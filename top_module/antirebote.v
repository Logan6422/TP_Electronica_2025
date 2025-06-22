module antirebote(
    input wire clk,
    input wire btn_in,     
    output reg btn_out     // pulsación limpia
);

parameter STABLE_COUNT = 200_000; // ~10 ms a 20 MHz

reg [17:0] contador = 0;
reg btn_sync_0 = 0, btn_sync_1 = 0;
wire btn_stable;

// Sincronizador doble para evitar problemas de metastabilidad
always @(posedge clk) begin
    btn_sync_0 <= btn_in;
    btn_sync_1 <= btn_sync_0;
end

// Detector de estabilidad
always @(posedge clk) begin
    if (btn_sync_1 == btn_out) begin
        contador <= 0;
    end else begin
        contador <= contador + 1;
        if (contador >= STABLE_COUNT) begin
            btn_out <= btn_sync_1;
            contador <= 0;
        end
    end
end

endmodule