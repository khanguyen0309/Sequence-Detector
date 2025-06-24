`include "uvm_macros.svh"
import uvm_pkg::*;

class transaction extends uvm_sequence_item;
    rand bit in;
    bit rst;
    bit overlap_en;

    function new (input string path = "transaction");
        super.new(path);
    endfunction

    `uvm_object_utils_begin(transaction)
    `uvm_field_int(in, UVM_DEFAULT)
    `uvm_field_int(rst, UVM_DEFAULT)
    `uvm_field_int(overlap_en, UVM_DEFAULT)
    `uvm_object_utils_end

    //If you want to customize printing with do_print()
    // function void do_print(uvm_printer printer);
    //     super.do_print(printer);
    //     printer.print_field("in", in, $bits(in));
    //     printer.print_field("rst", rst, $bits(rst));
    //     printer.print_field("overlap_en", overlap_en, $bits(overlap_en));
    // endfunction

endclass
