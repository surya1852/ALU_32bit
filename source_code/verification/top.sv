`include "uvm_macros.svh";
import uvm_pkg::*;

`include "alu_design.v"
`include "design_interface.sv"


typedef class test;
typedef class environment;
typedef class scoreboard;
typedef class subscriber;
typedef class agent;
typedef class driver;
typedef class monitor;
typedef class sequencer;
typedef class sequencee;
typedef class sequence_item;




`include "test.sv"
`include "environment.sv"
`include "scoreboard.sv"
`include "subscriber.sv"
`include "agent.sv"
`include "driver.sv"
`include "monitor.sv"
`include "sequencer.sv"
`include "sequence.sv"
`include "sequence_item.sv"

module top;


  alu alu_intf();

    alu_design DUT(
      .A(alu_intf.A),
      .B(alu_intf.B),
      .opcode(alu_intf.opcode),
      .carryout(alu_intf.carryout),
      .out(alu_intf.out)
      );


    initial begin
      uvm_config_db#(virtual alu)::set(null,"uvm_test_top.env.agt.drv","INTERFACE KEY",alu_intf);
      uvm_config_db#(virtual alu)::set(null,"*","INTERFACE KEY1",alu_intf);
    end



  initial begin

  run_test("test");


  end

  endmodule
                
