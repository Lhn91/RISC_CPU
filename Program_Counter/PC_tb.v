`timescale 1ns / 1ns
`include "PC.v"
`include "clock_generator.v"
`include "constants.v"
module PC_tb ();
    // ----------------- CLOCK -----------------
    
    // clock generator wires/registers
	wire clock;

	// generates clock square wave with 10ns period
	ClockGenerator clock_generator(clock);

    // ----------------- PC Module Ports -----------------
 
    // register file wires/registers
    reg  [1:0] sig_pc_src = `PC_Src_Dft;
    reg  [4:0] J_TypeImmediate;
    reg  [1:0] Reset = `UNRESET;
    wire [4:0] PC;
    
    pcModule pcModule(clock, sig_pc_src, J_TypeImmediate, Reset, PC );
    
    // ----------------- Simulation -----------------

    initial begin
    $dumpfile("PC_tb.vcd");
    $dumpvars(0, PC_tb);
        // test the pc module by using different inputs and checking if the outputs are correct
        #0
        $display("(%0t) > PC=%0d", $time, PC);
        sig_pc_src <= `PC_Src_Dft; // PC source default

        #10
        $display("(%0t) > PC=%0d", $time, PC);
        sig_pc_src <= `PC_Src_Jmp; // PC source default
        J_TypeImmediate <= 5'd10; // add 10 to PC

        #10
        $display("(%0t) > PC=%0d", $time, PC);
        sig_pc_src <= `PC_Src_Skip; // PC source default
        J_TypeImmediate <= 5'd20; // subtract 10 from PC
        
        #10
        // results of previouse cycle
        $display("(%0t) > PC=%0d", $time, PC);
        Reset = `RESET; //RESET
        sig_pc_src <= `PC_Src_Dft; // PC source default

        #10
        // results of previouse cycle
        $display("(%0t) > PC=%0d", $time, PC);
        Reset = `UNRESET;
        sig_pc_src <= `PC_Src_Dft; // PC source default

        #10
        // results of previouse cycle
        $display("(%0t) > PC=%0d", $time, PC);
        sig_pc_src <= `PC_Src_Skip; // PC source skip

        
        #10
        // results of previouse cycle
        $display("(%0t) > PC=%0d", $time, PC);
        sig_pc_src <= `PC_Src_Dft; // PC source default

        #20 $finish;    // 100 cycle
        $display("Test complete");
    end

endmodule