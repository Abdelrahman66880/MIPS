module tb_DataStore;

    parameter LOCATIONS = 256;

    reg [31:0] addr;
    reg [31:0] data_in;
    reg enable_write;
    reg CLK;
    wire [31:0] data_out;

    DataStore #(LOCATIONS) uut (
        .addr(addr),
        .data_in(data_in),
        .enable_write(enable_write),
        .CLK(CLK),
        .data_out(data_out)
    );

    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;
    end
    
    initial begin
        addr = 0;
        data_in = 0;
        enable_write = 0;

        #10; addr = 32'd4; data_in = 32'hA5A5A5A5; enable_write = 1;
        #10; enable_write = 0;

        #10; addr = 32'd4;
        #10;

        addr = 32'd8; data_in = 32'h5A5A5A5A; enable_write = 1;
        #10; enable_write = 0;

        #10; addr = 32'd8;
        #10;

        #10; addr = 32'd12;
        #10;

        #10; $stop;
    end

    initial begin 
        $monitor("Time: %0t | CLK: %b | enable_write: %b | addr: %h | data_in: %h | data_out: %h",
                 $time, CLK, enable_write, addr, data_in, data_out);
    end

endmodule