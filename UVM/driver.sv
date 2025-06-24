class drive extends uvm_driver #(transaction);
    `uvm_component_utils(driver)

    function new (input string path = "driver", uvm_component parent = null);
        super.new(path, parent);
    endfunction

    transaction tc;
    virtual seq_if sif;

    virtual function void build_phase(uvm_phase phase)
        super.build_phase(phase);
        tc = transaction::type_id::create("tc");

        if(!uvm_config_db #(virtual seq_if)::get(this, "", "sif", sif));
        `uvm_error("DRV", "Unable to access uvm_config_db");
    endfunction

    virtual task run_phase(uvm_phase phase)
        forever begin
            seq_item_port.get_next_item(tc);
            sif.in <= tc.in;
            sif.rst <= tc.rst;
            sif.overlap_en <= tc.overlap_en;
            `uvm_info("DRV", $sformatf("Trigger DUT in: %0d ,rst: %0d ,overlap: %0d", tc.in,
            tc.rst, tc.overlap_en), UVM_NONE);
            seq_item_port.done();
            #10;
        end
    endtask

endclass