`ifndef SEQUENCE_ITEM
  `define SEQUENCE_ITEM


class sequence_item extends uvm_sequence_item;

    rand bit [31:0] A;
    rand bit [31:0] B;
    rand bit [4:0] opcode;
         bit [31:0] out;
         bit carryout;

     `uvm_object_utils_begin(sequence_item)
        `uvm_field_int(A, UVM_DEFAULT)
        `uvm_field_int(B, UVM_DEFAULT)
        `uvm_field_int(opcode, UVM_DEFAULT)
        `uvm_field_int(out, UVM_DEFAULT)
        `uvm_field_int(carryout, UVM_DEFAULT)
      `uvm_object_utils_end

    function new(string name="sequence");
    	super.new(name);
    endfunction


    task body();
    	`uvm_info("","this is the task of the sequence item",UVM_NONE)
    endtask

 endclass : sequence_item

 `endif
