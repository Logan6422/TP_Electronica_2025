module contador(
    input wire clk, reset,sum,res,
    output reg [2:0] count
);

always@(posedge clk)begin
    if(reset)
        count <= 3'b000;
    else begin
        case({sum,res})
            2'b10: if(count < 7) count <= count + 1; //sumar auto
            2'b01: if(count > 0) count <= count - 1; //restar auto
            default: count <= count;
        endcase
    end
end

endmodule