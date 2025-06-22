module top(
    input wire clk, reset, b1, b2,
    output reg [2:0] leds
);


wire p_suma, p_resta;
wire [2:0] count_out;
wire b1_s, b2_s, reset_s;


antirebote A1(.clk(clk),.btn_in(b1),.btn_out(b1_s));
antirebote A2(.clk(clk),.btn_in(b2),.btn_out(b2_s));
antirebote A3(.clk(clk),.btn_in(reset),.btn_out(reset_s));

fsm FSM(.a(b1_s),.b(b2_s),.clk(clk),.rst(reset_s),.sumar(p_suma),.restar(p_resta));
contador COUNTER(.clk(clk), .reset(reset),.sum(p_suma),.res(p_resta),.count(count_out));


always@(*)begin
    leds <= count_out;
end

endmodule;