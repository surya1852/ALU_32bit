`ifndef TEST
    `define TEST

class test extends uvm_test;
   `uvm_component_utils_begin(test)
   `uvm_component_utils_end

    environment env;
    sequencee sen;

   function new(string name="test",uvm_component parent);
   	super.new(name, parent);
   endfunction


   function void build_phase(uvm_phase phase);
   	super.build_phase(phase);
   	   `uvm_info("","this is test build phase of test",UVM_NONE)
   	   env=environment::type_id::create("env",this);
   	   sen=sequencee::type_id::create("sen");
   endfunction : build_phase

   task run_phase(uvm_phase phase);
      `uvm_info("","this is the run phase of the test",UVM_NONE)
   	 phase.raise_objection(this);
   	 
   	 sen.start(env.agt.seqr);
   	 phase.drop_objection(this);
    endtask : run_phase


    function void end_of_elaboration_phase(uvm_phase phase);
    	super.end_of_elaboration_phase(phase);
    	  `uvm_info("","this is the elaboration class of the test",UVM_NONE)
    	  uvm_top.print_topology();
    	endfunction

      function void extract_phase(uvm_phase phase);
         super.extract_phase(phase);
         `uvm_info("","this is the extract phase of the test",UVM_NONE)
      endfunction : extract_phase


 endclass : test

  `endif 	
   

