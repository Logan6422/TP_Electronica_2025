// module contador(
//     input wire clk, reset, sum, res,
//     output reg [2:0] count
// );

//     reg sum_d;  // guarda el valor anterior del boton sum

//     always @(posedge clk ) begin
//         if (~reset) begin  //resetea el contador
//             count <= 0;
//             sum_d <= 1; //boton no presionado
//         end else begin
//             sum_d <= sum; // guarda valor anterior del botón en el registro

//             // detectar flanco de bajada (de 1 a 0)
//             if (sum_d == 1 && sum == 0) begin //si en el flanco anterior el boton no estaba presionado y en este si fue presionado
//                 if (count < 7)    // y el contador es menor a 7 entonces
//                     count <= count + 1; //suma
//             end
//         end
//     end
// endmodule


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
            count <= 0;
            sum_d <= 1;  // asumimos botones activos bajos
            res_d <= 1;
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
