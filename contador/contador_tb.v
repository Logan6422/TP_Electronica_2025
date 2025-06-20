`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns

module contador_tb();

//-- Simulation time: 1us (10 * 100ns)
parameter DURATION = 1000;

//-- Clock signal. It is not used in this simulation
reg clk = 0;
always #5 clk = ~clk;

//-- Leds port
wire [2:0] counter_t;
reg rst,sum_t,res_t;

//-- Instantiate the unit to test
contador UUT(.reset(rst), .count(counter_t), .clk(clk), .sum(sum_t), .res(res_t));
integer i;

initial begin
    
  //-- File were to store the simulation results
  $dumpfile(`DUMPSTR(`VCD_OUTPUT));
  $dumpvars(0, contador_tb);
    rst = 1;  
    sum_t = 0;
    res_t = 0;
    #10

    rst = 0;


    //3 pulsos  suma
    sum_t = 1; #10
    res_t = 0; #20
    
    sum_t = 1; #10
    res_t = 0; #20
    
    sum_t = 1; #10
    res_t = 0; #20
    
    sum_t = 0; #10
    res_t = 1; #20
    
    sum_t = 0; #10
    res_t = 1; #20

    

    #100
  $finish;
end

endmodule