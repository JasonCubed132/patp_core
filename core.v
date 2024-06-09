`timescale 1ns / 1ps

module core(
    input wire rst, clk
);

wire we_mar, we_ir, we_pc, we_d0, we_alureg;
wire oe_ms, oe_ir, oe_pc, oe_d0, oe_alureg;
wire read, write;
wire [1:0] func;
wire zero;
wire [2:0] opcode; 
wire [4:0] address;
wire [7:0] main_bus;

mar addr (
    .clk(clk), .rst(rst),
    .we(we_mar),
    .in(main_bus[4:0]),
    .out(address)
);

wire [7:0] ms_out;

main_store store (
    .clk(clk), .rst(rst),
    .read(read), .write(write),
    .address(address),
    .data_i(main_bus),
    .data_o(ms_out)
);

wire [4:0] ir_out;

ir inst (
    .clk(clk), .rst(rst),
    .we(we_ir),
    .in(main_bus),
    .out_opcode(opcode),
    .out_operand(ir_out)
);

wire [4:0] pc_out;

pc pc_addr (
    .clk(clk), .rst(rst),
    .we(we_pc),
    .in(main_bus[4:0]),
    .out(pc_out)
);

wire [7:0] d0_out;

d0 data (
    .clk(clk), .rst(rst),
    .we(we_d0),
    .in(main_bus),
    .out(d0_out)
);

wire [7:0] alu_out;

alu maths (
    .p(d0_out), .q(main_bus),
    .func(func),
    .zero(zero), .result(alu_out)
);

wire [7:0] alureg_out;

alureg alu_result (
    .clk(clk), .rst(rst),
    .we(we_alureg),
    .in(alu_out),
    .out(alureg_out)
);

cu control (
    .clk(clk), .rst(rst),
    .opcode(opcode),
    .zero(zero),
    .we_mar(we_mar),
    .we_ir(we_ir),
    .we_pc(we_pc),
    .we_d0(we_d0),
    .we_alureg(we_alureg),
    .oe_ms(oe_ms),
    .oe_ir(oe_ir),
    .oe_pc(oe_pc),
    .oe_d0(oe_d0),
    .oe_alureg(oe_alureg)
);

assign main_bus = {8{oe_ms}} & ms_out
                | {8{oe_ir}} & {3'b0, ir_out}
                | {8{oe_pc}} & {3'b0, pc_out}
                | {8{oe_d0}} & d0_out
                | {8{oe_alureg}} & alureg_out;

endmodule
