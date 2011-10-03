HLEMSA ;ALB/CJM -ListManager Screen for displaying Application-specific data stored with the event;12 JUN 1997 10:00 am
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13,1995
 ;
EN(EVENT) ;Entry point to viewing an event's application-specific data
 ;Input:  EVENT is the ien of an event
 ;Output:  none
 ;
 N IDX
 Q:'$G(EVENT)
 ;
 S IDX="^TMP(""HLEM APP DATA"",$J)"
 D WAIT^DICD
 D EN^VALM("HLEM DISPLAY APPLICATION DATA")
 Q
 ;
 ;
HDR ;Header code
 ;S VALMHDR(1)="#   EVENT       DT/TM           APPLICATION    MSG      REVIEW        CNT"
 Q
 ;
INIT ;Init variables and list array
 D BLD
 S VALMBCK="R"
 Q
 ;
BLD ;Build array of application data
 D CLEAN^VALM10
 N I
 K @IDX,VALMHDR
 S VALMBG=1,(COUNT,VALMCNT)=0
 ;
 ;Build header
 ;D HDR
 S I=0 F  S I=$O(^HLEV(776.4,EVENT,3,I)) Q:'I  D
 .S VALMCNT=$$SET^HLEMSU($$INC^HLEMU(.VALMCNT),$G(^HLEV(776.4,EVENT,3,I,0))_"  =",1,"H")
 .S VALMCNT=$$SET^HLEMSU($$INC^HLEMU(.VALMCNT),$P($G(^HLEV(776.4,EVENT,3,I,2)),"^"),5)
 Q
 ;
HELP ;Help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ;Exit code
 D CLEAN^VALM10
 D CLEAR^VALM1
 K @IDX
 Q
 ;
EXPND ;Expand code
 Q
