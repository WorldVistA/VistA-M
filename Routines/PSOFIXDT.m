PSOFIXDT ;BHAM ISC/RTR - COSIGNER AND FILL DATE CLEAN UP;7/29/94 
 ;;6.0;OUTPATIENT PHARMACY;**124**;APRIL 1993
 S PSOSTART=$O(^PS(59.7,0)) I +$P(^PS(59.7,PSOSTART,49.99),"^")<6 W !,"It appears from your version entry in your Pharmacy System File (#59.7)",!,"that you are not running Outpatient V 6.0.!",! G END
 S PSOSTART=$O(^PS(59.7,0)),PSOSTART=$P($G(^PS(59.7,PSOSTART,49.99)),"^",2) I 'PSOSTART W !,"There is a problem with the Date OP Installed field in your Pharmacy",!,"System File (#59.7), check entry and start again!",!! G END
 W @IOF W !,"This routine will queue three separate jobs.",!
 W !,"One job will generate a mail message listing prescriptions with missing",!,"Fill dates or Refill dates.",!
 W !,"A second job will generate a mail message listing entries in your Suspense",!,"File (#52.5) with missing Suspense dates.",!
 W !,"A third job will look through your prescription file for any -1 entries",!,"in your Cosigning Physician field.",!
 W "If we find any, we will update that field with the appropriate entry,",!,"based on the Usual Cosigner field in the New Person File for the",!,"provider of the prescription. If there is a problem with the Usual Cosigner"
 W !,"entry in the New Person File, we will set that field to null.",!,"A mail message will be sent to you with the number of entries changed.",!
 S X1=PSOSTART,X2=-1 D C^%DTC S PSOSTART=X
 D NOW^%DTC S %DT="RAEX",%DT(0)=%,%DT("B")="NOW",%DT("A")="QUEUE JOBS TO RUN AT WHAT TIME: " D ^%DT S PSOQTIME=Y I $D(DTOUT)!(Y=-1) W !,"Try again later!",! G END
 S ZTIO="",ZTRTN="BEG^PSOFIXDT",ZTDTH=PSOQTIME,ZTDESC="CHECK BAD PROVIDER ENTRIES",ZTSAVE("PSOSTART")=PSOSTART D ^%ZTLOAD
 S ZTIO="",ZTRTN="SUS^PSOFIXDT",ZTDTH=PSOQTIME,ZTDESC="CHECK FOR MISSING SUSPENSE DATES" D ^%ZTLOAD
 S ZTIO="",ZTRTN="START^PSOFIXDT",ZTDTH=PSOQTIME,ZTDESC="CHECK FOR MISSING FILL DATES",ZTSAVE("PSOSTART")=PSOSTART D ^%ZTLOAD W !!,"TASKS QUEUED!",! G END
BEG K ^TMP($J,"TRANS") S ^TMP($J,"TRANS",1,0)="Following are counts for the -1 entries found in the Prescription File (#52).",^TMP($J,"TRANS",2,0)=" ",^TMP($J,"TRANS",3,0)=" "
 S (PSOTOT,CNT,PSOCNT)=0 F AAA=PSOSTART:0 S AAA=$O(^PSRX("AD",AAA)) Q:'AAA  F BBB=0:0 S BBB=$O(^PSRX("AD",AAA,BBB)) Q:'BBB  I $P($G(^PSRX(BBB,3)),"^",3)=-1 K DA,DR,PSUS,PSPRV S PSCOS=0,PSPRV=+$P($G(^PSRX(BBB,0)),"^",4) D
 .I PSPRV,+$P($G(^VA(200,PSPRV,"PS")),"^",7),+$P($G(^("PS")),"^",8) S PSCNUM=$P(^("PS"),"^",8) I $D(^VA(200,PSCNUM,"PS")),$P(^("PS"),"^"),'$P(^("PS"),"^",7),$S('$P(^("PS"),"^",4):1,1:$P(^("PS"),"^",4)'<DT) S PSCOS=1
 .I PSCOS S DIE="^PSRX(",DA=BBB,DR="109////"_PSCNUM D ^DIE S CNT=CNT+1 Q
 .I 'PSCOS S DIE="^PSRX(",DA=BBB,DR="109////"_"@" D ^DIE S PSOCNT=PSOCNT+1 Q
 S PSOTOT=CNT+PSOCNT,^TMP($J,"TRANS",4,0)="Number of -1 entries changed to a provider based on the Usual Provider entry in the New Person File (#200):  "_$G(CNT)
 S ^TMP($J,"TRANS",5,0)=" ",^TMP($J,"TRANS",6,0)="Number of -1 entries changed to null:  "_$G(PSOCNT),^TMP($J,"TRANS",7,0)=" ",^TMP($J,"TRANS",8,0)="Total entries changed:  "_$G(PSOTOT)
 S XMSUB="Invalid -1 entries for Cosigning Physician" D MAIL G END
