SROPCEU ;BIR/ADM-List/Refile Not Transmitted Outpatient Encounters ; [ 09/22/98  11:41 AM ]
 ;;3.0; Surgery ;**69,77,50**;24 Jun 93
 S (SRFLG,SRSORT,SRSOUT)=0,SRSPEC=""
 W @IOF,!,?13,"Outpatient Surgery Encounters Not Transmitted to NPCD",!!!,"Surgical cases filed with PCE that have no Scheduling appointment status",!,"or that have an appointment status of ACTION REQUIRED or NON-COUNT indicate"
 W !,"surgical encounters that have not transmitted to the National Patient",!,"Care Database.  This option is intended as a tool to identify these",!,"encounters and, after taking appropriate corrective measures, to"
 W !,"reinitiate the encounter transmission process.",!!
ASK K DIR S DIR("A",1)="  1. Print list of cases.",DIR("A",2)="  2. Print total number of cases only.",DIR("A",3)="  3. Re-file cases in PCE.",DIR("A",4)="",DIR("A")="Select Number: ",DIR("B")=1
 S DIR("?",1)="Enter 1 to print a list of surgical cases and/or non-OR procedures that are",DIR("?",2)="filed in PCE, but have no Scheduling appointment status or have an"
 S DIR("?",3)="an appointment status of ACTION REQUIRED or NON-COUNT.",DIR("?",4)="",DIR("?",5)="Enter 2 to print the total number of cases only with no list."
 S DIR("?",6)="",DIR("?",7)="Enter 3 to re-file in PCE surgical cases and/or non-OR procedures that are"
 S DIR("?",8)="already filed, but have no Scheduling appointment status or have an",DIR("?")="appointment status of ACTION REQUIRED or NON-COUNT."
 S DIR(0)="NA^1:3:0" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 D END Q
 S SRSEL=Y W !!
 S DIR("A",1)=$S(SRSEL=1:"Print the list for",SRSEL=2:"Print totals for",1:"Re-file")_" the following.",DIR("A",2)="",DIR("A",3)="  1. O.R. Surgical Procedures",DIR("A",4)="  2. Non-O.R. Procedures"
 S DIR("A",5)="  3. Both O.R. Surgical Procedures and Non-O.R. Procedures (All Specialties)",DIR("A",6)="",DIR("A")="Select Number (1, 2 or 3): ",DIR("B")="1"
 S DIR(0)="NA^1:3:0" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 D END Q
 S SRFLG=Y I SRFLG=1 D SPEC I SRSOUT D END Q
 I SRFLG=2 D MSP I SRSOUT D END Q
 I SRFLG=3 D ALL I SRSOUT D END Q
DATE D DATE^SROUTL(.SDATE,.EDATE,.SRSOUT) G:SRSOUT END
 I SRSEL'=3 W ! K %ZIS,IOP,IO("Q"),POP D  I SRSOUT D END Q
 .S %ZIS("A")="Print report on which printer ? ",%ZIS="Q" D ^%ZIS I POP S SRSOUT=1
 .I $D(IO("Q")) K IO("Q") D ZT D ^%ZTLOAD S SRSOUT=1
 I SRSEL=3 D ZT S ZTIO="" D ^%ZTLOAD W:$G(ZTSK) !," (Task #"_ZTSK_")" D END Q
EN D TMP I SRSEL'=3 D ^SROPCEU0
 I SRSEL=3 D REFILE^SROPCEU0
END W:$E(IOST)="P" @IOF K ^TMP("SR69",$J),^TMP("SRSP",$J) I $D(ZTQUEUED) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 I 'SRSOUT,$E(IOST)'="P" W !!,"Press RETURN to continue  " R X:DTIME
 D ^%ZISC K SR12,SRDIV,SRDX,SRENC,SRFCPT,SRFICD,SRFRTO,SRINOUT,SRPARAM,SRPODX,SRQCPT,SRQICD,SRRPT,SRSEL,SRSORT,SRSPS,SRSR,SRTN,SRUCPT,SRUICD D ^SRSKILL W @IOF
 Q
ZT S ZTDESC=$S(SRSEL=2:"Re-file",1:"Report of")_" Untransmitted Surgery Oupatient Encounters"
 S (ZTSAVE("EDATE"),ZTSAVE("SDATE"),ZTSAVE("SRSITE*"),ZTSAVE("SRSPEC*"),ZTSAVE("SRFLG"),ZTSAVE("SRSEL"),ZTSAVE("SRSORT"))=""
 S ZTRTN="EN^SROPCEU"
 Q
SPEC W ! S DIR("?",1)="Enter YES if you would like "_$S(SRSEL=3:"re-filing",1:"the report printed")_" for all Surgical Specialties",DIR("?")="or enter NO to select a specific specialty."
 S DIR("A")="Do you want "_$S(SRSEL=3:"re-filing",1:"the report")_" for all Surgical Specialties ? ",DIR("B")="YES",DIR(0)="YA" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 I Y D ALL Q
 I 'Y W ! K DIC S DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Select Surgical Specialty: ",DIC("S")="I '$P(^(0),""^"",3)" D ^DIC K DIC S:Y<0 SRSOUT=1 Q:Y<0  S SRSPEC=+Y,SRSPECN=$P(Y(0),"^")
 Q
