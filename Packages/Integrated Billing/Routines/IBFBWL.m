IBFBWL ;ALB/PAW-IB BILLING Worklist ;30-SEP-2015
 ;;2.0;INTEGRATED BILLING;**554**;21-MAR-94;Build 81
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; -- Main entry point for IB BILLING WORKLIST
 N FILTERS,IBGRP,IBDIVS,IBWLTYP
 S IBWLTYP="B"
 I '$$FILTER(.FILTERS) Q
 S IBGRP=$P($G(FILTERS(0)),U,1)
 K XQORS,VALMEVL
 D EN^VALM("IB BILLING WORKLIST")
 Q
 ;
EN2 ; -- Main entry point for IB NVC PRECERT WORKLIST
 N FILTERS,IBGRP,IBDIVS,IBWLTYP
 S IBWLTYP="P"
 I '$$FILTER(.FILTERS) Q
 S IBGRP=$P($G(FILTERS(0)),U,1)
 K XQORS,VALMEVL
 D EN^VALM("IB NVC PRECERT WORKLIST")
 Q
 ;
INIT ; Initialize variables for IB BILLING WORKLIST
 D KILLGLB
 D GETAUT^IBFBWL1(IBGRP)
 I '$D(^TMP("IBFBWL",$J)) D  Q
 . W !!,*7,"There are no new cost recoverable invoices on file."
 . S DIR(0)="E"
 . D ^DIR
 . S VALMQUIT=1
 . D EXIT
 S IBWLTYP="B"
 D BLDWL^IBFBWL1
 Q
 ;
INIT2 ; Initialize variables for IB NVC Precert Worklist
 D KILLGLB
 D GETAUT^IBFBWL5(IBGRP)
 I '$D(^TMP("IBFBWL",$J)) D  Q
 . W !!,*7,"There are no new authorizations on file."
 . S DIR(0)="E"
 . D ^DIR
 . S VALMQUIT=1
 . D EXIT
 S IBWLTYP="P"
 D BLDWL^IBFBWL5
 Q
 ;
HDR ; Set header for IB BILLING Worklist
 N IBFST,IBIEN,IBXX,IBY
 S IBY=$P(FILTERS(0),U,1)
 I IBWLTYP="B" D
 . S VALMHDR(1)=$S(IBY=1:"Facility Revenue Review",IBY=2:"RUR SC/SA",IBY=3:"Billing")
 . S VALMHDR(1)=VALMHDR(1)_" ("_$S($P(FILTERS(0),U,4)=1:"First Party Copay",1:"Third Party")_")"
 I IBWLTYP="P" D
 . S VALMHDR(1)=$S(IBY=1:"Insurance Verification",IBY=2:"RUR Pre-certification")
 S VALMHDR(2)="Selected Division(s): "_IBDIVS
 Q
 ;
HDR2 ; Set header for IB NVC Precert Worklist
 N IBFST,IBIEN,IBXX,IBY
 S IBY=$P(FILTERS(0),U,1)
 S VALMHDR(1)=$S(IBY=1:"Insurance Verification",IBY=2:"RUR Pre-certification")
 S VALMHDR(2)="Selected Division(s): "_IBDIVS
 Q
 ;
