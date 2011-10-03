ANRVRP8 ;BIRM/LDT - VIST ROSTER OUTPATIENT APPOINTMENTS ; 17 Feb 98 / 2:26 PM
 ;;4.0; Visual Impairment Service Team ;;12 Jun 98
EN1 ;Entry point for Roster Outpatient Appointment.
 W @IOF,!!,"OUTPATIENT APPOINTMENT LIST",!!,"The right margin for this report is 132.",!!
 D SEL1 G:SEL="^" QUIT
BDT W ! S %DT="AEX",%DT("A")="BEGINNING date for report: " D ^%DT K %DT G:Y<0 QUIT S BDT=Y
EDT S %DT="AEX",%DT(0)=BDT,%DT("A")="ENDING date for report: " D ^%DT K %DT G:Y<0 QUIT S EDT=Y
 D SEL2 G:'$D(ANRVLP) QUIT
DEV K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!!" G QUIT
 I $D(IO("Q")) K IO("Q") S ZTDESC="VIST ROSTER OUTPATIENT APPOINTMENTS",ZTRTN="DEQ^ANRVRP8" S:$D(ANRVLP) ZTSAVE("ANRVLP(")="" F G="BDT","EDT","SEL" S:$D(@G) ZTSAVE(G)=""
 I  D ^%ZTLOAD K ZTSK G QUIT
 U IO
DEQ ;Entry point when queued.
 K ^TMP("ANRV",$J)
 S ANRVP=0 F  S ANRVP=$O(ANRVLP(ANRVP)) Q:'ANRVP  S DFN=$P($G(^ANRV(2040,ANRVP,0)),U),VASD("T")=EDT,VASD("F")=BDT D 9^VADPT,SETTMP
 S HDR="VIST ROSTER OUTPATIENT APPOINTMENTS"
 S (PG,QFLG)=0,$P(LN,"-",133)="" D NOW^%DTC S Y=$E(%,1,12) X ^DD("DD") S HDT=Y D HDR
 I '$D(^TMP("ANRV",$J)) W !,"NO DATA TO PRINT!" G QUIT
 D REPORT
 ;
QUIT K %,%H,%I,%T,%Y,ANRVP,ANRV,ANRVAP,ANRVLP,APP,BDT,DFN,EDT,HDR,HDT,JJ,LN,NAME,NN,PG,POP,QFLG,RVDT,SEL,SUB1,SUB2,X,Y,XX,XXX D KVAR^VADPT,KVA^VADPT
 W:$E(IOST)'="C" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
SETTMP ;Set TMP global
 I $D(^UTILITY("VASD",$J)) D
 .I SEL="P" S SUB1=VADM(1),^TMP("ANRV",$J,SUB1,0)=VADM(1)_U_$P(VADM(2),U,2) D
 ..S RVDT=$O(^ANRV(2040,ANRVP,6," "),-1) S:RVDT]"" RVDT=$G(^ANRV(2040,ANRVP,6,RVDT,0)) I RVDT]"" S Y=$P(RVDT,U) X ^DD("DD") S $P(^TMP("ANRV",$J,SUB1,0),U,3)=Y,$P(^(0),U,4)=$P(RVDT,U,2)
 ..S APP=0 F  S APP=$O(^UTILITY("VASD",$J,APP)) Q:'APP  S ^TMP("ANRV",$J,SUB1,APP)=$G(^UTILITY("VASD",$J,APP,"E"))
 .I SEL="D" S SUB2=VADM(1),APP=0 F  S APP=$O(^UTILITY("VASD",$J,APP)) Q:'APP  S %DT="NTX",X=$P(^UTILITY("VASD",$J,APP,"E"),U) D ^%DT S SUB1=Y,^TMP("ANRV",$J,SUB1,SUB2,0)=VADM(1)_U_$P(VADM(2),U,2) D
 ..S RVDT=$O(^ANRV(2040,ANRVP,6," "),-1) S:RVDT]"" RVDT=$G(^ANRV(2040,ANRVP,6,RVDT,0)) I RVDT]"" S Y=$P(RVDT,U) X ^DD("DD") S $P(^TMP("ANRV",$J,SUB1,SUB2,0),U,3)=Y,$P(^(0),U,4)=$P(RVDT,U,2)
 ..S ^TMP("ANRV",$J,SUB1,SUB2,APP)=$G(^UTILITY("VASD",$J,APP,"E"))
 Q
 ;
