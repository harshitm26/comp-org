signature RegFile where {
interface (RegFile.RegFile_ifc :: *) = {
    RegFile.setAddRegD :: ¶Prelude®¶.¶Bit®¶ 4 -> ¶Prelude®¶.¶Action®¶ {-# arg_names = [addD] #-};
    RegFile.setWE :: ¶Prelude®¶.¶Bit®¶ 1 -> ¶Prelude®¶.¶Action®¶ {-# arg_names = [write] #-};
    RegFile.setDataIn :: ¶Prelude®¶.¶Bit®¶ 4 -> ¶Prelude®¶.¶Action®¶ {-# arg_names = [inputData] #-};
    RegFile.readReg1 :: ¶Prelude®¶.¶Bit®¶ 4 -> ¶Prelude®¶.¶Bit®¶ 4 {-# arg_names = [add1] #-};
    RegFile.readReg2 :: ¶Prelude®¶.¶Bit®¶ 4 -> ¶Prelude®¶.¶Bit®¶ 4 {-# arg_names = [add2] #-}
};
 
instance RegFile ¶Prelude®¶.¶PrimMakeUndefined®¶ RegFile.RegFile_ifc;
								    
instance RegFile ¶Prelude®¶.¶PrimDeepSeqCond®¶ RegFile.RegFile_ifc;
								  
instance RegFile ¶Prelude®¶.¶PrimMakeUninitialized®¶ RegFile.RegFile_ifc;
									
RegFile.mkRegFile :: (¶Prelude®¶.¶IsModule®¶ _m__ _c__) => _m__ RegFile.RegFile_ifc
}
