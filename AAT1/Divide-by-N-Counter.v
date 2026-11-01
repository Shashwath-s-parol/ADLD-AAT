module divide_by_n(
    input clk,
    input reset,
    output reg clk_out
);

    parameter N = 10;

    integer count;

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            count <= 0;
            clk_out <= 0;
        end

        else begin
            if(count == (N/2)-1) begin
                count <= 0;
                clk_out <= ~clk_out;
            end

            else
                count <= count + 1;
        end
    end

endmodule

module tb_divide_by_n;

    reg clk, reset;
    wire clk_out;

    divide_by_n #(.N(10)) uut(clk, reset, clk_out);

    always #5 clk = ~clk;

    initial begin
        $monitor("Time=%0t Input_CLK=%b Output_CLK=%b",
                 $time, clk, clk_out);

        clk = 0;
        reset = 1;

        #10 reset = 0;

        #200;

        $finish;
    end

endmodule