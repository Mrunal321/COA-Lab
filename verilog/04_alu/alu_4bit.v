`timescale 1ns/1ps

module alu_full_adder(
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire sum,
    output wire cout
);

assign sum  = (~a & ~b & cin) |
              (~a &  b & ~cin) |
              ( a & ~b & ~cin) |
              ( a &  b & cin);
assign cout = (a & b) | (b & cin) | (a & cin);

endmodule

module alu_4bit(
    input  wire [3:0] a,
    input  wire [3:0] b,
    input  wire [2:0] opcode,
    output wire [3:0] result,
    output wire       carry,
    output wire       zero
);

wire op2_not;
wire op1_not;
wire op0_not;

wire sel_add;
wire sel_sub;
wire sel_and;
wire sel_or;
wire sel_xor;
wire sel_not;
wire sel_shl;
wire sel_shr;

wire [3:0] add_result;
wire [3:0] sub_result;
wire [3:0] and_result;
wire [3:0] or_result;
wire [3:0] xor_result;
wire [3:0] not_result;
wire [3:0] shl_result;
wire [3:0] shr_result;

wire add_c1;
wire add_c2;
wire add_c3;
wire add_cout;

wire sub_c1;
wire sub_c2;
wire sub_c3;
wire sub_cout;
wire sub_borrow;

assign op2_not = ~opcode[2];
assign op1_not = ~opcode[1];
assign op0_not = ~opcode[0];

assign sel_add = op2_not & op1_not & op0_not;
assign sel_sub = op2_not & op1_not & opcode[0];
assign sel_and = op2_not & opcode[1] & op0_not;
assign sel_or  = op2_not & opcode[1] & opcode[0];
assign sel_xor = opcode[2] & op1_not & op0_not;
assign sel_not = opcode[2] & op1_not & opcode[0];
assign sel_shl = opcode[2] & opcode[1] & op0_not;
assign sel_shr = opcode[2] & opcode[1] & opcode[0];

alu_full_adder add0(a[0], b[0], 1'b0,   add_result[0], add_c1);
alu_full_adder add1(a[1], b[1], add_c1, add_result[1], add_c2);
alu_full_adder add2(a[2], b[2], add_c2, add_result[2], add_c3);
alu_full_adder add3(a[3], b[3], add_c3, add_result[3], add_cout);

alu_full_adder sub0(a[0], ~b[0], 1'b1,   sub_result[0], sub_c1);
alu_full_adder sub1(a[1], ~b[1], sub_c1, sub_result[1], sub_c2);
alu_full_adder sub2(a[2], ~b[2], sub_c2, sub_result[2], sub_c3);
alu_full_adder sub3(a[3], ~b[3], sub_c3, sub_result[3], sub_cout);

assign sub_borrow = ~sub_cout;

assign and_result = a & b;
assign or_result  = a | b;

assign xor_result[0] = (~a[0] & b[0]) | (a[0] & ~b[0]);
assign xor_result[1] = (~a[1] & b[1]) | (a[1] & ~b[1]);
assign xor_result[2] = (~a[2] & b[2]) | (a[2] & ~b[2]);
assign xor_result[3] = (~a[3] & b[3]) | (a[3] & ~b[3]);

assign not_result = ~a;
assign shl_result = {a[2:0], 1'b0};
assign shr_result = {1'b0, a[3:1]};

assign result = ({4{sel_add}} & add_result) |
                ({4{sel_sub}} & sub_result) |
                ({4{sel_and}} & and_result) |
                ({4{sel_or}}  & or_result)  |
                ({4{sel_xor}} & xor_result) |
                ({4{sel_not}} & not_result) |
                ({4{sel_shl}} & shl_result) |
                ({4{sel_shr}} & shr_result);

assign carry = (sel_add & add_cout) |
               (sel_sub & sub_borrow) |
               (sel_shl & a[3]) |
               (sel_shr & a[0]);

assign zero = ~(result[0] | result[1] | result[2] | result[3]);

endmodule
