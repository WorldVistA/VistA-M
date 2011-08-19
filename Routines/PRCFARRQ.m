PRCFARRQ ;WISC@ALTOONA/CTB-QUEUE RECEIVING REPORT FOR TRANSMISSION ;7/18/95  12:05
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
LOAD Q:$$QUEUED
 Q:$P(^PRC(442,PRCFA("PODA"),0),U,2)=25
 S X=$P(PRC("PARAM"),"^",6),X=$S(X=1:"NOW",X=2:"LATER",1:"MAIL") D @X Q
NOW I '$D(^XUSEC("PRCFA TRANSMIT",DUZ)) G LATER
 S %A="Are you sure you wish to send this Receiving Report to Austin",%B="A 'NO' or an '^' will prevent release to Austin.",%=1 D ^PRCFYN
 I %'=1 S X="  Receiving Report has NOT been released to Austin.*" D MSG^PRCFQ Q
 S ZTDTH=$H,ZTIO="",ZTSAVE("PRC*")="",ZTSAVE("PRCFA*")="",ZTDESC="TRANSMIT RR "_$P(^PRC(442,PRCFA("PODA"),0),"^")_"-"_PRCFA("PARTIAL")_" TO AUSTIN",ZTRTN="^PRCFARRT" D ^%ZTLOAD K ZTSK
 S X="Receiving Report Queued for Immediate Transmission*" D MSG^PRCFQ Q
LATER ;STORE DATA IN FILE 442.9 FOR LATER RELEASE OF RECEIVING REPORT
 S %A="Are you sure you wish to send this Receiving Report to Austin",%B="A 'NO' or an '^' will prevent release to Austin.",%=1 D ^PRCFYN
 I %'=1 S X="  Receiving Report has NOT been released to Austin.*" D MSG^PRCFQ Q
 I $G(PRCACT)="E",$P(^PRC(442,PRCFA("PODA"),11,PRCFA("PARTIAL"),0),"^",19)]"" D  Q
 . W !!?5,"This receiving report has already been transmitted to Austin."
 . W !?5,"It may NOT be rereleased using this option."
 . W !?5,"RECEIVING REPORT HAS NOT BEEN RELEASED.",$C(7)
 . Q
 S DIC=442.9,DIC(0)="ML",DLAYGO=442.9,X=$P(^PRC(442,PRCFA("PODA"),0),"^",1)_"."_PRCFA("PARTIAL") D ^DIC K DIC,DLAYGO
 I +Y<0 W !,"Unable to Queue at this time, Please use option to queue manually.",$C(7) Q
 S DA=+Y,DR="1////"_PRCFA("PODA")_";2////"_+PRC("PER")_";3//T;4////"_$S('$D(PRCFA("RETRANS")):"",1:1),DIE="^PRC(442.9," D ^DIE
 S X="Receiving report placed on transmission list.*" D MSG^PRCFQ
 Q
MAIL S X="Don't forget to mail this Receiving Report to Austin.*" D MSG^PRCFQ
 Q
SINGLE ;QUEUE SINGLE RECEIVING REPORT FOR TRANSMISSION
 S PRCF("X")="AS" D ^PRCFSITE Q:'%  S DIC("A")="Select PURCHASE ORDER NUMBER: "
S1 S DIC="^PRC(442,",DIC(0)="AEQM",DIC("S")="I $O(^PRC(442,+Y,11,0)),+^PRC(442,+Y,0)=PRC(""SITE""),$P(^PRC(442,+Y,0),U,2)'=25" D ^DIC K DIC G:Y<0 OUT S DA(1)=+Y,PRCFA("PODA")=+Y
 S DIC("A")="Select Partial Number: ",DIC="^PRC(442,"_DA(1)_",11,",DIC(0)="AEQM" D ^DIC K DIC I Y<1 K PRCFA G OUT
 I $P(^PRC(442,PRCFA("PODA"),11,+Y,0),"^",19)]"" W !!,"This partial has already been transmitted to Austin.  <No Action Taken>",$C(7) G S2
 S PRCFA("PARTIAL")=+Y
 D ACCTGPER G OUT:$D(DTOUT)!$D(DUOUT)!$D(Y)
 I '$$QUEUED D ASK I '% S X=" <No Action Taken>*" D MSG^PRCFQ
