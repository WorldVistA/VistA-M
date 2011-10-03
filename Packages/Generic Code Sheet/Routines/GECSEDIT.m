GECSEDIT ;WISC/RFJ/KLD-create and edit code sheets                      ;13 Oct 98
 ;;2.0;GCS;**2,6,9,15,19,27**;MAR 14, 1995
 ;
 N %,DONTASK,GECS,GECSFLAG,GECSFXIT
 D ^GECSSITE Q:'$G(GECS("SITE"))
 I $L($G(GECSSYS)) S DONTASK=1
 W ! D BATTYPE^GECSUSEL($G(GECSSYS),$G(DONTASK)) Q:'$G(GECS("BATDA"))
 F  W ! D TRANTYPE^GECSUSEL($G(GECSSEGM),0) Q:$G(GECSFLAG)  I $G(GECS("TTDA")) D
 .   I $D(GECSFKP) S GECS("EDIT")=GECSFKP
 .   D NEWCS I '$G(GECS("CSDA")) Q
 .   I GECS("SYSID")="AMS" D AMIS I '$G(GECS("CSDA")) Q
 .   S %=$$CSEDIT
 .   I %<0 D KILLCS^GECSPUR1(GECS("CSDA")) W "  << CODE SHEET DELETED >>" Q
 .   I '%!($G(GECSFXIT)) D DELASK^GECSUTIL(GECS("CSDA")) I '$D(^GECS(2100,+$G(GECS("CSDA")),0)) Q
 .   I '$$MAPDATA^GECSXBLD(GECS("CSDA")) Q
 .   D ASKTOBAT^GECSXBL1(GECS("CSDA"))
 Q
 ;
 ;
NEWCS ;  get new code sheet number
 ;  return gecs("csname"),gecs("csda")
 N %,%DT,%Y,COUNTER,D0,DA,DI,DIC,DIE,DLAYGO,DQ,DR,GECSNAME,X,Y
 K GECS("CSNAME"),GECS("CSDA")
 F  S COUNTER=$$COUNTER^GECSUNUM(GECS("SITE")_"-"_GECS("SYSID")_"-"_GECS("FY")) Q:'COUNTER  D  Q:COUNTER
 .   S X=COUNTER_"-"_GECS("FY")
 .   ;  entry already in file 2100, get next counter
 .   I $D(^GECS(2100,"B",X)) S COUNTER=0 Q
 .   S DIC="^GECS(2100,",DIC(0)="LZ",DLAYGO=2100 D ^DIC K DLAYGO I Y'>0 S COUNTER=0 Q
 .   ;  existing entry selected
 .   I '$P(Y,"^",3) S COUNTER=0 Q
 I 'COUNTER Q
 ;
 W !!,"This code sheet has been assigned IDENTIFICATION NUMBER: ",$P(Y(0),"^")
 S GECSNAME=$P(Y(0),"^")
 S DIE="^GECS(2100,",DA=+Y
 S DR="1///"_GECS("SYSID")_";5///"_GECS("SITE")_";Q;6///"_GECS("SITE1")_";7///"_GECS("TT")_";9///NOW;9.01////"_$P(GECS("PER"),"^")_";10///"_GECS("EDIT")_";2///"_GECS("BATDA")
 D ^DIE I $D(Y) W !,"UNABLE TO CREATE CODE SHEET!" Q
 S GECS("CSDA")=DA,GECS("CSNAME")=GECSNAME
 Q
 ;
 ;
CSEDIT() ;  edit code sheet gecs(csda)
 ;  return -1 if code sheet not edit (for fms docs)
 ;  return 0 if ^ entered
 N %,%X,%Y,D,D0,DA,DI,DIC,DIE,DQ,DR,X,Y
 K GECSFXIT
 W !
 S (DIC,DIE)="^GECS(2100,",DA=GECS("CSDA")
 ;  edit control segment for fms
 I GECS("SYSID")="FMS" S DR="[PRCFMS:CONTROL]" W !!?5,"-- FMS Control Segment Data --" D ^DIE I $D(Y) Q -1
 S DR=GECS("EDIT")
 I GECS("SYSID")="FMS" W !!?5,"-- FMS Document Data --"
 I GECS("EDIT")["KEYPUNCH" W !?4 F %=1:1:75 W $S(%#10=0:$E(%),%#5=0:"+",1:".")
 D ^DIE
 I $D(Y) Q 0
 Q 1
 ;
 ;
EDIT ;  edit selected code sheet
 N %,GECS,GECSDA,GECSFXIT,GECSSTAT,GECSBTYP,ABORT,DIR
 D ^GECSSITE Q:'$D(GECS("SITE"))
 W ! D BATTYPE^GECSUSEL($G(GECSSYS),$S($L($G(GECSSYS)):1,1:0)) Q:'$G(GECS("BATDA"))
 S GECSBTYP=GECS("BATCH"),ABORT=0
 F  S GECSDA=$$CODESHET^GECSUSEL(GECSBTYP) Q:'GECSDA  D
 .   D VARIABLE^GECSUTIL(GECSDA)
 .   Q:$G(SITEM)
 .   I $G(GECS("TRANSFMSDA"))'="" D  Q:ABORT
 .   .   I $$GET1^DIQ(2100.1,GECS("TRANSFMSDA"),3,"I")="F" D  Q:ABORT
 .   .   .   W !!,"Current Status: Warning - "_$$GET1^DIQ(2100.1,GECS("TRANSFMSDA"),3,"E"),!
 .   .   .   S ABORT=1
 .   .   .   S DIR(0)="E",DIR("A")="Enter RETURN or '^' to exit"
 .   .   .   D ^DIR
 .   .   .   Q
 .   I $G(GECS("CSDA")) D  Q
 .   .   W ! S GECSSTAT=$$STATUS^GECSUSTA(GECS("CSDA")) W !
 .   .   I GECS("SYSID")="AMS" D AMIS I '$G(GECS("CSDA")) Q
 .   .   S %=$$CSEDIT
 .   .   I %<0!($G(GECSFXIT))
 .   .   I '$$MAPDATA^GECSXBLD(GECS("CSDA")) Q
 .   .   I GECSSTAT=0 D ASKTOBAT^GECSXBL1(GECS("CSDA")) Q
 .   .   I GECSSTAT=3,GECS("SYSID")="FMS" D ASKTOBAT^GECSXBL1(GECS("CSDA")) Q
 .   .   I GECSSTAT=3,$$ASKREBAT^GECSMUT1 S %=$$MARKBAT^GECSMUT1(GECS("CSDA"))
 .   D ERROR^GECSUTIL(GECSDA)
 Q
 ;
 ;
AMIS ;  ask amis month-year if system id = AMS
 N %,D,D0,DA,DI,DIC,DIE,DQ,DR,X,Y
 S (DIC,DIE)="^GECS(2100,",DA=GECS("CSDA"),DR=9.1 D ^DIE
 I $D(Y) K GECS("CSDA")
 Q
 ;
 ;
KEY ;  keypunch a code sheet
 ;  set variable gecsfkp=[input template]
 N GECSFKP
 S GECSFKP="[GECS KEYPUNCH]" D GECSEDIT
 Q
