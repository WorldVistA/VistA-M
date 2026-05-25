IBCNBLL ;ALB/ARH - Ins Buffer: LM main screen, list buffer entries ;1 Jun 97
 ;;2.0;INTEGRATED BILLING;**82,149,153,183,184,271,345,416,438,435,506,519,528,549,601,595,631,664,668,737,771,794,806,822**;21-MAR-94;Build 21
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
 ;IB*822/CKB - moved code to IBCNBLL1, routine exceeded SACC max size
 D HDR^IBCNBLL1
 Q
 ;
INIT ;  initialization for list manager list
 K ^TMP("IBCNBLL",$J),^TMP("IBCNBLLX",$J),^TMP("IBCNBLLY",$J),^TMP($J,"IBCNBLLS"),^TMP($J,"IBCNAPPTS")
 K ^TMP("IBCNBLLSP",$J)  ;IB*806/806 used to track patient subscriber id for policy
 ; IB*2.0*737/DTG correct IBCNSORT due to removed "*"
 ; S:$G(IBCNSORT)="" IBCNSORT=$S(VIEW=1:"10^Positive Response",1:"1^Patient Name")
 ;IB*794/DTG if sort is null default to patient name for all
 ;S:$G(IBCNSORT)="" IBCNSORT=$S(VIEW=1:"9^Positive Response",1:"1^Patient Name")
 S:$G(IBCNSORT)="" IBCNSORT="1^Patient Name"
 S IBKEYS=$$GETKEYS(DUZ) ;IB*2*506/taz user must have either IB INSURANCE EDIT or IB GROUP/PLAN EDIT in order to view entries without defined insurance company entries
 D BLD
 Q
 ;
HELP ;  list manager help
 ;IB*822/CKB - moved code to IBCNBLL1, routine exceeded SACC max size
 D HELP^IBCNBLL1
 Q
 ;
EXIT ;  exit list manager option and clean up
 K ^TMP("IBCNBLL",$J),^TMP("IBCNBLLX",$J),^TMP("IBCNBLLY",$J),^TMP($J,"IBCNBLLS"),^TMP($J,"SDAMA301"),^TMP($J,"IBCNAPPTS")
 K ^TMP("IBCNBLLSP",$J)  ;IB*806/DTG new policy flag track
 K IBCNSORT,IBCNSCRN,DFN,IBINSDA,IBFASTXT,IBBUFDA
 D CLEAR^VALM1
 Q
 ;
