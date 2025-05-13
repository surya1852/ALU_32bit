`ifndef AGENT
  `define AGENT

class agent extends uvm_agent;

	 `uvm_component_utils_begin(agent)
       `uvm_component_utils_end

       driver drv;
       monitor mnr;
       sequencer seqr;

    function new(string name="agent",uvm_component parent);
    	super.new(name,parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
    	super.build_phase(phase);
    	`uvm_info("","this is the build phase of the agent",UVM_NONE)
    	drv=driver::type_id::create("drv",this);
    	mnr=monitor::type_id::create("mnr",this);
    	seqr=sequencer::type_id::create("seqr",this);
    endfunction : build_phase


    function void connect_phase(uvm_phase phase);
    	super.connect_phase(phase);
    	drv.seq_item_port.connect(seqr.seq_item_export);
     endfunction : connect_phase
     

endclass : agent

`endif
