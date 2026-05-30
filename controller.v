module CommandDecoder(
    input [5:0] InstructionCode,     
    output reg dst_reg_sel,      
    output reg branch_take,      
    output reg load_mem,     
    output reg to_mem_reg,    
    output reg [1:0] compute_op, 
    output reg write_mem,    
    output reg src_immed,      
    output reg write_reg     
    );

always @(*) begin
    dst_reg_sel = 0;
    branch_take = 0;
    load_mem = 0;
    to_mem_reg = 0;
    compute_op = 2'b00;
    write_mem = 0;
    src_immed = 0;
    write_reg = 0;
    case (InstructionCode)
        6'b000000: begin // R-Type
            dst_reg_sel = 1;
            write_reg = 1;
            compute_op = 2'b10;
        end
        6'b100011: begin // lw
            src_immed = 1;
            to_mem_reg = 1;
            write_reg = 1;
            load_mem = 1;
        end
        6'b101011: begin // sw 
            src_immed = 1;
            write_mem = 1;
        end
        6'b000100: begin // beq 
            branch_take = 1;
            compute_op = 2'b01;
        end
        6'b001000: begin // addi 
            src_immed = 1;
            write_reg = 1;
        end
        default: begin
        end
    endcase
end

endmodule