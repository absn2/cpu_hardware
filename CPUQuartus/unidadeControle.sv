module unidadeControle(
    input logic clk,
    input reset,

    //fios da instrucao
    input logic [5:0] funct,
    input logic [5:0] opcode,
    
    //flags da ula
    input logic Overflow,
    input logic Negativo,
    input logic z,
    input logic Igual,
    input logic Maior,
    input logic Menor,
    

    //sinais dos registradores
    output logic regwrite,
    output logic epcwrite,
    output logic irwrite,

    //sinais memorias
    output logic memwrite,
    
    //sinais pc
    output logic pcwrite,
    output logic pcwritecond,
    
    //sinais pro alu
    output logic [2:0] alucontrol,
    output logic aluoutwrite,

    //sinais div e mult
    output logic hiwrite,
    output logic lowrite,
    output logic divby0,

    //sinal troca
    output logic xchgctrl,

    //sinal shiftreg
    output logic shiftcontrol,

    //lb, lw, lh, sw,sb e sh control
    output logic [1:0] sscontrol,
    output logic [1:0] lscontrol,

    //muxes
    output logic [2:0] iordmux,
    output logic muxhi,
    output logic muxlo,
    output logic muxshiftsrca,
    output logic muxshiftsrcb,
    output logic [2:0]muxregdst,
    output logic [3:0] muxmemtoreg,
    output logic muxxxchgctrl,
    output logic [1:0]muxalusrca,
    output logic [1:0]muxalusrcb,
    output logic [1:0]muxpcsource
);

parameter	reset_parameter = 7'd0;
parameter	fetch1 = 7'd2;
parameter	fetch2 = 7'd2;
parameter	fetch3 = 7'd3;
parameter	wait_= 7'd4;
parameter	decode = 7'd5;
parameter	decode2 = 7'd6;


reg[6:0] state;
integer count;

initial begin
state = fetch1;
count = 0;
end



