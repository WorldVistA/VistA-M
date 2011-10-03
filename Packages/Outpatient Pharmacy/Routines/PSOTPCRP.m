PSOTPCRP ;BIR/RTR-Non VA phycisian eligible patient report ;07/07/03
 ;;7.0;OUTPATIENT PHARMACY;**145,153,227**;DEC 1997
 Q  ;placed out of order by patch PSO*7*227
EN ;
 W !!,"This report prints entries from the TPB ELIGIBILITY file (#52.91)."
 W !,"If multiple Institutions are selected, and some Institutions have data and",!,"some don't, only those Institutions that have data will print on the report.",!
 N PSOGPINS,PSOGPAR,PSOGOK,PSOGSORT
 S PSOGPINS=0
INST ;Ask for Institutions
 K DIR S DIR(0)="S^S:SELECT;A:ALL",DIR("B")="SELECT",DIR("A")="Print Report for Selected Institutions, or All Institutions" D  D ^DIR K DIR I Y["^"!($D(DTOUT))!($D(DUOUT)) W !!,"Nothing queued to print.",! Q
 .S DIR("?")=" ",DIR("?",1)="Enter 'S' to select one or more Institutions to print the report for,",DIR("?",2)="Enter 'A' to print the report for all Institutions."
 I Y="A" S PSOGPINS=1 G PASS
 S PSOGOK=0
INSTX ;Ask for individual Institutions
 K DIC S DIC(0)="QEAMZ",DIC=4 D  W ! D ^DIC K DIC I 'PSOGOK,(Y<1!($D(DUOUT))!($D(DTOUT))) W !!,"Nothing queued to print.",! Q
 .I 'PSOGOK,$G(DUZ(2)) S DIC("B")=DUZ(2)
 .I PSOGOK S DIC("A")="Select another INSTITUTION NAME:"
 I Y>0 S PSOGPAR(+Y)="",PSOGOK=1 G INSTX
 I '$O(PSOGPAR(0)) W !,"No Institutions selected, nothing queued to print.",! Q
PASS ;
ACT ;Ask for type of report
 W ! K DIR S DIR(0)="S^A:ALL PATIENTS;E:ELIGIBLE PATIENTS;I:INELIGIBLE PATIENTS",DIR("B")="ALL PATIENTS",DIR("A")="Select patients for report" D  D ^DIR K DIR I Y["^"!($D(DTOUT))!($D(DUOUT)) W !!,"Nothing queued to print.",! Q
 .S DIR("?")=" ",DIR("?",1)="To see only those patients currently eligible for the Transitional Pharmacy",DIR("?",2)="Benefit program, enter 'E'. To see all patients currently in the TPB"
 .S DIR("?",3)="ELIGIBILITY file (#52.91), but not currently eligible for the benefit,",DIR("?",4)="enter 'I'. To see all patients in the TPB ELIGIBILITY file (#52.91),"
 .S DIR("?",5)="both eligible and ineligible, enter 'A'."
 S PSOGSORT=Y
 W ! K IOP,%ZIS,POP S %ZIS="QM" D ^%ZIS I $G(POP) W !!,"Nothing queued to print.",! Q
 I $D(IO("Q")) S ZTRTN="START^PSOTPCRP",ZTDESC="TPB ELIGIBILITY Report",ZTSAVE("PSOGPINS")="",ZTSAVE("PSOGSORT")="",ZTSAVE("PSOGPAR(")="" D ^%ZTLOAD K %ZIS W !,"Report queued to print.",! K ZTRTN,ZTDESC,ZTSAVE Q
START ;
 K ^TMP("PSOGP",$J)
 U IO
 N DIC,DIQ,DA,DR,PSOGPOUT,PSOGDV,PSOGPAGE,PSOGTOP,PSOGPLIN,PSOGLOP,PSOGNODE,PSOGNAME,PSOINAME,PSOTAR,PSOG1,PSOG2,PSOG3,PSOG4,DFN,VADM,PSOGSSN,PSOGSSNX,PSOXND,PSOXRS,VA,VAERR,PSOTINS,PSOTARX,PSOVADIS,PSOVADIX
 I '$G(DT) S DT=$$DT^XLFDT
 S PSOGPOUT=0,PSOGDV=$S($E(IOST,1,2)'="C-":0,1:1),PSOGPAGE=1
 S $P(PSOGPLIN,"-",79)=""
 ;Set TMP global, store grand total count in PSOGTOP, Subtotals in PSOTAR array
 S PSOGTOP=0
 F PSOGLOP=0:0 S PSOGLOP=$O(^PS(52.91,PSOGLOP)) Q:'PSOGLOP  D
 .S PSOGNODE=$G(^PS(52.91,PSOGLOP,0)) I 'PSOGNODE Q
 .;If selecting institutions, and patient if file with no Institution won't show on the report??
 .I 'PSOGPINS,'$D(PSOGPAR(+$P(PSOGNODE,"^",8))),$P(PSOGNODE,"^",8) Q
 .I PSOGSORT="E",$P(PSOGNODE,"^",3),$P(PSOGNODE,"^",3)'>DT Q
 .I PSOGSORT="I" I '$P(PSOGNODE,"^",3)!($P(PSOGNODE,"^",3)>DT) Q
 .K VADM S DFN=+$P(PSOGNODE,"^") I 'DFN Q
 .D DEM^VADPT I $G(VADM(1))="" K VADM Q
 .S PSOGNAME=$G(VADM(1))
 .K VADM
 .K VA,VAERR S DFN=+$P(PSOGNODE,"^") D PID^VADPT6
 .S PSOGNAME=PSOGNAME_"("_$G(VA("BID"))_")"
 .K VA,VAERR
 .S ^TMP("PSOGP",$J,$S($P(PSOGNODE,"^",8):$P(PSOGNODE,"^",8),1:"NONE"),PSOGNAME,$P(PSOGNODE,"^"),PSOGLOP)="",PSOGTOP=PSOGTOP+1
 .I $P(PSOGNODE,"^",8) S PSOTAR($P(PSOGNODE,"^",8))=$G(PSOTAR($P(PSOGNODE,"^",8)))+1 Q
 .S PSOTAR("NONE")=$G(PSOTAR("NONE"))+1
 ;D HD
 I 'PSOGTOP D HD W !!,"No patients found that meet report criteria.",! G END
 S PSOG1="" F  S PSOG1=$O(^TMP("PSOGP",$J,PSOG1)) Q:PSOG1=""!(PSOGPOUT)  D
 .I $G(PSOG1)="NONE" S PSOINAME="NONE"
 .I $G(PSOG1)'="NONE" K PSOTINS,DIC,DIQ,DA,DR S DIC=4,DR=".01",DA=+PSOG1,DIQ(0)="E",DIQ="PSOTINS" D EN^DIQ1 S PSOINAME=$G(PSOTINS(4,+PSOG1,.01,"E")) K DIC,DIQ,DR,DA,PSOTINS
 .D HD I PSOGPOUT Q
 .S PSOTARX=0
 .S PSOG2="" F  S PSOG2=$O(^TMP("PSOGP",$J,PSOG1,PSOG2)) Q:PSOG2=""!(PSOGPOUT)  F PSOG3=0:0 S PSOG3=$O(^TMP("PSOGP",$J,PSOG1,PSOG2,PSOG3)) Q:'PSOG3!(PSOGPOUT)  D
 ..F PSOG4=0:0 S PSOG4=$O(^TMP("PSOGP",$J,PSOG1,PSOG2,PSOG3,PSOG4)) Q:'PSOG4!(PSOGPOUT)  D
 ...S PSOXND=$G(^PS(52.91,PSOG4,0))
 ...D ADDR
 ...S PSOTARX=PSOTARX+1
 ...W !!,PSOG2
 ...W ?38,$S($P(PSOXND,"^",2):$E($P(PSOXND,"^",2),4,5)_"/"_$E($P(PSOXND,"^",2),6,7)_"/"_$E($P(PSOXND,"^",2),2,3),1:"")
 ...W ?47,$S($P(PSOXND,"^",3):$E($P(PSOXND,"^",3),4,5)_"/"_$E($P(PSOXND,"^",3),6,7)_"/"_$E($P(PSOXND,"^",3),2,3),1:"")
 ...W ?56,$S($P(PSOXND,"^",12):$E($P(PSOXND,"^",12),4,5)_"/"_$E($P(PSOXND,"^",12),6,7)_"/"_$E($P(PSOXND,"^",12),2,3),1:"")
 ...S PSOXRS=$P(PSOXND,"^",4)
 ...W ?65,$S(PSOXRS=1:"VA Provider",PSOXRS=2:"No/Show/Cancel",PSOXRS=3:"Patient Ended",PSOXRS=4:"N/F Rx",PSOXRS=5:"Patient Expired",PSOXRS=6:"Rx's Inactive",PSOXRS=7:"Exclusion",PSOXRS=8:"Refused Appt.",PSOXRS=9:"Pat Unreachable",1:"")
 ...I $P(PSOXND,"^",9) D
 ....I $P(PSOXND,"^",9)=1 W !?1,"Exclusion: ACTIVE RX "_$P(PSOXND,"^",11) Q
 ....I $P(PSOXND,"^",9)=2 W !?1,"Exclusion: ACTUAL APPT. <30 DAYS FROM DATE APPT. MADE" Q
 ....I $P(PSOXND,"^",9)=3 W !?1,"Exclusion: ACTIVE RX "_$P(PSOXND,"^",11)_" & ACTUAL APPT. <30 DAYS FROM DATE APPT. MADE"
 ...I ($Y+6)>IOSL,$G(PSOVADIS)'="" D HD I PSOGPOUT K PSOVADIS,PSOVADIX Q
 ...I $G(PSOVADIS)'="" W !,$G(PSOVADIS)
 ...I ($Y+6)>IOSL,$G(PSOVADIX)'="" D HD I PSOGPOUT K PSOVADIS,PSOVADIX Q
 ...I $G(PSOVADIX)'="" W !,$G(PSOVADIX)
 ...K PSOVADIS,PSOVADIX
 ...I ($Y+6)>IOSL,PSOTARX'=$G(PSOTAR(PSOG1)) D HD
 G END
HD ;HEADER
 I PSOGDV,PSOGPAGE'=1 W ! K DIR S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR I 'Y S PSOGPOUT=1 Q
 I PSOGPAGE=1,'PSOGDV W ! I 1
 E  W @IOF
 W !,$S(PSOGSORT="E":"Eligible Patients",PSOGSORT="I":"Ineligible Patients",1:"All Patients")_$S($G(PSOINAME)="":"",1:" (")_$G(PSOINAME)_$S($G(PSOINAME)="":"",1:")")_"  Total: "_$S($G(PSOG1)'="":$G(PSOTAR(PSOG1)),1:""),?68,"PAGE: "_PSOGPAGE
 S PSOGPAGE=PSOGPAGE+1
 ;I $G(PSOINAME)'="" W !,"("_PSOINAME_")"_"  Total: ",$G(PSOTAR(PSOG1))
 W !,"Grand Total: "_PSOGTOP,?38,"Start",?47,"Stop",?56,"Letter",?65,"Inactivation",!,"Patient",?38,"Date",?47,"Date",?56,"Date",?65,"Reason",!,PSOGPLIN
 Q
END ;End report
 K ^TMP("PSOGP",$J),PSOGPAR,PSOGSORT,PSOGPINS
 I '$G(PSOGPOUT),PSOGDV W !!,"End of Report." K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 I 'PSOGDV W !!,"End of Report."
 I PSOGDV W !
 E  W @IOF
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
ADDR ;Check for difference in State
 N PSOVA1,PSOVA2,VAPA
 S (PSOVADIX,PSOVADIS)=""
 S DFN=$P($G(^PS(52.91,PSOG4,0)),"^")
 I '$G(DFN) Q
 D ADD^VADPT
 I '$G(VAPA(12)) K VAPA G ADDRX
 I $P($G(VAPA(22,1)),"^",3)'="Y",$P($G(VAPA(22,2)),"^",3)'="Y",$P($G(VAPA(22,5)),"^",3)'="Y" K VAPA G ADDRX
 S PSOVADIS="Confidential State = "_$P($G(VAPA(17)),"^",2)
 I $G(VAPA(5))'=$G(VAPA(17)) S PSOVADIX=$S($G(VAPA(9)):"Temporary State = ",1:"Permanent State = ")_$P($G(VAPA(5)),"^",2)
 K VAPA
 Q
ADDRX ;
 K VAPA D ADD^VADPT I '$G(VAPA(9)) S PSOVADIS="Permanent State = "_$P($G(VAPA(5)),"^",2) K VAPA Q
 S PSOVADIS="Temporary State = "_$P($G(VAPA(5)),"^",2)
 S PSOVA1=$G(VAPA(5))
 K VAPA S VAPA("P")="" D ADD^VADPT
 S PSOVA2=$G(VAPA(5))
 I PSOVA1=PSOVA2 K VAPA Q
 S PSOVADIX="Permanent State = "_$P($G(PSOVA2),"^",2)
 K VAPA
 Q
