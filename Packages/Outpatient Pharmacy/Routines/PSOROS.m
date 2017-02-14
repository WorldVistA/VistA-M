PSOROS ;AITC/BWF - REMOTE RX UTILITY ;7/15/16 2:35am
 ;;7.0;OUTPATIENT PHARMACY;**454**;DEC 1997;Build 349
 ;
 Q
 ;
EN ; -- main entry point for PSO LM REMOTE ORDER SELECTION
 D EN^VALM("PSO LM REMOTE ORDER SELECTION")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="This is a test header for PSO LM REMOTE ORDER SELECTION."
 S VALMHDR(2)="This is the second line"
 Q
 ;
INIT ; -- init variables and list array
 ;F LINE=1:1:30 D SET^VALM10(LINE,LINE_"     Line number "_LINE)
 ;S VALMCNT=30
 ;S $P(RN," ",12)=" ",VALMCNT=PSOPF
 S $P(RN," ",12)=" ",VALMCNT=$G(CNT)
 S VALM("TITLE")="REMOTE OP Medications ("_$G(SRXSTAT)_")"
 D RV^PSONFI Q
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K VALMCNT,VALMHDR
 Q
 ;
EXPND ; -- expand code
 Q
 ;
