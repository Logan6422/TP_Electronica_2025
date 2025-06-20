`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns

module ffd_tb();

//-- Simulation time: 1us (10 * 100ns)
parameter DURATION = 1000;

//-- Clock signal. It is not used in this simulation
reg clk = 0;
always #5 clk = ~clk;

//-- Leds port
reg reset;
reg d;
wire q;

//-- Instantiate the unit to test
ffd UUT(.reset(reset),.d(d),.clk(clk),.q(q));


initial begin
    
  //-- File were to store the simulation results
  $dumpfile(`DUMPSTR(`VCD_OUTPUT));
  $dumpvars(0, ffd_tb);
    reset = 0;

    //ingreso
    d = 0;#10
    d = 1; #10


    d = 0;#10
    d = 1; #10
    #100
  $finish;
end

endmodule