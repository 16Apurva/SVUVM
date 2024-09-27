// Code your testbench here
// or browse Examples
`timescale 10ns/1ns
module tb_top(clk,rst,ld,updn,data,rd_data);
  
  output reg clk,rst;
  output reg ld,updn;
  output reg [3:0] data; 
  input wire [3:0]rd_data;
  
  counter cnt(.clk(clk),
              .rst(rst),
              .data(data),
              .updown(updn),
              .load(ld),
              .data_out(rd_data)
             );
 
  // Initial rest 
  initial 
    begin
      clk  = 1'b0;
      rst  = 1'b0;
      ld   = 1'b0;
      updn = 1'b0;
      data = 4'd0; 
    end
  
  //Clock generation logic
  always 
    begin
      #10 clk = ~clk;
    end
  
  // Reset generation logic
  initial 
    begin
      @(posedge clk);
      rst = 1;
      @(posedge clk);
      rst = 0;
    end
  
  //Monitor
   initial 
     begin
       $monitor($time," Monitor data_out %0d updn %0d ld %0d",rd_data,updn,ld);
     end
  
  //Testcase 
  initial
    begin
// Test 1
      $display(" TEST 1 ");
      repeat (12) begin       @(posedge clk); 
      $display($time," data_out %0d rst %0d updn %0d ld %0d",rd_data,rst,updn,ld);  
      end
// Test 2 
      $display (" TEST 2 ");
      updn = 1;
      repeat (20) begin       @(posedge clk); 
      $display($time," data_out %0d rst %0d updn %0d ld %0d",rd_data,rst,updn,ld);  
      end   
// Test 3 
      $display (" TEST 3 ");
      ld = 1'b1;
      data = 'd5;
      @(posedge clk);
      ld = 1'b0;
      repeat (5) 
        begin 
          @(posedge clk);
      $display($time," data_out %0d rst %0d updn %0d ld %0d",rd_data,rst,updn,ld);            
        end
        
      $finish();
    end
endmodule
