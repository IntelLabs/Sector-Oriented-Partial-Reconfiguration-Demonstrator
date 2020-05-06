module pr_control_conduit_2port (
		// interface from PIO 
		output 	wire [7:0]	in_port,
		input 	wire [7:0]	out_port,
		// interface to controller0
		input 	wire        freeze_status_0,   
		output  	wire        freeze_req_0,     
		output  	wire        unfreeze_req_0,    
		input 	wire        unfreeze_status_0, 
		output  	wire        reset_0,  
		input 	wire [1:0]  illegal_req_0,  
		// interface to controller1			  
		input 	wire        freeze_status_1,   
		output  	wire        freeze_req_1,     
		output  	wire        unfreeze_req_1,    
		input 	wire        unfreeze_status_1, 
		output  	wire        reset_1,           
		input 	wire [1:0]  illegal_req_1
		
);

//                bit7-6         bit5-4         bit3              bit2            bit1               bit0					 		
assign in_port = {illegal_req_1, illegal_req_0, freeze_status_1, freeze_status_0, unfreeze_status_1, unfreeze_status_0};

assign freeze_req_0 = out_port[0];
assign freeze_req_1 = out_port[1];

assign reset_0 = out_port[2];
assign reset_1 = out_port[3];

assign unfreeze_req_0 = out_port[4];
assign unfreeze_req_1 = out_port[5];

endmodule 
