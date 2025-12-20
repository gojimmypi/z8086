// Simple polling-mode UART
// Fixed 115200 baud, 8N1, no FIFO

module uart_simple (
    input clk,              // 50MHz
    input reset_n,

    // CPU interface - TX
    input [7:0] tx_data,
    input tx_wr,            // Write strobe
    output tx_busy,         // 1 when transmitting

    // CPU interface - RX
    output reg [7:0] rx_data,
    output reg rx_valid,    // 1 when data available
    input rx_ack,           // Read acknowledge

    // Physical pins
    output reg uart_tx,
    input uart_rx
);

// Baud rate generation
// 115200 baud with 50MHz clock
// Clocks per bit = 50M / 115200 = 434
// Use 16x oversampling: 434 / 16 = 27.13 ≈ 27
// Actual baud = 50M / (27 * 16) = 115740 (0.47% error, acceptable)
localparam BAUD_DIV = 27;
localparam CLKS_PER_BIT = BAUD_DIV * 16;  // 432 clocks per bit

// ========== TX State Machine ==========
reg [3:0] tx_state;     // 0=idle, 1=start, 2-9=data, 10=stop
reg [7:0] tx_shift;
reg [8:0] tx_counter;   // Count clocks per bit

assign tx_busy = (tx_state != 0);

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        uart_tx <= 1'b1;
        tx_state <= 0;
        tx_shift <= 8'h00;
        tx_counter <= 0;
    end else begin
        case (tx_state)
        4'd0: begin  // Idle
            uart_tx <= 1'b1;
            if (tx_wr) begin
`ifdef VERILATOR
                $display("[UART TX] Sending 0x%02X '%c'", tx_data,
                         (tx_data >= 32 && tx_data < 127) ? tx_data : 8'h2E);
`endif
                tx_shift <= tx_data;
                tx_state <= 1;
                tx_counter <= 0;
            end
        end

        4'd1: begin  // Start bit
            uart_tx <= 1'b0;
            if (tx_counter == CLKS_PER_BIT - 1) begin
                tx_counter <= 0;
                tx_state <= 2;
            end else begin
                tx_counter <= tx_counter + 1;
            end
        end

        4'd2, 4'd3, 4'd4, 4'd5, 4'd6, 4'd7, 4'd8, 4'd9: begin  // Data bits
            uart_tx <= tx_shift[0];
            if (tx_counter == CLKS_PER_BIT - 1) begin
                tx_counter <= 0;
                tx_shift <= {1'b0, tx_shift[7:1]};  // Shift right
                tx_state <= tx_state + 1;
            end else begin
                tx_counter <= tx_counter + 1;
            end
        end

        4'd10: begin  // Stop bit
            uart_tx <= 1'b1;
            if (tx_counter == CLKS_PER_BIT - 1) begin
                tx_counter <= 0;
                tx_state <= 0;
            end else begin
                tx_counter <= tx_counter + 1;
            end
        end

        default: tx_state <= 0;
        endcase
    end
end

// ========== RX State Machine ==========
// 16x oversampling for better edge detection
reg [3:0] rx_state;     // 0=idle, 1=start, 2-9=data, 10=stop, 11=align
reg [7:0] rx_shift;
reg [4:0] rx_sample_counter;  // Count to BAUD_DIV for 16x samples
reg [3:0] rx_bit_counter;     // Count to 16 for one bit period

// Synchronize uart_rx to clock domain
reg uart_rx_sync1, uart_rx_sync2;
always @(posedge clk) begin
    uart_rx_sync1 <= uart_rx;
    uart_rx_sync2 <= uart_rx_sync1;
end

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        rx_state <= 0;
        rx_shift <= 8'h00;
        rx_data <= 8'h00;
        rx_valid <= 1'b0;
        rx_sample_counter <= 0;
        rx_bit_counter <= 0;
    end else begin
        // Clear rx_valid when acknowledged
        if (rx_ack) begin
            rx_valid <= 1'b0;
        end

        case (rx_state)
        4'd0: begin  // Idle, wait for start bit
            rx_bit_counter <= 0;
            rx_sample_counter <= 0;
            if (!uart_rx_sync2) begin  // Start bit detected (falling edge)
                rx_state <= 1;
            end
        end

        4'd1: begin  // Start bit, wait for middle
            if (rx_sample_counter == BAUD_DIV - 1) begin
                rx_sample_counter <= 0;
                rx_bit_counter <= rx_bit_counter + 1;

                // Sample at middle of bit (count 8 of 16)
                if (rx_bit_counter == 7) begin
                    if (!uart_rx_sync2) begin  // Validate start bit
                        rx_state <= 4'd11;  // Wait remaining half-bit to align data sampling
                        rx_bit_counter <= 0;
                    end else begin
                        rx_state <= 0;  // False start
                    end
                end
            end else begin
                rx_sample_counter <= rx_sample_counter + 1;
            end
        end

        4'd11: begin  // Align to data bit boundary (wait remaining half-bit)
            if (rx_sample_counter == BAUD_DIV - 1) begin
                rx_sample_counter <= 0;
                rx_bit_counter <= rx_bit_counter + 1;

                // Wait 8 samples to reach next bit boundary
                if (rx_bit_counter == 7) begin
                    rx_state <= 2;
                    rx_bit_counter <= 0;
                end
            end else begin
                rx_sample_counter <= rx_sample_counter + 1;
            end
        end

        4'd2, 4'd3, 4'd4, 4'd5, 4'd6, 4'd7, 4'd8, 4'd9: begin  // Data bits
            if (rx_sample_counter == BAUD_DIV - 1) begin
                rx_sample_counter <= 0;
                rx_bit_counter <= rx_bit_counter + 1;

                // Sample at middle of bit (count 8 of 16)
                if (rx_bit_counter == 7) begin
                    rx_shift <= {uart_rx_sync2, rx_shift[7:1]};  // Shift right, LSB first
                end else if (rx_bit_counter == 15) begin
                    rx_state <= rx_state + 1;
                    rx_bit_counter <= 0;
                end
            end else begin
                rx_sample_counter <= rx_sample_counter + 1;
            end
        end

        4'd10: begin  // Stop bit
            if (rx_sample_counter == BAUD_DIV - 1) begin
                rx_sample_counter <= 0;
                rx_bit_counter <= rx_bit_counter + 1;

                // Sample at middle of bit
                if (rx_bit_counter == 7) begin
                    if (uart_rx_sync2) begin  // Valid stop bit
                        rx_data <= rx_shift;
                        rx_valid <= 1'b1;
                    end
                    // else: frame error, discard
                end else if (rx_bit_counter == 15) begin
                    rx_state <= 0;
                    rx_bit_counter <= 0;
                end
            end else begin
                rx_sample_counter <= rx_sample_counter + 1;
            end
        end

        default: rx_state <= 0;
        endcase
    end
end

endmodule
