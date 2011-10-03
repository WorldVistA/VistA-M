GECSXBL1 ;WISC/RFJ-ask to mark code sheets for batching             ;01 Nov 93
 ;;2.0;GCS;**2**;MAR 14, 1995
 Q
 ;
 ;
ASKTOBAT(GECSDA) ;  ask to mark code sheet gecsda for batching
 ;  if variable GECSAUTO="BATCH" then auto-mark for batch without asking
 ;  if variable GECSAUTO="SAVE" then retain in file
 N %,GECSFLAG,X,Y
 ;
 ;  retain in file
 I $G(GECSAUTO)="SAVE" Q
 ;
 ;  automatically mark for batching without asking
 I $G(GECSAUTO)="BATCH" S %=$$MARKBAT^GECSMUT1(GECSDA) Q
 ;
 ;  ask to mark for batching
 F  D  Q:$G(GECSFLAG)
 .   S DIR(0)="S^1:"_$S(GECS("SYSID")="FMS":"Transmit FMS Document",1:"Mark the Code Sheet For Batching")
 .   S DIR(0)=DIR(0)_";2:Edit the Code Sheet;3:Delete the Code Sheet;4:Retain the Code Sheet in the File for Editing Later;5:Print the Code Sheet;"
 .   S DIR("A")="CODE SHEET ACTION",DIR("B")=$S(GECS("SYSID")="FMS":4,1:1) D ^DIR K DIR
 .   ;
 .   I Y=4!$D(DTOUT)!($D(DUOUT)) W !,"CODE SHEET HAS BEEN RETAINED IN THE FILE FOR EDITING LATER!" D RETAIN^GECSUSTA(GECSDA) S GECSFLAG=1 Q
 .   ;  fms code sheets, transmit using stack file
 .   I Y=1,GECS("SYSID")="FMS" D TRANSMIT^GECSUFMS S GECSFLAG=1 Q
 .   ;
 .   I Y=1 S %=$$MARKBAT^GECSMUT1(GECSDA) S:% GECSFLAG=1 Q
 .   I Y=2 S %=$$CSEDIT^GECSEDIT,%=$$MAPDATA^GECSXBLD(GECS("CSDA")) S:'% GECSFLAG=1 Q
 .   I Y=3 D  Q
 .   .   D DELASK^GECSUTIL(GECSDA)
 .   .   I '$D(^GECS(2100,GECSDA)) K GECS("CSDA"),GECS("CSNAME") S GECSFLAG=1
 .   I Y=5 D
 .   .   S %ZIS="Q" D ^%ZIS I POP Q
 .   .   I '$D(IO("Q")) U IO D PRINT^GECSUTIL(GECSDA) D ^%ZISC Q
 .   .   I $D(IO("Q")) K IO("Q") S ZTRTN="PRINTDQ^GECSUTIL",ZTDESC="Print Generic Code Sheet",ZTSAVE("GECSDA")="",ZTIO=IO_";"_IOST_";"_IOM_";"_IOSL D ^%ZTLOAD
 Q
