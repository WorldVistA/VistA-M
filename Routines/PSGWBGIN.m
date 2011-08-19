PSGWBGIN ;BHAM ISC/CML-AR/WS Item Inactivation ; 06 Aug 93 / 2:19 PM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
 W !!,"You may inactivate a Stock Item for a single AOU,",!,"or enter ""^ALL"" to inactivate the Item in ALL AOUs.",!
 K QFLG F QQ=0:0 Q:$D(QFLG)  S ALL=1,DIC="^PSI(58.1,",DIC(0)="QEAM" D ^DIC K DIC Q:Y<0&(X'="^ALL")  D:X'="^ALL" INACT2 I ALL F QQ=0:0 D ASK Q:$D(QFLG)  I $D(X),"^"[X Q
QUIT K %,ALL,AOU,AOUCNT,DA,DR,QUE,QFLG,I,ITEM,ITEMNUM,INDT,J,K,QQ,REA1,REA2,RDT,X,XMDUZ,XMKK,XMLOCK,XMR,XMSUB,XMT,XMTEXT,XMZ,Y,^TMP("PSGWMSG",$J),ZTSK
 S:$D(ZTQUEUED) ZTREQ="@" Q
ASK ;
 W !!,"Select ITEM: " R X:DTIME S:'$T X="^",QFLG=1 Q:"^"[X  W:X?1."?" !!,"Enter the ITEM you wish to inactivate in all AOUs.",! S DIC="^PSDRUG(",DIC(0)="QEOM" D ^DIC K DIC G:Y<0 ASK S ITEM=+Y,REA2=""
 W !!,"Select INACTIVATION REASON:",!?5,"(N)  - NOT USED",!?5,"(DF) - DELETED FROM FORMULARY",!?5,"(O)  - OTHER"
ASKR1 R ?34,"=> ",REA1:DTIME S:'$T REA1="^",QFLG=1 Q:"^"[REA1  G:REA1="O" ASKR2 I REA1'="N",REA1'="DF" W *7,!?37,"Enter 'N', 'DF', or 'O'",! G ASKR1
 G QUE
ASKR2 R !!,"Enter INACTIVATION REASON (OTHER): ",REA2:DTIME S:'$T REA2="^",QFLG=1 Q:REA2="^"  I REA2]"",REA2?1."?"!($L(REA2)>40!($L(REA2)<3)) W *7,!?5,"ANSWER MUST BE 3-40 CHARACTERS IN LENGTH" G ASKR2
QUE F QQ=0:0 W !!,"Do you want to queue this job" S %=1 D YN^DICN Q:%  W !!,"To queue this job to run at a later time and free up your terminal now, accept",!,"the default, otherwise enter 'N' to run it immediately or '^' to Exit"
 Q:%<0  S QUE=$S(%=1:1,1:0) I QUE W !!,"You will be notified by MailMan when the job is completed.",!
 I %=1 S ZTIO="",ZTRTN="START^PSGWBGIN",ZTDESC="AR/WS MASS ITEM INACTIVATION",ZTSAVE("ITEM")="",ZTSAVE("REA1")="",ZTSAVE("REA2")="",ZTSAVE("QUE")="" D ^%ZTLOAD,HOME^%ZIS K ZTSK Q
START ;
 D NOW^%DTC S INDT=X,AOUCNT=0 F AOU=0:0 S AOU=$O(^PSI(58.1,AOU)) Q:'AOU  I $D(^PSI(58.1,AOU,1,"B",ITEM)) S ITEMNUM=$O(^PSI(58.1,AOU,1,"B",ITEM,0)) I $D(^PSI(58.1,AOU,1,ITEMNUM,0)),$P(^(0),"^",3)="" D INACT1 S AOUCNT=AOUCNT+1
 I 'QUE W *7,!!,$P(^PSDRUG(ITEM,0),"^")," has been inactivated in ",AOUCNT," AOU(s).",! Q
MAIL ;
 K XMY S Y=INDT X ^DD("DD") S RDT=Y S ^TMP("PSGWMSG",$J,1,0)="AR/WS ITEM Inactivation Background job has run to completion.",^TMP("PSGWMSG",$J,2,0)="Run Date: "_RDT
 S ^TMP("PSGWMSG",$J,3,0)="",^TMP("PSGWMSG",$J,4,0)="ITEM : "_$P(^PSDRUG(ITEM,0),"^"),^TMP("PSGWMSG",$J,5,0)="Has been inactivated as of "_RDT_" in "_AOUCNT_" AOU(s)."
 S XMSUB="AR/WS MASS ITEM INACTIVATION SUMMARY",XMDUZ="INPATIENT PHARMACY AR/WS",XMTEXT="^TMP(""PSGWMSG"",$J,",XMY(DUZ)="" S:'$D(XMY) XMY(.5)="" D ^XMD K XMY G QUIT
INACT1 ; Inactivate an Item for ALL AOUs
 K DA S DA(1)=AOU,DA=ITEMNUM,DIE="^PSI(58.1,"_DA(1)_",1,",DR="30///"_INDT_";31///"_REA1_";33///"_$S(REA2=""&($P(^PSI(58.1,DA(1),1,DA,0),"^",9)]""):"@",1:REA2) D ^DIE K DIE Q
INACT2 ; Inactivate an Item for a single AOU
 K DA,DIE S ALL=0,DA=+Y,DIE="^PSI(58.1,",DR="[PSGW INACTIVATE ITEM]" D ^DIE K DIE S:$D(Y) QFLG=1 Q
