HLCSQUE1 ;ALB/MFK HL7 UTILITY FUNCTIONS - 10/4/94 11AM ;02/17/2011
 ;;1.6;HEALTH LEVEL SEVEN;**14,59,100,153**;Oct 13, 1995;Build 11
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;Utilities used by HLCSQUE
 ;
DELMSG(IEN,HLDIR,MSG) ;DELETE A SINGLE MESSAGE FROM A QUEUE
 ;INPUT: IEN - Internal Entry Number for queue
 ;       HLDIR - Direction of queue
 ;       MSG - Message number to remove
 ;OUTPUT:  0 - Success
 ;        -1 - Error
 N DIK,DA
 ;  Check for required variables
 S IEN=$G(IEN)
 Q:(IEN="") "-1^Internal Entry Number missing"
 I +IEN<1 S IEN=$O(^HLCS(870,"B",IEN,""))
 Q:(IEN="") "-1^Invalid IEN"
 S HLDIR=$G(HLDIR)
 S HLDIR=$S(HLDIR="IN":1,HLDIR="OUT":2,HLDIR=2:2,HLDIR=1:1,1:"")
 Q:(HLDIR="") "-1^Invalid direction"
 S MSG=$G(MSG)
 Q:(MSG="") "-1^No message number"
 L +^HLCS(870,IEN,HLDIR,MSG):1
 ;If lock fails, another process is doing the work.
 I '$T Q 1
 S DIK="^HLCS(870,"_IEN_","_HLDIR_",",DA(1)=IEN,DA=MSG
 D ^DIK
 L -^HLCS(870,IEN,HLDIR,MSG)
 K IEN,HLDIR,MSG
 Q 0
DELETE(IEN,HLDIR,FRONT) ;  Delete messages outside the 'queue size' window
 N MSG,TMP,QSIZE,STOP,HLX
 ;  Make sure required variables exist
 S IEN=$G(IEN) Q:(IEN="")
 S HLDIR=$G(HLDIR) Q:(HLDIR="")
 S FRONT=$G(FRONT) Q:(FRONT="")
 S TMP=^HLCS(870,IEN,0)
 S QSIZE=$P(TMP,"^",21)
 I FRONT'>0 Q
 I QSIZE'>0 S QSIZE=10
 S MSG=0,STOP=0
 ;  For each message from the beginning of the queue to the front
 ;  of the queue-queue size, delete that message if it's done
 F  S MSG=$O(^HLCS(870,IEN,HLDIR,MSG)) Q:(MSG>(FRONT-QSIZE))!(STOP'=0)!(MSG'>0)  D
 .;P153 Start PIJ
 .;I $P($G(^HLCS(870,IEN,HLDIR,MSG,0)),"^",2)'="D" D  QUIT:STOP  ;->
 .I $P($G(^HLCS(870,IEN,HLDIR,MSG,0)),"^",2)'="D",$P($G(^HLCS(870,IEN,HLDIR,MSG,0)),"^",2)'="U" D  QUIT:STOP  ;->
 ..;P153 End PIJ
 ..I $D(^HLCS(870,IEN,HLDIR,MSG)) D  QUIT:STOP  ;->
 ...S HLX=$O(^HLCS(870,IEN,HLDIR,MSG)) QUIT:HLX>0  ;->
 ...S STOP=1
 ..S HLX=+$G(HLX)
 ..I '$D(^HLCS(870,IEN,HLDIR,+HLX,0)) S STOP=1 QUIT  ;->
 ..Q:$P($G(^HLCS(870,IEN,HLDIR,+HLX,0)),U,2)="D"  ;-> All OK...
 ..Q:$P($G(^HLCS(870,IEN,HLDIR,+HLX,0)),U,2)="U"  ;-> All OK...
 ..S STOP=1
 .S STOP=$$DELMSG(IEN,HLDIR,MSG)
 K IEN,HLDIR,FRONT
 Q
