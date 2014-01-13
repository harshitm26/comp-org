package RegFile;

interface RegFile_ifc;
	method Action setAddRegD&WE(Bit#(4) addD, Bit#(1) write);
	method Action setDataIn(Bit#(4) inputData);
	method Bit#(4) readReg1(Bit#(4) add1);
	method Bit#(4) readReg2(Bit#(4) add2);
endinterface: RegFile_ifc

(*synthesize*)
module mkRegFile(RegFile_ifc);
	Reg#(Bit#(4)) file[16];
	for(Bit#(5) i=0; i<16; i=i+1)
		file[i] <- mkReg(0);
	Reg#(Bit#(4)) addRegD <- mkReg(0);
	Reg#(Bit#(4)) dataIn <- mkReg(0);
	Reg#(Bit#(1)) we <- mkReg(0);
	Reg#(Bit#(16)) decelerator <- mkReg(0);
	rule writer(we==1);
		file[addRegD] <= dataIn;
	endrule: writer
	method Action setAddRegD&WE(Bit#(4) addD, Bit#(1) write);
		addRegD <= addD;
		we <= write;;
	endmethod: setAddRegD
	method Action setDataIn (Bit#(4) inputData);
		dataIn <= inputData;
	endmethod: setDataIn
	method Bit#(4) readReg1(Bit#(4) add1);
		return file[add1];
	endmethod: readReg1
	method Bit#(4) readReg2(Bit#(4) add2);
		return file[add2];
	endmethod: readReg2
endmodule: mkRegFile
endpackage: RegFile
