HLCSRQ ;ALB/MFK - HL7 MESSAGE REQUEUER SCREEN # 3; 20-JUN-1995
 ;;1.6;HEALTH LEVEL SEVEN;;Oct 13, 1995
EN ; -- main entry point
 D EN^VALM("HL MESSAGE REQUEUER - 3")
 Q
 ;
HDR ; -- header code
 N TMP,NAME
 S TMP=$G(^HLCS(870,MATCH,0))
 S NAME=$P(TMP,"^",1)
 S:(NAME="") NAME="UNKNOWN"
 S TMP="Selected Message from Logical Link "_NAME
 S VALMHDR(1)=$$SETSTR^VALM1(TMP,"",(40-($L(TMP)\2)),$L(TMP))
 Q
 ;
INIT ; -- init variables and list array
 N X,ENTRY,COUNTER
 Q:('$D(LLE))
 Q:('$D(MATCH))
 S ENTRY="",COUNTER=0
 F  S ENTRY=$O(LLE(ENTRY)) Q:(ENTRY="")  D
 .S IDX=LLE(ENTRY)
 .S X=0
 .S COUNTER=COUNTER+1
 .F  S X=$O(^HLCS(870,MATCH,2,IDX,1,X)) Q:(X="")  D
 ..S COUNTER=COUNTER+1
 ..S LINE=$G(^HLCS(870,MATCH,2,IDX,1,X,0))
 ..D SET^VALM10(COUNTER,LINE)
 S VALMCNT=COUNTER
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
