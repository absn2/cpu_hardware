module div(
	input logic [31:0]a,
	input logic [31:0]b,
	input logic clk,
	input logic reset,
	input logic divControl,
	output logic divStop, // sinal informando que acabou o algoritmo
	output logic divZero, 
	output logic [64:0] qOut,
	output logic [31:0] bOut,
	output logic [31:0] dividendOut,
	output logic [64:0] quotientOut,
	output logic [31:0]hi,
	output logic [31:0]lo
);

initial begin 
	dividend = -20;
end

integer counter = 32;
logic [64:0] quotient = 0;
logic [31:0] remainder;
logic [31:0] dividend;
logic [31:0] divisor;


always @ (posedge clk) begin
	if(counter == 32) begin
		dividend = a;
		divisor = b;
	end
	
	remainder = (dividend%divisor);
	
	if(dividend == 0) begin
		divZero = 1;
	end
	
	remainder = remainder - divisor;
	
	dividendOut = dividend;
	bOut = remainder;
	qOut = divisor;
	
	
	if(remainder >= 0) begin
		quotient = quotient << 1;
		quotient[0] = 1'b1;
	end
	
	if(remainder < 0) begin
		remainder = remainder + divisor;
		quotient = quotient << 1;
		quotient[0] = 1'b0;
	end

	divisor = divisor >> 1;
	
	if(counter > 0) begin
		counter = counter - 1;
	end
	
	if(counter == 0) begin
		hi = quotient[64:33];
		lo = quotient[32:1];
		quotientOut = quotient;
		divStop = 0;
		counter = -10;		
	end
	
	if(counter == -10) begin
		remainder = 32'd0;
		quotient = 65'b0;
	end
	//qOut = quotient;
end

endmodule: div