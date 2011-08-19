IBOSCDC ;ALB/BNT - SERVICE CONNECTED DETERMINATION CHANGE REPORT;10/04/07
 ;;2.0;INTEGRATED BILLING;**384**;21-MAR-94;Build 74
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
SCR ; -- Main Entry for report.
 N IBCTY,IBPTY,IBSD,IBDFN,Y,DUOUT,DTOUT,DIC
 S IBDFN=0
 S IBCTY=$$CTYPE() Q:IBCTY=U  I IBCTY="S" S IBCTY="Y"
 S IBSD=$$ATIME() Q:IBSD=U
PTP S IBPTY=$$PTYPE() Q:IBPTY=U
 I IBPTY="P" D
 . S DIC="^DPT(",DIC(0)="AEMNQ",DIC("A")="Select Patient: " D ^DIC
 . I (Y=-1)!$D(DUOUT)!$D(DTOUT) G PTP
 . S IBDFN=$P(Y,U)
 D DEV("RUN^IBOSCDC","      SERVICE CONNECTED STATUS CHANGES",IBDFN)
 Q
 ;
 ;Process Report
RUN ;
 S REF=$NA(^TMP($J,"IBSCDC"))
 K @REF
 U IO
 D REPORT
 D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@" K @REF,REF
 I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 Q
 ;
REPORT ;
 N IBSCDFN,IBRXNUM,IBRXFIL,PTNM,PTLN1,PTLN2,IBQUIT,IBOSCNT,IBFRST,IBOSCDC,IBRXD,IBP
 S (IBP,IBSCDFN,IBQUIT,IBOSCNT)=0,IBFRST=1
 S IBN=IBN_" for period "_$$FMTE^XLFDT(IBSD,"2P")_" - "_$$FMTE^XLFDT(DT,"2P")
 ; Write the Header
 D HDR(IBN)
 ; Get Data for specific patient
 I IBPTY="P" D  Q:IBQUIT
 . I '$$PTSRCH(IBDFN,IBSD,IBCTY,.IBOSCDC) W !,"No matching SC changes for patient "_$$PATINF^IBOSCDC1(IBDFN,30) S IBQUIT=1 Q
 . D COLLECT^IBOSCDC1(IBDFN,IBSD)
 . I '$D(@REF@(IBDFN)) W !,"No matching Prescriptions found for patient "_$$PATINF^IBOSCDC1(IBDFN,30) S IBQUIT=1 Q
 ; Get Data for all patients
 I IBPTY="A" D  Q:IBQUIT
 . D GETALLPT(IBCTY,IBSD,.IBOSCDC)
 . I '$D(IBOSCDC) W !,"No patients with SC changes found" S IBQUIT=1 Q
 ; Check all patients for Pharmacy data
 F  S IBSCDFN=$O(IBOSCDC(IBSCDFN)) Q:IBSCDFN=""  D  Q:IBQUIT
 . D COLLECT^IBOSCDC1(IBSCDFN,IBSD)
 . I '$D(@REF@(IBSCDFN)) Q
 . ;Get Patient Name and last 4 SSN
 . S PTNM=$$PATINF^IBOSCDC1(IBSCDFN,23)
 . ;Get first line of Patient data
 . S PTLN1=$$GETENRL($P($G(IBOSCDC(IBSCDFN)),U,1))
 . ; Get second line of patient data
 . S PTLN2=$$GETENRL($P($G(IBOSCDC(IBSCDFN)),U,2))
 . I 'IBFRST W !!
 . ;Write the first Patient line
 . D WPTLINE(PTNM,$P(PTLN1,U),$P(PTLN1,U,2),$P(PTLN1,U,3),$P(PTLN1,U,4),$P(PTLN1,U,5)) Q:IBQUIT
 . ;Write the second Patient line
 . D WPTLINE("",$P(PTLN2,U),$P(PTLN2,U,2),$P(PTLN2,U,3),$P(PTLN2,U,4),$P(PTLN2,U,5))
 . S (IBFRST)=0
 . F  S IBOSCNT=$O(@REF@(IBSCDFN,IBOSCNT)) Q:IBOSCNT=""  D
 . . S IBRXD=@REF@(IBSCDFN,IBOSCNT)
 . . ;Write the RX data
 . . D WRXLINE($P(IBRXD,U),$P(IBRXD,U,2),$P(IBRXD,U,3),$P(IBRXD,U,4),$P(IBRXD,U,5),$P(IBRXD,U,6),$P(IBRXD,U,7))
 . . ;Increment counter
 . . S IBFRST=1
 I 'IBFRST W "No data available for report"
 Q
 ;
 ;Get Service Connected Change type value
 ;Returns:
 ;(S = SC - NSC, N = NCS - SC, B = Both)
