DVBCADE1 ;ALB/GTS-557/THM-PRINT/REPRINT WORKSHEETS ; 5/7/91  11:20 AM
 ;;2.7;AMIE;**12**;Apr 10, 1995
 ;from DVBCADEX
 K RPRT I '$D(^TMP($J,"NEW")) W !!,"No exams selected ...",!! H 2 Q
 D COPY G EN
 ;
CK1 I $P(^DVB(396.4,EXDA,0),U,4)'="O"!($P(^(0),U,5)="Y"),'$D(RPRT) Q
 K CMBN I $P(TEMP("NEW",ZC,EXMNM),U,2)="A" S CMBN=1
 S PGM=$S($D(^DVB(396.6,JY,0)):$P(^(0),U,4),1:"")
 I PGM="" Q
 S TNAM=$P(^(0),U,1),PGM="^"_PGM D @PGM
 N DVBCEXM S DVBCEXM=EXMNM K DVBCFF
 I ZC="A" DO
 .S DVBCEXM=$O(TEMP("NEW","A",DVBCEXM))
 .I DVBCEXM'="" S DVBCFF=""
 .I '$D(DVBCFF) S DVBCEXM=$O(TEMP("NEW","Z","")) DO
 ..I DVBCEXM'="" S DVBCFF=""
 I ZC="Z" DO
 .S DVBCEXM=$O(TEMP("NEW","Z",DVBCEXM))
 .I DVBCEXM'="" S DVBCFF=""
 W:(IOST?1"P-".E)&($D(DVBCFF)) @IOF
 K DVBCFF,DVBCEXM
 S $P(^DVB(396.4,EXDA,0),U,5)="Y"
 K CMBN,TNAM,PGM Q
 ;
EN W @FF,!!,"Worksheets should be sent to a printer." S %ZIS="AEQ",%ZIS("A")="Output device: " D ^%ZIS Q:POP  K %ZIS
 ;
QUE I $D(IO("Q")) S ZTRTN=$S($D(RPRT):"GO2^DVBCADE1",1:"GO^DVBCADE1"),ZTDESC="Print C&P Work Sheets" F I="DUZ","DA*","DFN","TEMP*","REQDA","OWNDOM","RPRT","C*","SSN","PNAM" S ZTSAVE(I)=""
 I $D(IO("Q")) D ^%ZTLOAD S:'$D(ZTSK) POP=1 W:$D(ZTSK) !!,"Request queued",!! H 1 K IO("Q"),ZTRTN,ZTIO,ZTDESC K:'$D(RPRT) ZTSK Q
 Q:$D(RPRT)
 ;
GO U IO S DA=REQDA D VARS^DVBCUTIL
 S EXMNM="" F ZC="A","Z" F JZ=0:0 S EXMNM=$O(TEMP("NEW",ZC,EXMNM)) Q:EXMNM=""  S JY=$P(TEMP("NEW",ZC,EXMNM),U,1),EXDA=$P(TEMP("NEW",ZC,EXMNM),U,3) D CK1
 D ^%ZISC D:$D(ZTQUEUED) KILL^%ZTLOAD Q
 ;
SET S EXDA=+Y,JY=$P(Y,U,2) D EXMNM I '$D(OUT) D FMT D:$D(OUT) QUES Q:$D(OUT)  I '$D(OUT) S ^TMP($J,"NEW",EXMNM)=JY_U_FMT_U_EXDA H 1 W @FF,!!,HD4,!!!
 Q
 ;
 ;print/reprint worksheets
RPRT S RPRT=1 D HOME^%ZIS S FF=IOF
 ;
EN1 K ^TMP($J),DA,EXDA,EXMNM,OUT,DIC
 W @FF,!,"Print/Reprint C&P Worksheets",!!!
 S DIC="^DVB(396.3,",DIC(0)="AEQM",DIC("A")="Select VETERAN NAME: "
 D ^DIC G:X=""!(X=U) EXIT S (REQDA,DA(1))=+Y
 S HD4="Select exam(s) to print or enter ALL to print all exams."
 W !!,HD4,!!!
 K OUT,OUT1
 F I=0:0 K DIC,Y,D S DIC("A")="Select EXAM: " W ?10,DIC("A") S DIC="^DVB(396.6,",DIC("S")="I $D(^DVB(396.4,""ARQ""_REQDA,+Y))",DIC(0)="EQ" R X:DTIME S:'$T OUT1=1 Q:$D(OUT1)!(X="")!(X=U)!(X="ALL")!(X="all")  DO
 .D ^DIC D:X["?" QUES W:+Y<0 !!
 .I +Y>0 K DIC S X=+Y,DIC="^DVB(396.4,",DIC(0)="EQ",D="ARQ"_REQDA DO
 ..D MIX^DIC1 K DIC,D
 .I +Y>0 D SET
 G:$D(OUT1) EXIT
 I $D(X),X="ALL"!(X="all") F EXDA=0:0 S EXDA=$O(^DVB(396.4,"C",REQDA,EXDA)) Q:EXDA=""  D FMT G:$D(OUT1) EXIT Q:$D(OUT)  S ^TMP($J,"NEW",EXMNM)=JY_U_FMT_U_EXDA
 I '$D(^TMP($J,"NEW")) W *7,!!,"No exams selected ..." H 2 G EN1
 D COPY,EN G:POP EXIT I $D(ZTSK) K ZTSK G EN1
 ;
GO2 U IO S DA=DA(1) D VARS^DVBCUTIL
 S OWNDOM=$P(^DVB(396.3,DA(1),0),U,22) I OWNDOM]"" D ^DVBCTRNN
 S EXMNM="" F ZC="A","Z" F JZ=0:0 S EXMNM=$O(TEMP("NEW",ZC,EXMNM)) Q:EXMNM=""  S JY=$P(TEMP("NEW",ZC,EXMNM),U,1),EXDA=$P(TEMP("NEW",ZC,EXMNM),U,3) D CK1
 D ^%ZISC G:'$D(ZTQUEUED) EN1 I $D(ZTQUEUED) G EXIT
 ;
EXMNM K OUT S JY=$P(^DVB(396.4,EXDA,0),U,3)
 S EXMNM=$S($D(^DVB(396.6,JY,0)):$P(^(0),U,1),1:"")
 I EXMNM="" S OUT=1 ;!($D(^TMP($J,"NEW",EXMNM))) S OUT=1
 Q
 ;
FMT W @IOF,! D EXMNM W !!?10,EXMNM,!
 K OUT,OUT1 I $P(^DVB(396.4,EXDA,0),U,4)'="O" W *7,!!?5,"Status is not OPEN - No worksheet will be printed.    " H 3 S OUT=1 Q
 S FMT="F"
 Q
 ;
COPY K TEMP S X="" F Y=0:0 S X=$O(^TMP($J,"NEW",X)) Q:X=""  S Z=$S($P(^TMP($J,"NEW",X),U,2)="F":"A",1:"Z"),TEMP("NEW",Z,X)=^TMP($J,"NEW",X) ;full come out first
 Q
 ;
QUES W !!,"Press RETURN to continue  " R ANS:DTIME
 W @FF,!!,HD4,!!!
 Q
 ;
EXIT K RPRT,FMT,OUT,OUT1 D:$D(ZTQUEUED) KILL^%ZTLOAD G KILL^DVBCUTIL