START K ^TMP($J,"TRANS") S ^TMP($J,"TRANS",1,0)="Following are Rx fills that are missing either a Fill Date or a Refill Date:",^TMP($J,"TRANS",2,0)=" "
 F CCC=1:1 S X1=PSOSTART,X2=CCC D C^%DTC I $O(^PSRX("AD",X,0)) S RXSTART=$O(^PSRX("AD",X,0)) Q
 S PSOCOUNT=0,PSSUB=3 F PPP=RXSTART:0 S PPP=$O(^PSRX(PPP)) Q:'PPP  D
 .Q:$P($G(^PSRX(PPP,0)),"^",15)=3
 .S RXNUM=$P($G(^PSRX(PPP,0)),"^")
 .I $D(^PSRX(PPP,2)),'$P($G(^(2)),"^",2) S ^TMP($J,"TRANS",PSSUB,0)="Rx number: "_$G(RXNUM)_"   Original fill" S PSSUB=PSSUB+1,PSOCOUNT=PSOCOUNT+1
 .F LLL=0:0 S LLL=$O(^PSRX(PPP,1,LLL)) Q:'LLL  I $D(^PSRX(PPP,1,LLL,0)),'$P($G(^(0)),"^") S ^TMP($J,"TRANS",PSSUB,0)="Rx number: "_$G(RXNUM)_"   Refill number: "_$G(LLL) S PSSUB=PSSUB+1,PSOCOUNT=PSOCOUNT+1
 I 'PSOCOUNT S ^TMP($J,"TRANS",3,0)="NO MISSING FILL DATES WERE FOUND!"
 S XMSUB="Missing Fill Dates" D MAIL G END
SUS S SUSCOUNT=4 K ^TMP($J,"TRANS") S ^TMP($J,"TRANS",1,0)="Following are entries in your suspense file (#52.5) that are missing a suspense date."
 S ^TMP($J,"TRANS",2,0)="The Internal Rx Number is the .01 field in the Suspense File (#52.5).",^TMP($J,"TRANS",3,0)=" "
 F RRR=0:0 S RRR=$O(^PS(52.5,RRR)) Q:'RRR  I '$P($G(^PS(52.5,RRR,0)),"^",2) S ^TMP($J,"TRANS",SUSCOUNT,0)="Rx Number: "_$P($G(^PSRX($P($G(^PS(52.5,RRR,0)),"^"),0)),"^")_"   Internal Rx number: "_$P($G(^PS(52.5,RRR,0)),"^") S SUSCOUNT=SUSCOUNT+1
 I SUSCOUNT=4 S ^TMP($J,"TRANS",5,0)="NO MISSING SUSPENSE DATES FOUND!"
 S XMSUB="Missing suspense dates" D MAIL
END K ^TMP($J),XMDUZ,PSPRV,CNT,PSCOS,PSCNUM,PSOCNT,PSOTOT,PSOQTIME,PSOSTART,AAA,BBB,%DT,Y,DIE,DA,DR,PSSUB,PSOCOUNT,CCC,PPP,RRR,SUSCOUNT,RXNUM,DTOUT,DUOUT,XMDUZ,XMSUB,XMY,XMTEXT,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE S:$D(ZTQUEUED) ZTREQ="@" Q
MAIL S XMDUZ=.5,XMY(DUZ)="",XMY(DUZ,1)="I",XMTEXT="^TMP($J,""TRANS""," D ^XMD Q
