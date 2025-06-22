module fsm(
    input wire a,b,clk,rst,
    output wire sumar,restar
);

wire q0, q1;

ff_d FF0(.clk(clk),.reset(rst),.d((~q0 & b) | (~q0 & a)),.q(q0));
ff_d FF1(.clk(clk),.reset(rst),.d((~q0 & b) | (a & b)),.q(q1));
ff_d FFS(.clk(clk),.reset(rst),.d(q0 & q1 & ~a & ~b),.q(sumar));
ff_d FFR(.clk(clk),.reset(rst),.d(q0 & ~q1 & ~a & ~b),.q(restar));

endmodule

