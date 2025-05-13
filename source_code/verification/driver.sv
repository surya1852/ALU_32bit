`ifndef DRIVER
  `define DRIVER


class driver extends uvm_driver #(sequence_item);

	`uvm_component_utils_begin(driver)
	   `uvm_component_utils_end

	   uvm_analysis_port #(sequence_item) drv_port;

	   sequence_item seqi;
	   virtual alu alu_intf;

	function new(string name="",uvm_component parent);
		super.new(name,parent);
		drv_port = new("drv_port",this);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("","this is the build phase of the driver",UVM_NONE)
	   uvm_config_db#(virtual alu)::get(this,"","INTERFACE KEY",alu_intf);
    endfunction


    task run_phase(uvm_phase phase);
    	

    	forever begin
    		seq_item_port.get_next_item(seqi);
    		`uvm_info("","this is the run phase of the driver",UVM_NONE)
    		`uvm_info("","after randomization from sequence to driver",UVM_NONE)
    		 seqi.print();
    		 
    		 alu_intf.A <= seqi.A;
    		 alu_intf.B <= seqi.B;
    		 alu_intf.opcode <= seqi.opcode;

    		 #2;
    		alu_intf.print();
    		drv_port.write(seqi);
    		seq_item_port.item_done();
    	end
    endtask : run_phase

endclass : driver

`endif
