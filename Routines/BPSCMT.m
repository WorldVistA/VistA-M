BPSCMT ;BHAM ISC/SS - ECME SCREEN ADD/VIEW COMMENTS ;28-MAR-2005
 ;;1.0;E CLAIMS MGMT ENGINE;**1**;JUN 2004
 ;; Per VHA Directive 10-93-142, this routine should not be modified.
 ;USER SCREEN
 Q
 ;
CMT ;to invoke Add/View comments LM screen from main LM User Screen
 N BPRET,BPSEL
 I '$D(@(VALMAR)) Q
 D FULL^VALM1
 W !,"Enter the line number for which you wish to Add/View comments."
 S BPSEL=$$ASKLINE^BPSSCRU4("Select item","PC","Please select a SINGLE Patient Line item or a SINGLE Rx Line item when accessing Comments")
 I BPSEL<1 S VALMBCK="R" Q
 ;save some User Screen's configuration information VALVAR
 D SAVESEL(BPSEL,VALMAR)
 ;invoke Add/View comments LM screen
 D EN
 ;update the content of the main User Screen and redraw it
 I $G(^TMP("BPSSCR",$J,"VALM","UPDATE"))=1 D
 . D REDRAW^BPSSCRUD("Updating user screen for new comment(s)...")
 . K ^TMP("BPSSCR",$J,"VALM","UPDATE")
 ;return to main User Screen
 S VALMBCK="R"
 Q
 ;
EN ; -- main entry point for BPS LSTMN COMMENTS
 D EN^VALM("BPS LSTMN COMMENTS")
 Q
 ;
HDR ; -- header code
 N BPARR,BPX
 Q:'$D(@VALMAR@("VIEWPARAMS"))
 D RESTVIEW^BPSSCR01(.BPARR) ;Note: restore settings from current 
 ;("BPSCMT") TMP (because we have already put main screen setting in this TMP, see SAVESEL)
 S VALMHDR(1)="PHARMACY ECME"
 S VALMHDR(2)="SELECTED DIVISION(S): "_$$GETVDIVS^BPSSCR01(.BPARR,58)
 S VALMHDR(3)=$$GETVDETS^BPSSCR01(.BPARR)
 Q
 ;
INIT ; -- init variables and list array
 ;
 N BP59,BP59ARR,BPJSTPAT,BPINSDAT
 N BPX,BPPATIND,BPCLMIND,BPDFN,BPSSTR,BPPRNTGL,BPSINSUR,BP1LN
 I '$D(@VALMAR@("SELLN")) D SET^VALM10(1,"Needs to be called from BPS LSTMN ECME USRSCR template") Q
 S BPX=@VALMAR@("SELLN")
 S BPDFN=+$P(BPX,U,2)
 S BPSINSUR=+$P(BPX,U,3)
 S BP1LN=+$P(BPX,U,5)
 S BPPRNTGL=@VALMAR@("PARENT")
 S BPPATIND=+$P(BPX,U,6)
 S BPCLMIND=+$P(BPX,U,7)
 S BPJSTPAT=0
 I BPCLMIND=0 S BPJSTPAT=1
 I BPJSTPAT D
 . D MKPATARR(BPPRNTGL,BPPATIND,.BP59ARR)
 . S BPCLMIND=0
 . S BPPATIND=$S(BPPATIND<1:0,1:BPPATIND-1) ;since the MKARRELM will increase it by 1
 E  D
 . S BP59ARR(+$P(BPX,U,4))="" ;
 . S BPCLMIND=$S(BPCLMIND<1:0,1:BPCLMIND-1) ;since the MKARRELM will increase it by 1
 ;make LM array element(s)
 S BPPREV=0 ;to store data from previous patient/insurance group
 S BPLINE=1
 S BPINSDAT=$$GETINSUR^BPSSCRU2(+$O(BP59ARR(0)))
 S BPSINSUR=+BPINSDAT ;patient's insurance IEN
 I BPJSTPAT D MKPATELM^BPSCMT01(.BPLINE,VALMAR,BPDFN,BPINSDAT,.BPPATIND,.BPCLMIND,.BPPREV)
 S BP59=0
 F  S BP59=$O(BP59ARR(BP59)) Q:+BP59=0  D
 . D MKCLMELM^BPSCMT01(.BPLINE,VALMAR,BP59,BPDFN,BPSINSUR,.BPPATIND,.BPCLMIND,.BPPREV)
 . ;S BPLINE=BPLINE+1
 I BPJSTPAT D UPDPREV^BPSCMT01(VALMAR,.BPPATIND,.BPPREV)
 S VALMCNT=$S(BPLINE>1:BPLINE-1,1:BPLINE)
 Q
 ;/**
 ;make array of all claims (ptrs to #9002313.59)
 ;for the patient/insurance pair
 ;input
 ;BPPRNTGL - tmp global in parent LM
 ;BPPATIND - patient summary index
 ;BP59ARR - array to return results
MKPATARR(BPPRNTGL,BPPATIND,BP59ARR) ;
 N BPCLM,BPDFN,BPINS,BP59
 S BPCLM=0 F  S BPCLM=$O(@BPPRNTGL@("LMIND",BPPATIND,BPCLM)) Q:+BPCLM=0  D
 . S BPDFN=0 F  S BPDFN=$O(@BPPRNTGL@("LMIND",BPPATIND,BPCLM,BPDFN)) Q:+BPDFN=0  D
 . . S BPINS="" F  S BPINS=$O(@BPPRNTGL@("LMIND",BPPATIND,BPCLM,BPDFN,BPINS)) Q:BPINS=""  D
 . . . S BP59=0 F  S BP59=$O(@BPPRNTGL@("LMIND",BPPATIND,BPCLM,BPDFN,BPINS,BP59)) Q:+BP59=0  D
 . . . . S BP59ARR(BP59)=""
 Q
 ;
 ;/**
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K @VALMAR
 Q
 ;
EXPND ; -- expand code
 Q
 ;
 ;/**
 ;save selection in order to use inside enclosed ListManager copy
 ;input:
 ;BPSEL - selected line
 ;BPVALMR - parent VALMAR 
SAVESEL(BPSEL,BPVALMR) ;
 D CLEANIT
 S ^TMP("BPSCMT",$J,"VALM","SELLN")=BPSEL
 S ^TMP("BPSCMT",$J,"VALM","PARENT")=BPVALMR
 M ^TMP("BPSCMT",$J,"VALM","VIEWPARAMS")=@BPVALMR@("VIEWPARAMS")
 Q
 ;
CLEANIT ;
 K ^TMP("BPSCMT",$J,"VALM")
 Q
 ;
 ;redraw the screen for Add/View comments option
REDRWCMT ;
 N BPARR,BPVALMR,BPSEL
 S BPSEL=$G(@VALMAR@("SELLN"))
 S BPVALMR=$G(@VALMAR@("PARENT"))
 D CLEAN^VALM10
 K @VALMAR
 S @VALMAR@("SELLN")=BPSEL
 S @VALMAR@("PARENT")=BPVALMR
 M @VALMAR@("VIEWPARAMS")=@BPVALMR@("VIEWPARAMS")
 D INIT^BPSCMT
 D HDR^BPSCMT
 S VALMBCK="R"
 Q
 ;
 ;
 ;
