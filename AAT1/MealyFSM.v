module mealy_fsm(
    input clk,
    input reset,
    input x,
    output reg y
);

    reg [1:0] state, next_state;

    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;

    always @(posedge clk or posedge reset) begin
        if(reset)
            state <= S0;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state;
        y = 0;

        case(state)

            S0: begin
                if(x)
                    next_state = S1;
                else
                    next_state = S0;
            end

            S1: begin
                if(x)
                    next_state = S1;
                else
                    next_state = S2;
            end

            S2: begin
                if(x) begin
                    next_state = S1;
                    y = 1;
                end
                else
                    next_state = S0;
            end

            default: begin
                next_state = S0;
                y = 0;
            end

        endcase
    end

endmodule

module tb_mealy_fsm;

    reg clk, reset, x;
    wire y;

    mealy_fsm uut(clk, reset, x, y);

    always #5 clk = ~clk;

    initial begin
        $monitor("Time=%0t X=%b Y=%b", $time, x, y);

        clk = 0;
        reset = 1;
        x = 0;

        #10 reset = 0;

        x = 1; #10;
        x = 0; #10;
        x = 1; #10;

        x = 1; #10;
        x = 0; #10;
        x = 1; #10;

        #20;

        $finish;
    end

endmodule