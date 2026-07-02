`timescale 1ns/1ps

module tb_alu_4bit;

reg  [3:0] a;
reg  [3:0] b;
reg  [2:0] opcode;
wire [3:0] result;
wire       carry;
wire       zero;

alu_4bit uut(
    .a(a),
    .b(b),
    .opcode(opcode),
    .result(result),
    .carry(carry),
    .zero(zero)
);

initial begin
    a = 4'd7;
    b = 4'd3;

    opcode = 3'b000; #10;
    opcode = 3'b001; #10;
    opcode = 3'b010; #10;
    opcode = 3'b011; #10;

    a = 4'd15;
    b = 4'd1;
    opcode = 3'b000; #10;

    $finish;
end

endmodule
