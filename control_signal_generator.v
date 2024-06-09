`timescale 1ns / 1ps

module control_signal_generator(
    input wire fetch, clear, inc1, add, dec1, jmp, buz, load, store
    input wire t1, t2, t3, t4, t5,
    input wire z,
    output reg oe_ms, oe_ir, oe_pc, oe_d0, oe_alureg,
    output reg [1:0] func,
    output reg read, write,
    output reg we_mar, we_ir, we_pc, we_d0, we_alureg,
    output reg start_execute, start_fetch
);

always @(*) begin
    oe_ms = 1'b0; oe_ir = 1'b0; oe_pc = 1'b0; oe_d0 = 1'b0; oe_alureg = 1'b0;
    func = 2'b0;
    read = 1'b0; write = 1'b0;
    we_mar = 1'b0; we_ir = 1'b0; we_pc = 1'b0; we_d0 = 1'b0; we_alureg = 1'b0;
    start_execute = 1'b0; start_fetch = 1'b0;

end

endmodule
