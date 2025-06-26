`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns

module fsm_tb();

    parameter DURATION = 1000;

    reg clk = 0;
    always #5 clk = ~clk; // Período de 100ns

    // Señales de entrada
    reg rst = 1;
    reg A = 0;
    reg B = 0;

    // Salidas
    wire S; // salida auto
    wire E; // entrada auto

    // Instancia de la FSM
    fsm UUT (
        .clk(clk),
        .rst(rst),
        .A(A),
        .B(B),
        .S(S),
        .E(E)
    );

    initial begin
        $dumpfile(`DUMPSTR(`VCD_OUTPUT));
        $dumpvars(0, fsm_tb);

        // Reset
        rst = 1;
        #20;
        rst = 0;
        

        // === Secuencia de entrada de auto ===
        $display(">> INICIO: Ingreso de auto (esperamos E = 1 al final)");

        A = 0; B = 0; #100;
        A = 1; B = 0; #100; // s0 -> s1
        A = 1; B = 1; #100; // s1 -> s2
        A = 0; B = 1; #100; // s2 -> s3
        A = 0; B = 0; #100; // s3 -> s0 => S = 1 (entrada de auto)

        #100;

        // === Secuencia de salida de auto ===
        $display(">> INICIO: Salida de auto (esperamos S = 1 al final)");

        A = 0; B = 0; #100;
        A = 0; B = 1; #100; // s0 -> s3
        A = 1; B = 1; #100; // s3 -> s2
        A = 1; B = 0; #100; // s2 -> s1
        A = 0; B = 0; #100; // s1 -> s0 => E = 1 (salida de auto)

        #100;

        // === Secuencia inválida ===
        $display(">> INICIO: Secuencia inválida (no debe cambiar salidas)");

        A = 0; B = 0; #100;
        A = 1; B = 1; #100;
        A = 0; B = 0; #100;

        #100;

        $display(">> Fin de simulación.");
        $finish;
    end

endmodule