CTYPE() ;
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="S^S:SC to NSC;N:NSC to SC;B:Both"
 S DIR("A")="Select Change Type or (B)oth",DIR("B")="B"
 D ^DIR
 Q Y
 ;
 ;Get Activity Timeframe (Start date) for search
 ;Returns:
 ;Start date in FileMan format
ATIME() ;
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 W !
 S DIR(0)="N^1:999"
 S DIR("A")="     Select Activity Timeframe Days",DIR("B")=30
 D ^DIR
 Q $$FMADD^XLFDT(DT\1,-$G(Y))
 ;
 ;Get Patient Type value
 ;Returns (P = Patient, A = All)
PTYPE() ;
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="S^P:ONE PATIENT;A:ALL"
 S DIR("A")="Display One (P)atient or (A)ll",DIR("B")="A"
 D ^DIR
 Q Y
 ;
 ;Get All patients with SC Change
 ;Input: 
 ;IBSCDIR = Service Connected change direction
 ;         (Y = SC to NSC, N = NSC to SC, B = Both)
 ;IBSD = Start search date
 ;IBSCARR = Return array passed by ref
 ;Returns:
 ;^TMP(IBSCARR,$J,0)=Number of records found
 ;The first record found is in the 1 node
 ;^TMP(IBSCARR,$J,IBDFN,1)=File 27.11 IEN
 ;The last record found is in the 2 node
 ;^TMP(IBSCARR,$J,IBDFN,2)=File 27.11 IEN
GETALLPT(IBSCDIR,IBSD,IBSCARR) ;
 N IBDFN,IBCNT,IBDGEN
 ; Default start date -30 days
 I IBSD="" S IBSD=$$FMADD^XLFDT(DT\1,-30)
 S (IBDFN,IBCNT)=0
 F  S IBDFN=$O(^DGEN(27.11,"C",IBDFN)) Q:IBDFN=""  D
 . Q:'$D(^DPT(IBDFN,0))
 . I $$PTSRCH(IBDFN,IBSD,IBSCDIR,.IBDGEN) D
 . . S IBCNT=IBCNT+1,IBSCARR(0)=IBCNT
 . . S IBSCARR(IBDFN)=IBDGEN(IBDFN)
 Q
 ;
 ;This function searches for an SC change in Patient Enrollment for a patient
 ;during a specified date range.
 ;Input:
 ;IBDFN = Patient DFN
 ;IBSD  = Start date to begin search
 ;IBSCDIR = Service Connected change direction
 ;          (Y = SC to NSC, N = NSC to SC, B = Both)
 ;IBSCARR = Return array passed by ref
 ;Returns:
 ;IBSCARR(DFN)=DGEN1^DGEN2
 ;WHERE:
 ; DGEN1 = The IEN of first record
 ; DGEN2 = The IEN of second record where a SC change occurred.
PTSRCH(IBDFN,IBSD,IBSCDIR,IBSCARR) ;
 Q:IBDFN="" 0
 N DGENIEN,IBSC,IBSCHNG,SCDIR,EFDT,IBDGEN1
 S (DGENIEN,IBSCHNG)=0,(IBDGEN1,IBSC)=""
 F  S DGENIEN=$O(^DGEN(27.11,"C",IBDFN,DGENIEN)) Q:DGENIEN=""  D 
 . I $D(^DGEN(27.11,DGENIEN,"E")) D
 . . ; Get SERVICE CONNECTED field
 . . S IBSC=$P(^DGEN(27.11,DGENIEN,"E"),U,2) Q:IBSC=""
 . . ; Get EFFECTIVE DATE field
 . . S EFDT=$P(^DGEN(27.11,DGENIEN,0),U,8) Q:EFDT=""
 . . ; Is EFFECTIVE DATE prior to search date? If yes, quit.
 . . I EFDT<IBSD Q
 . . ; First matching SC found
 . . I IBDGEN1="" D  Q
 . . . I (IBSC=IBSCDIR)!(IBSCDIR="B") S IBDGEN1=IBSC S IBSCARR(IBDFN)=DGENIEN Q
 . . ; Matching SC change found. Overwrite previous with latest effective date.
 . . I IBDGEN1'="",IBSC'=IBDGEN1 D  Q
 . . . S $P(IBSCARR(IBDFN),U,2)=DGENIEN
 . . . S IBSCHNG=1
 ; If second match not found, kill the first since no change.
 I 'IBSCHNG K IBSCARR Q 0
 Q 1
 ;
 ;//TODO - Create IA for 27.11
 ;Get Patient Enrollment data
 ;Input: DGENINE = IEN of entry in file 27.11
 ;Returns: EFFECTIVE DATE (.08)^SERVICE CONNECTED (50.02)^ELIGIBILITY CODE (50.01)^SC % (50.03)^ENROLLMENT PRIORITY (.07)
