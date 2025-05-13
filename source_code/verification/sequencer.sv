`ifndef SEQUENCER
  `define SEQUENCER


class sequencer extends uvm_sequencer #(sequence_item);

	`uvm_component_utils_begin(sequencer)
	   `uvm_component_utils_end

	function new(string name="",uvm_component parent);
		super.new(name,parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("","this is the build phase of the sequencer",UVM_NONE)
    endfunction

endclass : sequencer

`endif
