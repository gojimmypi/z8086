// C firmware for z8086_soc_hdmi
//
// All segments are 0xF000
//
// This requires the dev86 toolchain: https://github.com/lkundrak/dev86
// On my Mac, I built it after applying the patch in tools/dev86.mac.patch
//
// December 2025
#include "soc_hdmi.h"

int str_eq();
void con_puts();
void scroll_up();
void demo_text();
void handle_command();
void print_help();
int led_get();
void led_set();
void clear_screen();
void handle_backspace();
void snake_game();
int rand16();
int rand_range();

void main() {
    int i;
    char c;
    int cmd_len;
    char cmd_buf[32];
    int blink_enabled;

    blink_enabled = 0;

    for (i = 0; i < 80; i++)
        con_putc(i, 29, ' ', 0x0F);

    video_set_cursor_scan(18, 23);
    video_set_blink(blink_enabled);

    print("Welcome to z8086 SoC - HDMI console\n> ");
    uart_print("Welcome to z8086 SoC - serial console\n> ");

    /* Simple echo loop - show both TX and RX on screen */
    cmd_len = 0;
    while (1) {
        if (uart_rx_ready()) {
            c = uart_getchar();
            if (c == '\r') continue;

            if (c == 8 || c == 127) {
                if (cmd_len > 0) {
                    cmd_len--;
                    handle_backspace();
                }
                continue;
            }

            if (c == '\n') {
                putchar(c);
                uart_putchar(c);

                cmd_buf[cmd_len] = 0;
                handle_command(cmd_buf, &blink_enabled);
                cmd_len = 0;

                uart_print("> ");
                print("> ");
            } else {
                if (cmd_len < 31) {
                    cmd_buf[cmd_len++] = c;
                }
                putchar(c);
                uart_putchar(c);
            }
        }
    }
}

int cursor_x = 0;
int cursor_y = 3;
int seed = 1;

void con_putc(x, y, c, color) 
    int x;
    int y;
    int c;
    int color;
{
#asm
    push  bp
    mov   bp,sp
    push  ds
    mov   bx,[bp+6]  ! y
    mov   ax,bx
    mov   cl,#4
    shl   bx,cl      ! *16
    mov   cl,#6
    shl   ax,cl      ! *64
    add   bx,ax      ! *80
    add   bx,[bp+4]  ! bx = y * 80 + x
    shl   bx,#1      ! bx *= 2
    mov   dl,[bp+8]  ! c
    mov   dh,[bp+10] ! color
    mov   ax,#$B800  ! VGA text segment
    mov   ds,ax
    mov   [bx],dx
    pop   ds
    pop   bp
#endasm
}

void putchar(c) 
    int c;
{
    con_putc(cursor_x, cursor_y, c, 0x0F);
    cursor_x++;
    if (cursor_x >= 80 || c == '\n') {
        cursor_x = 0;
        cursor_y++;
    }
    if (cursor_y >= 30) {
        scroll_up();
        cursor_y = 29;
    }
    video_set_cursor(cursor_x, cursor_y);
}

void handle_backspace() {
    if (cursor_x == 0) {
        return;
    }
    cursor_x--;
    con_putc(cursor_x, cursor_y, ' ', 0x0F);
    video_set_cursor(cursor_x, cursor_y);
    uart_putchar('\b');
    uart_putchar(' ');
    uart_putchar('\b');
}

void print(str)
    char *str;
{
    while (*str) {
        putchar(*str);
        str++;
    }
}

/* ========== Command Helpers ========== */

int str_eq(a, b)
    char *a;
    char *b;
{
    while (*a && *b) {
        if (*a != *b) return 0;
        a++;
        b++;
    }
    return (*a == 0 && *b == 0);
}

void con_puts(x, y, str, color)
    int x;
    int y;
    char *str;
    int color;
{
    while (*str) {
        con_putc(x, y, *str, color);
        x++;
        str++;
    }
}