GETENRL(DGENIEN) ;
 N FILE,FIELDS,RETV,X
 Q:'$D(^DGEN(27.11,DGENIEN)) 0
 I $E($L(DGENIEN)+1)'="," S DGENIEN=DGENIEN_","
 S RETV=""
 S FILE=27.11,FIELDS=".08;50.01:50.03;.07"
 D GETS^DIQ(FILE,DGENIEN_",",FIELDS,"IE","X")
 I $D(X) D
 . S RETV=$$FMTE^XLFDT($G(X(27.11,DGENIEN,.08,"I")),"2D")_U_$G(X(27.11,DGENIEN,50.02,"I"))_U_$E($G(X(27.11,DGENIEN,50.01,"E")),1,17)_U_$G(X(27.11,DGENIEN,50.03,"E"))_U_$G(X(27.11,DGENIEN,.07,"E"))
 Q RETV
 ;
 ;Print the report Header
 ;Input: IBX = Report Name
HDR(IBX) ;
 ; IBP is assumed for page #
 Q:IBQUIT
 N DIR,X,Y
 I $E(IOST,1,2)="C-",IBP S DIR(0)="E" D ^DIR K DIR I $D(DIRUT)!($D(DUOUT)) S IBQUIT=1 K DIRUT,DTOUT,DUOUT Q
 S IBP=IBP+1
 W @IOF
 F X=1:1:IOM W "="
 W IBX,?IOM-10,"Page: ",IBP,!
 F X=1:1:IOM W "="
 W !,"Patient",?24,"Effective",?35,"Service",?46,"Eligibility",?65,"SC",?69,"Enrollment",!
 W ?24,"Date",?35,"connected",?46,"code",?65,"%%",?69,"priority",!!
 W ?2,"RX#",?10,"Fill#",?16,"DOS",?25,"Bill#/Status",?39,"ECME#",?47,"Copay/Insurance",?66,"Total Charge",!
 F X=1:1:IOM W "-"
 Q
 ;
 ;Write Patient Line
WPTLINE(PT,EFDT,SC,ELIGCODE,SCPERCNT,ENRLPRIO) ;
 I $Y>(IOSL-4) D HDR(IBN) Q:IBQUIT
 W !,PT,?24,EFDT,?35,SC,?46,ELIGCODE,?65,SCPERCNT,?69,ENRLPRIO
 Q
 ;
 ;Write Prescription Line
WRXLINE(RX,FILL,DOS,BILL,ECME,COPAYINS,AMNT) ;
 I $Y>(IOSL-4) D HDR(IBN) Q:IBQUIT
 W !,?2,RX,?10,FILL,?16,$$FMTE^XLFDT(DOS,"2D"),?25,BILL,?39,ECME,?47,COPAYINS,?66,AMNT
 Q
 ;
 ;Device Selection
 ;Input: IBR = Routine
 ;       IBN = Task name (only used if tasked)
 ;       IBDFN = Patient DFN for single patient, if exists.
DEV(IBR,IBN,IBDFN) ;
 N %ZIS,ZTSK,ZTSAVE,POP,ZTRTN,ZTDESC
 S %ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . S ZTRTN=IBR,ZTDESC=IBN,ZTSAVE("IB*")="",ZTSAVE("IBPT(")=""
 . D ^%ZTLOAD,HOME^%ZIS K IO("Q") W !,"QUEUED TASK #",ZTSK
 U IO
 D @IBR
 Q
