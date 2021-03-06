//
// Generated by Bluespec Compiler, version 2011.06.D (build 24470, 2011-06-30)
//
// On Tue Aug 30 11:15:19 IST 2011
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

  // register led
  reg [6 : 0] led;
  wire [6 : 0] led$D_IN;
  wire led$EN;

  // register segm
  reg [3 : 0] segm;
  wire [3 : 0] segm$D_IN;
  wire segm$EN;

  // ports of submodule ctr
  wire [6 : 0] ctr$retled;
  wire [3 : 0] ctr$retsegm;

  // submodule ctr
  mkCtr ctr(.CLK(CLK),
	    .RST_N(RST_N),
	    .retled(ctr$retled),
	    .RDY_retled(),
	    .retsegm(ctr$retsegm),
	    .RDY_retsegm());

  // register led
  assign led$D_IN = ctr$retled ;
  assign led$EN = 1'd1 ;

  // register segm
  assign segm$D_IN = ctr$retsegm ;
  assign segm$EN = 1'd1 ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (!RST_N)
      begin
        led <= `BSV_ASSIGNMENT_DELAY 7'd0;
	segm <= `BSV_ASSIGNMENT_DELAY 4'd0;
      end
    else
      begin
        if (led$EN) led <= `BSV_ASSIGNMENT_DELAY led$D_IN;
	if (segm$EN) segm <= `BSV_ASSIGNMENT_DELAY segm$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    led = 7'h2A;
    segm = 4'hA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on

  // handling of system tasks

  // synopsys translate_off
  always@(negedge CLK)
  begin
    #0;
    if (RST_N) $display("Anode: %b\tLED Signal: %b\n", segm, led);
  end
  // synopsys translate_on
endmodule  // mkTb

