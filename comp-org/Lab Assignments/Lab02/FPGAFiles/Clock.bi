signature Clock where {
interface (Clock.Clock_ifc :: *) = {
    Clock.pause :: ¶Prelude®¶.¶Action®¶ {-# arg_names = [] #-};
    Clock.start :: ¶Prelude®¶.¶Action®¶ {-# arg_names = [] #-};
    Clock.setHH :: ¶Prelude®¶.¶Bit®¶ 5 -> ¶Prelude®¶.¶Action®¶ {-# arg_names = [hh] #-};
    Clock.setMM :: ¶Prelude®¶.¶Bit®¶ 6 -> ¶Prelude®¶.¶Action®¶ {-# arg_names = [mm] #-};
    Clock.setSS :: ¶Prelude®¶.¶Bit®¶ 6 -> ¶Prelude®¶.¶Action®¶ {-# arg_names = [ss] #-};
    Clock.dataHHMM :: ¶Prelude®¶.¶Bit®¶ 11 {-# arg_names = [] #-};
    Clock.dataMMSS :: ¶Prelude®¶.¶Bit®¶ 12 {-# arg_names = [] #-}
};
 
instance Clock ¶Prelude®¶.¶PrimMakeUndefined®¶ Clock.Clock_ifc;
							      
instance Clock ¶Prelude®¶.¶PrimDeepSeqCond®¶ Clock.Clock_ifc;
							    
instance Clock ¶Prelude®¶.¶PrimMakeUninitialized®¶ Clock.Clock_ifc;
								  
Clock.mkClock :: (¶Prelude®¶.¶IsModule®¶ _m__ _c__) => _m__ Clock.Clock_ifc
}
