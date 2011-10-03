SROQD ;BIR/ADM - CASES WITH DEATHS WITHIN 30 DAYS ;09/22/98  11:45 AM
 ;;3.0; Surgery ;**62,77,50,142**;24 Jun 93
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure.  Local modifications to this routine
 ;**         are prohibited.
 ;
 S SRSOUT=0,SRIO="A",SRSPEC="" W @IOF,!,?24,"Deaths Within 30 Days of Surgery"
 W !!,"This report lists patients who had surgery within the selected date range,",!,"who died within 30 days of surgery and whose deaths are included on the",!,"Quarterly/Summary Report."
 D DATE^SROUTL(.SDATE,.EDATE,.SRSOUT) G:SRSOUT END
SEC W !! K DIR S DIR("A",1)="Print report for which section of Quarterly/Summary Report ?",DIR("A",2)="",DIR("A",3)=" 1. Total Cases Summary",DIR("A",4)=" 2. Specialty Procedures",DIR("A",5)=" 3. Index Procedures"
 S DIR("A",6)="",DIR("A")="Select number: ",DIR("B")=1,DIR(0)="SAM^1:Total Cases Summary;2:Specialty Procedures;3:Index Procedures" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 G END
 S SRSEL=Y D:SRSEL=2 SPEC
 I SRSEL=1 W @IOF S SRRPT="Deaths within 30 Days of Surgery" D INOUT^SROUTL
 N SRINSTP S SRINST=$$INST^SROUTL0() G:SRINST="^" END S SRINSTP=$P(SRINST,"^"),SRINST=$S(SRINST["ALL DIVISIONS":SRINST,1:$P(SRINST,"^",2))
 I SRSOUT G END
IO W !!,"This report is designed to use a 132 column format.",!
 K %ZIS,IOP,IO("Q"),POP S %ZIS("A")="Print the report to which Printer ? ",%ZIS("B")="",%ZIS="Q" D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTDESC="Deaths within 30 Days of Surgery",(ZTSAVE("EDATE"),ZTSAVE("SDATE"),ZTSAVE("SRIO"),ZTSAVE("SRSEL"),ZTSAVE("SRINSTP"),ZTSAVE("SRSPEC*"))="",ZTRTN="EN^SROQD" D ^%ZTLOAD S SRSOUT=1 G END
EN U IO S (SRCTOT,SRDTOT,SRHDR2,SRSNM,SRSOUT)=0,(SRHDR,SRPAGE)=1,SRSD=SDATE-.0001,SRED=EDATE+.9999,Y=SDATE X ^DD("DD") S STARTDT=Y,Y=EDATE X ^DD("DD") S ENDATE=Y
 D KTMP S SRRPT="DEATHS WITHIN 30 DAYS OF SURGERY"_$S(SRSEL=2:" LISTED FOR SPECIALTY PROCEDURES",SRSEL=3:" LISTED FOR INDEX PROCEDURES",1:"")
 S SRFRTO="FOR "_$S(SRIO="O":"OUTPATIENT ",SRIO="I":"INPATIENT ",1:"")_"SURGERY PERFORMED FROM: "_STARTDT_"  TO: "_ENDATE
 S SRINST=$S(SRINSTP["ALL DIV":$P($$SITE^SROVAR,"^",2)_" - ALL DIVISIONS",1:$$GET1^DIQ(4,SRINSTP,.01))
 D NOW^%DTC S Y=$E(%,1,12) X ^DD("DD") S SRPRINT="Report Printed: "_Y
 D AC^SROQD0 D:SRSEL=1 PLIST D:SRSEL=2 NAT^SROQD1 D:SRSEL=3 IP^SROQD1
END W:$E(IOST)="P" @IOF D KTMP I $D(ZTQUEUED) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 I 'SRSOUT,$E(IOST)'="P" D PRESS
 D ^%ZISC K SRCTOT,SRDNAT,SRDTH,SRDTOT,SRFRTO,SRHDR2,SRINV,SRIO,SRIOSTAT,SRNAT,SRNATNM,SRRPT,SRSEL,SRTN D ^SRSKILL W @IOF
 Q
PRESS W !! K DIR S DIR(0)="E" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
KTMP F I="SR","SRDEATH","SRDTH","SRINOUT","SRIP","SRIOST","SRNM","SRPAT","SRNAT","SRSEC","SRREL","SRTN" K ^TMP(I,$J)
 Q
PLIST ; print patient list for total cases
 D HDR^SROQD0 S SRNM="" I SRIO'="A" D NOTA,TOT Q
 F  S SRNM=$O(^TMP("SRPAT",$J,SRNM)) Q:SRNM=""!SRSOUT  S DFN=0 F  S DFN=$O(^TMP("SRPAT",$J,SRNM,DFN)) Q:'DFN!SRSOUT  S SRZ=^(DFN) D
 .S SRSNM=0,SRSSN=$P(SRZ,"^"),(SRDD,X1)=$P(SRZ,"^",3),X2=$P(SRZ,"^",2),SRAGE=$E(X1,1,3)-$E(X2,1,3)-($E(X1,4,7)<$E(X2,4,7)) D PAT
TOT I 'SRSOUT S SRHDR2=1 D SUM^SROQD0
 Q
NOTA ; print in or out-patient deaths
 F  S SRNM=$O(^TMP("SRSEC",$J,SRIO,SRNM)) Q:SRNM=""!SRSOUT  S DFN=0 F  S DFN=$O(^TMP("SRSEC",$J,SRIO,SRNM,DFN)) Q:'DFN!SRSOUT  S SRTN=^TMP("SRSEC",$J,SRIO,SRNM,DFN),SRZ=^TMP("SRPAT",$J,SRNM,DFN) D
 .S SRSSN=$P(SRZ,"^"),(SRDD,X1)=$P(SRZ,"^",3),X2=$P(SRZ,"^",2),SRAGE=$E(X1,1,3)-$E(X2,1,3)-($E(X1,4,7)<$E(X2,4,7))
 .S SRNAME=">>> "_SRNM_"  ("_SRSSN_") - DIED "_$E(SRDD,4,5)_"/"_$E(SRDD,6,7)_"/"_$E(SRDD,2,3)_"  AGE: "_SRAGE,SRDTOT=SRDTOT+1
 .D:$Y+9>IOSL PAGE^SROQD0 Q:SRSOUT  W !,SRNAME,! S SRSNM=1
 .S SRSD=$P(^SRF(SRTN,0),"^",9),SRZ=^TMP("SR",$J,DFN,SRSD,SRTN) D OP S SRSNM=0 W ! F I=1:1:IOM W "-"
 Q
PAT ; print new patient information
 S SRNAME=">>> "_SRNM_"  ("_SRSSN_") - DIED "_$E(SRDD,4,5)_"/"_$E(SRDD,6,7)_"/"_$E(SRDD,2,3)_"  AGE: "_SRAGE,SRDTOT=SRDTOT+1
 D:$Y+9>IOSL PAGE^SROQD0 Q:SRSOUT  W !,SRNAME,! S SRSNM=1,SRSD=0 F  S SRSD=$O(^TMP("SR",$J,DFN,SRSD)) Q:'SRSD  S SRTN=0 F  S SRTN=$O(^TMP("SR",$J,DFN,SRSD,SRTN)) Q:'SRTN!SRSOUT  D OP
 S SRSNM=0 W ! F I=1:1:IOM W "-"
 Q
OP ; print case information
 Q:SRSD<(SDATE-.0001)!(SRSD>(EDATE+.9999))  D:$Y+7>IOSL PAGE^SROQD0 Q:SRSOUT
 S SRZ=^TMP("SR",$J,DFN,SRSD,SRTN),Y=SRSD,SRSDATE=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3),Y=$P(SRZ,"^"),SRSS=$S(Y=9999:"SPECIALTY NOT ENTERED",1:$P(^SRO(137.45,Y,0),"^"))
 S Y=$P(SRZ,"^",2),SRIOSTAT=$S(Y="I":"INPAT",Y="O":"OUTPAT",1:"???"),Y=$P(SRZ,"^",3),SRREL=$S(Y="U":"UNRELATED",Y="R":"RELATED",1:"???")
 S SRCON=$P(SRZ,"^",4) S SRL=52,SRSUPCPT=1 D PROC^SROUTL
 W !,SRSDATE,?10,SRTN,?22,SRIOSTAT,?31,$E(SRSS,1,35),?69,SRPROC(1),?123,SRREL,! W:SRCON "*** CONCURRENT CASE #"_SRCON_" ***" S I=1 F  S I=$O(SRPROC(I)) Q:'I  W ?69,SRPROC(I),!
 I SRCON,'$D(SRPROC(2)) W !
 Q
SPEC ; select national specialty
 W @IOF,! S DIR("?",1)="Enter YES if you would like the report printed for all National Surgical",DIR("?")="Specialties or enter NO to select a specific specialty."
 S DIR("A")="Do you want the report for all National Surgical Specialties ? ",DIR("B")="YES",DIR(0)="YA" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 I 'Y W ! K DIC S DIC=45.3,DIC(0)="QEAMZ",DIC("A")="Select National Surgical Specialty: ",DIC("S")="I '$P(^(0),""^"",3)" D ^DIC K DIC S:Y<0 SRSOUT=1 Q:Y<0  S SRSPEC=+Y,SRSPECN=$P(Y(0),"^")
 Q
