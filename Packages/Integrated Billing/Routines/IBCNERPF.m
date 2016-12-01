IBCNERPF ;BP/YMG - IBCNE USER INTERFACE EIV INSURANCE UPDATE REPORT ;16-SEP-2009
 ;;2.0;INTEGRATED BILLING;**416,528,549**;16-SEP-09;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; IB*2.0*549 Change value of IBCNESPC("PYR",ien)
 ;            Add IBCNESPC("PYR",ien,coien)
 ;                IBCNESPC("INSCO"))
 ; IB*2.0*549 Sort by payer name
 ; Variables:
 ;   IBCNERTN = "IBCNERPF" (current routine name for queueing the 
 ;                          COMPILE process)
 ;   IBCNESPC("BEGDT") = start date for date range
 ;   IBCNESPC("ENDDT") = end date for date range
 ;   IBCNESPC("INSCO") = "A" (All ins. cos.) OR "S" (Selected ins. cos.)
 ;   IBCNESPC("PYR",ien) - payer iens for report, if IBCNESPC("PYR")="A", then include all
 ;                       = (1) ^ (2)
 ;     (1) Display insurance company detail - 0 = No / 1 = Yes
 ;     (2) Display all or some insurance companies - A = All companies/
 ;                                                   S = Specified companies
 ;   IBCNESPC("PYR",ien,coien) - payer iens and company ien for report
 ;                             = Count for insurance company
 ;   IBCNESPC("PAT",ien) = patient iens for report, if IBCNESPC("PAT")="A", then include all
 ;   IBCNESPC("TYPE") = report type: "S" - summary, "D" - detailed
 ;   IBOUT = "R" for Report format or "E" for Excel format
 ;
 Q
EN ; entry point
 N IBCNERTN,IBCNESPC,IBOUT,STOP
 ;
 S STOP=0,IBCNERTN="IBCNERPF"
 W @IOF
 ; IB*2.0*549 - Change report name to eIV Auto Update Report
 W !,"eIV Auto Update Report"
 ; Prompts for eIV Update Report
 ; Report Type - Summary or Detailed
P10 D TYPE I STOP G EXIT
 ; Payer Selection parameter
P20 D PAYER I STOP G:$$STOP^IBCNERP1 EXIT G P10
 ; Date Range parameters
P30 D DTRANGE I STOP G:$$STOP^IBCNERP1 EXIT G P20
 ; Patient Selection parameter
P40 D PATIENT I STOP G:$$STOP^IBCNERP1 EXIT G P30
 ; IB*2.0*549 Set flag for all/selected insurance companies
P50 D INSCO
 ; IB*2.0*549 Sort is by payer name, so call to choose sort order not needed
 ; Select the output type
P60 S IBOUT=$$OUT^IBCNERP1 I STOP G:$$STOP^IBCNERP1 EXIT G P50
 ; Select the output device
P100 D DEVICE^IBCNERP1(IBCNERTN,.IBCNESPC,IBOUT) I STOP G:$$STOP^IBCNERP1 EXIT G P50
 ;
EXIT ;
 Q
 ;
PAYER ;
 ; IB*2.0*549 Add PIEN for payer IEN
 N DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,PIEN,X,Y
 W !
 S DIR("A")="Run for (A)ll Payers or (S)elected Payers: "
 S DIR("A",1)="PAYER SELECTION:"
 S DIR(0)="SA^A:All;S:Selected",DIR("B")="A"
 D ^DIR
 I $D(DIRUT) S STOP=1 Q
 I Y="A" S IBCNESPC("PYR")="A" Q  ; "All Payers" selected
 S DIC(0)="ABEQ"
 ; IB*2.0*549 Change prompt from "Select Insurance Company" to "Select Payer"
 W !
 S DIC("A")="Select Payer: "
 ; Do not allow selection of '~NO PAYER' and non-eIV payers
 ; IB*2.0*549 Only include payers with eIV Auto Update flag = Yes
 S DIC("S")="I ($P(^(0),U,1)'=""~NO PAYER"") I $$AUTOUPDT^IBCNERPF($P($G(Y),U,1))"
 S DIC="^IBE(365.12,"
 ;
PAYER1 ;
 D ^DIC
 I $D(DUOUT)!$D(DTOUT)!(Y=-1) S STOP=1 K IBCNESPC("PYR") Q
 ; IB*2.0*549 Get PIEN value
 S PIEN=$P(Y,U,1) K IBCNESPC("PYR",PIEN) S IBCNESPC("PYR",PIEN)=""
 ; IB*2.0*549 Get corresponding insurance companies
 D GETCOMPS(PIEN,.IBCNESPC)
 ; IB*2.0*549 Change Select Another to Select Another Payer 
 W !
 I $$ANOTHER("Payer") W ! G PAYER1
 Q
 ;
INSCO ; IB*2.0*549 Setup insurance company flag
 N PIEN,STOP
 S STOP=0
 I '$D(IBCNESPC("PYR")) D
 . K IBCNESPC("INSCO")
 E  D
 . I $G(IBCNESPC("PYR"))="A" D
 . . S IBCNESPC("INSCO")="A"
 . E  D
 . . S PIEN=""
 . . F  S PIEN=$O(IBCNESPC("PYR",PIEN)) Q:PIEN=""  D  Q:STOP
 . . . I $D(IBCNESPC("PYR",PIEN))\10 S IBCNESPC("INSCO")="S",STOP=1 Q
 . . S:'STOP IBCNESPC("INSCO")="A"
 Q
 ;
