HLCSREP ;ALB/MFK - HL7 QUEUE MANAGEMENT ;10/17/2007  08:56
 ;;1.6;HEALTH LEVEL SEVEN;**109,122**;Oct 13, 1995;Build 14
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
REPMSG ;Duplicate messages on a queue
 ; INPUT:  MSG   - Array which contains the queue and the
 ;                 message numbers for msgs to be re-queued
 ;                 MSG(QUEUE,NUMBER)
 ; OUTPUT: NONE
 N DIC,LLE,X,Y,DA,ERROR,FROMID,MSGID
 N TOID,ENTRY,LLE
 Q:('$D(MSG))
 ;  create new entries
 S (LLE,ERROR)=""
 F  S LLE=$O(MSG(LLE)) Q:(LLE="")!(ERROR)  D
 .S ENTRY=""
 .F  S ENTRY=$O(MSG(LLE,ENTRY)) Q:(ENTRY="")!(ERROR)  D
 ..S MSGID=$$ENQUEUE^HLCSQUE(LLE,"OUT")
 ..I +MSGID'>0 S ERROR=1 Q
 ..S TOID=$P(MSGID,"^",2)
 ..M ^HLCS(870,LLE,2,TOID)=^HLCS(870,LLE,2,ENTRY)
 ..;  Change .01 of new record to be IEN
 ..S $P(^HLCS(870,LLE,2,TOID,0),"^",1)=TOID
 ..S $P(^HLCS(870,LLE,2,TOID,0),"^",2)="P"
EXIT ;
 Q
 ;
ENQUE(LINK,DIR,IEN773) ;
 ;This routine will place the message=IEN773 on the "AC" xref of file 773.
 ;Input:
 ;  DIR = "I" or "O", denoting the direction that the message is going in
 ;  LINK = the ien of the logical link
 ;  IEN773 = ien of the message in file 773
 ;
 Q:'$G(LINK)
 I DIR'="I",DIR'="O" Q
 Q:'$G(IEN773)
 ;
 ; patch HL*1.6*122: MPI-client/server
 F  L +^HLMA("AC",DIR,LINK,IEN773):10 Q:$T  H 1
 S ^HLMA("AC",DIR,LINK,IEN773)=""
 L -^HLMA("AC",DIR,LINK,IEN773)
 ;
 S $P(^HLMA(+IEN773,0),U,17)=+LINK ; HL*1.6*109 - lja
 I DIR="O" D LLCNT^HLCSTCP(LINK,3)
 Q
 ;
DEQUE(LINK,DIR,IEN773) ;
 ;This routine will remove the message=IEN773 on the "AC" xref of file 773.
 ;Input:
 ;  DIR = "I" or "O", denoting the direction that the message is going in
 ;  LINK = the ien of the logical link
 ;  IEN773 = ien of the message in file 773
 ;
 Q:'$G(LINK)
 I DIR'="I",DIR'="O" Q
 Q:'$G(IEN773)
 ;
 ; patch HL*1.6*122: MPI-client/server
 F  L +^HLMA("AC",DIR,LINK,IEN773):10 Q:$T  H 1
 K ^HLMA("AC",DIR,LINK,IEN773)
 L -^HLMA("AC",DIR,LINK,IEN773)
 ;
 Q
