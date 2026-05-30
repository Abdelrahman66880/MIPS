module ComputeControl(
    input [1:0] op_selector,
    input [5:0] funct_bits,
    output reg [3:0] compute_cmd
);

    always @(*) begin
        case (op_selector)
            2'b00: compute_cmd = 4'b0010;
            2'b01: compute_cmd = 4'b0110;
            2'b10: begin
                case (funct_bits)
                    6'b100000: compute_cmd = 4'b0010;
                    6'b100010: compute_cmd = 4'b0110;
                    6'b100100: compute_cmd = 4'b0000;
                    6'b100101: compute_cmd = 4'b0001;
                    6'b101010: compute_cmd = 4'b0111;
                    default:   compute_cmd = 4'b1111;
                endcase
            end
            default: compute_cmd = 4'b1111;
        endcase
    end
endmodule