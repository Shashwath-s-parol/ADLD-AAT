module random_generator(
    input clk,
    input reset,
    output reg [3:0] q
);

    wire feedback;

    assign feedback = q[3] ^ q[2];

    always @(posedge clk or posedge reset) begin
        if(reset)
            q <= 4'b0001;
        else
            q <= {q[2:0], feedback};
    end

endmodule

module tb_random_generator;

    reg clk, reset;
    wire [3:0] q;

    random_generator uut(clk, reset, q);

    always #5 clk = ~clk;

    initial begin
        $monitor("Time=%0t Random_Output=%b", $time, q);

        clk = 0;
        reset = 1;

        #10 reset = 0;

        #200;

        $finish;
    end

endmodule