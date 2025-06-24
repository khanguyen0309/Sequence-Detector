class monitor extends uvm_monitor;
    `uvm_component_utils(monitor)
    uvm_analysis_port #(transaction) send;

    function new (input string inst = "monitor", uvm_component parent = null);
        super.new(inst, parent);
        send = new("send", this);
    endfunction

    transaction t;
    virtual seq_if sif;

    virtual function void build_phase(uvm_phase phase)
        super.build_phase(phase);
        t = transaction::type_id::create("TRANS");

        if(!uvm_config_db #(virtual seq_if)::get(this, "", "sif", sif));
        `uvm_error("MON", "Unable to access uvm_config_db");
    endfunction

    virtual task run_phase(uvm_phase phase)
        forever begin
            seq_item_port.get_next_item(t);
            sif.in <= t.in;
            sif.rst <= t.rst;
            sif.overlap_en <= tc.overlap_en;
            `uvm_info("MON", $sformatf("Trigger DUT in: %0d ,rst: %0d ,overlap: %0d", t.in,
            t.rst, t.overlap_en), UVM_NONE);
            seq_item_port.done();
            #10;
        end
    endtask

endclass