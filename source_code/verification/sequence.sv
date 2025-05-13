`ifndef SEQUENCEE
  `define SEQUENCEE


class sequencee extends uvm_sequence;

     `uvm_object_utils_begin(sequencee)
      `uvm_object_utils_end

      sequence_item seqi;

    function new(string name="sequencee");
    	super.new(name);
    endfunction


    task body();
    	`uvm_info("","this is the task of the sequence",UVM_NONE)
       for(int i=0;i<2;i++) begin
              seqi=sequence_item::type_id::create("seqi");
            start_item(seqi);
             seqi.randomize();
             `uvm_info("","randomization starts at the sequence",UVM_NONE)
              seqi.print();
            finish_item(seqi);
      end
    endtask

 endclass : sequencee

 `endif
