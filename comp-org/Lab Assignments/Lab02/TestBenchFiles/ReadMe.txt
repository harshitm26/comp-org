Main BSV files: Watch.bsv, Clock.bsv, SevSeg.bsv

Verilog modules: mkWatch.v (top level), mkClock.v , mkh2s.v

Tesbench modules: mkWatchTb.v, mkClockTb.v
Testbench executables: WatchTb.out, ClockTb.out

Various speed control registers of mkClock and mkWatch modules have been altered to observe their simulated behavious on PC within comfortable time scales

ClockTb.out shows time output from mkClock module in "hh mm ss" format

WatchTb.out shows output in following format while changing watch modes periodically:

AAAA SSSSSSS N

AAAA: indicates the anode selected
SSSSSSS: seven segment data for the selected anode
N: the seven segment data decoded to the corresponding number


See the BSV files for comments
