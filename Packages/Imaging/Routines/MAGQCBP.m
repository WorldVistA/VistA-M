MAGQCBP ;WOIFO/RP - Background Processor Queue Processor Monitor ; 18 Jan 2011 5:25 PM
 ;;3.0;IMAGING;**39**;Mar 19, 2002;Build 2010;Mar 08, 2011
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ; This Code evaluates whether the last queue processed or the queuing of the next queue is the later event
 ; So if and only if there is a queue waiting to be processed and that queue has been clear to be processed
 ; for a period of 15 minutes then and only then would a message event be triggered (See message event BPMSG)
CBP(MIN) ;Entry point for job to check the BP queue processing activity
 ; I Suggest 15 minutes as a reasonably sensitive value; value is site configurable
 ; An additional alert has been added for failed queues over 1K
 N DATA,FQLIM,LASTDT,LQP,NQ,NQP,QU,SPAN,PL,WS,WSNAME
 ;Variable  MAGEVAL, MAGMIN & FQLIM are site configurable when scheduling the task.
 S FQLIM=$S(+$G(MAGFQ)>0:MAGFQ,1:1000) ;T23 was setting to 1k if MAGFQ was less than 1k
 S MIN=$S(+$G(MAGMIN)>0:MAGMIN,1:+$G(MIN))
 S MAGEVAL=$S(+$G(MAGEVAL)>0:MAGEVAL,1:10000) ;this variable will be used for reviewing EVAL queues
 S U="^",PL=0
 F  S PL=$O(^MAG(2006.1,PL)) Q:'PL  D
 . S WS=0,WSNAME=""
 . F  S WSNAME=$O(^MAG(2006.8,"C",PL,WSNAME)) Q:WSNAME=""  D
 . . S WS=$O(^MAG(2006.8,"C",PL,WSNAME,"")) Q:'WS
 . . ; quit if this bp has not been active today - removed because we only report on active BP Servers
 . . ;Q:$P($P($G(^MAG(2006.8,WS,1)),U,5),"@",1)'=$P($$FMTE^XLFDT($$NOW^XLFDT),"@",1)
 . . S NQP=$$NQP(WS,PL,.NQ),RETURN=0
 . . I NQP>0 D
 . . . Q:WSNAME="Unassigned Tasks"
 . . . S LQP=$$LQP(WS,PL)
 . . . S SPAN=$S(LQP>NQP:LQP,1:NQP)
 . . . D CNT(NQ,PL,.RETURN) ; get counts for message.
 . . . I $$NOW^XLFDT>$$FMADD^XLFDT(SPAN,"","",MIN,"") D BPMSG(PL,WSNAME,MIN,NQ,LQP,NQP,RETURN)
 . . . Q
 . . Q
 . D:+PL FAILQ(PL,FQLIM)
 . D:+PL EVALQ(PL,MAGEVAL)
 . D:+PL CAUTO(PL) ; check for scheduled Purge and Verifier
 . D:+PL CISU(PL)  ; check for active Imaging Site Usage task 
 . Q
 K MAGEVAL,MAGMIN,MAGFQ   ;Variables passed from scheduled task
 Q
LQP(WS,PLACE) ; Returns the date and time of the Last Queue Processed by this BP Server
 N LDATE,QI,QP,TDATE,ZNODE,QUE,QSTR
 S QSTR="^^^^^^^^^^^^ABSTRACT^JUKEBOX^JBTOHD^PREFET^IMPORT^GCC^^^^^DELETE^"
 S ZNODE=$G(^MAG(2006.8,WS,0))
 S LDATE=0
 ;Priority:  JBTOHD, PREFET, ABSTRACT, IMPORT JUKEBOX, DELETE and GCC
 F QI=15,16,13,17,14,23,18 D:$P(ZNODE,U,QI)
 . S QUE=$P(QSTR,U,QI)
 . S QP=$O(^MAGQUEUE(2006.031,"C",PLACE,QUE,"")) Q:'QP
 . S TDATE=$P($G(^MAGQUEUE(2006.031,QP,0)),U,6)
 . I TDATE>LDATE S LDATE=TDATE
 . Q
 Q LDATE
