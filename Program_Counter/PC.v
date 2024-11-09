// PC register and its logic

// PC src can be one of the following:
// 1- PC + 4
// 2- Branch target address (if instruction is I-Type & function is BEQ and zero flag is 1)
// 3- Jump target address (if instruction is J-Type: J, JAL)
// 4- link return address (if stop bit is set)
`include "constants.v"
module pcModule(clock, sig_pc_src, J_TypeImmediate, Reset, PC );
    // ----------------- INPUTS -----------------
    // clock
    input wire clock;
    // PC source signal
    input wire [1:0] sig_pc_src;
    // J-Type immediate bus
    input wire [4:0] J_TypeImmediate;
    // RESET
    input wire [1:0] Reset;
    // ----------------- OUTPUTS -----------------
    // PC
    output reg [4:0] PC;

    // ----------------- INTERNALS -----------------
    // PC + 1
    wire [4:0] pc_plus_1;
    // PC + 2
    wire [4:0] pc_plus_2;
    // JTA
    wire [4:0] jump_target_address;

    assign pc_plus_1 = PC + 5'd1;
    assign pc_plus_2 = PC + 5'd2;
    assign jump_target_address = J_TypeImmediate;

    initial begin
		PC <= 4'd0;
	end

    always @(posedge clock) begin
        case(Reset)
            `RESET:
                PC <= 4'd0;
            `UNRESET:
                case (sig_pc_src)
                    `PC_Src_Dft: begin
                        // default      : PC = PC + 1
                        PC = pc_plus_1;    
                    end  
                    `PC_Src_Skip: begin
                        //skip          : PC = PC + 2 
                        PC = pc_plus_2;
                    end
                    `PC_Src_Jmp: begin
                        // Jump         : PC = J_TypeImmediate
                        PC = jump_target_address;
                    end  

                endcase
        endcase
	end

endmodule