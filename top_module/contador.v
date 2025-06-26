module contador(
    input wire clk,
    input wire reset,
    input wire sum,
    input wire res,
    output reg [2:0] count
);

    reg sum_d;  // valor anterior de sum
    reg res_d;  // valor anterior de res

    always @(posedge clk) begin
        if (~reset) begin
            count <= 3'b000;
            sum_d <= 0;  // asumimos botones activos bajos
            res_d <= 0;
        end else begin
            // Guardar los valores actuales para comparar en el próximo ciclo
            sum_d <= sum;
            res_d <= res;

            // Detectar flanco de bajada en sum
            if (sum_d == 1 && sum == 0) begin
                if (count < 7)
                    count <= count + 1;
            end

            // Detectar flanco de bajada en res
            if (res_d == 1 && res == 0) begin
                if (count > 0)
                    count <= count - 1;
            end
        end
    end

endmodule
