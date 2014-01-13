package SevSeg;

interface H2s_ifc;
        method Bit#(7) decode (Bit#(4) hex);
        method Bit#(4) dispsegment();
endinterface: H2s_ifc

(*synthesize*)
module mkh2s(H2s_ifc);
	
	method Bit#(7) decode (Bit#(4) hex);
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
endpackage: SevSeg
