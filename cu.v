`timescale 1ns / 1ps

module cu(
    input wire rst, clk,
    input wire [2:0] opcode,
    input wire z,

    output wire oe_ms, oe_ir, oe_pc, oe_d0, oe_alureg,
    output wire [1:0] func,
    output wire read, write,
    output wire we_mar, we_ir, we_pc, we_d0, we_alureg
);

wire dec_enable;
wire clear, inc1, add, dec1, jump, buz, load, store;

instruction_decoder i (
    .opcode(opcode),
    .enable(dec_enable),
    .clear(clear), .inc1(inc1), .add(add), .dec1(dec1),
    .jump(jump), .buz(buz), .load(load), .store(store)
);

wire fetch_ff, execute_ff;
wire fetch;

fetch_execute_ff f (
    .rst(rst), .clk(clk),
    .trigger_set(execute_ff),
    .trigger_rst(fetch_ff),
    .q(dec_enable),
    .notq(fetch)
);

wire sequencer_rst;
wire t1, t2, t3, t4, t5;

sequencer s (
    .rst(sequencer_rst), .clk(clk),
    .t1(t1), .t2(t2), .t3(t3), .t4(t4), .t5(t5)
);

assign sequencer_rst = fetch_ff | execute_ff;

control_signal_generator c (
    .fetch(fetch), .clear(clear), .inc1(inc1), .add(add),
    .dec1(dec1), .jmp(jump), .buz(buz), .load(load), .store(store),
    .t1(t1), .t2(t2), .t3(t3), .t4(t4), .t5(t5),
    .z(z),
    .oe_ms(oe_ms), .oe_ir(oe_ir), .oe_pc(oe_pc), .oe_d0(oe_d0), .oe_alureg(oe_alureg),
    .func(func),
    .read(read), .write(write),
    .we_mar(we_mar), .we_ir(we_ir), .we_pc(we_pc), .we_d0(we_d0), .we_alureg(we_alureg),
    .start_execute(execute_ff), .start_fetch(fetch_ff)
);

endmodule
