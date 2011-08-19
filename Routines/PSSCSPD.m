PSSCSPD ;BIR/RTR-Corresponding drug functions ;03/28/00
 ;;1.0;PHARMACY DATA MANAGEMENT;**34,47**;9/30/97
 ;
REP ;
 W !!,"Since this report must check every drug in the DRUG (#50) File, we recommend",!,"that you queue this report to a printer.",!
 K IOP,%ZIS,POP S %ZIS="QM" D ^%ZIS I $G(POP) W !!,"Nothing queued to print.",! Q
 I $D(IO("Q")) S ZTRTN="START^PSSCSPD",ZTDESC="Corresponding drug report" D ^%ZTLOAD K %ZIS W !,"Report queued to print.",! Q
START ;
 U IO
 K ^TMP($J,"PSSC")
 S (PSSOUT,PSSHV,PSSONE)=0,PSSDV=$S($E(IOST)="C":"C",1:"P"),PSSCT=1
 K PSSLINE S $P(PSSLINE,"-",78)=""
 D HDC
 S PSSN="" F  S PSSN=$O(^PSDRUG("B",PSSN)) Q:PSSN=""!($G(PSSOUT))  F PSSIEN=0:0 S PSSIEN=$O(^PSDRUG("B",PSSN,PSSIEN)) Q:'PSSIEN!($G(PSSOUT))  D
 .Q:'$D(^PSDRUG(PSSIEN,0))
 .S PSSINDTE=0 I $P($G(^PSDRUG(PSSIEN,"I")),"^"),$P($G(^("I")),"^")'>DT S PSSINDTE=1
 .S PSSNODE=$G(^PSDRUG(PSSIEN,8))
 .I '$P(PSSNODE,"^",5),'$P(PSSNODE,"^",6) Q
 .I ($Y+5)>IOSL D HDC Q:$G(PSSOUT)
 .S PSSONE=1
 .W !!,$P($G(^PSDRUG(PSSIEN,0)),"^")
 .I ($Y+5)>IOSL D HDC Q:$G(PSSOUT)
 .S PSSUSE=$P($G(^PSDRUG(PSSIEN,2)),"^",3)
 .K PSSI,PSSO,PSSOX,PSSIX
 .I $P(PSSNODE,"^",5) W !?3,"Corresponding Outpatient drug: ",?36,$P($G(^PSDRUG(+$P(PSSNODE,"^",5),0)),"^") D
 ..S PSSOX=+$P(PSSNODE,"^",5) I 'PSSOX!($P($G(^PSDRUG(+$G(PSSOX),0)),"^")="") Q
 ..Q:$P($G(^PSDRUG(PSSOX,8)),"^",6)
 ..Q:$D(^TMP($J,"PSSC",$P($G(^PSDRUG(+$G(PSSOX),0)),"^"),1))
 ..Q:$G(PSSINDTE)
 ..I PSSUSE["I"!(PSSUSE["U") S ^TMP($J,"PSSC",$P($G(^PSDRUG(+$G(PSSOX),0)),"^"),1)=$P($G(^PSDRUG(PSSIEN,0)),"^")
 .I $P(PSSNODE,"^",6) W !?3," Corresponding Inpatient drug: ",?36,$P($G(^PSDRUG(+$P(PSSNODE,"^",6),0)),"^") D
 ..S PSSIX=+$P(PSSNODE,"^",6) I 'PSSIX!($P($G(^PSDRUG(+$G(PSSIX),0)),"^")="") Q
 ..Q:$P($G(^PSDRUG(PSSIX,8)),"^",5)
 ..Q:$D(^TMP($J,"PSSC",$P($G(^PSDRUG(+$G(PSSIX),0)),"^"),2))
 ..Q:$G(PSSINDTE)
 ..I PSSUSE["O" S ^TMP($J,"PSSC",$P($G(^PSDRUG(+$G(PSSIX),0)),"^"),2)=$P($G(^PSDRUG(PSSIEN,0)),"^")
 I '$G(PSSOUT),'$G(PSSONE) W !?5,"No Corresponding Drugs were found.",!
 I $G(PSSOUT) G END
 S PSSHV=1 S:PSSCT=1 PSSCT=2 D HDC I $G(PSSOUT) G END
 I '$D(^TMP($J,"PSSC")) W !!?5,"There are no potential matches!",! G END
 S PSSNM="" F  S PSSNM=$O(^TMP($J,"PSSC",PSSNM)) Q:PSSNM=""!($G(PSSOUT))  D
 .I ($Y+5)>IOSL D HDC Q:$G(PSSOUT)
 .W !!,$G(PSSNM)
 .I ($Y+5)>IOSL D HDC Q:$G(PSSOUT)
 .I $D(^TMP($J,"PSSC",PSSNM,2)) W !," ** Potential corr. Outpatient Drug: "_$G(^(2))
 .I $D(^TMP($J,"PSSC",PSSNM,1)) W !," **  Potential corr. Inpatient Drug: "_$G(^(1))
END ;
 I '$G(PSSOUT),$G(PSSDV)="C" W !!,"End of Report." K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 I $G(PSSDV)="C" W !
 E  W @IOF
 K ^TMP($J,"PSSC")
 K PSSI,PSSINDTE,PSSNM,PSSONE,PSSHV,PSSO,PSSIX,PSSOX,PSSB,PSSUSE,PSSLINE,PSSOUT,PSSNODE,PSSN,PSSIEN D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
HDC ;
 I $G(PSSDV)="C",$G(PSSCT)'=1 W ! K DIR S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR I 'Y S PSSOUT=1 Q
 W @IOF W !,$S('$G(PSSHV):"Current Corresponding Inpatient/Outpatient Drug Matches",1:" *** Potential Corresponding Inpatient/Outpatient Drug Matches"),?68,"PAGE: "_$G(PSSCT),!,PSSLINE S PSSCT=PSSCT+1
 Q
EDIT ;
 W !! K DIC S DIC(0)="QEAMZ",DIC("A")="Select Drug: ",DIC="^PSDRUG(" D ^DIC K DIC I Y<1!($D(DTOUT))!($D(DUOUT)) W ! K PSSA,PSSI,PSSN,DA,DIE,DR Q
 S PSSI=+Y,PSSN=$P($G(^PSDRUG(PSSI,0)),"^"),PSSA=$P($G(^(2)),"^",3)
 W !!,"This entry is marked for the following PHARMACY packages:" W:PSSA["O" !," Outpatient" W:PSSA["U" !," Unit Dose" W:PSSA["I" !," IV" W:PSSA["W" !," Ward Stock" W:PSSA["N" !," Controlled Substances"
 I PSSA["O" I PSSA["I"!(PSSA["U") W ! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR G EDIT
 I PSSA'["O",PSSA'["U",PSSA'["I",PSSA'["W",PSSA'["N" W !," (none)"
 I PSSA'["O" W ! K DIE S DA=PSSI,DIE="^PSDRUG(",DR=62.05 D ^DIE K DIE I $D(Y)!($D(DTOUT)) G EDIT
 I PSSA'["I",PSSA'["U" W ! K DIE S DA=PSSI,DIE="^PSDRUG(",DR=905 D ^DIE K DIE
 G EDIT
 Q
PAT ;
 W ! K PSSOTH,DIC S DIC(0)="QEAMZ",DIC("A")="Select Pharmacy Orderable Item: ",DIC="^PS(50.7," D ^DIC K DIC I Y<1!($D(DTOUT))!($D(DUOUT)) G PATQ
 S PSSOTH=$S($P($G(^PS(59.7,1,40.2)),"^"):1,1:0)
 K DIE W ! S DA=+Y,DIE="^PS(50.7,",DR="7;S:'$G(PSSOTH) Y=""@1"";7.1;@1"
 D ^DIE G:$D(Y)!($D(DTOUT)) PATQ
 G PAT
PATQ W ! K DA,DIC,DIE,PSSOTH
 Q
MARK ;
 W !!,"This option will automatically mark all corresponding Inpatient and Outpatient",!,"drugs that are listed in the 'Potential Corresponding Inpatient/Outpatient Drug",!,"Matches' section of the 'Report of Corresponding Drugs'.",!
 W !,"Before using this option, please make sure you print a current 'Report of",!,"Corresponding Drugs' for review.",!
 K DIR S DIR(0)="Y",DIR("A")="Mark potential corresponding drugs",DIR("B")="Y" D  D ^DIR K DIR I Y'=1 G MARKQ
 .S DIR("?")=" ",DIR("?",1)="Enter 'Yes' to mark corresponding inpatient and outpatient drugs as displayed",DIR("?",2)="in the 'Potential Corresponding Inpatient/Outpatient Drug Matches' section of"
 .S DIR("?",3)="the 'Report of Corresponding Drugs'."
 W !!,"This job must be queued. You will receive a mail message upon completion.",!
 S PSSDUZX=$G(DUZ)
 K ZTDTH S ZTIO="",ZTRTN="MARKT^PSSCSPD",ZTDESC="AUTO-MARK CORRESPONDING DRUGS",ZTSAVE("PSSDUZX")="" D ^%ZTLOAD I $D(ZTSK)[0 W !!,"Nothing queued.",!
MARKQ K PSSDUZX
 Q
MARKT ;
 N PSSN,PSSIEN,PSSINDTE,PSSNODE
 S PSSN="" F  S PSSN=$O(^PSDRUG("B",PSSN)) Q:PSSN=""  F PSSIEN=0:0 S PSSIEN=$O(^PSDRUG("B",PSSN,PSSIEN)) Q:'PSSIEN  D
 .Q:'$D(^PSDRUG(PSSIEN,0))
 .I $P($G(^PSDRUG(PSSIEN,"I")),"^"),$P($G(^("I")),"^")'>DT Q
 .S PSSNODE=$G(^PSDRUG(PSSIEN,8))
 .I '$P(PSSNODE,"^",5),'$P(PSSNODE,"^",6) Q
 .S PSSUSE=$P($G(^PSDRUG(PSSIEN,2)),"^",3)
 .K PSSI,PSSO,PSSOX,PSSIX
 .I $P(PSSNODE,"^",5) D
 ..S PSSOX=+$P(PSSNODE,"^",5) I 'PSSOX!($P($G(^PSDRUG(+$G(PSSOX),0)),"^")="") Q
 ..Q:$P($G(^PSDRUG(PSSOX,8)),"^",6)
 ..I PSSUSE["I"!(PSSUSE["U") S $P(^PSDRUG(PSSOX,8),"^",6)=PSSIEN
 .I $P(PSSNODE,"^",6) D
 ..S PSSIX=+$P(PSSNODE,"^",6) I 'PSSIX!($P($G(^PSDRUG(+$G(PSSIX),0)),"^")="") Q
 ..Q:$P($G(^PSDRUG(PSSIX,8)),"^",5)
 ..I PSSUSE["O" S $P(^PSDRUG(PSSIX,8),"^",5)=PSSIEN
 I '$G(PSSDUZX) G MMM
 S XMDUZ="PHARMACY DATA MANAGEMENT",XMY(PSSDUZX)="",XMSUB="PDM CORRESPONDING DRUGS"
 K PSSXTEXT S PSSXTEXT(1)="The PDM job that automatically marks corresponding inpatient and",PSSXTEXT(2)="outpatient drugs is complete."
 S XMTEXT="PSSXTEXT(" D ^XMD K PSSXTEXT,XMDUZ,XMY,XMSUB,XMTEXT
MMM K PSSI,PSSO,PSSOX,PSSIX
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
