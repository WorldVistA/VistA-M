HMPDJFSP ;SLC/KCM,ASMR/RRB,CPC -- PUT/POST for Extract and Freshness Stream;May 15, 2016 14:15
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**1**;May 15, 2016;Build 4
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; DE2818/RRB: SQA findings 1st 3 lines
 Q
 ;
 ; --- create a new patient subscription
 ;
PUTSUB(ARGS) ; return location after creating a new subscription
 ;  fn returns      : /hmp/subscription/{hmpSrvId}/patient/{sysId;dfn}
 ;                  : "" if error, errors in ^TMP("HMPFERR",$J)
 ; .ARGS("server")  : name of HMP server
 ; .ARGS("localId") : dfn for patient to subscribe or "OPD" (operational data)
 ; .ARGS("icn")     : icn for patient to subscribe
 ; .ARGS("domains") : optional array of domains to initialize (deprecated)
 ;
 I '$$TM^%ZTLOAD D SETERR^HMPDJFS("Taskman not running") Q ""
 ;
 N HMPSRV,HMPFDFN,HMPBATCH,HMPFERR,I,NEWSUB,DOMAINS,HMPSVERS,HMPSTMP
 ;
 ; make sure we can identify the patient ("OPD" signals sync operational)
 S HMPFDFN=$G(ARGS("localId"))
 S HMPSVERS=+$G(ARGS("HMPSVERS")) ;US11019 get sync version
 I HMPFDFN'="OPD" D  Q:$G(HMPFERR) ""
 . I '$L(HMPFDFN),$L(ARGS("icn")) S HMPFDFN=+$$GETDFN^MPIF001(ARGS("icn"))
 . I 'HMPFDFN D SETERR^HMPDJFS("No patient specified") Q
 . I '$D(^DPT(HMPFDFN)) D SETERR^HMPDJFS("Patient not found")  ; IA 10035, DE2818
 ;
 ; make sure server is known and create batch id
 S HMPSRV=HMPFHMP  ; TODO: switch to HMPFHMP as server ien
 I '$L(HMPSRV) D SETERR^HMPDJFS("Missing HMP Server ID") Q ""
 S HMPSRV("ien")=$O(^HMP(800000,"B",HMPSRV,0))
 I 'HMPSRV("ien") D SETERR^HMPDJFS("HMP Server not registered") Q ""
 S HMPBATCH="HMPFX~"_HMPSRV_"~"_HMPFDFN
 ;
 ; set up domains to extract
 D @($S(HMPFDFN="OPD":"OPDOMS",1:"PTDOMS")_"^HMPDJFSD(.DOMAINS)")
 ;
 ; ejk US5647
 ; code below restores selective domain functionality. 
 ; once the complete list of domains is returned from HMPDJFSD,
 ; if ARGS("domains") is passed in, anything not in that parameter
 ; will be excluded from the ODS extract.
 I $G(ARGS("domains"))'="" D
 .F I=1:1 Q:'$D(DOMAINS(I))  I ARGS("domains")'[DOMAINS(I) K DOMAINS(I)
 ;
 ; see if this is new subscription and task extract if new
 D SETPAT(HMPFDFN,HMPSRV,.NEWSUB) Q:$G(HMPFERR) ""
 ;For operational data set stamptime as time subscription placed US6734
 S HMPSTMP=$$EN^HMPSTMP("NOW") ;DE3377
 ;
 ;cpc US11019 following chunk of code moved out of QUINIT as was being called multiple times
 ;US11019 get array of job ids by domain
 ; only done once when beginning the batch, no matter how many tasked jobs
 L +^XTMP(HMPBATCH):5 E  D SETERR^HMPDJFS("Cannot lock batch:"_HMPBATCH) QUIT
 I '$D(^XTMP(HMPBATCH)) D
 . D NEWXTMP^HMPDJFS(HMPBATCH,2,"HMP Patient Extract")
 . ;US11019 - store domain specific job ids
 . N EMPB S EMPB="jobDomainId-" ;US11019
 . F  S EMPB=$O(ARGS(EMPB)) Q:EMPB=""  Q:EMPB'["jobDomainId-"  S:'HMPSVERS HMPSVERS=1 S ^XTMP(HMPBATCH,"JOBID",$P(EMPB,"jobDomainId-",2))=ARGS(EMPB) ; US11019 3rd version
 . S ^XTMP(HMPBATCH,"HMPSVERS")=HMPSVERS ;US11019 store sync version
 . I $G(ARGS("jobId"))]"" S ^XTMP(HMPBATCH,"JOBID")=ARGS("jobId")  ;US3907 /US11019
 . I $G(ARGS("rootJobId"))]"" S ^XTMP(HMPBATCH,"ROOTJOBID")=ARGS("rootJobId")  ;US3907
 . S ^XTMP(HMPBATCH,0,"time")=$H
 . ; US6734 - setting of syncStart for OPD only
 . I HMPFDFN="OPD" D SETMARK("Start",HMPFDFN,HMPBATCH),INIT^HMPMETA(HMPBATCH,HMPFDFN,.ARGS) ; US6734 
 L -^XTMP(HMPBATCH)
 ;cpc US11019 end moved code
 ;Every Domain in it's own task (unless running in original mode)
 I NEWSUB D  Q:$G(HMPFERR) ""
 . ; if patient's extracts are held (version mismatch), put DFN on wait list
 . I +HMPFDFN,$G(^XTMP("HMPFS~"_HMPSRV("ien"),"waiting")) S ^XTMP("HMPFS~"_HMPSRV("ien"),"waiting",HMPFDFN)="" QUIT
 . D UPDSTS(HMPFDFN,$P(HMPBATCH,"~",2),1) ;moved from background job to once in foreground 12/17/2015
 . I 'HMPSVERS N HMPFDOM M HMPFDOM=DOMAINS D QUINIT(HMPBATCH,HMPFDFN,.HMPFDOM) Q  ;US11019 Enable previous behavior
 . S I="" F  S I=$O(DOMAINS(I)) Q:'I  D
 ..  N HMPFDOM
 ..  S HMPFDOM(1)=DOMAINS(I)
 ..  D QUINIT(HMPBATCH,HMPFDFN,.HMPFDOM)
 ;===JD START===
 ; For patient resubscribes, need to send demographics ONLY
 I 'NEWSUB,HMPFDFN'="OPD",'$D(^XTMP(HMPBATCH,0,"status")) D  ;DE3331 check expanded to ensure not current
 . N HMPFDOM,HMPDSAVE ;DE3331
 . M HMPDSAVE=DOMAINS ;DE3331
 . K DOMAINS S DOMAINS(1)="patient"
 . M HMPFDOM=DOMAINS
 . D QUINIT(HMPBATCH,HMPFDFN,.HMPFDOM)
 . I $G(HMPSVERS) S I="" F  S I=$O(HMPDSAVE(I)) Q:'I  D  ;DE3331 create empty metastamp entries for remaining domains
 ..  I HMPDSAVE(I)'="patient" D SETMARK("Meta",HMPFDFN,HMPDSAVE(I))
 ;===JD END===
 Q "/hmp/subscription/"_HMPSRV_"/patient/"_$$PID^HMPDJFS(HMPFDFN)
 ;
