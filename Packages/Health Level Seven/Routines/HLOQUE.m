HLOQUE ;ALB/CJM/OAK/PIJ/RBN- HL7 QUEUE MANAGEMENT - 10/4/94 1pm ;03/07/2012
 ;;1.6;HEALTH LEVEL SEVEN;**126,132,134,137,138,143,147,153,158**;Oct 13, 1995;Build 14
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
INQUE(FROM,QNAME,IEN778,ACTION,PURGE,ORIG) ;
 ;Will place the message=IEN778 on the IN queue, incoming
 ;Input:
 ;  FROM - sending facility from message header.
 ;         For actions other than incoming messages, its the specified link.
 ;  QNAME - queue named by the application
 ;  IEN778 = ien of the message in file 778
 ;  ACTION - <tag^routine> that should be executed for the application
 ;  PURGE (optional) - +PURGE>0 indicates that the purge dt/tm needs to be set by the infiler. 
 ;  ORIG - (optional, pass by reference)
 ;     If ORIG("IEN") is set, it indicates that the the incomming message was an app ack, and the original message needs to be updated with the purge dtate, status (ORIG("STATUS")), and the msgid of the original (ORIG("ACK BY"))
 ;Output: none
 ;
 N FLG
ZB36 I $G(FROM)="" S FROM="UNKNOWN"
 I $$RCNT^HLOSITE L +RECOUNT("IN",FROM,QNAME):20 S:$T FLG=1
 I '$L($G(QNAME)) S QNAME="DEFAULT"
 S ^HLB("QUEUE","IN",FROM,QNAME,IEN778)=ACTION_"^"_$G(PURGE)_"^"_$G(ORIG("IEN"))_"^"_$G(ORIG("ACK BY"))_"^"_$G(ORIG("STATUS"))
 I $$INC^HLOSITE($NA(^HLC("QUEUECOUNT","IN",FROM,QNAME)))
 L:$G(FLG) -RECOUNT("IN",FROM,QNAME)
 Q
 ;
OUTQUE(LINKNAME,PORT,QNAME,IEN778) ;
 ;Will place the message=IEN778 on the out-going queue
 ;Input:
 ;  LINKNAME = name of (.01) the logical link
 ;  PORT (optional) the port to connect to
 ;  QNAME - queue named by the application
 ;  IEN778 = ien of the message in file 778
 ;Output: none
 ;
 ;
 N SUB,FLG
 S SUB=LINKNAME
 I PORT S SUB=SUB_":"_PORT
 I '$L($G(QNAME)) S QNAME="DEFAULT"
 ;***Start HL*1.6*138 PIJ
 ;if recount in progress, give it up to 20 seconds to finish - if it takes longer than that the recount won't be exact, but a longer delay is unreasonable
 I $$RCNT^HLOSITE L +RECOUNT("OUT",SUB,QNAME):20 S:$T FLG=1
 ;***End HL*1.6*138 PIJ"
 S ^HLB("QUEUE","OUT",SUB,QNAME,IEN778)=""
 I $$INC^HLOSITE($NA(^HLC("QUEUECOUNT","OUT",SUB,QNAME)))
 L:$G(FLG) -RECOUNT("OUT",SUB,QNAME)
 Q
 ;
DEQUE(FROMORTO,QNAME,DIR,IEN778) ;
 ;This routine will remove the message=IEN778 from its queue
 ;Input:
 ;  DIR = "IN" or "OUT", denoting the direction that the message is going in
 ;  FROMORTO = for outgoing: the .01 field of the logical link
 ;         for incoming: sending facility
 ;  IEN778 = ien of the message in file 778
 ;Output: none
 ;
 Q:(FROMORTO="")
 I ($G(QNAME)="") S QNAME="DEFAULT"
 D
 .I $E(DIR)="I" S DIR="IN" Q
 .I $E(DIR)="O" S DIR="OUT" Q
 I DIR'="IN",DIR'="OUT" Q
 Q:'$G(IEN778)
 D:$D(^HLB("QUEUE",DIR,FROMORTO,QNAME,IEN778))
 .N FLG
 .I $$RCNT^HLOSITE L +RECOUNT(DIR,FROMORTO,QNAME):20 S:$T FLG=1
 .K ^HLB("QUEUE",DIR,FROMORTO,QNAME,IEN778)
 .;don't let the count become negative
 .I $$INC^HLOSITE($NA(^HLC("QUEUECOUNT",DIR,FROMORTO,QNAME)),-1)<0,$$INC^HLOSITE($NA(^HLC("QUEUECOUNT",DIR,FROMORTO,QNAME)))
 .L:$G(FLG) -RECOUNT(DIR,FROMORTO,QNAME)
 Q
 ;