FILTER(FILTERS) ; Set up filters
 ; Sets an array of filters to determine which entries to include in display
 ; Input:   None
 ; Output:  
 ; Returns: 0 if the user entered '^' or timed out, 1 otherwise
 ; If Billing - FILTERS(0) = fee basis group (1=Facility Revenue, 2=RUR SC/SA, 3=Billing)^ 0 (all) 1 (selected) institutions ^ 0 (all) 1 (selected) patients ^ 1(First Party Copay) 2 (Third Party)
 ; If Precert - FILTERS(0) = fee basis group (1=insurance verification, 2=RUR)^ 0 (all) 1 (selected) institutions ^ 0 (all) 1 (selected) patients
 ; FILTERS(1) = inst ien ^ inst ien ^ etc...
 ; FILTERS(2) = pat ien ^ pat ien ^ etc...
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,IBXX,X,XX,Y,VAUTD
 K FILTERS
 ;
 ; Billing Department
 I IBWLTYP="B" D
 . S DIR(0)="S",DIR("A")="Select (F)acility Revenue, (R)UR SC/SA or (B)illing"
 . S DIR("?",1)="Enter 'F' for Facility Revenue, 'R' for RUR SC/SA"
 . S DIR("?")="or 'B' to for Billing."
 . S $P(DIR(0),U,2)="F:Facility Revenue;R:RUR SC/SA;B:Billing"
 . W ! D ^DIR K DIR
 . I $G(DIRUT) Q
 . S X=$$UP^XLFSTR(X)
 . S FILTERS(0)=$S(Y="F":1,Y="R":2,Y="B":3,1:0)
 ;
 ; Pre-certification Department
 I IBWLTYP="P" D
 . S DIR(0)="S",DIR("A")="Select (I)nsurance Verification or (R)UR Pre-certification"
 . S DIR("?",1)="Enter 'I' for insurance verification authorizations."
 . S DIR("?")="Enter 'R' for RUR authorizations."
 . S $P(DIR(0),U,2)="I:Insurance Verification;R:RUR Pre-certification"
 . W ! D ^DIR K DIR
 . I $G(DIRUT) Q
 . S X=$$UP^XLFSTR(X)
 . S FILTERS(0)=$S(Y="I":1,Y="R":2,1:0)
 ;
 ; First Party Copay or Third Party
 I IBWLTYP="B" D
 . S DIR(0)="S",DIR("A")="Select (F)irst Party Copay or (T)hird Party Insurance"
 . S $P(DIR(0),U,2)="F:First Party Copay;T:Third Party Insurance"
 . S DIR("?",1)="Enter 'F' for First Party Copay."
 . S DIR("?")="Enter 'T' for Third Party Insurance."
 . S $P(DIR(0),U,2)="F:First Party Copay;T:Third Party Insurance"
 . W ! D ^DIR K DIR
 . I $G(DIRUT) Q 
 . S X=$$UP^XLFSTR(X)
 . S $P(FILTERS(0),U,4)=$S(Y="F":1,Y="T":3,1:0)
 ;
 I $G(DIRUT) Q 0
 ;
 ; Site (Division) Filter
 W !
 D PSDR^IBODIV
 ; Patient Filter
 S DIR(0)="S",DIR("A")="Select(A)ll or (S)elected Patient(s):",DIR("B")="All"
 S DIR("?",1)="Enter 'A' to select ALL Patients."
 S DIR("?")="Enter 'S' to view entries for selected Patients."
 S $P(DIR(0),U,2)="A:All Patients;S:Selected Patients"
 W ! D ^DIR K DIR
 I $G(DIRUT) Q 0
 S X=$$UP^XLFSTR(X)
 S $P(FILTERS(0),U,3)=$S(Y="A":0,1:1)
 ; Set Patient / Veteran filter
 I $P(FILTERS(0),U,3)=1 D ASKPAT(.FILTERS)
 D SHOWFILT(.FILTERS)
 D CHKFILT
 Q 1
 ;
ASKPAT(FILTERS)   ; Sets a list of patients
 ; Input:   FILTERS - Current Array of filter settings
 ; Output:  FILTERS - Updated Array of filter settings
 N DIC,DIR,DIRUT,DIVS,DUOUT,FIRST,IBIENS,IBIENS2,IBN,IBXX,IEN,X,Y
 S DIC(0)="AEQMN",DIC="^DPT(",FIRST=1
 F  D  Q:+IEN<1
 . D ONEPAT(.DIC,.IEN,.FIRST)               ; One patient
 . Q:+IEN<1
 . S IBIENS($P(IEN,U,2))=$P(IEN,U,1)
 . S IBIENS2($P(IEN,U,1))=$P(IEN,U,2)
 I '$D(IBIENS) S FILTERS(2)="" Q
 ;
 ; Set the filter node responses in alphabetical order
 S IBXX=""
 F  D  Q:IBXX=""
 . S IBXX=$O(IBIENS(IBXX))
 . Q:IBXX=""
 . S IBN=IBIENS(IBXX)
 . S FILTERS(2,IBN)=""
 Q
 ;
