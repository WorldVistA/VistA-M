HMPMOND ;ASMR/BL, monitor display ;Sep 24, 2016 03:07:36
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2,3**;April 14,2016;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; no entry from top
 ;DE6526, DE6644 - routine refactored, 7 September 2016
 ;
U ; monitor screen update - default activity in monitor
 ; called by:
 ;   OPTION^HMPMON
 ; passed in symbol table:
 ;   HMPMNTR("exit") - monitor exit flag
 ;   HMPMNTR("server") = # of server record in file HMP Subscription (800000)
 ;   HMPMNTR("zero node") = HMP SUBSCRIPTION entry's zero node
 ;   HMPROMPT = current prompt; ^ to exit option, else leave alone
 ;DSPLN - lines to display, first character in subscript is display order
 ;        this array is created for enhancements such as a remote procedure
 N DSPLN,HMPRSLT,JBID,STREAM,X,Y
 S DSPLN("1hdr")=$$HDR^HMPMONL($P(HMPMNTR("zero node"),U))  ; server name in header
 W !,DSPLN("1hdr"),!  ; line 1: screen header
 ; freshness stream subscript from ^XTMP
 S STREAM=$$LASTREAM^HMPMONL ; get last freshness stream
 I STREAM="" W !!,"   * No eHMP Extract Stream Found *" Q  ; nothing else to show
 ;create line 2
 D CHKXTMP^HMPMONX(.HMPRSLT)
 S Y="   "_$P(HMPRSLT(1),U,3)_": "_$P(HMPRSLT(2),U,3)  ; total patients in queue
 ; if there are patients show number staging & complete
 I $P(HMPRSLT(2),U,3) F X=4,5 S Y=Y_" - "_$P(HMPRSLT(1),U,X)_": "_$P(HMPRSLT(2),U,X)
 S DSPLN("2Patients")=Y W !,DSPLN("2Patients"),!  ; line 2: patients in queue
 ; create line 3
 S JBID=0
 F  S JBID=$O(^XTMP(STREAM,"job",JBID)) Q:'JBID  D
 . S JBID("count")=$G(JBID("count"))+1  ; count of job numbers found
 . S X=JBID X ^%ZOSF("JOBPARAM")  ; set JOB into X to check if job active
 . S:Y="" JBID("inactv")=$G(JBID("inactv"))+1  ; Y returned by ^%ZOSF("JOBPARAM")
 . S $P(JBID("list"),",",JBID("count"))=JBID
 S Y="   Polling job#"
 S:$G(JBID("list")) Y=Y_" "_JBID("list") S:$G(JBID("inactv")) Y=Y_" ("_JBID("inactv")_" inactive)"
 S DSPLN("3PollJobs")=Y W !,DSPLN("3PollJobs")  ; line 3: jobs polling in this stream
 ;create line 4
 S Y=$P(HMPMNTR("zero node"),U,2) ; ^DD(800000,.02,0)="LASTUPDATE"
 S Y="   Last Update: "_Y
 S:$P(HMPMNTR("zero node"),U,4) Y=Y_"  x"_$P(HMPMNTR("zero node"),U,4) ; ^DD(800000,.04,0)="REPEAT POLLS"
 S DSPLN("4LastUpdt")=Y  ; lastupdate
 S Y="eHMP Errors: "_$FN($$ETOTL^HMPMONE,",")  ;  # ehmp errors in all logs
 S $E(DSPLN("4LastUpdt"),80-$L(Y),79)=Y
 W !,DSPLN("4LastUpdt") ; line 4: last update & errors
 ; create line 5
 S Y="eHMP's ^XTMP size: "_$J($P(HMPRSLT(2),U,6)/1024,6,2)_" KB"  ; size of eHMP in ^XTMP
 S DSPLN("5XEoQXtmp")=$J("",79-$L(Y))_Y  ; right-justify line
 S Y=""  ; used for end of queue on next line
 S:$D(^XTMP(STREAM)) Y="  End of Queue: "_$P(STREAM,"~",3)_"-"_$G(^XTMP(STREAM,"last"))
 S:$L(Y) $E(DSPLN("5XEoQXtmp"),1,$L(Y))=Y  ; if end of queue found insert at beginning
 W !,DSPLN("5XEoQXtmp") ; line 5: end of queue, xtmp size
 ;
 D QUEUE(STREAM,10) ; show last 10 items in queue
 Q
 ;
