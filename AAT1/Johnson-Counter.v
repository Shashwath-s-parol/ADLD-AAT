module johnson_counter(
    input clk,
    input reset,
    output reg [3:0] q
);

    always @(posedge clk or posedge reset) begin
        if(reset)
            q <= 4'b0000;
        else
            q <= {q[2:0], ~q[3]};
    end

endmodule

module tb_johnson_counter;

    reg clk, reset;
    wire [3:0] q;

    johnson_counter uut(clk, reset, q);

    always #5 clk = ~clk;

    initial begin
        $monitor("Time=%0t Q=%b", $time, q);

        clk = 0;
        reset = 1;

        #10 reset = 0;

        #100;

        $finish;
    end

endmodule