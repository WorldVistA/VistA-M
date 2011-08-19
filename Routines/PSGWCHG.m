PSGWCHG ;BHAM ISC/CML-AR/WS Mass Ward Conversion ; 06 Aug 93 / 2:18 PM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
 W !!,"This routine will allow you to do a mass conversion of all active items in",!,"an active AOU from an old Ward designation to a new Ward designation."
 D SEL^PSGWUTL1 G:'$D(SEL) QUIT I SEL="I" F JJ=0:0 S JJ=$O(AOULP(JJ)) Q:'JJ  I $S('$D(^PSI(58.1,JJ,"I")):0,'^("I"):0,^("I")>DT:0,1:1) K AOULP(JJ)
 G:SEL="I" ASK
 F QQ=0:0 S DIC="^PSI(58.1,",DIC(0)="QEAM",DIC("S")="I $S('$D(^(""I"")):1,'^(""I""):1,^(""I"")>DT:1,1:0)" D ^DIC K DIC Q:Y<0  S AOULP(+Y)=""
 I '$D(AOULP)&(X'="^ALL") G QUIT
 I X="^ALL" F AOU=0:0 S AOU=$O(^PSI(58.1,AOU)) Q:'AOU  I $S('$D(^PSI(58.1,AOU,"I")):1,'^("I"):1,^("I")>DT:1,1:0) S AOULP(AOU)=""
ASK G:'$D(AOULP) QUIT
OLD R !!,"Select OLD WARD: ",X:DTIME S:'$T X="^" G:"^"[X QUIT W:X?1."?" !!,"Enter the Ward that currently exists in the WARD (FOR ITEM) field.",! S DIC="^DIC(42,",DIC(0)="QEM" D ^DIC K DIC G:Y<0 OLD S OLD=+Y
NEW R !!,"Select NEW WARD: ",X:DTIME S:'$T X="^" G:"^"[X QUIT W:X?1."?" !!,"Enter the new Ward you wish to replace ",$P(^DIC(42,OLD,0),"^"),".",!
 S DIC="^DIC(42,",DIC(0)="QEM",DIC("S")="I $S(+Y=OLD:0,'$D(^(""I"")):1,^(""I"")="""":1,1:0)" D ^DIC K DIC G:Y<0 NEW S NEW=+Y
QUE F QQ=0:0 W !!,"Do you want to queue this job" S %=1 D YN^DICN Q:%  W !!,"If you want to queue this job to run at a later time, accept the ",!,"default, otherwise enter 'N' to run it immediately or '^' to Exit"
 G:%<0 QUIT S QUE=$S(%=1:1,1:0) I QUE W !!,"You will be notified by MailMan when the job is completed.",!
 I %=1 S ZTIO="",ZTRTN="START^PSGWCHG",ZTDESC="AR/WS MASS WARD CONVERSION" S:$D(AOULP) ZTSAVE("AOULP(")="" F G="OLD","NEW","QUE" S:$D(@G) ZTSAVE(G)=""
 I  D ^%ZTLOAD,HOME^%ZIS K ZTSK G QUIT
START ;
 K ^TMP("PSGWOLD",$J) S (ITEMCNT,MEDRCNT)=0
 F DRUG=0:0 S DRUG=$O(^PSI(58.1,"D",DRUG)) Q:'DRUG  F MEDR=0:0 S MEDR=$O(^PSI(58.1,"D",DRUG,OLD,MEDR)) Q:'MEDR  I $D(AOULP(MEDR)) S ITEM=$O(^PSI(58.1,MEDR,1,"B",DRUG,0)) I +ITEM S ^TMP("PSGWOLD",$J,MEDR,ITEM)=""
 I $D(^TMP("PSGWOLD",$J)) F MEDR=0:0 S MEDR=$O(^TMP("PSGWOLD",$J,MEDR)) Q:'MEDR  S MEDRCNT=MEDRCNT+1 F ITEM=0:0 S ITEM=$O(^TMP("PSGWOLD",$J,MEDR,ITEM)) Q:'ITEM  S ITEMCNT=ITEMCNT+1 D CHK
 I 'QUE W *7,!!,"Total Stock Items converted: ",ITEMCNT,!,"Total AOU(s) converted: ",MEDRCNT,! G QUIT
MAIL ;
 K XMY D NOW^%DTC S Y=X X ^DD("DD") S RDT=Y S ^TMP("PSGWMSG",$J,1,0)="AR/WS Ward Conversion Background job has run to completion.",^TMP("PSGWMSG",$J,2,0)="Run Date: "_RDT,^TMP("PSGWMSG",$J,3,0)=""
 S ^TMP("PSGWMSG",$J,4,0)="Old Ward: "_$P(^DIC(42,OLD,0),"^")_"   converted to New Ward: "_$P(^DIC(42,NEW,0),"^"),^TMP("PSGWMSG",$J,5,0)="Total number of AOUs converted: "_MEDRCNT
 S ^TMP("PSGWMSG",$J,6,0)="Total number of Stock Items converted: "_ITEMCNT
 S XMSUB="AR/WS MASS WARD CONVERSION SUMMARY",XMDUZ="INPATIENT PHARMACY AR/WS",XMTEXT="^TMP(""PSGWMSG"",$J,",XMY(DUZ)="" S:'$D(XMY) XMY(.5)="" D ^XMD K XMY
QUIT K %,AOU,DRUG,G,QUE,I,ITEMCNT,J,K,MEDR,MEDRCNT,NEW,OLD,QQ,RDT,SEL,IGDA,JJ,X,XMDUZ,XMKK,XMLOCK,XMR,XMSUB,XMT,XMTEXT,XMZ,Y,^TMP("PSGWOLD",$J),^TMP("PSGWMSG",$J),ZTSK,%H,%I,CNT,DA,DR,ITEM,MEDRCNT,XCNP,AOULP
 S:$D(ZTQUEUED) ZTREQ="@" Q
CHK ;
 K DA S DA(2)=MEDR,DA(1)=ITEM,DA=OLD,DIK="^PSI(58.1,"_DA(2)_",1,"_DA(1)_",4," D ^DIK K DIK
 I '$D(^PSI(58.1,MEDR,1,ITEM,4,NEW,0)) K DA S DA(2)=MEDR,DA(1)=ITEM,DA=NEW,DIE="^PSI(58.1,"_DA(2)_",1,"_DA(1)_",4,",DR=".01////"_NEW D ^DIE K DIE I 'QUE W "."
 S CNT=0 F I=0:0 S I=$O(^PSI(58.1,MEDR,1,ITEM,4,I)) Q:'I  S CNT=CNT+1
 S $P(^PSI(58.1,MEDR,1,ITEM,4,0),"^",3,4)=NEW_"^"_CNT
 Q
