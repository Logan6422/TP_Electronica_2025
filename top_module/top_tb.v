//`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns

module top_tb();

parameter DURATION = 99999;

reg clk = 0;
always #10 clk = ~clk;  // 100ns período

// Señales de entrada
reg rst = 1;
reg A = 0;
reg B = 0;

// Salida de LEDs
wire [2:0] leds_t;

// Instancia del módulo top
top UUT (
    .clk(clk),
    .reset(rst),
    .b1(A),
    .b2(B),
    .leds(leds_t)
);

initial begin
    $dumpfile(`DUMPSTR(`VCD_OUTPUT));
    $dumpvars(0, top_tb);

    // Reset inicial
    rst = 0;
    #50;
    rst = 1;

    // === Ingreso de auto (suma) ===
    A = 0; B = 0; #100;
    A = 1; B = 0; #100; // s0 -> s1
    A = 1; B = 1; #100; // s1 -> s2
    A = 0; B = 1; #100; // s2 -> s3
    A = 0; B = 0; #100; // s3 -> s0 => S = 1 (entrada de auto)
      
    #100

    // === Ingreso de auto (suma) ===
    A = 0; B = 0; #100;
    A = 1; B = 0; #100; // s0 -> s1
    A = 1; B = 1; #100; // s1 -> s2
    A = 0; B = 1; #100; // s2 -> s3
    A = 0; B = 0; #100; // s3 -> s0 => S = 1 (entrada de auto)

    #100;

    // === Egreso de auto (resta) ===
    A = 0; B = 0; #100;
    A = 0; B = 1; #100; // s0 -> s1
    A = 1; B = 1; #100; // s1 -> s2
    A = 1; B = 0; #100; // s2 -> s3
    A = 0; B = 0; #100; // s3 -> s0 => S = 1 (entrada de auto)

    #100;

    // === Egreso de auto (resta) ===
    A = 0; B = 0; #100;
    A = 0; B = 1; #100; // s0 -> s1
    A = 1; B = 1; #100; // s1 -> s2
    A = 1; B = 0; #100; // s2 -> s3
    A = 0; B = 0; #100; // s3 -> s0 => S = 1 (entrada de auto)

    #100;
    
    // === Secuencia invalida (ignorar) ===
    A = 0; B = 0; #100;
    A = 1; B = 1; #100; 
    A = 1; B = 1; #100; 
    A = 0; B = 0; #100; 
    A = 0; B = 1; #100; 

    #100;

    $finish;
    
end



endmodule
