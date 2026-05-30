module InstructionMemory (
    input [31:0] fetch_addr,
    output [31:0] instr_word
);

    reg [31:0] progmem [0:127];

    initial begin
        progmem[0] = 32'h20020005; // addi $2, $0, 5
        progmem[1] = 32'h2003000c; // addi $3, $0, 12
        progmem[2] = 32'h20670009; // addi $7, $3, 9
        progmem[3] = 32'h00e22025; // or $4, $7, $2
        progmem[4] = 32'h00642824; // and $5, $3, $4
        progmem[5] = 32'h00a42820; // add $5, $5, $4
        progmem[6] = 32'h10a70008; // beq $5, $7, end
        progmem[7] = 32'h0064202a; // slt $4, $3, $4
        progmem[8] = 32'h10800001; // beq $4, $0, around
        progmem[9] = 32'h20050000; // addi $5, $0, 0
        progmem[10] = 32'h00e2202a; // slt $4, $7, $2
        progmem[11] = 32'h00853820; // add $7, $4, $5
        progmem[12] = 32'h00e23822; // sub $7, $7, $2
        progmem[13] = 32'hac670044; // sw $7, 68($3)
        progmem[14] = 32'h8c020050; // lw $2, 80($0)
        progmem[15] = 32'hac020054; // sw $2, 84($0)
    end

    assign instr_word = progmem[fetch_addr[31:2]];
endmodule
