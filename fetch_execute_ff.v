`timescale 1ns / 1ps

module fetch_execute_ff(
    input wire rst, clk,
    input wire trigger_set, trigger_rst,
    output wire q, notq
);

reg data_nxt;
reg data_q;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        data_q <= 1'b0;
    end else begin
        data_q <= data_nxt;
    end
end

always @(*) begin
    data_nxt = data_q;
    if (trigger_set) begin
        data_nxt = 1'b1;
    end
    if (trigger_rst) begin
        data_nxt = 1'b0;
    end
end

assign q = data_q;
assign notq = ~data_q;

endmodule
