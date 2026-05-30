`timescale 1ns / 1ps

module tb_ComputeUnit;

    parameter Bitwidth = 32;
    reg [Bitwidth-1:0] operand_x;
    reg [Bitwidth-1:0] operand_y;
    reg [3:0] operation_code;

    wire [Bitwidth-1:0] result_value;
    wire is_zero;

    ComputeUnit #(Bitwidth) uut (
        .operand_x(operand_x),
        .operand_y(operand_y),
        .operation_code(operation_code),
        .result_value(result_value),
        .is_zero(is_zero)
    );
    initial begin
        operand_x = 0; operand_y = 0; operation_code = 4'b0000;

        // AND
        #10; operand_x = 32'hF0F0F0FF; operand_y = 32'h0F0F0F0F; operation_code = 4'b0000; //0000000F
        #10; operand_x = 32'hFFFFFFFF; operand_y = 32'h00000000; operation_code = 4'b0000; //00000000, Z flag = 1

        // OR
        #10; operand_x = 32'hF0F0F0F0; operand_y = 32'h0F0F0F0F; operation_code = 4'b0001;

        // ADD
        #10; operand_x = 32'h00000010; operand_y = 32'h00000020; operation_code = 4'b0010;
        #10; operand_x = 32'hFFFFFFFF; operand_y = 32'h00000001; operation_code = 4'b0010; //(wrap around)

        // SUBTRACT
        #10; operand_x = 32'h00000020; operand_y = 32'h00000010; operation_code = 4'b0110;
        #10; operand_x = 32'h00000010; operand_y = 32'h00000020; operation_code = 4'b0110; //(negative result)

        // LESS-THAN SLT
        #10; operand_x = 32'h00000010; operand_y = 32'h00000020; operation_code = 4'b0111;
        #10; operand_x = 32'h00000020; operand_y = 32'h00000010; operation_code = 4'b0111;

        // NOR
        #10; operand_x = 32'hF0F0F0F0; operand_y = 32'h0F0F0F0F; operation_code = 4'b1100;

        // Default Case
        #10; operation_code = 4'b1111; // Undefined operation

        // Stop simulation
        #10; $stop;
    end

    // Monitor the output
    initial begin
        $display("Code Start");
        $monitor("Time: %0t | operand_x: %h | operand_y: %h | operation_code: %b | result_value: %h | is_zero: %b", 
                 $time, operand_x, operand_y, operation_code, result_value, is_zero);
    end

endmodule
