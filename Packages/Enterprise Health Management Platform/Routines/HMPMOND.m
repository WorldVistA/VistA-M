HMPMOND ;asmr-ven/toad-dashboard: update, rate ;Aug 25, 2016 21:17:38
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;April 14,2016;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; no entry from top
 ;DE6526 - routine refactored, August 25, 2016
 ;
U ; dashboard action: update dashboard
 ;
 ; called by:
 ;   OPTION^HMPMON
 ; calls:
 ;   $$LASTREAM^HMPMONL = last freshness stream
 ;   $$UHEAD^HMPMONL = header for dashboard update screen
 ;   EN^DDIOL: write output or load into output array
 ;   $$LNQSTAT = line 1: queue status
 ;   $$LNSTRM = line 2: jobs polling in this stream
 ;   $$LNLUPDT = line 3: last update & errors count
 ;   $$LNEOQ = line 4: end of queue & xtmp size
 ;   QUEUE: show last max items in freshness queue
 ; input:
 ;   HMPSRVR = # of server record in file HMP Subscription (800000)
 ;   HMPSUB = subscription record's header node
 ;   input from the database
 ; throughput: [passed through symbol table]
 ;   HMPROMPT = current prompt; ^ to exit option; else leave alone
 ;
 ;
 N STREAM,SYS ; freshness stream subscript into ^xtmp
 S STREAM=$$LASTREAM^HMPMONL(HMPSRVR) ; get last freshness stream
 S SYS=$$SYS^HMPUTILS
 D EN^DDIOL($$UHEAD^HMPMONL(STREAM,"eHMP Dashboard: "_SYS),,"?0") ; header
 ;
 D EN^DDIOL($$LNQSTAT(STREAM),,"!!") ; line 1: queue status
 Q:STREAM=""  ; nothing else to show
 ;
 D EN^DDIOL($$LNSTRM(STREAM)) ; line 2: jobs polling in this stream
 ;
 D EN^DDIOL($$LNLUPDT(HMPSUB)) ; line 3: last update, errors
 ;
 D EN^DDIOL($$LNEOQ(STREAM)) ; line 4: end of queue, xtmp size
 ;
 D QUEUE(STREAM,10) ; show last max items in freshness queue
 ;
 Q
 ;
 ;
LNQSTAT(STREAM) ; function, queue status line
 ; input:
 ;   STREAM = last freshness stream
 ; output = line 1 of dashboard screen
 ;
 Q $$SQUEUE(STREAM) ; queue status
 ;
 ;
LNSTRM(STREAM) ; line 2: jobs polling in this stream
 ; called by:
 ;   U
 ; calls:
 ;   ^%ZOSF("JOBPARAM")
 ; input:
 ;   STREAM = last freshness stream
 ;   input from the database
 ; output = line 2: jobs polling in this stream
 ;   report to current device
 ;
 N INACTV,JBID,JBLST,LNSTRM,X,Y
 S JBLST="",INACTV=0,JBID=""
 F  S JBID=$O(^XTMP(STREAM,"job",JBID)) Q:'JBID  D
 . S X=JBID X ^%ZOSF("JOBPARAM")  ; check if job active
 . S:Y="" INACTV=INACTV+1
 . S JBLST=JBLST_$S(JBLST:", ",1:"")_JBID
 ;
 S LNSTRM="   Polling job#"
 S:JBLST LNSTRM=LNSTRM_" "_JBLST
 S:INACTV LNSTRM=LNSTRM_" ("_INACTV_" inactive)"
 ;
 Q LNSTRM ; return line 2: stream's polling jobs
 ;
 ;
