`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns

module fsm_tb();

//-- Simulation time: 1us (10 * 100ns)
parameter DURATION = 1000;

//-- Clock signal. It is not used in this simulation
reg clk = 0;
always #5 clk = ~clk;

//-- Leds port
wire sum_t,res_t;
reg rst = 1;
reg a_t = 0;
reg b_t = 0;  

//-- Instantiate the unit to test
fsm UUT(.rst(rst),.a(a_t),.b(b_t),.clk(clk),.sumar(sum_t),.restar(res_t));
integer i;

initial begin
    
  //-- File were to store the simulation results
  $dumpfile(`DUMPSTR(`VCD_OUTPUT));
  $dumpvars(0, fsm_tb);
    rst = 0;

    

    //ingreso
    a_t = 0; b_t = 0; #10 
    a_t = 1; b_t = 0; #10
    a_t = 1; b_t = 1; #10
    a_t = 0; b_t = 1; #10
    a_t = 0; b_t = 0; #10 //sum (+1) 

    #20;

    //egreso
    a_t = 0; b_t = 0; #10 
    a_t = 0; b_t = 1; #10
    a_t = 1; b_t = 1; #10
    a_t = 1; b_t = 0; #10
    a_t = 0; b_t = 0; #10 //res(+1) 

    //peaton entrada
    a_t = 0; b_t = 0; #10 
    a_t = 1; b_t = 0; #10
    a_t = 0; b_t = 1; #10
    a_t = 0; b_t = 0; #10 // 0
    
    //peaton salida
      a_t = 0; b_t = 0; #10 
      a_t = 0; b_t = 1; #10
      a_t = 1; b_t = 0; #10
      a_t = 0; b_t = 0; #10 // 0

    #100
  $finish;
end

endmodule