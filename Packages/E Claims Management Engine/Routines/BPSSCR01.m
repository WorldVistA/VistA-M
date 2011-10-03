BPSSCR01 ;BHAM ISC/SS - USER SCREEN ;10-MAR-2005
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;USER SCREEN
 Q
 ;User Screen header
 ;input:
 ; BPSLN - line of the header
 ;output:
 ; text string for the header
HDR(BPSLN) ; -- header code
 N BPARR,BPX,BPXSL
 Q:'$D(@VALMAR@("VIEWPARAMS"))
 D RESTVIEW(.BPARR)
 I BPSLN=1 Q "SELECTED DIVISION(S): "_$$GETVDIVS(.BPARR,58)
 I BPSLN=2 Q $$GETVDETS(.BPARR)
 I BPSLN=3 D  Q $$LINE^BPSSCRU3(80-$L(BPX)," ")_BPX
 . S BPXSL=$$SORTTYPE^BPSSCRSL($G(BPARR(1.12)))
 . I BPXSL="" S BPXSL="Transaction date by default"
 . S BPX="Sorted by: "_BPXSL
 Q ""
 ;/**
 ;get current view details
GETVDETS(BPARR) ;*/
 N BPSTR
 I $G(BPARR(1.01))="A" S BPSTR=$$LJ^BPSSCR02("Transmitted by ALL users",31)
 E  S BPSTR=$$LJ^BPSSCR02("Transmitted by "_$$GETUSRNM^BPSSCRU1($G(BPARR(1.16))),31)
 S BPSTR=BPSTR_$$LJ^BPSSCR02(" Activity Date Range: within the past "_$G(BPARR(1.05))_$S($G(BPARR(1.04))="H":" hour(s)",1:" day(s)"),49)
 Q BPSTR
 ;
 ;/**
 ;get divisions selected
GETVDIVS(BPARRAY,BPMLEN) ;*/
 I $G(BPARRAY(1.13))="A" Q "ALL"
 N BPDIV,BPCNT,BPSTR,BPQUIT
 S BPQUIT=0,BPSTR=""
 F BPCNT=1:1:20 S BPDIV=$P($G(BPARRAY("DIVS")),";",BPCNT+1) Q:+BPDIV=0  D  Q:BPQUIT=1
 . I $L(BPSTR_$$DIVNAME^BPSSCRDS(BPDIV))>(BPMLEN-4) D  S BPQUIT=1 Q
 . . S BPSTR=$$LJ^BPSSCR02(BPSTR_",...",BPMLEN)
 . S BPSTR=BPSTR_$S(BPCNT>1:", ",1:"")_$$DIVNAME^BPSSCRDS(BPDIV)
 Q BPSTR
 ;/**
 ;input:
 ; BPARR - local array to store user profile info
 ;returns:
 ; the last number in LM ARRAY
INIT() ; -- init variables and list array*/
 N BPLN,BPLM,BP59,BPSORT,BPTMPGL,BPRET
 N BPARR
 ;get user's ien in BPS PRFILE file
 ;if array is not defined then read information from file, 
 ;otherwise use current info from the array, because the user
 ;may specify criteria in array without saving it in file for
 ;the temporary use
 I '$D(@VALMAR@("VIEWPARAMS")) D
 . D READPROF^BPSSCRSL(.BPARR,+DUZ)
 . D SAVEVIEW(.BPARR)
 E  D RESTVIEW(.BPARR)
 ;get date/time range
 I $$GETDT^BPSSCRU1(.BPARR)=0 Q
 S BPTMPGL=$NA(^TMP($J,"BPSSCR"))
 K @BPTMPGL,@VALMAR
 D COLLECT^BPSSCR04(BPTMPGL,.BPARR)
 D SAVEVIEW(.BPARR)
 S BPRET=$$LMARRAY(BPTMPGL,.BPARR)
 K @BPTMPGL
 S:BPRET>1 BPRET=BPRET-1
 Q BPRET
 ;
 ;/**
 ;make elements for List Manager array
 ;input:
 ;BPTMPGL - TMP global to store selected claims
 ;BPARR - local array to store user profile info
 ;returns:
 ; the last number in LM ARRAY
 ;indexing (example):
 ;S ^TMP("BPSSCR",$J,"VALM",1,0)="2   BUMSTEAD,CHARLE 5444 WEBMD"
 ;S ^TMP("BPSSCR",$J,"VALM",2,0)="    2.1  CEFACLOR 500MG CAP"
 ;S ^TMP("BPSSCR",$J,"VALM",3,0)="    2.2  AMPICILLIN 250MG CAP"
 ;S ^TMP("BPSSCR",$J,"VALM","LMIND",2,437272,7008776.00001,0)=""
 ;S ^TMP("BPSSCR",$J,"VALM","LMIND",2.1,437272,7008778.00011,1)=""
 ;S ^TMP("BPSSCR",$J,"VALM","LMIND",2.2,437272,7009457.00001,2)=""
LMARRAY(BPTMPGL,BPARR) ;*/
 N BPSRTVAL,BP59,BPSORT,BPLN,BPLM,BPSTR1,BPCLM,BPPREV
 S BPLM=0 ;patient_AND_insurance level counter
 S BPCLM=0 ;claim level counter 
 S BP59=0
 S BPLN=1 ;line counter for List manager array to display on the screen
 S BPPREV=0 ;to store data from previous patient group
 ;sort type:
 ;'T' FOR TRANSACTION DATE
 ;'D' FOR DIVISION (ECME pharmacy)
 ;'I' FOR INSURANCE
 ;'C' FOR REJECT CODE 
 ;'P' FOR PATIENT NAME
 ;'N' FOR DRUG NAME
 ;'B' FOR BILL TYPE (BB/RT)
 ;'L' FOR FILL LOCATION (Windows/Mail/CMOP) 
 ;'R' FOR RELEASED/NON-RELEASED RX
 ;'A' FOR ACTIVE/DISCONTINUED RX
 S BPSORT=$G(BPARR(1.12))
 S:BPSORT="" BPSORT="T" ;default
 S BPSRTVAL="" ;a value that "makes" an order, can be a string
 F  S BPSRTVAL=$O(@BPTMPGL@("SORT",BPSORT,BPSRTVAL)) Q:BPSRTVAL=""  D
 . I BPSORT="D" D
 . . S BPSTR1="---- Division: "_$$DIVNAME^BPSSCRDS(+$P(BPSRTVAL,U,2))_" "
 . . D SET^VALM10(BPLN,BPSTR1_$$LINE^BPSSCRU3(79-$L(BPSTR1),"-"),0)
 . . S BPLN=BPLN+1
 . I BPSORT="C" D
 . . S BPSTR1=$E("---- Reject code: "_$$GETRJNAM^BPSSCRU3(BPSRTVAL)_" ",1,79)
 . . D SET^VALM10(BPLN,BPSTR1_$$LINE^BPSSCRU3(79-$L(BPSTR1),"-"),0)
 . . S BPLN=BPLN+1
 . S BP59=0
 . F  S BP59=+$O(@BPTMPGL@("SORT",BPSORT,BPSRTVAL,BP59)) Q:+BP59=0  D
 . . I BP59'=0 D MKARRELM^BPSSCR02(.BPLN,VALMAR,BP59,.BPLM,.BPCLM,.BPPREV)
 D UPDPREV^BPSSCR02(VALMAR,BPLM,BPPREV)
 Q BPLN
 ;
HELP ; -- help code
 N X S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 Q
 ;
EXPND ; -- expand code
 Q
 ;/**
 ;store current view params in VALMAR("VIEWPARAMS") TMP global array
 ;to display in the header
 ;input: 
 ; BPARR - array with user profile info to store
SAVEVIEW(BPARR) ;        S @VALMAR@("VIEWPARAMS",BPLMIND,BPDFN,BP59,BPLINE)=""
 Q:'$D(BPARR)
 M @VALMAR@("VIEWPARAMS")=BPARR
 Q
 ;
 ;/**
 ;restore current view params from VALMAR("VIEWPARAMS") TMP global array
 ;input: 
 ; BPARR - array with user profile info to store
RESTVIEW(BPARR) ;        S @VALMAR@("VIEWPARAMS",BPLMIND,BPDFN,BP59,BPLINE)=""
 Q:'$D(@VALMAR@("VIEWPARAMS"))
 M BPARR=@VALMAR@("VIEWPARAMS")
 Q
 ;
