`timescale 1ns / 1ps

module main_store(
    input  wire rst, clk
    input  wire read, write,
    input  wire [4:0] address,
    input  wire [7:0] data_i,
    output wire [7:0] data_o
);

reg [31:0]  data_q [7:0];
wire [31:0] data_nxt [7:0];

integer i;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        for (i = 0; i < 32; i = i + 1) begin
            data_q[i] <= 8'd0;
        end
    end else begin
        for (i = 0; i < 32; i = i + 1) begin
            data_q[i] <= data_nxt[i];
        end
    end
end

always @(*) begin
    for (i = 0; i < 32; i = i + 1) begin
        data_nxt[i] <= data_q[i];
    end

    if (write) begin
        data_nxt[address] <= data_i;
    end
end

reg data_output [7:0];
assign data_o = data_output;

always @(*) begin
    data_output <= data_q[address];
end

endmodule
