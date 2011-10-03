MDSTUDW ; HOIFO/NCA - Print a List of Procedures With Incomplete Workload ;3/2/09  10:00
 ;;1.0;CLINICAL PROCEDURES;**21**;Apr 01, 2004;Build 30
 ; Integration Agreements:
 ; IA #1894 [Subscription] PXAPI call
 ; IA# 10103 [Supported] XLFDT calls
 ; IA# 10061 [Supported] VADPT calls
 ; IA# 10062 [Supported] VADPT6 calls
 ; IA# 4869 [Private] ^DIC(45.7,
 ;
E1 ; Get Start Date
 N MDSDT,MDEDT
 S %DT("A")="Select Start Date: ",%DT="AEX" W ! D ^%DT G EX:"^"[X!$D(DTOUT),E1:Y<1 S MDSDT=+Y
E2 S %DT("A")="Select End Date: ",%DT="AEX" W ! D ^%DT G EX:"^"[X!$D(DTOUT),E2:Y<1
 I +Y<MDSDT W !!,"***End Date must be on or after Start Date!!!" G E2
 S MDEDT=+Y+.24
EN2 ; Print a list of Procedures with incomplete Workload
 N DIC,MDSPEC,X,Y,DTOUT,DUOUT
S1 R !!,"Select Facility Treating Specialty (or ALL): ",X:DTIME Q:'$T!("^"[X)  S:X="all" X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ") I X="ALL" S MDSPEC=0
 E  K DIC S DIC="^DIC(45.7,",DIC(0)="EMQ" D ^DIC G:Y<1!($D(DTOUT))!($D(DUOUT)) S1 S MDSPEC=+Y K DIC W !
 K IOP S %ZIS="MQ",%ZIS("A")="Select LIST Printer: ",%ZIS("B")="HOME" W ! D ^%ZIS K %ZIS,IOP Q:POP
 I $D(IO("Q")) D QUE Q
 U IO D GETTRAN D ^%ZISC K %ZIS,IOP Q
QUE ; Queue List
 K IO("Q"),ZTUCI,ZTDTH,ZTIO,ZTSAVE,ZTDESC,ZTSK S ZTRTN="GETTRAN^MDSTUDW",ZTREQ="@",ZTSAVE("ZTREQ")="",ZTSAVE("MDSPEC")="",ZTSAVE("MDSDT")="",ZTSAVE("MDEDT")=""
 S:$D(XQY0) ZTDESC=$P(XQY0,"^",1)
 D ^%ZTLOAD D ^%ZISC U IO W !,"Request Queued",! K ZTSK Q
EX ; Exit
 Q
GETTRAN ; [Procedure] Loop through Results by Date/Time Performed
 K ^TMP("MDSTUDW",$J)
 N ANS,BID,DFN,DTP,LN,MDL,MDL1,MDCHKD,MDCHKDT,MDCOM,MDCNST,MDCOMP,MDDEFN,MDNUM,MDPNAM,MDREQ,MDANOD,MDBNOD,MDCNOD,MDSP,MDTXT,MDVS,MDVST,MDX,PG,S1,X1,X2,X,Y0,Z
 N MDCT,MDLOP,MDOK,MDOK1,MDOK2,MDVDT S S1=$S(IOST?1"C".E:IOSL-8,1:IOSL-7)
 S LN="",$P(LN,"-",79)="",MDCOM=0
 S PG=0 N % D NOW^%DTC S DTP=%,DTP=$$FMTE^XLFDT(DTP,"1P")
 S MDL=MDSDT F  S MDL=$O(^MDD(703.1,"ADTP",MDL)) Q:'MDL!(MDL>MDEDT)  F MDL1=0:0 S MDL1=$O(^MDD(703.1,"ADTP",MDL,MDL1)) Q:MDL1<1  D
 .S (MDANOD,MDBNOD,MDCNOD)=""
 .S MDCOM=$P($G(^MDD(703.1,+MDL1,0)),"^",5)
 .S MDVST=+$G(^MDD(702,+MDCOM,1)) Q:'MDVST
 .D ENCEVENT^PXAPI(MDVST) S (MDOK,MDOK1,MDOK2)=0
 .I $D(^TMP("PXKENC",$J,MDVST,"POV")) S MDOK=1
 .I $D(^TMP("PXKENC",$J,MDVST,"CPT")) S MDOK1=1
 .I $D(^TMP("PXKENC",$J,MDVST,"PRV")) S MDOK2=1
 .S MDVS=$O(^TMP("PXKENC",$J,MDVST,"VST",0))
 .S MDVDT=$P($G(^TMP("PXKENC",$J,MDVST,"VST",+MDVS,0)),"^",1)
 .K ^TMP("PXKENC",$J)
 .Q:(MDOK+MDOK1+MDOK2)=3
 .S DFN=+$P($G(^MDD(702,+MDCOM,0)),"^") D DEM^VADPT S MDPNAM=$G(VADM(1)) K VADM D PID^VADPT6 S BID=$G(VA("BID")) K VA
 .S MDBNOD=$S($L(MDPNAM)>24:$E(MDPNAM,1,24),1:MDPNAM)_" ("_BID_")",MDCNST=$P($G(^MDD(702,+MDCOM,0)),"^",5)
 .S MDANOD="UNASSIGNED",MDSP=+$$GET1^DIQ(702,+MDCOM,".04:.02","I")
 .I +MDSP Q:+MDSPEC>0&(+MDSPEC'=+MDSP)  S MDANOD=$$GET1^DIQ(702,+MDCOM,".04:.02")
 .I +$$GET1^DIQ(702,+MDCOM,.04,"I") S MDDEFN=$$GET1^DIQ(702,+MDCOM,.04),MDCNOD=MDVDT_"~"_MDBNOD
 .S MDANOD=MDANOD_"~"_MDDEFN
 .S Z=$$FMTE^XLFDT(MDVDT,"2MZ")_"^"_MDCNST_"^"_+$P($G(^MDD(702,+MDCOM,0)),"^",6)_"^"_MDVST_"^"_$S('MDOK:"Diagnosis",1:"")_"^"_$S('MDOK1:"CPT",1:"")_"^"_$S('MDOK2:"Provider",1:"")
 .I '$D(^TMP("MDSTUDW",$J,MDANOD,MDCNOD)) S ^TMP("MDSTUDW",$J,MDANOD,MDCNOD)=Z
 .Q
 I '$D(^TMP("MDSTUDW",$J)) S (ANS,MDANOD,MDLOP)="" D HDR W !!,"No procedures with incomplete workload found."
 N MDCT S MDCT=0,(ANS,MDCHKD)=""
 N MDLOP S MDLOP="" F  S MDLOP=$O(^TMP("MDSTUDW",$J,MDLOP)) Q:MDLOP=""!(ANS="^")  D
 .D HDR
 .S MDANOD="" F  S MDANOD=$O(^TMP("MDSTUDW",$J,MDLOP,MDANOD)) Q:MDANOD=""!(ANS="^")  D
 ..S Y0=$G(^TMP("MDSTUDW",$J,MDLOP,MDANOD))
 ..D:$Y>(IOSL-8) HDR Q:ANS="^"
 ..I MDCHKD'=$P(MDLOP,"~",2) W !,"PROCEDURE: ",$P(MDLOP,"~",2),! S MDCHKD=$P(MDLOP,"~",2)
 ..D:$Y'<S1 PAUSE Q:ANS="^"
 ..W !,$P(Y0,U),?18,$P(MDANOD,"~",2),?52,$P(Y0,U,2),?62,$P(Y0,U,3)
 ..I $P(Y0,U,5)'="" W ?69,$P(Y0,U,5)
 ..I $P(Y0,U,6)'="" W !?69,$P(Y0,U,6)
 ..I $P(Y0,U,7)'="" W !?69,$P(Y0,U,7)
 ..W ! Q
 .Q
 K ^TMP("MDSTUDL",$J)
 Q
HDR ; List Header
 Q:ANS="^"  D:$Y'<S1 PAUSE Q:ANS="^"
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1
 W !,DTP,?73,"Page ",PG,!!?5,"P R O C E D U R E S   W I T H   I N C O M P L E T E   W O R K L O A D",!!
 S Y=$S($P(MDLOP,"~")="UNASSIGNED":"",1:$P(MDLOP,"~")) W:Y'="" !?(78-$L(Y)\2),Y,!
 W !,"Visit D/T",?18,"Patient",?50,"Consult #",?62,"TIU #",?69,"MISSING",!,LN
 Q
PAUSE ; Pause For Scroll
 I IOST?1"C".E K DIR S DIR(0)="E",DIR("A")="Enter RETURN to Continue or '^' to Quit Listing"  D ^DIR I 'Y S ANS="^"
 Q