void scroll_up() {
#asm
    push  ds
    push  es
    mov   ax,#$B800
    mov   ds,ax
    mov   es,ax
    mov   si,#160        ! 80 cols * 2 bytes, row 1
    xor   di,di
    mov   cx,#2320       ! 80 cols * 29 rows
    cld                  ! clear direction flag
    db    0xF3           ! rep movsw
      movsw
    mov   di,#4640       ! 80 cols * 29 rows * 2 bytes
    mov   ax,#$0F20      ! space + attr
    mov   cx,#80
    db    0xF3           ! rep stosw
      stosw
    pop   es
    pop   ds
#endasm
}

void demo_text() {
    int i;
    int row;
    int col;
    int start_row;
    char *names[16];
    int needed_rows;
    int scrolls;
    int scroll_count;

    names[0]  = "BLK";
    names[1]  = "BLU";
    names[2]  = "GRN";
    names[3]  = "CYN";
    names[4]  = "RED";
    names[5]  = "MAG";
    names[6]  = "BRN";
    names[7]  = "LGRY";
    names[8]  = "DGRY";
    names[9]  = "LBLU";
    names[10] = "LGRN";
    names[11] = "LCYN";
    names[12] = "LRED";
    names[13] = "LMAG";
    names[14] = "YEL";
    names[15] = "WHT";

    needed_rows = 20;
    start_row = cursor_y + 1;
    if (start_row + needed_rows >= 30) {
        scrolls = (start_row + needed_rows) - 30;
        scroll_count = scrolls;
        while (scroll_count > 0) {
            scroll_up();
            scroll_count--;
        }
        if (cursor_y >= scrolls) {
            cursor_y -= scrolls;
        } else {
            cursor_y = 0;
        }
        video_set_cursor(cursor_x, cursor_y);
        start_row = cursor_y + 1;
    }

    row = start_row;
    con_puts(0, row, "TEXT DEMO", 0x1F);
    row++;
    con_puts(0, row, "FG COLORS (BG=0)", 0x0F);
    row++;

    for (i = 0; i < 16; i++) {
        col = (i & 3) * 20;
        row = start_row + 2 + (i >> 2) * 2;
        con_puts(col, row, names[i], 0x0F);
        con_puts(col + 6, row, "FG=", 0x07);
        con_putc(col + 9, row, '0' + (i >> 1), 0x07);
        con_putc(col + 10, row, (i & 1) ? '1' : '0', 0x07);
        con_puts(col, row + 1, " SAMPLE ", i);
    }

    row = start_row + 10;
    con_puts(0, row, "BG COLORS (FG=F)", 0x0F);
    row++;

    for (i = 0; i < 16; i++) {
        col = (i & 3) * 20;
        row = start_row + 12 + (i >> 2) * 2;
        con_puts(col, row, names[i], 0x0F);
        con_puts(col + 6, row, "BG=", 0x07);
        con_putc(col + 9, row, '0' + (i >> 1), 0x07);
        con_putc(col + 10, row, (i & 1) ? '1' : '0', 0x07);
        con_puts(col, row + 1, " SAMPLE ", (i << 4) | 0x0F);
    }

    cursor_x = 0;
    cursor_y = start_row + needed_rows;
    if (cursor_y >= 30) {
        scroll_up();
        cursor_y = 29;
    }
    video_set_cursor(cursor_x, cursor_y);
}

