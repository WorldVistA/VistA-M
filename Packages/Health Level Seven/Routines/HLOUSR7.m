HLOUSR7 ;OIFO-ALB/CJM - Deleting HLO queues ;03/26/2012
 ;;1.6;HEALTH LEVEL SEVEN;**147,153,158**;Oct 13, 1995;Build 14
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
SPURGE ; Entry point from ListManager for deleting sequential queues.
 N CONF,LINK,QUE,PORT,WHEN,COUNT,IEN
 S VALMBCK="R"
 D OWNSKEY^XUSRB(.CONF,"HLOMGR",DUZ)
 I CONF(0)'=1 D  Q
 . W !,"**** You are not authorized to use this option ****" D PAUSE^VALM1 Q
 S QUE=$$GETQ^HLOUSR4()
 Q:QUE=""
 I '$D(^HLB("QUEUE","SEQUENCE",QUE)) W !,"There are no messages on that queue!" D PAUSE^VALM1 Q
 W !!,"Deleting a queue in error will result in lost messages!"
 Q:'$$ASKYESNO^HLOUSR2("Are you SURE you want to delete that queue","NO")
 W !!,"After removing the messages from the sequence queue they will deleted"
 W !,"When do you want to schedule the messages to be purged?"
 S WHEN=$$ASKWHEN($$FMADD^XLFDT($$NOW^XLFDT,7),"Date/Time to schedule purge:")
 Q:'WHEN
 S (IEN,COUNT)=0
 F  S IEN=$O(^HLB("QUEUE","SEQUENCE",QUE,IEN)) Q:'IEN  S COUNT=COUNT+1 Q:COUNT>100
 I COUNT>100,$$ASKTASK() D
 .S ZTRTN="SEQPURGE^HLOUSR7"
 .S ZTDESC="HLO QUEUE PURGE"
 .S ZTDTH=$H
 .S ZTIO=""
 .S ZTSAVE("QUE")=QUE,ZTSAVE("WHEN")=""
 .D ^%ZTLOAD
 .I '$G(ZTSK) W !!,?5,"UNABLE TO SCHEDULE PURGE JOB",!
 .I $G(ZTSK) W !!,?5,"Purge job is scheduled, task #"_ZTSK
 .D PAUSE^VALM1
 E  D
 .D SEQPURGE
 .I $L(HLRFRSH) D @HLRFRSH
 Q
 ;
OPURGE ; Entry point from ListManager for deleting outgoing queues.
 N CONF,LINK,QUE,PORT,WHEN,COUNT,IEN
 S VALMBCK="R"
 D OWNSKEY^XUSRB(.CONF,"HLOMGR",DUZ)
 I CONF(0)'=1 D  Q
 . W !,"**** You are not authorized to use this option ****" D PAUSE^VALM1 Q
 S LINK=$$ASKLINK^HLOUSR
 Q:LINK=""
 W !
 S PORT=$$ASKPORT^HLOTRACE(LINK)
 I 'PORT W !,"There are no outgoing messages for that destination!" Q
 S LINK=LINK_":"_PORT
 W !
 S QUE=$$ASKQUE^HLOTRACE(LINK)
 I QUE=""  W !,"There are no outgoing messages for that destination!" Q
 W !!,"Deleting a queue in error will result in lost messages!"
 Q:'$$ASKYESNO^HLOUSR2("Are you SURE you want to delete that queue","NO")
 W !!,"After removing the messages from the outgoing queue they will deleted"
 W !,"When do you want to schedule the messages to be purged?"
 S WHEN=$$ASKWHEN($$FMADD^XLFDT($$NOW^XLFDT,7),"Date/Time to schedule purge:")
 Q:'WHEN
 S (IEN,COUNT)=0
 F  S IEN=$O(^HLB("QUEUE","OUT",LINK,QUE,IEN)) Q:'IEN  S COUNT=COUNT+1 Q:COUNT>100
 I COUNT>100,$$ASKTASK() D
 .S ZTRTN="OUTPURGE^HLOUSR7"
 .S ZTDESC="HLO QUEUE PURGE"
 .S ZTDTH=$H
 .S ZTIO=""
 .S ZTSAVE("LINK")="",ZTSAVE("QUE")=QUE,ZTSAVE("WHEN")=""
 .D ^%ZTLOAD
 .I '$G(ZTSK) W !!,?5,"UNABLE TO SCHEDULE PURGE JOB",!
 .I $G(ZTSK) W !!,?5,"Purge job is scheduled, task #"_ZTSK
 .D PAUSE^VALM1
 E  D
 .D OUTPURGE
 .D OUTQUE^HLOUSR6
 Q
 ;
