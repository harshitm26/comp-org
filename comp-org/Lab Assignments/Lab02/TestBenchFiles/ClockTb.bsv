package ClockTb;
import Clock::*;

(*synthesize*)
module mkClockTb();
	Clock_ifc clock <- mkClock;
	Reg#(Bit#(8)) decelerator <- mkReg(0);
	rule rundecelerator;
		decelerator <= decelerator +1;
	endrule
	rule dikha(decelerator==0);			//fetches Hours, Minutes and Seconds values from clock and displays on screen
		$display("%d %d %d\n", clock.dataHHMM()[10:6], clock.dataHHMM()[5:0], clock.dataMMSS()[5:0]);
	endrule: dikha
endmodule: mkClockTb
endpackage: ClockTb
