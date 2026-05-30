module AddressCounter (
    input clk,
    input [31:0] next_addr,
    output reg [31:0] curr_addr
);
    always @(posedge clk) begin
        curr_addr <= next_addr;
    end
endmodule