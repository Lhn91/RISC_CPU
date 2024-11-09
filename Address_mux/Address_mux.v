module Address_mux #(
    parameter ADDR_WIDTH = 5
) (
    input wire [ADDR_WIDTH-1:0] inst_addr,
    input wire [ADDR_WIDTH-1:0] data_addr,
    input wire select_address,
    output wire [ADDR_WIDTH-1:0] out_addr
);

// Assign output based on select signal
assign out_addr = select_address ? data_addr : inst_addr;

endmodule