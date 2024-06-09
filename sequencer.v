`timescale 1ns / 1ps

module sequencer(
    input wire clk, rst,
    output wire t1, t2, t3, t4, t5
);

reg [4:0] counter_nxt;
reg [4:0] counter_q;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        counter_q <= 1'b1;
    end else begin
        counter_q <= counter_nxt;
    end
end

always @(*) begin
    counter_nxt = {counter_q[3:0], counter_q[4]};
end

endmodule