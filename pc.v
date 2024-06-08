`timescale 1ns / 1ps

module pc(
    input  wire rst, clk, clk_pc,
    input  wire [4:0] in;
    output wire [4:0] out;
);

wire address_nxt [4:0];
reg  address_q   [4:0];

always @(posedge clk or posedge rst) begin
    if (rst) begin
        address_q <= 5'd0;
    end else begin
        address_q <= address_nxt;
    end
end

always @(*) begin
    address_nxt = address_q;
    if (clk_pc) begin
        address_nxt = in;
    end
end

endmodule
