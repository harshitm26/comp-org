package SevSegTb;
import SevSeg::*;
(*synthesize*)
module mkTb();
	Reg#(Bit#(4)) hex <- mkReg(0);
	H2s_ifc h2s <- mkh2s();
	rule showAllCombinations;
			$display("AnodeSelected: %b\tHex Number: %b\t LED Signals: %b\n", h2s.dispsegment(), hex, h2s.decode(hex));
			hex<= hex+1;
			if(hex=='b1111) $finish(0);
		endrule: showAllCombinations
endmodule: mkTb
endpackage: SevSegTb
