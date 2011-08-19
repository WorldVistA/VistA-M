HLCSRE1 ;ALB/MFK - UTILITIES FOR HL7 MESSAGE REQUEUER; 08-JUN-1995
 ;;1.6;HEALTH LEVEL SEVEN;;Oct 13, 1995
SELECT(MODE) ;
 ; MODE=0 FOR DESELECT
 ; MODE=1 (DEFAULT) FOR SELECT
 S:('$D(MODE)) MODE=1
 ; -- find out list of selected
 D EN^VALM2(XQORNOD(0))
 I ('$D(VALMY)) S VALMBCK="" Q
 S LINE=""
 F  S LINE=$O(VALMY(LINE)) Q:(LINE="")  D
 .; -- select lines
 .S STAR=$S(MODE=0:"  ",1:" *")
 .S ROW=STAR_$E($G(^TMP("HL","MESSAGE",$J,LINE,0)),3,245)
 .S ^TMP("HL","MESSAGE",$J,LINE,0)=ROW
 .D SELECT^VALM10(LINE,MODE)
 .S ENTRY=$O(^TMP("HL","MESSAGE",$J,"B",LINE,""))
 .S ^TMP("HL","MESSAGE",$J,"B",LINE,ENTRY)=MODE
 S VALMBCK=""
 K MODE,ROW,STAR
 Q
EXIT ; -- exit code for HL7 REQUEUE MESSAGE
 ; -- compile list of messages to requeue
 N DIR,LINE,ENTRY,DIRUT,Y,X
 S LINE=""
 F  S LINE=$O(^TMP("HL","MESSAGE",$J,"B",LINE)) Q:(LINE="")  D
 .S ENTRY=""
 .F  S ENTRY=$O(^TMP("HL","MESSAGE",$J,"B",LINE,ENTRY)) Q:(ENTRY="")  D
 ..I (^TMP("HL","MESSAGE",$J,"B",LINE,ENTRY)=1) S MSG(MATCH,ENTRY)=""
 I $D(MSG) D
 .D FULL^VALM1
 .S DIR(0)="Y",DIR("B")="YES",DIR("A")="Re-queue these messages?"
 .S DIR("?")="Select ""YES"" to re-queue, or ""NO"" to quit without re-queueing."
 .D ^DIR Q:$D(DIRUT)
 .I Y=1 D REPMSG^HLCSREP
 K ^TMP("HL","MESSAGE",$J),MATCH,MSG
 S VALMBCK="R"
 Q