STOPQUE(DIR,QUEUE) ;
 ;This API is used to set a stop flag on a named queue.
 ;DIR=<"IN" or "OUT">
 ;QUEUE - the name of the queue to be stopped
 ;
 Q:$G(DIR)=""
 Q:$G(QUEUE)=""
 S ^HLTMP("STOPPED QUEUES",DIR,QUEUE)=1
 Q
STARTQUE(DIR,QUEUE) ;
 ;This API is used to REMOVE the stop flag on a named queue.
 ;DIR=<"IN" or "OUT">
 ;QUEUE - the name of the queue to be stopped
 ;
 Q:$G(DIR)=""
 Q:$G(QUEUE)=""
 K ^HLTMP("STOPPED QUEUES",DIR,QUEUE)
 Q
STOPPED(DIR,QUEUE) ;
 ;This API is used to DETERMINE if the stop flag on a named queue is set.
 ;Input:
 ;  DIR=<"IN" or "OUT">
 ;  QUEUE - the name of the queue to be checked
 ;Output:
 ;  Function returns 1 if the queue is stopped, 0 otherwise
 N RET
 S RET=0
 Q:$G(DIR)="" 0
 Q:$G(QUEUE)="" 0
 S:$G(^HLTMP("STOPPED QUEUES",DIR,QUEUE)) RET=1
ZB0 Q RET
 ;
SQUE(SQUE,LINKNAME,PORT,QNAME,IEN778) ;
 ;Will place the message=IEN778 on the sequencing queue. This is always done in the context of the application calling an HLO API to send a message.
 ;Input:
 ;  SQUE - name of the sequencing queue
 ;  LINKNAME = name of (.01) the logical link
 ;  PORT (optional) the port to connect to
 ;  QNAME (optional) outgoing queue
 ;  IEN778 = ien of the message in file 778
 ;Output: 1 if placed on the outgoing queue, 0 if placed on the sequence queue
 ;
 N NEXT,MOVED,FLG
 S MOVED=0
 ;
 ;keep a count of messages pending on sequence queues for the HLO System Monitor
 ;
 ;***Start HL*1.6*138 PIJ
 ;if recount in progress, pause up to 20 seconds to finish - if it takes longer than that the recount won't be exact, but a longer delay is unreasonable
 I $$RCNT^HLOSITE L +RECOUNT("SEQUENCE",SQUE):20 S:$T FLG=1
 ;***End HL*1.6*138 PIJ
 ;
 ;** START 143 CJM
 L +^HLB("QUEUE","SEQUENCE",SQUE):200
 ;** END 143 CJM
 ;
 S NEXT=+$G(^HLB("QUEUE","SEQUENCE",SQUE))
 I NEXT=IEN778 L -^HLB("QUEUE","SEQUENCE",SQUE) Q 0  ;already queued!
 ;
 ;increment the counter for all sequence queues
 I $$INC^HLOSITE($NA(^HLC("QUEUECOUNT","SEQUENCE")))
 ;
 ;*** Start HL*1.6*138 CJM
 ;also keep counter for the individual queue
 I $$INC^HLOSITE($NA(^HLC("QUEUECOUNT","SEQUENCE",SQUE)))
 ;*** End HL*1.6*138 CJM
 ;
 ;** START 143 CJM
 ;L +^HLB("QUEUE","SEQUENCE",SQUE):200
 ;** END 143 CJM
 ;
 ;if the sequence queue is empty and not waiting on a message, then the message can be put directly on the outgoing queue, bypassing the sequence queue
 I '$O(^HLB("QUEUE","SEQUENCE",SQUE,0)),'NEXT D
 .S ^HLB("QUEUE","SEQUENCE",SQUE)=IEN778 ;to mean something moved to outgoing but not yet transmitted
 .D OUTQUE(.LINKNAME,.PORT,.QNAME,IEN778)
 .S MOVED=1
 E  D
 .;Put the message on the sequence queue.
 .S ^HLB("QUEUE","SEQUENCE",SQUE,IEN778)=""
 .;
 .;**P143 START CJM
 .I 'NEXT,$$ADVANCE(SQUE,"")
 .;**P143 END CJM
 .;
 .;**P147 START CJM
 .I NEXT,$L($P($G(^HLB(NEXT,0)),"^",7)) D ADVANCE(SQUE,NEXT)
 .;**P147 END CJM
 .;
 L -^HLB("QUEUE","SEQUENCE",SQUE)
 L:$G(FLG) -RECOUNT("SEQUENCE",SQUE)
 Q MOVED
 ;
