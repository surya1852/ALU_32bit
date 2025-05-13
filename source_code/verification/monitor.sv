`ifndef MONITOR
  `define MONITOR


class monitor extends uvm_monitor;

	`uvm_component_utils_begin(monitor)
	   `uvm_component_utils_end

	   virtual alu alu_intf;
	   sequence_item seqi;

	   uvm_analysis_port #(sequence_item) mon_port;

	function new(string name="",uvm_component parent);
		super.new(name,parent);
		mon_port=new("mon_port",this);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("","this is the build phase of the monitor",UVM_NONE)
		uvm_config_db#(virtual alu)::get(this,"","INTERFACE KEY1",alu_intf);
    endfunction

   task run_phase(uvm_phase phase);
   	
   	forever begin
   		//uvm_info("","this is the monitor run phase",UVM_NONE)
   		#2;
   		seqi=sequence_item::type_id::create("seqi",this);
   		seqi.A = alu_intf.A;
   		seqi.B = alu_intf.B;
   		seqi.opcode = alu_intf.opcode;
   		seqi.out = alu_intf.out;
   		seqi.carryout = alu_intf.carryout;
   		`uvm_info("",$sformatf("sampled from interface : A=%h , B=%h , opcode=%h, out = %h, carryout=%b",seqi.A,seqi.B,seqi.opcode,seqi.out,seqi.carryout),UVM_NONE)
   	   mon_port.write(seqi);
   	end
   endtask : run_phase




endclass : monitor

`endif
