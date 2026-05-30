module testbench();
    reg clk;
    reg reset;
    wire [31:0] store_data, mem_addr;
    wire mem_store_en;

    ProcessorCore dut (
        .clk(clk),
        .reset(reset),
        .store_data(store_data),
        .mem_addr(mem_addr),
        .mem_store_en(mem_store_en)
    );
initial begin
  reset <= 1; #22;
  reset <= 0;
  $display("\t\t time \tmem_addr\t\tstore_data");
  $monitor("%d\t%d\t%d", $time, mem_addr, store_data);
end
always begin
  clk <= 1; #5;
  clk <= 0; #5;
end
always @(negedge clk) begin
  if(mem_store_en) begin
    if(mem_addr === 84 & store_data === -5) begin
      $display("Simulation succeeded");
      $stop;
    end
  end
end
endmodule

