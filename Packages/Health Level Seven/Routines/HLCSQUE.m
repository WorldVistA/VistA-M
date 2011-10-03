HLCSQUE ;ALB/MFK/CJM HL7 UTILITY FUNCTIONS - 10/4/94 11AM ;02/17/2011
 ;;1.6;HEALTH LEVEL SEVEN;**14,61,59,153**;Oct 13, 1995;Build 11
 ;Per VHA Directive 2004-038, this routine should not be modified.
ENQUEUE(IEN,HLDIR) ;Assign a message for queue entry
 ; INPUT: IEN  - Internal Entry Number for file 870 - HL7 QUEUE
 ;        HLDIR  - Direction of queue (IN/OUT)
 ; OUTPUT: BEG - Location in the queue to stuff the message
 ;        -1   - Error
 N FRONT,BACK,DIC,DA,X,DINUM,ENTRY,Y,BPOINTER,NEWREC
 ;  Make sure required variables were given
 S IEN=$G(IEN)
 Q:(IEN="") "-1^Queue not given"
 I +IEN<1 S IEN=$O(^HLCS(870,"B",IEN,""))
 Q:(IEN="") "-1^Invalid queue"
 ;  Convert direction to a number
 S HLDIR=$G(HLDIR)
 Q:(HLDIR'="IN")&(HLDIR'="OUT")&(HLDIR'=1)&(HLDIR'=2) "-1^Invalid direction"
 S HLDIR=$S(HLDIR="IN":1,HLDIR="OUT":2,HLDIR=2:2,1:1)
 S BPOINTER=$S(HLDIR=1:"IN",1:"OUT")_" QUEUE BACK POINTER"
 S FRONT=$G(^HLCS(870,IEN,$S(HLDIR=1:"IN",1:"OUT")_" QUEUE FRONT POINTER"))
 D DELETE^HLCSQUE1(IEN,HLDIR,FRONT)
 F  L +^HLCS(870,IEN,BPOINTER):20 Q:$T
 S BACK=$G(^HLCS(870,IEN,BPOINTER))
 ; Set up DICN call
 S DIC="^HLCS(870,"_IEN_","_HLDIR_","
 S ENTRY=HLDIR+18
 S DIC(0)="LNX",DA(1)=IEN,DIC("P")=$P(^DD(870,ENTRY,0),"^",2)
 S NEWREC=BACK+1
 S (DINUM,X)=NEWREC
 ;  Create Record
 K DD,DO
 F  D  Q:Y>0  H 1
 .F  L +^HLCS(870,IEN,HLDIR,NEWREC):20 Q:$T
 .D FILE^DICN
 .I Y=-1 L -^HLCS(870,IEN,HLDIR,NEWREC) S NEWREC=NEWREC+1,(X,DINUM)=NEWREC
 ;  Set the 'status' to 'S' for stub
 S $P(^HLCS(870,IEN,HLDIR,NEWREC,0),"^",2)="S"
 S ^HLCS(870,IEN,BPOINTER)=NEWREC
EXIT1 ;  Unlock and return results
 L -^HLCS(870,IEN,BPOINTER)
 L -^HLCS(870,IEN,HLDIR,NEWREC)
 Q IEN_"^"_NEWREC
 ;
