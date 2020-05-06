module s1_user_logic_wrapper
   (
      input wire         clk , 
      input wire         rst , 
      // AVMM interface
      input wire           avmm_master_waitrequest , 
      input wire [31:0]    avmm_master_readdata , 
      input wire           avmm_master_readdatavalid , 
      output reg [31:0]    avmm_master_writedata , 
      output reg [19:0]    avmm_master_address , 
      output reg           avmm_master_write , 
      output reg           avmm_master_read 
   );

	user1 pr_logic
   (
      .avmm_master_waitrequest		(avmm_master_waitrequest),   
		.avmm_master_readdata			(avmm_master_readdata),      
		.avmm_master_readdatavalid		(avmm_master_readdatavalid), 
		.avmm_master_burstcount			(),    
		.avmm_master_writedata			(avmm_master_writedata),     
		.avmm_master_address				(avmm_master_address),       
		.avmm_master_write				(avmm_master_write),        
		.avmm_master_read					(avmm_master_read),          
		.avmm_master_byteenable			(),    
		.avmm_master_debugaccess		(),   
		.clk_clk								(clk),                   
		.reset_reset						(rst)
   );
	
endmodule
