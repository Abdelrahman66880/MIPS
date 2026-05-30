module DataStore 
    #(parameter SIZE = 256) 
    (
        input wire [31:0] addr,
        input wire [31:0] data_in,
        input wire enable_write,
        input wire CLK,
        output wire [31:0] data_out
    );

    reg [31:0] store [0:SIZE-1];

    // Combinational read
    assign data_out = store[addr[9:0]];

    // Sequential write
    always @(posedge CLK) begin
        if (enable_write) begin
            store[addr[9:0]] <= data_in;
        end
    end

endmodule
