//
// Generated by Bluespec Compiler, version 2011.06.D (build 24470, 2011-06-30)
//
// On Mon Oct 10 19:36:20 IST 2011
//
// Method conflict info:
// Method: evaluate
// Conflict-free: evaluate
//
//
// Ports:
// Name                         I/O  size props
// evaluate                       O     8
// RDY_evaluate                   O     1 const
// CLK                            I     1 unused
// RST_N                          I     1 unused
// evaluate_oprndA                I     4
// evaluate_oprndB                I     4
// evaluate_opcode                I     3
//
// Combinational paths from inputs to outputs:
//   (evaluate_oprndA, evaluate_oprndB, evaluate_opcode) -> evaluate
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
`define BSV_ASSIGNMENT_DELAY
`endif

module mkALU(CLK,
	     RST_N,

	     evaluate_oprndA,
	     evaluate_oprndB,
	     evaluate_opcode,
	     evaluate,
	     RDY_evaluate);
  input  CLK;
  input  RST_N;

  // value method evaluate
  input  [3 : 0] evaluate_oprndA;
  input  [3 : 0] evaluate_oprndB;
  input  [2 : 0] evaluate_opcode;
  output [7 : 0] evaluate;
  output RDY_evaluate;

  // signals for module outputs
  wire [7 : 0] evaluate;
  wire RDY_evaluate;

  // remaining internal signals
  reg [3 : 0] IF_evaluate_opcode_EQ_0b0_THEN_evaluate_oprndA_ETC___d50;
  reg _theResult___snd__h86;
  wire [4 : 0] _0b0_CONCAT_evaluate_oprndA_PLUS_0b0_CONCAT_NEG_ETC__q2,
	       _0b0_CONCAT_evaluate_oprndA_PLUS_0b0_CONCAT_eva_ETC__q1;
  wire [3 : 0] result__h130,
	       result__h164,
	       result__h170,
	       result__h240,
	       result__h267,
	       result__h353,
	       result__h87;
  wire _theResult_____1__h203,
       _theResult_____2__h202,
       flagCarry__h165,
       flagParity__h26,
       flagZero__h28,
       parityBit__h362,
       parityBit__h390,
       parityBit__h418;

  // value method evaluate
  assign evaluate =
	     { _theResult___snd__h86,
	       flagParity__h26,
	       IF_evaluate_opcode_EQ_0b0_THEN_evaluate_oprndA_ETC___d50[3],
	       flagZero__h28,
	       IF_evaluate_opcode_EQ_0b0_THEN_evaluate_oprndA_ETC___d50 } ;
  assign RDY_evaluate = 1'd1 ;

  // remaining internal signals
  assign _0b0_CONCAT_evaluate_oprndA_PLUS_0b0_CONCAT_NEG_ETC__q2 =
	     { 1'b0, evaluate_oprndA } + { 1'b0, -evaluate_oprndB } ;
  assign _0b0_CONCAT_evaluate_oprndA_PLUS_0b0_CONCAT_eva_ETC__q1 =
	     { 1'b0, evaluate_oprndA } + { 1'b0, evaluate_oprndB } ;
  assign _theResult_____1__h203 =
	     IF_evaluate_opcode_EQ_0b0_THEN_evaluate_oprndA_ETC___d50[2] ?
	       parityBit__h390 :
	       _theResult_____2__h202 ;
  assign _theResult_____2__h202 =
	     IF_evaluate_opcode_EQ_0b0_THEN_evaluate_oprndA_ETC___d50[1] ?
	       parityBit__h418 :
	       IF_evaluate_opcode_EQ_0b0_THEN_evaluate_oprndA_ETC___d50[0] ;
  assign flagCarry__h165 = evaluate_oprndA == 4'b1111 ;
  assign flagParity__h26 =
	     IF_evaluate_opcode_EQ_0b0_THEN_evaluate_oprndA_ETC___d50[3] ?
	       parityBit__h362 :
	       _theResult_____1__h203 ;
  assign flagZero__h28 =
	     IF_evaluate_opcode_EQ_0b0_THEN_evaluate_oprndA_ETC___d50 ==
	     4'd0 ;
  assign parityBit__h362 = _theResult_____1__h203 + 1'd1 ;
  assign parityBit__h390 = _theResult_____2__h202 + 1'd1 ;
  assign parityBit__h418 =
	     IF_evaluate_opcode_EQ_0b0_THEN_evaluate_oprndA_ETC___d50[0] +
	     1'd1 ;
  assign result__h130 = evaluate_oprndA - evaluate_oprndB ;
  assign result__h164 = evaluate_oprndA + 4'd1 ;
  assign result__h170 = { evaluate_oprndA[2:0], 1'd0 } ;
  assign result__h240 = { 1'd0, evaluate_oprndA[3:1] } ;
  assign result__h267 = { evaluate_oprndA[3], evaluate_oprndA[3:1] } ;
  assign result__h353 = evaluate_oprndA & evaluate_oprndB ;
  assign result__h87 = evaluate_oprndA + evaluate_oprndB ;
  always@(evaluate_opcode or
	  evaluate_oprndA or
	  _0b0_CONCAT_evaluate_oprndA_PLUS_0b0_CONCAT_eva_ETC__q1 or
	  _0b0_CONCAT_evaluate_oprndA_PLUS_0b0_CONCAT_NEG_ETC__q2 or
	  flagCarry__h165)
  begin
    case (evaluate_opcode)
      3'b0:
	  _theResult___snd__h86 =
	      _0b0_CONCAT_evaluate_oprndA_PLUS_0b0_CONCAT_eva_ETC__q1[4];
      3'b001:
	  _theResult___snd__h86 =
	      _0b0_CONCAT_evaluate_oprndA_PLUS_0b0_CONCAT_NEG_ETC__q2[4];
      3'b010: _theResult___snd__h86 = flagCarry__h165;
      default: _theResult___snd__h86 =
		   evaluate_opcode == 3'b011 && evaluate_oprndA[3];
    endcase
  end
  always@(evaluate_opcode or
	  result__h87 or
	  result__h130 or
	  result__h164 or
	  result__h170 or result__h240 or result__h267 or result__h353)
  begin
    case (evaluate_opcode)
      3'b0:
	  IF_evaluate_opcode_EQ_0b0_THEN_evaluate_oprndA_ETC___d50 =
	      result__h87;
      3'b001:
	  IF_evaluate_opcode_EQ_0b0_THEN_evaluate_oprndA_ETC___d50 =
	      result__h130;
      3'b010:
	  IF_evaluate_opcode_EQ_0b0_THEN_evaluate_oprndA_ETC___d50 =
	      result__h164;
      3'b011:
	  IF_evaluate_opcode_EQ_0b0_THEN_evaluate_oprndA_ETC___d50 =
	      result__h170;
      3'b100:
	  IF_evaluate_opcode_EQ_0b0_THEN_evaluate_oprndA_ETC___d50 =
	      result__h240;
      3'b101:
	  IF_evaluate_opcode_EQ_0b0_THEN_evaluate_oprndA_ETC___d50 =
	      result__h267;
      3'b110:
	  IF_evaluate_opcode_EQ_0b0_THEN_evaluate_oprndA_ETC___d50 =
	      result__h353;
      3'd7: IF_evaluate_opcode_EQ_0b0_THEN_evaluate_oprndA_ETC___d50 = 4'd0;
    endcase
  end
endmodule  // mkALU

