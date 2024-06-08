`timescale 1ns / 1ps

module alureg(
    input  wire rst, clk,
    input  wire we,
    input  wire [7:0] in,
    output wire [7:0] out
);

wire data_nxt [7:0];
reg  data_q   [7:0];

assign out = data_q;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        data_q <= 8'd0;
    end else begin
        data_q <= data_nxt;
    end
end

always @(*) begin
    data_nxt = data_q; 
    if (we) begin
        data_nxt = in;
    end
end

endmodule
