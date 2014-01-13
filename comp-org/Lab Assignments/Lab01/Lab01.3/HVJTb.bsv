package HVJTb;
import HVJ::*;

(*synthesize*)
module mkTb();
	Reg#(Bit#(2)) simulateSwitches <- mkReg(0);
	Mukhya_ifc mukhya <- mkMukhya();
	Reg#(Bit#(16)) counterSimulateSwitches <- mkReg(0);
	Reg#(Bit#(12)) counterDisplay <- mkReg(0);
	rule incrCtr(counterSimulateSwitches != 0);
		counterSimulateSwitches <= counterSimulateSwitches +1;
	endrule: incrCtr
	rule switchToNext (counterSimulateSwitches ==0);
		counterSimulateSwitches <= counterSimulateSwitches +1;
		simulateSwitches <= simulateSwitches +1;
		mukhya.updateInput(simulateSwitches+'b1);
	endrule: switchToNext
	rule display;
		counterDisplay <= counterDisplay +1;
		if(counterDisplay==0) 
			$display("Switch: %b\tAnode selected: %b\tLED Signal: %b\n", simulateSwitches, mukhya.retAnodeSelected(), mukhya.retSegmentData());
	endrule: display
endmodule: mkTb
endpackage: HVJTb
