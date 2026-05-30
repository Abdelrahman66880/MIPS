module ProcessorCore(
    input clk,
    input reset,
    output [31:0] store_data,
    output [31:0] mem_addr,
    output mem_store_en
);

    wire [31:0] pc_val, fetched_instr, mem_read_val;
    wire [31:0] alu_out, operand_b, operand_a;
    wire [3:0] compute_op_code;
    wire sel_alu_imm, sel_mem_data, sel_reg_dest, reg_wr_en, mem_rd_en, mem_wr_en_int, branch_en;
    wire [1:0] compute_sel;
    wire is_equal, branch_take;

    AddressCounter pc_unit(
        .clk(clk),
        .next_addr(branch_take ? (pc_val + {{14{fetched_instr[15]}}, fetched_instr[15:0], 2'b00}) : (pc_val + 4)),
        .curr_addr(pc_val)
    );

    InstructionMemory instr_mem(
        .fetch_addr(pc_val),
        .instr_word(fetched_instr)
    );

    ControlSignals decoder(
        .instr_opcode(fetched_instr[31:26]),
        .reg_select(sel_reg_dest),
        .branch_signal(branch_en),
        .mem_read(mem_rd_en),
        .mem_to_reg(sel_mem_data),
        .compute_op(compute_sel),
        .mem_write(mem_wr_en_int),
        .alu_immediate(sel_alu_imm),
        .reg_enable(reg_wr_en)
    );

    RegisterFile regfile(
        .clk(clk),
        .write_enable(reg_wr_en),
        .src_reg1(fetched_instr[25:21]),
        .src_reg2(fetched_instr[20:16]),
        .dst_reg(sel_reg_dest ? fetched_instr[15:11] : fetched_instr[20:16]),
        .write_val(sel_mem_data ? mem_read_val : alu_out),
        .read_val1(operand_a),
        .read_val2(operand_b)
    );

    SignExtender sign_ext(
        .narrow_val(fetched_instr[15:0]),
        .wide_val(operand_b)
    );

    ComputeUnit alu_unit(
        .operand_x(operand_a),
        .operand_y(sel_alu_imm ? operand_b : operand_a),
        .operation_code(compute_op_code),
        .result_value(alu_out),
        .is_zero(is_equal)
    );

    ComputeControl alu_ctrl(
        .op_selector(compute_sel),
        .funct_bits(fetched_instr[5:0]),
        .compute_cmd(compute_op_code)
    );

    DataStore data_mem(
        .addr(alu_out),
        .data_in(operand_b),
        .enable_write(mem_wr_en_int),
        .CLK(clk),
        .data_out(mem_read_val)
    );

    assign branch_take = branch_en & is_equal;
    assign mem_addr = alu_out;
    assign store_data = operand_b;
    assign mem_store_en = mem_wr_en_int;

endmodule