always @(posedge clk) begin
	if (reset) begin
		 alucontrol = 3'd0;
		 aluoutwrite = 1'd0;
		 divby0 = 1'd0;
		 epcwrite = 1'd0;
		 hiwrite = 1'd0;
		 iordmux = 2'd0;
		 irwrite = 1'd0;
		 lowrite = 1'd0;
		 lscontrol = 2'd0;
		 memwrite  = 1'd0;
		 muxalusrca = 2'd0;
		 muxalusrcb = 2'd0;
		 muxhi = 1'd0;
		 muxlo = 1'd0;
		 muxmemtoreg = 4'd9; // 
		 muxpcsource = 2'd0;
		 muxregdst = 3'd2; // 
		 muxshiftsrca = 1'd0;
		 muxshiftsrcb = 1'd0;
		 muxxxchgctrl = 1'd0;
		 pcwrite = 1'd0;
		 pcwritecond = 1'd0;
		 regwrite = 1'd1; //
		 shiftcontrol = 1'd0;
		 sscontrol = 2'd0;
		 state = fetch1;
		 xchgctrl = 1'd0;

		end
		else begin
			case (state)
				fetch1: begin // fetch - 1
					 alucontrol = 3'd1;
					 aluoutwrite = 1'd0;
					 divby0 = 1'd0;
					 epcwrite = 1'd0;
					 hiwrite = 1'd0;
					 iordmux = 2'd0;
					 irwrite = 1'd0;
					 lowrite = 1'd0;
					 lscontrol = 2'd0;
					 memwrite  = 1'd0; // 0 = lendo , 1 = escrevendo
					 muxalusrca = 2'd0;
					 muxalusrcb = 2'd1;
					 muxhi = 1'd0;
					 muxlo = 1'd0;
					 muxmemtoreg = 4'd9; // 
					 muxpcsource = 2'd0;
					 muxregdst = 3'd2; // 
					 muxshiftsrca = 1'd0;
					 muxshiftsrcb = 1'd0;
					 muxxxchgctrl = 1'd0;
					 pcwrite = 1'd0;
					 pcwritecond = 1'd0;
					 regwrite = 1'd0; //
					 shiftcontrol = 1'd0;
					 sscontrol = 2'd0;
					 state = fetch2;
					 xchgctrl = 1'd0;
				end
				fetch2: begin // fetch - 1
					 alucontrol = 3'd1;
					 aluoutwrite = 1'd0;
					 divby0 = 1'd0;
					 epcwrite = 1'd0;
					 hiwrite = 1'd0;
					 iordmux = 2'd0;
					 irwrite = 1'd0;
					 lowrite = 1'd0;
					 lscontrol = 2'd0;
					 memwrite  = 1'd0; // 0 = lendo , 1 = escrevendo
					 muxalusrca = 2'd0;
					 muxalusrcb = 2'd1;
					 muxhi = 1'd0;
					 muxlo = 1'd0;
					 muxmemtoreg = 4'd9; // 
					 muxpcsource = 2'd0;
					 muxregdst = 3'd2; // 
					 muxshiftsrca = 1'd0;
					 muxshiftsrcb = 1'd0;
					 muxxxchgctrl = 1'd0;
					 pcwrite = 1'd1;
					 pcwritecond = 1'd0;
					 regwrite = 1'd0; //
					 shiftcontrol = 1'd0;
					 sscontrol = 2'd0;
					 state = fetch3;
					 xchgctrl = 1'd0;
				end
				fetch3: begin // fetch - 1
					 alucontrol = 3'd1;
					 aluoutwrite = 1'd0;
					 divby0 = 1'd0;
					 epcwrite = 1'd0;
					 hiwrite = 1'd0;
					 iordmux = 2'd0;
					 irwrite = 1'd1;
					 lowrite = 1'd0;
					 lscontrol = 2'd0;
					 memwrite  = 1'd0; // 0 = lendo , 1 = escrevendo
					 muxalusrca = 2'd0;
					 muxalusrcb = 2'd1;
					 muxhi = 1'd0;
					 muxlo = 1'd0;
					 muxmemtoreg = 4'd9; // 
					 muxpcsource = 2'd0;
					 muxregdst = 3'd2; // 
					 muxshiftsrca = 1'd0;
					 muxshiftsrcb = 1'd0;
					 muxxxchgctrl = 1'd0;
					 pcwrite = 1'd0;
					 pcwritecond = 1'd0;
					 regwrite = 1'd0; //
					 shiftcontrol = 1'd0;
					 sscontrol = 2'd0;
					 state = decode;
					 xchgctrl = 1'd0;
				end
				decode: begin // fetch - 1
					 alucontrol = 3'd1;
					 aluoutwrite = 1'd1;
					 divby0 = 1'd0;
					 epcwrite = 1'd0;
					 hiwrite = 1'd0;
					 iordmux = 2'd0;
					 irwrite = 1'd1;
					 lowrite = 1'd0;
					 lscontrol = 2'd0;
					 memwrite  = 1'd0; // 0 = lendo , 1 = escrevendo
					 muxalusrca = 2'd0;
					 muxalusrcb = 2'd3;
					 muxhi = 1'd0;
					 muxlo = 1'd0;
					 muxmemtoreg = 4'd9; // 
					 muxpcsource = 2'd0;
					 muxregdst = 3'd2; // 
					 muxshiftsrca = 1'd0;
					 muxshiftsrcb = 1'd0;
					 muxxxchgctrl = 1'd0;
					 pcwrite = 1'd0;
					 pcwritecond = 1'd0;
					 regwrite = 1'd0; //
					 shiftcontrol = 1'd0;
					 sscontrol = 2'd0;
					 state = decode2;
					 xchgctrl = 1'd0;
				end
				decode: begin // fetch - 1
					 alucontrol = 3'd1;
					 aluoutwrite = 1'd1;
					 divby0 = 1'd0;
					 epcwrite = 1'd0;
					 hiwrite = 1'd0;
					 iordmux = 2'd0;
					 irwrite = 1'd1;
					 lowrite = 1'd0;
					 lscontrol = 2'd0;
					 memwrite  = 1'd0; // 0 = lendo , 1 = escrevendo
					 muxalusrca = 2'd0;
					 muxalusrcb = 2'd3;
					 muxhi = 1'd0;
					 muxlo = 1'd0;
					 muxmemtoreg = 4'd9; // 
					 muxpcsource = 2'd0;
					 muxregdst = 3'd2; // 
					 muxshiftsrca = 1'd0;
					 muxshiftsrcb = 1'd0;
					 muxxxchgctrl = 1'd0;
					 pcwrite = 1'd0;
					 pcwritecond = 1'd0;
					 regwrite = 1'd0; //
					 shiftcontrol = 1'd0;
					 sscontrol = 2'd0;
					 state = decode2;
					 xchgctrl = 1'd0;
				end

			endcase
	end





end
endmodule: unidadeControle