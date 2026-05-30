module ControlSignals(
    input [5:0] instr_opcode,
    output reg reg_select, 
    output reg branch_signal, 
    output reg mem_read, 
    output reg mem_write, 
    output reg mem_to_reg, 
    output reg alu_immediate, 
    output reg reg_enable, 
    output reg [1:0] compute_op 
);

    always @(*) begin
        case (instr_opcode)
            6'b000000: begin
                reg_select = 1;
                branch_signal = 0;
                mem_read = 0;
                mem_write = 0;
                mem_to_reg = 0;
                alu_immediate = 0;
                reg_enable = 1;
                compute_op = 2'b10;
            end
            6'b100011: begin
                reg_select = 0;
                branch_signal = 0;
                mem_read = 1;
                mem_write = 0;
                mem_to_reg = 1;
                alu_immediate = 1;
                reg_enable = 1;
                compute_op = 2'b00;
            end
            6'b101011: begin
                reg_select = 0;
                branch_signal = 0;
                mem_read = 0;
                mem_write = 1;
                mem_to_reg = 0;
                alu_immediate = 1;
                reg_enable = 0;
                compute_op = 2'b00;
            end
            6'b000100: begin
                reg_select = 0;
                branch_signal = 1;
                mem_read = 0;
                mem_write = 0;
                mem_to_reg = 0;
                alu_immediate = 0;
                reg_enable = 0;
                compute_op = 2'b01;
            end
            default: begin
                reg_select = 0;
                branch_signal = 0;
                mem_read = 0;
                mem_write = 0;
                mem_to_reg = 0;
                alu_immediate = 0;
                reg_enable = 0;
                compute_op = 2'b00;
            end
        endcase
    end
endmodule