AUTOUPDT(PIEN) ; Determine if the Auto update flag for payer = Yes
 ; Input:   PIEN        - IEN of the Payer (file 365.12)
 ; Returns  1 - Auto update flag is set to 'Y', 0 otherwise
 ; IB*2.0*549 Only include payers with eIV Auto Update flag = Yes
 N AUTOUPDT,IENS,MULT
 S MULT=$$PYRAPP^IBCNEUT5("IIV",PIEN)
 I MULT D
 . S IENS=MULT_","_PIEN_","
 . S AUTOUPDT=$$GET1^DIQ(365.121,IENS,".07","I")
 E  S AUTOUPDT=0
 Q AUTOUPDT
 ;
GETCOMPS(PIEN,IBCNESPC) ; Get companies linked to payer
 ; IB*2.0*549 Get associated insurance companies 
 ; IB*2.0*549 If user wants to display insurance companies, prompt only 
 ;            for those linked to payer
 ; IB*2.0*549 Allow the user to select none, one, or multiple insurance 
 ;            companies associated with a given payer
 ;
 ; IB*2.0*549 Add to IBCNESPC documentation
 ; Input
 ;  PIEN     - Payer ID
 ;  IBCNESPC - Array holding payer id and related insurance companies
 ; Output
 ;  IBCNESPC - Array holding payer id and related insurance companies
 ;  IBCNESPC("PYR",PIEN) = (1) ^ (2)
 ;    (1) Display insurance company detail - 0 = No / 1 = Yes
 ;    (2) Display all or some insurance companies - A = All companies/ S = Specified companies
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,IBCNS,X,Y
 ; IB*2.0*549 Query to display associated insurance companies
 W !
 S DIR("A")="Do you want to display insurance company detail"
 S DIR("B")="NO"
 S DIR(0)="Y" D ^DIR
 Q:$D(DIRUT)
 ; IB*2.0*549 Display or do not display company detail
 S IBCNESPC("PYR",PIEN)=Y
 Q:'Y  ; IB*2.0*549 Do not display company detail
 ;
 W !
 K DIR
 S DIR("A")="Run for (A)ll Insurance Companies or Selected Insurance Companies: "
 S DIR("B")="A"
 S DIR(0)="SA^A:All;S:Selected" D ^DIR
 Q:$D(DIRUT)
 ; IB*2.0*549 Display all or specified companies
 S $P(IBCNESPC("PYR",PIEN),U,2)=Y
 Q:Y="A"  ; IB*2.0*549 Run for all companies
 ; IB*2.0*549 - Replaced dictionary look-up of Insurance Companies with
 ;                           call to Insurance Company look-up listman template
 K ^TMP("IBCNILKA",$J)
 D EN^IBCNILK(2,PIEN,4)
 I $D(^TMP("IBCNILKA",$J)) D
 .S IBCNS=""
 .F  S IBCNS=$O(^TMP("IBCNILKA",$J,IBCNS)) Q:IBCNS=""  D
 ..S IBCNESPC("PYR",PIEN,IBCNS)=""
 .K ^TMP("IBCNILKA",$J)
 Q
 ;
DTRANGE ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="D^::EX",DIR("B")="Today"
 S DIR("A")="Earliest Date Received"
 S DIR("A",1)="RESPONSE RECEIVED DATE RANGE SELECTION:"
 D ^DIR I $D(DIRUT) S STOP=1 Q
 S IBCNESPC("BEGDT")=Y
 ; End date
DTRANGE1 ;
 K DIR("A") S DIR("A")="  Latest Date Received"
 D ^DIR I $D(DIRUT) S STOP=1 Q
 I Y<IBCNESPC("BEGDT") W !,"     Latest Date must not precede the Earliest Date." G DTRANGE1
 S IBCNESPC("ENDDT")=Y
 Q
 ;
PATIENT ;
 N DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ; summary report is always run for all patients
 I $G(IBCNESPC("TYPE"))="S" S IBCNESPC("PAT")="A" Q
 W !
 S DIR("A")="Run for (A)ll Patients or (S)elected Patients: "
 S DIR("A",1)="PATIENT SELECTION:"
 S DIR(0)="SA^A:All;S:Selected",DIR("B")="A"
 D ^DIR
 I $D(DIRUT) S STOP=1 Q
 I Y="A" S IBCNESPC("PAT")="A" Q  ; "All Patients" selected
 S DIC(0)="ABEQ"
 S DIC("A")="Select Patient: "
 S DIC="^DPT("
PATIENT1 ;
 D ^DIC
 I $D(DUOUT)!$D(DTOUT)!(Y=-1) S STOP=1 K IBCNESPC("PAT") Q
 S IBCNESPC("PAT",$P(Y,U,1))=""
 ; IB*2.0*549 Change Select Another to Select Another Patient
 I $$ANOTHER("Patient") G PATIENT1
 Q
 ;
ANOTHER(TYPE) ; "Select Another" prompt
 ;IB*2.0*549 Change Select Another to Select Another Patient
 ;
 ; returns 1, if response was "YES", returns 0 otherwise
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ; IB*2.0*549 Change Select Another to Select Another [Type]
 S DIR("A")="Select Another "_TYPE_"?" S DIR(0)="Y",DIR("B")="NO"
 D ^DIR I $D(DIRUT) S STOP=1
 Q Y
 ;
TYPE ;
 ;IB*2.0*549 Sort by payer name (Delete SORT tag)
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^S:Summary;D:Detailed"
 S DIR("A")="Run a (S)ummary or (D)etailed Report: "
 S DIR("B")="Summary"
 D ^DIR I $D(DIRUT) S STOP=1 Q
 S IBCNESPC("TYPE")=Y
 Q
