PSXBLD2 ;BIR/EJW-New warning label Data for Transmission ;10/26/04
 ;;2.0;CMOP;**54,71**;11 Apr 97;Build 1
 ;
 ;Reference to  ^PS(55,    supported by DBIA #2228
 ;Reference to WTEXT^PSSWRNA supported by DBIA #4444
 ;
NEWWARN ;Send All New warnings to CMOP in NTE11 & NTE11A
 ;  First 220 characters will be placed into the NTE11 segment, any
 ;  text > 220 will be placed into a continuation segment of NTE11A,
 ;  but only up to an additional max of 220 characters.
 ;
 N J,TEXT,W,TXT1,TXT2
 ;send English warnings
 F J=1:1:$L(WARN,",") S W=$P(WARN,",",J) Q:W=""  D
 .S TEXT=$$WTEXT^PSSWRNA(W)
 .Q:TEXT=""
 .S TXT1=$E(TEXT,1,220),TXT2=$E($E(TEXT,221,$L(TEXT)),1,220)
 .S MSG=MSG+1,PSXORD(MSG)="NTE|11|"_$P(RXY,"^")_"|ENG|"_W_"|"_TXT1
 .S:TXT2]"" MSG=MSG+1,PSXORD(MSG)="NTE|11A|"_$P(RXY,"^")_"|ENG|"_W_"|"_TXT2
 ;
 ;quit if Patient Not Language Spanish
 I $P($G(^PS(55,DFN,"LAN")),"^",2)'=2 Q
 ;quit also, if Patient Other Language Not Yes
 I '$P($G(^PS(55,DFN,"LAN")),"^") Q
 ;
 ;send Spanish warnings also
 F J=1:1:$L(WARN,",") S W=$P(WARN,",",J) Q:W=""  D
 .S TEXT=$$WTEXT^PSSWRNA(W,2)
 .Q:TEXT=""
 .S TXT1=$E(TEXT,1,220),TXT2=$E($E(TEXT,221,$L(TEXT)),1,220)
 .S MSG=MSG+1,PSXORD(MSG)="NTE|11|"_$P(RXY,"^")_"|SPA|"_W_"|"_TXT1
 .S:TXT2]"" MSG=MSG+1,PSXORD(MSG)="NTE|11A|"_$P(RXY,"^")_"|SPA|"_W_"|"_TXT2
 Q
