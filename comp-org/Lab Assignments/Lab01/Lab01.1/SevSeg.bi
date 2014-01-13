signature SevSeg where {
interface (SevSeg.H2s_ifc :: *) = {
    SevSeg.decode :: ¶Prelude®¶.¶Bit®¶ 4 -> ¶Prelude®¶.¶Bit®¶ 7 {-# arg_names = [hex] #-};
    SevSeg.dispsegment :: ¶Prelude®¶.¶Bit®¶ 4 {-# arg_names = [] #-}
};
 
instance SevSeg ¶Prelude®¶.¶PrimMakeUndefined®¶ SevSeg.H2s_ifc;
							      
instance SevSeg ¶Prelude®¶.¶PrimDeepSeqCond®¶ SevSeg.H2s_ifc;
							    
instance SevSeg ¶Prelude®¶.¶PrimMakeUninitialized®¶ SevSeg.H2s_ifc;
								  
SevSeg.mkh2s :: (¶Prelude®¶.¶IsModule®¶ _m__ _c__) => _m__ SevSeg.H2s_ifc
}
