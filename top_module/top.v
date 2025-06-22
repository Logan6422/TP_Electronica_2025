module top(
    input wire clk, reset, b1, b2,
    output reg [2:0] leds
);

reg b1_syn, b2_sync;
wire p_suma, p_resta;
wire [2:0] count_out;

fsm FSM(.a(b1),.b(b2),.clk(clk),.rst(reset),.sumar(p_suma),.restar(p_resta));
contador COUNTER(.clk(clk), .reset(reset),.sum(p_suma),.res(p_resta),.count(count_out));

//rst = 1

always@(*)begin
    leds <= count_out;
end

endmodule;