NQP(WS,PLACE,NQ) ; Returns the date and time that the next queue to be processed by this BP Server was queued
 N LDATE,QCNT,QI,QP,TDATE,ZNODE,QUEIEN
 S QSTR="^^^^^^^^^^^^ABSTRACT^JUKEBOX^JBTOHD^PREFET^IMPORT^GCC^^^^^DELETE^"
 S ZNODE=$G(^MAG(2006.8,WS,0))
 S TDATE=0
 ;Priority:  JBTOHD, PREFET, ABSTRACT, IMPORT JUKEBOX, DELETE and GCC
 F QI=15,16,13,17,14,23,18 Q:'QI  I $P(ZNODE,U,QI) D  Q:TDATE>0
 . S NQ=$P(QSTR,U,QI)
 . S QP=$O(^MAGQUEUE(2006.031,"C",PLACE,NQ,"")) Q:'QP
 . Q:'+$P(^MAGQUEUE(2006.031,QP,0),U,3)  ; Queue count - no entries 
 . I +$P(^MAGQUEUE(2006.031,QP,0),U,3) D   ;Queue count
 . . S QUEIEN=$P($G(^MAGQUEUE(2006.031,QP,0)),U,2)
 . . S TDATE=$P($G(^MAGQUEUE(2006.03,QP,0)),U,4)
 . . I '+TDATE S TDATE=$$NQENTRY(NQ,PLACE)
 . . ;above line is needed - if queien value doesn't exist in the 2006.03
 . . ;then get the next entry using x-ref "D","NOT_Processed" for queue type.
 . Q
 Q TDATE
BPMSG(PLACE,WS,MIN,NQ,LASTDT,NQDATE,DATA) ;
 N MSG,TMP
 S MSG="VistA Imaging BP Server, "_WS_", has failed to process"
 D DFNIQ^MAGQBPG1("",MSG,0,PLACE,"MAGQCBP")
 S MSG="a "_NQ_" queue within "_MIN_" minutes."
 D DFNIQ^MAGQBPG1("",MSG,0,PLACE,"MAGQCBP")
 S MSG="The last date/time a queue was processed was on: "_$$FMTE^XLFDT(LASTDT,1)
 D DFNIQ^MAGQBPG1("",MSG,0,PLACE,"MAGQCBP")
 S MSG="The next queue to process was created on: "_$$FMTE^XLFDT(NQDATE,1)
 D DFNIQ^MAGQBPG1("",MSG,0,PLACE,"MAGQCBP")
 S MSG="Total "_NQ_" queues is: "_$P(DATA,U,2)_"."
 D DFNIQ^MAGQBPG1("",MSG,0,PLACE,"MAGQCBP")
 S TMP=$P(^DIC(4,$O(^DIC(4,"D",$P($G(^MAG(2006.1,PLACE,0)),U,1),"")),0),U,1)
 S MSG="This BP Queue processor was supporting the VI implementation serving: "_TMP_"."
 D DFNIQ^MAGQBPG1("",MSG,0,PLACE,"MAGQCBP")
 S MSG="VI_BP_Queue_Processor_failure"
 D DFNIQ^MAGQBPG1("",MSG,1,PLACE,"MAGQCBP")
 Q
BMSGF(PLACE,WS,NQ,DATA) ;
 N MSG,TMP
 ;DATA=FAILQUECNT_U_QUEUE CNT_U_TOTAL QUE TYPE
 S MSG="VistA Imaging BP Server "_WS_" has "_NQ_" failed queues ("_$P(DATA,U)_")."
 D DFNIQ^MAGQBPG1("",MSG,0,PLACE,"MAGQCBP")
 S MSG="Please review this BP server activity."
 D DFNIQ^MAGQBPG1("",MSG,0,PLACE,"MAGQCBP")
 S MSG="The last date/time this queue was processed was on: "_$$FMTE^XLFDT($P(DATA,U,4))_"."
 D DFNIQ^MAGQBPG1("",MSG,0,PLACE,"MAGQCBP")
 S TMP=$P(^DIC(4,$O(^DIC(4,"D",$P($G(^MAG(2006.1,PLACE,0)),U,1),"")),0),U,1)
 S MSG="This BP Queue processor was supporting the VI implementation serving: "_TMP
 D DFNIQ^MAGQBPG1("",MSG,0,PLACE,"MAGQCBP")
 S MSG="VI_BP_Queue_Processor_failure"
 D DFNIQ^MAGQBPG1("",MSG,1,PLACE,"MAGQCBP")
 Q
