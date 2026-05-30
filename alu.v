module ComputeUnit #(
    parameter Bitwidth = 32
)(
    input [Bitwidth-1:0] operand_x,
    input [Bitwidth-1:0] operand_y,
    input [3:0] operation_code,
    output reg [Bitwidth-1:0] result_value,
    output is_zero
);

    assign is_zero = (result_value == {Bitwidth{1'b0}});

    always @(*) begin
        case (operation_code)
            4'b0000: result_value = operand_x & operand_y;
            4'b0001: result_value = operand_x | operand_y;
            4'b0010: result_value = operand_x + operand_y;
            4'b0110: result_value = operand_x - operand_y;
            4'b0111: result_value = (operand_x < operand_y) ? 1 : 0;
            4'b1100: result_value = ~(operand_x | operand_y);
            default: result_value = {Bitwidth{1'b0}};
        endcase
    end
endmodule