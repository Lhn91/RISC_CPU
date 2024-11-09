module ALU(sig_mem_to_alu, sig_acc_to_alu, inA, inB, Result, isZero, );
// ----------------- INPUTS -----------------
    input wire [2:0] opcode;
    input wire [7:0] inA;
    input wire [7:0] inB;
// ----------------- OUTPUTS -----------------
    output reg  [7:0] result;
    output reg        isZero;
// ... Các mạch con (adder, subtractor, ...)

always @(*) begin
    case(opcode)
        3'b010: result = inA + inB; // ADD
        3'b011: result = inA & inB; // AND
        3'b100: result = inA ^ inB; // XOR
        default: result = 8'b0;
    endcase
    is_zero = (result == 8'b0);
end

endmodule