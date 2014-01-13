package Counter;

interface H2s_ifc;
        method Bit#(7) decode (Bit#(4) hex);
        method Bit#(4) dispsegment();
endinterface: H2s_ifc

(*synthesize*)
module mkh2s(H2s_ifc);

	method Bit#(7) decode(Bit#(4) hex);
		Bit#(7) led;		
		led[6] = ~hex[3]&~hex[2]&~hex[1]&hex[0] | ~hex[3]&hex[2]&~hex[1]&~hex[0] | hex[3]&~hex[2]&hex[1]&hex[0] | hex[3]&hex[2]&~hex[1]&hex[0];
		led[5] = ~hex[3]&hex[2]&~hex[1]&hex[0] | ~hex[3]&hex[2]&hex[1]&~hex[0] | hex[3]&~hex[2]&hex[1]&hex[0] | hex[3]&hex[2]&~hex[1]&~hex[0] | hex[3]&hex[2]&hex[1];
		led[4] = ~hex[3]&~hex[2]&hex[1]&~hex[0] | hex[3]&hex[2]&~hex[1]&~hex[0] | hex[3]&hex[2]&hex[1];
		led[3] = ~hex[3]&~hex[2]&~hex[1]&hex[0] | ~hex[3]&hex[2]&~hex[1]&~hex[0] | ~hex[3]&hex[2]&hex[1]&hex[0] | hex[3]&~hex[2]&hex[1]&~hex[0] | hex[3]&hex[2]&hex[1]&hex[0];
		led[2] = ~hex[3]&~hex[2]&~hex[1]&hex[0] | ~hex[3]&~hex[2]&hex[1]&hex[0] | ~hex[3]&hex[2]&~hex[1] | ~hex[3]&hex[2]&hex[1]&hex[0] | hex[3]&~hex[2]&~hex[1]&hex[0];
		led[1] = ~hex[3]&~hex[2]&~hex[1]&hex[0] | ~hex[3]&~hex[2]&hex[1] | ~hex[3]&hex[2]&hex[1]&hex[0] | hex[3]&hex[2]&~hex[1]&hex[0];
		led[0] = ~hex[3]&~hex[2]&~hex[1] | ~hex[3]&hex[2]&hex[1]&hex[0] | hex[3]&hex[2]&~hex[1]&~hex[0];
		return led;
	endmethod: decode
	
	method Bit#(4) dispsegment();
		return 'b0111;
	endmethod: dispsegment
endmodule: mkh2s

interface Ctr_ifc;
	method Bit#(7) retled();
	method Bit#(4) retsegm();
endinterface: Ctr_ifc
(*synthesize*)
module mkCtr(Ctr_ifc);
	Reg#(Bit#(4)) segm<-mkReg(0);
	Reg#(Bit#(4)) hex <- mkReg(0);
	Reg#(Bit#(7)) led <- mkReg(0);
	H2s_ifc h2s <- mkh2s();
	Reg#(Bit#(25)) c <- mkReg(0);
	rule counting;
		segm<=h2s.dispsegment();
		c <= c+1;
		if(c==0) begin
			led <= h2s.decode(hex);
			if(hex=='b0011)
				hex <= 'b0000;
			else
				hex <= hex +'b1;
		end
	endrule: counting   
	method Bit#(7) retled();
		return led;
	endmethod: retled
	method Bit#(4) retsegm();
		return segm;
	endmethod: retsegm
endmodule: mkCtr

endpackage: Counter
		


