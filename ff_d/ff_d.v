module ff_d(
    input wire clk,reset,d,
    output reg q
);


always @(posedge clk)begin
    if(~reset)
        q <= 0;
    else
        q <= d;
end
endmodule