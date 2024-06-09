`timescale 1ns / 1ps

module core_tb();

reg rst, clk;

core c (
    .rst(rst), .clk(clk)
);

always #5 clk = ~clk;

initial begin
    rst = 1'b1;
    #10 rst = 1'b0;
    #10000 rst = 1'b0;
end

endmodule