ASKTASK() ;
 W !!,"There are a lot of messages pending on that queue!"
 Q $$ASKYESNO^HLOUSR2("Would you like to delete the queue in the background via a separate task","YES")
 ;
  ;
ASKWHEN(DEFAULT,PROMPT)       ;
 ;Description: Asks the user to enter a dt/tm.
 ;Input: DEFAULT - the suggested default dt/time (optional, defaults to NOW)
 ;PROMPT - optional prompt
 ;Output: Returns the date as the function value, or 0 if the user does not select a date
 ;
 ;
 N %DT
 S %DT="AEST"
 S:$L($G(PROMPT)) %DT("A")=PROMPT
 S %DT("B")=$$FMTE^XLFDT($S($L($G(DEFAULT)):DEFAULT,1:"NOW"))
 S %DT(0)="NOW"
 Q:$D(DTOUT) 0
 D ^%DT
 I Y=-1 Q 0
 Q Y
OUTPURGE ;Purge outgoing queue
 N MSG,CNT
 N MSG
 S (CNT,MSG)=0
 I '$D(ZTQUEUED) W !,"Removing messages....",!
 F  S MSG=$O(^HLB("QUEUE","OUT",LINK,QUE,MSG)) Q:'MSG  D
 .S CNT=CNT+1
 .I '(CNT#100),'$D(ZTQUEUED) W "."
 .I '(CNT#70000),'$D(ZTQUEUED) W "!"
 .D DEQUE^HLOQUE(LINK,QUE,"OUT",MSG)
 .I $$SETPURGE(MSG,WHEN) S $P(^HLB(MSG,0),"^",21)="MESSAGE GENERATED IN ERROR AND NOT TRANSMITTED"
 Q
 ;
SEQPURGE ;Purge sequence queue
 N MSG,CNT
 S (CNT,MSG)=0
 I '$D(ZTQUEUED) W !,"Removing messages....",!
 F  S MSG=$O(^HLB("QUEUE","SEQUENCE",QUE,MSG)) Q:'MSG  D
 .S CNT=CNT+1
 .I '(CNT#100),'$D(ZTQUEUED) W "."
 .I '(CNT#70000),'$D(ZTQUEUED) W "!"
 .K ^HLB("QUEUE","SEQUENCE",QUE,MSG)
 .I $$SETPURGE(MSG,WHEN) S $P(^HLB(MSG,0),"^",21)="MESSAGE GENERATED IN ERROR AND NOT TRANSMITTED"
 I $$INC^HLOSITE($NA(^HLC("QUEUECOUNT","SEQUENCE")),-$G(^HLC("QUEUECOUNT","SEQUENCE",QUE)))
 S ^HLC("QUEUECOUNT","SEQUENCE",QUE)=0
 S ^HLB("QUEUE","SEQUENCE",QUE)=""
 Q
 ;
SETPURGE(MSGIEN,TIME) ;  Set message up for purging.
 ;Resets the purge date/time.
 ;Input:
 ;   MSGIEN (required) ien of the message, file #778
 ;   TIME (optional) dt/time to set the purge time to, defaults to NOW
 ;Output:
 ;   Function returns 1 on success, 0 on failure
 ;   
 N NODE,OLDTIME,HLDIR
 Q:'$G(MSGIEN) 0
 S NODE=$G(^HLB(MSGIEN,0))
 Q:NODE="" 0
 S OLDTIME=$P(NODE,"^",9)
 S:'$G(TIME) TIME=$$NOW^XLFDT
 S HLDIR=$S($E($P(NODE,"^",4))="I":"IN",1:"OUT")
 K:OLDTIME ^HLB("AD",HLDIR,OLDTIME,MSGIEN)
 S $P(^HLB(MSGIEN,0),"^",9)=TIME
 S ^HLB("AD",HLDIR,TIME,MSGIEN)=""
 Q 1
