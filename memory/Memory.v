// stores program instructions ( used 32 bit cells )
`include "constants.v"
module Memory(clock, AddressBus, DataIn, sig_enable_data_memory_write, DataOut,sig_enable_data_memory_read);

    // ----------------- INPUTS -----------------

    // clock
    input wire clock;

    // address bus
    input wire [4:0] AddressBus; //5 bit address

    input wire [1:0] sig_enable_data_memory_write;
    input wire [7:0] DataIn;

    input wire [1:0] sig_enable_data_memory_read;
    // ----------------- OUTPUTS -----------------
    output reg DataOut[7:0] ; //8 bit data (instruction or data)

    // ----------------- INTERNALS -----------------

    // instruction memory
    reg [7:0] Memory [0:31]; //mem size 32 block, each block has 8 bit data

    // ----------------- INITIALIZATION -----------------

    initial begin
        // load instructions from file
        //$readmemh("instructions.txt", instruction_memory);
        // initial
        instruction_memory[0] = 8'b0;
        instruction_memory[1] = 8'b110_00001;
        instruction_memory[2] = 8'bx;
        instruction_memory[3] = 8'bx;
        //.....
        instruction_memory[31] = 8'b000_00011;
    end

    always @(posedge clk) begin
        if (sig_enable_data_memory_write)begin
            Memory[AddressBus[4:0]] <= DataIn;
        end
        else if(sig_enable_data_memory_read)begin
            DataOut <= Memory[AddressBus[4:0]];
        end

    end
endmodule