ONEPAT(DIC,IEN,FIRST)  ; Prompts the user for a clinic or ward
 ; Input:   DIC     - Variable/Array of settings needed for ^DIC call
 ;          FIRST   - Set to 1 initially and then 0 for subsequent calls
 ; Output:  FIRST   - Set to 0
 ;          IEN     - IEN of the selected Ward or clinic Entry
 ;                    null of no selection was made
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 S DIC("A")=$S(FIRST:"Select Patient: ",1:"Select Another Patient: ")
 D ^DIC
 S FIRST=0,IEN=Y
 S DFN=+Y
 Q
 ;
SHOWFILT(FILTERS)   ; Display
 ; Displays the currently selected filter selections for the
 ; Billing and NVC Precert Worklist display
 ; Input:   FILTERS()   - Array of filter settings. See FILTERS for a detailed
 ;                        explanation of the FILTERS array
 ; Output:  Current Filter settings are displayed
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,IEN,LEN,IBXX,IBY,IBZ
 I IBWLTYP="B" D
 . W !!!,"Type of Review: "
 . S IBY=$P(FILTERS(0),U,1)
 . W $S(IBY=1:"Facility Revenue",IBY=2:"RUR SC",IBY=3:"Billing",1:"")
 . S IBZ=$P(FILTERS(0),U,4) W " ("_$S(IBZ=1:"First Party Copay",1:"Third Party")_")"
 I IBWLTYP="P" D
 . W !!!,"Pre-certification Department: "
 . S IBY=$P(FILTERS(0),U,1)
 . W $S(IBY=1:"Insurance Verification",IBY=2:"RUR",1:"")
 ;
 W !,"Show All Divisions or Selected Divisions: "
 W $S($G(VAUTD)=1:"All",1:"Selected")
 ;
 ; Division list (if any)
 I ($P(FILTERS(0),U,2)=1) D
 . W !,"Divisions to Display: "
 . S LEN=20,IEN=0
 . F  S IEN=$O(FILTERS(1,IEN)) Q:IEN=""  D
 . . S IBXX=$$GET1^DIQ(4,IEN_",",.01)
 . . S LEN=LEN+$L(IBXX)
 . . I LEN+2<80 D  Q
 . . . W IBXX
 . . . I $O(FILTERS(1,IEN))'="" D
 . . . . S LEN=LEN+2
 . . . . W ", "
 . . S LEN=20
 . . W !,"                    ",IBXX
 ;
 W !,"All Patients or Selected Patients: "
 W $S($P(FILTERS(0),U,3)=0:"All",1:"Selected")
 ; Patient Inclusion list (if any)
 I ($P(FILTERS(0),U,3)=1) D
 . W !,"Patients to Display: "
 . S LEN=20,IEN=0
 . F  S IEN=$O(FILTERS(2,IEN)) Q:IEN=""  D
 . . S IBXX=$$GET1^DIQ(2,IEN_",",.01)
 . . S LEN=LEN+$L(IBXX)
 . . I LEN+2<80 D  Q
 . . . W IBXX
 . . . I $O(FILTERS(2,IEN))'="" D
 . . . . S LEN=LEN+2
 . . . . W ", "
 . . S LEN=20
 . . W !,"                    ",IBXX
 ;
 K DIR
 D PAUSE^VALM1
 Q
 ;
LINKI ; View Patient Insurance (VP)
 D FULL^VALM1
 N I,J,DFN,IBXX,VALMY,ECNT,GOTPAT,REC
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 . S (ECNT,REC)=$G(^TMP("IBFBWLX",$J,IBXX))
 . S DFN=$P(ECNT,U,1)
 . S ^TMP($J,"PATINS")=$P(REC,U,1),GOTPAT=1
 . ;D EN^VALM("IBCNS INSURANCE MANAGEMENT")
 . D EN^VALM("IBCNS VIEW PAT INS")
 S VALMBCK="R"
 Q
 ;
