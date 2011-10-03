IBJDIPR ;ALB/HMC - PERCENTAGE OF PATIENTS PREREGISTERED REPORT ;10-MAY-2004
 ;;2.0;INTEGRATED BILLING;**272,305**;21-MAR-1994
 ;
EN ; - Option entry point.
 ;
 D ENQ1
 W !!,"This report provides number of patients treated, the number of"
 W !,"patients pre-registered, % of patients pre-registered, number of"
 W !,"patients pre-registered past the pre-registration time frame,"
 W !,"number of patients never pre-registered, the clinic exclusions,"
 W !,"and the eligibility exclusions.",!!
 ;
DATE D DATE^IBOUTL I IBBDT=""!(IBEDT="") G ENQ
 ;
 ;
TIME ;Pre-Registration time frame, default is 180 days
 ;
 S DIR(0)="N^^I X'>0 K X"
 S DIR("A")="Pre-Registration time frame (days)" W !
 S DIR("B")=180
 S DIR("?")="^D THLP^IBJDIPR"
 D ^DIR
 S IBPRF=Y
 I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) G ENQ
 ;
 K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 S DIR(0)="Y",DIR("B")="NO",DIR("?")="^D EHLP^IBJDIPR"
 S DIR("A")="Detailed list of Exclusions (Y/N)"
 D ^DIR
 S IBEXC=+Y
 I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) G ENQ
 K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 ;
 W !!,"This report only requires an 80 column printer."
 W !!,"Note: This report may take a while to run."
 W !!,"You should queue this report to run after normal business hours.",!
 ;
 ; - Select a device.
 S %ZIS="QM" D ^%ZIS G:POP ENQ
 I $D(IO("Q")) D  G ENQ
 .S ZTRTN="DQ^IBJDIPR",ZTDESC="IB - PERCENTAGE OF PATIENTS PREREGISTERED"
 .S ZTSAVE("IB*")=""
 .D ^%ZTLOAD
 .W !!,$S($D(ZTSK):"This job has been queued. The task number is "_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 U IO
 ;
DQ ; - Tasked entry point.
 ;
 N IBQUERY,IBQUERY1,DGNAM
 K IB,^TMP("IBJDIPR",$J),^TMP("IBJDIPR1",$J)
 ;
 ;Temporary global IBJDIPR contains outpatients found for date range in the outpatient encounter file"
 ;Temporary global IBJDIPR1 contains the clinic exclusions found in the MAS parameter file"
 ;
 S (IBQ,DGPREC,DGPREE)=0
 F I="TOT","PRE","PAST","NEVR" S IB(I)=0
 ;
 ;Build exclusion temporary file from MAS parameter file,
 ; ^DG(43 - dbia 4242
 ;
 ;Get clinic exclusions and clinic name from ^SC (Hospital location file)
 ;dbia 401
 S X="" F  S X=$O(^DG(43,1,"DGPREC","B",X)) Q:X=""  D
 . S DGNAM=$P($G(^SC(X,0)),U,1) I DGNAM="" Q
 . S ^TMP("IBJDIPR1",$J,"DGPREC",X)=""
 . S ^TMP("IBJDIPR1",$J,"DGPRECA",DGNAM_U_X)=X ;index sorted by name
 . S DGPREC=DGPREC+1
 ;
 ;Get eligibility exclusions and eligibility name from ^DIC(8 dbia 427
 ;
 S X="" F  S X=$O(^DG(43,1,"DGPREE","B",X)) Q:X=""  D
 . S DGNAM=$P($G(^DIC(8,X,0)),U,1) I DGNAM="" Q
 . S ^TMP("IBJDIPR1",$J,"DGPREE",X)=""
 . S ^TMP("IBJDIPR1",$J,"DGPREEA",DGNAM_U_X)=X ;index sorted by name
 . S DGPREE=DGPREE+1
 ;
 ; - Find outpatients treated within the user-specified date range.
 D OUTPT("",IBBDT,IBEDT,"S:IBQ SDSTOP=1 I 'IBQ,$$ENCHK^IBJDI5(Y0) D ENC^IBJDIPR(Y0)","Percentage of Patients Pre-registered",.IBQ,"IBJDIPR",.IBQUERY)
 D CLOSE^IBSDU(.IBQUERY),CLOSE^IBSDU(.IBQUERY1) I IBQ G ENQ
 ;
 ;Find pre-registered patients
 ;Use file 41.41 (^DGS), Pre-registration audit file
 ;dbia 4425
 ;
 S DFN=""
 F  S DFN=$O(^TMP("IBJDIPR",$J,DFN)) Q:DFN=""  D
 . S TRDAT=^TMP("IBJDIPR",$J,DFN) ;Get treatment date
 . S IB("TOT")=IB("TOT")+1 ;Total unique patients treated
 . S PRDAT=TRDAT+.0000001
 . S PRDAT=$O(^DGS(41.41,"ADC",DFN,PRDAT),-1) ;Most recent pre-reg date
 . I PRDAT="" S IB("NEVR")=IB("NEVR")+1 Q  ;never pre-registered
 . I PRDAT<$$FMADD^XLFDT(TRDAT,-IBPRF) S IB("PAST")=IB("PAST")+1 Q  ;past time frame
 . S IB("PRE")=IB("PRE")+1 ;pre-registered
 ;
 ; - Print the reports.
 ; QUIT if this is a electronic transmission to the ARC -IB patch 305
 Q:$G(IBARFLAG)
 S (IBQ,IBPAG)=0 D NOW^%DTC S IBRUN=$$DAT2^IBOUTL(%)
 I 'IBQ D SUM,PAUSE
ENQ K ^TMP("IBJDIPR",$J),^TMP("IBJDIPR1",$J)
 I $D(ZTQUEUED) S ZTREQ="@" G ENQ1
 ;
 D ^%ZISC
ENQ1 K IB,IBQ,IBBDT,IBEDT,IBD,IBPAG,IBRUN,IBOED,IBPRF
 K DFN,POP,I,X,X1,X2,Y,%,%ZIS,ZTDESC,ZTRTN,ZTSAVE,ZTREQ,ZTQUEUED
 K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 K DGPREC,DGPREE,PRDAT,TRDAT,IBEXC,DGEE,DGEC,PCENT,TAB,DGNAM
 Q
 ;
OUTPT(DFN,IBBDT,IBEDT,IBCBK,IBMSG,IBQ,IBSUBSCR,IBQUERY,IBDIR) ;
 ; Input:   DFN = IEN of patient if using PATIENT/DATE index, otherwise,
 ;                if null or 0, DATE/TIME index will be used
 ;        IBCBK = The MUMPS code to execute when valid enctr found
 ;        IBBDT/IBEDT = The start/end dates
 ;        IBMSG = The text to send to STOP PROCESSING CALL (if null, no
 ;                call made)
 ;          IBQ = Flag that says whether or not the process was stopped
 ;                by user
 ;      IBQUERY = The # of the QUERY OBJECT to be used to extract outpt
 ;                visits
 ;        IBDIR = Null to look forward, 'B' to look backward thru file
 ;
 N IBVAL,IBFILTER
 S IBVAL("BDT")=IBBDT,IBVAL("EDT")=IBEDT_".99" S:$G(DFN) IBVAL("DFN")=DFN
 ;
 ; - Look at parent encounters, completely checked out, check user
 ;   requested to quit, process each pt only once if IBSUBSCR'=null
 S IBFILTER=""
 S IBCBK="I '$P(Y0,U,6),$P(Y0,U,7),$S((Y#100)'=0:1,$G(IBMSG)="""":1,1:'$$STOP^IBJDI21(.IBQ,IBMSG))"_" "_IBCBK
 S IBDIR=$S($G(IBDIR)="":"",1:"BACKWARD")
 ;
 ;ibsdu will use ^SD(409.1), Standard encounter query, to process
 ;file 409.68 (^SCE) - dbia402 for outpatient encounter data.
 ;
 D SCAN^IBSDU($S($G(DFN):"PATIENT/DATE",1:"DATE/TIME"),.IBVAL,IBFILTER,IBCBK,0,.IBQUERY,IBDIR) K ^TMP("DIERR",$J)
 Q
 ;
ENC(IBOED) ; - Encounter extract.
 ; Input:    IBOED = Data from outpatient encounter file, ^SCE.
 ;
 S DFN=+$P(IBOED,U,2) I 'DFN Q
 ;Check exclusions
 I $P(IBOED,U,4)]"",$D(^TMP("IBJDIPR1",$J,"DGPREC",$P(IBOED,U,4))) Q  ;Clinic exclusion
 I $P(IBOED,U,13)]"",$D(^TMP("IBJDIPR1",$J,"DGPREE",$P(IBOED,U,13))) Q  ;Eligibility exclusion
 D PROC(DFN,IBOED) ; Process patient.
 Q
 ;
PROC(DFN,IBOED) ; - Process each specific patient.
 ; Input:     DFN = Pointer to the patient in file #2
 ;          IBOED = Data from outpatient encounter file, ^SCE.
 ;
 ; Pre-set variables IB array, IBBDT, IBEDT are required.
 ;
 I $$TESTP^IBJDI1(DFN) Q  ;     Test patient.
 D ELIG^VADPT G:'VAEL(4) PRCQ ; Patient is not a vet.
 ;
 ; - Set patient index
 S ^TMP("IBJDIPR",$J,DFN)=$P(IBOED,U,1)
 ;
PRCQ K VA,VAERR,VAEL
 Q
 ;
SUM ; - Print the summary report.
 D HEAD Q:IBQ
 W !!?15,"Patients pre-registered from ",$$DAT1^IBOUTL(IBBDT)," - ",$$DAT1^IBOUTL(IBEDT)
 W !!?17,"Pre-registration time frame: ",$J(IBPRF,5)," days"
 W !!?24,"Run Date: ",IBRUN,!?10,$$DASH(55),!!
 ;
 W ?35,"*Number of Unique Patients Treated: ",$J(IB("TOT"),5)
 W !?1,"Unique Outpatients Pre-registered within pre-registration time frame: ",$J(IB("PRE"),5)
 S PCENT=0 I IB("TOT") S PCENT=(IB("PRE")/IB("TOT"))*100
 W !?47,"Percent Pre-registered: ",$J(PCENT,5,2),"%"
 W !!?3,"Unique Outpatients Pre-registered past pre-registration time frame: ",$J(IB("PAST"),5)
 W !?30,"Unique Outpatients never Pre-registered: ",$J(IB("NEVR"),5)
 W !!?8,"*Counts may not include all patients because of exclusions."
 W !!?37,"Number of Eligibility Exclusions: ",$J(DGPREE,5)
 W !!?42,"Number of Clinic Exclusions: ",$J(DGPREC,5)
 I 'IBEXC Q
 I DGPREE D
 .S DGEE=1
 .D PAUSE Q:IBQ  D HEAD Q:IBQ
 .S X="" F I=1:1 S X=$O(^TMP("IBJDIPR1",$J,"DGPREEA",X)) Q:X=""  D  Q:IBQ
 ..I $Y>(IOSL-4) D PAUSE Q:IBQ  D HEAD Q:IBQ
 ..S TAB=$S((I#2):10,1:45)
 ..W ?TAB,$E($P(X,U,1),1,30) W:'(I#2) !
 I DGPREC D
 .S DGEC=1,DGEE=0
 .S X="" F I=1:1 S X=$O(^TMP("IBJDIPR1",$J,"DGPRECA",X)) Q:X=""  D  Q:IBQ
 ..I I=1 D  Q:IBQ
 ...I ($Y+4)>(IOSL-4) D PAUSE Q:IBQ  D HEAD Q
 ...W !!?10,"Clinic Exclusions",!?9,$$DASH(19),!
 ..I $Y>(IOSL-4) D PAUSE Q:IBQ  D HEAD Q:IBQ
 ..S TAB=$S((I#2):10,1:45)
 ..W ?TAB,$E($P(X,U,1),1,30) W:'(I#2) !
 Q
 ;
HEAD ; - Report Header
 ;
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF,*13
 S IBPAG=IBPAG+1
 W !?21,"PERCENTAGE OF PATIENTS PRE-REGISTERED",?71,"Page: ",IBPAG
 I IBPAG=1 W !!?33,"SUMMARY REPORT" Q
 W !!?24,"Run Date: ",IBRUN,!?10,$$DASH(55),!!
 W !?10,"Listing of all Exclusions: ",!
 I $G(DGEE) W !!?10,"Eligibility Exclusions",!?9,$$DASH(24),!
 I $G(DGEC) W !!?10,"Clinic Exclusions",!?9,$$DASH(19),!
 S IBQ=$$STOP^IBOUTL("Percentage of Patients Pre-registered")
 Q
 ;
DASH(X) ; - Return a dashed line.
 Q $TR($J("",X)," ","=")
 ;
PAUSE ; - Page break.
 I $E(IOST,1,2)'="C-" Q
 N DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 S DIR(0)="E" D ^DIR I $D(DIRUT)!($D(DUOUT)) S IBQ=1
 Q
 ;
THLP ; - 'Pre-Registration time frame (days)' prompt
 ;
 W !!,"Number of days to search for pre-registered patients."
 W !,"Number of days must be greater that zero."
 W !,"Select '<CR>' to accept the default 180 days."
 W !?11,"'^' to quit."
 Q
 ;
EHLP ; - 'Detailed list of Exclusions' prompt
 ;
 W !!,"Select '<CR>' to print only the number of eligibility and clinic exclusions."
 W !!?11,"'Y' to print list of all eligibility and clinic exclusions."
 W !?11,"'^' to quit."
 Q
IBAR(IBBDT,IBEDT) ;Entry point for Vista IB AR data to ARC
 ;patch 305 - called by IBRFN4
 N IBPRF,IBEXC,IBARFLAG,IB,IBPERC,IBARDATA
 S IBPRF=180,IBEXC=0,IBARFLAG=1
 D DQ
 I 'IB("TOT") S IBPERC=0 G IBARD
 S IBPERC=IB("PRE")/IB("TOT")*100,IBPERC=$FN(IBPERC,"",2)
IBARD S IBARDATA=IB("TOT")_U_IB("PRE")_U_IBPERC_U_IB("PAST")_U_IB("NEVR")
 Q IBARDATA
