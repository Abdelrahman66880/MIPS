module ComputeControl_tb;

    reg [1:0] op_selector;
    reg [5:0] funct_bits;
    wire [3:0] compute_cmd;

    ComputeControl uut (
        .op_selector(op_selector),
        .funct_bits(funct_bits),
        .compute_cmd(compute_cmd)
    );

    initial begin
        // Test LW/SW
        op_selector = 2'b00; funct_bits = 6'bXXXXXX;
        #10 $display("LW/SW: compute_cmd = %b", compute_cmd);

        // Test BEQ
        op_selector = 2'b01; funct_bits = 6'bXXXXXX;
        #10 $display("BEQ: compute_cmd = %b", compute_cmd);

        // Test R-Type: Add
        op_selector = 2'b10; funct_bits = 6'b100000;
        #10 $display("R-Type Add: compute_cmd = %b", compute_cmd);

        // Test R-Type: Subtract
        op_selector = 2'b10; funct_bits = 6'b100010;
        #10 $display("R-Type Subtract: compute_cmd = %b", compute_cmd);

        // Test R-Type: AND
        op_selector = 2'b10; funct_bits = 6'b100100;
        #10 $display("R-Type AND: compute_cmd = %b", compute_cmd);

        // Test R-Type: OR
        op_selector = 2'b10; funct_bits = 6'b100101;
        #10 $display("R-Type OR: compute_cmd = %b", compute_cmd);

        // Test R-Type: Set on Less Than
        op_selector = 2'b10; funct_bits = 6'b101010;
        #10 $display("R-Type SLT: compute_cmd = %b", compute_cmd);

        $stop;
    end
endmodule