QUINIT(HMPBATCH,HMPFDFN,HMPFDOM) ; Queue the initial extracts for a patient
 ; HMPBATCH="HMPFX~hmpsrvid~dfn"  example: HMPFX~hmpXYZ~229
 ; HMPFDOM(n)="domainName"
 ; 
 ; ^XTMP("HMPFX~hmpsrvid~dfn",0)=expires^created^HMP Patient Extract
 ;                           ,0,"status",domain)=0:waiting;1:ready
 ;                           ,0,"task",taskIen)=""
 ;                           ,taskIen,domain,... (extract data)
 ;
 ; set up the domains to be done by this task
 N I S I=0 F  S I=$O(HMPFDOM(I)) Q:'I  D SETDOM("status",HMPFDOM(I),0)
 ;
 ; create task for this set of domains within the batch
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSAVE,ZTSK
 S ZTRTN="DQINIT^HMPDJFSP",ZTIO="HMP EXTRACT RESOURCE",ZTDTH=$H
 S ZTSAVE("HMPBATCH")="",ZTSAVE("HMPFDFN")="",ZTSAVE("HMPFDOM(")=""
 S ZTSAVE("HMPENVIR(")=""  ; environment information
 S ZTSAVE("HMPSTMP")="" ; Operational data stamptime US6734
 S ZTSAVE("HMPSVERS")="" ;sync version US11019
 S ZTDESC="Build HMP domains for a patient"
 D ^%ZTLOAD
 I $G(ZTSK) S ^XTMP(HMPBATCH,0,"task",ZTSK)="" Q
 D SETERR^HMPDJFS("Task not created")
 Q
