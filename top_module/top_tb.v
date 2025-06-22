`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns

module top_tb();

//-- Simulation time: 1us (10 * 100ns)
parameter DURATION = 99999;

//-- Clock signal. It is not used in this simulation
reg clk = 0;
always #10 clk = ~clk;

//-- Leds port
wire [2:0] leds_t;
reg rst = 1;
reg b1_t = 0;
reg b2_t = 0;  

//-- Instantiate the unit to test
top UUT(.reset(rst),.b1(b1_t),.b2(b2_t),.clk(clk),.leds(leds_t));


initial begin
    
  //-- File were to store the simulation results
  $dumpfile(`DUMPSTR(`VCD_OUTPUT));
  $dumpvars(0, top_tb);
    rst = 0;
    #50
    rst = 1;

   
    //ingreso
    b1_t = 0; b2_t = 0; #10 
    b1_t = 1; b2_t = 0; #10
    b1_t = 1; b2_t = 1; #10
    b1_t = 0; b2_t = 1; #10
    b1_t = 0; b2_t = 0; #10 //sum (+1) 

    #20;

    //egreso
    b1_t = 0; b2_t = 0; #10 
    b1_t = 0; b2_t = 1; #10
    b1_t = 1; b2_t = 1; #10
    b1_t = 1; b2_t = 0; #10
    b1_t = 0; b2_t = 0; #10 //sum (+1) 

    //ingreso
    b1_t = 0; b2_t = 0; #10 
    b1_t = 1; b2_t = 0; #10
    b1_t = 1; b2_t = 1; #10
    b1_t = 0; b2_t = 1; #10
    b1_t = 0; b2_t = 0; #10 //sum (+1) 

    //peaton
    b1_t = 0; b2_t = 0; #10 
    b1_t = 1; b2_t = 0; #10
    b1_t = 0; b2_t = 1; #10
    b1_t = 0; b2_t = 0; #10 //sum (+1) 

    //peaton
    b1_t = 0; b2_t = 0; #10 
    b1_t = 0; b2_t = 1; #10
    b1_t = 1; b2_t = 0; #10
    b1_t = 0; b2_t = 0; #10 //sum (+1) 

    #100
  $finish;
end

endmodule