QUEUE(STREAM,MAX) ; show last max items in freshness queue
 ; called by:
 ;   U
 ; calls:
 ;   QLIST: get size and last max items
 ;   QHEAD: show freshness-queue header
 ;   $$QROW = each row of the report
 ; input:
 ;   STREAM = last freshness stream
 ;   MAX = maximum # items to show
 ;   input from the database
 ; output:
 ;   HMPEXIT = whether to exit option report to current device
 ;
 N ITEM,LIST,X,Y  ; size of queue
 ; LIST - array of last max items
 D QLIST(.LIST,STREAM,MAX)  ; get items to display, LIST is total, returns MAX items
 ;set total into X to adjust length into Y, LIST varies
 S Y="Freshness Queue (last "_MAX_" items):",X="Total items in queue: "_LIST,$E(Y,80-$L(X),79)=X
 W !!,Y,!
 W !,"item      patient      transaction   type                               waiting"
 W !,"--------  -----------  ------------  ---------------------------------  -------"
 ; create report lines in Y
 S ITEM="" F  S ITEM=$O(LIST(ITEM),-1) Q:'ITEM  D  ; display ITEM array
 . S X=" "_$$QWAIT(LIST(ITEM)),Y=""  ; space in front of wait time in X
 . S $E(Y,1,9)=$E(ITEM,1,9)  ; item #
 . S $E(Y,11,23)=$E($P(LIST(ITEM),U),1,13)  ; patient
 . S $E(Y,24,37)=$E($P(LIST(ITEM),U,2),1,14)  ; transaction
 . S $E(Y,38,74)=$E($P($P(LIST(ITEM),U,3),"#"),1,37)  ; type
 . S $E(Y,80-$L(X),79)=X  ; waiting time
 . W !,Y  ; display row of report
 ;
 Q
 ;
QLIST(ITMLST,STREAM,MAX) ;  items from freshness queue, return last MAX items
 ; ITMLST passed by reference, returns:
 ;   ITMLST = total # items in freshness queue
 ;   ITMLST(item #) = record for each of the last max items
 ;
 K ITMLST S ITMLST=0  ; clear any residue
 N ITM S ITM=$C(1)  ; reverse iteration from first subscript after numerics
 F  S ITM=$O(^XTMP(STREAM,ITM),-1) Q:'ITM  D:ITMLST<MAX  S ITMLST=ITMLST+1
 . S ITMLST(ITM)=$G(^XTMP(STREAM,ITM))  ; save item, use $GET because queue is dynamic
 ;
 Q
 ;
QWAIT(RECORD) ; function, return waiting value for RECORD
 ;   RECORD = record of item in the queue
 ; examples:
 ;   $$QWAIT("3^visit^H4721^^52660^54378") = "done"
 ;      if $H = "64272,54378" then:
 ;   $$QWAIT("3^visit^H4721^^52660^") = "1,718 s"
 ;   $$QWAIT("3^visit^H4721^^") = ""
 ;   $$QWAIT("") = ""
 ;
 Q:$G(RECORD)="" ""  ; return null if no RECORD
 Q:$P(RECORD,U,6) "done"  ; item complete, return literal
 N START,WTING
 S START=$P(RECORD,U,5) Q:'START ""  ; no start time, return null
 S WTING=$P($H,",",2)-START  S:WTING<0 WTING=86400-WTING  ; handle midnight
 Q $FN(WTING,",")_" s"  ; make pretty
 ;
