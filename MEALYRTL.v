/// Mealy 101 Detector  

module mealy101(
	input clk,reset,x,
	output reg y
);
	parameter s0 = 2'b00;
	parameter s1 = 2'b01;
	parameter s2 = 2'b10;
	parameter s3 = 2'b11;
	reg [1:0] state, nextstate;

	always @(posedge clk or posedge reset)
		begin
			if(reset)
				state <= s0;
			else
				state <= nextstate;
		end

	always @(*)
		begin
			y = 0;
			nextstate = state;
			case(state)
				s0:begin
					if (x == 1'b1)
						nextstate = s1;
					else 
						nextstate = s0;
				   end
				s1:begin
					if(x == 1'b0)
						nextstate = s2;
					else 
						nextstate = s1;
				   end
				s2:begin
					if(x == 1'b1)
						begin
							nextstate = s1;
							y = 1'b1;
						end
					else 
						nextstate = s0;
				    end
				default: begin
						nextstate = s0;
						y = 1'b0;
					 end
			endcase
		end
endmodule
