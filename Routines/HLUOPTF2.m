HLUOPTF2 ;ALB/CJM-HL7 -Fast Purge ;02/04/2004
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
FAST1 ;entry point for FAST PURGE 1, called by the Event Monitor
 I '$$COUNT D PURGE
 Q
FAST2 ;entry point for FAST PURGE 2, called by the Event Monitor
 I $$COUNT=1 D PURGE
 Q
 ;
START ;Interactive entry point, asks user whether or not to queue the Fast Purge
 ;
 N ASK,STOP
 S STOP=1
 S ASK=$$ASKYESNO^HLEMU("Do you want to queue the Fast Purge so that it operates in the background","YES")
 I ASK D
 .N ZTRTN,ZTDESC,ZTSAVE,ZTIO,ZTSK
 .S ZTRTN="PURGE^HLUOPTF2"
 .S ZTDESC="HL7 FAST PURGE UTILITY"
 .S ZTIO=""
 .S ZTSAVE("STOP")=1
 .D ^%ZTLOAD
 .W !,$S($D(ZTSK):"HL7 FAST PURGE UTILITY QUEUED, TASK="_ZTSK,1:"REQUEST CANCELLED")
 E  I ASK=0 D
 .W !,"Starting Fast Purge....",!
 .D PURGE
 K ^TMP("HLEVFLAG",$J)
 Q
STOP ;
 ;entry point to ask the Fast Purge Job to stop
 I $$COUNT>$G(^XTMP("HL7 FAST PURGE JOBS","STOP")),$$I^HLEMU($NA(^XTMP("HL7 FAST PURGE JOBS","STOP")),1)
 Q
COUNT() ;
 ;returns the number of Fast Purge Jobs that are running
 N COUNT,I
 S COUNT=0
 F I=1:1:20 D
 .L ^XTMP("HL7 FAST PURGE JOBS",I):0
 .I '$T D
 ..S COUNT=COUNT+1
 .E  D
 ..L -^XTMP("HL7 FAST PURGE JOBS",I)
 Q COUNT
 ;
PURGE ;entry point for the FAST PURGE
 ;
 ;Variables:
 ;  CHECKAT - next time to check in with TaskMan, Job Monitor, andEvent Logging, set every 10 minutes
 ;  HOUR - the date and time to 1 hour precision that this process is currently purging, each hour is locked before purging
 ; IEN772 - entry in file 772 identified for purging
 ; IEN773 - entry in file 773 identified for purging
 ; LASTCHK - a simple count, the time is checked everytime this count reaches 500 - for efficiency, do not want to check the time after purging every entry
 ; CNT773 - count to report for EVENT LOGGING of entries purged (file 773)
 ; CNT772 - count to report for EVENT LOGGING of entries purged (file 772)
 ; QUIT - set to 1 when signaled to stop via TaskMan
 ; TIME - time currently being processed on the AI x-ref, file 773
 ; 
 ;
 I $G(STOP)=1 D
 .;setting this flag allows the job to run outside of Process Monitorng
 .S ^TMP("HLEVFLAG",$J)="STOP"
 ;
 N LCNT,CNT773,CNT772,HOUR,LASTCHK,TIME,IEN772,IEN773,CHECKAT,QUIT,VAR,I
 S (TIME,HOUR,CNT773,CNT772,LCOUNT,QUIT)=0
 ;
 D START^HLEVAPI(.VAR)
 ;
 S CHECKAT=$$FMADD^XLFDT($$NOW^XLFDT,,,10)
 ; 
 ;let everyone know that there is 1 more purge job running - maximum of 20 Fast Purges running at once
 F I=1:1:20 L ^XTMP("HL7 FAST PURGE JOBS",I):0 Q:$T
 ;
 ;loop until signaled to stop or there is no work for a while
 I $T F  D  Q:QUIT
 .S:'TIME HOUR=$$FINDHOUR(HOUR) S:HOUR TIME=HOUR-.00000001
 .;
 .;wasn't able to get an hour to lock
 .I 'HOUR D  Q
 ..;
 ..;if there has been no work for a while then quit
 ..I $$NOW^XLFDT>CHECKAT,CNT773<2000 D
 ...S QUIT=$$CHECKIN(.CHECKAT,.CNT773,.CNT772,.LCOUNT)
 ...S QUIT=1
 ..E  D
 ...S QUIT=$$CHECKIN(.CHECKAT,.CNT773,.CNT772,.LCOUNT)
 ...D EVENT(.CNT773,.CNT772)
 ...Q:QUIT
 ...D PAUSE
 .;
 .;at this point, an hour has been locked, so delete all the entries for that hour
 .F  S TIME=$O(^HLMA("AI",TIME)) D  Q:'TIME  Q:QUIT
 ..I ('TIME)!($E(TIME,1,10)>HOUR) S TIME=0 Q
 ..S LCOUNT=LCOUNT+1
 ..I LCOUNT>500 S QUIT=$$CHECKIN(.CHECKAT,.CNT773,.CNT772,.LCOUNT) Q:QUIT
 ..S (IEN772,IEN773)=0
 ..F  S IEN773=$O(^HLMA("AI",TIME,773,IEN773)) Q:'IEN773  D
 ...S CNT773=CNT773+1
 ...D DEL773^HLUOPT3(IEN773)
 ...;
 ..F  S IEN772=$O(^HLMA("AI",TIME,772,IEN772)) Q:'IEN772  D
 ...S CNT772=CNT772+1
 ...D DEL772^HLUOPT3(IEN772)
 ..;
 ..; make sure that no more records are on this x-ref for that time - could only happen in the case of corruption of some sort
 ..K ^HLMA("AI",TIME)
 ;
 ;unlock the last hour currently being held
 L:HOUR -^HLMA("AI",HOUR)
 ;
 ;let everyone know that there is 1 less purge job running
 F I=1:1:20 L -^XTMP("HL7 FAST PURGE JOBS",I)
 D CHECKOUT^HLEVAPI
 K ^TMP("HLEVFLAG",$J)
 Q
 ;
PAUSE ;sleep for 10 SECONDS
 H 10
 Q
 ;
CHECKIN(CHECKAT,CNT773,CNT772,LCOUNT) ;
 ;if NOW>CHECKAT then:
 ;  1) check in with TaskMan
 ;  2) send a new event to the event monitor
 ;  3) reset CHECKAT for 10 minutes in the future
 ;  4) as an alternative to TaskMan, check if special Stop Fast Purge option has been used
 ;
 ;Input:
 ;  CHECKAT - the end of the current 10 minute time period
 ;  CNT773 - number of records in file 773 purged since the last time Event Logging was updated
 ;  CNT772 - number of records in file 772 purged since the last time Event Logging was updated
 ;Output:
 ;   Function returns 1 if the Fast Purge should stop, 0 otherwise
 ;   LCOUNT is reset to 0 **pass by reference**
 ;   CNT773 and CNT772 are set to 0 if reported to Event Logging **pass by reference**
 ;   CHECKAT is reset to 10 minute sin the future if the time is up **pass by reference**
 ;
 N NOW,QUIT
 S QUIT=0
 ;
 S NOW=$$NOW^XLFDT
 I NOW>CHECKAT D
 .D EVENT(.CNT773,.CNT772)
 .S CHECKAT=$$FMADD^XLFDT(NOW,,,10)
 .I '$D(ZTQUEUED) D
 ..W "."
 .E  D
 ..;check in with the Job Monitor
 ..D CHECKIN^HLEVAPI
 ..S QUIT=$$S^ZTLOAD
 ..S:QUIT ZTSTOP=1
 ;
 ;Check if the special option has been used to stop the purge
 I $G(^XTMP("HL7 FAST PURGE JOBS","STOP"))>0 D
 .S QUIT=1
 .I $$I^HLEMU($NA(^XTMP("HL7 FAST PURGE JOBS","STOP")),-1)
 ;
 S LCOUNT=0
 Q QUIT
 ;
