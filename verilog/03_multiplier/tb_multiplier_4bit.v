`timescale 1ns/1ps

module tb_multiplier_4bit;

reg  [3:0] a;
reg  [3:0] b;
wire [7:0] product;

multiplier_4bit uut(
    .a(a),
    .b(b),
    .product(product)
);

initial begin
    a = 4'd3;  b = 4'd4;  #10;
    a = 4'd7;  b = 4'd2;  #10;
    a = 4'd15; b = 4'd15; #10;
    a = 4'd9;  b = 4'd6;  #10;

    $finish;
end

endmodule
