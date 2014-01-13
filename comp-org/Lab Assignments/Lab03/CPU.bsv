package CPU;
import ALU::*;
import RegFile::*;
import SevSeg::*;

interface CPU_ifc;
	method Bit#(4) retAnodeSelected();
	method Bit#(7) retSevSegData();
	method Bit#(4) retLEDData();
	method Action recSwitches(Bit#(8) swtchs);
	method Action recButtons(Bit#(4) btns);
endinterface: cpu_ifc;

(*synthesize*)
module mkCPU(CPU_ifc);
	ALU_ifc alu <- mkALU();
	RegFile_ifc regFile <- mkRegFile();
	H2S_ifc h2s0 <- mkH2S();
	H2S_ifc h2s1 <- mkH2S();
	H2S_ifc h2s2 <- mkH2S();
	H2S_ifc h2s3 <- mkH2S();
	Reg#(Bit#(8)) switches <- mkReg(0);
	Reg#(Bit#(4)) buttons <- mkReg(0);
	Reg#(Bit#(4)) leds <- mkReg(0);
	Reg#(Bit#(4)) addReg1 <- mkReg(0);
	Reg#(Bit#(4)) addReg2 <- mkReg(0);
	Reg#(Bit#(4)) addRegD <- mkReg(0);
	Reg#(Bit#(1)) we <- mkReg(0);
	Reg#(Bit#(4)) dataInput <- mkReg(0);
	Reg#(Bit#(3)) opCode <- mkReg(0);
	Reg#(Bit#(4)) toShow1 <- mkReg(0);
	Reg#(Bit#(4)) toShow2 <- mkReg(0);
	Reg#(Bit#(4)) toShow3 <- mkReg(0);
	Reg#(Bit#(4)) toShow4 <- mkReg(0);
	Reg#(Bit#(2)) anodeSelected <- mkReg(0);
	Reg#(Bit#(7)) sevSegData <- mkReg(0);
	Reg#(Bit#(12)) counterAnodeSelected <- mkReg(0);
	Reg#(Bit#(18)) decelerator <- mkReg(0);
	Reg#(Bool) wait <- mkReg(False);
	Reg#(Bit#(8)) waitCounter <- mkReg(1);
	Reg#(4) rawbuttons <- mkReg(0);
	Reg#(8) btn0stream <- mkReg(0);
	Reg#(8) btn1stream <- mkReg(0);
	Reg#(8) btn2stream <- mkReg(0);
	Reg#(8) btn3stream <- mkReg(0);
	rule rulDelayAgent(wait==true);
		waitCounter  <= waitCounter +1;
		if(waitCounter==0) wait<=false;
	endrule: rulDelayAgent
	rule rulDebouncer;
		btn0stream <= {btn0stream[6:0],rawbuttons[0]};
		btn1stream <= {btn1stream[6:0],rawbuttons[1]};
		btn2stream <= {btn2stream[6:0],rawbuttons[2]};
		btn3stream <= {btn3stream[6:0],rawbuttons[3]};
		if(ones(btn0stream) > 'd4) buttons[0]<=1; else buttons[0]<=0;
		if(ones(btn1stream) > 'd4) buttons[1]<=1; else buttons[1]<=0;
		if(ones(btn2stream) > 'd4) buttons[2]<=1; else buttons[2]<=0;
		if(ones(btn3stream) > 'd4) buttons[3]<=1; else buttons[3]<=0;
	endrule: rulDebouncer
	rule rulShow;
		counterAnodeSelected <= counterAnodeSelected+1;
		case(anodeSelected)
			'b00: begin sevSegData<=h2s0.decode(toShow0); end
			'b01: begin sevSegData<=h2s0.decode(toShow1); end
			'b10: begin sevSegData<=h2s0.decode(toShow2); end
			'b11: begin sevSegData<=h2s0.decode(toShow3); end
		endcase
	endrule: rulShow
		

	rule rulTakeInput&Process(wait==false);
		if(btn0==1) begin
			toShow3 <= {1'b0, switches[2:0]};
			opcode <= switches[2:0];
		end
		else if(btn2==1) begin
			dataInput <= switches[3:0];
			toShow3 <= switches[3:0];
		end
		else if(btn3==1) begin
			case(switches[5:4])
				'b00: begin end
				'b01: begin
					addReg2 <= switches[3:0];
					toShow3 <= switches[3:0];
				end
				'b10: begin
					addReg1 <= switches[3:0];
					toShow3 <= switches[3:0];
				end
				'b11: begin
					addRegD <= switches[3:0];
					toShow3 <= switches[3:0];
				end
			endcase
		end
		else if(btn1==1) begin
			if(opcode!='b111) begin
				Bit#(8) result = evaluate(regFile.readReg1(addReg1), regFile.readReg2(addReg2), opcode);
				regFile.setRegAddD&WE(addRegD, switches[6]);
				regFile.setDataIn(result);
				toShow2 <= result[3:0];
				toShow1 <= regFile.readReg1(addReg1);
				toShow0 <= regFile.readReg2(addReg2);
				leds[0] <= result[7];
				leds[1] <= result[6];
				leds[2] <= result[5];
				leds[3] <= result[4];
			end
			else begin
				regFile.setRedAddD&WE(addRegD, switches[6]);
				regFile.setDataIn(dataInput);
				toShow3 <= dataInput;
			end
		end
		wait<=True;
	endrule: rulTakeInput&Process


			
	
	
	

	