module RegisterFile (
    input wire clk,
    input wire write_enable,
    input wire [4:0] src_reg1,
    input wire [4:0] src_reg2,
    input wire [4:0] dst_reg,
    input wire [31:0] write_val, 
    output wire [31:0] read_val1,
    output wire [31:0] read_val2
);

    reg [31:0] storage [31:0]; 
    
    assign read_val1 = storage[src_reg1];
    assign read_val2 = storage[src_reg2];

    always @(posedge clk) begin
        if (write_enable && dst_reg != 5'b00000) begin
            storage[dst_reg] <= write_val;
        end
    end

endmodule