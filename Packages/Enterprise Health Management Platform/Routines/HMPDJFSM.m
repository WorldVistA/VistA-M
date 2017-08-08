HMPDJFSM ;SLC/KCM,ASMR/BL,CK-PROTOCOLS & API's FOR MONITORING ;Sep 23, 2016 10:44:23
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**1,2,3**;Sep 01, 2011;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; no entry at top
 ;DE4611, routine cleanup to bring it up to eHMP standards, 22 September 2016
 ;
 ;subroutines that support API^HMPDJFS
 ; HLTHCHK: check health of VistA Server subscription
 ; $$HLTHINFO = domain progress (Health Info) in JSON
 ; $$HLTHHDR = domain-progress (Health Header) header in JSON
 ;
 ;subroutines that support SRV^HMPEQ & EVTS^HMPEQ
 ; $$LSTREAM = latest stream for this server
 ; $$WAIT = # seconds the batch has been waiting
 ; $$LOBJ = last domain>count retrieved for this batch
 ;
 ;subroutines that support protocol menu HMPM EVT QUE MGR MENU
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
ADDPT(PAT) ; Add patient to server
 N ARGS,RESULT,SRV,Y
 I '$G(PAT) S PAT=$$GETPAT() Q:'PAT
 S SRV=$$GETSRV() Q:SRV'>0
 I $G(^HMP(800000,"AITEM",PAT,SRV))>0 W !,"Patient "_PAT_" already synched."
 ;
 S ARGS("command")="putPtSubscription"
 S ARGS("server")=$P(^HMP(800000,SRV,0),"^")
 S ARGS("localId")=PAT
 D API^HMPDJFS(.RESULT,.ARGS)
 ;IA10035, DE2818
 S Y=$S(^TMP("HMPF",$J,1)["location":$P($G(^DPT(PAT,0)),"^")_" is being synched.",1:"Subscription failed.")_" DFN: "_PAT
 W !,Y
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
 ;   $$HLTHHDR = JSON header for progress report
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
 ; DE4611 begin, 21 September 2016
 N DFN,HMPIEN,NXTDFN,STS,TIME
 S HMPIEN=$O(^HMP(800000,"B",HMPFHMP,0))
 I 'HMPIEN D SETERR^HMPDJFS("Server not registered") Q
 ; NODE - count of nodes in returned JSON
 ; NXTDFN - next DFN in queue using naked reference, if found append comma to each JSON node
 S NODE=0,STS=""
 F  S STS=$O(^HMP(800000,HMPIEN,1,"AP",STS)) Q:'$L(STS)  D
 . S TIME="" F  S TIME=$O(^HMP(800000,HMPIEN,1,"AP",STS,TIME)) Q:'$L(TIME)  D
 ..  S DFN="" F  S DFN=$O(^HMP(800000,HMPIEN,1,"AP",STS,TIME,DFN)) Q:'DFN  S NXTDFN=$O(^(DFN)) D
 ...   S NODE=NODE+1,^TMP("HMPF",$J,NODE)=$$HLTHINFO(HMPFHMP,HMPIEN,DFN)_$S(NXTDFN:",",1:"")
 ; DE4611 end
 S ^TMP("HMPF",$J,.5)=$$HLTHHDR(NODE)
 S ^TMP("HMPF",$J,NODE+1)="]}}"
 Q
 ;
 ;
HLTHINFO(SRV,SRVIEN,DFN) ;function, return domain progress in JSON
 ; called by:
 ;   HLTHCHK
 ; input:
 ;   SRV = name of server, to use in ^XTMP subscripts
 ;   SRVIEN = record # in file HMP Subscription (800000)
 ;   DFN = record # in file Patient (2)
 ; output = string of JSON reporting progress for this domain
 ;   {pid,domainsCompleted,domainsPending,objectCount,queuedTime,
 ;   phase(waiting,extracting)
 ;
 N BATCH,CNT,DOM,DONE,HMPERR,INFO,JSON,PEND,QTIME,STS
 S BATCH="HMPFX~"_SRV_"~"_DFN
 S QTIME=$G(^XTMP(BATCH,0,"time")) S:$L(QTIME) QTIME=$$HTFM^XLFDT(QTIME)
 S DONE=0,PEND=0,CNT=0
 S DOM="" F  S DOM=$O(^XTMP(BATCH,0,"status",DOM)) Q:DOM=""  D
 . S CNT=CNT+$G(^XTMP(BATCH,0,"count",DOM))
 . I $G(^XTMP(BATCH,0,"status",DOM)) S DONE=DONE+1 Q
 . S PEND=PEND+1
 S INFO("pid")=$$PID^HMPDJFS(DFN)
 S INFO("domainsCompleted")=DONE,INFO("domainsPending")=PEND,INFO("objectCount")=CNT
 I $L(QTIME) S INFO("queuedTime")=$$FMTHL7^HMPSTMP(QTIME)  ; DE5016
 S STS=$P($G(^HMP(800000,SRVIEN,1,DFN,0)),"^",2)
 S INFO("extractStatus")=$S(STS=1:"initializing",STS=2:"initialized",1:"uninitialized")
 D ENCODE^HMPJSON("INFO","JSON","HMPERR")
 I $D(HMPERR) Q HMPERR  ;  encoding error, return that
 Q JSON(1) ; return domain progress
 ;
 ;
HLTHHDR(COUNT) ; function, domain-progress header (health header) as JSON
 ;   COUNT = total # items
 ;   HMPSYS = system id (in symbol table)
 N X  ; $$KSP^XUPARAM = return kernel system parameter WHERE (domain)
 S X="{""apiVersion"":1.02,""params"":{""domain"":"""_$$KSP^XUPARAM("WHERE")_""""
 S X=X_",""systemId"":"""_HMPSYS_"""},""data"":{""updated"":"""_$$HL7NOW^HMPDJ_""""
 S X=X_",""totalItems"":"_COUNT
 S X=X_",""items"":["
 Q X  ; return domain-progress header
 ;
LSTREAM(SRV) ;function, latest stream for this server
 ; called by:
 ;   EVTS^HMPEQ: return events for server's last stream
 ;   SRV^HMPEQ: process one server
 ; calls: none
 ; input:
 ;   SRV = ien of server in file HMP Subscription (8000000)
 ;
 N STREAM
 S STREAM="HMPFS~"_$P($G(^HMP(800000,SRV,0)),"^")_"~9999999999"
 Q $O(^XTMP(STREAM),-1)  ; return last stream ID for this server
 ;
WAIT(BATCH) ; function, number of seconds the batch has been waiting
 ; called by:
 ;   SRV^HMPEQ: process one server
 ; BATCH = extract batch in ^XTMP
 N START S START=$G(^XTMP(BATCH,0,"time")) Q:'START 0
 Q $$HDIFF^XLFDT($H,START,2)  ; return # seconds waiting
 ;
LOBJ(BATCH,TASK) ;function, last item in domain or <finished> if none
 ; called by SRV^HMPEQ process one server
 ;   BATCH = extract batch
 ;   TASK = extract-batch task id
 Q:'$G(TASK) "no task"  ; must have task
 N DOMAIN,LASTITM,NUM S (DOMAIN,LASTITM,NUM)=""
 F  S DOMAIN=$O(^XTMP(BATCH,0,"status",DOMAIN)) Q:'$L(DOMAIN)  D  Q:$L(LASTITM)
 . Q:$G(^XTMP(BATCH,0,"status",DOMAIN))  ; domain complete
 . S NUM=$O(^XTMP(BATCH,TASK,DOMAIN,""),-1),LASTITM=DOMAIN_$S(NUM:" #"_NUM,1:"")
 ;
 Q $S('$L(LASTITM):"<finished>",1:LASTITM)  ; return last domain item
 ;
 ; subroutines that support protocol menu HMPM EVT QUE MGR MENU
GETSRV() ;extrinsic variable, interactive protocol HMPM EVT QUE CHANGE SERVER [Change Server]
 ; called by:
 ;   protocol unwinder
 ; output = IEN of server to monitor
 ;
 N DIC,Y
 S DIC="^HMP(800000,",DIC(0)="AEMQ",DIC("A")="Select HMP server instance: "
 D ^DIC Q +Y ; return IEN for the server to monitor
 ;
 ;
EMERSTOP ; protocol HMPM EVT QUE EMERGENCY STOP [not distributed]
 ; called by:
 ;   protocol unwinder
 ;  user selects a domain to stop freshness updates
 ; Emergency Stop for Freshness
 D SETFRUP(0) Q
 ;
RSTRTFR ; protocol HMPM EVT QUE RESTART FRESHNESS [not distributed]
 ; called by:
 ;   protocol unwinder:
 ;   user selects a domain to resume freshness updates
 ; Re-start freshness updates
 D SETFRUP(1) Q
 ;
SETFRUP(START) ; set flag for freshness updates
 ; called by:
 ;   EMERSTOP
 ;   RSTRTFR
 ; input:
 ;   START = 0 to stop, 1 to resume
 ;   user selects a domain to stop or resume freshness updates
 ; output:
 ;   freshness updates stopped or resumed for selected domain
 ;
 D:'START
 . W !,"WARNING!  This will stop freshness updates for the HMP."
 . W !,"          It will be necessary to re-synch patient data.",!
 D:START
 . W !,"This will --RESUME-- freshness updates for the HMP."
 . W !,"It may be necessary to re-synch patient and operational data.",!
 N TYPLST,DMNLST,I,TYPE
 D EVNTYPS(.TYPLST)
 S I=0 F  S I=$O(TYPLST(I)) Q:'I  S DMNLST(TYPLST(I))=""
 S TYPE=$$GETFTYP(.DMNLST,START)
 Q:TYPE=""
 I TYPE="*" D  Q  ; all types
 . S TYPE="" F  S TYPE=$O(DMNLST(TYPE)) Q:TYPE=""  D CHGFTYP(TYPE,START)
 D CHGFTYP(TYPE,START) Q
 ;
CHGFTYP(TYPE,ACTN) ; change the freshness update flag for a type
 ; input:
 ;   TYPE = domain to change
 ;   ACTN = 0 to stop, 1 to resume
 I ACTN D STRTFTYP(TYPE) Q
 ; otherwise
 D STOPFTYP(TYPE) Q
 ;
STOPFTYP(DMN) ; stop freshness updates for domain, DMN = domain to stop
 ; create ^XTMP zero node if needed, save data for 30 days
 D:'$D(^XTMP("HMP-off",0)) NEWXTMP^HMPDJFS("HMP-off",30,"Switch off HMP freshness updates")
 W !,"Stopping freshness updates for: "_DMN
 S ^XTMP("HMP-off",DMN)=1 Q
 ;
STRTFTYP(DMN) ; resume freshness updates for domain, DMN = domain to resume
 W !,"Resuming freshness updates for: "_DMN
 K ^XTMP("HMP-off",DMN) Q
 ;
GETFTYP(DMNLST,ACTN) ;function, select & return domain from list, DMNLST passed by ref.
 ; input:
 ;  DMNLST(domain name) = "" for all selectable domains
 ;  ACTN = 0 to stop, 1 to resume
 ;   user prompted to select a domain
 ;
 N P,T,X
 S P=$S(ACTN:"start",1:"stop")
 F  D  Q:X'["?"
 . D SHOWFTYP(.DMNLST)
 . W !!,"Choose domain to "_P_". (* "_P_"s all): "
 . R X:DTIME S:X["^" X="" Q:X=""  Q:X="*"
 . S X=$$LOW^XLFSTR(X) Q:$D(DMNLST(X))  ; match found
 . S T=$O(DMNLST(X))  ; check for partial match
 . I X=$E(T,1,$L(X)) W "  "_T S X=T Q  ; partial match found
 . W "  ??",! S X="?"  ; set X to ? to keep asking
 ;
 Q X  ; return selected domain
 ;
 ;
SHOWFTYP(DMNLST) ; show freshness domains
 ;   DMNLST(domain name) = "" for all selectable domains, passed by ref.
 ;list of domains displayed on current device
 N C,DM,Y
 S C=0,(DM,Y)="" F  S DM=$O(DMNLST(DM)) Q:'$L(DM)  D
 . S C=C+1 I C<3 S Y=Y_DM_$J(" ",26-$L(DM)) Q  ; 3 domains per line padded
 . S Y=Y_DM W !,Y S C=0,Y=""  ; write the line
 ;
 I $L(Y) W !,Y  ; in case any domains are left
 Q
 ;
 ;
EVNTYPS(LIST) ; protocol HMPM EVT QUE CHANGE DOMAIN [Change Domain], LIST passed by ref.
 ;;allergy
 ;;appointment
 ;;auxiliary
 ;;consult
 ;;cpt
 ;;diagnosis
 ;;diet
 ;;document
 ;;education
 ;;exam
 ;;factor
 ;;image
 ;;immunization
 ;;lab
 ;;med
 ;;mh
 ;;obs
 ;;order
 ;;patient
 ;;pov
 ;;problem
 ;;procedure
 ;;pt-select
 ;;ptf
 ;;roadtrip
 ;;roster
 ;;skin
 ;;surgery
 ;;task
 ;;treatment
 ;;user
 ;;visit
 ;;vital
 ;
 ; list above ends with single semi-colon comment
 ;called by: protocol unwinder
 ; output: LIST(#) = domain name
 N I,X
 F I=1:1 S X=$P($T(EVNTYPS+I),";;",2,99) Q:X=""  S LIST(I)=X
 Q
 ;
