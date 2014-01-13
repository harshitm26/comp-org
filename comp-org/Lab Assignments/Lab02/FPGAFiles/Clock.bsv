package Clock;

interface Clock_ifc;
	method Action pause();			//pauses the clock
	method Action start();			//resumes the clock
	method Action setHH(Bit#(5) hh);		//sets hrs register to hh
	method Action setMM(Bit#(6) mm);		//sets min register to mm
	method Action setSS(Bit#(6) ss);		//sets sec register to ss
	method Bit#(11) dataHHMM();			//returns hours-minutes in 11-bit format as hhhhhmmmmmm
	method Bit#(12) dataMMSS();			//returns minutes-seconds in 12-bit format as mmmmmmssssss
endinterface: Clock_ifc

(*synthesize*)
module mkClock(Clock_ifc);
	Reg#(Bit#(6)) sec <- mkReg(0);
	Reg#(Bit#(6)) min <- mkReg(0);
	Reg#(Bit#(5)) hrs <- mkReg('b1100);
	Reg#(Bit#(26)) decelerator <- mkReg(0);	//controls clock speed
	Reg#(Bool) running <- mkReg(True);
	rule runDecelerator(running);
		if(decelerator=='d49999999) decelerator<=0;	//Assuming the frequency to be 50 MHz, we reset decelerator to 0 after 50,000,000 cycles
		else decelerator <= decelerator +1;
	endrule: runDecelerator
	rule runClock(decelerator == 0);				//runs the clock: updates sec, min and hrs register according to clock rules
		if(sec=='d59) begin
			sec<=0;
			if(min=='d59) begin
				min<=0;
				if(hrs=='d23) hrs<=0;
				else hrs<=hrs+1;
			end
			else min<=min+1;
		end
		else sec<=sec+1;
	endrule: runClock
	method Action setHH(Bit#(5) hh);	
		hrs<=hh;
	endmethod: setHH
	method Action setMM(Bit#(6) mm);
		min<=mm;
	endmethod: setMM
	method Action setSS(Bit#(6) ss);
		sec <= ss;
	endmethod: setSS
	method Bit#(11) dataHHMM();
		return {hrs,min};
	endmethod: dataHHMM
	method Bit#(12) dataMMSS();
		return{min,sec};
	endmethod: dataMMSS
	method Action pause();
		running <= False;
	endmethod: pause
	method Action start();
		running <= True;
	endmethod: start
endmodule: mkClock
endpackage: Clock
		
