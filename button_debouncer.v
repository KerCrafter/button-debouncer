module button_debouncer #(
    parameter DEBOUNCE_CLK_CNT = 65536
)(
    input  wire clk,
    input  wire reset,
    input  wire btn_in,
    output reg  btn_debounced = 1'b0
);
    localparam CNT_WIDTH = (DEBOUNCE_CLK_CNT > 1) ? $clog2(DEBOUNCE_CLK_CNT) : 1;

    localparam [CNT_WIDTH-1:0] DEBOUNCE_CNT_MAX = DEBOUNCE_CLK_CNT[CNT_WIDTH-1:0];
    localparam [CNT_WIDTH-1:0] DEBOUNCE_LIMIT   = DEBOUNCE_CNT_MAX - 1'b1;

    reg [$clog2(DEBOUNCE_CLK_CNT)-1:0] cnt = 0;

    always @(posedge clk) begin
        if (reset) begin
            cnt <= 0;
            btn_debounced <= 1'b0;
        end else begin
            if (btn_in == 1'b0) begin
                cnt <= 0;
                btn_debounced <= 1'b0;
            end else begin
                if (cnt < DEBOUNCE_LIMIT)
                    cnt <= cnt + 1'd1;
                else
                    btn_debounced <= 1'b1;
            end
        end
    end

endmodule