S2 S DIC("A")="Select Next PURCHASE ORDER NUMBER: "
 G S1
OUT K D,D0,DA,DI,DIC,DIE,DQ,DR,PRCFA Q
RETRANS ;RETRANSMIT SINGLE RECEIVING REPORT
 S PRCF("X")="AS" D ^PRCFSITE Q:'%  S DIC("A")="Select PURCHASE ORDER NUMBER: "
R1 S DIC="^PRC(442,",DIC(0)="AEQM",DIC("S")="I $O(^PRC(442,+Y,11,0)),+^PRC(442,+Y,0)=PRC(""SITE""),$P(^PRC(442,+Y,0),U,2)'=25" D ^DIC K DIC G:Y<0 OUT S DA(1)=+Y,PRCFA("PODA")=+Y
 S DIC("A")="Select Partial Number: ",DIC="^PRC(442,"_DA(1)_",11,",DIC(0)="AEQM" D ^DIC K DIC I Y<1 K PRCFA G OUT
 I $P(^PRC(442,PRCFA("PODA"),11,+Y,0),"^",19)="" W !!,"This partial has not yet been transmitted to Austin.  <No Action Taken>",$C(7) G R2
 S PRCFA("PARTIAL")=+Y,PRCFA("RETRANS")=""
 D ACCTGPER G OUT:$D(DTOUT)!$D(DUOUT)!$D(Y)
 I '$$QUEUED D ASK I '% S X="  <No action taken>*" D MSG^PRCFQ
R2 S DIC("A")="Select Next PURCHASE ORDER NUMBER: "
 G R1
ASK ;ASK NOW OR LATER   ANSWER IN % 1=NOW, 2=LATER -1=ABORT
 K DA
 I '$D(^XUSEC("PRCFA TRANSMIT",DUZ)) S %=2 G ASK1
 S %=2,%A="Do you want this transmitted immediately",%B="A 'YES' will cause the receiving report to go to Austin immediately.",%B(1)="A 'NO' will queue it for release using the 'Transmit Receiving Reports'"
 S %B(2)="Option.  An '^' will terminate this option." D ^PRCFYN
ASK1 G:%<0 ASKX I %=1 D NOW S %=1 G ASKX
 S X=$P(^PRC(442,PRCFA("PODA"),0),"^")_"."_PRCFA("PARTIAL"),DIC=442.9,DIC(0)="ML",DLAYGO=442.9 D ^DIC K DIC,DLAYGO
 I Y<0 S %=0 W !,"Unable to QUEUE at this time" G ASK
 S DIE="^PRC(442.9,",DA=+Y,DR="2////"_+PRC("PER")_";1////"_PRCFA("PODA")_";3//T;4////"_$S('$D(PRCFA("RETRANS")):"",1:1) D ^DIE K DIE,DR
 I $D(Y) S DIK="^PRC(442.9," D ^DIK K DIK,DA S X="  Not Queued>*" D MSG^PRCFQ S %=0 G ASKX
 S X="  Receiving report has been put on transmission list.*" D MSG^PRCFQ S %=1
ASKX K DA
 Q
QUEUED() ;Check if in batch already
 N X,Y S X=$P($G(^PRC(442,+PRCFA("PODA"),0)),U)_"."_PRCFA("PARTIAL") ; + added by REW for Patch 90 to prevent NULL SUB error
 S Y=$O(^PRC(442.9,"B",X,""))
 I +Y>0 W !,"    This Receiving Report is ALREADY Queued for Transmission." Q 1
 Q 0
ACCTGPER ;Ask Accounting Period
 S DA(1)=PRCFA("PODA"),DA=PRCFA("PARTIAL")
 S DIE="^PRC(442,"_PRCFA("PODA")_",11,",DR="23R//^S X=$P(""JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC"",U,+$E(DT,4,5))_"" ""_($E(DT,1,3)+1700)"
 D ^DIE K DA,DIE,DR
 Q
