    module debounce (
        input wire clk,
        input wire rst,
        input wire noisy_in,
        output reg clean_out
    );

        reg [15:0] count = 0; //contador para medir cantidad de ciclos donde la senial permanece distinta
        reg stable_state = 0; //valor estable valido
        reg prev_noisy = 0;  //valor anterior para detectar cambios

        parameter THRESHOLD = 20; //cantidad de ciclos estables para aceptar cambio

        always @(posedge clk or posedge rst) begin
            if (rst) begin
                count <= 0;
                clean_out <= 0;
                stable_state <= 0;
                prev_noisy <= 0;
            end else begin
                if (noisy_in == prev_noisy) begin
                    // Señal estable, reinicio contador
                    count <= 0;
                end else begin
                    // Señal cambió, comienzo a contar cuantos ciclos se mantiene estable
                    count <= count + 1;  
                    if (count >= THRESHOLD) begin
                        stable_state <= noisy_in; //acepta el nuevo valor como estable
                        clean_out <= noisy_in; //actualiza la salida
                        count <= 0;
                    end
                end
                prev_noisy <= noisy_in;
            end
        end

    endmodule

