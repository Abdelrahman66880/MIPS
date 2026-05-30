`timescale 1ns / 1ps

module RegisterFile_tb;

    reg clk;
    reg write_enable; 
    reg [4:0] src_reg1;
    reg [4:0] src_reg2;
    reg [4:0] dst_reg;
    reg [31:0] write_val;

    wire [31:0] read_val1;
    wire [31:0] read_val2;

    RegisterFile uut (
        .clk(clk),
        .write_enable(write_enable),
        .src_reg1(src_reg1),
        .src_reg2(src_reg2),
        .dst_reg(dst_reg),
        .write_val(write_val),
        .read_val1(read_val1),
        .read_val2(read_val2)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        write_enable = 0;
        src_reg1 = 0;
        src_reg2 = 0;
        dst_reg = 0;
        write_val = 0;

        // Test case 1: Write and read from a register
        
        #10;
        
        write_enable = 1;           
        dst_reg = 5'd1;  
        write_val = 32'hA5A5A5A5; 
        
        #10;
        
        write_enable = 0;           
        src_reg1 = 5'd1;  
        #10;

        // Test case 2: Write and read from a different register
        write_enable = 1;
        dst_reg = 5'd2;  
        write_val = 32'h5A5A5A5A; 
        
        #10;
        
        write_enable = 0;
        src_reg2 = 5'd2;  
        
        #10;

        // Test case 3: Ensure writing to $zero (register 0) is ignored
        write_enable = 1;
        dst_reg = 5'd0;  
        write_val = 32'hFFFFFFFF; 
        
        #10;
        
        write_enable = 0;
        src_reg1 = 5'd0;  
        
        #10;

        // Test case 4: Simultaneously read from two different registers
        src_reg1 = 5'd1;  
        src_reg2 = 5'd2;  
        
        #10;

        $finish;
    end

endmodule