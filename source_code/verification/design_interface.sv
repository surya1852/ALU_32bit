interface alu;
                logic [31:0] A;
                logic [31:0] B;
                logic [31:0] out;
                logic [4:0] opcode;
                logic carryout;

                modport alu_design (
                            input A, B,opcode, output out, carryout 
                                 );

                modport top (
                           input out, carryout, output A, B, opcode
                  );

    task print();
        begin
        
         $display("values at interface A = %h B = %h opcode = %h",A,B,opcode);
        end
    endtask : print

endinterface