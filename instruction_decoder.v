`timescale 1ns / 1ps

module instruction_decoder(
    input wire [2:0] opcode,
    input wire enable,
    output reg clear, inc1, add, dec1, jump, buz, load, store
);

always @(*) begin
    clear = 1'b0;
    inc1 = 1'b0;
    add = 1'b0;
    dec1 = 1'b0;
    jump = 1'b0;
    buz = 1'b0;
    load = 1'b0;
    store = 1'b0;

    if (enable) begin
        case (opcode)
            3'b000: clear = 1'b1;
            3'b001: inc1 = 1'b1;
            3'b010: add = 1'b1;
            3'b011: dec1 = 1'b1;
            3'b100: jump = 1'b1;
            3'b101: buz = 1'b1;
            3'b110: load = 1'b1;
            3'b111: store = 1'b1;
        endcase
    end
end

endmodule