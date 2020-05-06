module pr_control_conduit (
		// interface from PIO 
		output 	wire [15:0]	in_port,
		input 	wire [15:0]	out_port,
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
		input 	wire [1:0]  illegal_req_1,
		// interface to controller2
		input 	wire        freeze_status_2,   
		output  	wire        freeze_req_2,     
		output  	wire        unfreeze_req_2,    
		input 	wire        unfreeze_status_2, 
		output  	wire        reset_2,           
		input 	wire [1:0]  illegal_req_2, 
		// interface to controller3
		input 	wire        freeze_status_3,   
		output  	wire        freeze_req_3,     
		output  	wire        unfreeze_req_3,    
		input 	wire        unfreeze_status_3, 
		output  	wire        reset_3,           
		input 	wire [1:0]  illegal_req_3    		
);

//                bit15-14       bit13-12       bit11-10       bit9-8         bit7             bit6             bit5             bit4             bit3               bit2               bit1               bit0					 		
assign in_port = {illegal_req_3, illegal_req_2, illegal_req_1, illegal_req_0, freeze_status_3, freeze_status_2, freeze_status_1, freeze_status_0, unfreeze_status_3, unfreeze_status_2, unfreeze_status_1, unfreeze_status_0};

assign freeze_req_0 = out_port[0];
assign freeze_req_1 = out_port[1];
assign freeze_req_2 = out_port[2];
assign freeze_req_3 = out_port[3];

assign reset_0 = out_port[4];
assign reset_1 = out_port[5];
assign reset_2 = out_port[6];
assign reset_3 = out_port[7];

assign unfreeze_req_0 = out_port[8];
assign unfreeze_req_1 = out_port[9];
assign unfreeze_req_2 = out_port[10];
assign unfreeze_req_3 = out_port[11];

endmodule 
