`ifndef SUBSCRIBER
  `define SUBSCRIBER

class subscriber extends uvm_component;

	`uvm_component_utils_begin(subscriber)
	   `uvm_component_utils_end

	 function new(string name="subscriber",uvm_component parent);
	 	super.new(name,parent);
	 endfunction : new

	 function void build_phase(uvm_phase phase);
	 	super.build_phase(phase);
	 	`uvm_info("","this is the build phase of the subscriber",UVM_NONE)
	 endfunction

	endclass : subscriber

`endif
