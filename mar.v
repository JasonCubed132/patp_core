`timescale 1ns / 1ps

module mar(
    input  wire rst, clk,
    input  wire we,
    input  wire [4:0] in,
    output wire [4:0] out
);

reg  [4:0] address_q;
wire [4:0] address_nxt;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        address_q <= 5'd0;
    end else begin
        address_q <= address_nxt;
    end
end

assign out = address_q;

always @(*) begin
    address_nxt = address_q;
    if (we) begin
        address_nxt = in;
    end
end

endmodule
