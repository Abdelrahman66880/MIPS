 `timescale 1ns / 1ps

module ControlSignals_tb;

    reg [5:0] instr_opcode;

    wire reg_select;
    wire branch_signal;
    wire mem_read;
    wire mem_write;
    wire mem_to_reg;
    wire alu_immediate;
    wire reg_enable;
    wire [1:0] compute_op;

    ControlSignals uut (
        .instr_opcode(instr_opcode),
        .reg_select(reg_select),
        .branch_signal(branch_signal),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .alu_immediate(alu_immediate),
        .reg_enable(reg_enable),
        .compute_op(compute_op)
    );

    initial begin
        // R-Type instruction (opcode = 6'b000000)
        instr_opcode = 6'b000000;
        #10;
        $display("R-Type: reg_select=%b, branch_signal=%b, mem_read=%b, mem_write=%b, mem_to_reg=%b, alu_immediate=%b, reg_enable=%b, compute_op=%b", 
                 reg_select, branch_signal, mem_read, mem_write, mem_to_reg, alu_immediate, reg_enable, compute_op);

        // LW (Load Word) instruction (opcode = 6'b100011)
        instr_opcode = 6'b100011;
        #10;
        $display("LW: reg_select=%b, branch_signal=%b, mem_read=%b, mem_write=%b, mem_to_reg=%b, alu_immediate=%b, reg_enable=%b, compute_op=%b", 
                 reg_select, branch_signal, mem_read, mem_write, mem_to_reg, alu_immediate, reg_enable, compute_op);

        // SW (Store Word) instruction (opcode = 6'b101011)
        instr_opcode = 6'b101011;
        #10;
        $display("SW: reg_select=%b, branch_signal=%b, mem_read=%b, mem_write=%b, mem_to_reg=%b, alu_immediate=%b, reg_enable=%b, compute_op=%b", 
                 reg_select, branch_signal, mem_read, mem_write, mem_to_reg, alu_immediate, reg_enable, compute_op);

        // BEQ (Branch on Equal) instruction (opcode = 6'b000100)
        instr_opcode = 6'b000100;
        #10;
        $display("BEQ: reg_select=%b, branch_signal=%b, mem_read=%b, mem_write=%b, mem_to_reg=%b, alu_immediate=%b, reg_enable=%b, compute_op=%b", 
                 reg_select, branch_signal, mem_read, mem_write, mem_to_reg, alu_immediate, reg_enable, compute_op);


        $finish;
    end

endmodule