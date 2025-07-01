module top(                             
    input wire clk,                     
    input wire reset,                   
    input wire b1, b2,                  
    output reg [2:0] leds               
);

    // Señales internas para comunicación entre módulos
    wire pulse_sumar, pulse_restar;     // Pulsos generados por la FSM para sumar o restar
    wire [2:0] count_out;               // Salida del contador (valor actual)

    
    // Se invierten b1 y b2 porque los sensores están activos bajos
    fsm FSM (
        .clk(clk),                      
        .rst(~reset),                   
        .A(~b1),                        
        .B(~b2),                        
        .S(pulse_restar),              
        .E(pulse_sumar)                
    );

    
    // Responde a los pulsos generados por la FSM
    contador COUNTER (
        .clk(clk),                      
        .reset(reset),                  
        .sum(pulse_sumar),              
        .res(pulse_restar),             
        .count(count_out)               
    );

    // Asignación de la salida a los LEDs:
    
    always @(posedge clk or negedge reset) begin
        if (!reset)                     
            leds <= 3'b000;             // Se apagan los LEDs
        else
            leds <= count_out;          // Se muestra el valor del contador
    end   

endmodule                               

