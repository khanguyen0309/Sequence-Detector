` ifndef SEQ_ITEM_SV
` define SEQ_ITEM_SV

class seq_item extends uvm_sequence_item;

    rand bit in;
    bit rst;
    bit overlap_en;

    `uvm_object_utils(seq_item)

    //Constructor
    function new(string name = "seq_item"); 
        super.new(name);
    endfunction

    function void do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_field("in", in, $bits(in));
        printer.print_field("rst", rst, $bits(rst));
        printer.print_field("overlap_en", overlap_en, $bits(overlap_en));
    endfunction
endclass

`endif
