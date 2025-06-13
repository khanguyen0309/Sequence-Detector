` ifndef SEQUENCE_SV
` define SEQUENCE_SV

class simple_seq extends uvm_sequence #(seq_item);
    `uvm_object_utils(simple_seq)

    function new(string name = "simple_seq");   //Function has no delay + has to return
        super.new(name);
    endfunction


    virtual task body();    //Task has delay, time control available + doesn't return
        seq_item item;
        
        repeat (10) begin
            item = seq_item::type_id::create("item");
            assert(item.randomize());
            start_item(item);
            finish_item(item);
        end
    endtask
endclass

`endif