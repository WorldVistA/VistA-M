HLOFILER ;ALB/CJM- Passes messages on the incoming queue to the applications - 10/4/94 1pm ;03/12/2012
 ;;1.6;HEALTH LEVEL SEVEN;**126,131,134,137,152,158**;Oct 13, 1995;Build 14
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
DOWORK(QUEUE) ;passes the messages on the queue to the application
 N $ETRAP,$ESTACK S $ETRAP="G ERROR^HLOFILER"
 ;
 N MSGIEN,DEQUE,QUE,COUNT
 M QUE=QUEUE
 S (DEQUE,COUNT)=0
 S MSGIEN=0
 ;
 F  S MSGIEN=$O(^HLB("QUEUE","IN",QUEUE("FROM"),QUEUE("QUEUE"),MSGIEN)) Q:'MSGIEN  S COUNT=COUNT+1 Q:COUNT>1000  D  M QUEUE=QUE
 .N MCODE,ACTION,QUE,PURGE,ORIG,NODE,COUNT
 .N $ETRAP,$ESTACK S $ETRAP="G ERROR2^HLOFILER"
 .S NODE=$G(^HLB("QUEUE","IN",QUEUE("FROM"),QUEUE("QUEUE"),MSGIEN))
 .S ACTION=$P(NODE,"^",1,2)
 .S PURGE=$P(NODE,"^",3)
 .S ORIG("IEN")=$P(NODE,"^",4),ORIG("ACK BY")=$P(NODE,"^",5),ORIG("STATUS")=$P(NODE,"^",6)
 .D DEQUE(MSGIEN,PURGE,.ORIG)
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
DEQUE(MSGIEN,PURGE,ORIG) ;
 ;Dequeues the message.  Also sets up the purge indicator and the completion status.
 S:$G(MSGIEN) DEQUE=$G(DEQUE)+1,DEQUE(MSGIEN)=PURGE_"^"_ORIG("IEN")_"^"_ORIG("ACK BY")_"^"_ORIG("STATUS")
 I '$G(MSGIEN)!($G(DEQUE)>25) S MSGIEN=0 D
 .F  S MSGIEN=$O(DEQUE(MSGIEN)) Q:'MSGIEN  D
 ..N NODE,PURGE,ORIG
 ..S NODE=DEQUE(MSGIEN)
 ..S PURGE=$P(NODE,"^"),ORIG("IEN")=$P(NODE,"^",2),ORIG("ACK BY")=$P(NODE,"^",3),ORIG("STATUS")=$P(NODE,"^",4)
 ..D DEQUE^HLOQUE(QUEUE("FROM"),QUEUE("QUEUE"),"IN",MSGIEN)
 ..S $P(^HLB(MSGIEN,0),"^",19)=1 ;sets the flag to show that the app handoff was done
 ..;
 ..;update original message
 ..I ORIG("IEN"),$D(^HLB(ORIG("IEN"),0)) D
 ...S:$L(ORIG("ACK BY")) $P(^HLB(ORIG("IEN"),0),"^",7)=ORIG("ACK BY"),$P(^HLB(ORIG("IEN"),0),"^",18)=1
 ...S:$L(ORIG("STATUS")) $P(^HLB(ORIG("IEN"),0),"^",20)=ORIG("STATUS")
 ..;
ZB2 ..D:PURGE
 ...N STATUS
 ...S STATUS=$P(^HLB(MSGIEN,0),"^",20)
 ...S:STATUS="" $P(^HLB(MSGIEN,0),"^",20)="SU",STATUS="SU"
 ...D SETPURGE^HLOF778A(MSGIEN,STATUS,ORIG("IEN"),ORIG("STATUS"))
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
 .N NODE,RAPP,SAPP,FS,CS,REP,ESCAPE,SUBCOMP,HDR,DIR,NOW,SYS
 .D SYSPARMS^HLOSITE(.SYS)
 .S NOW=$$NOW^XLFDT
 .S NODE=$G(^HLB(MSGIEN,0))
 .Q:NODE=""
 .Q:$P(NODE,"^",20)="ER"
 .S $P(NODE,"^",20)="ER",$P(NODE,"^",21)="APPLICATION ROUTINE ERROR"
 .S DIR=$S($E($P(NODE,"^",4))="I":"IN",1:"OUT")
 .I $P(NODE,"^",9) K ^HLB("AD",DIR,$P(NODE,"^",9),MSGIEN)
 .S $P(NODE,"^",9)=$$FMADD^XLFDT(NOW,SYS("ERROR PURGE"))
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
 ;
 ;
 ;
 ;
 ;
