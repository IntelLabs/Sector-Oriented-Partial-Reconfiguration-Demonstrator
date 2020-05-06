// security_filter.v
// Translate write to sector address to write to AVMM address

module security_filter 

#(
parameter DROP_ADDR = 'hffff, parameter S0_ADDR = 'h0000, parameter S1_ADDR = 'h0000,
parameter S2_ADDR = 'h0000, parameter S3_ADDR = 'h0000, parameter S4_ADDR = 'h0000,
parameter S5_ADDR = 'h0000, parameter S6_ADDR = 'h0000, parameter S7_ADDR = 'h0000,
parameter S8_ADDR = 'h0000, parameter DATA_SIZE = 32, parameter AVMM_ADDR_SIZE = 16
)

(
// ports to access csr                                   			
input 	wire                    avl_csr_write,
input 	wire                    avl_csr_read,
input 	wire                    avl_csr_addr,
input 	wire  [DATA_SIZE-1:0]    avl_csr_wrdata,
output 	reg   [DATA_SIZE-1:0]    avl_csr_rddata,

input  wire [AVMM_ADDR_SIZE-1:0] 	avs_s0_address,     // .address
input  wire        			avs_s0_write,       //       .write
input  wire [DATA_SIZE-1:0] 	avs_s0_writedata,   //       .writedata
output wire        		avs_s0_waitrequest, //       .waitrequest
input  wire        		clock_clk,          //  clock.clk
input  wire        		reset_reset,        //  reset.reset
output wire [AVMM_ADDR_SIZE-1:0]avm_m0_address,     // avm_m0.address
input  wire        		avm_m0_waitrequest, //       .waitrequest
output wire        		avm_m0_write,       //       .write.
output wire [DATA_SIZE-1:0] 	avm_m0_writedata    //       .writedata
);

localparam NSECTORS = 9;

wire [AVMM_ADDR_SIZE-1:0] translation_table [0:NSECTORS-1];
wire 			  write_csr_ctrl, read_csr_ctrl;
wire [DATA_SIZE-1:0]      csr_rddata_combi;
reg [NSECTORS-1:0]	  enable_filter;

reg [DATA_SIZE-1:0]          cmd_writedata;
reg [AVMM_ADDR_SIZE-1:0]     cmd_address; 
reg                          cmd_write;  
reg                          cmd_waitrequest;

reg [DATA_SIZE-1:0]          wr_writedata;
reg [AVMM_ADDR_SIZE-1:0]     wr_address; 
reg                          wr_write;  

reg [DATA_SIZE-1:0]          wr_reg_writedata;
reg [AVMM_ADDR_SIZE-1:0]     wr_reg_address; 
reg                          wr_reg_write;  
reg                          wr_reg_waitrequest;
reg 			     no_command;
reg                          use_reg;
reg                          wait_rise;

assign write_csr_ctrl 	 = avl_csr_write & (avl_csr_addr == 2'b00);
assign read_csr_ctrl     = avl_csr_read & (avl_csr_addr == 2'b00);
assign csr_rddata_combi  = {{23{1'b0}}, enable_filter};

always_ff @(posedge clock_clk) begin
  if (!reset_reset) begin
        enable_filter <= {NSECTORS{1'b0}};
  end
  else begin
	if (write_csr_ctrl) begin
     		enable_filter[0] <= avl_csr_wrdata[0];
		enable_filter[1] <= avl_csr_wrdata[1];
		enable_filter[2] <= avl_csr_wrdata[2];
		enable_filter[3] <= avl_csr_wrdata[3];
		enable_filter[4] <= avl_csr_wrdata[4];
		enable_filter[5] <= avl_csr_wrdata[5];
		enable_filter[6] <= avl_csr_wrdata[6];
		enable_filter[7] <= avl_csr_wrdata[7];
		enable_filter[8] <= avl_csr_wrdata[8];
	end
  end
end

assign translation_table[0] = (enable_filter[0])? DROP_ADDR : S0_ADDR; 
assign translation_table[1] = (enable_filter[1])? DROP_ADDR : S1_ADDR; 
assign translation_table[2] = (enable_filter[2])? DROP_ADDR : S2_ADDR; 
assign translation_table[3] = (enable_filter[3])? DROP_ADDR : S3_ADDR; 
assign translation_table[4] = (enable_filter[4])? DROP_ADDR : S4_ADDR; 
assign translation_table[5] = (enable_filter[5])? DROP_ADDR : S5_ADDR; 
assign translation_table[6] = (enable_filter[6])? DROP_ADDR : S6_ADDR; 
assign translation_table[7] = (enable_filter[7])? DROP_ADDR : S7_ADDR; 
assign translation_table[8] = (enable_filter[8])? DROP_ADDR : S8_ADDR; 

assign no_command      = ~cmd_write;
assign cmd_waitrequest = avm_m0_waitrequest & ~no_command;
assign wait_rise = ~wr_reg_waitrequest & cmd_waitrequest;

always_ff @(posedge clock_clk) begin
    if (!reset_reset) begin
        avl_csr_rddata         <= {32{1'b0}};
    end
    else begin
        avl_csr_rddata         <= csr_rddata_combi;
    end
end

always_ff @(posedge clock_clk) begin
	if (wait_rise) begin
		wr_reg_writedata  <= avs_s0_writedata;
		wr_reg_address    <= avs_s0_address;
	end
end

always_ff @(posedge clock_clk) begin
	if (!reset_reset) begin
		wr_reg_waitrequest <= 1'b1;                    
		use_reg            <= 1'b1;
		wr_reg_write       <= 1'b0;
	end 
	else begin
		wr_reg_waitrequest <= cmd_waitrequest;
		
		if (wait_rise) begin
			wr_reg_write      <= avs_s0_write;
		end
		
		// stop using the buffer when waitrequest is low
		if (~cmd_waitrequest)
			 use_reg <= 1'b0;
		else if (wait_rise) begin
			use_reg <= 1'b1;
		end     
		
	end
end
		
always_comb begin
	wr_writedata   =  avs_s0_writedata;
	wr_address     =  avs_s0_address;
	wr_write       =  avs_s0_write;
	
	if (use_reg) begin //pipeline signals when waitrequest is high
		 wr_writedata   =  wr_reg_writedata;
		 wr_address     =  wr_reg_address;
		 wr_write       =  wr_reg_write;
	end
end

always_ff @(posedge clock_clk) begin
	if (~cmd_waitrequest) begin
		cmd_writedata  <= wr_writedata;
		if (avs_s0_address <= NSECTORS-1) begin
			cmd_address    <= translation_table[avs_s0_address];
		end 
	end
end

always_ff @(posedge clock_clk) begin
	if (!reset_reset) begin
		cmd_write      <= 1'b0;
	end
	else if (~cmd_waitrequest) begin
		if ((avs_s0_address > NSECTORS-1) || (translation_table[avs_s0_address] == DROP_ADDR)) begin //address not authorized
			cmd_write      <= 1'b0;
		end
		else begin
			cmd_write      <= wr_write;
		end
	end
end
		 
assign avm_m0_writedata     = cmd_writedata;
assign avm_m0_address       = cmd_address;
assign avm_m0_write         = cmd_write;
assign avs_s0_waitrequest   = wr_reg_waitrequest;

endmodule