SETDOM(ATTRIB,DOMAIN,VALUE,HMPMETA) ; Set value for a domain ; cpc TA41760
 ; ATTRIB: "status" or "count" attribute
 ; for status, VALUE: 0=waiting, 1=ready
 ; for count,  VALUE: count of items
 ;don't update to finished value if just tracking metastamp
 I $G(HMPMETA)'="" S ^XTMP(HMPBATCH,0,ATTRIB,DOMAIN,$S(HMPMETA=1:"MetaStamp",HMPMETA=2:"Combined",1:"Staging"),$S(VALUE:"Stop",1:"Start"))=$H Q:(HMPMETA=1&VALUE)  ;cpc TA41760 10/7/2015 add time logging
 S ^XTMP(HMPBATCH,0,ATTRIB,DOMAIN)=VALUE
 Q
SETMARK(TYPE,HMPFDFN,HMPBATCH) ; Post markers for begin and end of initial synch
 ; ^XTMP("HMPFP","tidy",hmpServer,fmDate,sequence)=batch
 Q:$G(HMPENVIR("converting"))  ; don't set markers during conversion
 N HMPSRV,NODES,X
 S HMPSRV=$P(HMPBATCH,"~",2)
 D POST^HMPDJFS(HMPFDFN,"sync"_TYPE,HMPBATCH,"",HMPSRV,.NODES)
 Q:TYPE="Start"!(TYPE="Meta")  ; US11019
 D SETTIDY("<done>",.NODES)
 Q
 ;
