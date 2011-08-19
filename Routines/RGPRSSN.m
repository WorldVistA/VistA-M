RGPRSSN ;WAS/FHM-MPI/PD PSEUDO/MISSING SSN REPORT ;6/25/98
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**19,34**;30 Apr 99
 ;
 ;Reference to ^DIC(8 supported by IA #427
 ;Reference to ^DGPM( supported by IA #966
 ;Reference to ^SCE( supported by IA #2443
 ;Reference to ADM^VADPT2 supported by IA #325
 ;
 ;EXTRACT BAD SSN AND SORTS THEM BY CLASSIFICATION
 W !,"This report will provide a list of:"
 W !,"(1) any B Cross-references (there is no 'zero' node but a B x-ref)"
 W !,"    on the patient file,"
 W !,"(2) patients with Pseudo SSNs who have not had activity within the past 3 years,"
 W !,"(3) patients with Pseudo SSNs who have had activity within the past 3 years.",!
 W !,"The Reports are sorted by Primary Eligibility Code. The report can"
 W !,"be queued if desired."
 W !,!,"For MPI/PD purposes, general advice is to concentrate first on"
 W !,"getting correct SSNs for the patients who HAVE had activity within"
 W !,"the past 3 years.",!
 S %ZIS="QM" D ^%ZIS G EXIT:POP
 K ^TMP($J)
 I $D(IO("Q")) D  Q
   .S ZTRTN="DQ^RGPRSSN",ZTDESC="MPI/PD SSN VALIDATION"
   .D ^%ZTLOAD D HOME^%ZIS K IO("Q")
DQ N DTOUT,DUOUT S RGFS=1,PRNTCODE="",RGPRNTCO=""
 U IO W @IOF,!,"MPI/PD Report of Pseudo, missing & potentially false SSNs "
 D NOW^%DTC D YX^%DTC
 W ?55,Y,!
 W !,"Bad B Cross References Report"
 W !,"Please contact IRM for assistance with bad B Cross references."
 W !,"----------------------------------------------------------------------------"
 S BREF=0
 S NAME=""
 F  S NAME=$O(^DPT("B",NAME)) Q:NAME=""  D
   .S REFNO=0
   .S REFNO=$O(^DPT("B",NAME,REFNO)) Q:REFNO=""
   .IF $D(^DPT(REFNO,0)) S NODE=^DPT(REFNO,0),RGSSN=$P(NODE,"^",9)
   .E  S BREF=1 W !,"B Cross Reference with no 0 Node in DPT: DFN= ",REFNO Q
   .IF RGSSN="" S RGSSN="None"
   .IF RGSSN'?9N S SCRATCH=$$SETGBL
   .IF RGSSN="123456789" S SCRATCH=$$SETGBL
   .IF RGSSN="000000000" S SCRATCH=$$SETGBL
   .IF RGSSN="111111111" S SCRATCH=$$SETGBL
   .IF RGSSN="222222222" S SCRATCH=$$SETGBL
   .IF RGSSN="333333333" S SCRATCH=$$SETGBL
   .IF RGSSN="444444444" S SCRATCH=$$SETGBL
   .IF RGSSN="555555555" S SCRATCH=$$SETGBL
   .IF RGSSN="666666666" S SCRATCH=$$SETGBL
   .IF RGSSN="777777777" S SCRATCH=$$SETGBL
   .IF RGSSN="888888888" S SCRATCH=$$SETGBL
   .IF RGSSN?1"9"8N S SCRATCH=$$SETGBL
   .QUIT
 IF BREF=0 W !,"*** No Bad B Cross References Found in your account.***"
LST S (ACTIV1,ECODE1,NAME1,REFNO1)=""
LST1 S ACTIV1=$O(^TMP($J,ACTIV1)) G EXIT:ACTIV1="" D HEADER G EXIT:$D(DUOUT)!($D(DTOUT))
LST2 S ECODE1=$O(^TMP($J,ACTIV1,ECODE1))  G LST1:ECODE1="" D:$Y>(IOSL-4) HEADER,HEAD2 G:$D(DUOUT)!($D(DTOUT)) EXIT W ! S SCRATCH=$$GETECODE
LST3 S NAME1=$O(^TMP($J,ACTIV1,ECODE1,NAME1))  G LST2:NAME1="" D:$Y>(IOSL-4) HEADER,HEAD2 G:$D(DUOUT)!($D(DTOUT)) EXIT
 S REFNO1=^TMP($J,ACTIV1,ECODE1,NAME1)
 S (PHONE,RGSSN,ECODE)="None"
 ;Using VADPT for PHONE# , SSN     ,eligibility code, and Name  
 K VAPTYP,VAHOW,VAROOT,VADM,VAEL,VAPA,VATEST S DFN=REFNO1 D ADD^VADPT,DEM^VADPT,ELIG^VADPT S NAME=VADM(1),RGSSN=$P(VADM(2),U),PHONE=VAPA(8),ECODE=$P(VAEL(1),U)
 K VAPTYP,VAHOW,VAROOT,VADM,VAEL,VAPA,VATEST
 S ACTIVITY=$$ACTIVE(REFNO1)
 W !,?10,ECODE,?20,NAME1,?54,RGSSN,?65,PHONE
 GOTO LST3
EXIT D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 K ^TMP($J)
 K ACTIV1,ACTIVITY,BREF,ECODE,ECODE1,NAME,NAME1,NODE,NODE2,NODE3
 K NODE4,PHONE,PRNTCODE,REFNO,REFNO1,RGFS,RGPRNTCO,SCRATCH,RGSSN,ZTREQ,%ZIS,NODE1,POP,ZTDESC,ZTRTN
 QUIT
SETGBL()        ;SETS GLOBAL
 S ECODE=""
 K VAEL S DFN=REFNO D ELIG^VADPT S ECODE=$P(VAEL(1),U)
 IF ECODE="" S ECODE="None"
 S ACTIVITY=$$ACTIVE(REFNO)
 S ^TMP($J,ACTIVITY,ECODE,NAME)=REFNO
 QUIT 1
GETECODE()      ;
 S PRNTCODE="None"
 IF $D(^DIC(8,ECODE1,0)) S NODE4=^DIC(8,ECODE1,0),PRNTCODE=$P(NODE4,"^",1)
 W !,PRNTCODE S RGFS=0
 QUIT 1
LTD(DFN)        ;
 ;FIND LAST TREATMENT DATE
 ;INPUT: DFN
 ;OUTPUT: LTD LAST TREATMENT DATE
 ;
 ;
 N LTD,X
 ;
 ; - NEED A PATIENT
 I '$G(DFN) S LTD=0 G LTDQ
 ;
 ; - IF CURRENT INPATIENT, SET LTD = TODAY AND QUIT
 ;Current admission movement from ADM^VAPDT2
 K VADMVT,VAINDT D ADM^VADPT2 I $L(VADMVT) S LTD=DT K VADMVT,VAERR,VAINDT G LTDQ
 K VADMVT,VAERR,VAINDT
 ;
 ; - GET THE LAST DISCHARGE DATE
 S LTD=+$O(^DGPM("ATID3",DFN,"")) S:LTD LTD=9999999.9999999-LTD\1 S:LTD>DT LTD=DT
 ;
 ; - GET THE LAST REGISTRATION DATE AND COMPARE IT TO LTD
 K VAROOT,VARP,^UTILITY("VARP",$J) S VARP("F")=2000101 D REG^VADPT I $D(^UTILITY("VARP",$J,1,"I")) S X=$P(^("I"),U) I X S X=X\1 S:X>LTD LTD=X
 K ^UTILITY("VARP",$J),VARP,VAERR
 ;
 ; - GET THE LAST STOP AND COMPARE TO LTD
 ; Look at Outpatient Encounter, ^SDV is going away
 ; Use an API instead of ordering through global
 N OPIEN S OPIEN=$$GETLAST^SDOE(DFN,2000101,"C")
 I $G(^SCE(+OPIEN,0)) S LTD=$P(^SCE(OPIEN,0),"^",1)\1
 ;
LTDQ ;
 Q $S(LTD:LTD,1:0)
 ;
ACTIVE(DFN) ;
 N LTD,TODAY,DIFF
 S LTD=$$LTD(DFN)
 Q:LTD'>0 "NO"
 Q:$L(LTD)'=7 1_"^"_LTD_"^"_"ZERO"
 S TODAY=$$NOW^XLFDT\1
 S DIFF=$$FMDIFF^XLFDT(TODAY,LTD)
 ; if difference is > 1096 days or 3 years
 I DIFF>1096 Q "NO"
 Q "YES"
HEADER ;PRINT REPORT HEADER
 I ($E(IOST,1,2)="C-")&(IO=IO(0)) D
 . S DIR(0)="E"
 . D ^DIR K DIR
 Q:$D(DUOUT)!($D(DTOUT))
 ;;;W:$D(IOF) @IOF
 W @IOF,!,"MPI/PD Report of Pseudo, missing & potentially false SSNs "
 D NOW^%DTC D YX^%DTC
 W ?55,Y,! K Y
 W !,?20,"Patient activity within past 3 years = ",$G(ACTIV1)
 W !,?1,"Primary"
 W !,?1,"Elig Code"
 W !,?10,"Elig.",?20,"Name",?54,"SSN",?65,"Home Phone"
 W !,"-----------------------------------------------------------------------------"
 Q
HEAD2 ;SUB HEADER
 Q:$D(DUOUT)!($D(DTOUT))
 I RGFS=0,PRNTCODE=RGPRNTCO W !,PRNTCODE
 E  I RGFS=0 W !,PRNTCODE S RGPRNTCO=PRNTCODE
 Q
