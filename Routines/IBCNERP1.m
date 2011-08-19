IBCNERP1 ;DAOU/BHS - IBCNE USER IF eIV RESPONSE REPORT ;03-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,271,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; eIV - Insurance Verification Interface
 ;
 ; Input parameters: N/A
 ; Other relevant variables ZTSAVED for queueing:
 ;  IBCNERTN = "IBCNERP1" (current routine name for queueing the 
 ;   COMPILE process)
 ;  IBCNESPC("BEGDT")=start dt for rpt
 ;  IBCNESPC("ENDDT")=end dt for rpt
 ;  IBCNESPC("PYR")=payer ien (365.12) or "" for all payers
 ;  IBCNESPC("SORT")=1 (Payer name) OR 2 (Patient name)
 ;  IBCNESPC("PAT")=patient ien (2) or "" for all patients
 ;  IBCNESPC("TYPE")=A (All Responses) for date range OR M (Most Recent
 ;   Responses) for date range (by unique Payer/Pat pair)
 ;  IBCNESPC("TRCN")=Trace #^IEN, if non-null all other params are null
 ;  IBCNESPC("RFLAG")=Report Flag used to indicate which report is being
 ;   run.  Response Report (0), Inactive Report (1), or Ambiguous 
 ;   Report (2).
 ;  IBCNESPC("DTEXP")=Expiration date used in the inactive policy report
 ;
 ; Only call this routine at a tag
 Q
EN(IPRF) ; Main entry pt
 ; Init vars
 N STOP,IBCNERTN,POP,IBCNESPC
 S IBCNESPC("RFLAG")=$G(IPRF)
 ;
 S STOP=0
 S IBCNERTN="IBCNERP1"
 W @IOF
 W !,"eIV ",$S(IPRF=1:"Inactive Policy",IPRF=2:"Ambiguous Policy",1:"Response")," Report",!
 I $G(IPRF) D
 . W !,"Please select a date range to view ",$S(IPRF=1:"inactive",1:"ambiguous")," policy information that the eIV"
 . W !,"process turned up while attempting to discover previously unknown"
 . W !,"insurance policies. (Date range selection is based on the date that"
 . W !,"eIV receives the response from the payer.)"
 ;
 I '$G(IPRF) D
 . W !,"Insurance verification responses are received daily."
 . W !,"Please select a date range in which responses were received to view the"
 . W !,"associated response detail.  Otherwise, select a Trace # to view specific"
 . W !,"response detail."
 ;
 ; Rpt by Date Range or Trace #
R05 I '$G(IPRF) D RTYPE I STOP G:$$STOP EXIT G R05
 ; If rpt by Trace # - no other criteria is necessary
 I $G(IBCNESPC("TRCN")) G R100
 ; Date Range params
R10 D DTRANGE I STOP G:$$STOP EXIT G R05
 ; Payer Selection param
R20 D PYRSEL I STOP G:$$STOP EXIT G R10
 ; Patient Selection param
R30 D PTSEL I STOP G:$$STOP EXIT G R20
 ; Type of data to return param
R40 D TYPE I STOP G:$$STOP EXIT G R30
 ; How far back do you want the expiration date
R45 I $G(IPRF)=1 D DTEXP I STOP G:$$STOP EXIT G R40
 ; Sort by param - Payer or Patient
R50 D SORT I STOP G:$$STOP EXIT G R45
 ; Select output device
R100 D DEVICE(IBCNERTN,.IBCNESPC) I STOP G:$$STOP EXIT G:$G(IBCNESPC("TRCN"))'="" R05 G R50
 G EXIT
 ;
EXIT ; Exit pt
 Q
 ;
 ;
