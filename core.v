`timescale 1ns / 1ps

module core(
    input wire rst, clk
);

wire we_mar, we_ir, we_pc, we_d0, we_alureg;
wire e_ms, e_ir, e_pc, e_d0, e_alureg;
wire read, write;
wire [1:0] func;
wire z;
wire [2:0] opcode; 
wire [4:0] address;
wire [7:0] main_bus;

mar addr (
    .clk(clk), .rst(rst),
    .we(we_mar),
    .in(main_bus),
    .out(address),
);

wire [7:0] ms_out;

ms store (
    .clk(clk), .rst(rst),
    .read(read), .write(write),
    .in(main_bus),
    .out(ms_out)
);

wire [7:0] ir_out;

ir inst (
    .clk(clk), .rst(rst),
    .we(we_ir),
    .in(main_bus),
    .out(ir_out)
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
    .z(z), .result(alu_out)
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
    .clk_cu(clk),
    .opcode(opcode),
    .z(z),
    .we_mar(we_mar),
    .we_ir(we_ir),
    .we_pc(we_pc),
    .we_d0(we_d0),
    .we_alureg(we_alureg),
    .e_ms(e_ms),
    .e_ir(e_ir),
    .e_pc(e_pc),
    .e_d0(e_d0),
    .e_alureg(e_alureg)
);

assign main_bus = {8{e_ms}} & ms_out
                | {8{e_ir}} & ir_out
                | {8{e_pc}} & pc_out
                | {8{e_d0}} & d0_out
                | {8{e_alureg}} & alureg_out;

endmodule
