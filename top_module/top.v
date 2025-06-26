module top(
    input wire clk,
    input wire reset,
    input wire b1, b2,         // sensores
    output reg [2:0] leds      // visualización del contador
);

    // Conexiones internas
    wire pulse_sumar, pulse_restar;
    wire [2:0] count_out;

    // Instanciar la FSM
    fsm FSM (
        .clk(clk),
        .rst(~reset),
        .A(~b1),
        .B(~b2),
        .S(pulse_restar), // S = salida auto → resta
        .E(pulse_sumar)   // E = entrada auto → suma
    );
    // Instanciar el contador
    contador COUNTER (
        .clk(clk),
        .reset(reset),
        .sum(pulse_sumar),
        .res(pulse_restar),
        .count(count_out)
    );
    //Actualizar LEDs en flanco positivo de clk para reflejar el conteo en todo momento
    always @(posedge clk or negedge reset) begin
        if (!reset)
            leds <= 3'b000;
        else
            leds <= count_out;
    end   
endmodule




