HMPDJFSM ;SLC/KCM,ASMR/RRB,CK - Monitoring Tools for Extracts;May 15, 2016 14:15
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**1**;May 15, 2016;Build 4
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; Show information for one server
 N IEN
 S IEN=$$GETSRV() Q:IEN'>0
 D LOOP(IEN)
 Q
ALL ; Show information for all servers
 S IEN=0 F  S IEN=$O(^HMP(800000,IEN)) Q:'IEN  W ! D SHOWSRV(IEN)
 Q
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
 I ^TMP("HMPF",$J,1)["location" W !,$P($G(^DPT(PAT,0)),"^")," is being synced."  ; IA10035, DE2818
 E  W !,"Subscription failed."
 Q
LOGLVL ; Set log level
 N DIR,DTOUT,DUOUT,DIRUT,Y,ERR
 W !,"Set freshness logging level."
 W !,"Current level is ",$$GET^XPAR("ALL","HMP LOG LEVEL")
 S DIR(0)="S^0:no logging;1:request logging;2:response logging;C:clear logs"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT) Q
 I Y="C" K ^XTMP("HMPFLOG") Q
 I Y>0 K ^XTMP("HMPFLOG")
 D PUT^XPAR("SYS","HMP LOG LEVEL",1,Y,.ERR)
 I $G(ERR) W !,"Error saving log level"
 Q
THLTH ; test health
 K ^TMP("HMPF",$J)
 N ARGS,HMPFHMP,HMPSYS,HMPFRSP
 S ARGS("server")="Test-Server-1"
 S HMPFRSP=$NA(^TMP("HMPF",$J))
 S HMPSYS=$$SYS^HMPUTILS
 S HMPFHMP=$TR($G(ARGS("server")),"~","=")
 D HLTHCHK(.ARGS)
 N I S I=0 F  S I=$O(^TMP("HMPF",$J,I)) Q:'I  W !,^TMP("HMPF",$J,I)
 Q
HLTHCHK(ARGS) ; Check health of VistA Server subscription
 ; expect HMPFRSP, HMPFHMP, HMPSYS to be created by API^HMPDJFS
 ; . ARGS("server")=HMP Server Id
 ; return a list of extracts that are currently active
 ; {pid="ABCD;229",domainsCompleted=8,domainsPending=20,objectCount=137,
 ;  subscribeTime=20140609112734,extractStatus="initializing"}
 ; ^TMP("HMPF",$J,1)=results
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
 Q
