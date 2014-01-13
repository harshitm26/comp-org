package Watch;

import Clock::*;
import SevSeg::*;

typedef enum {ALLSET,SETTINGFIRST,FIRSTSET,SETTINGSECOND,SECONDSET} SetStates deriving(Bits, Eq);		//SETTINGFIRST means setting the leftmost 2 numbers on LED, FIRSTSET means the leftmost 2 numbers have been set
typedef enum {MHHMM, MMMSS, MALARM, MSTOPWATCH, SETTINGHHMM, SETTINGMMSS, SETTINGALARM} ClockStates deriving(Bits,Eq);		//MHHMM: Mode Hours-Minutes
typedef enum {PAUSED, RUNNING} StopWatchStates deriving(Bits,Eq);

interface Watch_ifc;
	method Bit#(4) retAnodeSelected();					//returns the anode data
	method Bit#(7) retSegmentData();					//returns the seven segment data
	method Action updateInput(Bit#(3) btns, Bit#(6) swtchs);	//receives input
	method Bit#(4) retLEDSignals();					//returns LED data
endinterface: Watch_ifc

(*descending_urgency = "displayData, settinghhmmrule, settingmmssrule, settingalarmrule"*)
(*synthesize*)
module mkWatch(Watch_ifc);
	Clock_ifc clock <- mkClock();

//-----------Debouncer registers-----------------

	Reg#(Bit#(8)) btn1stream <- mkReg(0);		//BTN0 data streams in here
	Reg#(Bit#(8)) btn2stream <-mkReg(0);		//BTN1 data streams in here
	Reg#(Bit#(8)) btn3stream <- mkReg(0);		//BTN2 data streams in here
	Reg#(Bit#(8)) btdecelerator <- mkReg(0);		//controls rate of taking input from buttons
	Reg#(Bit#(1)) btn0 <- mkReg(0);			//stores the BTN0 debounced value
	Reg#(Bit#(1)) btn1 <- mkReg(0);			//stores the BTN1 debounced value
	Reg#(Bit#(1)) btn2 <- mkReg(0);			//stores the BTN2 debounced value
	Reg#(Bit#(3)) btnin <- mkReg(0);			//stores the raw BTN values coming from FPGA

//-----------Initial states-----------------

	StopWatchStates initialstopwatchstate = PAUSED;
	ClockStates initialclockstate = MHHMM;

//-----------Display-related registers and modules-----------------
	H2s_ifc h2s0 <- mkh2s();				//Seven-segment module for rightmost number
	H2s_ifc h2s1 <- mkh2s();				//Seven-segment module for third number
	H2s_ifc h2s2 <- mkh2s();				//Seven-segment module for second number
	H2s_ifc h2s3 <- mkh2s();				//Seven-segment module for leftmost number
	
	Reg#(Bit#(2)) anodeSelected <-mkReg(0);		//goes 00->01->10->11->00 everytime counterAnodeSelected overflows
	Reg#(Bit#(12)) counterAnodeSelected <- mkReg(0);	//controls the rate of increment of anodeSelected register
	Reg#(Bit#(7)) segmentData <- mkReg(0);		//returns the realtime Seven-segment data out to FPGA

	Reg#(Bit#(4)) toShow4 <- mkReg(0);			//contains the number to be shown leftmost on display
	Reg#(Bit#(4)) toShow3 <- mkReg(0);			//contains the number to be shown second on display
	Reg#(Bit#(4)) toShow2 <- mkReg(0);			//contains the number to be shown third on display
	Reg#(Bit#(4)) toShow1 <- mkReg(0);			//contains the number to be shown rightmost on display

	Reg#(Bit#(5)) alarmHH <- mkReg('b0111);		//stores the current alarm Hours value, initialised to 07 hrs
	Reg#(Bit#(6)) alarmMM <- mkReg(0);			//stores the current alarm Minutes value, initialised to 00 min
	Reg#(Bit#(6)) switches <- mkReg(0);		//stores realtime input from switches
	Reg#(Bit#(4)) led <- mkReg(0);			//stores the led data to be output to FPGA
	Reg#(SetStates) setState <- mkReg(ALLSET);	//stores the state of the watch when in setting hours-minute, setting minute-seconds or setting alarm mode
	Reg#(StopWatchStates) stopWatchState <- mkReg(initialstopwatchstate);		//stores status of stopwatch

	Reg#(Bit#(4)) stopWatch4 <- mkReg(0);		//Stopwatch registers
	Reg#(Bit#(4)) stopWatch3 <- mkReg(0);
	Reg#(Bit#(4)) stopWatch2 <- mkReg(0);
	Reg#(Bit#(4)) stopWatch1 <- mkReg(0);

	Reg#(ClockStates) mode <- mkReg(initialclockstate);	//stores the mode clock is currently in
	Reg#(Bit#(19)) stopWatchDecelerator <- mkReg(0);		//controls the speed of stopwatch
	Reg#(Bit#(22)) takeInput <- mkReg(0);			//controls the rate of processing input
	Reg#(Bit#(1)) blinker <- mkReg(0);				//for blinking LEDs
	Reg#(Bit#(23)) counterblinker <- mkReg(0);		//controls the rate of flip of blinker

//-----------Rules and methods-----------------
	rule incrdecelerator;					//increments the various counters
		btdecelerator <= btdecelerator +1;
		takeInput <= takeInput +1;
		counterblinker <= counterblinker +1;
	endrule: incrdecelerator

	function Bit#(4) nones(Bit#(8) inp);			//returns the number of ones in inp
		Bit#(4) one =0;
		Bit#(4) counter=0;
		while(counter<'d8) begin
			if(inp[counter]==1) one=one+1;
			counter=counter+1;
		end
		return one;
	endfunction: nones

	rule process (btdecelerator==0);				//Debouncer
		btn1stream <= {btn1stream[6:0],btnin[0]};		//streams in the BTN0 data in btn1stream
		btn2stream <= {btn2stream[6:0],btnin[1]};
		btn3stream <= {btn3stream[6:0],btnin[2]};
		if(nones(btn1stream)<'d4) btn0<=0; else btn0<=1;	//If number of ones in btn1stream is less than 4, then btn0 is debounced to 0 otherwise 1
		if(nones(btn2stream)<'d4) btn1<=0; else btn1<=1;
		if(nones(btn3stream)<'d4) btn2<=0; else btn2<=1;
	endrule: process

	function Bit#(4) ones(Bit#(6) given);			//returns the number at ones place of the decimal number corresponding to 'given'
		Bit#(4) i=0;
		while(given>='d10 && i<'d6) begin
			given=given-'d10;
			i=i+1;
		end
		return given[3:0];
	endfunction: ones

	function Bit#(4) tens(Bit#(6) given);			//returns the number at tens place of the decimal number corresponding to 'given'
		Bit#(4) i=0;
		while(given>='d10 && i<'d6) begin
			given=given-'d10;
			i=i+1;
		end
		return i;
	endfunction: tens

	rule rulblinker(counterblinker==0);			//flips the blinker register
		blinker <= 'b1 - blinker;
	endrule: rulblinker

	rule takinginput(takeInput==0);				//processes input
		if(btn0==1 && setState==ALLSET) begin		//Changes mode sequentially as MHHMM->MMMSS->MALARM->MSTOPWATCH->MHHMM
			case (mode)
				MHHMM: begin mode <= MMMSS; end
				MMMSS: begin mode <= MALARM; end
				MALARM: begin mode <= MSTOPWATCH; end
				MSTOPWATCH: begin mode <= MHHMM; end
			endcase
		end
		else if(btn1==1 && setState == ALLSET ) begin	//Starts the SET mode or resumes/pauses the stopwatch
			case (mode)
				MHHMM: begin mode <= SETTINGHHMM; clock.pause(); setState <= SETTINGFIRST; led[2] <=1; end
				MMMSS: begin mode <= SETTINGMMSS; clock.pause(); setState <= SETTINGFIRST; led[2]<=1; end
				MALARM: begin mode <= SETTINGALARM; setState <= SETTINGFIRST; led[2]<=1; end
				MSTOPWATCH: begin stopWatchState <= stopWatchState==RUNNING?PAUSED:RUNNING; end
			endcase
		end
		else if(stopWatchState==PAUSED && btn2==1 && setState==ALLSET && mode==MSTOPWATCH)	//resets the stopwatch
			begin
				stopWatch1 <= 0;
				stopWatch2 <=0;
				stopWatch3<=0;
				stopWatch4<=0;
			end
	endrule: takinginput

	Bool alarmactive = (alarmHH == clock.dataHHMM()[10:6] && alarmMM==clock.dataHHMM()[5:0] && setState==ALLSET);	//Alarm On/Off register
	rule displayData(takeInput>'d8);
		if(alarmactive) led[3]<=blinker; else led[3]<=0;			//If Alarm is ON, blink 3rd LED
		counterAnodeSelected <= counterAnodeSelected +1;			
		if(counterAnodeSelected ==0) begin
			anodeSelected <= anodeSelected +'b1;
		end
		case(anodeSelected)							//selects the anode and the seven-segment data to be output to FPGA
			'b00: begin segmentData <= h2s0.decode(toShow1); end
			'b01: begin segmentData <= h2s1.decode(toShow2); end
			'b10: begin segmentData <= h2s2.decode(toShow3); end
			'b11: begin segmentData <= h2s3.decode(toShow4); end
		endcase
	endrule: displayData

	rule stopwatchrun(stopWatchState==RUNNING);	//runs the stopwatch: updates stopWatch1, stopWatch2, stopWatch3 and stopWatch4 registers according the decimal rules
		if(stopWatchDecelerator=='d499999) stopWatchDecelerator<=0;	//Assuming internal freq to be 50 MHz, we reset stopWatchDecelerator to 0 every 50,000,000 cycles
		else stopWatchDecelerator <= stopWatchDecelerator +1;
		if(stopWatchDecelerator==0) begin
			if(stopWatch1=='d9) begin
				stopWatch1<=0;
				if(stopWatch2=='d9) begin
					stopWatch2<=0;
					if(stopWatch3=='d9) begin
						stopWatch3<=0;
						if(stopWatch4=='d9) stopWatch4<=0;
						else stopWatch4<=stopWatch4+1;
					end
					else stopWatch3<=stopWatch3+1;
				end
				else stopWatch2<=stopWatch2+1;
			end
			else stopWatch1<=stopWatch1+1;
		end
	endrule: stopwatchrun

	rule hhmmrule (mode==MHHMM);			//If mode is MHHMM, show Hours and Minutes from the clock
		toShow1<=ones(clock.dataHHMM()[5:0]);
		toShow2<=tens(clock.dataHHMM()[5:0]);
		toShow3<=ones({'b0,clock.dataHHMM()[10:6]});
		toShow4<=tens({'b0,clock.dataHHMM()[10:6]});
	endrule: hhmmrule
	rule mmssrule (mode==MMMSS);			//If mode is MMMSS, show Minutes and Seconds from the clock
		toShow1<=ones(clock.dataMMSS()[5:0]);
		toShow2<=tens(clock.dataMMSS()[5:0]);
		toShow3<=ones(clock.dataMMSS()[11:6]);
		toShow4<=tens(clock.dataMMSS()[11:6]);
	endrule: mmssrule
	rule alarmrule(mode==MALARM);			//If mode is MALARM, show the alarmHH and alarmMM
		toShow1<=ones(alarmMM);
		toShow2<=tens(alarmMM);
		toShow3<=ones({'b0,alarmHH});
		toShow4<=tens({'b0,alarmHH});
	endrule: alarmrule
	rule stopwatchrule(mode==MSTOPWATCH);		//similarly for stopwatch
		toShow1<=stopWatch1;
		toShow2<=stopWatch2;
		toShow3<=stopWatch3;
		toShow4<=stopWatch4;	
	endrule: stopwatchrule

	rule settinghhmmrule (mode==SETTINGHHMM && takeInput!=0 && takeInput<='d8);
		if(setState==SETTINGFIRST) begin
				toShow3 <= ones({'b0,switches[4:0]});
				toShow4 <= tens({'b0,switches[4:0]});
				if(switches[4:0]>'d23) led[0]<=blinker; else led[0]<=0;		//If values are invalid blink LED0
				if(btn2==1 && switches[4:0]<'d24) begin				//Set values, if valid
					clock.setHH(switches[4:0]);
					setState<=FIRSTSET;
					end
				end
		else if(setState==FIRSTSET) begin
				led<=0;	
				if(btn1==1) setState<=SETTINGSECOND;
				end
		else if(setState==SETTINGSECOND) begin
				toShow2 <= tens(switches[5:0]);
				toShow1 <= ones(switches[5:0]);
				if(switches[5:0]>'d59) led<= (blinker==1?'b011:'b010); else led<='b010;	//Blink LED0 of values are invalid
				if(btn2==1 && switches[5:0]<'d60) begin						//Set values, if valid
					clock.setMM(switches[5:0]);
					setState<=SECONDSET;
					end
				end
		else if(setState==SECONDSET) begin
				led<=0;
				if(btn1==1) begin									//Normalize, once everything is set
					setState <= ALLSET;
					clock.start();
					mode <= MHHMM;
					end
				end
	endrule: settinghhmmrule
	rule settingmmssrule (mode==SETTINGMMSS && takeInput!=0 && takeInput<='d8);
		if(setState==SETTINGFIRST) begin
				toShow4 <= tens(switches[5:0]);
				toShow3 <= ones(switches[5:0]);
				if(switches[5:0]>'d59) led[0]<=blinker; else led[0]<=0;				//If values are invalid blink LED0
				if(btn2==1 && switches[5:0]<'d60) begin						//Set values, if valid
					clock.setMM(switches[5:0]);
					setState<=FIRSTSET;
					end
				end
		else if(setState==FIRSTSET) begin
				led<=0;	
				if(btn1==1) setState<=SETTINGSECOND;
				end
		else if(setState==SETTINGSECOND) begin
				toShow2 <= tens(switches[5:0]);
				toShow1 <= ones(switches[5:0]);
				if(switches[5:0]>'d59) led<=(blinker==1?'b011:'b010); else led<='b010;	//Blink LED0 of values are invalid
				if(btn2==1 && switches[5:0]<'d60) begin						//Set values, if valid
					clock.setSS(switches[5:0]);
					setState<=SECONDSET;
					end
				end
		else if(setState==SECONDSET) begin
				led<=0;
				if(btn1==1) begin									//Normalize, once everything is set
					setState <= ALLSET;
					clock.start();
					mode <= MMMSS;
					end
				end
	endrule: settingmmssrule
	rule settingalarmrule (mode==SETTINGALARM && takeInput!=0 && takeInput<='d8);
		if(setState==SETTINGFIRST) begin
				toShow4 <= tens({'b0,switches[5:0]});
				toShow3 <= ones({'b0,switches[5:0]});
				if(switches[4:0]>'d23) led[0]<=blinker; else led[0]<=0;				//If values are invalid blink LED0
				if(btn2==1 && switches[4:0]<'d24) begin						//Set values, if valid
					alarmHH <= switches[4:0];
					setState<=FIRSTSET;
					end
				end
		else if(setState==FIRSTSET) begin
				led<=0;	
				if(btn1==1) setState<=SETTINGSECOND;
				end
		else if(setState==SETTINGSECOND) begin
				toShow2 <= tens(switches[5:0]);
				toShow1 <= ones(switches[5:0]);
				if(switches[5:0]>'d59) led<=(blinker==1?'b011:'b010); else led<='b010;	//Blink LED0 of values are invalid
				if(btn2==1 && switches[5:0]<'d60) begin						//Set values, if valid
					alarmMM <= switches[5:0];
					setState<=SECONDSET;
					end
				end
		else if(setState==SECONDSET) begin
				led<=0;
				if(btn1==1) begin									//Normalize, once everything is set
					setState <= ALLSET;
					mode <= MALARM;
					end
				end
	endrule: settingalarmrule

//-------------------Input/Output methods---------------------
	method Bit#(4) retAnodeSelected();
		case(anodeSelected)
			'b00: return 'b1110;
			'b01: return 'b1101;
			'b10: return 'b1011;
			'b11: return 'b0111;
		endcase
	endmethod: retAnodeSelected
	method Bit#(7) retSegmentData();
		return segmentData;
	endmethod: retSegmentData
	method Action  updateInput(Bit#(3) btns, Bit#(6) swtchs);
		btnin <= btns;
		switches <= swtchs;
	endmethod: updateInput
	method retLEDSignals();
		return led;
	endmethod: retLEDSignals
endmodule: mkWatch
endpackage: Watch
