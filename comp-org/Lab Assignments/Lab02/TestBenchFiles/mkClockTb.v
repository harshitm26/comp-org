//
// Generated by Bluespec Compiler, version 2011.06.D (build 24470, 2011-06-30)
//
// On Sat Sep 24 01:39:40 IST 2011
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

module mkClockTb(CLK,
		 RST_N);
  input  CLK;
  input  RST_N;

  // register decelerator
  reg [7 : 0] decelerator;
  wire [7 : 0] decelerator$D_IN;
  wire decelerator$EN;

  // ports of submodule clock
  wire [11 : 0] clock$dataMMSS;
  wire [10 : 0] clock$dataHHMM;
  wire [5 : 0] clock$setMM_mm, clock$setSS_ss;
  wire [4 : 0] clock$setHH_hh;
  wire clock$EN_pause,
       clock$EN_setHH,
       clock$EN_setMM,
       clock$EN_setSS,
       clock$EN_start;

  // submodule clock
  mkClock clock(.CLK(CLK),
		.RST_N(RST_N),
		.setHH_hh(clock$setHH_hh),
		.setMM_mm(clock$setMM_mm),
		.setSS_ss(clock$setSS_ss),
		.EN_pause(clock$EN_pause),
		.EN_start(clock$EN_start),
		.EN_setHH(clock$EN_setHH),
		.EN_setMM(clock$EN_setMM),
		.EN_setSS(clock$EN_setSS),
		.RDY_pause(),
		.RDY_start(),
		.RDY_setHH(),
		.RDY_setMM(),
		.RDY_setSS(),
		.dataHHMM(clock$dataHHMM),
		.RDY_dataHHMM(),
		.dataMMSS(clock$dataMMSS),
		.RDY_dataMMSS());

  // register decelerator
  assign decelerator$D_IN = decelerator + 8'd1 ;
  assign decelerator$EN = 1'd1 ;

  // submodule clock
  assign clock$setHH_hh = 5'h0 ;
  assign clock$setMM_mm = 6'h0 ;
  assign clock$setSS_ss = 6'h0 ;
  assign clock$EN_pause = 1'b0 ;
  assign clock$EN_start = 1'b0 ;
  assign clock$EN_setHH = 1'b0 ;
  assign clock$EN_setMM = 1'b0 ;
  assign clock$EN_setSS = 1'b0 ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (!RST_N)
      begin
        decelerator <= `BSV_ASSIGNMENT_DELAY 8'd0;
      end
    else
      begin
        if (decelerator$EN)
	  decelerator <= `BSV_ASSIGNMENT_DELAY decelerator$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    decelerator = 8'hAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on

  // handling of system tasks

  // synopsys translate_off
  always@(negedge CLK)
  begin
    #0;
    if (RST_N)
      if (decelerator == 8'd0)
	$display("%d %d %d\n",
		 clock$dataHHMM[10:6],
		 clock$dataHHMM[5:0],
		 clock$dataMMSS[5:0]);
  end
  // synopsys translate_on
endmodule  // mkClockTb
