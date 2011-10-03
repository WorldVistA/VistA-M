RGEVPM ;BIR/CML-VIEW POTENTIAL MATCH PATIENT LIST ;07/20/99
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**1,3,19**;30 Apr 99
 S QFLG=1
BEGIN ;
 W !!,"This report prints a list of patients who have been identified as having"
 W !,"multiple Potential Matches on the Master Patient Index (MPI) and who haven't"
 W !,"yet been resolved using the option ""Single Patient Initialization to MPI""."
 W !,"Status is current as of the date/time the report is generated."
 W !!,"This data is pulled from the CIRN HL7 EXCEPTION LOG file (#991.1)."
 W !,"Prior to producing the report, duplicate POTENTIAL MATCH patients will be"
 W !,"purged from the file."
 ;
 D EXCTMP
 I XCNT=0 W !!,"There are no patients identified as Potential Matches." G QUIT
DEV ;
 W !!,"The right margin for this report is 80.",!!
 D EN^XUTMDEVQ("START^RGEVPM","MPI/PD - Potential Match Patient List") I 'POP Q
 W !,"NO DEVICE SELECTED OR REPORT PRINTED!!"
 G QUIT
START ;
 S HOME=$$SITE^VASITE()   ;institution file ptr^station name^station number
 ;
LOOP ;Search ^RGHL7(991.1,"ADFN" to see how many patients need to be resolved to MPI
 K ^TMP("RGEVPM",$J)
 ;
 S (RCNT,RGDFN)=0
 F  S RGDFN=$O(^RGHL7(991.1,"ADFN",218,RGDFN)) Q:'RGDFN  D
 .S ICN=+$$GETICN^MPIF001(RGDFN)
 .I $E(ICN,1,3)=$P(HOME,"^",3)!(ICN<0) D
 ..S RCNT=RCNT+1
 ..S DFN=RGDFN D DEM^VADPT
 ..S ^TMP("RGEVPM",$J,VADM(1),RGDFN)=$P(VADM(2),"^")_"^"_$P(VADM(3),"^",2)
 ;
PRT ;Print report
 S (PG,QFLG)=0,$P(LN,"-",81)="",LOCSITE=$P(HOME,"^",2)
 D NOW^%DTC S HDT=$$FMTE^XLFDT($E(%,1,12))
 D HDR
 I '$D(^TMP("RGEVPM",$J)) W !!,"No patients found who need to be resolved to the MPI." G QUIT
 ;
 ;count the number of patients who need to be resolved
 S PTNM="",CNT=0
 F  S PTNM=$O(^TMP("RGEVPM",$J,PTNM)) Q:PTNM=""  Q:QFLG  D
 .S RGDFN=0
 .F  S RGDFN=$O(^TMP("RGEVPM",$J,PTNM,RGDFN)) Q:'RGDFN  S CNT=CNT+1
 ;
 S PTNM=""
 F  S PTNM=$O(^TMP("RGEVPM",$J,PTNM)) Q:PTNM=""  Q:QFLG  D
 .S RGDFN=0
 .F  S RGDFN=$O(^TMP("RGEVPM",$J,PTNM,RGDFN)) Q:'RGDFN  Q:QFLG  D
 ..S SSN=$P(^TMP("RGEVPM",$J,PTNM,RGDFN),"^")
 ..S DOB=$P(^TMP("RGEVPM",$J,PTNM,RGDFN),"^",2)
 ..D:$Y+4>IOSL HDR Q:QFLG  W !,PTNM,?36,SSN,?50,DOB,?68,$J(RGDFN,9)
 W !!,"TOTAL: ",CNT
 ;
QUIT ;
 I $E(IOST,1,2)="C-"&('QFLG) S DIR(0)="E" D  D ^DIR K DIR
 .S SS=22-$Y F JJ=1:1:SS W !
 K ^TMP("RGEVPM",$J)
 K %,CNT,DA,DFN,DIK,DIR,DOB,DUPCNT,EXCDT,HDT,HOME,ICN,IEN,IEN2,JJ,LCNT,LN,LOCSITE
 K NCNT,NODE,OLDDT,OLDNODE,PG,PTNM,QFLG,RCNT,RDT,RGDFN,SS,SSN,VADM,X,XCNT,Y,ZTSK
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" Q
 ;
HDR ;HEADER
 I $E(IOST,1,2)="C-" S SS=22-$Y F JJ=1:1:SS W !
 I $E(IOST,1,2)="C-",PG>0 S DIR(0)="E" W ! D ^DIR K DIR I 'Y S QFLG=1 Q
 S PG=PG+1 W:$Y!($E(IOST,1,2)="C-") @IOF
 W !,"PATIENT LIST of Potential Matches to be Resolved",?72,"Page: ",PG
 W !,"Printed at ",LOCSITE," on ",HDT
 W !!,"Patient Name",?39,"SSN",?52,"DOB",?70,"DFN",!,LN
 Q
 ;
EXCTMP ;Count number of POTENTIAL MATCH type entries (IEN=218) in CIRN HL7 EXCEPTION LOG 
 ;file 991.1, build XTMP global of unique patients and purge dup entries in file.
 W !!,"...one moment please..",!
 K ^TMP("RGEVPM",$J)
 S (RGDFN,CNT,XCNT,DUPCNT)=0
 F  S RGDFN=$O(^RGHL7(991.1,"ADFN",218,RGDFN)) Q:'RGDFN  D
 .S IEN=0
 .F  S IEN=$O(^RGHL7(991.1,"ADFN",218,RGDFN,IEN)) Q:'IEN  D
 ..S IEN2=0
 ..F  S IEN2=$O(^RGHL7(991.1,"ADFN",218,RGDFN,IEN,IEN2)) Q:'IEN2  D
 ...S CNT=CNT+1
 ...S EXCDT=$P(^RGHL7(991.1,IEN,0),"^",3)
 ...I '$D(^TMP("RGEVPM",$J,RGDFN)) D  Q
 ....S XCNT=XCNT+1
 ....D SETTMP
 ...I $D(^TMP("RGEVPM",$J,RGDFN))  D
 ....S OLDNODE=^TMP("RGEVPM",$J,RGDFN)
 ....S OLDDT=$P(OLDNODE,"^")
 ....I EXCDT>OLDDT D  Q
 .....S DA(1)=$P(OLDNODE,"^",2),DA=$P(OLDNODE,"^",3)
 .....D DELDUP
 .....D SETTMP
 ....I OLDDT>EXCDT!(OLDDT=EXCDT) D
 .....S DA(1)=IEN,DA=IEN2
 .....D DELDUP
 W !,DUPCNT," duplicate patient entries for POTENTIAL MATCH exceptions were identified"
 W !,"and deleted from the CIRN HL7 EXCEPTION LOG file (#991.1)."
 Q
 ;
SETTMP ;set TMP global for patient check
 S ^TMP("RGEVPM",$J,RGDFN)=EXCDT_"^"_IEN_"^"_IEN2
 Q
 ;
DELDUP ;delete patient dups from file
 S DUPCNT=DUPCNT+1
 S DIK="^RGHL7(991.1,"_DA(1)_",1,"
 D ^DIK K DIK,DA
 Q
 ;
CURPM() ;Call to check if there are any patients in the CIRN HL7 EXCEPTION LOG
 ;file (#991.1) with an exception TYPE of "POTENTIAL MATCH" who currently need
 ;to be resolved to the MPI.
 ;returns a value of "1" if any are found, "0" if none are found
 N LOC,RGDFN,GOT,ICN
 S LOC=$P($$SITE^VASITE(),"^",3)
 S (GOT,RGDFN)=0
 F  S RGDFN=$O(^RGHL7(991.1,"ADFN",218,RGDFN)) Q:'RGDFN  D  Q:GOT
 .S ICN=+$$GETICN^MPIF001(RGDFN)
 .I $E(ICN,1,3)=LOC!(ICN<0) S GOT=1 Q
 I GOT Q 1
 Q 0
