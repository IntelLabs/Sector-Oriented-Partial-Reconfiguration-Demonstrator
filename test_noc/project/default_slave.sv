module default_slave (
input  wire [15:0] 		avs_s0_address, 
input  wire        		avs_s0_write,       
input  wire             avs_s0_read,	    
input  wire [31:0] 		avs_s0_writedata,    
output wire	[31:0]    	avs_s0_readdata, 
output wire	[1:0]   		avs_s0_response,   
input  wire        		clk,          
input  wire        		reset  
);

logic [31:0] readdata;
logic [1:0] response;

always_ff @(posedge clk) begin
	readdata	<= 0;
end

always_ff @(posedge clk) begin
	if (!reset) begin 
		response	<= 0;
	end
	else if (avs_s0_write || avs_s0_read) begin
		response	<= 2'b10;
	end
	else begin
		response	<= 0;
	end
end

assign avs_s0_readdata = readdata;
assign avs_s0_response = response;

endmodule 