LINKCT ; Claims Tracking (CT)
 I IBWLTYP="P",IBGRP=1 D  Q
 . W !," This action not available for IV queue."
 . D PAUSE^VALM1
 . K ^TMP($J,"IBCLMTRK")
 . S VALMBCK="R"
 D FULL^VALM1
 K ^TMP($J,"IBCLMTRK")
 N I,J,CTDT,CTIEN,CTLN1,CTTMP,CTUSR,DFN,D0,ECNT,GOTPAT,IBFBA,IBAUTH,IBEND,IBIEN,IBNAME,IBST,IBXX,VALMY
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 . S ECNT=$G(^TMP("IBFBWLX",$J,IBXX))
 . S DFN=$P(ECNT,U,1),IBNAME=$P(ECNT,U,2),IBAUTH=$P(ECNT,U,3),IBFBA=$P(ECNT,U,4),GOTPAT=1
 . S IBIEN=IBAUTH_","_DFN_","
 . D GETDTS^IBFBUTIL(IBIEN)
 . I IBEND="" S IBEND="3991231"
 . S ^TMP($J,"IBCLMTRK")=DFN_U_IBST_U_IBEND_U_IBAUTH_U_IBFBA
 . D EN^VALM("IBT CLAIMS TRACKING EDITOR")
 I IBWLTYP="P",$D(D0) D
 . S CTIEN=D0
 . I '$D(^IBT(356,CTIEN,1)) Q
 . S CTLN1=^IBT(356,CTIEN,1)
 . S CTDT=$P($P(CTLN1,U,1),".",1)
 . S CTUSR=$P(CTLN1,U,2)
 . I $G(DUZ)=CTUSR,DT=CTDT D
 .. N Y,X
 .. W !!
 .. S DIR("A")="Link last Claims Tracking entry to current auth for "_IBNAME_"? "
 .. S DIR("?")="Please answer Yes or No."
 .. S DIR("B")="YES",DIR(0)="YA^^"
 .. D ^DIR K DIR
 .. I Y(0)'="YES" Q
 .. S CTTMP=^TMP($J,"IBCLMTRK")
 .. S DFN=$P(CTTMP,U,1)
 .. S IBAUTH=$P(CTTMP,U,4)
 .. S IBXX=""
 .. S IBXX=$O(^IBFB(360,"D",DFN,IBAUTH,IBXX))
 .. S $P(^IBFB(360,IBXX,1),U,1)=CTIEN
 K ^TMP($J,"IBCLMTRK")
 S VALMBCK="R"
 Q
 ;
EXPAND ; Expand Item (EE)
 D FULL^VALM1
 N I,J,DFN,IBFBA,IBXX,VALMY,ECNT,IBAUTH,IBNAME
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 . K ^TMP("IBFBWE",$J)
 . S ECNT=$G(^TMP("IBFBWLX",$J,IBXX))
 . S DFN=$P(ECNT,U,1),IBNAME=$P(ECNT,U,2),IBAUTH=$P(ECNT,U,3),IBFBA=$P(ECNT,U,4)
 . S ^TMP("IBFBWE",$J)=DFN_U_IBNAME_U_IBAUTH_U_IBFBA
 . D EN^VALM("IB BILLING WORKLIST EXPAND")
 . Q
 K ^TMP("IBFBWE",$J)
 S VALMBCK="R"
 Q
 ;
ACTIONS ; Worklist Action (WA)
 D FULL^VALM1
 N I,J,DFN,IBFBA,IBXX,VALMY,ECNT,IBAUTH,IBNAME
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 . K ^TMP("IBFBWA",$J)
 . S ECNT=$G(^TMP("IBFBWLX",$J,IBXX))
 . S DFN=$P(ECNT,U,1),IBNAME=$P(ECNT,U,2),IBAUTH=$P(ECNT,U,3),IBFBA=$P(ECNT,U,4)
 . S ^TMP("IBFBWA",$J)=DFN_U_IBNAME_U_IBAUTH_U_IBFBA
 . I IBWLTYP="B" D
 .. D EN^VALM("IB BILLING WORKLIST ACTIONS")
 . I IBWLTYP="P" D
 .. I IBGRP=1 D EN^VALM("IB NVC PRECERT WORKLIST IV")
 .. I IBGRP=2 D EN^VALM("IB NVC PRECERT WORKLIST RUR")
 K ^TMP("IBFBWA",$J)
 K ^TMP("VALMAR",$J)
 I IBWLTYP="B" D BLDWL^IBFBWL1
 I IBWLTYP="P" D BLDWL^IBFBWL5
 K IBFIRST
 S VALMBCK="R"
 Q
 ;
