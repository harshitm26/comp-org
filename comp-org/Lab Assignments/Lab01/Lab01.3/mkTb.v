//
// Generated by Bluespec Compiler, version 2011.06.D (build 24470, 2011-06-30)
//
// On Thu Sep  1 21:43:38 IST 2011
//
// Method conflict info:
// (none)
//
// Ports:
// Name                         I/O  size props
// CLK                            I     1 clock
// RST_N                          I     1 reset
//
// No combinational paths from inputs to outputs
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
`define BSV_ASSIGNMENT_DELAY
`endif

module mkTb(CLK,
	    RST_N);
  input  CLK;
  input  RST_N;

  // register counterDisplay
  reg [11 : 0] counterDisplay;
  wire [11 : 0] counterDisplay$D_IN;
  wire counterDisplay$EN;

  // register counterSimulateSwitches
  reg [15 : 0] counterSimulateSwitches;
  wire [15 : 0] counterSimulateSwitches$D_IN;
  wire counterSimulateSwitches$EN;

  // register simulateSwitches
  reg [1 : 0] simulateSwitches;
  wire [1 : 0] simulateSwitches$D_IN;
  wire simulateSwitches$EN;

  // ports of submodule mukhya
  wire [6 : 0] mukhya$retSegmentData;
  wire [3 : 0] mukhya$retAnodeSelected;
  wire [1 : 0] mukhya$updateInput_inp;
  wire mukhya$EN_updateInput;

  // submodule mukhya
  mkMukhya mukhya(.CLK(CLK),
		  .RST_N(RST_N),
		  .updateInput_inp(mukhya$updateInput_inp),
		  .EN_updateInput(mukhya$EN_updateInput),
		  .retAnodeSelected(mukhya$retAnodeSelected),
		  .RDY_retAnodeSelected(),
		  .retSegmentData(mukhya$retSegmentData),
		  .RDY_retSegmentData(),
		  .RDY_updateInput());

  // register counterDisplay
  assign counterDisplay$D_IN = counterDisplay + 12'd1 ;
  assign counterDisplay$EN = 1'd1 ;

  // register counterSimulateSwitches
  assign counterSimulateSwitches$D_IN = counterSimulateSwitches + 16'd1 ;
  assign counterSimulateSwitches$EN = 1'b1 ;

  // register simulateSwitches
  assign simulateSwitches$D_IN = simulateSwitches + 2'b01 ;
  assign simulateSwitches$EN = counterSimulateSwitches == 16'd0 ;

  // submodule mukhya
  assign mukhya$updateInput_inp = simulateSwitches + 2'b01 ;
  assign mukhya$EN_updateInput = counterSimulateSwitches == 16'd0 ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (!RST_N)
      begin
        counterDisplay <= `BSV_ASSIGNMENT_DELAY 12'd0;
	counterSimulateSwitches <= `BSV_ASSIGNMENT_DELAY 16'd0;
	simulateSwitches <= `BSV_ASSIGNMENT_DELAY 2'd0;
      end
    else
      begin
        if (counterDisplay$EN)
	  counterDisplay <= `BSV_ASSIGNMENT_DELAY counterDisplay$D_IN;
	if (counterSimulateSwitches$EN)
	  counterSimulateSwitches <= `BSV_ASSIGNMENT_DELAY
	      counterSimulateSwitches$D_IN;
	if (simulateSwitches$EN)
	  simulateSwitches <= `BSV_ASSIGNMENT_DELAY simulateSwitches$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    counterDisplay = 12'hAAA;
    counterSimulateSwitches = 16'hAAAA;
    simulateSwitches = 2'h2;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on

  // handling of system tasks

  // synopsys translate_off
  always@(negedge CLK)
  begin
    #0;
    if (RST_N)
      if (counterDisplay == 12'd0)
	$display("Switch: %b\tAnode selected: %b\tLED Signal: %b\n",
		 simulateSwitches,
		 mukhya$retAnodeSelected,
		 mukhya$retSegmentData);
  end
  // synopsys translate_on
endmodule  // mkTb

