
extern int cursor_x, cursor_y;

/* print to console at (x, y) with color */
void con_putc(x, y, c, color);

/* print to console at current cursor position, and move cursor to next position */
void putchar(c);

void print(str);

/* Video control */
void video_set_cursor(col, row);
void video_set_cursor_scan(start, end);
void video_set_blink(enable);
int led_get();
void led_set(value);

/* UART functions */
int uart_rx_ready();        /* returns 1 if RX data available */
int uart_tx_ready();        /* returns 1 if TX ready */
char uart_getchar();        /* blocking read */
void uart_putchar(c);       /* blocking write */
void uart_print(str);       /* print string to UART */
