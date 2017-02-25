HMPDJFSM ;SLC/KCM,ASMR/RRB,CK-PROTOCOLS & API's FOR MONITORING ;2016-07-25 14:32
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**1,2**;Sep 01, 2011;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; no entry at top
 ;
 ;
 ;
 ; contents
 ;
 ; subroutines that support API^HMPDJFS
 ;
 ; HLTHCHK: check health of VistA Server subscription
 ; $$HLTHINFO = domain progress in json
 ; $$HLTHHDR = domain-progress header in json
 ;
 ; subroutines that support SRV^HMPEQ & EVTS^HMPEQ
 ;
 ; $$LSTREAM = latest stream for this server
 ; $$WAIT = # seconds the batch has been waiting
 ; $$LOBJ = last domain>count retrieved for this batch
 ;
 ; subroutines that support protocol menu HMPM EVT QUE MGR MENU
 ;
 ; $$GETSRV = protocol HMPM EVT QUE CHANGE SERVER [Change Server]
 ; EMERSTOP: protocol HMPM EVT QUE EMERGENCY STOP [not distributed]
 ; RSTRTFR: protocol HMPM EVT QUE RESTART FRESHNESS [not distributed]
 ; SETFRUP: set flag for freshness updates
 ; CHGFTYP: change the freshness update flag for domain
 ; STOPFTYP: stop freshness updates for domain
 ; STRTFTYP: resume freshness updates for domain
 ; $$GETFTYP = select & return domain from list
 ; SHOWFTYP: show freshness domains
 ; EVNTYPS: protocol HMPM EVT QUE CHANGE DOMAIN [Change Domain]
 ;
 ; 
 ;
 ; subroutines that support API^HMPDJFS
 ;
 ;
