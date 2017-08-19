HMPMONJ ;ASMR/BL, monitor job listing ;Sep 13, 2016 20:03:08
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2,3**;April 14,2016;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; no entry from top
 ;DE6526 - routine refactored, 25 August 2016
 ;
 ;
J ; polling job display
 ;in symbol table:
 ;   HMPMNTR("server") = # of server record in file HMP Subscription (800000)
 ;   HMPROMPT = current monitor prompt group
 ;
 D FORMFEED^HMPMONL ; clear screen before report
 N STREAM  ; freshness stream subscript in ^XTMP
 W !,$$HDR^HMPMONL("eHMP Jobs"),!  ;  header line
 S STREAM=$$LASTREAM^HMPMONL ; get last freshness stream
 ;
 D POLLJOBS(STREAM) ; show stream's polling jobs
 D EXTRBTCH(STREAM) ; show extract batches
 W !! D RTRN2CON^HMPMONL
 Q
 ;
 ;
POLLJOBS(STREAM) ; show stream's polling jobs
 ;
 Q:$G(STREAM)=""
 W !!,"Polling job#:"
 ;
 N JOBID,LINE,X,Y
 S JOBID=""
 F  S JOBID=$O(^XTMP(STREAM,"job",JOBID)) Q:'JOBID  D
 . S LINE="   "_JOBID
 . ; check if job is still active
 . S X=JOBID X ^%ZOSF("JOBPARAM") S:Y="" LINE=LINE_" (inactive)"
 . W !,LINE
 ;
 Q
 ;
EXTRBTCH(STREAM) ; show extract batches
 ; STREAM - freshness stream
 ; called by:
 ;   J
 ;  ; symbol table:
 ;   HMPMNTR("server") = # of server record in file HMP Subscription (800000)
 ;   HMPROMPT = current dashboard prompt, ^ = exit now
 ; loop through extracts for this server
 ;
 N BATCH,BTCHCNT,C,EXIT,EXTRACTS,FRESHPRE,PIECE,SLOTS,TASK,TSKLST
 ; BTCHCNT - batch counter
 S SLOTS="Slots Open: "_$$SLOTS^HMPMONL ; # free slots, ^DD(3.54,1,0)="AVAILABLE SLOTS"
 S EXTRACTS="Extract Batches:",$E(EXTRACTS,80-$L(SLOTS),79)=SLOTS ;  extracts summary
 W !!,EXTRACTS
 ;
 S (BTCHCNT,EXIT)=0,FRESHPRE=$$FRESHPRE^HMPMONL,BATCH=FRESHPRE
 F  D  Q:EXIT  ; traverse batches
 . S BATCH=$O(^XTMP(BATCH)) ; get next batch
 . S:$E(BATCH,1,$L(FRESHPRE))'=FRESHPRE EXIT=1 Q  ; done if it's a different freshness stream
 . S BTCHCNT=BTCHCNT+1 W !,$J($P(BATCH,"~",3),12)_" Tasks"
 . S TASK=0,TSKLST="",C=0  ; C is the count
 . F  S TASK=$O(^XTMP(BATCH,0,"task",TASK)) Q:'TASK  S C=C+1,$P(TSKLST,",",C)=TASK  ; comma-delimited string of tasks
 . W !," "_C_" Task"_$E(C'=1,"s")_" found: "_TSKLST
 . I '$D(^XTMP(BATCH,0,"wait")) W !,"Waiting: "_$$WAIT(BATCH)_" seconds" Q
 . ;
 . I '$L(TSKLST) W !,"No tasks found for "_BATCH_" batch." Q
 . ;
 . ; each comma $piece of the list is a task #
 . F PIECE=1:1:$L(TSKLST,",") D
 ..  S TASK=$P(TSKLST,",",PIECE) W !,"Task "_TASK_" extracting: "_$$LASTITEM(BATCH,TASK),! ; last item in batch
 ;
 I 'BTCHCNT W !," * No batches found. *",!
 Q
 ;
WAIT(BATCH) ; function # seconds BATCH has waited
 ;
 N START S START=$G(^XTMP(BATCH,0,"time"))
 Q:'START 0  ; default to zero
 Q $$HDIFF^XLFDT($H,START,2)  ; return wait time in seconds
 ;
LASTITEM(BATCH,TASK) ; function, last domain retrieved for this BATCH and TASK
 Q:'$L($G(BATCH)) "*no batch*"  ; batch required
 Q:'$G(TASK) "*no task*"  ; task required
 N DOMAIN,LSTITM,NUM S LSTITM="",DOMAIN=""
 F  D  Q:DOMAIN=""!$L(LSTITM)
 . S DOMAIN=$O(^XTMP(BATCH,0,"status",DOMAIN)) Q:'$L(DOMAIN)
 . Q:$G(^XTMP(BATCH,0,"status",DOMAIN))  ; domain complete
 . S NUM=$O(^XTMP(BATCH,TASK,DOMAIN,""),-1)  ; go to last entry
 . S LSTITM=DOMAIN_$S(NUM:" #"_NUM,1:"")
 ;
 S:LSTITM="" LSTITM="<finished>"
 Q LSTITM  ; return last item
 ;