COMPILE(IBCNERTN,IBCNESPC) ; 
 ; Entry point called from EN^XUTMDEVQ in either direct or queued mode.
 ; Input params:
 ;  IBCNERTN = Routine name for ^TMP($J,...
 ;  IBCNESPC = Array passed by ref of the report params
 ;
 ; Init scratch globals
 K ^TMP($J,IBCNERTN),^TMP($J,IBCNERTN_"X")
 ; Compile
 I IBCNERTN="IBCNERP1" D EN^IBCNERP2(IBCNERTN,.IBCNESPC)
 I IBCNERTN="IBCNERP4" D EN^IBCNERP5(IBCNERTN,.IBCNESPC)
 I IBCNERTN="IBCNERP7" D EN^IBCNERP8(IBCNERTN,.IBCNESPC)
 I IBCNERTN="IBCNERPF" D EN^IBCNERPG(IBCNERTN,.IBCNESPC)
 ; Print
 I '$G(ZTSTOP) D
 . I IBCNERTN="IBCNERP1" D EN3^IBCNERPA(IBCNERTN,.IBCNESPC)
 . I IBCNERTN="IBCNERP4" D EN6^IBCNERPA(IBCNERTN,.IBCNESPC)
 . I IBCNERTN="IBCNERP7" D EN^IBCNERP9(IBCNERTN,.IBCNESPC)
 . I IBCNERTN="IBCNERPF" D EN^IBCNERPH(IBCNERTN,.IBCNESPC)
 ; Close device
 D ^%ZISC
 ; Kill scratch globals
 K ^TMP($J,IBCNERTN),^TMP($J,IBCNERTN_"X")
 ; Purge task record
 I $D(ZTQUEUED) S ZTREQ="@"
 ;
COMPILX ; COMPILE exit pt
 Q
 ;
STOP() ; Determine if user wants to exit out of the whole option
 ; Init vars
 N DIR,X,Y,DIRUT
 ;
 W !
 S DIR(0)="Y"
 S DIR("A")="Do you want to exit out of this option entirely"
 S DIR("B")="YES"
 S DIR("?",1)="  Enter YES to immediately exit out of this option."
 S DIR("?")="  Enter NO to return to the previous question."
 D ^DIR K DIR
 I $D(DIRUT) S (STOP,Y)=1 G STOPX
 I 'Y S STOP=0
 ;
STOPX ; STOP exit pt
 Q Y
 ;
DTRANGE ; Determine start and end dates for date range param
 ; Init vars
 N X,Y,DIRUT
 ;
 W !
 ;
 S DIR(0)="D^:-NOW:EX"
 S DIR("A")="Start DATE"
 S DIR("?",1)="   Please enter a valid date for which an eIV Response"
 S DIR("?")="   would have been received. Future dates are not allowed."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G DTRANGX
 S IBCNESPC("BEGDT")=Y
 ; End date
DTRANG1 S DIR(0)="DA^"_Y_":-NOW:EX"
 S DIR("A")="  End DATE:  "
 S DIR("?",1)="   Please enter a valid date for which an eIV Response"
 S DIR("?",2)="   would have been received.  This date must not precede"
 S DIR("?")="   the Start Date.  Future dates are not allowed."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G DTRANGX
 S IBCNESPC("ENDDT")=Y
 ;
DTRANGX ; DTRANGE exit pt
 Q
 ;
PYRSEL ; Select one payer or ALL - File #365.12
 ; Init vars
 NEW DIC,DTOUT,DUOUT,X,Y
 ;
 W !
 S DIC(0)="ABEQ"
 S DIC("A")=$$FO^IBCNEUT1("Payer or <Return> for All Payers: ",40,"R")
 ; Do not allow selection of '~NO PAYER' and non-eIV payers
 S DIC("S")="I ($P(^(0),U,1)'=""~NO PAYER""),$$PYRAPP^IBCNEUT5(""IIV"",$G(Y))'="""""
 S DIC="^IBE(365.12,"
 D ^DIC
 I $D(DUOUT)!$D(DTOUT) S STOP=1 G PYRSELX
 ; If nothing was selected (Y=-1), select ALL payers
 S IBCNESPC("PYR")=$S(Y=-1:"",1:$P(Y,U,1))
 ;
PYRSELX ; PYRSEL exit pt
 Q
 ;
PTSEL ; Select one patient or ALL - File #2
 ; Init vars
 NEW DIC,DTOUT,DUOUT,X,Y
 ; Patient lookup
 W !
 S DIC(0)="AEQM"
 S DIC("A")=$$FO^IBCNEUT1("Patient or <Return> for All Patients: ",40,"R")
 S DIC="^DPT("
 D ^DIC
 I $D(DUOUT)!$D(DTOUT) S STOP=1 G PTSELX
 ; If nothing was selected (Y=-1), select ALL patients
 S IBCNESPC("PAT")=$S(Y=-1:"",1:$P(Y,U,1))
 ;
PTSELX ; PTSEL exit pt
 Q
 ;
TYPE ; Prompt to select to display All or Most Recent Responses for
 ; Patient/Payer combos
 ; Init vars
 N DIR,X,Y,DIRUT
 ;
 S DIR(0)="S^A:All Responses;M:Most Recent Responses"
 S DIR("A")="Select the type of responses to display"
 S DIR("B")="A"
 S DIR("?",1)="  A - All responses from the payer during the date range will be"
 S DIR("?",2)="      displayed for each unique payer/patient combination."
 S DIR("?",3)="      (Default)"
 S DIR("?",4)="  M - Only the most recently received response from the payer"
 S DIR("?",5)="      during the date range will be displayed for each unique"
 S DIR("?")="      payer/patient combination."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G TYPEX
 S IBCNESPC("TYPE")=Y
 ;
TYPEX ; TYPE exit pt
 Q
 ;
DTEXP ; Prompt for oldest expiration date to pull for.
 ; Init Vars
 N Y,DIRUT,TODAY
 ;
 W !
 ;
 S DIR(0)="D^:-NOW:EX"
 S DIR("A")="Earliest Policy Expiration Date to Select From"
 S DIR("B")="T-365"
 S DIR("?",1)=" Please enter a valid date in the past. Any policy with a reported"
 S DIR("?")=" expiration date prior to this date will not be selected."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G DTEXPX
 S IBCNESPC("DTEXP")=Y
 ;
DTEXPX ; DTEXP Exit
 Q
 ;
SORT ; Prompt to allow users to sort the report by Payer(default) or 
 ;  Patient
 ; Init vars
 N DIR,X,Y,DIRUT
 ;
 S DIR(0)="S^1:Payer Name;2:Patient Name"
 S DIR("A")="Select the primary sort field"
 S DIR("B")=1
 S DIR("?",1)="  1 - Payer Name is the primary sort, Patient Name is secondary."
 S DIR("?",2)="      (Default)"
 S DIR("?")="  2 - Patient Name is the primary sort, Payer Name is secondary."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G SORTX
 S IBCNESPC("SORT")=Y
 ;
SORTX ; SORT exit pt
 Q
 ;
RTYPE ; Prompt to allow users to report by date range or Trace #
 ; Init vars
 N D,DIC,DIR,X,Y,DIRUT,DTOUT,DUOUT
 ;
 S DIR(0)="S^1:Report by Date Range;2:Report by Trace #"
 S DIR("A")="Select the type of report to generate"
 S DIR("B")=1
 S DIR("?",1)="  1 - Generate report by date range, payer range, patient range"
 S DIR("?",2)="      and All or Most Recent responses for payer/patient."
 S DIR("?",3)="      (Default)"
 S DIR("?",4)="  2 - Generate report for a specific Trace # which corresponds"
 S DIR("?")="      to an unique response."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G RTYPEX
 I Y=1 S IBCNESPC("TRCN")="" G RTYPEX
 ;
 ; Allow user to select Trace # from x-ref "C"
 W !
 S DIC(0)="AEVZSQ"
 S DIC="^IBCN(365,",D="C",DIC("A")="Enter Trace # for report: "
 S DIC("W")="N IBX S IBX=$P($G(^(0)),U,2,3) W:$P(IBX,U,1) $P($G(^DPT($P(IBX,U,1),0)),U,1) W:$P(IBX,U,2) ""  ""_$P($G(^IBE(365.12,$P(IBX,U,2),0)),U,1)"
 D IX^DIC K DIC
 I $D(DTOUT)!$D(DUOUT) S STOP=1 G RTYPEX
 I 'Y!(Y<0) S STOP=1 G RTYPEX
 S IBCNESPC("TRCN")=$P(Y(0),U,9)_"^"_$P(Y,U,1)
 ;
RTYPEX ; RTYPE exit pt
 Q
 ;
DEVICE(IBCNERTN,IBCNESPC) ; Device Handler and possible TaskManager calls
 ;
 ; Input params:
 ;  IBCNERTN = Routine name for ^TMP($J,...
 ;  IBCNESPC = Array passed by ref of the report params
 ;
 ; Init vars
 N ZTRTN,ZTDESC,ZTSAVE,POP
 ;
 I IBCNERTN="IBCNERP4"!(IBCNERTN="IBCNERPF"&($G(IBCNESPC("TYPE"))="D")) W !!!,"*** This report is 132 characters wide ***",!
 S ZTRTN="COMPILE^IBCNERP1("""_IBCNERTN_""",.IBCNESPC)"
 S ZTDESC="IBCNE eIV "_$S(IBCNERTN="IBCNERP1":"Response",IBCNERTN="IBCNERPF":"Insurance Update",1:"Payer")_" Report"
 S ZTSAVE("IBCNESPC(")=""
 S ZTSAVE("IBCNERTN")=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE)
 I POP S STOP=1
 ;
DEVICEX ; DEVICE exit pt
 Q
 ;
