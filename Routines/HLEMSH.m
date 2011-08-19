HLEMSH ;ALB/CJM -ListManager Screen for displaying an Event;12 JUN 1997 10:00 am
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13,1995
 ;
EN(TYPE) ;Entry point to viewing of help for a type of event
 ;Input: TYPE is the ien of an HL7 MONITOR EVENT TYPE
 ;Output:  none
 ;
 Q:'$G(TYPE)
 ;
 D WAIT^DICD
 D EN^VALM("HLEM EVENT HELP")
 Q
 ;
INIT ;Init variables and list array
 S VALMAR="^HLEV(776.3,TYPE,3)"
 S VALMCNT=$P($G(@VALMAR@(0)),"^",3)
 I 'VALMCNT S VALMAR="VALMAR",@VALMAR@(1,0)="NO HELP AVAILABLE!",VALMCNT=1
 S VALMBG=1
 S VALMBCK="R"
 Q
 ;
 ;
HELP ;Help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ;Exit code
 D CLEAN^VALM10
 D CLEAR^VALM1
 ;
 Q
 ;
EXPND ;Expand code
 Q
