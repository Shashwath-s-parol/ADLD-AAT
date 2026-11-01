module timer(
    input clk,
    input reset,
    input start,
    input [3:0] load_value,
    output reg [3:0] count,
    output reg done
);

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            count <= 0;
            done <= 0;
        end

        else if(start) begin
            count <= load_value;
            done <= 0;
        end

        else if(count > 0) begin
            count <= count - 1'b1;

            if(count == 1)
                done <= 1;
        end
    end

endmodule

module tb_timer;

    reg clk, reset, start;
    reg [3:0] load_value;

    wire [3:0] count;
    wire done;

    timer uut(clk, reset, start, load_value, count, done);

    always #5 clk = ~clk;

    initial begin
        $monitor("Time=%0t Count=%d Done=%b",
                 $time, count, done);

        clk = 0;
        reset = 1;
        start = 0;
        load_value = 5;

        #10 reset = 0;

        start = 1; #10;
        start = 0;

        #100;

        $finish;
    end

endmodule