void handle_command(cmd, blink_enabled)
    char *cmd;
    int *blink_enabled;
{
    if (cmd[0] == 0) return;

    if (str_eq(cmd, "help")) {
        print_help();
        return;
    }

    if (str_eq(cmd, "text")) {
        demo_text();
        uart_print("Text demo updated\n");
        print("Text demo updated\n");
        return;
    }

    if (str_eq(cmd, "clear")) {
        clear_screen();
        uart_print("Screen cleared\n");
        print("Screen cleared\n");
        return;
    }

    if (str_eq(cmd, "snake")) {
        snake_game();
        uart_print("Snake done\n");
        print("Snake done\n");
        return;
    }

    if (str_eq(cmd, "blink on")) {
        *blink_enabled = 1;
    } else if (str_eq(cmd, "blink off")) {
        *blink_enabled = 0;
    } else if (str_eq(cmd, "blink")) {
        *blink_enabled = !(*blink_enabled);
    } else if (str_eq(cmd, "led on")) {
        led_set(0x7F);
        uart_print("LEDs on\n");
        print("LEDs on\n");
        return;
    } else if (str_eq(cmd, "led off")) {
        led_set(0x00);
        uart_print("LEDs off\n");
        print("LEDs off\n");
        return;
    } else if (str_eq(cmd, "led toggle")) {
        led_set(led_get() ^ 0x7F);
        uart_print("LEDs toggled\n");
        print("LEDs toggled\n");
        return;
    } else if (str_eq(cmd, "led 0")) {
        led_set(led_get() ^ 0x01);
        uart_print("LED0 toggle\n");
        print("LED0 toggle\n");
        return;
    } else if (str_eq(cmd, "led 1")) {
        led_set(led_get() ^ 0x02);
        uart_print("LED1 toggle\n");
        print("LED1 toggle\n");
        return;
    } else if (str_eq(cmd, "led 2")) {
        led_set(led_get() ^ 0x04);
        uart_print("LED2 toggle\n");
        print("LED2 toggle\n");
        return;
    } else if (str_eq(cmd, "led 3")) {
        led_set(led_get() ^ 0x08);
        uart_print("LED3 toggle\n");
        print("LED3 toggle\n");
        return;
    } else if (str_eq(cmd, "led 4")) {
        led_set(led_get() ^ 0x10);
        uart_print("LED4 toggle\n");
        print("LED4 toggle\n");
        return;
    } else if (str_eq(cmd, "led 5")) {
        led_set(led_get() ^ 0x20);
        uart_print("LED5 toggle\n");
        print("LED5 toggle\n");
        return;
    } else if (str_eq(cmd, "led 6")) {
        led_set(led_get() ^ 0x40);
        uart_print("LED6 toggle\n");
        print("LED6 toggle\n");
        return;
    } else {
        uart_print("Unknown command: ");
        uart_print(cmd);
        uart_print("\n");
        print("Unknown command: ");
        print(cmd);
        print("\n");
        return;
    }

    video_set_blink(*blink_enabled);
    if (*blink_enabled) {
        uart_print("Blink on\n");
        print("Blink on\n");
    } else {
        uart_print("Blink off\n");
        print("Blink off\n");
    }
}

void print_help() {
    uart_print("Commands:\n");
    uart_print("  help         - show this help\n");
    uart_print("  text         - color demo\n");
    uart_print("  clear        - clear screen\n");
    uart_print("  snake        - play snake (WASD, q)\n");
    uart_print("  blink        - toggle blink attribute\n");
    uart_print("  blink on/off - set blink\n");
    uart_print("  led on/off   - set LEDs\n");
    uart_print("  led toggle   - toggle all LEDs\n");
    uart_print("  led 0..6     - toggle LED\n");
    uart_print("\n");

    print("Commands:\n");
    print("  help         - show this help\n");
    print("  text         - color demo\n");
    print("  clear        - clear screen\n");
    print("  snake        - play snake (WASD, q)\n");
    print("  blink        - toggle blink attribute\n");
    print("  blink on/off - set blink\n");
    print("  led on/off   - set LEDs\n");
    print("  led toggle   - toggle all LEDs\n");
    print("  led 0..6     - toggle LED\n");
    print("\n");
}

/* ========== Video Control ==========
 *
 * Video controller I/O ports (VGA-style, 0x10-0x1f range):
 * 0x10: cursor column
 * 0x11: cursor row
 * 0x12: cursor scanline start
 * 0x13: cursor scanline end
 * 0x14: blink enable
 */

void video_set_cursor(col, row)
    int col;
    int row;
{
#asm
    push  bp
    mov   bp,sp
    mov   dx,#0x10
    mov   al,[bp+4]
    out   dx,al
    mov   dx,#0x11
    mov   al,[bp+6]
    out   dx,al
    pop   bp
#endasm
}

void video_set_cursor_scan(start, end)
    int start;
    int end;
{
#asm
    push  bp
    mov   bp,sp
    mov   al,[bp+4]
    and   al,#0x1F
    mov   dx,#0x12
    out   dx,al
    mov   al,[bp+6]
    and   al,#0x1F
    mov   dx,#0x13
    out   dx,al
    pop   bp
#endasm
}

