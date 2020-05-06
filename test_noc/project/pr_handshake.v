module pr_handshake
   (
      input wire         	clk , 
		//pr_handshake1
	   input wire           pr_handshake_start_req ,
		output reg           pr_handshake_start_ack ,
		input wire           pr_handshake_stop_req ,
		output reg           pr_handshake_stop_ack ,
		//pr_handshake2
		input wire           pr_handshake_start_req_1 ,
		output reg           pr_handshake_start_ack_1 ,
		input wire           pr_handshake_stop_req_1 ,
		output reg           pr_handshake_stop_ack_1 ,
		//pr_handshake3
		input wire           pr_handshake_start_req_2 ,
		output reg           pr_handshake_start_ack_2 ,
		input wire           pr_handshake_stop_req_2 ,
		output reg           pr_handshake_stop_ack_2 ,
		//pr_handshake4
		input wire           pr_handshake_start_req_3 ,
		output reg           pr_handshake_start_ack_3 ,
		input wire           pr_handshake_stop_req_3 ,
		output reg           pr_handshake_stop_ack_3 
		);
		
always @(posedge clk) begin
	pr_handshake_start_ack <=1'b0;
	pr_handshake_stop_ack <=1'b0;
	if (  pr_handshake_start_req == 1'b0 ) begin
		pr_handshake_start_ack <= 1'b1;
	end
	// Active high SW reset
	if (  pr_handshake_stop_req == 1'b1 ) begin
		pr_handshake_stop_ack <=1'b1;
	end
end

always @(posedge clk) begin
	pr_handshake_start_ack_1 <=1'b0;
	pr_handshake_stop_ack_1 <=1'b0;
	if (  pr_handshake_start_req_1 == 1'b0 ) begin
		pr_handshake_start_ack_1 <= 1'b1;
	end
	// Active high SW reset
	if (  pr_handshake_stop_req_1 == 1'b1 ) begin
		pr_handshake_stop_ack_1 <=1'b1;
	end
end

always @(posedge clk) begin
	pr_handshake_start_ack_2 <=1'b0;
	pr_handshake_stop_ack_2 <=1'b0;
	if (  pr_handshake_start_req_2 == 1'b0 ) begin
		pr_handshake_start_ack_2 <= 1'b1;
	end
	// Active high SW reset
	if (  pr_handshake_stop_req_2 == 1'b1 ) begin
		pr_handshake_stop_ack_2 <=1'b1;
	end
end

always @(posedge clk) begin
	pr_handshake_start_ack_3 <=1'b0;
	pr_handshake_stop_ack_3 <=1'b0;
	if (  pr_handshake_start_req_3 == 1'b0 ) begin
		pr_handshake_start_ack_3 <= 1'b1;
	end
	// Active high SW reset
	if (  pr_handshake_stop_req_3 == 1'b1 ) begin
		pr_handshake_stop_ack_3 <=1'b1;
	end
end

endmodule 