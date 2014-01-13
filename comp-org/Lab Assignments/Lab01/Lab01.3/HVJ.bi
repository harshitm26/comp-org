signature HVJ where {
interface (HVJ.H2s_ifc :: *) = {
    HVJ.decode :: ¶Prelude®¶.¶Bit®¶ 4 -> ¶Prelude®¶.¶Bit®¶ 7 {-# arg_names = [hex] #-}
};
 
instance HVJ ¶Prelude®¶.¶PrimMakeUndefined®¶ HVJ.H2s_ifc;
							
instance HVJ ¶Prelude®¶.¶PrimDeepSeqCond®¶ HVJ.H2s_ifc;
						      
instance HVJ ¶Prelude®¶.¶PrimMakeUninitialized®¶ HVJ.H2s_ifc;
							    
HVJ.mkh2s :: (¶Prelude®¶.¶IsModule®¶ _m__ _c__) => _m__ HVJ.H2s_ifc;
								   
interface (HVJ.Mukhya_ifc :: *) = {
    HVJ.retAnodeSelected :: ¶Prelude®¶.¶Bit®¶ 4 {-# arg_names = [] #-};
    HVJ.retSegmentData :: ¶Prelude®¶.¶Bit®¶ 7 {-# arg_names = [] #-};
    HVJ.updateInput :: ¶Prelude®¶.¶Bit®¶ 2 -> ¶Prelude®¶.¶Action®¶ {-# arg_names = [inp] #-}
};
 
instance HVJ ¶Prelude®¶.¶PrimMakeUndefined®¶ HVJ.Mukhya_ifc;
							   
instance HVJ ¶Prelude®¶.¶PrimDeepSeqCond®¶ HVJ.Mukhya_ifc;
							 
instance HVJ ¶Prelude®¶.¶PrimMakeUninitialized®¶ HVJ.Mukhya_ifc;
							       
HVJ.mkMukhya :: (¶Prelude®¶.¶IsModule®¶ _m__ _c__) => _m__ HVJ.Mukhya_ifc
}
