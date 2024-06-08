`timescale 1ns / 1ps

module ir(
    input  wire rst, clk,
    input  wire we,
    input  wire [7:0] in,
    output wire [4:0] out_operand,
    output wire [2:0] out_opcode
);

wire instruction_nxt [7:0];
reg  instruction_q   [7:0];

always @(posedge clk or posedge rst) begin
    if (rst) begin
        instruction_q <= 8'd0;
    end else begin
        instruction_q <= instruction_nxt;
    end
end

always @(*) begin
    instruction_nxt = instruction_q;
    if (we) begin
        instruction_nxt = in;
    end
end

assign {out_opcode, out_operand} = instruction_q;

endmodule
