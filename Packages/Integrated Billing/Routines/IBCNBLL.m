IBCNBLL ;ALB/ARH - Ins Buffer: LM main screen, list buffer entries ;1 Jun 97
 ;;2.0;INTEGRATED BILLING;**82,149,153,183,184,271,345,416,438,435,506,519,528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; DBIA# 642 for call to $$LST^DGMTU
 ; DBIA# 4433 for call to $$SDAPI^SDAMA301
 ;
EN ; - main entry point for screen
 N VIEW,AVIEW,DFLG,IBKEYS
 S VIEW=6,AVIEW=0 ; default to complete view ;IB*2*506/taz changed
 K ^TMP("IBCNERTQ",$J) ; clear temp. global for eIV real time inquiries
 D EN^VALM("IBCNB INSURANCE BUFFER LIST")
 Q
 ;
EN1(V) ; entry point from view changing actions
 S VIEW=V S AVIEW=$S(VIEW=4:1,1:0)
 D INIT,HDR
 S VALMBCK="R",VALMBG=1
 Q
 ;
HDR ;  header code for list manager display
 S VALMHDR(1)="Sorted by: "_$P(IBCNSORT,U,2)
 I $P(IBCNSORT,U,3)'="" S VALMHDR(1)=VALMHDR(1)_", """_$P(IBCNSORT,U,3)_""" first"
 I VIEW=1 S VALM("TITLE")="Positive Insurance Buffer",VALMSG="*Verified    +Active" ;IB*2*506/taz Only shows Verified and Active records.
 I VIEW=2 S VALM("TITLE")="Negative Insurance Buffer",VALMSG="*Verified    -N/Active"  ;IB*2*506/taz Only shows Verified and N/Active records.
 I VIEW=3 S VALM("TITLE")="Medicare(WNR) Insurance Buffer",VALMSG="*Verified +Act -N/Act ?Await/R #Unclr !Unable/Send"
 I VIEW=4 S VALM("TITLE")="Failure Buffer",VALMSG="!Unable/Send"  ;IB*2*506/taz changed
 I VIEW=5 S VALM("TITLE")="e-Pharmacy Buffer",VALMSG="*Verified"     ; IB*2*435
 I VIEW=6 S VALM("TITLE")="Complete Buffer",VALMSG=""     ; IB*2*506/taz added
 I VIEW=7 S VALM("TITLE")="TRICARE/CHAMPVA",VALMSG=""   ;528/baa added
 Q
 ;
INIT ;  initialization for list manager list
 K ^TMP("IBCNBLL",$J),^TMP("IBCNBLLX",$J),^TMP("IBCNBLLY",$J),^TMP($J,"IBCNBLLS"),^TMP($J,"IBCNAPPTS")
 S:$G(IBCNSORT)="" IBCNSORT=$S(VIEW=1:"10^Positive Response",1:"1^Patient Name")
 S IBKEYS=$$GETKEYS(DUZ) ;IB*2*506/taz user must have either IB INSURANCE EDIT or IB GROUP/PLAN EDIT in order to view entries without defined insurance company entries
 D BLD
 Q
 ;
