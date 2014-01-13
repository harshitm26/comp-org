package HVJ;

interface H2s_ifc;
        method Bit#(7) decode (Bit#(4) hex);
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
endmodule: mkh2s

interface InSel_ifc;
	method Bit#(2) retInSel ();
endinterface: InSel_ifc

(*synthesize*)
module mkInSel(InSel_ifc);
	Reg#(Bit#(2)) inp <-mkReg(0);
	Reg#(Bit#(25)) c <- mkReg(0);
	rule pulse;
		c<=c+1;
		if(c=='b0) inp<=inp+1;
	endrule: pulse
	method Bit#(2) retInSel();
		return inp;
	endmethod: retInSel
endmodule: mkInSel

interface Mukhya_ifc;
	method Bit#(4) retAnodeSelected();
	method Bit#(7) retSegmentData();
endinterface: Mukhya_ifc

(*synthesize*)
module mkMukhya(Mukhya_ifc);
	Reg#(Bit#(4)) anodeSelected <- mkReg(0);
	Reg#(Bit#(7)) segmentData <- mkReg(0);
	Reg#(Bit#(2)) displaySelected <- mkReg(0);
	H2s_ifc h2s0 <- mkh2s();
	H2s_ifc h2s1 <- mkh2s();
	H2s_ifc h2s2 <- mkh2s();
	H2s_ifc h2s3 <- mkh2s();
	H2s_ifc h2s4 <- mkh2s();
	H2s_ifc h2s5 <- mkh2s();
	H2s_ifc h2s6 <- mkh2s();
	H2s_ifc h2s7 <- mkh2s();
	H2s_ifc h2s8 <- mkh2s();
	H2s_ifc h2s9 <- mkh2s();
	H2s_ifc h2s10 <- mkh2s();
	H2s_ifc h2s11 <- mkh2s();
	H2s_ifc h2s12 <- mkh2s();
	H2s_ifc h2s13 <- mkh2s();
	H2s_ifc h2s14 <- mkh2s();
	H2s_ifc h2s15 <- mkh2s();
	Reg#(Bit#(12)) counterDisplaySelected <- mkReg(0);
	InSel_ifc switchInput <- mkInSel();
	rule dikha;
		counterDisplaySelected <= counterDisplaySelected +1;
		if(counterDisplaySelected == 0)
			displaySelected <= displaySelected+'b01;
		case (switchInput.retInSel())
		'b00: begin
			case(displaySelected)
				'b00: begin segmentData <= h2s0.decode('b0000); end
				'b01: begin segmentData <= h2s1.decode('b0010); end
				'b10: begin segmentData <= h2s2.decode('b0010); end
				'b11: begin segmentData <= h2s3.decode('b1100); end
			endcase
			end
		'b01: begin
			case(displaySelected)
				'b00: begin segmentData <= h2s4.decode('b0000); end
				'b01: begin segmentData <= h2s5.decode('b1001); end
				'b10: begin segmentData <= h2s6.decode('b0010); end
				'b11: begin segmentData <= h2s7.decode('b0000); end
			endcase
			end
		'b10: begin
			case(displaySelected)
				'b00: begin segmentData <= h2s8.decode('b0100); end
				'b01: begin segmentData <= h2s9.decode('b0001); end
				'b10: begin segmentData <= h2s10.decode('b0011); end
				'b11: begin segmentData <= h2s11.decode('b0000); end
			endcase
			end
		'b11: begin
			case(displaySelected)
				'b00: begin segmentData <= h2s12.decode('b0111); end
				'b01: begin segmentData <= h2s13.decode('b0000); end
				'b10: begin segmentData <= h2s14.decode('b1000); end
				'b11: begin segmentData <= h2s15.decode('b0000); end
			endcase
			end
		endcase
	endrule: dikha
	method Bit#(4) retAnodeSelected();
		case (displaySelected)
			'b00: return('b1110);
			'b01: return('b1101);
			'b10: return('b1011);
			'b11: return('b0111);
		endcase
	endmethod: retAnodeSelected
	method Bit#(7) retSegmentData();
		return segmentData;
	endmethod: retSegmentData
endmodule: mkMukhya
endpackage: HVJ














