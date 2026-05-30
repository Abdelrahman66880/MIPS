module SignExtender (
    input [15:0] narrow_val,
    output [31:0] wide_val
);
    assign wide_val = {{16{narrow_val[15]}}, narrow_val};
endmodule