HLOFILER ;ALB/CJM- Passes messages on the incoming queue to the applications - 10/4/94 1pm ;07/10/2007
 ;;1.6;HEALTH LEVEL SEVEN;**126,131,134,137**;Oct 13, 1995;Build 21
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;GET WORK function for the process running under the Process Manager
GETWORK(QUE) ;
 ;Input:
 ;  QUE - (pass by reference) These subscripts are used:
 ;    ("FROM") - sending facility last obtained
 ;    ("QUEUE") - name of the queue last obtained
 ;Output:
 ;  Function returns 1 if success, 0 if no more work
 ;  QUE-  updated to identify next queu of messages to process.
 ;
 N FROM,QUEUE
 I '$D(QUE("SYSTEM")) D
 .N SYS
 .D SYSPARMS^HLOSITE(.SYS)
 .S QUE("SYSTEM","NORMAL PURGE")=SYS("NORMAL PURGE")
 .S QUE("SYSTEM","ERROR PURGE")=SYS("ERROR PURGE")
 S FROM=$G(QUE("FROM")),QUEUE=$G(QUE("QUEUE"))
 I ($G(FROM)]""),($G(QUEUE)]"") D
 .L -^HLB("QUEUE","IN",FROM,QUEUE)
 .F  S QUEUE=$O(^HLB("QUEUE","IN",FROM,QUEUE)) Q:(QUEUE="")  I '$$STOPPED^HLOQUE("IN",QUEUE) L +^HLB("QUEUE","IN",FROM,QUEUE):0  Q:$T
 I ($G(FROM)]""),($G(QUEUE)="") D
 .F  S FROM=$O(^HLB("QUEUE","IN",FROM)) Q:FROM=""  D  Q:($G(QUEUE)]"")
 ..S QUEUE="" F  S QUEUE=$O(^HLB("QUEUE","IN",FROM,QUEUE)) Q:(QUEUE="")  I '$$STOPPED^HLOQUE("IN",QUEUE) L +^HLB("QUEUE","IN",FROM,QUEUE):0 Q:$T
 I FROM="" D
 .F  S FROM=$O(^HLB("QUEUE","IN",FROM)) Q:FROM=""  D  Q:($G(QUEUE)]"")
 ..S QUEUE="" F  S QUEUE=$O(^HLB("QUEUE","IN",FROM,QUEUE)) Q:(QUEUE="")  I '$$STOPPED^HLOQUE("IN",QUEUE) L +^HLB("QUEUE","IN",FROM,QUEUE):0 Q:$T
 S QUE("FROM")=FROM,QUE("QUEUE")=QUEUE
 Q:(QUEUE]"") 1
 Q 0
 ;
DOWORK(QUEUE) ;sends the messages on the queue
 N $ETRAP,$ESTACK S $ETRAP="G ERROR^HLOFILER"
 ;
 N MSGIEN,DEQUE,QUE
 M QUE=QUEUE
 S DEQUE=0
 S MSGIEN=0
 ;
 F  S MSGIEN=$O(^HLB("QUEUE","IN",QUEUE("FROM"),QUEUE("QUEUE"),MSGIEN)) Q:'MSGIEN  D  M QUEUE=QUE
 .N MCODE,ACTION,QUE,PURGE,ACKTOIEN,NODE
 .N $ETRAP,$ESTACK S $ETRAP="G ERROR2^HLOFILER"
 .S NODE=$G(^HLB("QUEUE","IN",QUEUE("FROM"),QUEUE("QUEUE"),MSGIEN))
 .S ACTION=$P(NODE,"^",1,2)
 .S PURGE=$P(NODE,"^",3)
 .S ACKTOIEN=$P(NODE,"^",4)
 .D DEQUE(MSGIEN,PURGE,ACKTOIEN)
 .I ACTION]"" D
 ..N HLMSGIEN,MCODE,DEQUE,DUZ
 ..N $ETRAP,$ESTACK S $ETRAP="G ERROR3^HLOFILER"
 ..S HLMSGIEN=MSGIEN
 ..S MCODE="D "_ACTION
 ..N MSGIEN,X
 ..D DUZ^XUP(.5)
 ..X MCODE
 ..;kill the apps variables
 ..D
 ...N ZTSK
 ...D KILL^XUSCLEAN
 ;
ENDWORK ;where the execution resumes upon an error
 D DEQUE()
 Q
 ;
