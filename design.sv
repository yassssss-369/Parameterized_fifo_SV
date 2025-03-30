module parameterized_fifo #(parameter D = 4)
  (input logic in,clk,rst,write_en,read_en,
   output logic out);
 
  
  logic arr[D-1:0]; 
  
  always_ff @(posedge clk or negedge rst) begin 
    if(!rst)begin 
      foreach(arr[i]) arr[i] <= 0;
      out <= 0;
    end
    
    else if(write_en) begin 
      
      for(int i = D - 1;i>= 0 ; i--) arr[i] <= arr[i-1];
       arr[0] <= in;
    end
    else if(read_en) begin
      out<=arr[D-1];
    end
  end

endmodule
