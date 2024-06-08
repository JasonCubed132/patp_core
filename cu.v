`timescale 1ns / 1ps

module cu(
    input wire rst, clk, clk_cu,
    input wire [4:0] opcode,
    input wire z,

    output wire e_ms, e_ir, e_pc, e_d0, e_alureg,
    output wire [1:0] func,
    output wire read, write,
    output wire clk_mar, clk_ir, clk_pc, clk_d0, clk_alureg
);

endmodule
