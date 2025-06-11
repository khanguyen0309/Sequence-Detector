interface seq_if(input logic clk);

    //input control signals
    logic rst;
    logic in;
    logic overlap_en;

    //output signal:
    logic out;

    //Clocking block for synchronization (for UVM)
    clocking cb @(posedge clk);
        iniput out;
        output rst, in, overlap_en;
    endclocking
    
endinterface 
