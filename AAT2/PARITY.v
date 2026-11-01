
module parity_checker (
    input [3:0] data,
    input parity_bit,
    output even_error,
    output odd_error
);

assign even_error = ^{data, parity_bit};
assign odd_error  = ~(^ {data, parity_bit});

endmodule


module parity_generator (
    input [3:0] data,
    output even_parity,
    output odd_parity
);

assign even_parity = ^data;
assign odd_parity  = ~(^data);

endmodule
