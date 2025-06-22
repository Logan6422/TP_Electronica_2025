// module ff_d(
//     input wire clk,reset,d,
//     output reg q
// );


// always @(posedge clk)begin
//     if(~reset)
//         q <= 0;
//     else
//         q <= d;
// end
// endmodule

module ff_d(
    input wire clk,
    input wire reset,
    input wire d,
    output reg q
);

    reg d_d; // registro para detectar flanco de bajada

    always @(posedge clk) begin
        if (~reset) begin
            q <= 0;
            d_d <= 1; // asumimos señal activa baja: 1 = botón no presionado
        end else begin
            d_d <= d;       // guardo valor anterior de d
            // flanco de bajada: d_d=1 y d=0
            if (d_d == 1 && d == 0)
                q <= 1;
            else
                q <= 0; // pulso de 1 ciclo en q
        end
    end

endmodule
