
module tb_parity;

reg [3:0] data;
wire even_parity, odd_parity;

parity_generator uut (
    .data(data),
    .even_parity(even_parity),
    .odd_parity(odd_parity)
);

initial begin
    $monitor("Data=%b Even=%b Odd=%b",
              data, even_parity, odd_parity);

    data = 4'b0000;
    #10 data = 4'b0001;
    #10 data = 4'b0011;
    #10 data = 4'b1010;
    #10 data = 4'b1111;
    #10 $finish;
end
initial begin
$dumpfile("Parity.vcd");
$dumpvars;
end
endmodule
