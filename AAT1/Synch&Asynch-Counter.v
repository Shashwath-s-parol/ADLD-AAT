module sync_counter(
    input clk,
    input reset,
    output reg [3:0] q
);

    always @(posedge clk) begin
        if(reset)
            q <= 4'b0000;
        else
            q <= q + 1'b1;
    end

endmodule

module async_counter(
    input clk,
    input reset,
    output reg [3:0] q
);

    always @(posedge clk or posedge reset) begin
        if(reset)
            q[0] <= 0;
        else
            q[0] <= ~q[0];
    end

    always @(negedge q[0] or posedge reset) begin
        if(reset)
            q[1] <= 0;
        else
            q[1] <= ~q[1];
    end

    always @(negedge q[1] or posedge reset) begin
        if(reset)
            q[2] <= 0;
        else
            q[2] <= ~q[2];
    end

    always @(negedge q[2] or posedge reset) begin
        if(reset)
            q[3] <= 0;
        else
            q[3] <= ~q[3];
    end

endmodule

module tb_counters;

    reg clk, reset;

    wire [3:0] q_sync;
    wire [3:0] q_async;

    sync_counter uut1(clk, reset, q_sync);
    async_counter uut2(clk, reset, q_async);

    always #5 clk = ~clk;

    initial begin
        $monitor("Time=%0t Sync=%b Async=%b",
                 $time, q_sync, q_async);

        clk = 0;
        reset = 1;

        #10 reset = 0;

        #200;

        $finish;
    end

endmodule