LNLUPDT(HMPSUB) ; line 3: last update & errors count
 ; called by:
 ;   U
 ; calls:
 ;   $$SLASTUP = screen-field lastupdate
 ;   $$LJ^XLFSTR = left justify
 ;   $$SERRORS = screen-field errors
 ;   SETRIGHT^HMPMONL: set substring at right of line
 ; input:
 ;   HMPSUB = subscription record's header node
 ; output = line 3: last update & errors count
 ;
 N SLASTUP S SLASTUP=$$SLASTUP(HMPSUB) ; lastupdate
 N LNLUPDT S LNLUPDT=$$LJ^XLFSTR(SLASTUP,79) ; left in 79 columns
 N SERRORS S SERRORS=$$SERRORS ; screen-field errors
 D SETRIGHT^HMPMONL(.LNLUPDT,SERRORS) ; to the right
 ;
 Q LNLUPDT ; return line 3: last update & errors
 ;
 ;
LNEOQ(STREAM) ; line 4: end of queue & xtmp size
 ; called by:
 ;   U
 ; calls:
 ;   $$SXTMPSIZ = screen-field xtmp-size
 ;   $$RJ^XLFSTR = right justify
 ;   $$SENDQ = screen-field end-of-queue
 ;   SETLEFT^HMPMONL: set substring at left of line
 ; input:
 ;   STREAM = last freshness stream
 ; output = line 4: end of queue & xtmp size
 ;
 N LNEOQ,SENDQ,SXTMPSIZ
 S SXTMPSIZ=$$SXTMPSIZ ; screen-field xtmp-size
 S LNEOQ=$$RJ^XLFSTR(SXTMPSIZ,79) ; create line 3
 S SENDQ=$$SENDQ(STREAM) ; screen-field end-of-queue
 D:SENDQ SETLEFT^HMPMONL(.LNEOQ,SENDQ)
 ;
 Q LNEOQ ; return line 4: end of queue & xtmp size
 ;
SQUEUE(STREAM) ; screen-field queue status
 ; called by:
 ;   $$LNQSTAT
 ; calls:
 ;   CHKXTMP^HMPMONX: calculate queue status
 ; input:
 ;   STREAM = last freshness stream
 ; output = queue status
 ;
 Q:STREAM="" "No HMP extract stream found."  ; nothing to monitor
 ;
 N RESULT D CHKXTMP^HMPMONX(.RESULT) ; calculate queue status
 Q RESULT(1)  ;return queue status
 ;
SLASTUP(HMPSUB) ; screen-field last update
 ; called by:
 ;   $$LNLUPDT
 ; input:
 ;   HMPSUB = subscription record's header node
 ; output = screen-field last update
 ;
 N SERVER,SLASTUP,UPDATE
 S SERVER=$P(HMPSUB,U)  ; ^DD(800000,.01,0)="SERVER"
 S UPDATE=$P(HMPSUB,U,2) ; ^DD(800000,.02,0)="LASTUPDATE"
 S SLASTUP="   Last Update: "_UPDATE
 S:$P(HMPSUB,U,4) SLASTUP=SLASTUP_"  x"_$P(HMPSUB,U,4) ; ^DD(800000,.04,0)="REPEAT POLLS"
 ;
 Q SLASTUP ; return last-update
 ;
 ;
SERRORS() ; function, screen-field errors
 ;
 Q "eHMP Errors: "_$FN($$ETOTL^HMPMONE,",")  ;  # ehmp errors in all logs
 ;
 ;
SENDQ(STREAM) ; screen-field end-of-queue
 ;
 ; called by:
 ;   $$LNEOQ
 ; calls: none
 ; input:
 ;   STREAM = last freshness stream
 ; output = screen-field end-of-queue
 ;
 N SENDQ S SENDQ=""
 S:$D(^XTMP(STREAM)) SENDQ="  End of Queue: "_$P(STREAM,"~",3)_"-"_$G(^XTMP(STREAM,"last"))
 ;
 Q SENDQ ; return screen-field end-of-queue
 ;
 ;
SXTMPSIZ(STREAM) ; function, returns screen-field xtmp-size
 ; called by:
 ;   $$LNEOQ
 ;
 Q "eHMP's ^XTMP use: "_$$XTMPSIZE^HMPMONX  ; size of eHMP in ^XTMP
 ;
 ;