DEQUE(MSGIEN,PURGE,ACKTOIEN) ;
 ;Dequeues the message.  Also sets up the purge dt/tm and the completion status.
 S:$G(MSGIEN) DEQUE=$G(DEQUE)+1,DEQUE(MSGIEN)=PURGE_"^"_ACKTOIEN
 I '$G(MSGIEN)!($G(DEQUE)>25) S MSGIEN=0 D
 .F  S MSGIEN=$O(DEQUE(MSGIEN)) Q:'MSGIEN  D
 ..N NODE,PURGE,ACKTOIEN
 ..S NODE=DEQUE(MSGIEN)
 ..S PURGE=$P(NODE,"^"),ACKTOIEN=$P(NODE,"^",2)
 ..D DEQUE^HLOQUE(QUEUE("FROM"),QUEUE("QUEUE"),"IN",MSGIEN)
 ..S NODE=$G(^HLB(MSGIEN,0))
 ..Q:NODE=""
 ..S $P(NODE,"^",19)=1 ;sets the flag to show that the app handoff was done
 ..D:PURGE
 ...N STATUS
 ...S STATUS=$P(NODE,"^",20)
 ...S:STATUS="" $P(NODE,"^",20)="SU",STATUS="SU"
 ...S $P(NODE,"^",9)=$$FMADD^XLFDT($$NOW^XLFDT,,$S(PURGE=2:24*QUEUE("SYSTEM","ERROR PURGE"),$D(^HLB(MSGIEN,3,1,0)):24*QUEUE("SYSTEM","ERROR PURGE"),1:QUEUE("SYSTEM","NORMAL PURGE")))
 ...S ^HLB("AD",$S($E($P(NODE,"^",4))="I":"IN",1:"OUT"),$P(NODE,"^",9),MSGIEN)=""
 ...I ACKTOIEN,$D(^HLB(ACKTOIEN,0)) S $P(^HLB(ACKTOIEN,0),"^",9)=$P(NODE,"^",9),^HLB("AD",$S($E($P(NODE,"^",4))="I":"OUT",1:"IN"),$P(NODE,"^",9),ACKTOIEN)=""
 ..S ^HLB(MSGIEN,0)=NODE
 .K DEQUE S DEQUE=0
 Q
 ;
ERROR ;error trap
 S $ETRAP="Q:$QUIT """" Q"
 N HOUR
 S HOUR=$E($$NOW^XLFDT,1,10)
 S ^TMP("HL7 ERRORS",$J,HOUR,$P($ECODE,",",2))=$G(^TMP("HL7 ERRORS",$J,HOUR,$P($ECODE,",",2)))+1
 ;
 D DEQUE()
 ;
 ;a lot of errors of the same type may indicate an endless loop
 ;return to the Process Manager error trap
 I ($G(^TMP("HL7 ERRORS",$J,HOUR,$P($ECODE,",",2)))>30) Q:$QUIT "" Q
 ;
 ;while debugging quit on all errors - returns to the Process Manager error trap
 I $G(^HLTMP("LOG ALL ERRORS")) Q:$QUIT "" Q
 I $ECODE["EDITED" Q:$QUIT "" Q
 ;
 D ^%ZTER
 D UNWIND^%ZTER
 Q:$QUIT ""
 Q
 ;
ERROR2 ;
 S $ETRAP="Q:$QUIT """" Q"
 ;
 D DEQUE()
 ;
 ;may need to change the status to Error
 D
 .N NODE,RAPP,SAPP,FS,CS,REP,ESCAPE,SUBCOMP,HDR,DIR,NOW
 .S NOW=$$NOW^XLFDT
 .S NODE=$G(^HLB(MSGIEN,0))
 .Q:NODE=""
 .Q:$P(NODE,"^",20)="ER"
 .S $P(NODE,"^",20)="ER",$P(NODE,"^",21)="APPLICATION ROUTINE ERROR"
 .S DIR=$S($E($P(NODE,"^",4))="I":"IN",1:"OUT")
 .I $P(NODE,"^",9) K ^HLB("AD",DIR,$P(NODE,"^",9),MSGIEN)
 .S $P(NODE,"^",9)=$$FMADD^XLFDT(NOW,,24*QUEUE("SYSTEM","ERROR PURGE"))
 .S ^HLB(MSGIEN,0)=NODE
 .S ^HLB("AD",DIR,$P(NODE,"^",9),MSGIEN)=""
 .S HDR=$G(^HLB(MSGIEN,1))
 .S FS=$E(HDR,4)
 .Q:FS=""
 .S CS=$E(HDR,5)
 .S REP=$E(HDR,6)
 .S ESCAPE=$E(HDR,7)
 .S SUBCOMP=$E(HDR,8)
 .S RAPP=$$DESCAPE^HLOPRS1($P($P(HDR,FS,5),CS),FS,CS,SUBCOMP,REP,ESCAPE)
 .I RAPP="" S RAPP="UNKNOWN"
 .S SAPP=$$DESCAPE^HLOPRS1($P($P(HDR,FS,3),CS),FS,CS,SUBCOMP,REP,ESCAPE)
 .S ^HLB("ERRORS",RAPP,NOW,MSGIEN)=""
 .D COUNT^HLOESTAT(DIR,RAPP,SAPP,"UNKNOWN")
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
 S $ECODE=""
 ;
 Q:$QUIT ""
 Q
ERROR3 ;error trap for application context
 S $ETRAP="Q:$QUIT """" Q"
 D ^%ZTER
 S $ECODE=",UAPPLICATION ERROR,"
 ;
 ;drop to the ERROR2 error handler
 Q:$QUIT ""
 Q
