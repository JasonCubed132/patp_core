`timescale 1ns / 1ps

module alu(
    input wire [1:0] func,
    input wire [7:0] p, q,
    output reg zero,
    output reg [7:0] result
);

always @(*) begin
    result = 8'd0;
    zero = 1'b0;

    case (func)
        2'b00: begin
            result = 8'd0;
        end
        2'b01: begin
            result = q + 1'b1;
        end
        2'b10: begin
            result = q + p;
        end
        2'b11: begin
            result = q - 1'b1;
        end
    endcase

    if (result == 8'b0) begin
        zero = 1'b1;
    end
end

endmodule