DQINIT ; Dequeue initial extracts
 ; expects:  HMPBATCH, HMPFDFN, HMPFDOM, ZTSK
 N COUNT,HMPFDOMI,HMPFSYS,HMPFZTSK
 F COUNT=1:1:10 Q:$D(^XTMP(HMPBATCH,0,"task",ZTSK))  H .5 ;cpc 9/18/2015 In case job running too quickly
 I '$D(^XTMP(HMPBATCH,0,"task",ZTSK)) Q  ; extract was superceded
 K ^TMP("HMPERR",$J)
 S HMPFSYS=$$GET^XPAR("SYS","HMP SYSTEM NAME")
 S HMPFZTSK=ZTSK ; just in case the unexpected happens to ZTSK
 S ^XTMP(HMPBATCH,0,"task",ZTSK,"job")=$J
 S ^XTMP(HMPBATCH,0,"task",ZTSK,"wait")=$$HDIFF^XLFDT($H,$G(^XTMP(HMPBATCH,0,"time")),2)
 ;
 ;  S68 check space
 D CHKSP^HMPUTILS($P(HMPBATCH,"~",2)) ; US8228
 N HMPMETA ; US6734
 F HMPMETA=$S(HMPSVERS:2,1:1):-1:0 D  Q:HMPMETA=2  ;
 . I HMPMETA=0,+HMPFDFN D SETMARK("Start",HMPFDFN,HMPBATCH) ; US6734
 . S HMPFDOMI=""
 . F  S HMPFDOMI=$O(HMPFDOM(HMPFDOMI)) Q:'HMPFDOMI  D
 ..  D SETDOM("status",HMPFDOM(HMPFDOMI),0,HMPMETA) ; cpc TA41760
 ..  I HMPFDFN="OPD" D
 ...   D DOMOPD(HMPFDOM(HMPFDOMI))
 ...   I HMPMETA=2 D UPD^HMPMETA(HMPFDOM(HMPFDOMI)) ; US6734 - mark OPD domain as complete in metastamp
 ..  I +HMPFDFN D DOMPT(HMPFDOM(HMPFDOMI))
 ..  I HMPMETA=1 D:'$O(HMPFDOM(HMPFDOMI)) MERGE^HMPMETA(HMPBATCH) D:HMPFDFN="OPD" UPD^HMPMETA(HMPFDOM(HMPFDOMI)) Q
 ..  I HMPMETA=2 D
 ...   D MERGE1^HMPMETA(HMPBATCH,HMPFDOM(HMPFDOMI)) ;US11019 - merge data into metastamp
 ...   I +HMPFDFN D SETMARK("Meta",HMPFDFN,HMPFDOM(HMPFDOMI)) ;US11019 - new freshness entry replacing syncStart
 ...   I HMPFDFN="OPD" D:'$O(HMPFDOM(HMPFDOMI)) MERGE^HMPMETA(HMPBATCH) ; US6734 - merge data into metastamp
 ..  D SETDOM("status",HMPFDOM(HMPFDOMI),1,HMPMETA) ; ready ; cpc TA41760
 ..  ; if superceded, stop processing domains
 ..  I '$D(^XTMP(HMPBATCH,0,"task",HMPFZTSK)) S HMPFDOMI=999 Q
 ..  ; -- if more domains, check ^XTMP size before continuing; may have to HANG if too big  *BEGIN*S68-JCH*
 ..  I +HMPFDFN,HMPFDOMI'=+$O(HMPFDOM(""),-1) D CHKXTMP(HMPBATCH,HMPFZTSK) ;; US 5074 - removed
 ; if superceded, remove extracts produced by this task
 I '$D(^XTMP(HMPBATCH,0,"task",HMPFZTSK)) K ^XTMP(HMPBATCH,HMPFZTSK) Q
 ; don't assume initialized, since we may split domains to other tasks
 I $$INITDONE(HMPBATCH) D  ; if all domains extracted
 . S COUNT=$O(^TMP("HMPERR",$J,"")) I COUNT>0 D POSTERR(COUNT,HMPFDFN)
 . D SETMARK("Done",HMPFDFN,HMPBATCH) ; - add updated syncStatus
 . D MVFRUPD(HMPBATCH,HMPFDFN)        ; - move freshness updates over
 ;
 K ^XTMP(HMPBATCH,0,"task",HMPFZTSK)  ; this task is done
 Q
 ;
