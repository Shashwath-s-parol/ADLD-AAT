module shift_register(
    input clk,
    input reset,
    input serial_in,
    output reg [3:0] q
);

    always @(posedge clk or posedge reset) begin
        if(reset)
            q <= 4'b0000;
        else
            q <= {q[2:0], serial_in};
    end

endmodule

module tb_shift_register;

    reg clk, reset, serial_in;
    wire [3:0] q;

    shift_register uut(clk, reset, serial_in, q);

    always #5 clk = ~clk;

    initial begin
        $monitor("Time=%0t Serial_In=%b Q=%b",
                 $time, serial_in, q);

        clk = 0;
        reset = 1;
        serial_in = 0;

        #10 reset = 0;

        serial_in = 1; #10;
        serial_in = 0; #10;
        serial_in = 1; #10;
        serial_in = 1; #10;
        serial_in = 0; #10;

        #30;

        $finish;
    end

endmodule