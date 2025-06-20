module fsm(
    input wire a,b,clk,rst,
    output reg sumar,restar
);

wire [1:0] estado_actual;
reg [1:0] estado_siguiente;

ff_d FF0(.clk(clk),.reset(rst),.d(estado_siguiente[0]),.q(estado_actual[0]));
ff_d FF1(.clk(clk),.reset(rst),.d(estado_siguiente[1]),.q(estado_actual[1]));

localparam S1 = 2'b00,
           S2 = 2'b10,
           S3 = 2'b11,
           S4 = 2'b01;


always @(*) begin
    estado_siguiente = estado_actual;
    sumar = 0;
    restar = 0;

    case(estado_actual)
        S1:begin
            if({a,b} == 2'b10)begin
                estado_siguiente <= S2;
            end else if({a,b} == 2'b01)begin
                estado_siguiente <= S4;
            end
        end

        S2:begin
            if({a,b} == 2'b11)begin
                estado_siguiente <= S3;
            end else if({a,b} == 2'b00)begin
                estado_siguiente <= S1;
                restar = 1;
            end
        end

        S3:begin
            if({a,b} == 2'b01)begin
                estado_siguiente <= S4;
            end else if({a,b} == 2'b10)begin
                estado_siguiente <= S2;
            end
        end

        S4:begin
            if({a,b} == 2'b00)begin
                estado_siguiente <= S1;
                sumar = 1;
            end else if({a,b} == 2'b11)begin
                estado_siguiente <= S3;
            end
        end
    endcase 
end

endmodule