BPSREOP ;BHAM ISC/SS - REOPEN CLOSED CLAIMS ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**3**;JUN 2004;Build 20
 ;; Per VHA Directive 10-93-142, this routine should not be modified.
 ;Reopen closed claims
 ;Q
EN1 ;
 N BPDFN,BPSTRT,BPEND
 W @IOF
 I $$WHATTODO(.BPDFN,.BPSTRT,.BPEND)<0 Q
 ;
EN ; -- main entry point for BPS LSTMN ECME REOPEN
 N VALMAR,VALMBCK,VALMCNT,VALMHDR,X
 D EN^VALM("BPS LSTMN ECME REOPEN")
 Q
 ;
HDR ; -- header code
 ;S VALMHDR(1)="This is a test header for BPS LSTMN ECME REOPEN."
 ;S VALMHDR(2)="This is the second line"
 Q
 ;
INIT ; -- init variables and list array
 N BPTMPGL,Y
 ;ask what patient and what is date range
 I ('$D(BPDFN))!('$D(BPSTRT))!('$D(BPEND)) W !,"BPDFN,BPSTRT,BPEND need to be defined! " Q
 D COLLECT^BPSREOP1(BPDFN,BPSTRT,BPEND)
 S VALMHDR(1)="PATIENT: "_$$PATINF^BPSREOP1(BPDFN)_"   Closed claims from "_$$FORMDATE^BPSSCRU6(BPSTRT,3)_" to "_$$FORMDATE^BPSSCRU6(BPEND,3)
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 Q
 ;
EXPND ; -- expand code
 Q
 ;
 ;prompts the user to select patient , start and end dates
 ;input/output (by reference):
 ;BPDFN - patient ien #2
 ;BPSTRT - start date (fileman format)
 ;BPEND - end date (fileman format)
 ;Return value:
 ;-1 quit
 ; 1 - continue (okay)_
 ;
WHATTODO(BPDFN,BPSTRT,BPEND) ;
 S BPDFN=$$PROMPT^BPSSCRCV("P^DPT(","Select PATIENT NAME","")
 I BPDFN<0 Q -1
 S BPSTRT=$$ASKDATE^BPSSCRU6("START WITH DATE:","TODAY")
 I BPSTRT<0 Q -1
 F  S BPEND=$$ASKDATE^BPSSCRU6("GO TO DATE:","TODAY") Q:(BPEND<0)!(BPEND'<BPSTRT)  D
 . W !,"The GO TO date cannot precede the START date."
 I BPEND<0 Q -1
 Q 1
 ;
