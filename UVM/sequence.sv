class generator extends uvm_sequence #(transaction);
    `uvm_object_utils(generator)       //register a class to the factory

    transaction t;
    integer i;

    //Constructor 
    function new(string path = "generator");   //Function has no delay + has to return
        super.new(path);
    endfunction


    virtual task body();    //Task has delay, time control available + doesn't return
        t = transaction::type_id::create("t")
        
        repeat (10) begin
            start_item(t);
            t.randomize();
            `uvm_info("GEN", $sformatf("Data send to Driver in :%0d , rst :%0d , overlap :
            %0d", t.in, t.rst, t.overlap_en), UVM_NONE);
            finish_item(t);
        end
    endtask
endclass