module fsm(                     // Definición del módulo FSM (Finite State Machine)
    input wire clk,             // Entrada de reloj
    input wire rst,             // Entrada de reset (activo alto)
    input wire A,               // Entrada A (sensor)
    input wire B,               // Entrada B (sensor)
    output reg S,               // Salida S (por ejemplo, señal de salida de un auto)
    output reg E                // Salida E (por ejemplo, señal de entrada de un auto)
);

    // Definición de estados como parámetros constantes
    localparam S0 = 2'b00,      // Estado inicial: sin sensores activos
               S1 = 2'b10,      // Estado: solo A activo
               S2 = 2'b11,      // Estado: A y B activos
               S3 = 2'b01;      // Estado: solo B activo

    reg [1:0] state, next_state;   // Registros para el estado actual y el próximo estado
    reg [1:0] prev_state;          // Registro para guardar el estado anterior

    // Bloque secuencial que actualiza el estado y genera salidas
    always @(posedge clk or posedge rst) begin
        if (rst) begin               // Si se activa el reset...
            state <= S0;            // Volver al estado inicial
            prev_state <= S0;       // También reiniciar el estado previo
            S <= 0;                 // Poner salida S en 0
            E <= 0;                 // Poner salida E en 0
        end else begin              // En flanco de subida de clk, si no hay reset...
            prev_state <= state;    // Guardar el estado actual como anterior
            state <= next_state;    // Avanzar al siguiente estado calculado

            // Generación de pulso de salida S:
            // si se pasó de S1 a S0, entonces se activa S por 1 ciclo
            if (prev_state == S1 && state == S0)
                S <= 1;
            else
                S <= 0;

            // Generación de pulso de entrada E:
            // si se pasó de S3 a S0, entonces se activa E por 1 ciclo
            if (prev_state == S3 && state == S0)
                E <= 1;
            else
                E <= 0;
        end
    end

    // Bloque combinacional que define las transiciones entre estados
    always @(*) begin
        next_state = state;          // Por defecto, mantener el mismo estado
        case (state)
            S0: begin                // Estado S0: sin sensores activos
                if ({A,B} == 2'b10)  // Si solo A está activo
                    next_state = S1;
                else if ({A,B} == 2'b01) // Si solo B está activo
                    next_state = S3;
            end
            S1: begin                // Estado S1: solo A activo
                if ({A,B} == 2'b11)  // Si A y B activos → auto avanza
                    next_state = S2;
                else if ({A,B} == 2'b00) // Si se sueltan los sensores
                    next_state = S0;
            end
            S2: begin                // Estado S2: ambos sensores activos
                if ({A,B} == 2'b01)  // Solo B activo → auto saliendo
                    next_state = S3;
                else if ({A,B} == 2'b10) // Solo A activo → auto entrando
                    next_state = S1;
            end
            S3: begin                // Estado S3: solo B activo
                if ({A,B} == 2'b00)  // Si se sueltan los sensores
                    next_state = S0;
                else if ({A,B} == 2'b11) // Ambos sensores activos nuevamente
                    next_state = S2;
            end
        endcase
    end

endmodule                          // Fin del módulo