HLTHINFO(SRV,SRVIEN,DFN) ; Return a string of JSON reporting progress for this domain
 ; {pid,domainsCompleted,domainsPending,objectCount,queuedTime,phase(waiting,extracting)
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
 I $L(QTIME) S INFO("queuedTime")=$P($$FMTHL7^XLFDT(QTIME),"-")
 S STS=$P($G(^HMP(800000,SRVIEN,1,DFN,0)),"^",2)
 S INFO("extractStatus")=$S(STS=1:"initializing",STS=2:"initialized",1:"uninitialized")
 D ENCODE^HMPJSON("INFO","JSON")
 Q JSON(1)
 ;
HLTHHDR(COUNT) ; return JSON
 ; expects HMPFSYS
 N X
 S X="{""apiVersion"":1.02,""params"":{""domain"":"""_$$KSP^XUPARAM("WHERE")_""""
 S X=X_",""systemId"":"""_HMPSYS_"""},""data"":{""updated"":"""_$$HL7NOW^HMPDJ_""""
 S X=X_",""totalItems"":"_COUNT
 S X=X_",""items"":["
 Q X
 ;
LOOP(SRV) ; Monitor refresh loop
 D HOME^%ZIS
 N ACT,IEN
 S ACT="R" F  D  Q:"RV"'[ACT
 . I ACT="R" D SHOWMAIN(SRV)
 . I ACT="V" D SHOWHMPN
 . W ! S ACT=$$GETCMD
 Q
GETSRV() ; Return the IEN for the server to monitor
 N DIC,Y
 S DIC="^HMP(800000,",DIC(0)="AEMQ",DIC("A")="Select HMP server instance: "
 D ^DIC
 Q +Y
 ;
GETPAT() ; Return DFN for a patient
 N DIC,Y
 S DIC=2,DIC(0)="AEMQ"  ; DE2818, changed to file number, not global
 D ^DIC
 Q +Y
 ;
GETCMD() ; Get the next command
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="SB^R:Refresh;V:View HMP Nodes;Q:Quit"
 S DIR("B")="Refresh"
 D ^DIR
 I $D(DIRUT)!$D(DIROUT) S Y="Q"
 Q Y
 ;
SHOWHMPN ; Show HMP global nodes
 W !!,"Current HMP temporary nodes",?40,"High Numeric or Last Subscript",!
 N X,Y,J
 S X="VPQ~" F  S X=$O(^XTMP(X)) Q:$E(X,1,3)'="HMP"  D
 . W !,"^XTMP("""_X_""")"
 . S Y=$O(^XTMP(X," "),-1) S:'$L(Y) Y=$O(^XTMP(X,""),-1) W ?40,Y
 W !
 S X="VPQ~" F  S X=$O(^TMP(X)) Q:$E(X,1,3)'="HMP"  D
 . S J=0 F  S J=$O(^TMP(X,J)) Q:'J  D
 . . W !,"^TMP("""_X_""","_J_")"
 . . S Y=$O(^TMP(X,J," "),-1) S:'$L(Y) Y=$O(^TMP(X,J,""),-1) W ?40,Y
 S J=0 F  S J=$O(^TMP(J)) Q:'J  D
 . S X="VPQ~" F  S X=$O(^TMP(J,X)) Q:$E(X,1,3)'="HMP"  D
 . . W !,"^TMP("_J_","""_X_""")"
 . . S Y=$O(^TMP(J,X," "),-1) S:'$L(Y) Y=$O(^TMP(J,X,""),-1) W ?40,Y
 Q
SHOWMAIN(SRV) ; Show main information for server
 N STREAM
 S STREAM=$$LSTREAM(SRV)
 W @IOF
 W !,$$HTE^XLFDT($H),?64,"Slots Open: ",$$SLOTS,!
 I STREAM="" W !,"No HMP extract stream found." Q
 D SHOWSRV(SRV)
 D LJOBS(SRV)
 D LQUEUE(SRV,10)
 Q 
SHOWSRV(IEN) ; Show information for a server
 N X0,ROOT,BATCH,STREAM,SRVNM,LASTUP,REPEAT,TASK,TASKS
 S X0=^HMP(800000,IEN,0)
 S SRVNM=$P(X0,"^"),LASTUP=$P(X0,"^",2),REPEAT=$P(X0,"^",4)
 S STREAM=$$LSTREAM(IEN)
 W !,SRVNM,?30,"Last Update: ",LASTUP W:REPEAT "  x",REPEAT
 I $D(^XTMP(STREAM)) D
 . W !,?29,"End of Queue: ",$P(STREAM,"~",3),"-",$G(^XTMP(STREAM,"last"))
 ; loop thru extracts for this server
 S ROOT="HMPFX~"_SRVNM_"~",BATCH=ROOT
 S BATCH=ROOT F  S BATCH=$O(^XTMP(BATCH)) Q:$E(BATCH,1,$L(ROOT))'=ROOT  D
 . W !,$J($P(BATCH,"~",3),12)
 . S TASK=0,TASKS=""
 . F  S TASK=$O(^XTMP(BATCH,0,"task",TASK)) Q:'TASK  S TASKS=TASKS_$S($L(TASKS):",",1:"")_TASK
 . W ?14,"Task(s)"_TASKS
 . I '$D(^XTMP(BATCH,0,"wait")) W ?34,"waiting: ",$$WAIT(BATCH)," seconds" Q
 . W ?31,"extracting: ",$$LOBJ(BATCH,TASK)
 Q
WAIT(BATCH) ; Return the number of seconds the batch has been waiting
 N START
 S START=$G(^XTMP(BATCH,0,"time")) Q:'START 0
 Q $$HDIFF^XLFDT($H,START,2)
 ;
LOBJ(BATCH,TASK) ; Return the last domain>count retrieved for this batch
 Q:'TASK "no task"
 N LASTITM,DOMAIN,NUM
 S LASTITM=""
 S DOMAIN="",LASTITM=""
 F  S DOMAIN=$O(^XTMP(BATCH,0,"status",DOMAIN)) Q:'$L(DOMAIN)  D  Q:$L(LASTITM)
 . I $G(^XTMP(BATCH,0,"status",DOMAIN)) Q  ; domain complete
 . S NUM=$O(^XTMP(BATCH,TASK,DOMAIN,""),-1)
 . S LASTITM=DOMAIN_$S(NUM:" #"_NUM,1:"")
 Q $S('$L(LASTITM):"<finished>",1:LASTITM)
 ;
SLOTS() ; Return the number of slots available
 N OUT
 D FIND^DIC(3.54,"","1","BX","HMP EXTRACT RESOURCE","","","","","OUT")
 Q $G(OUT("DILIST","ID",1,1))
 ;
LJOBS(SRV) ; Show jobs polling in this stream
 N STREAM,JOBLIST,JOBNUM,JOBNA,X,Y
 S STREAM=$$LSTREAM(SRV),JOBLIST="",JOBNA=0
 S JOBNUM="" F  S JOBNUM=$O(^XTMP(STREAM,"job",JOBNUM)) Q:'JOBNUM  D
 . ; check if job is still active
 . S X=JOBNUM X ^%ZOSF("JOBPARAM") I '$L(Y) S JOBNA=JOBNA+1 QUIT  ; check if job active
 . S JOBLIST=JOBLIST_$S($L(JOBLIST):", ",1:"")_JOBNUM
 W !!,"Polling job number(s):  "_JOBLIST
 I JOBNA W "  ("_JOBNA_" no longer active)"
 Q
LQUEUE(SRV,MAX) ; Show last MAX items in freshness queue
 W !!,"Last items in the queue ---"
 N CNT,SEQ,LIST,STREAM
 S STREAM=$$LSTREAM(SRV)
 S CNT=0,SEQ=" " ; reverse from space to get numeric entries
 F  S SEQ=$O(^XTMP(STREAM,SEQ),-1) Q:'SEQ  D  Q:CNT>9
 . S CNT=CNT+1
 . S LIST(SEQ)=^XTMP(STREAM,SEQ)
 S SEQ="" F  S SEQ=$O(LIST(SEQ)) Q:'SEQ  W !,SEQ,?8,LIST(SEQ)
 Q
LSTREAM(SRV) ; Return the latest stream for this server
 N STREAM
 S STREAM="HMPFS~"_$P($G(^HMP(800000,SRV,0)),"^")_"~9999999"
 S STREAM=$O(^XTMP(STREAM),-1)
 Q STREAM
 ;
EMERSTOP ; Emergency Stop for Freshness
 D SETFRUP(0)
 Q
RSTRTFR ; Re-start freshness updates
 D SETFRUP(1)
 Q
SETFRUP(START) ; Set flag for freshness updates
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
 Q
CHGFTYP(TYPE,START) ; Change the freshness update flag for a type
 I START D STRTFTYP(TYPE) Q
 ; otherwise
 D STOPFTYP(TYPE)
 Q
STOPFTYP(TYPE) ; Stop freshness updates for type
 I '$D(^XTMP("HMP-off",0)) D NEWXTMP^HMPDJFS("HMP-off",999,"Switch off HMP freshness updates")
 W !,"Stopping freshness updates for: ",TYPE
 S ^XTMP("HMP-off",TYPE)=1
 Q
STRTFTYP(TYPE) ; Resume freshness updates for type
 W !,"Resuming freshness updates for: ",TYPE
 K ^XTMP("HMP-off",TYPE)
 Q
GETFTYP(ALPHA,START) ; Return item from the list
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
 Q X
 ;
SHOWFTYP(ALPHA) ; Show freshness types
 N I,X,P
 S I=0,X="" F  S X=$O(ALPHA(X)) Q:'$L(X)  D
 . S I=I+1,P=I#3
 . W:P=1 !,X
 . W:P=2 ?26,X
 . W:P=0 ?52,X
 Q
EVNTYPS(LIST) ; load event types
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
 Q
 ;