HELP ;  list manager help
 D FULL^VALM1
 S VALMBCK="R"
 W @IOF
 W !,"Flags displayed on screen if they apply to the Buffer entry:"
 W !,"   i - Patient has other currently effective Insurance"
 W !,"   I - Patient is currently admitted as an Inpatient"
 W !,"   E - Patient has Expired"
 W !,"   Y - Means Test Copay Patient"
 W !,"   H - Patient has Bills On Hold"
 W !,"   * - Buffer entry Verified by User"
 W !
 ;D PAUSE^VALM1 I 'Y Q
 W !,"Sources displayed on the screen if they apply to the Buffer entry:"
 W !,"   I - Interview"
 W !,"   P - Pre-registration"
 W !,"   M - Medicare"
 W !,"   D - Data Match"
 W !,"   E - eIV"
 W !,"   R - ICB"
 W !,"   V - IVM"
 W !,"   H - HMS"
 W !,"   C - Contract Services"
 W !,"   X - e-Pharmacy"           ; IB*2*435
 W !,"   F - Intrafacility Insurance Update" ; IB*2*528
 D PAUSE^VALM1 I 'Y Q
 ;
 I VIEW'=5 D     ; IB*2*435
 . W !,"eIV Electronic Insurance Verification Status"
 . W !!,"The following eIV Status indicators may appear to the left of the patient name:",!
 . Q
 ;
 I VIEW=1 D
 .W !,"      + - eIV payer response indicates this is an active policy."
 .W !,"      $ - Escalated active policy."
 .W !,"      * - Previously an active policy."
 .Q
 I VIEW=2 D
 .W !,"      - - eIV payer response indicates this is NOT an active policy."
 .W !,"      * - Previously an not active policy."
 .Q
 I $F(",3,6,7,",VIEW) D   ;528/baa
 .W !,"      + - eIV payer response indicates this is an active policy."
 .W !,"      ? - Awaiting electronic reply from eIV Payer."
 .W !,"      $ - Escalated Active policy."
 .W !,"      * - Previously either an active or not active policy."
 .W !,"      # - Can not determine from eIV response if coverage is Active."
 .W !,"          Review Response Report. Manual verification required."
 .W !,"      ! - eIV was unable to send an inquiry for this entry."
 .W !,"          Corrections required or payer not Active."
 .W !,"      - - eIV payer response indicates this is NOT an active policy."
 .W !,"<Blank> - Entry added through manual process."
 .Q
 I VIEW=4 D
 .W !,"      ! - eIV was unable to send an inquiry for this entry."
 .W !,"          Corrections required or payer not Active."
 .Q
 ;
 I VIEW=5 D      ; IB*2*435
 . W !,"      e-Pharmacy buffer entries are not applicable for e-IV processing."
 . Q
 ;
 D PAUSE^VALM1 I 'Y Q
 W !,"When an entry is Processed it is either:"
 W !,"   Accepted - the Buffer entry's data is stored in the main Insurance files."
 W !,"            - the modified Insurance entry is flagged as Verified."
 W !
 W !,"   Rejected - the Buffer entry's data is not stored in the main Insurance files."
 W !!
 W !,"Once an entry is processed (either accepted or rejected) most of the data in"
 W !,"the Buffer File entry is deleted leaving only a stub entry for tracking"
 W !,"and reporting purposes."
 W !!
 W !,"The IB INSURANCE SUPERVISOR key is required to either Accept or Reject an entry."
 D PAUSE^VALM1
 Q
 ;
EXIT ;  exit list manager option and clean up
 K ^TMP("IBCNBLL",$J),^TMP("IBCNBLLX",$J),^TMP("IBCNBLLY",$J),^TMP($J,"IBCNBLLS"),^TMP($J,"SDAMA301"),^TMP($J,"IBCNAPPTS")
 K IBCNSORT,IBCNSCRN,DFN,IBINSDA,IBFASTXT,IBBUFDA
 D CLEAR^VALM1
 Q
 ;
