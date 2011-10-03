PSGWWRD ;BHAM ISC/CML-Add/Delete Ward (for Item) assignments ; 06 Aug 93 / 2:17 PM [ 09/28/95  11:59 AM ]
 ;;2.3; Automatic Replenishment/Ward Stock ;**5**;4 JAN 94
 W !!,"This option will allow you to add or delete a WARD (for Item) assignment for",!,"all stock items in one or more ACTIVE AOUs."
ASK1 W !!,"Do you wish to (A)dd or (D)elete?  (Enter 'A', 'D', or ""^"" to Exit): "
 R ANS:DTIME S:'$T ANS="^" G:"^"[ANS QUIT I ANS'="A",ANS'="D" D HELP G ASK1
 W:ANS="A" "DD" W:ANS="D" "ELETE" S ANSW=$S(ANS="A":"ADD",1:"DELETE")
 D SEL^PSGWUTL1 G:'$D(SEL) QUIT I SEL="I" F JJ=0:0 S J=$O(AOULP(JJ)) Q:'JJ  I $S('$D(^PSI(58.1,JJ,"I")):0,'^("I"):0,^("I")>DT:0,1:1) K AOULP(JJ)
 G:SEL="I" ASK3
ASK2 F JJ=0:0 S DIC="^PSI(58.1,",DIC(0)="QEAM",DIC("S")="I $S('$D(^(""I"")):1,'^(""I""):1,^(""I"")>DT:1,1:0)" D ^DIC K DIC Q:Y<0  S AOULP(+Y)=""
 I '$D(AOULP)&(X'="^ALL") G QUIT
 I X="^ALL" F AOU=0:0 S AOU=$O(^PSI(58.1,AOU)) Q:'AOU  S AOULP(AOU)=""
ASK3 G:'$D(AOULP) QUIT W ! S DIC="^DIC(42,",DIC(0)="QEAM",DIC("A")="Select Ward (for Item) to "_ANSW_": " S:ANS="A" DIC("S")="I $S('$D(^(""I"")):1,^(""I"")="""":1,1:0)" D ^DIC K DIC G:Y<0 QUIT S WRD=+Y
QUE F JJ=0:0 W !!,"Do you want to queue this job" S %=1 D YN^DICN Q:%  W !!,"If you want to queue this job to run at a later time, accept the",!,"default, otherwise enter 'N' to run it immediately or '^' to Exit"
 G:%<0 QUIT S QUE=$S(%=1:1,1:0) I QUE W !!,"You will be notified by MailMan when the job is completed.",!
 I %=1 S ZTIO="",ZTRTN="START^PSGWWRD",ZTDESC="AR/WS WARD (FOR ITEM) ADD/DELETE" S:$D(AOULP) ZTSAVE("AOULP(")="" F G="QUE","WRD","ANS" S:$D(@G) ZTSAVE(G)=""
 I  D ^%ZTLOAD,HOME^%ZIS K ZTSK G QUIT
START ;
 K ^TMP($J) S (ITMCNT,MRCNT,FLG)=0 D:ANS="A" ADD D:ANS="D" DEL D:QUE MAIL
 I 'QUE W *7,!!,"WARD (For Item) assignment of ",$P(^DIC(42,WRD,0),"^")," has been ",$S(ANS="A":"added to",1:"deleted from"),":",!,"Total AOU(s): ",MRCNT,"   Total Stock Items: ",ITMCNT
QUIT K %,%Y,%Z,ANS,ANSW,AOU,AOULP,DA,DIC,DIE,DIK,DR,FLG,G,ITM,ITMCNT,JJ,SEL,IGDA,MRCNT,QUE,RDT,WED,WRD,X,XMDUZ,XMSUB,XMTEXT,XMY,Y,ZTSK,^TMP($J),IO("Q") D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@" Q
ADD ;
 F AOU=0:0 S AOU=$O(AOULP(AOU)) S:FLG MRCNT=MRCNT+1 Q:'AOU  S FLG=0 I $S('$D(^PSI(58.1,AOU,"I")):1,'^("I"):1,^("I")>DT:1,1:0) F ITM=0:0 S ITM=$O(^PSI(58.1,AOU,1,ITM)) Q:'ITM  I '$D(^PSI(58.1,AOU,1,ITM,4,WRD,0)) D ADDWRD
 Q
ADDWRD ;
 S DA(2)=AOU,DA(1)=ITM,DIC="^PSI(58.1,"_DA(2)_",1,"_DA(1)_",4,",DIC(0)="LM",DIC("P")=$P(^DD(58.11,5,0),"^",2),(DINUM,X)=WRD
 K DD,DO D FILE^DICN K DIC S ITMCNT=ITMCNT+1,FLG=1 W:'QUE "."
 Q
DEL ;
 F AOU=0:0 S AOU=$O(AOULP(AOU)) S:FLG MRCNT=MRCNT+1 Q:'AOU  S FLG=0 I $S('$D(^PSI(58.1,AOU,"I")):1,'^("I"):1,^("I")>DT:1,1:0) F ITM=0:0 S ITM=$O(^PSI(58.1,AOU,1,ITM)) Q:'ITM  I $D(^PSI(58.1,AOU,1,ITM,4,WRD,0)) D DELWRD
 Q
DELWRD ;
 S DA(2)=AOU,DA(1)=ITM,DA=WRD,DIK="^PSI(58.1,"_DA(2)_",1,"_DA(1)_",4,",DR="5///@" D ^DIK K DIK S ITMCNT=ITMCNT+1,FLG=1 W:'QUE "."
 Q
MAIL ;
 K XMY D NOW^%DTC S Y=X X ^DD("DD") S RDT=Y S ^TMP($J,"MSG",1,0)="AR/WS WARD (For Item) "_$S(ANS="A":"ADDITION",1:"DELETION")_" Background job has run to completion."
 S ^TMP($J,"MSG",2,0)="Run Date: "_RDT,^TMP($J,"MSG",3,0)="",^TMP($J,"MSG",4,0)="WARD (For Item) assignment of "_$P(^DIC(42,WRD,0),"^")_" has been "_$S(ANS="A":"Added to",1:"Deleted from")_":"
 S ^TMP($J,"MSG",5,0)="Total AOU(s): "_MRCNT_"   Total Stock Items: "_ITMCNT
 S XMSUB="AR/WS WARD (FOR ITEM) "_$S(ANS="A":"ADDITION",1:"DELETION")_" SUMMARY",XMDUZ="INPATIENT PHARMACY AR/WS",XMTEXT="^TMP($J,""MSG"",",XMY(DUZ)="" S:'$D(XMY) XMY(.5)="" D ^XMD K XMY Q
HELP ;
 I ANS'?."?" W *7," ??"
 W !!?5,"Enter: 'A' to Add a Ward (for Item)",!?12,"'D' to Delete a Ward (for Item)",!?12,"""^"" to Exit." Q
