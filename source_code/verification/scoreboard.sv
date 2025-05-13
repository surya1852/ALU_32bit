`ifndef SCOREBOARD
 `define SCOREBOARD

 `uvm_analysis_imp_decl(_var_port_drv);
 `uvm_analysis_imp_decl(_var_port_mon);

 typedef struct{
      bit [31:0] out;
      bit carryout;
 } expected;

class scoreboard extends uvm_scoreboard;
	`uvm_component_utils_begin(scoreboard)
	   `uvm_component_utils_end
	   
	    expected exc;
	    expected exqueue[$];
	    logic [32:0] temp;

	   uvm_analysis_imp_var_port_drv #(sequence_item,scoreboard) drv_export;
	   uvm_analysis_imp_var_port_mon #(sequence_item,scoreboard) mon_export;

	function new(string name="scorebaord",uvm_component parent);
		super.new(name,parent);
		drv_export=new("drv_export",this);
		mon_export=new("mon_export",this);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("","this is the build phase of the scoreboard",UVM_NONE)
	endfunction


	function void write_var_port_drv(sequence_item seqi);
		temp=0;
		exc = `{default:0};
		`uvm_info("",$sformatf("Driver  A=%h B=%h opcode =%b",seqi.A,seqi.B,seqi.opcode),UVM_NONE)

		case(seqi.opcode)
			    5'b00000: begin temp = seqi.A + seqi.B;
			    	             exc.out = temp[31:0];
			    	             exc.carryout = temp[32];
			    	        end
			    5'b00001: begin exc.out = seqi.A - seqi.B; exc.carryout = 0; end 
			    5'b00010: begin exc.out = seqi.A * seqi.B; exc.carryout = 0; end 
			    5'b00011: begin exc.out = (seqi.B != 0) ? seqi.A / seqi.B : 32'hDEADBEEF; exc.carryout = 0; end
			    5'b00100: begin exc.out = seqi.A << 1; exc.carryout= 0; end 
			    5'b00101: begin exc.out = seqi.A >> 1; exc.carryout = 0; end 
			    5'b00110: begin exc.out = {seqi.A[30:0], seqi.A[31]}; exc.carryout = 0; end 
			    5'b00111: begin exc.out = {seqi.A[0], seqi.A[31:1]}; exc.carryout = 0; end 
			    5'b01000: begin exc.out = seqi.A & seqi.B; exc.carryout = 0; end 
			    5'b01001: begin exc.out = seqi.A | seqi.B; exc.carryout = 0; end 
			    5'b01010: begin exc.out = seqi.A ^ seqi.B; exc.carryout = 0; end 
			    5'b01011: begin exc.out = ~(seqi.A | seqi.B); exc.carryout = 1; end 
			    5'b01100: begin exc.out = ~(seqi.A & seqi.B); exc.carryout = 1; end 
			    5'b01101: begin exc.out = ~(seqi.A ^ seqi.B); exc.carryout = 1; end 
			    5'b01110: begin exc.out = (seqi.A > seqi.B) ? 32'd1 : 32'd0; exc.carryout = 0; end 
			    5'b01111: begin exc.out = (seqi.A == seqi.B) ? 32'd1 : 32'd0; exc.carryout = 0; end 
			    5'b10000: begin exc.out = seqi.A + 1; exc.carryout = 0; end 
			    5'b10001: begin exc.out = seqi.A - 1; exc.carryout = 0; end 
			    5'b10010: begin exc.out = ~seqi.A; exc.carryout = 0; end 
			    5'b10011: begin exc.out = (seqi.B != 0) ? seqi.A % seqi.B : 32'hdeadbeef; exc.carryout = 0; end 
			    5'b10100: begin exc.out = (seqi.A < seqi.B) ? 32'd1 : 32'd0; exc.carryout= 0; end 
			    default:  begin exc.out = 32'h0; exc.carryout = 0; end

		endcase // seqi.opcode
		  $display("the expected values are out =%h ,carryout= %b",exc.out,exc.carryout);
		exqueue.push_back(exc);
    endfunction

    function void write_var_port_mon(sequence_item seqi);
    	//`uvm_info("","checking the expected and actual output ",UVM_NONE)
        
        expected exp;
        exp= exqueue.pop_front();


    	if(seqi.out !== exp.out || seqi.carryout !== exp.carryout) begin
    		`uvm_error("scoreboard",$sformatf("MISMATCHED ! expected out =%h, carryout =%b , got =%h, carryout =%b",exp.out,exp.carryout,seqi.out,seqi.carryout))
    	end
    	else begin
    		`uvm_info("",$sformatf("MATCHED!! expected out =%h, carryout =%b , got =%h, carryout =%b",exp.out,exp.carryout,seqi.out,seqi.carryout),UVM_NONE)
    	end
    endfunction : write_var_port_mon


endclass : scoreboard

`endif

