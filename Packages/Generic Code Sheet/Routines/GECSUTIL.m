GECSUTIL ;WISC/RFJ/KLD-code sheet utilities                             ;13 Oct 98
 ;;2.0;GCS;**1,19**;MAR 14, 1995
 Q
 ;
 ;
DELASK(GECSDA) ;  ask to delete the code sheet gecsda
 N %,GECSBATC
 S XP="ARE YOU SURE YOU WANT TO DELETE THE CODE SHEET",XH="Enter 'YES' to delete."
 W ! I $$YN(2)'=1 S %=$$STATUS^GECSUSTA(GECSDA) Q
 S GECSBATC=$P($G(^GECS(2100,GECSDA,"TRANS")),"^",9)
 D KILLCS^GECSPUR1(GECSDA) W "  << CODE SHEET DELETED >>"
 I $L(GECSBATC) D KILLBATC^GECSMUT1(GECSBATC)
 Q
 ;
 ;
PRINTDQ ;  taskman comes here to print code sheet gecsda
 D PRINT(GECSDA)
 Q
 ;
 ;
PRINT(GECSDA) ;  print code sheet gecsda
 N %,D,DA1,GECSFLAG,LINE
 I '$D(IO) S IOP="HOME" D ^%ZIS K IOP
 W !!,"TRANSMITTED CODE SHEET FOR ID# ",$P(^GECS(2100,GECSDA,0),"^")," WILL BE AS FOLLOWS:",!
 F %=1:1:79 W $S(%#10=0:$E(%),%#5=0:"+",1:".")
 S LINE=1,DA1=0 F  S DA1=$O(^GECS(2100,GECSDA,"CODE",DA1)) Q:'DA1!($G(GECSFLAG))  S D=$G(^(DA1,0)) I D'="" D
 .   I '$D(ZTQUEUED),IO=IO(0),$E(IOST)="C",LINE=20 D  Q:$G(GECSFLAG)
 .   .   S LINE=1
 .   .   D PAUSE Q:$G(GECSFLAG)
 .   .   W !! F %=1:1:79 W $S(%#10=0:$E(%),%#5=0:"+",1:".")
 .   W !,D
 .   S LINE=LINE+1
 W !
 I LINE>13 D R
 Q
 ;
 ;
VARIABLE(GECSDA)   ;  set up variables for code sheet gecsda
 N D,GECSFLAG,GECSFNOP
 K GECS
 S D=$G(^GECS(2100,+GECSDA,0)) I D="" W !,"CODE SHEET MISSING" Q
 S GECS("CSDA")=+GECSDA
 S GECS("CSNAME")=$P(D,"^")
 S GECS("SYSID")=$P(D,"^",2)
 S GECS("BATDA")=+$P(D,"^",3)
 S GECS("BATCH")=$P($G(^GECS(2101.1,GECS("BATDA"),0)),"^")
 S GECS("SITE")=$P(D,"^",6)
 S GECS("SITE1")=$P(D,"^",7)
 S GECS("TT")=$P(D,"^",8) S:GECS("TT")="" GECS("TT")=" "
 S GECS("TTDA")=+$O(^GECS(2101.2,"B",GECS("TT"),0))
 S GECS("EDIT")=$P(D,"^",11) S:GECS("EDIT")="" GECS("EDIT")="[ ]"
 S GECS("TRANSFMS")=$P($G(^GECS(2100,+GECSDA,"TRANS")),"^",3)
 I GECS("TRANSFMS")'="" D
 . S GECS("TRANSFMSDA")=$O(^GECS(2100.1,"B",GECS("TRANSFMS"),""))
 ;  check variables
 I GECS("CSNAME")="" W !,"CODE SHEET NAME MISSING" S GECSFLAG=1
 I GECS("SYSID")="" W !,"SYSTEM IDENTIFIER MISSING" S GECSFLAG=1
 I GECS("BATCH")="" W !,"BATCH TYPE MISSING" S GECSFLAG=1
 I 'GECS("SITE") W !,"STATION NUMBER MISSING" S GECSFLAG=1
 I 'GECS("TTDA") W !,"TRANSACTION TYPE/SEGMENT MISSING" S GECSFLAG=1
 I '$O(^DIE("B",$E(GECS("EDIT"),2,$L(GECS("EDIT"))-1),0)) W !,"EDIT TEMPLATE MISSING" S GECSFLAG=1
 I GECS("SITE") S GECSFNOP=1 D GETSITE^GECSSITE($O(^DIC(4,"D",GECS("SITE")_GECS("SITE1"),0))) I '$D(GECS("SITE")) S GECSFLAG=1
 I $G(GECSFLAG) K GECS
 Q
 ;
 ;
ERROR(GECSDA) ;  error in code sheet variables
 W !!,"SINCE THERE ARE DATA ERRORS FOR THIS CODE SHEET, IT CANNOT BE EDITTED.",!,"THIS CODE SHEET SHOULD BE DELETED AND RE-ENTERED AS A NEW CODE SHEET."
 D DELASK^GECSUTIL(GECSDA)
 Q
 ;
 ;
R ;  press return to continue
 N X U IO(0) W !,"<Press RETURN to continue>" R X:DTIME Q
 ;
 ;
PAUSE ;  pause
 N X U IO(0) W !,"Press RETURN to continue, '^' to exit:" R X:DTIME S:'$T X="^" S:X["^" GECSFLAG=1 U IO Q
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
 W !,XH F I=1:1 Q:'$D(XH(I))  W !,XH(I)
 W !
 Q
