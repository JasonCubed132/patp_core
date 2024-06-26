`timescale 1ns / 1ps

module control_signal_generator(
    input wire fetch, clear, inc1, add, dec1, jmp, buz, load, store,
    input wire t1, t2, t3, t4, t5,
    input wire zero,
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

    if (fetch) begin
        if (t1) begin
            oe_pc = 1'b1;
            we_mar = 1'b1;
        end
        if (t2) begin
            read = 1'b1;
            oe_ms = 1'b1;
            we_ir = 1'b1;
        end
        if (t3) begin
            oe_pc = 1'b1;
            func = 2'b01;
            we_alureg = 1'b1;
        end
        if (t4) begin
            oe_alureg = 1'b1;
            we_pc = 1'b1;
        end
        if (t5) begin
            start_execute = 1'b1;
        end
    end

    if (clear) begin
        if (t1) begin
            func = 2'b0;
            we_alureg = 1'b1;
        end
        if (t2) begin
            oe_alureg = 1'b1;
            we_d0 = 1'b1;
        end
        if (t3) begin
            start_fetch = 1'b1;
        end
    end

    if (inc1) begin
        if (t1) begin
            oe_d0 = 1'b1;
            func = 2'b01;
            we_alureg = 1'b1;
        end
        if (t2) begin
            oe_alureg = 1'b1;
            we_d0 = 1'b1;
        end
        if (t3) begin
            start_fetch = 1'b1;
        end
    end

    if (add) begin
        if (t1) begin
            oe_ir = 1'b1;
            func = 2'b10;
            we_alureg = 1'b1;
        end
        if (t2) begin
            oe_alureg = 1'b1;
            we_d0 = 1'b1;
        end
        if (t3) begin
            start_fetch = 1'b1;
        end
    end

    if (dec1) begin
        if (t1) begin
            oe_d0 = 1'b1;
            func = 2'b11;
            we_alureg = 1'b1;
        end
        if (t2) begin
            oe_alureg = 1'b1;
            we_d0 = 1'b1;
        end
        if (t3) begin
            start_fetch = 1'b1;
        end
    end

    if (jmp) begin
        if (t1) begin
            oe_ir = 1'b1;
            we_pc = 1'b1;
        end
        if (t2) begin
            start_fetch = 1'b1;
        end
    end

    if (buz) begin
        if (t1 & (zero != 1'b0)) begin
            oe_ir = 1'b1;
            we_pc = 1'b1;
        end
        if (t2) begin
            start_fetch = 1'b1;
        end
    end

    if (load) begin
        if (t1) begin
            oe_ir = 1'b1;
            we_mar = 1'b1;
        end
        if (t2) begin
            read = 1'b1;
            oe_ms = 1'b1;
            we_d0 = 1'b1;
        end
        if (t3) begin
            start_fetch = 1'b1;
        end
    end

    if (store) begin
        if (t1) begin
            oe_ir = 1'b1;
            we_mar = 1'b1;
        end
        if (t2) begin
            oe_d0 = 1'b1;
            write = 1'b1;
        end
        if (t3) begin
            start_fetch = 1'b1;
        end
    end
end

endmodule
