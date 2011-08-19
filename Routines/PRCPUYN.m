PRCPUYN ;WISC/RFJ-yes,no reader                                    ;29 Dec 93
 ;;5.1;IFCAP;**108**;Oct 20, 2000;Build 10
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ;
YN(%) ;  yes, no reader
 ;  %=default answer [1=yes,2=no];
 ;  XP=prompt array [none,1,2,3...];
 ;  XH=help array [none,1,2,3...]
 N I,X
 I '$G(%) S %=3
 F  D  Q:$D(X)
 .   W:$D(XP) !,XP F I=1:1 Q:'$D(XP(I))  W !,XP(I)
 .   W "? ",$P("YES// ^NO// ^<YES/NO> ","^",%)
 .   R X:$S($D(DTIME):DTIME,1:300) E  W "  <<timeout>>" S X=0 Q
 .   I X["^" S X=0 Q
 .   S:X="" X=% S X=$TR($E(X),"yYnN","1122"),X=+X
 .   I X'=1,X'=2 D HELP K X Q
 .   W:$X>73 ! W $P("  (YES)^  (NO)","^",X)
 K XH,XP
 Q X
 ;
HELP I '$D(XH) W !,"You must enter a 'Yes' or a 'No', or you may enter an '^' to Quit",!! Q
 W:$L($G(XH)) !,XH F I=1:1 Q:'$D(XH(I))  W !,XH(I)
 W !
 Q
