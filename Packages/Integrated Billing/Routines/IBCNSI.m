IBCNSI ;ALB/NLR- INSURANCE COMPANY BILLING ADDRESSES ; 21-SEP-2017
 ;;2.0;INTEGRATED BILLING;**592**;21-MAR-94;Build 58
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;also used for IA #4694
 ;KDM US2487 IB*2.0*592
 ; new template needed for option AD of the insurance compnay editor menu
 ; create submenu of just billing address to have it's own screen and display
 ;
EN ; -- main entry point for IBCNSC INSURANCE CO ADDRESSES
 ;
 D EN^VALM("IBCNSC INSURANCE CO ADDRESSES")
 Q
 ;
HDR ; -- header code
 ;D HDR^IBCNSC
 S VALMHDR(1)="Insurance Co: "_$E($P(^DIC(36,IBCNS,0),"^"),1,30)_"   Claims Processing Addresses"
 ;S VALMHDR(2)="This is the second line"
 Q
 ;
INIT ; -- Option AD
 ;
 ;K VALMQUIT
 K ^TMP("IBCNSI",$J)
 S VALMCNT=0,VALMBG=1
 ;D BLDAD,HDR ; WCJ
 D BLDAD ; WCJ
 Q
 ;
BLDAD ; -- Option AD list builder display items
 ;kdm US2487 IB*2.0*592
 ;NEW BLNKI
 N BLNKI,IBACMAX  ; new variable set in PARAM section and needed throughout for display
 ;
 ;K ^TMP("IBCNSI",$J)
 S IBACMAX=0
 D KILL^VALM10()    ; delete all video attributes
 F BLNKI=1:1:50 D BLANK(.BLNKI)     ;blank lines to start with
 ; 
 ; MAIN MAILING
 N OFFSET,START,IBCNS11,IBCNS13,IBADD
 S IBCNS11=$G(^DIC(36,+IBCNS,.11))
 S IBCNS13=$G(^DIC(36,+IBCNS,.13))
 S START=1,OFFSET=25 D MAINAD^IBCNSC01       ; main mailing address
 ; 
 ; CLAIMS INPATIENT
 ;JWS;N OFFSET,START,IBCNS12,IBADD
 N IBCNS12
 S START=8,OFFSET=2 D CLMS1AD^IBCNSC0     ; inpatient claims office
 ;
 ; CLAIMS OUTPATIENT
 ;JWS;N OFFSET,START,IBCNS16,IBADD
 N IBCNS16
 S START=16,OFFSET=2 D CLMS2AD^IBCNSC0     ; outpatient claims office
 ; 
 ; RX
 ;JWS;N OFFSET,START,IBCNS18,IBADD
 N IBCNS18
 S IBCNS18=$$ADD2^IBCNSC0(IBCNS,.18,11)
 S START=24,OFFSET=2 D PRESCRAD^IBCNSC1      ; prescription claims office
 ;
 ; APPEALS OFFICE
 ;JWS;N OFFSET,START,IBCNS14,IBADD
 N IBCNS14
 S START=31,OFFSET=2 D APPEALAD^IBCNSC      ; appeals office
 ;
 ; INQUIRY OFFICE
 ;JWS;N OFFSET,START,IBCNS15,IBADD
 N IBCNS15
 S START=39+(2*$G(IBACMAX)),OFFSET=2 D INQAD^IBCNSC      ; inquiry office
 ;
 ; DENTAL CLAIMS OFFICE
 ;JWS;N OFFSET,START,IBCNS19,IBADD
 N IBCNS19
 S START=46+(2*$G(IBACMAX)),OFFSET=2 D DENTALAD^IBCNSC       ; Dental Claims Office
 ;
 S VALMCNT=+$O(^TMP("IBCNSI",$J,""),-1)    ; no of lines in the list
 Q
 ;INIT ; -- init variables and list array
 ;F LINE=1:1:30 D SET^VALM10(LINE,LINE_"     Line number "_LINE)
 ;S VALMCNT=30
 ;Q
 ; 
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
BLANK(LINE) ; -- Build blank line
 D SET^VALM10(.LINE,$J("",80))
 Q
 ;
EA ;
 D FULL^VALM1
 D MAIN^IBCNSC1
 D HDR,BLDAD
 S VALMBCK="R"
 Q
 ;
EXIT ; -- exit code
 ;
 K ^TMP("IBCNSI",$J)
 ;S VALMBCK="R"
 D CLEAR^VALM1
 Q
 ;
EXPND ; -- expand code
 Q
 ;
