`include "constants.v"
module instruction_resgister(clock, Reset, DataIn, DataOut,);
    // ----------------- INPUTS -----------------
    input wire [1:0] Reset;
    input wire [7:0] DataIn;
        // clock
    input wire clock;
    // ----------------- OUTPUTS -----------------
    output reg [2:0] OpCode;
    output reg [4:0] DataOut;
    // ----------------- INTERNALS -----------------
    always @(posedge clk or posedge reset) begin
        case (Reset) 
            `RESET:
                begin
                    OpCode <= 3'b0;
                    DataOut <= 5'b0;
                end 
            `UNRESET:
                begin
                    OpCode <= DataIn[7:5];
                    DataOut <= DataIn[4:0];
                end
        end
    end

endmodule




