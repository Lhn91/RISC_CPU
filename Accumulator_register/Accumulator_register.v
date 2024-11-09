module accumulator_register(
    input wire clk,
    input wire [7:0] alu_result,
    input wire [7:0] memory_data,
    input wire sig_mem_to_acc,
    input wire sig_alu_to_acc,
    output reg [7:0] accumulator
);

always @(posedge clk) begin
    if(sig_alu_to_acc)       
            accumulator <= alu_result;
    else if(sig_mem_to_acc) 
            accumulator <= memory_data;
    endcase
end
endmodule