module tb;
  parameter D = 4;
  logic in, clk, rst, out, write_en, read_en;
  
  // Instantiate FIFO using named port mapping
  parameterized_fifo #(D) uut (
    .clk(clk),
    .rst(rst),
    .in(in),
    .out(out),
    .write_en(write_en),
    .read_en(read_en)
  );

  // Clock generation (T = 10ns, f = 100MHz)
  always #5 clk = !clk;
  
  initial begin
    // Initialize signals
    clk = 0;
    rst = 0;
    in = 0;
    write_en = 0;
    read_en = 0;

    // Dump simulation data
    $dumpfile("dump.vcd");
    $dumpvars(1, clk,rst,in,write_en,read_en,out,uut.arr[0], uut.arr[1], uut.arr[2], uut.arr[3]);

    // Reset sequence
    #5 rst = 1; 

    // Write data into FIFO
    #10 write_en = 1;
    #10 in = 1;
    #10 in = 0;
    #10 in = 1;
    #10 in = 1;
    #10 in = 0;
    #10 write_en = 0;  // Stop writing

    // Read from FIFO
    #20 read_en = 1;
    #10 read_en = 0;
//     #10 write_en = 1;
//     #10 in = 1;
//      #10 write_en = 0;
//     #20 read_en = 1;
//     #10 read_en = 0;
    

    // Finish simulation
    #50 $finish;
  end

endmodule
