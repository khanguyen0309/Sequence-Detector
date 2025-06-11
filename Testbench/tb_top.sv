//Top testbench for the design
`timescale 1ns / 1ps

import uvm_package::*;

` include "uvm_macros.svh"

` include "interface.sv" //Connect the DUT
` include "det_101.v" //RTL module

module tb_top;

    //Declare clock signal
    bit clk;

    //clock generation: 10ns period
    always #5 clk = ~clk;

    //Instantiate the interface
    seq_if intf(clk);

    //DUT instance
    det_101 dut(
        .clk        (clk),
        .rst        (intf.rst),
        .in         (intf.in),
        .overlap_en (intf.overlap_en),
        .out        (intf.out)
    );

    //Run UVM testbench
    initial begin
        uvm_config_db#(virtual seq_if)::set(null, "*", "vif", intf); //Pass interface to UVM env
        run_test(); //Can be run_test("test_name") later
    end
endmodule