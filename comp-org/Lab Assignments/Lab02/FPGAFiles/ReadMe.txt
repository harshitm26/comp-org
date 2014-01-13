BSV Files: Clock.bsv, SevSeg.bsv, Watch.bsv
Verilog modules: mkWatch.v (top level), mkClock.v, mkh2s.v
UCF file: mkWatch.ucf

Internal frequency assumed: 50 MHz

Control the speed of the clock using decelerator register in Clock.bsv

Control the speed of the stopwatch using stopWatchDecelerator in Watch.bsv

Debouncing algorithm involves processing the last 8 time-spaced button states and output "High" if more than 4 of these states were "High" otherwise output "Low"



See the BSV files for comments