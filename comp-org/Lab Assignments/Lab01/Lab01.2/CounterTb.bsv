package CounterTb;
import Counter::*;
(*synthesize*)
module mkTb();
	Ctr_ifc ctr <- mkCtr();
	Reg#(Bit#(4)) segm <-mkReg(0);
	Reg#(Bit#(7)) led <- mkReg(0);
	rule showresults;
		segm <= ctr.retsegm();
		led <= ctr.retled();
		$display("Anode: %b\tLED Signal: %b\n", segm, led);
	endrule: showresults
endmodule: mkTb

endpackage: CounterTb
