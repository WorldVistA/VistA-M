HLCSRES ;ALB/MFK - HL7 MESSAGE REQUEUER SCREEN # 2 ; 08-JUN-1995
 ;;1.6;HEALTH LEVEL SEVEN;;Oct 13, 1995
EN(MATCH) ; -- main entry point
 D EN^VALM("HL MESSAGE REQUEUER - 2")
 Q
 ;
HDR ; -- header code
 N TMP,NAME
 S TMP=$G(^HLCS(870,MATCH,0))
 S NAME=$P(TMP,"^",1)
 S:(NAME="") NAME="UNKNOWN"
 S TMP="Processed Messages in Logical Link "_NAME
 S VALMHDR(1)=$$SETSTR^VALM1(TMP,"",(40-($L(TMP)\2)),$L(TMP))
 Q
 ;
INIT ; -- init variables and list array
 N ENTRY,DATE,APP,X,DATE1,LINEENT,CNTR,Y
 S (ENTRY,CNTR)=0
 F  S ENTRY=$O(^HLCS(870,MATCH,2,ENTRY)) Q:(ENTRY="")!(ENTRY="B")  D
 .Q:($P($G(^HLCS(870,MATCH,2,ENTRY,0)),"^",2)="P")
 .S CNTR=CNTR+1
 .S LINEENT=""
 .S DATE1=$P($G(^HLCS(870,MATCH,2,ENTRY,1,1,0)),"^",7)
 .S APP=$P($G(^HLCS(870,MATCH,2,ENTRY,1,1,0)),"^",5)
 .S DATE=$$FMDATE^HLFNC(DATE1)
 .S Y=DATE
 .D DD^%DT
 .S LINEENT=$$SETFLD^VALM1(CNTR,LINEENT,"INDEX")
 .S LINEENT=$$SETFLD^VALM1(Y,LINEENT,"DATE")
 .S LINEENT=$$SETFLD^VALM1(APP,LINEENT,"APP")
 .S ^TMP("HL","MESSAGE",$J,CNTR,0)=LINEENT
 .S ^TMP("HL","MESSAGE",$J,"IDX",CNTR,CNTR)=""
 .S ^TMP("HL","MESSAGE",$J,"B",CNTR,ENTRY)=""
 I CNTR=0 S ^TMP("HL","MESSAGE",$J,1,0)="** There are no entries in this queue **"
 S VALMCNT=CNTR
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXPND ; -- expand code
 N LOOP,LLE,X,VALMY,HLLLE
 S LOOP="",HLLLE=0
 D EN^VALM2(XQORNOD(0))
 ; -- find out what the user selected
 I ('$D(VALMY)) S VALMBCK="" Q
 F LOOP=$O(VALMY(LOOP)) Q:(LOOP="")  D
 .S HLLLE=HLLLE+1
 .S LLE(HLLLE)=$O(^TMP("HL","MESSAGE",$J,"B",LOOP,""))
 ; -- call entry to show individual messages
 D EN^HLCSRQ
 ; -- re-index files in case entries were re-queued
 Q