void video_set_blink(enable)
    int enable;
{
#asm
    push  bp
    mov   bp,sp
    mov   dx,#0x14
    mov   al,[bp+4]
    out   dx,al
    pop   bp
#endasm
}

/* ========== LED Control ==========
 *
 * Port 0x05, low 7 bits
 */

int led_get() {
#asm
    mov   dx,#5
    in    al,dx
    and   al,#0x7F
    xor   ah,ah
#endasm
}

void led_set(value)
    int value;
{
#asm
    push  bp
    mov   bp,sp
    mov   dx,#5
    mov   al,[bp+4]
    out   dx,al
    pop   bp
#endasm
}

void clear_screen() {
    int x;
    int y;
    for (y = 0; y < 30; y++) {
        for (x = 0; x < 80; x++) {
            con_putc(x, y, ' ', 0x0F);
        }
    }
    cursor_x = 0;
    cursor_y = 0;
    video_set_cursor(cursor_x, cursor_y);
}

void snake_game() {
    int width;
    int height;
    int ox;
    int oy;
    int len;
    int dir;
    int next_x;
    int next_y;
    int food_x;
    int food_y;
    int i;
    int hit;
    int delay;
    int score_tens;
    int score_ones;
    char c;
    static unsigned seed = 1;
    int sx[128];
    int sy[128];

    width = 40;
    height = 20;
    ox = 20;
    oy = 4;

    clear_screen();
    con_puts(0, 0, "SNAKE - WASD to move, Q to quit", 0x0F);
    con_puts(0, 1, "Score: 0", 0x0F);

    video_set_cursor(0, 31);

    for (i = 0; i <= width + 1; i++) {
        con_putc(ox - 1 + i, oy - 1, '#', 0x0A);
        con_putc(ox - 1 + i, oy + height, '#', 0x0A);
    }
    for (i = 0; i < height; i++) {
        con_putc(ox - 1, oy + i, '#', 0x0A);
        con_putc(ox + width, oy + i, '#', 0x0A);
    }

    len = 5;
    dir = 1;  /* 0=up,1=right,2=down,3=left */
    score_tens = 0;
    score_ones = 0;
    food_x = -1;
    food_y = 0;

    for (i = 0; i < len; i++) {
        sx[i] = width / 2 - i;
        sy[i] = height / 2;
    }

    for (i = 0; i < len; i++) {
        con_putc(ox + sx[i], oy + sy[i], i == 0 ? 'O' : 'o', 0x0A);
    }

    con_puts(0, 2, "Press any key to start", 0x0F);
    while (1) {
        if (uart_rx_ready()) {
            c = uart_getchar();
            break;
        }
    }
    con_puts(0, 2, "                      ", 0x0F);

    while (1) {
        if (uart_rx_ready()) {
            c = uart_getchar();
            if (c == 'q' || c == 'Q') break;
            if ((c == 'w' || c == 'W') && dir != 2) dir = 0;
            else if ((c == 'd' || c == 'D') && dir != 3) dir = 1;
            else if ((c == 's' || c == 'S') && dir != 0) dir = 2;
            else if ((c == 'a' || c == 'A') && dir != 1) dir = 3;
        }

        if (food_x < 0) {
            do {
                food_x = rand_range(width);
                food_y = rand_range(height);
                hit = 0;
                for (i = 0; i < len; i++) {
                    if (sx[i] == food_x && sy[i] == food_y) hit = 1;
                }
            } while (hit);
            con_putc(ox + food_x, oy + food_y, '*', 0x0E);
        }

        next_x = sx[0];
        next_y = sy[0];
        if (dir == 0) next_y--;
        else if (dir == 1) next_x++;
        else if (dir == 2) next_y++;
        else next_x--;

        if (next_x < 0 || next_x >= width || next_y < 0 || next_y >= height) {
            break;
        }
        hit = 0;
        for (i = 0; i < len; i++) {
            if (sx[i] == next_x && sy[i] == next_y) hit = 1;
        }
        if (hit) break;

        for (i = len; i > 0; i--) {
            sx[i] = sx[i - 1];
            sy[i] = sy[i - 1];
        }
        sx[0] = next_x;
        sy[0] = next_y;

        con_putc(ox + sx[1], oy + sy[1], 'o', 0x0A);
        con_putc(ox + sx[0], oy + sy[0], 'O', 0x0A);

        if (sx[0] == food_x && sy[0] == food_y) {
            len++;
            score_ones++;
            if (score_ones == 10) {
                score_ones = 0;
                score_tens++;
            }
            if (len > 120) len = 120;
            food_x = -1;
            con_putc(7, 1, '0' + score_tens, 0x0F);
            con_putc(8, 1, '0' + score_ones, 0x0F);
        } else {
            con_putc(ox + sx[len], oy + sy[len], ' ', 0x0F);
        }

        for (delay = 0; delay < 20000; delay++);
        for (delay = 0; delay < 20000; delay++);
        for (delay = 0; delay < 20000; delay++);
        for (delay = 0; delay < 20000; delay++);
        for (delay = 0; delay < 20000; delay++);
    }

    con_puts(0, 2, "Game over. Press ENTER to continue.", 0x0F);
    while (1) {
        if (uart_rx_ready()) {
            c = uart_getchar();
            if (c == '\n') break;
        }
    }
    clear_screen();
}