DOMPT(HMPFADOM) ; Load a patient domain
 N FILTER,RSLT,HMPFEST,HMPCHNK  ; *S68-JCH*
 S FILTER("noHead")=1
 S FILTER("domain")=HMPFADOM
 S FILTER("patientId")=HMPFDFN
 ; -- domain var used for chunking patient objects using <domain>#<number> construct  *BEGIN*S68-JCH*
 S HMPCHNK=HMPFADOM
 S HMPCHNK("trigger count")=$$CHNKCNT(HMPFADOM)  ; *END*S68-JCH*
 D GET^HMPDJ(.RSLT,.FILTER) ;US11019 I $G(HMPMETA) D SETDOM("status",HMPFADOM,1,1) Q  ;US11019/US6734 - do not update stream if compiling metastamp ; CPC TA41760
 I $G(HMPMETA)=1 D SETDOM("status",HMPFADOM,1,1) Q  ;US11019/US6734 - do not update stream if compiling metastamp ; CPC TA41760
 ; add to HMPFS queue if total>0 OR this is the first chunck (#0) section  *S68-JCH*
 I ($G(@RSLT@("total"),0)>0)!($P(HMPCHNK,"#",2)=0) D CHNKFIN  ; *S68-JCH*
 Q
 ;
DOMOPD(HMPFADOM) ; Load an operational domain in smaller batches
 ; expects HMPBATCH,HMPFZTSK
 N FILTER,RSLT,NEXTID,DONE,HMPFEST,HMPFSEC,HMPFSIZE,HMPFLDON ; cpc
 S HMPFSIZE=1000               ; section size (adjust to taste)
 S HMPFEST=$$TOTAL(HMPFADOM)   ; set estimated domain total
 S NEXTID=0,HMPFSEC=0,DONE=0,HMPFLDON=0 ;cpc
 S HMPFADOM=HMPFADOM_"#"_HMPFSEC
 F  D  Q:DONE
 . N FILTER,RSLT
 . S FILTER("noHead")=1
 . S FILTER("domain")=HMPFADOM ; include section for ^XTMP location
 . S FILTER("start")=NEXTID
 . S FILTER("limit")=HMPFSIZE
 . D GET^HMPEF(.RSLT,.FILTER)
 . I $G(HMPMETA)=1 S DONE=1 Q  ;US6734 - do not update stream if compiling metastamp
 . I '$D(^XTMP(HMPBATCH,0,"task",HMPFZTSK)) S DONE=1 QUIT  ; superceded
 . I $G(^XTMP(HMPBATCH,HMPFZTSK,HMPFADOM,"total"),0)=0,(HMPFSEC>0) S DONE=1 QUIT
 . I $G(^XTMP(HMPBATCH,HMPFZTSK,HMPFADOM,"finished")) S DONE=1
 . D MOD4STRM(HMPFADOM)
 . I DONE S HMPFEST=^XTMP(HMPBATCH,0,"count",$P(HMPFADOM,"#")) S:'HMPFEST HMPFEST=1
 . D POSTSEC(HMPFADOM,HMPFEST,HMPFSIZE)
 . Q:DONE
 . S NEXTID=$G(^XTMP(HMPBATCH,HMPFZTSK,HMPFADOM,"last"),0)
 . S HMPFSEC=HMPFSEC+1
 . S $P(HMPFADOM,"#",2)=HMPFSEC
 Q
 ;
CHNKCNT(DOMAIN) ; -- get patient object chunk count trigger                        *BEGIN*S68-JCH*
 ; input: DOMAIN := current domain name being processed
 Q $S(+$$GET^XPAR("PKG","HMP DOMAIN SIZES",$P($G(DOMAIN),"#"),"Q")>3000:500,1:1000)  ; *END*S68-JCH*
 ;
CHNKINIT(HMP,HMPI) ; -- init chunk section callback  *BEGIN*S68-JCH*
 ; input by ref:  HMP := $NA of location for chunk of objects
 ;               HMPI := number of objects in @HMP
 ; -- quit if not in chunking mode
 Q:'$D(HMPCHNK)
 ;
 S $P(HMPCHNK,"#",2)=$S(HMPCHNK["#":$P(HMPCHNK,"#",2)+1,1:0)
 S HMP=$NA(^XTMP(HMPBATCH,HMPFZTSK,HMPCHNK))
 K @HMP
 S HMPI=0
 Q  ; *END*S68-JCH*
 ;
CHNKCHK(HMP,HMPI) ; -- check if chunk should be queued callback *BEGIN*S68-JCH*
 ; (called by ADD^HMPDJ & HMP1^HMPDJ02)
 ; input by ref:  HMP := $NA of location for chunk of objects
 ;               HMPI := number of objects in @HMP
 ; quit if not in chunking mode
 Q:'$D(HMPCHNK)
 ;
 ; execute 'whether to chunk' criteria
 Q:HMPI<HMPCHNK("trigger count")
 ; -- add tail to json to section
 D GTQ^HMPDJ
 ; -- finish section and put on HMPFS~ queue
 D CHNKFIN
 ; -- check ^XTMP size before continuing; may have to HANG if too big
 D CHKXTMP(HMPBATCH,HMPFZTSK)  ; US5074 disable loopback
 ; -- initialize for next section
 D CHNKINIT(.HMP,.HMPI)
 Q  ; *END*S68-JCH*
 ;
CHNKFIN ; -- finish chunk section callback *BEGIN*S68-JCH*
 ; -- quit if not in chunking mode
 Q:'$D(HMPCHNK)
 ;
 D MOD4STRM(HMPCHNK)
 ; -- domain#number, <no estimated do> , chunk trigger count for domain
 D POSTSEC(HMPCHNK,,HMPCHNK("trigger count"))
 Q  ; *END*S68-JCH*
 ;
MOD4STRM(DOMAIN) ; modify extract to be ready for stream
 ; expects: HMPBATCH, HMPFSYS, HMPFZTSK
 ; results are in ^XTMP("HMPFX~hmpsrv~dfn",DFN,DOMAIN,...)
 ; syncError: {uid,collection,error}  uid=urn:va:syncError:sysId:dfn:extract
 N DFN,HMPSRV,COUNT,DOMONLY
 S DOMONLY=$P(DOMAIN,"#")
 S DFN=$P(HMPBATCH,"~",3),HMPSRV=$P(HMPBATCH,"~",2)
 S COUNT=+$G(^XTMP(HMPBATCH,HMPFZTSK,DOMAIN,"total"),0)
 I COUNT=0 S ^XTMP(HMPBATCH,HMPFZTSK,DOMAIN,1,1)="null"
 ;
 S ^XTMP(HMPBATCH,HMPFZTSK,DOMAIN,"total")=COUNT  ; include errors and/or empty
 D SETDOM("count",DOMONLY,$G(^XTMP(HMPBATCH,0,"count",DOMONLY),0)+COUNT)
 Q
 ;
POSTSEC(DOMAIN,ETOTAL,SECSIZE) ; post domain section to stream and set tidy nodes
 N DFN,HMPSRV,COUNT,X,NODES
 S COUNT=^XTMP(HMPBATCH,HMPFZTSK,DOMAIN,"total")
 S ETOTAL=$G(ETOTAL,COUNT)
 s SECSIZE=$G(SECSIZE,0)
 S DFN=$P(HMPBATCH,"~",3)
 S HMPSRV=$P(HMPBATCH,"~",2)
 D POST^HMPDJFS(DFN,"syncDomain",DOMAIN_":"_HMPFZTSK_":"_COUNT_":"_ETOTAL_":"_SECSIZE,"",HMPSRV,.NODES)
 D SETTIDY(DOMAIN,.NODES)
 Q
 ;
SETTIDY(DOMAIN,NODES) ; Set tidy nodes for clean-up of the extracts in ^XTMP
 ; expects HMPBATCH,HMPFZTSK
 N X,STREAM,SEQ
 S X="" F  S X=$O(NODES(X)) Q:X=""  D      ; iterate hmp servers
 . S STREAM="HMPFS~"_X_"~"_$P(NODES(X),U)  ; HMPFS~hmpSrv~fmDate
 . S SEQ=$P(NODES(X),U,2)
 . S ^XTMP(STREAM,"tidy",SEQ,"batch")=HMPBATCH
 . S ^XTMP(STREAM,"tidy",SEQ,"domain")=DOMAIN
 . S ^XTMP(STREAM,"tidy",SEQ,"task")=HMPFZTSK
 Q
 ;
MVFRUPD(HMPBATCH,HMPFDFN) ; Move freshness updates over active stream
 N I,X,FROM,HMPSRV,DFN,TYPE,ID,ACT
 S HMPSRV=$P(HMPBATCH,"~",2)
 D UPDSTS(HMPFDFN,HMPSRV,2)              ; now initialized 
 S FROM="HMPFH~"_HMPSRV_"~"_HMPFDFN
 S I=0 F  S I=$O(^XTMP(FROM,I)) Q:'I  D  ; move over held updates
 . S X=^XTMP(FROM,I)
 . S DFN=$P(X,U),TYPE=$P(X,U,2),ID=$P(X,U,3),ACT=$P(X,U,4)
 . D POST^HMPDJFS(DFN,TYPE,ID,ACT,HMPSRV)
 K ^XTMP(FROM)
 Q
 ;
BLDSERR(DFN,DOMAIN,ERRJSON) ; Create syncError object in ERRJSON
 ; expects: HMPBATCH, HMPFSYS, HMPFZTSK
 N COUNT,ERRVAL,ERROBJ,ERR,ERRMSG,SYNCERR
 M ERRVAL=^XTMP(HMPBATCH,HMPFZTSK,DOMAIN,"error")
 I $G(ERRVAL)="" Q
 S ERRVAL="{"_ERRVAL_"}"
 D DECODE^HMPJSON("ERRVAL","ERROBJ","ERR")
 I $D(ERR) S $EC=",UJSON decode error,"
 K ^XTMP(HMPBATCH,HMPFZTSK,DOMAIN,"error")
 S ERRMSG=ERROBJ("error","message")
 Q:'$L(ERRMSG)
 S SYNCERR("uid")="urn:va:syncError:"_HMPFSYS_":"_DFN_":"_DOMAIN
 S SYNCERR("collection")=DOMAIN
 S SYNCERR("error")=ERRMSG
 D ENCODE^HMPJSON("SYNCERR","ERRJSON","ERR") I $D(ERR) S $EC=",UJSON encode error," Q
 S COUNT=$O(^TMP("HMPERR",$J,""),-1)+1
 M ^TMP("HMPERR",$J,COUNT)=ERRJSON
 Q
 ;
POSTERR(COUNT,DFN) ; put error into ^XTMP(batch)
 N CNT,NODE,HMPSRV
 S HMPSRV=$P(HMPBATCH,"~",2)
 S CNT=0 F  S CNT=$O(^TMP("HMPERR",$J,CNT)) Q:CNT'>0  D
 .S NODE=$G(^TMP("HMPERR",$J,CNT,1))
 .S ^XTMP(HMPBATCH,HMPFZTSK,"error",CNT,1)=NODE
 .I CNT>1 S ^XTMP(HMPBATCH,HMPFZTSK,"error",CNT,.3)=","
 D POST^HMPDJFS(DFN,"syncError","error:"_HMPFZTSK_":"_COUNT_":"_COUNT,"",HMPSRV)
 Q
 ;
INITDONE(HMPBATCH) ; Return 1 if all domains are done
 N X,DONE
 S X="",DONE=1
 F  S X=$O(^XTMP(HMPBATCH,0,"status",X)) Q:'$L(X)  I '^(X) S DONE=0
 Q DONE
 ;
SETPAT(DFN,SRV,NEWSUB) ; Add patient to 800000 if not there
 N ERR,FDA,IEN,IENROOT
 S IEN=$O(^HMP(800000,"B",SRV,0))
 I 'IEN D SETERR^HMPDJFS("Unable to find server: "_SRV) QUIT
 ; for operational, only start sync if not yet subscribed
 I DFN="OPD" D  QUIT
 . L +^HMP(800000,IEN):5 E  D SETERR^HMPDJFS("Unable to lock server: "_SRV) Q
 . ; status is empty string (not 0) when unsubscribed
 . S NEWSUB='$L($P($G(^HMP(800000,IEN,0)),U,3))
 . I NEWSUB D UPDOPD(IEN,1) ; set to subscribed
 . L -^HMP(800000,IEN)
 ;
 ; for patient, check subscribed and get the PID
 L +^HMP(800000,IEN,1,DFN):5 E  D SETERR^HMPDJFS("Unable to lock patient: "_DFN) Q
 S NEWSUB='$D(^HMP(800000,IEN,1,DFN))
 I NEWSUB D ADDPAT(DFN,IEN)
 L -^HMP(800000,IEN,1,DFN)
 Q
 ;
UPDOPD(SRV,STS) ; Update status of operational synch
 N FDA,ERR,DIERR
 S FDA(800000,SRV_",",.03)=STS
 D FILE^DIE("","FDA","ERR")
 I $D(ERR) D SETERR^HMPDJFS("Error changing operational status")
 D CLEAN^DILF
 Q
ADDPAT(DFN,SRV) ; Add a patient as subscribed for server
 N FDA,FDAIEN,DIERR,ERR,IENS
 S IENS="?+"_DFN_","_SRV_","
 S FDAIEN(DFN)=DFN  ; help DINUM to work
 S FDA(800000.01,IENS,.01)=DFN
 S FDA(800000.01,IENS,2)=0
 S FDA(800000.01,IENS,3)=$$NOW^XLFDT
 D UPDATE^DIE("","FDA","FDAIEN","ERR")
 I $D(ERR) D SETERR^HMPDJFS("Error adding patient subscription")
 D CLEAN^DILF
 Q
 ;
UPDSTS(DFN,SRVNM,STS) ; Update the sync status
 N SRV,ERR ;US11019
 S SRV=$O(^HMP(800000,"B",SRVNM,0)) I 'SRV D SETERR^HMPDJFS("Missing Server") Q
 I DFN="OPD" D UPDOPD(SRV,STS) QUIT
 ;
 S FDA(800000.01,DFN_","_SRV_",",2)=STS
 S FDA(800000.01,DFN_","_SRV_",",3)=$$NOW^XLFDT
 D FILE^DIE("","FDA","ERR")
 I $D(ERR) D SETERR^HMPDJFS("Error updating patient sync status")
 D CLEAN^DILF
 Q
 ;
UPDPAT(DFN,SRV,STS) ; DEPRECATED?
 N ERR,FDA,IEN
 S IEN=$O(^HMP(800000,"B",SRV,"")) I +IEN'>0 Q
 I DFN="OPD" D
 . S FDA(800000,"?"_IEN_",",.01)=SRV
 . S FDA(800000,"?"_IEN_",",.03)=STS
 I +DFN>0 D
 .S FDA(800000.01,"?"_DFN_","_IEN_",",.01)=DFN
 .S FDA(800000.01,"?"_DFN_","_IEN_",",2)=STS
 D UPDATE^DIE("","FDA","","ERR")
 Q
 ;
TOTAL(DOMAIN) ; return size total
 N I,X,SIZE,ROOT
 S SIZE=0
 F I=1:1 S X=$T(OPDOMS+I^HMPDJFSD) Q:$P(X,";",3)="zzzzz"  D  Q:SIZE
 . I $P(X,";",3)'=DOMAIN Q
 . S ROOT=$P(X,";",4)
 . I ROOT="^HMP(800000.11)" S SIZE=$G(^HMP(800000.11,"ACNT",DOMAIN)) Q
 . I $L(ROOT) S SIZE=$P($G(@ROOT@(0)),U,4)
 Q $S(SIZE:SIZE,1:9999)
 ;
 ;
OKTORUN(HMPTTYPE) ;execute 'ok to run' strategy
 ; input: HMPTTYPE := type of task [ 'redoer' | 'extractor' | 'hangLoop']
 ;          - currently not used but may become useful for strategy algorithms
 ; returns: 1 - ok to run task | 0 - do not run task
 Q $$CHKSIZE
 ;
CHKSIZE() ; aggregate extract ^XTMP size strategy
 ; returns: 1 - ^XTMP extract size within limit  | 0 - ^XTMP size over limit
 ; Note: logic used regardless of HMP server
 Q $$GETMAX>+$$GETSIZE^HMPUTILS()
 ;
CHKXTMP(HMPBATCH,HMPFZTSK) ; -- ^XTMP check at end each domain loop iteration ; if too big HANG
 N HMPOK
 S HMPOK=0
 F  D  Q:HMPOK
 . ; -- if ok to run, continue
 . I $$OKTORUN("hangLoop") K ^XTMP(HMPBATCH,0,"task",HMPFZTSK,"hanging") S HMPOK=1 Q
 . S ^("hanging")=$G(^XTMP(HMPBATCH,0,"task",HMPFZTSK,"hanging"))+1
 . H $$GETSECS
 Q
 ;
GETMAX() ; return the max allowable aggregate extract size
 N HMPLIM
 S HMPLIM=$$GET^XPAR("SYS","HMP EXTRACT DISK SIZE LIMIT")*1000000
 Q $S(HMPLIM:HMPLIM,1:20000000)  ; if not set, 20mb characters
 ;
GETSECS() ; return default # of seconds to requeue in future or hang when processing domains
 N SECS
 S SECS=+$$GET^XPAR("SYS","HMP EXTRACT TASK REQUEUE SECS")
 Q $S(SECS:SECS,1:10)   ; not set, wait 10 seconds
 ;