CAUTO(PLACE) ;
 N ASSIGN,BPPURGE,BPTIME,BPVER,MSG,NODE5,TMP,AUTO
 S BPPURGE=$G(^MAG(2006.1,PLACE,"BPPURGE")),BPTIME=0
 S ASSIGN=$$GTASK(PLACE,3),ASSIGN=$S(ASSIGN["is not currently assigned":0,1:1)
 ; ASSIGN is a flag whether the AUTO PURGE task has been assigned to a BP Server. 
 I +$P(BPPURGE,U,6),+ASSIGN D  ; If Scheduled is ON (#62.5) and assigned to a BP Server.
 . ; Add 20 min to schedule time to compensate the BP to perform MAGQ FS CHNGE.
 . S BPTIME=$P(BPPURGE,U,10)_"."_$P(BPPURGE,U,11) Q:'+BPTIME  S BPTIME=$$FMADD^XLFDT(BPTIME,"","",21)
 . Q:($$NOW^XLFDT)<BPTIME
 . ;DATE OF SCHEDULED PURGE (#61.3) & SCHEDULED PURGE TIME (#61.4) of SITE PARAMETERS (2006.1)
 . I ($$NOW^XLFDT)>BPTIME D  ;2006.1 
 . . Q:($P(BPPURGE,U,7)=$P(BPPURGE,U,10))    ; DATE OF LAST PURGE (#61.1) & DATE OF SCHEDULED PURGE (#61.3) of SITE PARAMETERS 2006.1 - Purge active
 . . S TMP=$P(^DIC(4,$O(^DIC(4,"D",$P($G(^MAG(2006.1,PLACE,0)),U,1),"")),0),U,1)
 . . S MSG="The "_TMP_" implementation of VistA Imaging has failed to start the schedule Purge activity!"
 . . D DFNIQ^MAGQBPG1("",MSG,0,PLACE,"MAGQCBP")
 . . S MSG="The task is currently assigned to BP Server: "_$$GTASK(PLACE,3)  ;AUTO PURGE is assigned to BP Server field #3
 . . D DFNIQ^MAGQBPG1("",MSG,0,PLACE,"MAGQCBP")
 . . S MSG="Scheduled_Purge_failure"
 . . D DFNIQ^MAGQBPG1("",MSG,1,PLACE,"MAGQCBP") ; Send
 . . Q
 . Q
 S BPVER=$G(^MAG(2006.1,PLACE,"BPVERIFIER")),BPTIME=0
 S ASSIGN=$$GTASK(PLACE,4),ASSIGN=$S(ASSIGN["is not currently assigned":0,1:1)
 I $P(BPVER,U,1),+ASSIGN D    ; If Scheduled Verifier is ON (#62) and assigned to a BP Server ;
 . ; DATE OF SCHEDULED VERIFY (#62.3) & SCHEDULED VERIFIER TIME (62.4) of SITE PARAMETERS 2006.1
 . ; Add 20 min to schedule time to compensate the BP to perform MAGQ FS CHNGE.
 . S BPTIME=($P(BPVER,U,4)_"."_$P(BPVER,U,5)) Q:'+BPTIME  S BPTIME=$$FMADD^XLFDT(BPTIME,"","",21)
 . Q:($$NOW^XLFDT)<BPTIME
 . I ($$NOW^XLFDT)>BPTIME D
 . . ;Quit if the verifier has already processed.
 . . Q:($P(BPVER,U,2)=$P(BPVER,U,4))  ; DATE OF LAST VERIFY (#62.1) & DATE OF SCHEDULED VERIFY (#62.3) - Verifier is active
 . . S TMP=$P(^DIC(4,$O(^DIC(4,"D",$P($G(^MAG(2006.1,PLACE,0)),U,1),"")),0),U,1)
 . . S MSG="The "_TMP_" implementation of VistA Imaging has failed to start the schedule Verifier activity!"
 . . D DFNIQ^MAGQBPG1("",MSG,0,PLACE,"MAGQCBP")
 . . S MSG="The task is currently assigned to BP Server: "_$$GTASK(PLACE,4)  ;AUTO VERIFY is assigned to BP Server field #3
 . . D DFNIQ^MAGQBPG1("",MSG,0,PLACE,"MAGQCBP")
 . . S MSG="Scheduled_Verifier_failure"
 . . D DFNIQ^MAGQBPG1("",MSG,1,PLACE,"MAGQCBP") ; Send
 . . Q
 . Q
 Q
GTASK(PLACE,TASK) ;
 ;AUTO PURGE(3), AUTO VERIFY(4), ABSTRACT(12), JUKEBOX(13), JBTOHD(14), PREFET(15), IMPORT(16), GCC(17), DELETE(20) 
 N MAGFLD,IEN,WS,ASSIGNED,WSIEN
 S ASSIGNED=0
 D FIELD^DID(2006.8,TASK,"","LABEL","MAGFLD")
 S WS="" F  S WS=$O(^MAG(2006.8,"C",PLACE,WS)) Q:WS=""  D  Q:ASSIGNED
 . Q:($$UPPER^MAGQE4(WS)="UNASSIGNED TASKS")
 . S WSIEN=$O(^MAG(2006.8,"C",PLACE,WS,""))
 . S ASSIGNED=+$$GET1^DIQ(2006.8,WSIEN_",",TASK,"I","","")
 . Q
 I 'ASSIGNED Q $G(MAGFLD("LABEL"))_" is not currently assigned"
 Q WS
CISU(PLACE) ;
 N ZTSK,ACTIVE,MESSAGE
 Q:'+PLACE
 S ACTIVE=0,MESSAGE="Unknown"
 S ZTSK=$$GET1^DIQ(2006.1,PLACE_",",10,"I","","")
 I ZTSK D
 . D STAT^%ZTLOAD ; IA#10063
 . I ZTSK(0)=1,ZTSK(1)<3 S ACTIVE=1
 . S MESSAGE=ZTSK(2)
 . I $$UPPER^MAGQE4(MESSAGE)="UNDEFINED" S MESSAGE="Task is undefined"
 . Q
 Q:+ACTIVE
 ;else START A NEW TASK,SEND A MESSAGE
 D STTASK^MAGQE4
 D DFNIQ^MAGQBPG1("","The inactive monthly Imaging Site Usage report task was restarted",0,PLACE,"MAGQCBP")
 D DFNIQ^MAGQBPG1("","The problem was: "_MESSAGE,0,PLACE,"MAGQCBP")
 D DFNIQ^MAGQBPG1("","Site_report_task_was_restarted",1,PLACE,"MAGQCBP") ; Send
 K ZTSK
 Q
CNT(QUE,PL,RET) ; Return the number of failed queues, queue pointer, queue type total count and last date processed.
 ; failed queues= queue count - total queue type count.
 ;^MAGQUEUE(2006.031,D0,0)= (#.01) QUEUE NAME [1F] ^ (#1) QUEUE POINTER
 ;                     ==>[2P:2006.03] ^ (#2) QUEUE COUNT [3N] ^ (#.04) PLACE
 ;                     ==>[4P:2006.1] ^ (#3) QUEUE TYPE TOTAL [5N] ^ (#4)
 ;                     ==>LAST_QUEUE_PROCESSED_DATE_TIME [6D] ^
 N QP,FAIL,QTOTAL,QCNT S RET=0
 Q:QUE=""!('PL)
 Q:'$D(^MAGQUEUE(2006.031,"C",PL,QUE))
 S QP=$O(^MAGQUEUE(2006.031,"C",PL,QUE,"")) Q:'QP!'$D(^MAGQUEUE(2006.031,QP))
 S QCNT=$P($G(^MAGQUEUE(2006.031,+QP,0)),U,3),QTOTAL=$P($G(^MAGQUEUE(2006.031,+QP,0)),U,5)
 S FAIL=(+QTOTAL)-(+QCNT),RET=FAIL_U_QCNT_U_QTOTAL_U_$P($G(^MAGQUEUE(2006.031,+QP,0)),U,6)
 Q
NQENTRY(NQ,PLACE) ;
 ;Get the date the queue entry was entered into 2006.03 file.
 N I
 Q:NQ=""!'PLACE
 S I=$O(^MAGQUEUE(2006.03,"D",PLACE,NQ,"NOT_PROCESSED",""))
 I +I,$D(^MAGQUEUE(2006.03,I,0)) Q $P(^MAGQUEUE(2006.03,I,0),U,4)
 Q 0
FAILQ(PLACE,FQLIM) ;
 N QU,RETURN,FAILQ,BPSERV
 F QU="JUKEBOX","ABSTRACT","IMPORT","JBTOHD","DELETE","GCC" D
 . D CNT(QU,PLACE,.RETURN)
 . S FAILQ=$S(+$P(RETURN,U)>+FQLIM:1,1:0),BPSERV="("_$$GTASK(PLACE,QU)_")"
 . ;send msg if failed queues are greater then specified value.
 . D:+FAILQ BMSGF(PLACE,BPSERV,QU,RETURN)
 . Q
EVALQ(PL,QLIM) ;
 N RETURN,MSG
 D CNT("EVAL",PL,.RETURN)
 S QCNT=$P(RETURN,U,2)
 Q:QCNT'>QLIM
 S MSG="The total number of EVAL queues is "_QCNT_".  Please review the DICOM Gateways"
 D DFNIQ^MAGQBPG1("",MSG,0,PL,"MAGQCBP")
 S MSG="to ensure Routing is appropriately setup with the correct destination."
 D DFNIQ^MAGQBPG1("",MSG,0,PL,"MAGQCBP")
 S MSG="If your site is not using DICOM Gateway for Routing then review "
 D DFNIQ^MAGQBPG1("",MSG,0,PL,"MAGQCBP")
 S MSG="the Imaging DICOM Gateway Installation Guide, Section 4.3."
 D DFNIQ^MAGQBPG1("",MSG,0,PL,"MAGQCBP"),BLNKLN
 S MSG="On-Demand Routing will not generate EVAL queues, if your site is doing"
 D DFNIQ^MAGQBPG1("",MSG,0,PL,"MAGQCBP")
 S MSG="only On-Demand Routing then the DICOM Gateway parameters are set incorrectly."
 D DFNIQ^MAGQBPG1("",MSG,0,PL,"MAGQCBP"),BLNKLN
 S MSG="Check the following DICOM parameters on all your Gateways:"
 D DFNIQ^MAGQBPG1("",MSG,0,PL,"MAGQCBP")
 S MSG="(On-Demand routing does not require these parameters to be set.)"
 D DFNIQ^MAGQBPG1("",MSG,0,PL,"MAGQCBP"),BLNKLN
 S MSG="Will this computer be a Routing Processor? // NO "
 D DFNIQ^MAGQBPG1("",MSG,0,PL,"MAGQCBP")
 S MSG="Will this computer be part of a system where 'autorouting' is active? // NO "
 D DFNIQ^MAGQBPG1("",MSG,0,PL,"MAGQCBP")
 S MSG="VI_BP_Eval_Queue"
 D DFNIQ^MAGQBPG1("",MSG,1,PL,"MAGQCBP")
 Q
BLNKLN ;
 S MSG="               "
 D DFNIQ^MAGQBPG1("",MSG,0,PL,"MAGQCBP")
 Q
