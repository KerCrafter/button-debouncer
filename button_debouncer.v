module button_debouncer #(
    parameter DEBOUNCE_CLK_CNT = 65536
)(
    input  wire clk,
    input  wire reset,
    input  wire btn_in,
    output reg  btn_debounced = 1'b0
);

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
                if (cnt < DEBOUNCE_CLK_CNT - 1)
                    cnt <= cnt + 1;
                else
                    btn_debounced <= 1'b1;
            end
        end
    end

endmodule