ALL Q:SRSEL=3  W ! I SRSEL=1 D
 .S DIR("?",1)="Enter YES if you would like the report to be sorted by specialty.  Enter NO",DIR("?")="if you would like all specialties combined and sorted by case number.",DIR("A")="Do you want the report sorted by Specialty ? "
 I SRSEL=2 D
 .S DIR("?",1)="Enter YES if you would like the report to give totals for each specialty.",DIR("?")="Enter NO if you would like totals for all specialties combined.",DIR("A")="Do you want totals separated by Specialty ? "
 S DIR("B")="YES",DIR(0)="YA" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 I Y S SRSORT=1
 Q
MSP W ! S DIR("?",1)="Enter YES if you would like "_$S(SRSEL=3:"re-filing",1:"the report printed")_" for all Medical Specialties",DIR("?")="or enter NO to select a specific specialty."
 S DIR("A")="Do you want "_$S(SRSEL=3:"re-filing",1:"the report")_" for all Medical Specialties ? ",DIR("B")="YES",DIR(0)="YA" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 I Y D ALL Q
 I 'Y W ! K DIC S DIC=723,DIC(0)="QEAMZ",DIC("A")="Select Medical Specialty: " D ^DIC K DIC S:Y<0 SRSOUT=1 Q:Y<0  S SRSPEC=+Y,SRSPECN=$P(Y(0),"^")
 Q
TMP ; identify cases with not transmitted encounters
 N SRVSIT S SRSDT=SDATE-.0001,SRSEDT=EDATE+.9999 K ^TMP("SR69",$J),^TMP("SRSP",$J) S:SRSORT ^TMP("SRSP",$J,0)="0^0^0^0" S SRCNT=0 F I=0,12,14 S SRCNT(I)=0
 F  S SRSDT=$O(^SRF("AC",SRSDT)) Q:'SRSDT!(SRSDT>SRSEDT)  S SRTN=0 F  S SRTN=$O(^SRF("AC",SRSDT,SRTN)) Q:'SRTN  I $D(^SRF(SRTN,0)),$$DIV^SROUTL0(SRTN) D
 .S SR=^SRF(SRTN,0),SR12=$P(SR,"^",12),SRVSIT=$P(SR,"^",15) Q:'SRVSIT!(SR12'="O")
 .S SRNON=0 I $P($G(^SRF(SRTN,"NON")),"^")="Y" S SRNON=1
 .I SRFLG=1,SRNON Q
 .I SRFLG=2,'SRNON Q
 .S SRSS=$S('SRNON:$P(SR,"^",4),1:$P(^SRF(SRTN,"NON"),"^",8)) I SRSPEC,SRSPEC'=SRSS Q
 .I 'SRNON S SRSS="1;;"_$P(^SRO(137.45,SRSS,0),"^")
 .I SRNON S SRSS="2;;"_$P(^ECC(723,SRSS,0),"^")
 .S SRENC=$O(^SCE("AVSIT",SRVSIT,0))
 .I 'SRENC D  S SRCNT(0)=SRCNT(0)+1 Q
 ..I '$D(^TMP("SRSP",$J,SRSS,0)) S ^TMP("SRSP",$J,SRSS,0)="0^0^0^0"
 ..S ^TMP("SRSP",$J,SRSS,SRTN)="",$P(^TMP("SRSP",$J,SRSS,0),"^")=$P(^TMP("SRSP",$J,SRSS,0),"^")+1,^TMP("SR69",$J,SRTN)=""
 .K SRX S DA=SRENC,DIC=409.68,DR=".12",DIQ="SRX",DIQ(0)="IE" D EN^DIQ1 K DA,DIC,DIQ,DR
 .S SRZ=SRX(409.68,SRENC,.12,"I") I SRZ'=12&(SRZ'=14) Q
 .S SRCNT(SRZ)=SRCNT(SRZ)+1,^TMP("SR69",$J,SRTN)=SRX(409.68,SRENC,.12,"E")
 .I '$D(^TMP("SRSP",$J,SRSS,0)) S ^TMP("SRSP",$J,SRSS,0)="0^0^0^0"
 .S ^TMP("SRSP",$J,SRSS,SRTN)=SRX(409.68,SRENC,.12,"E"),$P(^TMP("SRSP",$J,SRSS,0),"^",$S(SRZ=12:2,1:3))=$P(^TMP("SRSP",$J,SRSS,0),"^",$S(SRZ=12:2,1:3))+1
 F I=0,12,14 S SRCNT=SRCNT+SRCNT(I)
 S ^TMP("SRSP",$J,0)=SRCNT(0)_"^"_SRCNT(12)_"^"_SRCNT(14)_"^"_SRCNT
 S SRSS=0 F  S SRSS=$O(^TMP("SRSP",$J,SRSS)) Q:SRSS=""  D
 .S X=0 F I=1:1:3 S X=X+$P(^TMP("SRSP",$J,SRSS,0),"^",I)
 .S $P(^TMP("SRSP",$J,SRSS,0),"^",4)=X
 Q
