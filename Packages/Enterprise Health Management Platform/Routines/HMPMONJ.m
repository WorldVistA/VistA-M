HMPMONJ ;asmr-ven/toad-dashboard: job listing ;Aug 25, 2016 21:17:38
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;April 14,2016;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; no entry from top
 ;DE6526 - routine refactored, August 25, 2016
 ;
 ;
J ; job listing
 ; called by:
 ;   OPTION^HMPMON
 ; calls:
 ;   FORMFEED^HMPMONL: issue form feed to current device or array
 ;   $$LASTREAM^HMPMONL = get last freshness stream
 ;   POLLJOBS: show jobs polling in this stream
 ;   EXTRBATS: show extract batches
 ; input:
 ;   HMPSRVR = # of server record in file HMP Subscription (800000)
 ;   input from the database
 ; symbol table:
 ;   HMPROMPT = current dashboard prompt, ^ = exit now [symbol table]
 ;   HMPEOP = 1 by default, 0 if exiting
 ; output = line 2: jobs polling in this stream
 ;   report to current device
 ;
 D FORMFEED^HMPMONL ; clear screen before report
 N STREAM ; freshness stream subscript into ^xtmp
 S STREAM=$$LASTREAM^HMPMONL(HMPSRVR) ; get last freshness stream
 ;
 D POLLJOBS(STREAM) ; show stream's polling jobs
 D EXTRBATS(HMPSRVR,STREAM,HMPSUB) ; show extract batches
 S:HMPROMPT=U HMPEOP=0  ; dashboard exit flag, suppress dashboard end-of-page if exiting
 ;
 Q
 ;
 ;
POLLJOBS(STREAM) ; show stream's polling jobs
 ; called by:
 ;   J
 ; calls:
 ;   EN^DDIOL: write output or load into output array
 ;   ^%ZOSF("JOBPARAM")
 ; input:
 ;   STREAM = last freshness stream
 ;   input from the database
 ; output = line 2: jobs polling in this stream
 ;   report to current device
 ;
 D EN^DDIOL("Polling job#:",,"!!")
 ;
 N JOBID,LINE,X,Y
 S JOBID=""
 F  S JOBID=$O(^XTMP(STREAM,"job",JOBID)) Q:'JOBID  D
 . S LINE="   "_JOBID
 . ; check if job is still active
 . S X=JOBID X ^%ZOSF("JOBPARAM") S:Y="" LINE=LINE_" (inactive)"
 . D EN^DDIOL(LINE)
 ;
 Q
 ;
EXTRBATS(HMPSRVR,STREAM,HMPSUB) ; show extract batches
 ;
 ; called by:
 ;   J
 ; calls:
 ;   $$SLOTS^HMPMONL = # free resource slots
 ;   $$RJ^XLFSTR = right justify
 ;   SETLEFT^HMPMONL: set substring at left of line
 ;   EN^DDIOL: write output or load into output array
 ;   $$FRESHPRE^HMPMONL = ^xtmp freshness prefix
 ;   $$WAIT = # seconds batch has waited
 ;   CHKIOSL^HMPMONL: check for and handle end of page
 ;   $$LASTITEM = last domain retrieved for this batch
 ; input:
 ;   HMPSRVR = # of server record in file HMP Subscription (800000)
 ;   STREAM = last freshness stream
 ;   HMPSUB = subscription record's header node
 ;   input from the database
 ; symbol table:
 ;   HMPROMPT = current dashboard prompt, ^ = exit now
 ; output:
 ;   output to the current device
 ;
 ; loop thru extracts for this server
 ;
 N BATCH,C,EXIT,EXTRACTS,FRESHPRE,PIECE,SLOTS,TASK,TSKLST
 S SLOTS="Slots Open: "_$$SLOTS^HMPMONL ; # free slots, ^DD(3.54,1,0)="AVAILABLE SLOTS"
 S EXTRACTS=$$RJ^XLFSTR(SLOTS,79)  ; extracts summary
 D SETLEFT^HMPMONL(.EXTRACTS,"Extract Batches:")
 D EN^DDIOL(EXTRACTS,,"!!")
 ;
 S EXIT=0,FRESHPRE=$$FRESHPRE^HMPMONL(HMPSUB),BATCH=FRESHPRE
 F  D  Q:HMPROMPT=U!EXIT  ; traverse batches
 . S BATCH=$O(^XTMP(BATCH)) ; get next batch
 . S EXIT=$E(BATCH,1,$L(FRESHPRE))'=FRESHPRE
 . Q:EXIT  ; done if it's a different freshness stream
 . ;
 . W !,$J($P(BATCH,"~",3),12)
 . ;
 . S TASK=0,TSKLST="",C=0  ; C is the count
 . F  S TASK=$O(^XTMP(BATCH,0,"task",TASK)) Q:'TASK  S C=C+1,$P(TSKLST,",",C)=TASK  ; comma-delimited string of tasks
 . W ?14,"Tasks: ",TSKLST W:C>1 !
 . ;
 . I '$D(^XTMP(BATCH,0,"wait")) D  Q
 ..  W ?34,"waiting: "_$$WAIT(BATCH)_" seconds"
 ..  D CHKIOSL^HMPMONL ; check, handle end of page
 . ;
 . I 'TSKLST W ?31,"extracting: no task" D CHKIOSL^HMPMONL ; check for and handle end of page
 . ;
 . ; each comma $piece of the list is a task #
 . F PIECE=1:1:$L(TSKLST,",") D  Q:HMPROMPT=U
 ..  S TASK=$P(TSKLST,",",PIECE)
 ..  W ?31,"extracting: "_$$LASTITEM(BATCH,TASK),! ; last item in batch
 ..  D CHKIOSL^HMPMONL ; check for and handle end of page
 ;
 Q
 ;
WAIT(BATCH) ; # seconds batch has waited
 ; called by:
 ;   EXTRBATS
 ; calls:
 ;   $$HDIFF^XLFDT = difference between two horolog date-times
 ; input:
 ;   BATCH = batch id
 ;   input from the database
 ; output = seconds
 ;
 N START S START=$G(^XTMP(BATCH,0,"time"))
 Q:'START 0  ; default to zero
 Q $$HDIFF^XLFDT($H,START,2)  ; return wait time in seconds
 ;
LASTITEM(BATCH,TASK) ; last domain retrieved for this batch
 ; called by:
 ;   EXTRBATS
 ; calls: none
 ; input:
 ;   BATCH = batch id
 ;   TASK = task #
 ;   input from the database
 ; output = last item in batch
 ;
 Q:'$G(TASK) "no task"
 N DOMAIN,LASTITEM,NUM
 S LASTITEM="",DOMAIN=""
 F  D  Q:DOMAIN=""!$L(LASTITEM)
 . S DOMAIN=$O(^XTMP(BATCH,0,"status",DOMAIN)) Q:'$L(DOMAIN)
 . Q:$G(^XTMP(BATCH,0,"status",DOMAIN))  ; domain complete
 . S NUM=$O(^XTMP(BATCH,TASK,DOMAIN,""),-1)
 . S LASTITEM=DOMAIN_$S(NUM:" #"_NUM,1:"")
 ;
 S:LASTITEM="" LASTITEM="<finished>"
 ;
 Q LASTITEM  ; return last item
 ;