BLD ;  build screen display
 N IBCNT,IBCNS1,IBCNS2,IBBUFDA,IBLINE
 ;
 D SORT S IBCNT=0,VALMCNT=0,IBBUFDA=0
 ;
 S IBCNS1="" F  S IBCNS1=$O(^TMP($J,"IBCNBLLS",IBCNS1)) Q:IBCNS1=""  D
 .S IBCNS2="" F  S IBCNS2=$O(^TMP($J,"IBCNBLLS",IBCNS1,IBCNS2)) Q:IBCNS2=""  D
 ..S IBBUFDA=0 F  S IBBUFDA=$O(^TMP($J,"IBCNBLLS",IBCNS1,IBCNS2,IBBUFDA)) Q:'IBBUFDA  D
 ...S DFLG=^TMP($J,"IBCNBLLS",IBCNS1,IBCNS2,IBBUFDA)
 ...S IBCNT=IBCNT+1 I '$D(ZTQUEUED),'(IBCNT#15) W "."
 ...S IBLINE=$$BLDLN(IBBUFDA,IBCNT,DFLG) I IBLINE="" S IBCNT=IBCNT-1 Q  ; IB*2*506/taz If line is null stop processing this entry.
 ...D SET(IBLINE,IBCNT)
 ;
 I VALMCNT=0 D SET("",0),SET("There are no Buffer entries that have not been processed.",0)
 Q
 ;
BLDLN(IBBUFDA,IBCNT,DFLG) ; build line to display on List screen for one Buffer entry
 N DFN,IB0,IB20,IB60,IBLINE,IBY,VAIN,VADM,VA,VAERR,X,Y,IBMTS S IBLINE="",IBBUFDA=+$G(IBBUFDA)
 S IB0=$G(^IBA(355.33,IBBUFDA,0)),IB20=$G(^IBA(355.33,IBBUFDA,20)),IB60=$G(^IBA(355.33,IBBUFDA,60))
 S DFN=+IB60 I +DFN D DEM^VADPT,INP^VADPT
 ;
 I 'IBKEYS,'$$ACTIVE(DFN) G BLDLNQ  ;IB*2*506/taz Only allow active insurance for users not holding IB INSURANCE EDIT or IB GROUP/PLAN EDIT keys
 ;
 S IBY=$G(IBCNT),IBLINE=$$SETSTR^VALM1(IBY,"",1,4)
 ;
 ; ESG - 6/6/02 - SDD 5.1.8
 ; pull the symbol from the symbol function
 ;
 S IBY=$$SYMBOL(IBBUFDA)
 I IBY="*" S IBY=" "  ;528/baa
 S IBY=IBY_$P($G(^DPT(+DFN,0)),U,1),IBLINE=$$SETSTR^VALM1(IBY,IBLINE,5,20)
 S IBLINE=$$SETSTR^VALM1(DFLG,IBLINE,25,1)
 S IBY=$G(VA("BID")),IBLINE=$$SETSTR^VALM1(IBY,IBLINE,27,4)
 S IBY=$P(IB20,U,1),IBLINE=$$SETSTR^VALM1(IBY,IBLINE,32,17)
 S IBY=$P(IB60,U,4),IBLINE=$$SETSTR^VALM1(IBY,IBLINE,50,13)
 S IBY=$$GET1^DIQ(355.12,$P(IB0,U,3),.03),IBLINE=$$SETSTR^VALM1($$SRCCNV(IBY),IBLINE,64,1)
 S IBY=$$DATE(+IB0),IBLINE=$$SETSTR^VALM1(IBY,IBLINE,66,8)
 S IBY="" D  S IBLINE=$$SETSTR^VALM1(IBY,IBLINE,76,5)
 . S IBY=IBY_$S(+$$INSURED^IBCNS1(DFN,DT):"i",1:" ")
 . S IBY=IBY_$S(+$G(VAIN(1)):"I",1:" ")
 . S IBY=IBY_$S(+$G(VADM(6)):"E",1:" ")
 . S IBMTS=$P($$LST^DGMTU(DFN),U,4)
 . S IBY=IBY_$S(IBMTS="C":"Y",IBMTS="G":"Y",1:" ")
 . S IBY=IBY_$S(+$$HOLD(DFN):"H",1:" ")
BLDLNQ ; IB*2*506/taz Tag added
 Q IBLINE
 ;
SET(LINE,CNT) ;  set up list manager screen display array
 S VALMCNT=VALMCNT+1
 S ^TMP("IBCNBLL",$J,VALMCNT,0)=LINE Q:'CNT
 S ^TMP("IBCNBLL",$J,"IDX",VALMCNT,+CNT)=""
 S ^TMP("IBCNBLLX",$J,CNT)=VALMCNT_U_IBBUFDA
 S ^TMP("IBCNBLLY",$J,IBBUFDA)=VALMCNT_U_+CNT
 Q
 ;
SORT ;  set up sort for list screen
 ;  1^Patient Name, 2^Ins Name, 3^Source Of Info, 4^Date Entered, 5^Inpatient (Y/N), 6^Means Test (Y/N), 7^On Hold, 8^Verified, 9^eIV Status, 10^Positive Response
 N APPTNUM,IB0,IB20,IB60,IBCNDT,IBBUFDA,IBCNDFN,IBCNPAT,IBCSORT1,IBCSORT2,IBSDA,DFN,VAIN,VA,VAERR,IBX,IBCNT,INAME,SYM,MWNRFLG,MWNRIEN,X,Y
 S IBCNT=0
 ;
 K ^TMP($J,"IBCNBLLS") I '$G(IBCNSORT) S IBCNSORT="1^Patient Name"
 ; get payer ien for Medicare WNR
 S MWNRIEN=$P($G(^IBE(350.9,1,51)),U,25)
 ;
 S IBCNDT=0 F  S IBCNDT=$O(^IBA(355.33,"AEST","E",IBCNDT)) Q:'IBCNDT  D
 .S IBBUFDA=0 F  S IBBUFDA=$O(^IBA(355.33,"AEST","E",IBCNDT,IBBUFDA)) Q:'IBBUFDA  D
 ..S IBCNT=IBCNT+1 I '$D(ZTQUEUED),'(IBCNT#15) W "."
 ..S IB0=$G(^IBA(355.33,IBBUFDA,0)),IB20=$G(^IBA(355.33,IBBUFDA,20)),IB60=$G(^IBA(355.33,IBBUFDA,60))
 ..S IBCNDFN=+IB60,IBCNPAT="" I +IBCNDFN S IBCNPAT=$P($G(^DPT(IBCNDFN,0)),U,1)
 ..S INAME=$P(IB20,U)
 ..;
 ..I +IBCNSORT=1 S IBCSORT1=IBCNPAT
 ..I +IBCNSORT=2 S IBCSORT1=INAME
 ..I +IBCNSORT=3 S IBCSORT1=$P(IB0,U,3)
 ..I +IBCNSORT=4 S IBCSORT1=$P(+IB0,".",1)
 ..I +IBCNSORT=5 I +IBCNDFN S DFN=+IBCNDFN D INP^VADPT S IBCSORT1=$S($G(VAIN(1)):1,1:2)
 ..I +IBCNSORT=6 I +IBCNDFN S IBX=$P($$LST^DGMTU(IBCNDFN),U,4) S IBCSORT1=$S(IBX="C":1,IBX="G":1,1:2)
 ..I +IBCNSORT=7 I +IBCNDFN S IBX=$$HOLD(IBCNDFN) S IBCSORT1=$S(+IBX:1,1:2)
 ..I +IBCNSORT=8 S IBCSORT1=$S(+$P(IB0,U,10):1,1:2)
 ..; Sort by symbol and then within the symbol, sort by date entered
 ..; Build a numerical subscript with format ##.FM date
 ..S SYM=$$SYMBOL(IBBUFDA)
 ..I +IBCNSORT=9 S IBCSORT1=$G(IBCNSORT(1,SYM))_"."_$P(+IB0,".",1),IBCSORT1=+IBCSORT1
 ..;
 ..I +IBCNSORT=10 S IBCSORT1=$S(SYM="+":0,1:1),IBCSORT2=IBCNPAT
 ..;
 ..S IBCSORT1=$S($G(IBCSORT1)="":"~UNKNOWN",1:IBCSORT1),IBCSORT2=$S(IBCNPAT="":"~UNKNOWN",1:IBCNPAT)
 ..; get future appointments
 ..S IBSDA(1)=DT,IBSDA(3)="R;I;NT",IBSDA(4)=IBCNDFN,IBSDA("FLDS")="1;2"
 ..S DFLG="" ;,APPTNUM=$$SDAPI^SDAMA301(.IBSDA) I APPTNUM>0,SYM="!" S DFLG="d" ; duplicate flag ;IB*2*506 appointment data removed.
 ..S MWNRFLG=0 I MWNRIEN'="",$P($$INSERROR^IBCNEUT3("B",IBBUFDA),U,2)=MWNRIEN S MWNRFLG=1
 ..I $$INCL(VIEW,MWNRFLG,SYM,IB0) S ^TMP($J,"IBCNBLLS",IBCSORT1,IBCSORT2,IBBUFDA)=DFLG
 ..K VAIN,IBCSORT1,IBCSORT2
 ..Q
 .Q
 I IBCNT,'$D(ZTQUEUED) W "|"
 Q
 ;
INCL(VIEW,MCFLAG,SYM,IB0) ;
 N INCL,IENS,IBEBI
 S INCL=0
 I 'IBKEYS,(SYM'="+") G INCLQ ; If users don't have the required keys, they can only see current Positive Entries
 I VIEW=6 S INCL=1 G INCLQ  ;Include Everything  (Complete view)
 I VIEW=7,((INAME["TRICARE")!(INAME["CHAMPVA")) S INCL=1 G INCLQ  ; Tricare/Champva;528/baa
 I VIEW=5,$P(IB0,U,17) S INCL=1 G INCLQ  ;Only e-Pharmacy on e-Pharmacy view (IB*2*435)
 I $P(IB0,U,17) G INCLQ  ;Exclude e-Pharmacy (IB*2*435)
 I VIEW=3,MCFLAG S INCL=1 G INCLQ ;Only Medicare View
 I MCFLAG G INCLQ  ;Exclude Medicare from Positive, Negative and Failure Views
 I VIEW=4,(SYM="!") S INCL=1 G INCLQ  ;Only failures on Failure view
 I VIEW=1,((SYM="+")!(SYM="$")) S INCL=1 G INCLQ  ;Positive View
 I VIEW=2,(SYM="-") S INCL=1 G INCLQ  ;Negative View
 I SYM="*" D  G INCLQ
 . ;find history in Response file for verified entries.
 . I $$GET1^DIQ(355.33,IBBUFDA,.15)="" S:(VIEW=1) INCL=1 Q  ;IIV PROCESSED DATE field is empty entry is positive
 . S IENS="1,"_$O(^IBCN(365,"AF",IBBUFDA,""))_","
 . ;the following line of code is necessary to check for both "eIV Eligibility Determination" and "IIV Eligibility Determination" (IB*2.0*506)
 . I $$GET1^DIQ(365.02,IENS,.06)["IV Eligibility Determination" Q
 . S IBEBI=$$GET1^DIQ(365.02,IENS,.02)  ;Eligibility/Benefits Info
 . I IBEBI=1 S:(VIEW=1) INCL=1 Q
 . I VIEW=2 S INCL=1 Q
INCLQ ;
 Q INCL
 ;
DATE(X) ;
 Q $E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
HOLD(DFN) ; returns true if patient has bills On Hold
 Q $D(^IB("AH",+$G(DFN)))
 ;
SYMBOL(IBBUFDA) ; Returns the symbol for this buffer entry
 NEW IB0,SYM
 S IB0=$G(^IBA(355.33,IBBUFDA,0)),SYM=""
 I +$P(IB0,U,12) S SYM=$C($P($G(^IBE(365.15,+$P(IB0,U,12),0)),U,2))
 ; If the entry has been manually verified, override the symbol displayed
 I $P(IB0,U,10)'="",'+$P(IB0,U,12) S SYM="*"
 I SYM="" S SYM=" "
 Q SYM
 ;
 ;
UPDLN(IBBUFDA,ACTION) ; *** called by any action that modifies a buffer entry, so list screen can be updated if screen not recompiled
 ; modifies a single line in the display array for a buffer entry that has been modified in some way
 ; ACTION = REJECTED, ACCEPTED, EDITED
 N IBARRN,IBOLD,IBNEW,IBO,IBN S IBO="0123456789",IBN="----------"
 ;
 S IBARRN=$G(^TMP("IBCNBLLY",$J,+$G(IBBUFDA))) Q:'IBARRN
 S IBOLD=$G(^TMP("IBCNBLL",$J,+IBARRN,0)) Q:IBOLD=""
 ;
 ; if action is REJECTED or ACCEPTED then the patient name is replaced by the Action in the display array
 ; and the buffer entry is removed from the list of entries that can be selected
 I (ACTION="REJECTED")!(ACTION="ACCEPTED") D
 . S IBNEW=$TR($E(IBOLD,1,5),IBO,IBN)_ACTION_$J("",7)_$E(IBOLD,21,999)
 . S ^TMP("IBCNBLL",$J,+IBARRN,0)=IBNEW
 ;
 ; if the action is EDITED then the line for the buffer entry is recomplied and the updated line is set into 
 ; the display array
 I ACTION="EDITED" D
 . S IBNEW=$$BLDLN(IBBUFDA,+$P(IBARRN,U,2),$E(IBOLD,25))
 . S ^TMP("IBCNBLL",$J,+IBARRN,0)=IBNEW
 Q
 ;
SRCCNV(SRC) ; convert Source of Info acronym from field 355.12/.03 into 1 char code
 N CODSTR,I,SRCSTR,CODE
 S SRCSTR="INTVW^DMTCH^IVM^PreRg^eIV^HMS^MCR^ICB^CS^eRxEL^IIU"
 S CODSTR="I^D^V^P^E^H^M^R^C^X^F"
 S CODE=""
 I $G(SRC)'="" F I=1:1:11 S:SRC=$P(SRCSTR,U,I) CODE=$P(CODSTR,U,I) Q:CODE'=""
 Q CODE
 ;
GETKEYS(DUZ) ; 
 ;Make sure that user has the INSURANCE EDIT key and/or the GROUP/PLAN EDIT key.  User
 ;must have either key in order to see non_Positive Entries.
 N KEY1,KEY2
 S KEY1=$O(^DIC(19.1,"B","IB INSURANCE COMPANY EDIT","")) I KEY1 S KEY1=$D(^VA(200,DUZ,51,KEY1))
 S KEY2=$O(^DIC(19.1,"B","IB GROUP PLAN EDIT","")) I KEY2 S KEY2=$D(^VA(200,DUZ,51,KEY2))
 Q KEY1!KEY2
 ;
ACTIVE(DFN) ;Check for active insurance
 N IBINSCO
 D ALL^IBCNS1(DFN,"IBINSCO",3,DT,0)  ;IB*2.0*519 allow WNRs and Indemnity plans
 Q +$G(IBINSCO(0))
