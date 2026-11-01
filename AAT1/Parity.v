module parity(
    input [3:0] data,
    input parity_in,
    output parity_even,
    output parity_odd,
    output error
);

    assign parity_even = ^data;
    assign parity_odd = ~(^data);
    assign error = (^data) ^ parity_in;

endmodule

module tb_parity;

    reg [3:0] data;
    reg parity_in;

    wire parity_even, parity_odd, error;

    parity uut(data, parity_in, parity_even, parity_odd, error);

    initial begin
        $monitor("Time=%0t Data=%b Even=%b Odd=%b Parity_In=%b Error=%b",
                 $time, data, parity_even, parity_odd, parity_in, error);

        data = 4'b0000;
        parity_in = 0; #10;

        data = 4'b1010;
        parity_in = 0; #10;

        data = 4'b1111;
        parity_in = 0; #10;

        data = 4'b1010;
        parity_in = 1; #10;

        $finish;
    end

endmodule