DEQUEUE(IEN,HLDIR) ;Release the next message from the queue
 N RETURN,FRONT,FPOINTER
 ;
 N FOUND,NOMORE,NEXT,HLRTIME,STATUS
 ;
 S IEN=$G(IEN)
 Q:(IEN="") "-1^Queue not given"
 I +IEN<1 S IEN=$O(^HLCS(870,"B",IEN,""))
 Q:(IEN="") "-1^Invalid queue"
 ;  Convert direction to a number
 S HLDIR=$G(HLDIR)
 Q:(HLDIR'="IN")&(HLDIR'="OUT")&(HLDIR'=1)&(HLDIR'=2) "-1^Invalid direction"
 S HLDIR=$S(HLDIR="IN":1,HLDIR="OUT":2,HLDIR=2:2,1:1)
 S FPOINTER=$S(HLDIR=1:"IN",1:"OUT")_" QUEUE FRONT POINTER"
 S HLRTIME=$P($G(^HLCS(870,IEN,0)),"^",22) ; retention time in minutes for stub
 S:HLRTIME HLRTIME=HLRTIME*60
 S:(HLRTIME<300) HLRTIME=600
 L +^HLCS(870,IEN,FPOINTER):1
 I '$T S RETURN="-1^NO NEXT RECORD" G EXIT2
 S FRONT=$G(^HLCS(870,IEN,FPOINTER))
 S (FOUND,NOMORE)=0
 F NEXT=FRONT+1:1 D  Q:FOUND  Q:NOMORE
 .F  L +^HLCS(870,IEN,HLDIR,NEXT):20 Q:$T
 .I '$D(^HLCS(870,IEN,HLDIR,NEXT,0)) D  Q:NOMORE
 ..;missing record
 ..L -^HLCS(870,IEN,HLDIR,NEXT)
 ..;update front pointer
 ..S:$O(^HLCS(870,IEN,HLDIR,NEXT)) ^HLCS(870,IEN,FPOINTER)=NEXT
 ..;
 ..;Is there another record following the missing one?
 ..S NEXT=$O(^HLCS(870,IEN,HLDIR,NEXT))
 ..I 'NEXT S NOMORE=1,RETURN="-1^NO NEXT RECORD" Q
 ..;
 ..;The next record after missing record has been found - lock it!
 ..F  L +^HLCS(870,IEN,HLDIR,NEXT):20 Q:$T
 ..;
 .;A record has been found.
 .S STATUS=$P($G(^HLCS(870,IEN,HLDIR,NEXT,0)),"^",2)
 .;Is it a pending message, a stub, or done?
 .I STATUS="P" D
 ..;it is a pending message, so should be returned.
 ..S FOUND=1,RETURN=IEN_"^"_NEXT
 ..;
 .E  D
 ..;if the record is DONE then the front pointer is wrong - fix it and try again!
 ..I STATUS="D" S ^HLCS(870,IEN,FPOINTER)=NEXT Q
 ..;
 ..;Must be a stub record
 ..;
 ..;discard 'old' stub records
 ..N HLDT1
 ..S HLDT1=$P($G(^HLCS(870,IEN,HLDIR,NEXT,0)),"^",10)
 ..I 'HLDT1 D  Q
 ...;not an old stub record - can not discard
 ...S $P(^HLCS(870,IEN,HLDIR,NEXT,0),"^",10)=$$NOW^XLFDT,NOMORE=1,RETURN="-1^STUB"
 ..;
 ..I $$FMDIFF^XLFDT($$NOW^XLFDT,HLDT1,2)>HLRTIME D
 ...;Is an old stub record - should continue on to the next record
 ...S $P(^HLCS(870,IEN,HLDIR,NEXT,0),"^",2)="U"
 ...;update front pointer
 ...S ^HLCS(870,IEN,FPOINTER)=NEXT
 ..E  D
 ...;not an old stub record - should NOT continue to next record
 ...S NOMORE=1,RETURN="-1^STUB"
 .;
 .L -^HLCS(870,IEN,HLDIR,NEXT)
 ;
 S:FOUND ^HLCS(870,IEN,FPOINTER)=NEXT
EXIT2 L -^HLCS(870,IEN,FPOINTER)
 Q RETURN
 ;
CLEARQUE(IEN,HLDIR) ;Empty an entire queue
 ; IEN - Entry number for queue - can be name from "B" X-ref
 ; HLDIR - Can be "IN", "OUT", 1 or 2.
 ; output: 0 for success
 ;        -1^error for error
 N MSG,X,ERR,FP,BP
 ;NOTE: this is not needed to initialize a queue
 ; enqueue will set up (?) a new queue
 ;  Make sure that required variables exist
 S IEN=$G(IEN)
 Q:(IEN="") "-1^Internal Entry Number missing"
 I +IEN<1 S IEN=$O(^HLCS(870,"B",IEN,""))
 Q:(IEN="") "-1^Invalid IEN"
 ;  Convert direction to a number
 S HLDIR=$G(HLDIR)
 Q:(HLDIR'="IN")&(HLDIR'="OUT")&(HLDIR'=1)&(HLDIR'=2) "-1^Invalid direction"
 S HLDIR=$S(HLDIR="IN":1,HLDIR="OUT":2,HLDIR=2:2,1:1)
 ;  If in queue, set front pointer to 6, out pointer gets set to 8
 I HLDIR=1 S FP="IN QUEUE FRONT POINTER",BP="IN QUEUE BACK POINTER"
 I HLDIR=2 S FP="OUT QUEUE FRONT POINTER",BP="OUT QUEUE BACK POINTER"
 S MSG=0
 W !
 ;  Loop through and delete messages
 F  S MSG=$O(^HLCS(870,IEN,HLDIR,MSG)) Q:(MSG'>0)  D
 .S ERR=$$DELMSG^HLCSQUE1(IEN,HLDIR,MSG) W "."
 .I ERR W ERR,!
 ;  Clear front and back pointers
 S ^HLCS(870,IEN,FP)=0
 S ^HLCS(870,IEN,BP)=0
 ;K IEN,HLDIR
 Q 0
 ;
PUSH(HLDOUT0,HLDOUT1) ;-- Place message back on queue
 ;  INPUT - HLDOUT0 IEN of file 870
 ;          HLDOUT1 IEN of Out Multiple
 ;  OUTPUT- NONE
 ;
 ;-- exit if not vaild variables
 I 'HLDOUT0!'HLDOUT1 G PUSHQ
 ;-- exit if global does not already exist
 I '$D(^HLCS(870,HLDOUT0,"OUT QUEUE FRONT POINTER")) G PUSHQ
 S ^HLCS(870,HLDOUT0,"OUT QUEUE FRONT POINTER")=(HLDOUT1-1)
PUSHQ Q
 ;