HISTORY ; Worklist History (HI)
 D FULL^VALM1
 N I,J,DFN,ECNT,IBA,IBAUTH,IBB,IBFBA,IBHDT,IBHLG,IBHUSR,IBNAME,IBNAME,IBY,IBX,IBXX,VALMY
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 . K ^TMP("IBFBWH",$J)
 . S ECNT=$G(^TMP("IBFBWLX",$J,IBXX))
 . S DFN=$P(ECNT,U,1),IBNAME=$P(ECNT,U,2),IBAUTH=$P(ECNT,U,3),IBFBA=$P(ECNT,U,4)
 . I IBFBA'="" S IBY=IBFBA
 . I IBFBA="" D
 .. S IBX="" F  S IBX=$O(^IBFB(360,"C",DFN,IBX)) Q:IBX=""  D
 ... I $P(^IBFB(360,IBX,0),U,3)=IBAUTH S IBY=IBX
 . S IBA=0 F  S IBA=$O(^IBFB(360,IBY,4,IBA)) Q:IBA=""  D
 .. S IBHDT=$$FDATE^VALM1($P(^IBFB(360,IBY,4,IBA,0),U,1))
 .. S IBHLG=$P(^IBFB(360,IBY,4,IBA,0),U,2)
 .. S IBHUSR=$P(^IBFB(360,IBY,4,IBA,0),U,3)
 .. S ^TMP("IBFBWH",$J,IBA)=IBHDT_U_IBHLG_U_IBHUSR
 . D EN^VALM("IB BILLING WORKLIST HISTORY")
 . Q
 K ^TMP("IBFBWH",$J)
 S VALMBCK="R"
 Q
 ;
REFRESH ; Special Main Screen List Refresh
 K ^TMP("IBFBWL",$J)
 I IBWLTYP="B" D
 . D GETAUT^IBFBWL1(IBGRP)
 . D BLDWL^IBFBWL1
 I IBWLTYP="P" D
 . D GETAUT^IBFBWL5(IBGRP)
 . D BLDWL^IBFBWL5
 S VALMBCK="R"
 Q
 ; 
KILLGLB ; Kill Worklist Globals
 K ^TMP("IBFBWL",$J)
 K ^TMP("IBFBWLX",$J)
 K ^TMP("IBFBWA",$J)
 K ^TMP("IBFBWE",$J)
 K ^TMP("IBFBWH",$J)
 K ^TMP("VALMAR",$J)
 K ^TMP("XQORS",$J)
 K IBFP,IBFPNO,IBFPNOT,IBFPNUM,IBINLN2,IBINV,IBST
 D CLEAR^VALM1
 Q
 ;
CHKFILT ; Check Filters
 N IBSTAT,IBXX,IBXXX,IBXXXX,IBFST
 I $G(VAUTD)=1 S $P(FILTERS(0),U,2)=0,IBDIVS="All"
 I $G(VAUTD)=0 D
 .S $P(FILTERS(0),U,2)=1
 .S IBSTAT=0,IBFST=1
 .F  S IBSTAT=$O(VAUTD(IBSTAT)) Q:IBSTAT=""  D
 ..S IBXX=$E($$GET1^DIQ(40.8,IBSTAT_",",.01),1,15)
 ..S IBXXX=$$GET1^DIQ(40.8,IBSTAT_",",1,"E")
 ..S IBXXXX=$$GET1^DIQ(40.8,IBSTAT_",",.07,"I")
 ..I 'IBFST S IBDIVS=IBDIVS_","_IBXX_"-"_IBXXX
 ..I IBFST S IBFST=0,IBDIVS=IBXX_"-"_IBXXX
 ..S FILTERS(1,IBXXXX)=""
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D KILLGLB
 D CLEAN^VALM10
 D ^%ZISC
 Q
