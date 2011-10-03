HLCSREQ ;ALB/MFK - HL7 MESSAGE REQUEUER SCREEN # 3 ;02/16/2000  15:58
 ;;1.6;HEALTH LEVEL SEVEN;**61**;Oct 13, 1995
EN ; -- main entry point
 D EN^VALM("HL MESSAGE REQUEUER - 1")
 Q
 ;
HDR ; -- header code
 N TMP
 S TMP="Known Logical Links"
 S VALMHDR(1)=$$SETSTR^VALM1(TMP,"",(40-($L(TMP)\2)),$L(TMP))
 Q
 ;
INIT ; -- init variables and list array
 ; -- build array of indices and queues
 N LLE,X,LINEENT,NAME,SIZE,HLPOINT,HLSENT,ENTRY,HLSTAT,X
 S LLE=0,X=0
 F  S LLE=$O(^HLCS(870,LLE)) Q:(LLE="")  D
 .Q:('$D(^HLCS(870,LLE,2,0)))
 .S LINEENT=""
 .S SIZE=$P(^HLCS(870,LLE,2,0),"^",4)
 .S:(SIZE="") SIZE=0
 .S HLPOINT="",HLSENT=0
 .F  S HLPOINT=$O(^HLCS(870,LLE,2,"B",HLPOINT)) Q:(HLPOINT="")  D
 ..S ENTRY=$O(^HLCS(870,LLE,2,"B",HLPOINT,""))
 ..Q:'ENTRY
 ..Q:'$D(^HLCS(870,LLE,2,ENTRY,0))
 ..S HLSTAT=$P($G(^HLCS(870,LLE,2,ENTRY,0)),"^",2)
 ..S HLSENT=HLSENT+($S(HLSTAT="P":0,1:1))
 .S NAME=$P(^HLCS(870,LLE,0),"^",1)
 .S X=X+1
 .S LINEENT=$$SETFLD^VALM1(X,LINEENT,"NUMBER")
 .S LINEENT=$$SETFLD^VALM1(NAME,LINEENT,"QUEUE")
 .S LINEENT=$$SETFLD^VALM1(SIZE,LINEENT,"SIZE")
 .S LINEENT=$$SETFLD^VALM1(HLSENT,LINEENT,"SENT")
 .S LINEENT=$$SETFLD^VALM1(SIZE-HLSENT,LINEENT,"PENDING")
 .;D SET^VALM10(X,LINEENT)
 .S ^TMP("HL",$J,X,0)=LINEENT
 .S ^TMP("HL",$J,"B",X,LLE)=""
 .S ^TMP("HL",$J,"IDX",X,X)=""
 I (X=0) S ^TMP("HL",$J,1,0)="** No logical links have been defined **"
 S VALMCNT=X
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("HL",$J)
 Q
 ;
EXPND ; -- expand code
 N LOOP,MATCH,VALMY
 S LOOP=""
 D EN^VALM2(XQORNOD(0))
 ; -- find out what the user selected
 I ('$D(VALMY)) S VALMBCK="" Q
 F LOOP=$O(VALMY(LOOP)) Q:(LOOP="")  D
 .S MATCH=$O(^TMP("HL",$J,"B",LOOP,""))
 ; -- call entry to show individual messages
 D EN^HLCSRES(MATCH)
 ; -- re-index files in case entries were re-queued
 D INIT
 Q
 ;
