class drive extends uvm_driver #(transaction);
    `uvm_component_utils(driver)

    function new (input string path = "driver", uvm_component parent = null);

    endfunction

endclass