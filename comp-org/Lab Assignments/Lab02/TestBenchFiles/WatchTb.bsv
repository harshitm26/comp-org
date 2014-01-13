package WatchTb;

import Watch::*;

(*synthesize*)
module mkWatchTb();
	Watch_ifc watch <- mkWatch();
	Reg#(Bit#(18)) counterMode <- mkReg(0);			//synchronizes this module to rate of taking input by watch
	Reg#(Bit#(15)) counterDisplay <- mkReg(0);		//controls the rate of showing data on the screen
	Reg#(Bit#(2)) showing <- mkReg(0);
	function (Bit#(4)) decode (Bit#(7) given);		//converts seven segment data to corresponding number, just for convenience in testing
		Bit#(4) spit;
		case(given)
			'b0000001: begin spit='d0;end
			'b1001111: begin spit='d1;end
			'b0010010: begin spit='d2;end
			'b0000110: begin spit='d3;end
			'b1001100: begin spit='d4;end
			'b0100100: begin spit='d5;end
			'b0100000: begin spit='d6;end
			'b0001111: begin spit='d7; end
			'b0000000: begin spit='d8; end
			'b0000100: begin spit='d9; end
			default: begin spit='d10; end
		endcase
		return spit;
	endfunction: decode
	rule incrementCounter;
		counterDisplay <= counterDisplay +'b1;
		counterMode<=counterMode+1;
		if(counterMode==0) begin				//At this instant takeInput register of watch is also 0, hence the mode has been changed
			$display("Changing mode to");
			case(showing)
				'b00: begin $display("Hours:Minutes"); end
				'b01: begin $display("Minutes:Seconds"); end
				'b10: begin $display("Alarm"); end
				'b11: begin $display("Stopwatch"); end
			endcase
		showing <= showing +1;
		end
		watch.updateInput('b001, 'b0);
	endrule: incrementCounter
	rule show(counterDisplay==0);	//Shows anode, seven-segment data and decoded seven-segment data on screen
		$display("%b %b %d  ", watch.retAnodeSelected(), watch.retSegmentData(), decode(watch.retSegmentData()));
	endrule: show
endmodule: mkWatchTb
endpackage: WatchTb
