module barrel_shifter(
    input [3:0] data,
    input [1:0] shift,
    input direction,
    output reg [3:0] y
);

    always @(*) begin
        if(direction == 0)
            y = data << shift;
        else
            y = data >> shift;
    end

endmodule

module tb_barrel_shifter;

    reg [3:0] data;
    reg [1:0] shift;
    reg direction;

    wire [3:0] y;

    barrel_shifter uut(data, shift, direction, y);

    initial begin
        $monitor("Time=%0t Data=%b Shift=%d Direction=%b Y=%b",
                 $time, data, shift, direction, y);

        data = 4'b1011;

        direction = 0;
        shift = 0; #10;
        shift = 1; #10;
        shift = 2; #10;
        shift = 3; #10;

        direction = 1;
        shift = 0; #10;
        shift = 1; #10;
        shift = 2; #10;
        shift = 3; #10;

        $finish;
    end

endmodule