int rand16() {
    if (seed & 1) {
        seed = (seed >> 1) ^ 0xB400;
    } else {
        seed = (seed >> 1);
    }
    return seed & 0x7FFF;  // Mask to ensure positive value (0-32767)
}

int rand_range(limit)
    int limit;
{
    int v;
    v = rand16();
    if (v < 0) v = -v;  // Handle negative values
    while (v >= limit) v -= limit;
    return v;
}

/* ========== UART Functions ========== */

/* Check if RX data available */
int uart_rx_ready() {
#asm
    mov   dx,#7          ! PORT_UART_STATUS = 8, but we read port 8
    inc   dx
    in    al,dx
    and   al,#1          ! Bit 0: Data Ready
    xor   ah,ah
#endasm
}

/* Check if TX ready */
int uart_tx_ready() {
#asm
    mov   dx,#8          ! PORT_UART_STATUS
    in    al,dx
    mov   cl,#5
    shr   al,cl          ! Shift bit 5 to bit 0
    and   al,#1          ! Bit 5: THR Empty
    xor   ah,ah
#endasm
}

/* Blocking read - wait for data and return it */
char uart_getchar() {
#asm
.uart_getchar_wait:
    mov   dx,#8          ! PORT_UART_STATUS
    in    al,dx
    test  al,#1          ! Bit 0: Data Ready
    jz    .uart_getchar_wait

    mov   dx,#7          ! PORT_UART_DATA
    in    al,dx          ! Read data
    xor   ah,ah
#endasm
}

/* Blocking write - wait for TX ready and send character */
void uart_putchar(c)
    int c;
{
#asm
    uart_putchar.c	set	2
.uart_putchar_wait:
    mov   dx,#8          ! PORT_UART_STATUS
    in    al,dx
    test  al,#0x20       ! Bit 5: THR Empty
    jz    .uart_putchar_wait

    mov   bx,sp
    mov   ax,[bx+2]      ! Get character parameter
    mov   dx,#7          ! PORT_UART_DATA
    out   dx,al          ! Write data
#endasm
}

/* Print string to UART */
void uart_print(str)
    char *str;
{
    while (*str) {
        uart_putchar(*str);
        str++;
    }
}

/* 
Entry point. Ideally this should become crt0.s. 
tools/build_hex.py generates the reset code to jump to `start`.
*/
#asm
start:
    cli
    mov     ax, #0xF000
    mov     ds, ax           ; DS = 0xF000
    mov     ss, ax           ; SS = 0xF000
    mov     sp, #0xFFF0      ; SP = 0xFFF0
    sti                    

.done:
    call    _main

hello_msg:
    .ASCII  "Hello from firmware.c!\0"

#endasm
