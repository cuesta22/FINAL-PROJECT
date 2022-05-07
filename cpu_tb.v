module cpu_tb(clk, rst, fin_out);
output reg clk, rst;
output [31:0] fin_out;
cpu processor(clk, rst, fin_out);
initial begin 
clk = 0;
forever #10 clk=~clk; 
end
initial begin 
rst = 1;
#10 rst = 0;
end
endmodule 