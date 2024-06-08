`timescale 1ns / 1ps

module cu(
    input wire rst, clk,
    input wire [4:0] opcode,
    input wire z,

    output wire e_ms, e_ir, e_pc, e_d0, e_alureg,
    output wire [1:0] func,
    output wire read, write,
    output wire we_mar, we_ir, we_pc, we_d0, we_alureg
);

endmodule