BLD ;  build screen display
 N IBCNT,IBCNS1,IBCNS2,IBBUFDA,IBLINE
 ;
 N IBSUBSAV,IBSBSAVA S (IBSUBSAV,IBSBSAVA)=""  ;IB*806/DTG new var's for new flag
 ;
 D SORT S IBCNT=0,VALMCNT=0,IBBUFDA=0
 ;
 I '$D(ZTQUEUED) W !,"Building display "  ;IB*794/DJW telling users what we are doing
 S IBCNS1="" F  S IBCNS1=$O(^TMP($J,"IBCNBLLS",IBCNS1)) Q:IBCNS1=""  D
 .S IBCNS2="" F  S IBCNS2=$O(^TMP($J,"IBCNBLLS",IBCNS1,IBCNS2)) Q:IBCNS2=""  D
 ..S IBBUFDA=0 F  S IBBUFDA=$O(^TMP($J,"IBCNBLLS",IBCNS1,IBCNS2,IBBUFDA)) Q:'IBBUFDA  D
 ...S DFLG=^TMP($J,"IBCNBLLS",IBCNS1,IBCNS2,IBBUFDA)
 ...S IBSBSAVA=$G(^TMP("IBCNBLLSP",$J,IBCNS1,IBCNS2,IBBUFDA))  ;IB*806/DTG pick up the potential new pt flag
 ...S IBCNT=IBCNT+1 I '$D(ZTQUEUED),'(IBCNT#100) W "."  ;IB*794/DJW changed '(IBCNT#15) to be #100
 ...S IBLINE=$$BLDLN(IBBUFDA,IBCNT,DFLG) I IBLINE="" S IBCNT=IBCNT-1 Q  ; IB*2*506/taz If line is null stop processing this entry.
 ...D SET(IBLINE,IBCNT)
 ;
 I VALMCNT=0 D SET("",0),SET("There are no Buffer entries that have not been processed.",0)
 Q
 ;
BLDLN(IBBUFDA,IBCNT,DFLG) ; build line to display on List screen for one Buffer entry
 N DFN,IB0,IB20,IB40,IB60,IBLINE,IBMTS,IBY,MCFLAG,VA,VADM,VAERR,VAIN,X,Y
 S IBLINE="",IBBUFDA=+$G(IBBUFDA)
 S IB40=$G(^IBA(355.33,IBBUFDA,40)),MCFLAG=$$GTMFLG(IBBUFDA)  ;IB*2.0*549
 S IB0=$G(^IBA(355.33,IBBUFDA,0)),IB20=$G(^IBA(355.33,IBBUFDA,20)),IB60=$G(^IBA(355.33,IBBUFDA,60))
 S DFN=+IB60 I +DFN D DEM^VADPT,INP^VADPT
 ;
 ;IB*2.0*549 - Replaced the following line of code:
 ;I 'IBKEYS,'$$ACTIVE(DFN) G BLDLNQ  ;IB*2*506/taz Only allow active insurance for users not holding IB INSURANCE EDIT or IB GROUP/PLAN EDIT keys
 ; With the following code that will determine if the list item is Medicare (+MCFLAG,) then include it on
 ; the list even if the user doesn't have the security keys and if the patient has ACTIVE or INACTIVE policies.
 I 'IBKEYS,'$$ACTIVE(DFN),'MCFLAG G BLDLNQ  ;IB*2.0*549
 ;
 S IBY=$G(IBCNT),IBLINE=$$SETSTR^VALM1(IBY,"",1,4)
 ;
 ; ESG - 6/6/02 - SDD 5.1.8
 ; pull the symbol from the symbol function
 ;
 S IBY=$$SYMBOL(IBBUFDA)
 ;I IBY="*" S IBY=" "  ;528/baa ;IB*737/DTG stop '*' verified
 ;IB*822/CKB - added a space in between SYMBOL and Patient Name
 S IBY=IBY_" "_$P($G(^DPT(+DFN,0)),U,1),IBLINE=$$SETSTR^VALM1(IBY,IBLINE,5,20)
 S IBLINE=$$SETSTR^VALM1(DFLG,IBLINE,25,1)
 S IBY=$G(VA("BID")),IBLINE=$$SETSTR^VALM1(IBY,IBLINE,28,4)  ;IB*822/CKB - changed '27' to '28
 ;S IBY=$P(IB20,U,1),IBLINE=$$SETSTR^VALM1(IBY,IBLINE,32,17)
 ;IB*822/CKB - changed '32' to '33' and '16' to '15' to handle the space added before the Patient Name
 S IBY=$P(IB20,U,1),IBLINE=$$SETSTR^VALM1(IBY,IBLINE,33,15)  ;IB*806/DTG new position for policy flag
 ;S IBY=$P(IB60,U,4),IBLINE=$$SETSTR^VALM1(IBY,IBLINE,50,13)
 S IBY=$P(IB60,U,4),IBLINE=$$SETSTR^VALM1(IBY,IBLINE,49,13)  ;IB*806/DTG new position for policy flag
 ;S IBY=$$GET1^DIQ(355.12,$P(IB0,U,3),.03),IBLINE=$$SETSTR^VALM1($$SRCCNV(IBY),IBLINE,64,1)
 S IBY=$$GET1^DIQ(355.12,$P(IB0,U,3),.03),IBLINE=$$SETSTR^VALM1($$SRCCNV(IBY),IBLINE,63,1)  ;IB*806/DTG new position for policy flag
 ;S IBY=$$DATE(+IB0),IBLINE=$$SETSTR^VALM1(IBY,IBLINE,66,8)
 S IBY=$$DATE(+IB0),IBLINE=$$SETSTR^VALM1(IBY,IBLINE,65,8)  ;IB*806/DTG new position for policy flag
 ;IB*771/TAZ - Moved Flags logic to FLAGS subroutine.
 ;S IBY="" D FLAGS(DFN,.IBY) S IBLINE=$$SETSTR^VALM1(IBY,IBLINE,76,5)
 S IBY="" D FLAGS(DFN,.IBY,IBBUFDA) S IBLINE=$$SETSTR^VALM1(IBY,IBLINE,75,6)  ;IB*806/DTG new policy flag
 ;
BLDLNQ ; IB*2*506/taz Tag added
 Q IBLINE
 ;
 ;FLAGS(DFN,IBY) ;Build flag set for line
FLAGS(DFN,IBY,IBBUFSN) ;Build flag set for line  ; IB*806/DTG added additional var for 'P'otential flag
 ;IB*771/TAZ - Segregated so that the code could be called from other routines.
 ;INPUT:
 ;  DFN   -  Patient IEN
 ;  IBY   -  String to append the buffer flags to.  Must be initialized in calling routine.
 ;
 ;
 ;OUTPUT:
 ;  IBY   -  String with formatted flags appended.
 ;
 N IBMTS,VA,VADM,VAIN,VAERR
 D DEM^VADPT,INP^VADPT
 S IBY=IBY_$S(+$$INSURED^IBCNS1(DFN,DT):"i",1:" ")
 S IBY=IBY_$S(+$G(VAIN(1)):"I",1:" ")
 S IBY=IBY_$S(+$G(VADM(6)):"E",1:" ")
 S IBMTS=$P($$LST^DGMTU(DFN),U,4)
 S IBY=IBY_$S(IBMTS="C":"Y",IBMTS="G":"Y",1:" ")
 S IBY=IBY_$S(+$$HOLD(DFN):"H",1:" ")
 S IBBUFSN=$G(IBBUFSN)  ; IB*806/DTG added for 'P'otential flag
 I $D(IBSBSAVA) S IBY=IBY_$G(IBSBSAVA)
 I '$D(IBSBSAVA) S IBY=IBY_$$SUBCLNCK^IBCNBLA(DFN,IBBUFSN)
 Q
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
 ; IB*2.0*737/DTG remove "8^Verified" reference
 ; Line below is the relationship between the sort order and the external description.
 ;  1^Patient Name, 2^Ins Name, 3^Source Of Info, 4^Date Entered, 5^Inpatient (Y/N), 6^Means Test (Y/N), 7^On Hold, 8^Verified, 9^eIV Status, 10^Positive Response
 ;  1^Patient Name, 2^Ins Name, 3^Source Of Info, 4^Date Entered, 5^Inpatient (Y/N), 6^Means Test (Y/N), 7^On Hold, 8^eIV Status, 10^Positive Response
 N APPTNUM,IB0,IB20,IB60,IBCNDT,IBBUFDA,IBCNDFN,IBCNPAT,IBCSORT1,IBCSORT2,IBSDA,DFN,VAIN,VA,VAERR,IBX,IBCNT,INAME,SYM,X,Y
 S IBCNT=0
 ;
 K ^TMP($J,"IBCNBLLS") I '$G(IBCNSORT) S IBCNSORT="1^Patient Name"
 K ^TMP("IBCNBLLSP",$J)  ;IB*806/DTG clear new pt policy flag track
 ; get payer ien for Medicare WNR
 ;
 I '$D(ZTQUEUED) W !,"Gathering and sorting the records "  ;IB*794/DJW telling users what we are doing
 S IBCNDT=0 F  S IBCNDT=$O(^IBA(355.33,"AEST","E",IBCNDT)) Q:'IBCNDT  D
 .S IBBUFDA=0 F  S IBBUFDA=$O(^IBA(355.33,"AEST","E",IBCNDT,IBBUFDA)) Q:'IBBUFDA  D
 ..S IBCNT=IBCNT+1 I '$D(ZTQUEUED),'(IBCNT#100) W "."  ;IB*794/DJW changed '(IBCNT#15) to be #100
 ..S IB0=$G(^IBA(355.33,IBBUFDA,0)),IB20=$G(^IBA(355.33,IBBUFDA,20)),IB60=$G(^IBA(355.33,IBBUFDA,60))
 ..S IBCNDFN=+IB60,IBCNPAT="" I +IBCNDFN S IBCNPAT=$P($G(^DPT(IBCNDFN,0)),U,1)
 ..S IBSUBSAV=$$SUBCLNCK^IBCNBLA(IBCNDFN,+IBBUFDA)  ;IB*806/DTG check for new pt policy
 ..;
 ..S INAME=$P(IB20,U)
 ..;
 ..I +IBCNSORT=1 S IBCSORT1=IBCNPAT
 ..I +IBCNSORT=2 S IBCSORT1=INAME
 ..I +IBCNSORT=3 S IBCSORT1=$P(IB0,U,3)
 ..I +IBCNSORT=4 S IBCSORT1=$P(+IB0,".",1)
 ..I +IBCNSORT=5 I +IBCNDFN S DFN=+IBCNDFN D INP^VADPT S IBCSORT1=$S($G(VAIN(1)):1,1:2)
 ..I +IBCNSORT=6 I +IBCNDFN S IBX=$P($$LST^DGMTU(IBCNDFN),U,4) S IBCSORT1=$S(IBX="C":1,IBX="G":1,1:2)
 ..I +IBCNSORT=7 I +IBCNDFN S IBX=$$HOLD(IBCNDFN) S IBCSORT1=$S(+IBX:1,1:2)
 .. ;IB*737 dropped "* verified" sort which was +IBCNSORT=8, changed
 .. ;  code below where +IBCNSORT=9 & +IBCNSORT=10 is now 8 and 9
 .. ;  to compensate for dropping "*"
 ..; I +IBCNSORT=8 S IBCSORT1=$S(+$P(IB0,U,10):1,1:2)  ; IB*737 removed
 ..; Sort by symbol and then within the symbol, sort by date entered
 ..; Build a numerical subscript with format ##.FM date
 ..S SYM=$$SYMBOL(IBBUFDA)
 ..; I +IBCNSORT=9 S IBCSORT1=$G(IBCNSORT(1,SYM))_"."_$P(+IB0,".",1),IBCSORT1=+IBCSORT1  ;IB*737
 ..; I +IBCNSORT=10 S IBCSORT1=$S(SYM="+":0,1:1),IBCSORT2=IBCNPAT  ;IB*737
 ..;
 ..I +IBCNSORT=8 S IBCSORT1=$G(IBCNSORT(1,SYM))_"."_$P(+IB0,".",1),IBCSORT1=+IBCSORT1  ;IB*737
 ..;
 ..I +IBCNSORT=9 S IBCSORT1=$S(SYM="+":0,1:1),IBCSORT2=IBCNPAT  ;IB*737
 ..;
 ..I +IBCNSORT=10 S IBCSORT1=$S(IBSUBSAV="P":0,1:1),IBCSORT2=IBCNPAT  ;IB*806/DTG new sort for 'P'otential new patient
 ..;
 ..S IBCSORT1=$S($G(IBCSORT1)="":"~UNKNOWN",1:IBCSORT1),IBCSORT2=$S(IBCNPAT="":"~UNKNOWN",1:IBCNPAT)
 ..; get future appointments
 ..S IBSDA(1)=DT,IBSDA(3)="R;I;NT",IBSDA(4)=IBCNDFN,IBSDA("FLDS")="1;2"
 ..S DFLG="" ;,APPTNUM=$$SDAPI^SDAMA301(.IBSDA) I APPTNUM>0,SYM="!" S DFLG="d" ; duplicate flag ;IB*2*506 appointment data removed.
 ..;I $$INCL(VIEW,SYM,IB0) S ^TMP($J,"IBCNBLLS",IBCSORT1,IBCSORT2,IBBUFDA)=DFLG
 ..I $$INCL(VIEW,SYM,IB0) D  ;IB806/DTG add set for new flag 'P'
 ...S ^TMP($J,"IBCNBLLS",IBCSORT1,IBCSORT2,IBBUFDA)=DFLG
 ...I $G(IBSUBSAV)'="" S ^TMP("IBCNBLLSP",$J,IBCSORT1,IBCSORT2,IBBUFDA)=IBSUBSAV
 ..K VAIN,IBCSORT1,IBCSORT2
 ..Q
 .Q
 ;I IBCNT,'$D(ZTQUEUED) W "|"  ;IB*794 "|" No longer needed
 Q
 ;
INCL(VIEW,SYM,IB0) ;
 N INCL,IENS,IBEBI,MCFLAG
 S INCL=0
 ; IB*2*549 - Added 'MCFLAG to allow Medicare in the following line.
 S MCFLAG=$$GTMFLG(IBBUFDA)
 I 'IBKEYS,'MCFLAG,(SYM'="+") G INCLQ ; If users don't have required keys, they only see current Positive Entries.
 I VIEW=6 S INCL=1 G INCLQ  ;Include Everything  (Complete view)
 I VIEW=7,((INAME["TRICARE")!(INAME["CHAMPVA")) S INCL=1 G INCLQ  ; Tricare/Champva;528/baa 
 I VIEW=5,$P(IB0,U,17) S INCL=1 G INCLQ  ;Only e-Pharmacy on e-Pharmacy view (IB*2*435)
 I $P(IB0,U,17) G INCLQ  ;Exclude e-Pharmacy (IB*2*435)
 I VIEW=3,MCFLAG S INCL=1 G INCLQ ;Only Medicare View
 I MCFLAG G INCLQ  ;Exclude Medicare from Positive, Negative and Failure Views
 I VIEW=4,(SYM="!") S INCL=1 G INCLQ  ;Only failures on Failure view
 I VIEW=1,((SYM="+")!(SYM="$")) S INCL=1 G INCLQ  ;Positive View
 I VIEW=2,(SYM="-") S INCL=1 G INCLQ  ;Negative View
 ;I SYM="*" D  G INCLQ  ;IB*737/DTG stop '*' verified
 ;. ;find history in Response file for verified entries.
 ;. I $$GET1^DIQ(355.33,IBBUFDA,.15)="" S:(VIEW=1) INCL=1 Q  ;IIV PROCESSED DATE field is empty entry is positive
 ;. S IENS="1,"_$O(^IBCN(365,"AF",IBBUFDA,""))_","
 ;. ;the following line of code is necessary to check for both "eIV Eligibility Determination" and "IIV Eligibility Determination" (IB*2.0*506)
 ;. I $$GET1^DIQ(365.02,IENS,.06)["IV Eligibility Determination" Q
 ;. S IBEBI=$$GET1^DIQ(365.02,IENS,.02)  ;Eligibility/Benefits Info
 ;. I IBEBI=1 S:(VIEW=1) INCL=1 Q
 ;. I VIEW=2 S INCL=1 Q
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
 ;I $P(IB0,U,10)'="",'+$P(IB0,U,12) S SYM="*"  ;IB*737/DTG stop '*' verified
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
 . ;IB*822/CKB - modified the REJECTED/ACCEPTED line for it to display properly, removed pt name(IBOLD 21-27)
 . S IBNEW=$TR($E(IBOLD,1,5),IBO,IBN)_" "_ACTION_$J("",13)_$E(IBOLD,28,999)
 . S ^TMP("IBCNBLL",$J,+IBARRN,0)=IBNEW
 ;
 ; if the action is EDITED then the line for the buffer entry is recompiled and the updated line is set into 
 ; the display array
 I ACTION="EDITED" D
 . S IBNEW=$$BLDLN(IBBUFDA,+$P(IBARRN,U,2),$E(IBOLD,25))
 . S ^TMP("IBCNBLL",$J,+IBARRN,0)=IBNEW
 Q
 ;
SRCCNV(SRC) ; convert Source of Info acronym from field 355.12/.03 into 1 char code
 ; IB*2*595/DM T,U,B,O,N,S,A,K,J translations added
 ; IB*2*664/DW updated "U" for Community Care Network - should be CCN and not PCC
 ; IB*2*664/VD added "W" for Electronic Health Record
 ; IB*2*668/DW added "G" for Adv Med Cost Mgmt Solution
 ;
 ; If you touch this section check the HELP in routine IBCNBLL1
 ;
 N SRCSTR,CODE
 Q:SRC="" ""
 S SRCSTR="INTVW;I^DMTCH;D^IVM;V^PreRg;P^eIV;E^HMS;H^MCR;M^ICB;R^CS;C^eRxEL;X^IIU;F^INSPT;T^CCN;U^PCFB;B^PCOTR;O^INSIN;N^INSVR;S^VAR;A^KSK;K^MVAH;J^EHR;W^AMCMS;G"
 S CODE=$P($P(SRCSTR,SRC_";",2),U,1)
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
 ;
GTMFLG(IBBUFDA) ;Check if Medicare
 ; IB*2.0*549 Added method
 N MWNRIEN,MWNRFLG
 S MWNRFLG=0
 S MWNRIEN=$P($G(^IBE(350.9,1,51)),U,25)
 S MWNRFLG=0
 I MWNRIEN'="",$P($$INSERROR^IBCNEUT3("B",IBBUFDA),U,2)=MWNRIEN S MWNRFLG=1
 Q MWNRFLG
REFRESH ; IB*794/DJW Refresh the buffer data but keep the selected view and sort
 D INIT,HDR
 S VALMBCK="R",VALMBG=1
 Q 
 ;
