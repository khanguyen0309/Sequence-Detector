//System Verilog testbench for 101 module
`timescale 1ns / 1ps

module tb_101;
    
    //Declare testbench signals
    logic clk, rst, in;
    logic out;
    logic overlap_en;
    
    //Instantiate the DUT (Design Under Test)
    det_101 dut(
        .clk(clk),
        .rst(rst),
        .in(in),
        .overlap_en(overlap_en),
        .out(out)
    );
    
    // Clock generation: 10ns period (toggle every 5ns)
    always #5 clk = ~clk;
    
    //Stimulus
    initial begin
        //Initialize signals
        clk = 0; 
        rst = 1;
        in = 0;
        overlap_en = 1;
        
        $display("Starting simulation...");
//        $dumpfile("det_101.vcd");  //For waveform 
//        $dumpvars(0, 101_tb);
        
        #12 rst = 0; 
        
        //Apply bitstream: 101 (detected), then 100101
        @(posedge clk); in = 1;
        @(posedge clk); in = 0;
        @(posedge clk); in = 1;
        @(posedge clk); in = 1;
        @(posedge clk); in = 0;
        @(posedge clk); in = 0;
        @(posedge clk); in = 1;
        @(posedge clk); in = 0;
        @(posedge clk); in = 1;
        
        #30;
        $finish;
    end
    
    //Monitor signal transitions
    initial begin
        $monitor("T = %0t | clk = %b rst = %b in = %b => out = %b", $time, clk, rst, in, out);
    end
endmodule
