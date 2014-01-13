signature Watch where {
import Clock;
	    
import SevSeg;
	     
data (Watch.SetStates :: *) =
    Watch.ALLSET () |
    Watch.SETTINGFIRST () |
    Watch.FIRSTSET () |
    Watch.SETTINGSECOND () |
    Watch.SECONDSET ();
		      
instance Watch ¶Prelude®¶.¶PrimMakeUndefined®¶ Watch.SetStates;
							      
instance Watch ¶Prelude®¶.¶PrimDeepSeqCond®¶ Watch.SetStates;
							    
instance Watch ¶Prelude®¶.¶PrimMakeUninitialized®¶ Watch.SetStates;
								  
instance Watch ¶Prelude®¶.¶Bits®¶ Watch.SetStates 3;
						   
instance Watch ¶Prelude®¶.¶Eq®¶ Watch.SetStates;
					       
data (Watch.ClockStates :: *) =
    Watch.MHHMM () |
    Watch.MMMSS () |
    Watch.MALARM () |
    Watch.MSTOPWATCH () |
    Watch.SETTINGHHMM () |
    Watch.SETTINGMMSS () |
    Watch.SETTINGALARM ();
			 
instance Watch ¶Prelude®¶.¶PrimMakeUndefined®¶ Watch.ClockStates;
								
instance Watch ¶Prelude®¶.¶PrimDeepSeqCond®¶ Watch.ClockStates;
							      
instance Watch ¶Prelude®¶.¶PrimMakeUninitialized®¶ Watch.ClockStates;
								    
instance Watch ¶Prelude®¶.¶Bits®¶ Watch.ClockStates 3;
						     
instance Watch ¶Prelude®¶.¶Eq®¶ Watch.ClockStates;
						 
data (Watch.StopWatchStates :: *) = Watch.PAUSED () | Watch.RUNNING ();
								      
instance Watch ¶Prelude®¶.¶PrimMakeUndefined®¶ Watch.StopWatchStates;
								    
instance Watch ¶Prelude®¶.¶PrimDeepSeqCond®¶ Watch.StopWatchStates;
								  
instance Watch ¶Prelude®¶.¶PrimMakeUninitialized®¶ Watch.StopWatchStates;
									
instance Watch ¶Prelude®¶.¶Bits®¶ Watch.StopWatchStates 1;
							 
instance Watch ¶Prelude®¶.¶Eq®¶ Watch.StopWatchStates;
						     
interface (Watch.Watch_ifc :: *) = {
    Watch.retAnodeSelected :: ¶Prelude®¶.¶Bit®¶ 4 {-# arg_names = [] #-};
    Watch.retSegmentData :: ¶Prelude®¶.¶Bit®¶ 7 {-# arg_names = [] #-};
    Watch.updateInput :: ¶Prelude®¶.¶Bit®¶ 3 ->
			 ¶Prelude®¶.¶Bit®¶ 6 -> ¶Prelude®¶.¶Action®¶ {-# arg_names = [btns, swtchs] #-};
    Watch.retLEDSignals :: ¶Prelude®¶.¶Bit®¶ 4 {-# arg_names = [] #-}
};
 
instance Watch ¶Prelude®¶.¶PrimMakeUndefined®¶ Watch.Watch_ifc;
							      
instance Watch ¶Prelude®¶.¶PrimDeepSeqCond®¶ Watch.Watch_ifc;
							    
instance Watch ¶Prelude®¶.¶PrimMakeUninitialized®¶ Watch.Watch_ifc;
								  
Watch.mkWatch :: (¶Prelude®¶.¶IsModule®¶ _m__ _c__) => _m__ Watch.Watch_ifc
}
