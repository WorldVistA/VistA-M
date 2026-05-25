PSOROS ;AITC/BWF - REMOTE RX UTILITY ;7/15/16 2:35am
 ;;7.0;OUTPATIENT PHARMACY;**454,774**;DEC 1997;Build 15
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
 N PARK I $G(PSODFN),$L($G(REMSITE)),$L($G(SRXSTAT)),$L($G(SDNAME)) S PARK=+$G(^XTMP("PSORRX1",$J,PSODFN,REMSITE,SRXSTAT,SDNAME,"PARK"))
 S VALM("TITLE")=$S($G(PARK):"REMOTE OP Medications ("_$E($G(SRXSTAT),1,3)_"/PK)",1:"REMOTE OP Medications ("_$G(SRXSTAT)_")")
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