FINDHOUR(HOUR) ;
 ;Finds the next dt/tm to the hour on the AI x-ref of file 773 that can be locked, returns 0 on failure
 N QUIT,NOW
 S QUIT=0
 ;
 ;unlock the last hour currently being held
 L:HOUR -^HLMA("AI",HOUR)
 ;
 S NOW=$$NOW^XLFDT
 ;
 ;if this is the first time through then start with the first entry on the x-ref
 I 'HOUR D  Q:QUIT HOUR
 .S HOUR=$O(^HLMA("AI",0))
 .;
 .;any records to purge?
 .I 'HOUR S QUIT=1 Q
 .;
 .;if so, quit if the next purgeable record is for the future
 .I HOUR>NOW S HOUR=0 Q
 .;
 .S HOUR=$E(HOUR,1,10)
 .L +^HLMA("AI",+HOUR):0 S:$T QUIT=1
 ;
 S HOUR=$E(HOUR,1,10)
 F  D  Q:QUIT
 .;
 .;look for the next entry at least 1 hour in the future
 .S HOUR=$$FMADD^XLFDT(HOUR,,1)-.000000001
 .S HOUR=$E($O(^HLMA("AI",HOUR)),1,10)
 .I 'HOUR S QUIT=1 Q
 .;
 .;I the hour is in the future then the entries can not yet be purged
 .I (HOUR>NOW) S HOUR=0,QUIT=1 Q
 .;
 .;check if this hour can be locked, if so this is the hour to be purged
 .L +^HLMA("AI",+HOUR):0 I $T S QUIT=1
 ;
 Q HOUR
 ;
EVENT(CNT773,CNT772) ;
 ;add the last number of records purged to event logging
 N EVENT
 I CNT773 D
 .S EVENT=$$EVENT^HLEME("773 PURGE","HEALTH LEVEL SEVEN")
 .I CNT773>1,$$INC^HLEME(EVENT,CNT773-1)
 .S CNT773=0
 I CNT772 D
 .S EVENT=$$EVENT^HLEME("772 PURGE","HEALTH LEVEL SEVEN")
 .I CNT772>1,$$INC^HLEME(EVENT,CNT772-1)
 .S CNT772=0
 Q
 ;
CHECK1() ;called by the Master Job to determine whether 
 ;FAST HL7 PURGE #1 should run.
 ;Output:
 ;  function returns 1 if yes, 0 if no
 ;
 I $$COUNT^HLEVAPI3("FAST HL7 PURGE #1")
 Q '$T
 ;
CHECK2() ;called by the Master Job to determine whether 
 ;FAST HL7 PURGE #2 should run.
 ;Output:
 ;  function returns 1 if yes, 0 if no
 ;
 I $$COUNT^HLEVAPI3("FAST HL7 PURGE #1"),'$$COUNT^HLEVAPI3("FAST HL7 PURGE #2")
 Q $T