ADDPT(PAT) ; Add patient to server
 N SRV,ARGS,RESULT
 I '$G(PAT) S PAT=$$GETPAT() Q:'PAT
 S SRV=$$GETSRV() Q:SRV'>0
 I $G(^HMP(800000,"AITEM",PAT,SRV))>0 W !,"Patient "_PAT_" already synced."
 ;
 S ARGS("command")="putPtSubscription"
 S ARGS("server")=$P(^HMP(800000,SRV,0),"^")
 S ARGS("localId")=PAT
 D API^HMPDJFS(.RESULT,.ARGS)
 I ^TMP("HMPF",$J,1)["location" W !,$P($G(^DPT(PAT,0)),"^")," is being synced."
 ; IA10035, DE2818
 E  W !,"Subscription failed."
 Q
 ;
GETPAT() ; Return DFN for a patient
 N DIC,Y
 S DIC=2,DIC(0)="AEMQ"  ; DE2818, changed to file number, not global
 D ^DIC
 Q +Y
 ;
HLTHCHK(ARGS) ; check health of VistA Server subscription
 ; called by:
 ;   API^HMPDJFS: asynchronous extracts & freshness via stream
 ; calls:
 ;   SETERR^HMPDJFS: log error
 ;   $$HLTHINFO = progress for this domain
 ;   $$HLTHHDR = json header for progress report
 ; input:
 ;   .ARGS("server") = HMP Server Id
 ;  also these, created by API^HMPDJFS, passed thru symbol table:
 ;   HMPFRSP = [unused?]
 ;   HMPFHMP = server name
 ;   HMPSYS = system id
 ; output: in ^TMP("HMPF",$job,node): list of active extracts
 ;   {pid="ABCD;229",domainsCompleted=8,domainsPending=20,
 ;   objectCount=137,subscribeTime=20140609112734,
 ;   extractStatus="initializing"}
 ;
 N HMPIEN,STS,TIME,DFN
 S HMPIEN=$O(^HMP(800000,"B",HMPFHMP,0))
 I 'HMPIEN D SETERR^HMPDJFS("Server not registered") QUIT
 S NODE=0
 S STS="" F  S STS=$O(^HMP(800000,HMPIEN,1,"AP",STS)) Q:'$L(STS)  D
 . S TIME="" F  S TIME=$O(^HMP(800000,HMPIEN,1,"AP",STS,TIME)) Q:'$L(TIME)  D
 . . S DFN="" F  S DFN=$O(^HMP(800000,HMPIEN,1,"AP",STS,TIME,DFN)) Q:'DFN  D
 . . . S NODE=NODE+1
 . . . S ^TMP("HMPF",$J,NODE)=$$HLTHINFO(HMPFHMP,HMPIEN,DFN)
 S ^TMP("HMPF",$J,.5)=$$HLTHHDR(NODE)
 S ^TMP("HMPF",$J,NODE+1)="]}}"
 ;
 quit  ; end of HLTHCHK
 ;
 ;
HLTHINFO(SRV,SRVIEN,DFN) ; domain progress in json
 ; called by:
 ;   HLTHCHK
 ; calls:
 ;   $$HTFM^XLFDT = convert $horolog date-time to fileman
 ;   $$PID^HMPDJFS = convert patient dfn to patient id format
 ;   $$FMTHL7^XLFDT = convert fileman date-time to hl7 (iso)
 ;   ENCODE^HMPJSON: convert mumps array to json to return
 ; input:
 ;   SRV = name of server, to use in ^XTMP subscripts
 ;   SRVIEN = record # in file HMP Subscription (800000)
 ;   DFN = record # in file Patient (2)
 ; output = string of JSON reporting progress for this domain
 ;   {pid,domainsCompleted,domainsPending,objectCount,queuedTime,
 ;   phase(waiting,extracting)
 ;
 N BATCH,QTIME,DONE,PEND,CNT,DOM,INFO,STS,JSON
 S BATCH="HMPFX~"_SRV_"~"_DFN
 S QTIME=$G(^XTMP(BATCH,0,"time")) S:$L(QTIME) QTIME=$$HTFM^XLFDT(QTIME)
 S DONE=0,PEND=0,CNT=0
 S DOM="" F  S DOM=$O(^XTMP(BATCH,0,"status",DOM)) Q:DOM=""  D
 . S CNT=CNT+$G(^XTMP(BATCH,0,"count",DOM))
 . I $G(^XTMP(BATCH,0,"status",DOM)) S DONE=DONE+1 QUIT
 . S PEND=PEND+1
 S INFO("pid")=$$PID^HMPDJFS(DFN)
 S INFO("domainsCompleted")=DONE
 S INFO("domainsPending")=PEND
 S INFO("objectCount")=CNT
 I $L(QTIME) S INFO("queuedTime")=$$FMTHL7^HMPSTMP(QTIME)  ; DE5016
 S STS=$P($G(^HMP(800000,SRVIEN,1,DFN,0)),"^",2)
 S INFO("extractStatus")=$S(STS=1:"initializing",STS=2:"initialized",1:"uninitialized")
 D ENCODE^HMPJSON("INFO","JSON")
 ;
 quit JSON(1) ; return domain progress ; end of $$HLTHINFO
 ;
 ;
HLTHHDR(COUNT) ; domain-progress header in json
 ; called by:
 ;   HLTHCHK
 ; calls:
 ;   $$KSP^XUPARAM = return kernel system parameter WHERE (domain)
 ;   $$HL7NOW^HMPDJ = current date-time in hl7 (iso) format
 ; input:
 ;   COUNT = total # items
 ;   HMPSYS = system id [passed through symbol table]
 ; output = json header
 ;
 N X
 S X="{""apiVersion"":1.02,""params"":{""domain"":"""_$$KSP^XUPARAM("WHERE")_""""
 S X=X_",""systemId"":"""_HMPSYS_"""},""data"":{""updated"":"""_$$HL7NOW^HMPDJ_""""
 S X=X_",""totalItems"":"_COUNT
 S X=X_",""items"":["
 ;
 quit X ; return domain-progress header ; end of $$HLTHHDR
 ;
 ;
 ;
 ; subroutines that support SRV^HMPEQ & EVTS^HMPEQ
 ;
 ;
 ;
LSTREAM(SRV) ; latest stream for this server
 ; called by:
 ;   EVTS^HMPEQ: return events for server's last stream
 ;   SRV^HMPEQ: process one server
 ; calls: none
 ; input:
 ;   SRV = ien of server in file HMP Subscription (8000000)
 ; output = last stream id for this server
 ;
 N STREAM
 S STREAM="HMPFS~"_$P($G(^HMP(800000,SRV,0)),"^")_"~9999999"
 S STREAM=$O(^XTMP(STREAM),-1)
 ;
 quit STREAM ; return last stream id ; end of $$LSTREAM
 ;
 ;
WAIT(BATCH) ; # seconds the batch has been waiting
 ; called by:
 ;   SRV^HMPEQ: process one server
 ; calls:
 ;   $$HDIFF^XLFDT
 ; input:
 ;   BATCH = extract batch
 ; output = # seconds the batch has been waiting
 ;
 N START
 S START=$G(^XTMP(BATCH,0,"time")) Q:'START 0
 N WAIT S WAIT=$$HDIFF^XLFDT($H,START,2)
 ;
 quit WAIT ; return # seconds waiting ; end of $$WAIT
 ;
 ;
LOBJ(BATCH,TASK) ; last domain>count retrieved for this batch
 ; called by:
 ;   SRV^HMPEQ: process one server
 ; calls: none
 ; input:
 ;   BATCH = extract batch
 ;   TASK = extract-batch task id
 ; output = last domain if any, or <finished> if none
 ;
 Q:'TASK "no task"
 N LASTITM,DOMAIN,NUM
 S LASTITM=""
 S DOMAIN="",LASTITM=""
 F  S DOMAIN=$O(^XTMP(BATCH,0,"status",DOMAIN)) Q:'$L(DOMAIN)  D  Q:$L(LASTITM)
 . I $G(^XTMP(BATCH,0,"status",DOMAIN)) Q  ; domain complete
 . S NUM=$O(^XTMP(BATCH,TASK,DOMAIN,""),-1)
 . S LASTITM=DOMAIN_$S(NUM:" #"_NUM,1:"")
 N LAST S LAST=$S('$L(LASTITM):"<finished>",1:LASTITM)
 ;
 quit LAST ; return last domain if any ; end of $$LOBJ
 ;
 ;
 ;
 ; subroutines that support protocol menu HMPM EVT QUE MGR MENU
 ;
 ;
 ;
GETSRV() ; protocol HMPM EVT QUE CHANGE SERVER [Change Server]
 ; called by:
 ;   protocol unwinder
 ; calls:
 ;   ^DIC: select server subscription to monitor
 ; input:
 ;   file HMP Subscription (800000)
 ; output = IEN of server to monitor
 ;
 N DIC,Y
 S DIC="^HMP(800000,",DIC(0)="AEMQ",DIC("A")="Select HMP server instance: "
 D ^DIC
 ;
 Q +Y ; return the IEN for the server to monitor ; end of $$GETSRV
 ;
 ;
EMERSTOP ; protocol HMPM EVT QUE EMERGENCY STOP [not distributed]
 ; called by:
 ;   protocol unwinder
 ; calls:
 ;   SETFRUP: set flag for freshness updates
 ; input:
 ;   user selects a domain to stop freshness updates
 ; output: freshness updates stopped for selected domain
 ;
 ; Emergency Stop for Freshness
 ;
 D SETFRUP(0)
 ;
 quit  ; end of EMERSTOP
 ;
 ;
RSTRTFR ; protocol HMPM EVT QUE RESTART FRESHNESS [not distributed]
 ; called by:
 ;   protocol unwinder
 ; calls:
 ;   SETFRUP: set flag for freshness updates
 ; input:
 ;   user selects a domain to resume freshness updates
 ; output: freshness updates resumed for selected domain
 ;
 ; Re-start freshness updates
 ;
 D SETFRUP(1)
 ;
 quit  ; end of RSTRTFR
 ;
 ;
SETFRUP(START) ; set flag for freshness updates
 ; called by:
 ;   EMERSTOP
 ;   RSTRTFR
 ; calls:
 ;   EVNTYPS: load event types
 ;   $$GETFTYP = select & return domain from list
 ;   CHGFTYP: change freshness update flag for a type
 ; input:
 ;   START = 0 to stop, 1 to resume
 ;   user selects a domain to stop or resume freshness updates
 ; output:
 ;   freshness updates stopped or resumed for selected domain
 ;
 I 'START D
 . W !,"WARNING!  This will stop freshness updates for the HMP."
 . W !,"          It will be necessary to re-synch patient data.",!
 I START D
 . W !,"This will --RESUME-- freshness updates for the HMP."
 . W !,"It may be necessary to re-synch patient and operational data.",!
 N TYPLST,ALPHA,I,TYPE
 D EVNTYPS(.TYPLST)
 S I=0 F  S I=$O(TYPLST(I)) Q:'I  S ALPHA(TYPLST(I))=""
 S TYPE=$$GETFTYP(.ALPHA,START)
 Q:TYPE=""
 I TYPE="*" D  Q
 . S TYPE="" F  S TYPE=$O(ALPHA(TYPE)) Q:TYPE=""  D CHGFTYP(TYPE,START)
 D CHGFTYP(TYPE,START)
 ;
 quit  ; end of SETFRUP
 ;
 ;
CHGFTYP(TYPE,START) ; change the freshness update flag for a type
 ; called by:
 ;   SETFRUP
 ; calls:
 ;   STRTFTYP: resume freshness updates for domain
 ;   STOPFTYP: stop freshness updates for domain
 ; input:
 ;   TYPE = domain to change
 ;   START = 0 to stop, 1 to resume
 ; output:
 ;
 I START D STRTFTYP(TYPE) Q
 ; otherwise
 D STOPFTYP(TYPE)
 ;
 quit  ; end of CHGFTYP
 ;
 ;
STOPFTYP(TYPE) ; stop freshness updates for domain
 ; called by:
 ;   CHGFTYP
 ; calls:
 ;   NEWXTMP^HMPDJFS: set a new node in ^XTMP
 ; input:
 ;   TYPE = domain to stop
 ; output:
 ;   freshness updates stopped for domain
 ;   ^XTMP("HMP-off",domain) = 1
 ;  if missing, header node ^XTMP("HMP-off",0) is set to
 ;    = when to purge ^ today ^ Switch off HMP freshness updates
 ;
 I '$D(^XTMP("HMP-off",0)) D NEWXTMP^HMPDJFS("HMP-off",999,"Switch off HMP freshness updates")
 W !,"Stopping freshness updates for: ",TYPE
 S ^XTMP("HMP-off",TYPE)=1
 ;
 quit  ; end of STOPFTYP
 ;
 ;
STRTFTYP(TYPE) ; resume freshness updates for domain
 ; called by:
 ;   CHGFTYP
 ; calls: none
 ; input:
 ;   TYPE = domain to resume
 ; output:
 ;   freshness updates resumed for domain
 ;   ^XTMP("HMP-off",TYPE) deleted
 ;
 W !,"Resuming freshness updates for: ",TYPE
 K ^XTMP("HMP-off",TYPE)
 ;
 quit  ; end of STRTFTYP
 ;
 ;
GETFTYP(ALPHA,START) ; select & return domain from list
 ; called by:
 ;   SETFRUP
 ; calls:
 ;   SHOWFTYP: Show freshness types
 ;   $$LOW^XLFSTR = convert domain name to lower case
 ; input:
 ;  .ALPHA(domain name) = "" for all selectable domains
 ;   START = 0 to stop, 1 to resume
 ;   user prompted to select a domain
 ; output = domain name
 ;
 N X,T,P
 S P=$S(START:"start",1:"stop")
 F  D  Q:X'["?"
 . D SHOWFTYP(.ALPHA)
 . W !!,"Choose domain to "_P_" (* "_P_"s all): "
 . R X:300 S:$E(X)="^" X="" Q:X=""  Q:X="*"
 . S X=$$LOW^XLFSTR(X)
 . Q:$D(ALPHA(X))
 . S T=$O(ALPHA(X))
 . I X=$E(T,1,$L(X)) W "  ",T S X=T Q
 . W "  ??",! S X="?"
 ;
 quit X ; return selected domain ; end of $$GETFTYP
 ;
 ;
SHOWFTYP(ALPHA) ; show freshness domains
 ; called by:
 ;   $$GETFTYP
 ; calls: none
 ; input:
 ;  .ALPHA(domain name) = "" for all selectable domains
 ; output:
 ;   list of domains is reported on current device
 ;
 N I,X,P
 S I=0,X="" F  S X=$O(ALPHA(X)) Q:'$L(X)  D
 . S I=I+1,P=I#3
 . W:P=1 !,X
 . W:P=2 ?26,X
 . W:P=0 ?52,X
 ;
 quit  ; end of SHOWFTYP
 ;
 ;
EVNTYPS(LIST) ; protocol HMPM EVT QUE CHANGE DOMAIN [Change Domain]
 ;;allergy
 ;;med
 ;;auxiliary
 ;;appointment
 ;;diagnosis
 ;;document
 ;;factor
 ;;immunization
 ;;lab
 ;;obs
 ;;order
 ;;problem
 ;;procedure
 ;;consult
 ;;image
 ;;surgery
 ;;task
 ;;visit
 ;;vital
 ;;mh
 ;;ptf
 ;;exam
 ;;cpt
 ;;education
 ;;pov
 ;;skin
 ;;treatment
 ;;roadtrip
 ;;diet
 ;;pt-select
 ;;patient
 ;;roster
 ;;user
 ;;zzzzz
 N I,X
 F I=1:1 S X=$P($T(EVNTYPS+I),";;",2,99) Q:X="zzzzz"  S LIST(I)=X
 ;
 quit
 ;
 ; called by:
 ;   protocol unwinder
 ; calls: none
 ; input:
 ;   $text table above
 ; output:
 ;  .LIST(#) = domain name
 ;
 ; load event types
 ;
 ; end of EVNTYPS
 ;
 ;
EOR ; end of routine HMPDJFSM