QUEUE(STREAM,MAX) ; show last max items in freshness queue
 ; called by:
 ;   U
 ; calls:
 ;   QLIST: get size and last max items
 ;   QDEF: define table F report
 ;   QHEAD: show freshness-queue header
 ;   $$QROW = each row of the report
 ;   EN^DDIOL: write output or load into output array
 ; input:
 ;   STREAM = last freshness stream
 ;   MAX = maximum # items to show
 ;   input from the database
 ; output:
 ;   HMPEXIT = whether to exit option report to current device
 ;
 N LIST ; size of queue, array of last max items
 D QLIST(.LIST,STREAM,MAX) ; get size and last max items
 ;
 N FRESHQ D QDEF(.FRESHQ) ; define table for report
 D QHEAD(.FRESHQ,MAX,LIST) ; show freshness-queue report header lines
 ;
 N ITEM,RECORD,ROW S ITEM=""
 F  S ITEM=$O(LIST(ITEM),-1) Q:'ITEM  D  ; traverse items
 . S RECORD=LIST(ITEM) Q:RECORD=""
 . S ROW=$$QROW(.FRESHQ,ITEM,RECORD)
 . D EN^DDIOL(ROW) ; display row of report
 ;
 Q
 ;
 ;
QLIST(LIST,STREAM,MAX) ; size of freshness queue, get last max items
 ; called by:
 ;   QUEUE
 ; input:
 ;   STREAM = last freshness stream
 ;   MAX = maximum # items to show
 ;   LIST - passed by ref.
 ; output:
 ;   LIST = total # items in freshness queue
 ;   LIST(item #) = record for each of the last max items
 ;
 K LIST S LIST=0
 N ITEM S ITEM=$C(1) ; reverse iteration from first subscript after numerics
 F  S ITEM=$O(^XTMP(STREAM,ITEM),-1) Q:'ITEM  D  ; traverse end of freshness list
 . S LIST=LIST+1  ; count up to max to show
 . Q:LIST>MAX
 . S LIST(ITEM)=$G(^XTMP(STREAM,ITEM))  ; record item
 ;
 Q
 ;
QDEF(FRESHQ) ; set table definition for report
 ; called by:
 ;   QUEUE
 ; output:
 ;  FRESHQ = table definition for report, passed by ref.
 ;
 S FRESHQ=5 ; table definition for report
 S FRESHQ(1,0)="1^8^item^l" ; column 1
 S FRESHQ(2,0)="11^21^patient^l" ; column 2
 S FRESHQ(3,0)="24^35^transaction^r" ; column 3
 S FRESHQ(4,0)="38^64^type^l" ; column 4
 S FRESHQ(5,0)="67^79^waiting^r" ; column 5
 ;
 Q
 ;
QHEAD(FRESHQ,MAX,COUNT) ; show freshness-queue header
 ;
 ; called by:
 ;   QUEUE
 ; calls:
 ;   $$QLNQSTAT = freshness queue report line 1: max & count
 ;   EN^DDIOL: write output or load into output array
 ;   $$TABLHEAD^HMPMONL = table header
 ;   $$TABLLINE^HMPMONL = table line
 ; input:
 ;   FRESHQ = table definition for report (see example), passed by ref.
 ;   MAX = maximum # items to show
 ;   COUNT = total # items in queue
 ; output:
 ;   report to current device or output array
 ; examples:
 ;   if:
 ;     FRESHQ(1,0) = "1^8^item^l"
 ;     FRESHQ(2,0) = "11^21^patient^l"
 ;     FRESHQ(3,0) = "24^35^transaction^r"
 ;     FRESHQ(4,0) = "38^64^which^l"
 ;     FRESHQ(5,0) = "67^79^waiting^r"
 ;
 N QHEAD,QLINE,QLNQSTAT
 S QLNQSTAT=$$QLNQSTAT(MAX,COUNT) ; max & count
 D EN^DDIOL(QLNQSTAT,,"!!") ; freshness queue report line 1
 ;
 S QHEAD=$$TABLHEAD^HMPMONL(.FRESHQ) ; table header
 D EN^DDIOL(QHEAD,,"!!") ; freshness queue report line 2
 ;
 N QLINE S QLINE=$$TABLLINE^HMPMONL(.FRESHQ) ; table line
 D EN^DDIOL(QLINE) ; freshness queue report line 3
 ;
 Q
 ;
QLNQSTAT(MAX,LIST) ; freshness queue report line 1
 ; called by:
 ;   QHEAD
 ; calls:
 ;   $$LJ^XLFSTR = left-justify max items
 ;   SETRIGHT^HMPMONL = right-justify total items
 ; input:
 ;   MAX = maximum # items to show
 ;   LIST = total # items in freshness queue
 ; output = freshness queue report line 1
 ;
 N QLINE,QLNQSTAT,QSIZE
 ;
 S QLNQSTAT=$$LJ^XLFSTR("Freshness Queue (last "_MAX_" items):",79)
 S QSIZE="Total items in queue: "_LIST
 D SETRIGHT^HMPMONL(.QLNQSTAT,QSIZE)
 ;
 Q QLNQSTAT ; return freshness queue report line 1
 ;
 ;
QROW(FRESHQ,ITEM,RECORD) ; row of the freshness-queue report
 ;
 ; called by:
 ;   QUEUE
 ; calls:
 ;   SETCOL^HMPMONL: set a value into its column
 ;   $$QWAIT = waiting value for this record
 ; input:
 ;   FRESHQ = table definition for report (see example), passed by ref.
 ;   ITEM = sequence # of item in freshness queue
 ;   RECORD = record of item in the queue
 ; output: report row for the item
 ; example: see QDEF
 ;
 ;
 N PATIENT,ROW,TRANSACT,TYPE,WAITING
 S ROW=""
 D:$L(RECORD)  ; if no record, no row
 . D SETCOL^HMPMONL(.ROW,.FRESHQ,1,ITEM)
 . S PATIENT=$P(RECORD,U) ; patient record #
 . D SETCOL^HMPMONL(.ROW,.FRESHQ,2,PATIENT)
 . S TRANSACT=$P(RECORD,U,2)
 . D SETCOL^HMPMONL(.ROW,.FRESHQ,3,TRANSACT)
 . S TYPE=$P($P(RECORD,U,3),"#")
 . D SETCOL^HMPMONL(.ROW,.FRESHQ,4,TYPE)
 . S WAITING=$$QWAIT(RECORD)
 . D SETCOL^HMPMONL(.ROW,.FRESHQ,5,WAITING)
 ;
 Q ROW ; return report row
 ;
 ;
QWAIT(RECORD) ; function, return waiting value
 ; input:
 ;   RECORD = record of item in the queue
 ; output = waiting value
 ; examples:
 ;   $$QWAIT("3^visit^H4721^^52660^54378") = "done"
 ;      if $H = "64003,54378" then:
 ;   $$QWAIT("3^visit^H4721^^52660^") = "1,718 s"
 ;   $$QWAIT("3^visit^H4721^^") = ""
 ;   $$QWAIT("") = ""
 ;
 Q:$G(RECORD)="" ""  ; return null if no RECORD
 ;
 N DONE,START,WAITING
 S WAITING="",DONE=$P(RECORD,U,6)
 S:DONE WAITING="done"
 D:'DONE
 . S START=$P(RECORD,U,5) Q:'START
 . S WAITING=$FN($P($H,",",2)-START,",")_" s" S:WAITING<0 WAITING=86400-WAITING  ; handle midnight
 ;
 Q WAITING ; return waiting seconds
 ;
