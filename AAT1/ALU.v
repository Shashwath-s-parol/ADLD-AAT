module alu(
    input [7:0] a, b,
    input [2:0] op,
    output reg [7:0] y,
    output zero
);

    always @(*) begin
        case(op)
            3'b000: y = a + b;
            3'b001: y = a - b;
            3'b010: y = a & b;
            3'b011: y = a | b;
            3'b100: y = a ^ b;
            3'b101: y = ~a;
            3'b110: y = a << 1;
            3'b111: y = a >> 1;
            default: y = 8'b0;
        endcase
    end

    assign zero = (y == 8'b0);

endmodule

module tb_alu;

    reg [7:0] a, b;
    reg [2:0] op;
    wire [7:0] y;
    wire zero;

    alu uut(a, b, op, y, zero);

    initial begin
        $monitor("Time=%0t A=%d B=%d OP=%b Y=%d ZERO=%b",
                 $time, a, b, op, y, zero);

        a = 10; b = 5;

        op = 3'b000; #10;
        op = 3'b001; #10;
        op = 3'b010; #10;
        op = 3'b011; #10;
        op = 3'b100; #10;
        op = 3'b101; #10;
        op = 3'b110; #10;
        op = 3'b111; #10;

        a = 0; b = 0;
        op = 3'b000; #10;

        $finish;
    end

endmodule