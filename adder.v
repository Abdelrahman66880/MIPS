module SumUnit (
    input [31:0] val_a,
    input [31:0] val_b,
    output [31:0] result
);
    assign result = val_a + val_b;
endmodule