HDR ;Report header
 I $E(IOST)="C",PG>0 S DIR(0)="E" D ^DIR K DIR I 'Y S QFLG=1 Q
 S PG=PG+1 W:$Y!($E(IOST)="C") @IOF Q:(PG>1)&($E(IOST)="C")  W !,HDR," FROM " S Y=BDT X ^DD("DD") W Y," TO " S Y=EDT X ^DD("DD") W Y,?100,"Page ",PG
 W !,"NAME",?32,"SSN",?45,"LAST ANNUAL REVIEW",?65,"STATUS",?81,"APPT. DATE/TIME",?100,"CLINIC",!,LN
 Q
 ;
REPORT ;Print Report
 I SEL="P" S NAME="" F  S NAME=$O(^TMP("ANRV",$J,NAME)) Q:NAME=""  D  D:$Y+4>IOSL HDR Q:QFLG
 .F XX=1:1:4 S ANRV(XX)=$P($G(^TMP("ANRV",$J,NAME,0)),U,XX)
 .W !!,ANRV(1),?32,ANRV(2),?48,ANRV(3),?65,$S(ANRV(4)="035":"COMPLETE (035)",ANRV(4)="036":"DECLINED (036)",ANRV(4)="037":"NO SHOW (037)",1:"")
 .S NN=0 F  S NN=$O(^TMP("ANRV",$J,NAME,NN)) Q:'NN  D
 ..F XXX=1:1:4 S ANRVAP(XXX)=$P($G(^TMP("ANRV",$J,NAME,NN)),U,XXX)
 ..W ?81,ANRVAP(1),?100,ANRVAP(2),!
 I SEL="D" S APP=0,NAME="" F  S APP=$O(^TMP("ANRV",$J,APP)) Q:'APP  F  S NAME=$O(^TMP("ANRV",$J,APP,NAME)) Q:NAME=""  D  D:$Y+5>IOSL HDR Q:QFLG
 .F XX=1:1:4 S ANRV(XX)=$P($G(^TMP("ANRV",$J,APP,NAME,0)),U,XX)
 .W !!,ANRV(1),?32,ANRV(2),?48,ANRV(3),?65,$S(ANRV(4)="035":"COMPLETE (035)",ANRV(4)="036":"DECLINED (036)",ANRV(4)="037":"NO SHOW (037)",1:"")
 .S NN=0 F  S NN=$O(^TMP("ANRV",$J,APP,NAME,NN)) Q:'NN  D
 ..F XXX=1:1:4 S ANRVAP(XXX)=$P($G(^TMP("ANRV",$J,APP,NAME,NN)),U,XXX)
 ..W ?81,ANRVAP(1),?100,ANRVAP(2),!
 Q
SEL1 W !!,"Do you want to sort by (P)atient or (D)ate/time of appointment?",!
 S DIR(0)="SAOBM^P:PATIENT;D:DATE/TIME",DIR("A")="Choose P or D: ",DIR("?")="^D HELPSEL^ANRVRP8" D ^DIR K DIR
 S SEL=Y S:SEL="" SEL="^" G:SEL="^" QUIT2 Q
SEL2 W !!,"Do you want to list outpatient appointments for:",!?7,"(A)ll patients, or",!?7,"(S)elect patients.",!
 S DIR(0)="SAOBM^A:ALL;S:SELECT",DIR("A")="Choose A or S: ",DIR("?")="^D HELP2^ANRVRP8" D ^DIR K DIR
 I Y="A" G SETLP
ASKPT ;Ask for selected patients.
 W !
 S DIC="^ANRV(2040,",DIC(0)="QEAM",DIC("S")="I $P($G(^ANRV(2040,+Y,13)),U,2)'=""I""" D ^DIC K DIC I Y<0 Q
 S ANRVLP(+Y)="" G ASKPT
 Q
QUIT2 K %,X,Y Q
SETLP ;Set ANRVLP for all patients who are not inactive for AMIS
 S JJ=0 F  S JJ=$O(^ANRV(2040,JJ)) Q:'JJ  I $P($G(^ANRV(2040,JJ,13)),U,2)'="I" S ANRVLP(JJ)=""
 Q
HELPSEL ;
 W !!,"Enter:",!?7,"""P"" to sort outpatient appointments by patient in alphabetic order.",!?7,"""D"" to sort outpatient appointments by date/time of clinic appointment.",!?7,"""^"" or <return> to halt." Q
HELP2 ;
 W !!,"Enter:",!?7,"""A"" to list ALL patients from the VIST ROSTER file with",!?11,"outpatient appointments.",!?7,"""S"" to select only specific patients.",!?7,"""^"" or <return> to halt." Q
