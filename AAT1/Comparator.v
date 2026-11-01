module comparator(
    input [3:0] a, b,
    output greater,
    output equal,
    output less
);

    assign greater = (a > b);
    assign equal = (a == b);
    assign less = (a < b);

endmodule

module tb_comparator;

    reg [3:0] a, b;
    wire greater, equal, less;

    comparator uut(a, b, greater, equal, less);

    initial begin
        $monitor("Time=%0t A=%d B=%d Greater=%b Equal=%b Less=%b",
                 $time, a, b, greater, equal, less);

        a = 9; b = 5; #10;
        a = 3; b = 8; #10;
        a = 7; b = 7; #10;
        a = 0; b = 15; #10;

        $finish;
    end

endmodule