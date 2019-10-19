module setSize(
	input logic [31:0] B,
	input logic [31:0] Data,
	input logic [1:0] SSControl,
	output logic [31:0] saidaSetSize
);

always @ (*) 
	begin
		if(SSControl == 2'b01) begin // word
			saidaSetSize = B;
		end 
		else if(SSControl == 2'b10) begin // halfword
			saidaSetSize = {Data[31:16],B[15:0]};
		end 
		else if(SSControl == 2'b11) begin // byte
			saidaSetSize = {Data[31:8],B[7:0]};
		end
	end
endmodule: setSize