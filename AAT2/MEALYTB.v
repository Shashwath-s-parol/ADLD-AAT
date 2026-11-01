module MealyTB;
reg clk,reset,x;
wire y;

mealy101 J1(clk,reset,x,y);

always #5 clk = ~clk;

initial begin
clk = 0;
reset = 1;
x = 0;

#10 reset = 0;

#10 x = 1;
#10 x = 0;
#10 x = 1;

#10 x = 1;
#10 x = 0;
#10 x = 1;

#10 x = 0;
#10 x = 0;

#20 $finish;
end

initial begin
    $monitor ("Time = %0t | Reset = %0b |Input=%b|Output=%b ",$time,reset,x,y);
end
initial begin
$dumpfile("Mealy.vcd");
$dumpvars;
end
endmodule
