module memToReg(
	input logic [31:0] Saida,//0
	input logic [31:0] lsOut,//1
	input logic [31:0] hiOut,//2
	input logic [31:0] loOut,//3
	input logic [31:0] ltOut, // 4 esta � a sa�da que vem do LT da ULA e que passa pelo sign extend 1:32
	input logic [31:0] inst31_0, // 5
	input logic [31:0] e6, 
	input logic [31:0] e7,
	input logic [31:0] e8,
	output logic [31:0] memToRegOut,
	input logic [3:0]memToRegmux
);

parameter  e9 = 32'd227;



always
	case(memToRegmux)
		4'b0000: memToRegOut = Saida;
		4'b0001: memToRegOut = lsOut;
		4'b0010: memToRegOut = hiOut;
		4'b0011: memToRegOut = loOut;
		4'b0100: memToRegOut = ltOut;
		4'b0101: memToRegOut = inst31_0;
		4'b0110: memToRegOut = e6;
		4'b0111: memToRegOut = e7;
		4'b1000: memToRegOut = e8;
		4'b1001: memToRegOut = e9;
		
	endcase
	
endmodule: memToReg