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
    
	// verificar o estado atual ajudar na debugação
	output logic [5:0] functOut,
	output logic [6:0] stateOut,
	
	
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

parameter fetch1 = 7'd0;
parameter fetch2 = 7'd1;
parameter fetch3 = 7'd2;
parameter decode = 7'd3;
parameter decode2 = 7'd4;
parameter wait_= 7'd5;
parameter execute = 7'd6;
parameter add_sub_and = 7'd7;
parameter addi_addiu = 7'd8;
parameter break2 = 7'd9;
parameter xchg2 = 7'd10;
parameter xchg3 = 7'd11;
parameter closeWR = 7'd68;
parameter wait_Final = 7'd69;

//inst R
parameter formatR = 6'd0;
parameter xchg1 = 6'd5;
parameter break1 = 6'd13;
parameter rte = 6'd19;
parameter andR = 6'd36;
parameter addR = 6'd32;
parameter subR = 6'd34;

//inst I
parameter addi = 6'd8;
parameter addiu = 6'd9;

reg[6:0] state;
integer count;

initial begin
state = fetch1;
stateOut = fetch1;
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
				fetch1: begin // 
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
					 stateOut = fetch2;
					 xchgctrl = 1'd0;
				end
				fetch2: begin // 
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
					 stateOut = fetch3;
					 xchgctrl = 1'd0;
				end
				fetch3: begin // 
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
					 stateOut = decode;
					 xchgctrl = 1'd0;
				end
				decode: begin //
					 alucontrol = 3'd1;
					 aluoutwrite = 1'd1;
					 divby0 = 1'd0;
					 epcwrite = 1'd0;
					 hiwrite = 1'd0;
					 iordmux = 2'd0;
					 irwrite = 1'd0;
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
					 stateOut = decode2;
					 xchgctrl = 1'd0;
				end
				decode2: begin // 
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
					 state = execute;
					 stateOut = execute;
					 functOut = funct;
					 xchgctrl = 1'd0;
				end
				execute: begin
					case (opcode)
						formatR: begin
							case (funct)
								andR: begin
									alucontrol = 3'd3; // funcao and
									aluoutwrite = 1'd1; // habilita escrita
									divby0 = 1'd0;
									epcwrite = 1'd0;
									hiwrite = 1'd0;
									iordmux = 2'd0;
									irwrite = 1'd0;
									lowrite = 1'd0;
									lscontrol = 2'd0;
									memwrite  = 1'd0;
									muxalusrca = 2'd1; // a
									muxalusrcb = 2'd0; // b
									muxhi = 1'd0;
									muxlo = 1'd0;
									muxmemtoreg = 4'd9; 
									muxpcsource = 2'd0;
									muxregdst = 3'd2;  
									muxshiftsrca = 1'd0;
									muxshiftsrcb = 1'd0;
									muxxxchgctrl = 1'd0;
									pcwrite = 1'd0;
									pcwritecond = 1'd0;
									regwrite = 1'd0; 
									shiftcontrol = 1'd0;
									sscontrol = 2'd0;
									state = add_sub_and;
									stateOut = add_sub_and;
									xchgctrl = 1'd0;
								end
								addR: begin
								    alucontrol = 3'd1; // funcao and
									aluoutwrite = 1'd1; // habilita escrita
									divby0 = 1'd0;
									epcwrite = 1'd0;
									hiwrite = 1'd0;
									iordmux = 2'd0;
									irwrite = 1'd0;
									lowrite = 1'd0;
									lscontrol = 2'd0;
									memwrite  = 1'd0;
									muxalusrca = 2'd1; // a
									muxalusrcb = 2'd0; // b
									muxhi = 1'd0;
									muxlo = 1'd0;
									muxmemtoreg = 4'd9; 
									muxpcsource = 2'd0;
									muxregdst = 3'd2;  
									muxshiftsrca = 1'd0;
									muxshiftsrcb = 1'd0;
									muxxxchgctrl = 1'd0;
									pcwrite = 1'd0;
									pcwritecond = 1'd0;
									regwrite = 1'd0; 
									shiftcontrol = 1'd0;
									sscontrol = 2'd0;
									state = add_sub_and;
									stateOut = add_sub_and;
									xchgctrl = 1'd0;
								end
								subR: begin
								    alucontrol = 3'd2; // funcao and
									aluoutwrite = 1'd1; // habilita escrita
									divby0 = 1'd0;
									epcwrite = 1'd0;
									hiwrite = 1'd0;
									iordmux = 2'd0;
									irwrite = 1'd0;
									lowrite = 1'd0;
									lscontrol = 2'd0;
									memwrite  = 1'd0;
									muxalusrca = 2'd1; // a
									muxalusrcb = 2'd0; // b
									muxhi = 1'd0;
									muxlo = 1'd0;
									muxmemtoreg = 4'd9; 
									muxpcsource = 2'd0;
									muxregdst = 3'd2;  
									muxshiftsrca = 1'd0;
									muxshiftsrcb = 1'd0;
									muxxxchgctrl = 1'd0;
									pcwrite = 1'd0;
									pcwritecond = 1'd0;
									regwrite = 1'd0; 
									shiftcontrol = 1'd0;
									sscontrol = 2'd0;
									state = add_sub_and;
									stateOut = add_sub_and;
									xchgctrl = 1'd0;
								end
								break1: begin
									 alucontrol = 3'd2;
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
									 state = break2;
									 stateOut = break2;
									 functOut = funct;
									 xchgctrl = 1'd0;
						       end
								rte: begin
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
									 muxalusrcb = 2'd3;
									 muxhi = 1'd0;
									 muxlo = 1'd0;
									 muxmemtoreg = 4'd9; // 
									 muxpcsource = 2'd3;
									 muxregdst = 3'd2; // 
									 muxshiftsrca = 1'd0;
									 muxshiftsrcb = 1'd0;
									 muxxxchgctrl = 1'd0;
									 pcwrite = 1'd1;
									 pcwritecond = 1'd0;
									 regwrite = 1'd0; //
									 shiftcontrol = 1'd0;
									 sscontrol = 2'd0;
									 state = closeWR;
									 stateOut = closeWR;
									 functOut = funct;
									 xchgctrl = 1'd0;
								end
								xchg1: begin
									 alucontrol = 3'd1;
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
									 muxalusrcb = 2'd3;
									 muxhi = 1'd0;
									 muxlo = 1'd0;
									 muxmemtoreg = 4'd8; // <--
									 muxpcsource = 2'd0;
									 muxregdst = 3'd0;  // <--
									 muxshiftsrca = 1'd0;
									 muxshiftsrcb = 1'd0;
									 muxxxchgctrl = 1'd0; // <--
									 pcwrite = 1'd0;
									 pcwritecond = 1'd0;
									 regwrite = 1'd0; 
									 shiftcontrol = 1'd0;
									 sscontrol = 2'd0;
									 state = xchg2;
									 stateOut = xchg2;
									 functOut = funct;
									 xchgctrl = 1'd1; // <--
								end
							endcase
						end
						addi: begin
							 alucontrol = 3'd1;
							 aluoutwrite = 1'd1;
							 divby0 = 1'd0;
							 epcwrite = 1'd0;
							 hiwrite = 1'd0;
							 iordmux = 2'd0;
							 irwrite = 1'd0;
							 lowrite = 1'd0;
							 lscontrol = 2'd0;
							 memwrite  = 1'd0; // 0 = lendo , 1 = escrevendo
							 muxalusrca = 2'd1;
							 muxalusrcb = 2'd2;
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
							 state = addi_addiu;
							 stateOut = addi_addiu;
							 functOut = funct;
							 xchgctrl = 1'd0;
						end
						addiu: begin
							 alucontrol = 3'd1;
							 aluoutwrite = 1'd1;
							 divby0 = 1'd0;
							 epcwrite = 1'd0;
							 hiwrite = 1'd0;
							 iordmux = 2'd0;
							 irwrite = 1'd0;
							 lowrite = 1'd0;
							 lscontrol = 2'd0;
							 memwrite  = 1'd0; // 0 = lendo , 1 = escrevendo
							 muxalusrca = 2'd1;
							 muxalusrcb = 2'd2;
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
							 state = addi_addiu;
							 stateOut = addi_addiu;
							 functOut = funct;
							 xchgctrl = 1'd0;
						end
					endcase
			    end			
				add_sub_and: begin
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
					muxalusrca = 2'd1;
					muxalusrcb = 2'd0;
					muxhi = 1'd0;
					muxlo = 1'd0;
					muxmemtoreg = 4'd0; // <----
					muxpcsource = 2'd0;
					muxregdst = 3'd1; // <---
					muxshiftsrca = 1'd0;
					muxshiftsrcb = 1'd0;
					muxxxchgctrl = 1'd0;
					pcwrite = 1'd0;
					pcwritecond = 1'd0;
					regwrite = 1'd1; // <---
					shiftcontrol = 1'd0;
					sscontrol = 2'd0;
					state = closeWR;
					stateOut = closeWR;								
					xchgctrl = 1'd0;
				end
				xchg2: begin
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
					muxalusrca = 2'd1;
					muxalusrcb = 2'd0;
					muxhi = 1'd0;
					muxlo = 1'd0;
					muxmemtoreg = 4'd8; // <--- 
					muxpcsource = 2'd0;
					muxregdst = 3'd0; // <---
					muxshiftsrca = 1'd0;
					muxshiftsrcb = 1'd0;
					muxxxchgctrl = 1'd0; // <---
					pcwrite = 1'd0;
					pcwritecond = 1'd0;
					regwrite = 1'd1; 
					shiftcontrol = 1'd0;
					sscontrol = 2'd0;
					state = xchg3;
					stateOut = xchg3;								
					xchgctrl = 1'd0; // <---
				end
				xchg3: begin
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
					muxalusrca = 2'd1;
					muxalusrcb = 2'd0;
					muxhi = 1'd0;
					muxlo = 1'd0;
					muxmemtoreg = 4'd8; // <--- 
					muxpcsource = 2'd0;
					muxregdst = 3'd4; // <---
					muxshiftsrca = 1'd0;
					muxshiftsrcb = 1'd0;
					muxxxchgctrl = 1'd1; // <---
					pcwrite = 1'd0;
					pcwritecond = 1'd0;
					regwrite = 1'd1; 
					shiftcontrol = 1'd0;
					sscontrol = 2'd0;
					state = closeWR;
					stateOut = closeWR;								
					xchgctrl = 1'd0; // <---
				end
				addi_addiu: begin
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
					muxalusrca = 2'd1;
					muxalusrcb = 2'd0;
					muxhi = 1'd0;
					muxlo = 1'd0;
					muxmemtoreg = 4'd0; // <----
					muxpcsource = 2'd0;
					muxregdst = 3'd0; // <---
					muxshiftsrca = 1'd0;
					muxshiftsrcb = 1'd0;
					muxxxchgctrl = 1'd0;
					pcwrite = 1'd0;
					pcwritecond = 1'd0;
					regwrite = 1'd1; // <---
					shiftcontrol = 1'd0;
					sscontrol = 2'd0;
					state = closeWR;
					stateOut = closeWR;								
					xchgctrl = 1'd0;
				end
				break2: begin
					alucontrol = 3'd2;
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
					muxalusrcb = 2'd1;
					muxhi = 1'd0;
					muxlo = 1'd0;
					muxmemtoreg = 4'd0; // <----
					muxpcsource = 2'd0;
					muxregdst = 3'd0; // <---
					muxshiftsrca = 1'd0;
					muxshiftsrcb = 1'd0;
					muxxxchgctrl = 1'd0;
					pcwrite = 1'd1;
					pcwritecond = 1'd0;
					regwrite = 1'd0; // <---
					shiftcontrol = 1'd0;
					sscontrol = 2'd0;
					state = closeWR;
					stateOut = closeWR;								
					xchgctrl = 1'd0;
				end
				closeWR: begin
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
					muxmemtoreg = 4'd0; // 
					muxpcsource = 2'd0;
					muxregdst = 3'd0; // 
					muxshiftsrca = 1'd0;
					muxshiftsrcb = 1'd0;
					muxxxchgctrl = 1'd0;
					pcwrite = 1'd0;
					pcwritecond = 1'd0;
					regwrite = 1'd0; //
					shiftcontrol = 1'd0;
					sscontrol = 2'd0;
					state = wait_Final;
					stateOut = wait_Final; 
					xchgctrl = 1'd0;
				end
				wait_Final: begin
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
					muxmemtoreg = 4'd0; // 
					muxpcsource = 2'd0;
					muxregdst = 3'd0; // 
					muxshiftsrca = 1'd0;
					muxshiftsrcb = 1'd0;
					muxxxchgctrl = 1'd0;
					pcwrite = 1'd0;
					pcwritecond = 1'd0;
					regwrite = 1'd0; //
					shiftcontrol = 1'd0;
					sscontrol = 2'd0;
					state = fetch1;
					stateOut = fetch1;
					xchgctrl = 1'd0;
				end
			endcase
		end
	end
endmodule: unidadeControle