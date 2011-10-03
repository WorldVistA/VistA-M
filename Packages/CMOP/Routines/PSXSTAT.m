PSXSTAT ;BIR/WPB-Routine to Display Statistics ;08 APR 1997 2:06 PM
 ;;2.0;CMOP;**41**;11 Apr 97
 ;Reference to ^PS(59 supported by DBIA #1976
 ;
EXIT K RETRAN,RETRANS,SENDR,STAT,TDATE,X,Y,BAT,CLOSED,CNT,DIV,DPT,FILL,LINE
 K %ZIS,PSXLION,SYSTEM,SYS,CDOM,FDOM,FAC,SYSSTAT,PP,PURG,XX,XMIT,PDTTM
 K CMOP,NAME,RX,COMFLAG,PSXBAT,SS,ACT,AA,ACTIVE,SSN,SS,RECVD,NOTE,STATUS
 K TT,ZZ,DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
QUE S ZTRTN="RPT^PSXSTAT",ZTIO=PSXLION,ZTSAVE("COMFLAG")="",ZTSAVE("PSXBAT")="",ZTSAVE("DTAIL")="",ZTDESC="CMOP Transmission Inquiry Report" D ^%ZTLOAD
 I $D(ZTSK)[0 W !!,"Job Canceled"
 E  W !!,"Job Queued"
 D HOME^%ZIS
 Q
BATCH ;displays the status of a batch - called from the CMOP MGR menu
 S COMFLAG=0
BB S BAT=0 F  S BAT=$O(^PSX(550.2,BAT)) Q:BAT'>0!(BAT="")  S PSXBAT=BAT
 I $G(PSXBAT)=""!($G(PSXBAT)=0) W !,"A transmission has not been created yet." Q
 S:$G(PSXBAT) PSXBATNM=$$GET1^DIQ(550.2,PSXBAT,.01)
 ;S DIC(0)="AEMQZ",DIC="^PSX(550.2,",DIC("B")=$G(PSXBATNM),DIC("S")="I $D(^PSX(550.2,""B"",+Y))" D ^DIC K DIC G:$D(DTOUT)!($D(DUOUT))!($G(Y)'>0) EXIT S PSXBAT=+Y K Y
 S DIC(0)="AEMQZ",DIC="^PSX(550.2,",DIC("B")=$G(PSXBATNM) D ^DIC K DIC G:$D(DTOUT)!($D(DUOUT))!($G(Y)'>0) EXIT S PSXBAT=+Y K Y
 S:$G(PSXBAT) PSXBATNM=$$GET1^DIQ(550.2,PSXBAT,.01)
 ;S TT=$O(^PSX(550.2,"B",$G(PSXBATNM),"")) I $G(TT)'>0 W !,"Transmission "_PSXBAT_" doesn't exist." K TT,PSXBAT,BAT,X,Y G BATCH
 W !
DEV ;I COMFLAG=0 S %ZIS="Q" D ^%ZIS S PSXLION=ION I POP W !,"NO DEVICE SELECTED" G EXIT
 ;I $D(IO("Q")) D QUE,EXIT Q
 ;Called by Taskman to produce Statistical Report
RPT S Y=$P($G(^PSX(550.2,PSXBAT,0)),U,6) X ^DD("DD") S TDATE=Y K Y
 S RETRAN=$P($G(^PSX(550.2,PSXBAT,1)),U,3)
 S DIV=$P($G(^PS(59,$P($G(^PSX(550.2,PSXBAT,0)),U,3),0)),U,1)
 S CMOP=$P($G(^PSX(550,$P($G(^PSX(550.2,PSXBAT,0)),U,4),0)),U,1)
 S SENDR=$P($G(^VA(200,$P($G(^PSX(550.2,PSXBAT,0)),U,5),0)),U,1)
 S Y=$P($G(^PSX(550.2,PSXBAT,1)),U,4) X ^DD("DD") S CLOSED=Y K Y
 S Y=$P($G(^PSX(550.2,PSXBAT,1)),U,1) X ^DD("DD") S RECVD=Y K Y
 S STAT=$P($G(^PSX(550.2,PSXBAT,0)),U,2) S STATUS=$S(STAT=1:"Opened",STAT=2:"Transmitted",STAT=3:"Acknowledged",STAT=4:"Closed",STAT=5:"Retransmitted",1:"")
 I $G(COMFLAG)'=1 W @IOF,!!!,?30,"View Transmission"
 W !!!,"Division",?25,":",?27,DIV
 W !,"CMOP",?25,":",?27,CMOP
 W !,"Transmission number",?25,":",?27,PSXBAT,?50,"Status",?62,":  ",?65,STATUS
 I $G(RETRAN)'="" W !,"Retransmission of batch",?25,":",?27,RETRAN
 W !,"Sender",?25,":",?27,SENDR
 W !,"Transmission date/time",?25,":",?27,TDATE
 I RECVD'="" W !,"Received date/time",?25,":",?27,RECVD
 I CLOSED'="" W !,"Closed date/time",?25,":",?27,CLOSED
 W !,"Beginning order number",?25,":",?27,$P($G(^PSX(550.2,PSXBAT,1)),U,5),?50,"Total orders:",?65,$P($G(^PSX(550.2,PSXBAT,1)),U,7)
 W !,"Ending order number",?25,":",?27,$P($G(^PSX(550.2,PSXBAT,1)),U,6),?50,"Total Rxs   : ",?65,$P($G(^PSX(550.2,PSXBAT,1)),U,8)
 I $G(COMFLAG)'=1&($D(^PSX(550.2,PSXBAT,3,1,0))) W !!,"Comments: " S CNT=0 F  S CNT=$O(^PSX(550.2,PSXBAT,3,CNT)) Q:CNT'>0  S NOTE=$G(^PSX(550.2,PSXBAT,3,CNT,0)) W !,NOTE
 ;I $G(COMFLAG)'=1 W ! S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR W @IOF
 I $G(COMFLAG)'=1 W ! S DIR(0)="Y",DIR("A")="View another transmission",DIR("B")="NO" D ^DIR K DIR I $G(Y)=1 W @IOF G BATCH
 I COMFLAG=1 D EDIT
 G EXIT
 Q
COMM ;code to enter the comment field of PSX(550.2 - called from the
 ;CMOP MGR menu
 S COMFLAG=1
 G BB
EDIT L +^PSX(550.2,PSXBAT):30 I '$T W !!,"This record is currently in use, try later." Q
 S DA=PSXBAT,DIE="^PSX(550.2,",DR="16" D ^DIE K DIE,DA,DR L -^PSX(550.2,PSXBAT)
 Q
COMM514 ; Enter batch comments in 552.1  called from option PSX COMMENT
 S CFLAG=1
 D SHOW G:$G(REC)="" EXIT1
 S DA=REC K Y L +PSX(552.1,DA):600
 S DIE="^PSX(552.1,",DR="15" D ^DIE L -^PSX(552.1,DA) K DIE,DR,DA
EXIT1 K REC,DTOUT,DIRUT,DIROUT,DUOUT,DIC,DIC(0),NODE0,NODE1,NODE2,NODEP,Y,X,STAT,I,CFLAG
 Q
SHOW S DIC=552.1,DIC(0)="AEQMZ",DIC("A")="FACILITY BATCH REFERENCE:  " D ^DIC K DIC S REC=+Y G:(+Y<1)!($G(DTOUT))!($G(DUOUT)) EXIT1
 S NODE0=$G(^PSX(552.1,+Y,0)),NODE1=$G(^PSX(552.1,+Y,1)),NODE2=$G(^PSX(552.1,+Y,2)),NODEP=$G(^PSX(552.1,+Y,"P")),STAT=$P(NODE0,"^",2)
 I $G(CFLAG)="" W @IOF,!!!,?28,"VIEW TRANSMISSION"
SHOW1 W !!,"Transmission",?17,":",?19,$P(NODE0,"^",1),?39,"Transmitted",?52,":",?54,$$FMTE^XLFDT($P(NODE0,"^",3),"1P")
 W !,"Status",?17,":",?19,$S(STAT=1:"Received",STAT=2:"Queued",STAT=3:"Processed",STAT=4:"Closed",STAT=5:"Hold",STAT=6:"Printed",STAT=99:"Rejected",1:""),?39,"Received",?52,":",?54,$$FMTE^XLFDT($P(NODE0,"^",4),"1P")
 W !,"Division",?17,":",?19,$E($P(NODEP,"^",1),1,18) I "34"[$G(STAT) W ?39,"Processed",?52,":",?54,$$FMTE^XLFDT($P(NODE0,"^",6),"1P")
 W !,"Sender",?17,":",?19,$E($P(NODEP,"^",3),1,18) I $G(STAT)=4 W ?39,"Closed",?52,":",?54,$$FMTE^XLFDT($P(NODE0,"^",5),"1P")
 W !,"Beginning order #",?17,":",?19,$P(NODE1,"^",1),?39,"Total orders",?52,":",?54,$P(NODE1,"^",3)
 W !,"Ending order #",?17,":",?19,$P(NODE1,"^",2),?39,"Total Rx's",?52,":",?54,$P(NODE1,"^",4)
 I $G(NODE2)'="" W !,"Retransmission of ",$P(NODE2,"^",2)
 I $G(CFLAG)'=1,($G(^PSX(552.1,REC,3,0)))'="" W !!,"Comments: " F I=0:0 S I=$O(^PSX(552.1,REC,3,I)) Q:I'>0  W $G(^PSX(552.1,REC,3,I,0)),!
 ;I $G(CFLAG)'=1 W ! S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR W @IOF
 I $G(CFLAG)'=1 W ! S DIR(0)="Y",DIR("A")="View another transmission",DIR("B")="NO" D ^DIR K DIR I $G(Y)=1 W @IOF G SHOW
 I $G(CFLAG)="" D EXIT1
 Q
