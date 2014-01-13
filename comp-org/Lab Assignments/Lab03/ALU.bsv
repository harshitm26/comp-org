package ALU;

interface ALU_ifc;
	method Bit#(8) evaluate (Bit#(4) oprndA, Bit#(4) oprndB, Bit#(3) opcode);
endinterface: ALU_ifc

(*synthesize*)
module mkALU(ALU_ifc);
	method Bit#(8) evaluate (Bit#(4) oprndA, Bit#(4) oprndB, Bit#(3) opcode);
		Bit#(4) result = 0;
		Bit#(1) flagCarry = 0;
		Bit#(1) flagParity = 0;
		Bit#(1) flagSign = 0;
		Bit#(1) flagZero = 0;	
		function Bit#(1) parity(Bit#(4) given);
			Bit#(1) parityBit=0;
			if(given[0]==1) parityBit=parityBit+1;
			if(given[1]==1) parityBit=parityBit+1;
			if(given[2]==1) parityBit=parityBit+1;
			if(given[3]==1) parityBit=parityBit+1;
			return parityBit;
		endfunction: parity
		case(opcode)
			'b000: begin
				result = oprndA + oprndB;
				flagCarry= ({1'b0,oprndA}+{1'b0,oprndB})[4];
			end
			'b001: begin
				result = oprndA - oprndB;
				flagCarry = ({1'b0,oprndA}+{1'b0,-oprndB})[4];
			end
			'b010: begin
				result = oprndA + 1;
				flagCarry = (oprndA==4'b1111)?1:0;
			end
			'b011:begin
				result = oprndA<<1;
				flagCarry=oprndA[3];
			end
			'b100:begin
				result = {0,oprndA[3:1]};
			end
			'b101:begin
				result = oprndA[3]==1?{1,oprndA[3:1]}:{0,oprndA[3:1]};
			end
			'b110:begin
				result= oprndA & oprndB;
			end
			'b111:begin
			end
		endcase
		flagParity=parity(result);
		flagSign=result[3]==1?1:0;
		flagZero=result==0?1:0;
		return({flagCarry,flagParity,flagSign,flagZero,result});
	endmethod: evaluate
	endmodule: mkALU
endpackage: ALU
		
				
