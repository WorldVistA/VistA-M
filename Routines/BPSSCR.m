BPSSCR ;BHAM ISC/SS - ECME USER SCREEN MAIN ;10-MAR-2005
 ;;1.0;E CLAIMS MGMT ENGINE;**1**;JUN 2004
 ;; Per VHA Directive 10-93-142, this routine should not be modified.
 ;USER SCREEN
 Q
EN ; -- main entry point for BPS ECME USER SCREEN
 D EN^VALM("BPS LSTMN ECME USRSCR")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)=$$HDR^BPSSCR01(1)
 S VALMHDR(2)=$$HDR^BPSSCR01(2)
 S VALMHDR(3)=$$HDR^BPSSCR01(3)
 Q
 ;
INIT ; -- init variables and list array
 D KILINSGL ;clean up insurance list
 W !,"Please wait..."
 S VALMCNT=$$INIT^BPSSCR01()
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D CLEANUP
 Q
 ;
EXPND ; -- expand code
 Q
 ;
CLEANUP ;
 K @VALMAR
 D KILINSGL ;clean up insurance list
 Q
 ; BPINSNAM - insurance name; BPPHONE - insurance phone number
CHKINSUR(BPINSNAM,BPPHONE) ; returns a unique number for insurance (among those found in claims)
 N BPINSID,BPMAXN
 I $L(BPINSNAM)=0 S BPINSNAM="UNKNOWN"
 I $L(BPPHONE)=0 S BPPHONE="N/A"
 S BPINSID=+$G(^TMP($J,"BPSSCRINS","VAL",BPINSNAM,BPPHONE))
 I BPINSID=0 D
 . S BPMAXN=$G(^TMP($J,"BPSSCRINS","MAXN"))+1
 . S ^TMP($J,"BPSSCRINS","VAL",BPINSNAM,BPPHONE)=BPMAXN
 . S ^TMP($J,"BPSSCRINS","MAXN")=BPMAXN
 Q +$G(^TMP($J,"BPSSCRINS","VAL",BPINSNAM,BPPHONE))
 ;
KILINSGL ;
 K ^TMP($J,"BPSSCRINS")
 Q
 ;
