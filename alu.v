`timescale 1ns / 1ps

module alu(
    input wire [1:0] func,
    input wire [7:0] p, q,
    output wire z,
    output wire [7:0] result
);

reg result_inner [7:0];
reg z_inner;

always @(*) begin
    result_inner = 8'd0;
    z_inner = 1'b0;

    case (func)
        2'b00: begin
            result_inner = 8'd0;
        end
        2'b01: begin
            result_inner = q + 1'b1;
        end
        2'b10: begin
            result_inner = q + p;
        end
        2'b11: begin
            result_inner = q - 1'b1;
        end
    endcase

    if (result_inner == 8'b0) begin
        z_inner = 1'b1;
    end
end

endmodule
