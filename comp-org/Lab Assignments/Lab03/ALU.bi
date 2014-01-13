signature ALU where {
interface (ALU.ALU_ifc :: *) = {
    ALU.evaluate :: ¶Prelude®¶.¶Bit®¶ 4 ->
		    ¶Prelude®¶.¶Bit®¶ 4 -> ¶Prelude®¶.¶Bit®¶ 3 -> ¶Prelude®¶.¶Bit®¶ 8 {-# arg_names = [oprndA,
												       oprndB,
												       opcode] #-}
};
 
instance ALU ¶Prelude®¶.¶PrimMakeUndefined®¶ ALU.ALU_ifc;
							
instance ALU ¶Prelude®¶.¶PrimDeepSeqCond®¶ ALU.ALU_ifc;
						      
instance ALU ¶Prelude®¶.¶PrimMakeUninitialized®¶ ALU.ALU_ifc;
							    
ALU.mkALU :: (¶Prelude®¶.¶IsModule®¶ _m__ _c__) => _m__ ALU.ALU_ifc
}
