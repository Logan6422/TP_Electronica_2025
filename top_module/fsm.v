module fsm #(
    parameter PULSE_WIDTH_S = 10, // duración del pulso de salida (S)
    parameter PULSE_WIDTH_E = 10  // duración del pulso de entrada (E)
)(
    input wire clk,
    input wire rst,
    input wire A,
    input wire B,
    output reg S, // salida de auto
    output reg E  // entrada de auto
);

    // Estados
    localparam S0 = 2'b00,
               S1 = 2'b10,
               S2 = 2'b11,
               S3 = 2'b01;

    reg [1:0] state, next_state;
    reg [1:0] prev_state;

    // Registro de estado y estado previo
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= S0;
            prev_state <= S0;
            S <= 0;
            E <= 0;
        end else begin
            prev_state <= state;
            state <= next_state;

            // Pulsos según transiciones
            if (prev_state == S1 && state == S0)
                S <= 1;
            else
                S <= 0;

            if (prev_state == S3 && state == S0)
                E <= 1;
            else
                E <= 0;
        end
    end

    // Lógica combinacional de transición de estados
    always @(*) begin
        next_state = state;
        case (state)
            S0: begin
                if ({A,B} == 2'b10)
                    next_state = S1;
                else if ({A,B} == 2'b01)
                    next_state = S3;
            end
            S1: begin
                if ({A,B} == 2'b11)
                    next_state = S2;
                else if ({A,B} == 2'b00)
                    next_state = S0;
            end
            S2: begin
                if ({A,B} == 2'b01)
                    next_state = S3;
                else if ({A,B} == 2'b10)
                    next_state = S1;
            end
            S3: begin
                if ({A,B} == 2'b00)
                    next_state = S0;
                else if ({A,B} == 2'b11)
                    next_state = S2;
            end
        endcase
    end

endmodule

//     // Lógica secuencial para salidas extendidas
//     always @(posedge clk or posedge rst) begin
//         if (rst) begin
//             s_count <= 0;
//             e_count <= 0;
//             S <= 0;
//             E <= 0;
//         end else begin
//             // Detectar transiciones reales de estados previos a actuales
//             if (prev_state == S3 && state == S0)
//                 s_count <= PULSE_WIDTH_S - 1;

//             if (prev_state == S1 && state == S0)
//                 e_count <= PULSE_WIDTH_E - 1;

//             // Control de salida S
//             if (s_count > 0) begin
//                 S <= 1;
//                 s_count <= s_count - 1;
//             end else
//                 S <= 0;

//             // Control de salida E
//             if (e_count > 0) begin
//                 E <= 1;
//                 e_count <= e_count - 1;
//             end else
//                 E <= 0;
//         end
//     end

//     always @(posedge clk) begin
//     $display("Tiempo %0t: A=%b, B=%b", $time, UUT.b1_t, UUT.b2_t);
// end

