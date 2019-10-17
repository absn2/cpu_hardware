module setSize(
	input logic [31:0] B,
	input logic [31:0] Data,
	input logic [1:0] SSControl,
	output logic [31:0] saidaSetSize
);

always @ (*) 
	begin
		if(SSControl == 2'b01) begin // word
			for (int i = 0; i < 32; i++) begin
				saidaSetSize[i] = B[i];
			end
		end else if(SSControl == 2'b10) begin // halfword
			for (int i = 0; i < 16; i++) begin
				saidaSetSize[i] = B[i];
			end
			for (int i = 16; i < 32; i++) begin
				saidaSetSize[i] = Data[i];
			end			
		end else if(SSControl == 2'b11) begin // byte
			for (int i = 0; i < 8; i++) begin
				saidaSetSize[i] = B[i];
			end
			for (int i = 8; i < 32; i++) begin
				saidaSetSize[i] = Data[i];
			end
		end
	end
endmodule: setSize