module contador(                    
    input wire clk,                 
    input wire reset,               
    input wire sum,                 
    input wire res,                 
    output reg [2:0] count          
);

    reg sum_d;                      
    reg res_d;                      

    always @(posedge clk) begin     
        if (~reset) begin           // Si el reset está en 0 (activo), se reinician los registros
            count <= 3'b000;        
            sum_d <= 0;             
            res_d <= 0;             
        end else begin              // Si reset no está activo (es decir, en 1), se ejecuta la lógica normal
            sum_d <= sum;           
            res_d <= res;           

            //asegura de que solo se active una vez por pulsación

            // Detecta flanco de bajada en 'sum': si antes era 1 y ahora es 0
            if (sum_d == 1 && sum == 0) begin
                if (count < 7)      // Si el contador no está en el valor máximo (7)
                    count <= count + 1; // Incrementa el contador en 1
            end

            // Detecta flanco de bajada en 'res': si antes era 1 y ahora es 0
            if (res_d == 1 && res == 0) begin
                if (count > 0)      // Si el contador es mayor que 0
                    count <= count - 1; // Decrementa el contador en 1
            end
        end
    end

endmodule                          
