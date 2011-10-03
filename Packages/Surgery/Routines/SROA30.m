SROA30 ;BIR/MAM - 30 DAY LETTERS AND MAIL MESSAGE ;01/26/06
 ;;3.0; Surgery ;**7,18,31,38,95,153**;24 Jun 93;Build 11
 S SRSOUT=0 W @IOF K DIR S DIR("A")="Do you want to edit the text of the letter",DIR("B")="NO",DIR(0)="Y" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) G END
 I Y S X="Division: "_SRSITE("SITE")_"  ("_SRSITE("DIV")_")" W @IOF,!,?(80-$L(X)\2),X,! K DA,DIE,DR S DA=SRSITE,DR="31",DIE=133 D ^DIE K DA,DIE,DR
ONE G:SRSOUT END W @IOF S DIR("?",1)="Enter <RET> to select a patient and print the letter for a specific risk",DIR("?")="assessment, or 'NO' to print letters for a date range."
 S DIR("A")="Do you want to print the letter for a specific assessment",DIR("B")="YES",DIR(0)="Y" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 G END
 I Y D ^SROASS S:'$D(SRTN) SRSOUT=1 G:SRSOUT END G IO
 S SRAMAN=1
 W !!,"This option will allow you to reprint the 30 day follow up letters for the date",!,"that they were originally printed.  When printed automatically, the letters",!,"print 25 days after the date of operation."
SDATE W !!,"Print letters for BEGINNING date: TODAY// " R X:DTIME I '$T!(X["^") S SRSOUT=1 G END
 I X["?" W !,"Enter the EARLIEST date for which you want letters printed." S X="?",%DT="E" D ^%DT G SDATE
 S:X="" X="T" S %DT="E" D ^%DT G SDATE:Y<1 S X1=Y,X2=-25 D C^%DTC S SRSTART=X
EDATE W !,"Print letters for ENDING date: TODAY// " R X:DTIME I '$T!(X["^") S SRSOUT=1 G END
 I X["?" W !,"Enter the LATEST date for which you want letters printed." S X="?",%DT="E" D ^%DT G EDATE
 S:X="" X="T" S %DT="E" D ^%DT G EDATE:Y<1 S X1=Y,X2=-25 D C^%DTC S SREND=X
 I SRSTART>SREND W !!,"The ENDING date must be later than the BEGINNING date.  Please try again." G SDATE
IO I $D(SRTN),$P($G(^SRF(SRTN,30)),"^") W !!,"The 30 Day Letter will not print because the case selected has been cancelled.",!!,"Press <RET> to continue " R X:DTIME G END
 I $D(SRTN),'$P($G(^SRF(SRTN,.2)),"^",12) W !!,"The 30 Day Letter will not print because for the case selected,",!,"the field, TIME PATIENT OUT OF OR, has not been filled in.",!!,"Press <RET> to continue " R X:DTIME G END
 I $D(SRTN),$P($G(^DPT(DFN,.35)),"^") W !!,"The 30 Day Letter will not print because the patient has a date of death.",!!,"Press <RET> to continue " R X:DTIME G END
 W ! K %ZIS,IO("Q"),POP S %ZIS("A")="Print 30 Day Letters on which Device: ",%ZIS="Q" D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTDESC="Risk Assessment 30 Day Letters",ZTSAVE("SR*")="",ZTRTN="BEG^SROA30" D ^%ZTLOAD S SRSOUT=1 G END
BEG ; Entry point when manually queued
 U IO I $D(SRTN) D ^SROALET G END
 S SRSOUT=0,SRSDATE=SRSTART-.0001,SREND=SREND_".9999" F  S SRSDATE=$O(^SRF("AC",SRSDATE)) Q:'SRSDATE!(SRSDATE>SREND)!(SRSOUT)  D
 .S SRTN=0 F  S SRTN=$O(^SRF("AC",SRSDATE,SRTN)) Q:'SRTN  I $$DIV^SROUTL0(SRTN) D ^SROALET I '$D(SRAMAN),$D(VADM(1)) D MSG
 G END
EN ; Entry point when tasked daily
 Q:$G(IO)=""  U IO S (SRSOUT,SRYN)=0
 S X1=DT,X2=-25 D C^%DTC S SRSDATE=X-.0001,SREND=X_".9999" F  S SRSDATE=$O(^SRF("AC",SRSDATE)) Q:'SRSDATE!(SRSDATE>SREND)!(SRSOUT)  D SRTN
 G END
SRTN I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 S SRTN=0 F  S SRTN=$O(^SRF("AC",SRSDATE,SRTN)) Q:'SRTN  D ^SROALET I '$D(SRAMAN),$D(VADM(1)) D MSG
 Q
MSG S XMSUB="RISK ASSESSMENT 30 DAY REMINDER FOR "_VADM(1),XMDUZ="SURGICAL CLINICAL NURSE REVIEWER"
 S Y=$P(^SRF(SRTN,0),"^",9),SRADATE=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)
 S XMY("G.RISK ASSESSMENT@"_^XMB("NETNAME"))=""
 K SRAMSG S SRAMSG(1,0)=" ",SRAMSG(2,0)="Assesment Number: "_SRTN_"      Date of Operation: "_SRADATE,SRAMSG(3,0)="  ",SRAMSG(4,0)=SRNM,SRAMSG(5,0)=VAPA(1),SRCNT=6 I VAPA(2)'="" D ADD
 S SRAMSG(SRCNT,0)=VAPA(4)_", "_STATE_" "_VAPA(6),SRCNT=SRCNT+1
 F I=SRCNT:1:SRCNT+3 S SRAMSG(I,0)="   "
 S SEX=$P(VADM(5),"^")
 S SRAMSG(SRCNT+4,0)="It has been 25 days since "_SRNM_" had "_$S(SEX="M":"his",SEX="F":"her",1:"his")_" operation.  A follow-up ",SRAMSG(SRCNT+5,0)="letter has been printed."
 S XMTEXT="SRAMSG(" N I D ^XMD
 Q
END S SRPRINT=0 I $E(IOST)="P" S SRPRINT=1
 W:SRPRINT @IOF I $D(ZTQUEUED) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 D ^%ZISC W @IOF D ^SRSKILL K SRTN,VAIN,VAINDT
 Q
ADD ; Lines 2 and 3 of street address
 S SRAMSG(6,0)=VAPA(2),SRCNT=7
 I VAPA(3)'="" S SRAMSG(7,0)=VAPA(3),SRCNT=8
 Q