ADVANCE(SQUE,MSGIEN) ;
 ;Will move the specified sequencing queue to the next message. 
 ;Input:
 ;  SQUE - name of the sequencing queue
 ;  MSGIEN - the ien of the message upon which the sequence queue was waiting.  If it is NOT the correct ien, then the sequence queue will NOT be advance.
 ;Output:
 ;  Function - 1 if advanced, 0 if not
 ;
 N NODE,IEN778,LINKNAME,PORT,QNAME
 Q:'$L($G(SQUE)) 0
 ;
 ;**P143 START CJM
 ;Q:'$G(MSGIEN) 0
 Q:'$D(MSGIEN) 0
 ;**P143 END CJM
 ;
 L +^HLB("QUEUE","SEQUENCE",SQUE):200
 ;
 ;do not advance if the queue wasn't pending the message=MSGIEN
 ;**P143 START CJM
 ;I (MSGIEN'=$P($G(^HLB("QUEUE","SEQUENCE",SQUE)),"^")) L -^HLB("QUEUE","SEQUENCE",SQUE) Q 0
 I ($G(MSGIEN)'=$P($G(^HLB("QUEUE","SEQUENCE",SQUE)),"^")) L -^HLB("QUEUE","SEQUENCE",SQUE) Q 0
 ;**P143 END CJM
 ;
 ;decrement the count of messages pending on all sequence queues
 I $$INC^HLOSITE($NA(^HLC("QUEUECOUNT","SEQUENCE")),-1)<0,$$INC^HLOSITE($NA(^HLC("QUEUECOUNT","SEQUENCE")))
 ;
 ;**Start HL*1.6*138 CJM
 ;decrement the count of messages pending on this individual queue
 I $$INC^HLOSITE($NA(^HLC("QUEUECOUNT","SEQUENCE",SQUE)),-1)<0,$$INC^HLOSITE($NA(^HLC("QUEUECOUNT","SEQUENCE",SQUE)))
 ;**End HL*1.6*138 CJM
 ;
 S IEN778=0
 ;look for the first message on the sequence que.  Make sure its valid, if not remove the invalid entry and keep looking.
 F  S IEN778=$O(^HLB("QUEUE","SEQUENCE",SQUE,0)) Q:'IEN778  S NODE=$G(^HLB(IEN778,0)) Q:$L(NODE)  D
 .;message does not exist! Remove from queue and try again.
 .K ^HLB("QUEUE","SEQUENCE",SQUE,IEN778)
 .I $$INC^HLOSITE($NA(^HLC("QUEUECOUNT","SEQUENCE")),-1)<0,$$INC^HLOSITE($NA(^HLC("QUEUECOUNT","SEQUENCE"))) ;decrement the count of messages pending sequence queues
 .;**Start HL*1.6*138 CJM
 .; also decrement the count of messages pending on this individual queue
 .I $$INC^HLOSITE($NA(^HLC("QUEUECOUNT","SEQUENCE",SQUE)),-1)<0,$$INC^HLOSITE($NA(^HLC("QUEUECOUNT","SEQUENCE",SQUE)))
 .;**End HL*1.6*138 CJM
 ;
 ;IEN778 is the next pending msg on this sequence queue
 I IEN778 D
 .;
 .;parse out info needed to move to outgoing queue
 .S LINKNAME=$P(NODE,"^",5),PORT=$P(NODE,"^",8),QNAME=$P(NODE,"^",6)
 .;
 .S ^HLB("QUEUE","SEQUENCE",SQUE)=IEN778 ;indicates this sequence queue is now waiting for msg=IEN778 before advancing.  The second pieces is the timer, but will not be set until the message=IEN778 is actually transmitted.
 .K ^HLB("QUEUE","SEQUENCE",SQUE,IEN778) ;remove from sequence queue
 .L -^HLB("QUEUE","SEQUENCE",SQUE)
 .S $P(^HLB(IEN778,5),"^",2)=1
 .D OUTQUE(.LINKNAME,$G(PORT),$G(QNAME),IEN778) ;move to outgoing queue
 E  D
 .K ^HLB("QUEUE","SEQUENCE",SQUE) ;this sequence queue is currently empty and not needed
 .L -^HLB("QUEUE","SEQUENCE",SQUE)
 Q 1
 ;
SEQCHK(WORK) ;functions under the HLO Process Manager
 ;check sequence queues for timeout
 N QUE,NOW
 S NOW=$$NOW^XLFDT
 S QUE=""
 F  S QUE=$O(^HLB("QUEUE","SEQUENCE",QUE)) Q:QUE=""  D
 .N NODE,MSGIEN,ACTION,NODE
 .S NODE=$G(^HLB("QUEUE","SEQUENCE",QUE))
 .Q:'$P(NODE,"^",2)
 .Q:$P(NODE,"^",2)>NOW
 .Q:$P(NODE,"^",3)
 .L +^HLB("QUEUE","SEQUENCE",QUE):2
 .;don't report if a lock wasn't obtained
 .Q:'$T
 .S NODE=$G(^HLB("QUEUE","SEQUENCE",QUE))
 .I '$P(NODE,"^",2) L -^HLB("QUEUE","SEQUENCE",QUE) Q
 .I ($P(NODE,"^",2)>NOW) L -^HLB("QUEUE","SEQUENCE",QUE) Q
 .I $P(NODE,"^",3) L -^HLB("QUEUE","SEQUENCE",QUE) Q  ;exception already raised
 .S MSGIEN=$P(NODE,"^")
 .I 'MSGIEN L -^HLB("QUEUE","SEQUENCE",QUE) Q
 .S ACTION=$$EXCEPT^HLOAPP($$GETSAP^HLOCLNT2(MSGIEN))
 .S $P(^HLB(MSGIEN,5),"^",3)=1
 .S $P(^HLB("QUEUE","SEQUENCE",QUE),"^",3)=1 ;indicates exception raised
 .L -^HLB("QUEUE","SEQUENCE",QUE)
 .D  ;call the application to take action
 ..N HLMSGIEN,MCODE,DUZ,QUE,NOW
 ..N $ETRAP,$ESTACK S $ETRAP="G ERROR^HLOQUE"
 ..S HLMSGIEN=MSGIEN
 ..S MCODE="D "_ACTION
 ..N MSGIEN,X
 ..D DUZ^XUP(.5)
 ..X MCODE
 ..;kill the apps variables
 ..D
 ...N ZTSK
 ...D KILL^XUSCLEAN
 Q
ERROR ;error trap for application context
 S $ETRAP="D UNWIND^%ZTER"
 D ^%ZTER
 S $ECODE=",UAPPLICATION ERROR,"
 ;
 ;kill the apps variables
 D
 .N ZTSK,MSGIEN,QUEUE
 .D KILL^XUSCLEAN
 ;
 ;release all the locks the app may have set, except Taskman lock
 L:$D(ZTSK) ^%ZTSCH("TASK",ZTSK):1
 L:'$D(ZTSK)
 ;reset HLO's lock
 L +^HLTMP("HL7 RUNNING PROCESSES",$J):0
 ;return to processing the next message on the queue
 D UNWIND^%ZTER
 Q
 ;
 ; *** start HL*1.6*143 -  RBN ***
 ;
 ; IMPLEMENTATION OF HL0 QUEUE COUNT SUMMARY
 ;
QUECNT(QUEARRAY) ;
 ; 
 ; DESC  : Functions eturns the total number of messages on all the queues and an the QUEARRAY
 ;        
 ; INPUT : QUEARRAY - the array, passed by reference, to contain the queue counts. 
 ;               
 ; OUTPUT : Filled array
 ;               
 ;               Format:
 ;             
 ;               QUE("TOTAL") = Total number of messages on all queues.
 ;               QUE("OUT")   = Total number of outgoing messages.
 ;               QUE("IN")    = Total number of incoming messages.
 ;               QUE("SEQ")   = Total number of messages on sequence queues.
 ;               QUE("IN",link_name,queue_name) = Number of messages on given link and queue.
 ;               QUE("OUT",link_name,queue_name) = Number of messages on given link and queue.
 ;               QUE("SEQ",queue_name) = Number of messages on given sequence queue.
 ; 
 ; There are four possible calls ("entry points") to this API:
 ;   1. QUECNT - returns the referenced array with all of the above data.
 ;   2. IN     - returns only the data related to the IN queues.
 ;   3. OUT    - returns only the data related to the OUT queues.
 ;   4. SEQ    - returns only the data related to the SEQUENCE queues.
 ;   
 N TOTAL,INCNT,OUTCNT,SEQCNT,LINK,QUE,FLG
 S FLG=1
 ; Get incomming counts
 D IN(.QUEARRAY)
 ; Get outgoing counts
 D OUT(.QUEARRAY)
 ; Get sequence counts
 D SEQ(.QUEARRAY)
 ;
 ; Total messages on all queues
 ; 
 S QUEARRAY("TOTAL")=INCNT+OUTCNT+SEQCNT
 Q QUEARRAY("TOTAL")
 ;
IN(QUEARRAY) ;
 ; Count messages on incoming queues
 ;
 I '$G(FLG) N TOTAL,INCNT,OUTCNT,SEQCNT,LINK,QUE,FLG
 S (LINK,QUE)=""
 S INCNT=0
 F  S LINK=$O(^HLC("QUEUECOUNT","IN",LINK)) Q:LINK=""  D
 .  F  S QUE=$O(^HLC("QUEUECOUNT","IN",LINK,QUE)) Q:QUE=""  D
 .  .  S INCNT=INCNT+^HLC("QUEUECOUNT","IN",LINK,QUE)
 .  .  S QUEARRAY("IN",LINK,QUE)=^HLC("QUEUECOUNT","IN",LINK,QUE)
 S QUEARRAY("IN")=INCNT
 I '$G(FLG) Q INCNT
 Q
 ;
OUT(QUEARRAY) ;
 ; Count messages on outgoing queues
 ;
 I '$G(FLG) N TOTAL,INCNT,OUTCNT,SEQCNT,LINK,QUE,FLG
 S (LINK,QUE)=""
 S OUTCNT=0
 F  S LINK=$O(^HLC("QUEUECOUNT","OUT",LINK)) Q:LINK=""  D
 .  F  S QUE=$O(^HLC("QUEUECOUNT","OUT",LINK,QUE)) Q:QUE=""  D
 .  .  S OUTCNT=OUTCNT+^HLC("QUEUECOUNT","OUT",LINK,QUE)
 .  .  S QUEARRAY("OUT",LINK,QUE)=^HLC("QUEUECOUNT","OUT",LINK,QUE)
 S QUEARRAY("OUT")=OUTCNT
 I '$G(FLG) Q OUTCNT
 Q
 ;
SEQ(QUEARRAY) ;
 ; Count messages on sequence queues
 ;
 I '$G(FLG) N TOTAL,INCNT,OUTCNT,SEQCNT,LINK,QUE,FLG
 S QUE=""
 S SEQCNT=0
 F  S QUE=$O(^HLC("QUEUECOUNT","SEQUENCE",QUE)) Q:QUE=""  D
 .  S SEQCNT=SEQCNT+^HLC("QUEUECOUNT","SEQUENCE",QUE)
 .  S QUEARRAY("SEQ",QUE)=^HLC("QUEUECOUNT","SEQUENCE",QUE)
 S QUEARRAY("SEQ")=^HLC("QUEUECOUNT","SEQUENCE")
 I '$G(FLG) Q QUEARRAY("SEQ")
 Q
 ;
 ; *** End HL*1.6*143 -  RBN ***
 ;
 ;** P147 START CJM
RESETF(IEN) ;
 ;resets the "F" index on the HLO Priority Queues file (#779.9) for
 ;for record IEN
 ;
 N DA
 S DA(1)=IEN
 S DA=0
 F  S DA=$O(^HLD(779.9,DA(1),1,DA)) Q:'DA  D
 .N DATA
 .S DATA(.01)=$P($G(^HLD(779.9,DA(1),1,DA,0)),"^")
 .Q:DATA(.01)=""
 .D UPD^HLOASUB1(779.91,.DA,.DATA)
 Q
 ;
GETPRTY(QUEUE,LINK) ;
 ;Inputs:
 ;    QUEUE (required)
 ;    LINK (required) the name of hte link, possibly with the port # appeded
 ;
 ;
 N PRTY,LNK
 S PRTY=0
 S LNK=$P(LINK,":")
 I $L(LNK) S PRTY=$G(^HLD(779.9,"F",QUEUE,"OUT",LNK))
 I PRTY Q PRTY
 S PRTY=$G(^HLD(779.9,"E",QUEUE,"OUT"))
 Q:'PRTY 50
 Q PRTY
 ; 
SETPRTY ;  User interface to set queue priority
 ; 
 N DIC,DA,DR,Y,DIE,QUEUE
 S DIC="^HLD(779.9,"
 S DIC(0)="QEAL"
 S DIC("A")="Enter the name of an outgoing queue: "
 S DIC("DR")=".01"
 D ^DIC
 I $G(DTOUT)!($G(DUOUT))!(Y=-1) D  Q
 . K DIC,DA,DR,Y,DIE
 S DA=+Y,QUEUE=$P(Y,"^",2)
 I $$ASKYESNO^HLOUSR2("Do you want to set "_QUEUE_"'s priority for just one specific logical link","YES") D
 .N DATA
 .S DATA(.02)="OUT"
 .D UPD^HLOASUB1(779.9,DA,.DATA)
 .S DIC="^HLD(779.9,"_DA_",1,"
 .S DA(1)=DA,DA=""
 .;S DIC("DR")=.02
 .S DIC(0)="QEAL"
 .S DIC("A")="Select the specific link: "
 .D ^DIC
 .I Y>0 D
 ..S DA=+Y
 ..S DIE="^HLD(779.9,"_DA(1)_",1,"
 ..S DR=.02
 ..D ^DIE
 E  D
 .N DATA
 .S DATA(.02)="OUT"
 .S DATA(.03)=1
 .D UPD^HLOASUB1(779.9,DA,.DATA)
 .S DIE="^HLD(779.9,"
 .S DR=.04
 .D ^DIE
 Q
SETP(QUEUE,PRIORITY,LINK) ;
 ;Description: API for setting an outgoing queue's priority
 ;Input:
 ;   QUEUE (required) the name of the queue
 ;   PRIORITY (required) the priority, 20-100
 ;   LINK (optional) name or IEN of an HL Logical Link. If specified, 
 ;                   the priority will be applied only to the specific
 ;                   link, otherwise the priority will be applied to all
 ;                   queues named QUEUE
 ;Output:
 ;     function returns 1 on success, 0 on failure
 ;
 N LINKIEN,DA,DATA
 S LINKIEN=0
 S PRIORITY=+$G(PRIORITY)
 I $G(PRIORITY)<20 Q 0
 I PRIORITY>100 Q 0
 I '$L($G(QUEUE)) Q 0
 I $L(QUEUE)>20 Q 0
 I $L($G(LINK)) D  Q:'LINKIEN 0
 .S LINKIEN=0
 .I LINK,$D(^HLCS(870,LINK,0)) S LINKIEN=LINK Q
 .S LINKIEN=$O(^HLCS(870,"B",LINK,0))
 S DA=$O(^HLD(779.9,"B",QUEUE,0))
 I 'DA D
 .S DATA(.02)="OUT"
 .S DATA(.01)=QUEUE
 .I 'LINKIEN S DATA(.03)=1,DATA(.04)=PRIORITY
 .S DA=$$ADD^HLOASUB1(779.9,,.DATA)
 E  I 'LINKIEN D  Q $$UPD^HLOASUB1(779.9,DA,.DATA)
 .S DATA(.02)="OUT"
 .S DATA(.03)=1
 .S DATA(.04)=PRIORITY
 Q:'DA 0
 Q:'LINKIEN 1
 S DA(1)=DA
 S DA=$O(^HLD(779.9,DA(1),1,"B",LINKIEN,0))
 K DATA
 S DATA(.01)=LINKIEN
 S DATA(.02)=PRIORITY
 I DA Q $$UPD^HLOASUB1(779.91,.DA,.DATA)
 I $$ADD^HLOASUB1(779.91,.DA,.DATA,.ERROR) Q 1
 Q 0
 ;**P147 END CJM
 ;
 ;
 ;
 ;
 ;
 ;
