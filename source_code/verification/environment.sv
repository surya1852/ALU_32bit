`ifndef ENVIRONMENT
  `define ENVIRONMENT

class environment extends uvm_env;

	`uvm_component_utils_begin(environment)
	  `uvm_component_utils_end

	    scoreboard sco;
	    subscriber scr;
	    agent agt;

	function new(string name="environemnt", uvm_component parent);
		super.new(name,parent);
	endfunction : new
    

    function void build_phase(uvm_phase phase);
    	super.build_phase(phase);
    	  `uvm_info("","this is the build phase of environment",UVM_NONE)
    	sco=scoreboard::type_id::create("sco",this);
    	scr=subscriber::type_id::create("scr",this);
    	agt=agent::type_id::create("agt",this);
    endfunction

    function void connect_phase(uvm_phase phase);
    	super.connect_phase(phase);
    	agt.drv.drv_port.connect(sco.drv_export);
    	agt.mnr.mon_port.connect(sco.mon_export);
    endfunction

 endclass : environment

 `endif