ZISX ;SF/GFT,AC - PROGRAM THAT XECUTES NODES IN ^%ZIS GLOBAL. ;10/26/2011
 ;;8.0;KERNEL;**585**;Jul 10, 1995;Build 22
 ;Close execute
X3 D XECUTE($G(^%ZIS(2,+IOST(0),3))) Q
X31 ;X ^%ZIS(2,+IOST(0),3.1) Q  ;Old code
 ;Open printer port
X10 D XECUTE($G(^%ZIS(2,IO("S"),10))) Q
 ;Close printer port
X11 D XECUTE($G(^%ZIS(2,+IO("S"),11))) K IO("S") Q
 ;Pre-Close
XPCX D XECUTE($G(^%ZIS(1,+IOS,"PCX"))) Q
XPOX(X) ;Execute pre-open execute code.
 D XECUTE($G(^%ZIS(1,+X,"POX"))) Q
 ;General
%Y D XECUTE($G(%Y)) Q
XS X %ZIS("S") Q
XW X %ZIS("W") Q
 ;
 ;**P585 START CJM
 ;ignore calls to CLOSE^NVSPRTU and PREOPEN^NVSPRTU if the device type is "PQ"=Print Queue
XECUTE(NODE) ;
 I ($G(%ZTYPE)="PQ")!($G(IOT)="PQ") D
 .N REPLACE
 .S REPLACE("PREOPEN^NVSPRTU")="PREOPEN^ZISX"
 .S REPLACE("CLOSE^NVSPRTU")="CLOSE^ZISX"
 .S NODE=$$REPLACE^XLFSTR(NODE,.REPLACE)
 .X NODE
 E  D
 .X NODE
 Q
CLOSE ;
 Q
PREOPEN(X) ;
 Q $G(X)
 ;**P585 END
