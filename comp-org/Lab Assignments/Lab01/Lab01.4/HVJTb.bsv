package HVJTb;

import HVJ::*;

(*synthesize*)
module mkTb();
	Mukhya_ifc disp <-mkMukhya();
	Reg#(Bit#(12)) c <- mkReg(0);
	rule show;
		c <= c + 1;
		if(c==0) $display("Anode Selected: %b\tLED Data: %b\n", disp.retAnodeSelected(), disp.retSegmentData());
	endrule: show
endmodule: mkTb
endpackage: HVJTb
		
