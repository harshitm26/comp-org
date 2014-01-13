signature Counter where {
interface (Counter.H2s_ifc :: *) = {
    Counter.decode :: ¶Prelude®¶.¶Bit®¶ 4 -> ¶Prelude®¶.¶Bit®¶ 7 {-# arg_names = [hex] #-};
    Counter.dispsegment :: ¶Prelude®¶.¶Bit®¶ 4 {-# arg_names = [] #-}
};
 
instance Counter ¶Prelude®¶.¶PrimMakeUndefined®¶ Counter.H2s_ifc;
								
instance Counter ¶Prelude®¶.¶PrimDeepSeqCond®¶ Counter.H2s_ifc;
							      
instance Counter ¶Prelude®¶.¶PrimMakeUninitialized®¶ Counter.H2s_ifc;
								    
Counter.mkh2s :: (¶Prelude®¶.¶IsModule®¶ _m__ _c__) => _m__ Counter.H2s_ifc;
									   
interface (Counter.Ctr_ifc :: *) = {
    Counter.retled :: ¶Prelude®¶.¶Bit®¶ 7 {-# arg_names = [] #-};
    Counter.retsegm :: ¶Prelude®¶.¶Bit®¶ 4 {-# arg_names = [] #-}
};
 
instance Counter ¶Prelude®¶.¶PrimMakeUndefined®¶ Counter.Ctr_ifc;
								
instance Counter ¶Prelude®¶.¶PrimDeepSeqCond®¶ Counter.Ctr_ifc;
							      
instance Counter ¶Prelude®¶.¶PrimMakeUninitialized®¶ Counter.Ctr_ifc;
								    
Counter.mkCtr :: (¶Prelude®¶.¶IsModule®¶ _m__ _c__) => _m__ Counter.Ctr_ifc
}
