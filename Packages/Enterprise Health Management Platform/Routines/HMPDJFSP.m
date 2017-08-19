HMPDJFSP ;SLC/KCM.ASMR/RRB,CPC-PUT/POST for extract & freshness ;Jan 20, 2017 17:18:18
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**1,2,3**;Sep 01, 2011;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; no entry at top
 ;
 ;
 ; --- create a new patient subscription
 ;
PUTSUB(ARGS) ; return location after creating a new subscription
 ; called by:
 ;   API^HMPDJFS
 ; falls through to:
 ;   QREJOIN
 ; calls:
 ;   $$TM^%ZTLOAD
 ;   SETERR^HMPDJFS
 ;   $$GETDFN^MPIF001
 ;   SETERR^HMPDJFS
 ;   OPDOMS^HMPDJFSD
 ;   PTDOMS^HMPDJFSD
 ;   SETPAT
 ;   NEWXTMP^HMPDJFS
 ;   SETMARK
 ;   INIT^HMPMETA
 ;   $$HTFM^XLFDT
 ;   SAVETASK^HMPDJFSQ
 ;   $$PID^HMPDJFS
 ; output:
 ;  fn returns      : /hmp/subscription/{hmpSrvId}/patient/{sysId;dfn}
 ;                  : "" if error, errors in ^TMP("HMPFERR",$J)
 ; .ARGS("server")  : name of HMP server
 ; .ARGS("localId") : dfn for patient to subscribe or "OPD" (operational data)
 ; .ARGS("icn")     : icn for patient to subscribe
 ; .ARGS("domains") : optional array of domains to initialize (deprecated)
 ;
 I '$$TM^%ZTLOAD D SETERR^HMPDJFS("Taskman not running") Q ""
 ;
 N HMPSRV,HMPFDFN,HMPBATCH,HMPFERR,I,NEWSUB,DOMAINS,HMPSVERS,HMPSTMP,HMPPRITY,HMPQBTCH ;US13442
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
 S HMPQBTCH="HMPFS~"_HMPSRV_"~queue"
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
 ;US13442
 S HMPPRITY=1 S:+$G(ARGS("HMPPriority")) HMPPRITY=+ARGS("HMPPriority")
 I '$D(^XTMP(HMPQBTCH,0)) D  ;check basic controls exist
 . S ^XTMP(HMPQBTCH,0)=$$HTFM^XLFDT(+$H+5)_U_$$HTFM^XLFDT(+$H)_U_"HMP task queue"
 . S ^XTMP(HMPQBTCH,0,0)=2 ;default concurrent patients
 ;put task onto task queue if new subscription for patient
 I NEWSUB,+HMPFDFN D SAVETASK^HMPDJFSQ Q "/hmp/subscription/"_HMPSRV_"/patient/"_$$PID^HMPDJFS(HMPFDFN)
 ;
QREJOIN  ; task And come back in from queue
 ; falls through from:
 ;   PUTSUB
 ; called by:
 ;   NEWTASK^HMPDJFSQ: ZTRTN="QREJOIN^HMPDJFSP"
 ; calls:
 ;   UPDSTS
 ;   QUINIT^HMPDJFSQ
 ;   SETMARK
 ;   $$PID^HMPDJFS
 ;
 ;Every Domain in it's own task (unless running in original mode)
 I NEWSUB D  Q:$G(HMPFERR) ""
 . ; if patient's extracts are held (version mismatch), put DFN on wait list
 . I +HMPFDFN,$G(^XTMP("HMPFS~"_HMPSRV("ien"),"waiting")) S ^XTMP("HMPFS~"_HMPSRV("ien"),"waiting",HMPFDFN)="" QUIT
 . D UPDSTS(HMPFDFN,$P(HMPBATCH,"~",2),1) ;moved from background job to once in foreground 12/17/2015
 . I 'HMPSVERS N HMPFDOM M HMPFDOM=DOMAINS D QUINIT^HMPDJFSQ(HMPBATCH,HMPFDFN,.HMPFDOM) Q  ;US11019 Enable previous behavior
 . S I="" F  S I=$O(DOMAINS(I)) Q:'I  D
 ..  N HMPFDOM
 ..  S HMPFDOM(1)=DOMAINS(I)
 ..  D QUINIT^HMPDJFSQ(HMPBATCH,HMPFDFN,.HMPFDOM)
 ;===JD START===
 ; For patient resubscribes, need to send demographics ONLY
 I 'NEWSUB,HMPFDFN'="OPD",'$D(^XTMP(HMPBATCH,0,"status")) D  ;DE3331 check expanded to ensure not current
 . N HMPFDOM,HMPDSAVE ;DE3331
 . M HMPDSAVE=DOMAINS ;DE3331
 . K DOMAINS S DOMAINS(1)="patient"
 . M HMPFDOM=DOMAINS
 . D QUINIT^HMPDJFSQ(HMPBATCH,HMPFDFN,.HMPFDOM)
 . I $G(HMPSVERS) S I="" F  S I=$O(HMPDSAVE(I)) Q:'I  D  ;DE3331 create empty metastamp entries for remaining domains
 ..  I HMPDSAVE(I)'="patient" D SETMARK("Meta",HMPFDFN,HMPDSAVE(I))
 ;===JD END===
 Q "/hmp/subscription/"_HMPSRV_"/patient/"_$$PID^HMPDJFS(HMPFDFN)
 ;
 ;
QUINIT(HMPBATCH,HMPFDFN,HMPFDOM) ; Queue the initial extracts for a patient
 ; called by:
 ;   VERMATCH^HMPDJFSG
 ;   CVTSEL^HMPP3I
 ; calls:
 ;   QUINIT^HMPDJFSQ
 ;
 do QUINIT^HMPDJFSQ(HMPBATCH,HMPFDFN,.HMPFDOM)
 ;
 quit  ; end of QUINIT
 ;
 ;
SETDOM(ATTRIB,DOMAIN,VALUE,HMPMETA) ; Set value for a domain ; cpc TA41760
 ; called by:
 ;   QUINIT^HMPDJFSQ
 ;   QUINIT^HMPMETA
 ;   DQINIT^HMPDJFSQ
 ;   DOMPT
 ;   MOD4STRM
 ; calls: none
 ; input:
 ;   ATTRIB: "status" or "count" attribute
 ;   VALUE:
 ;      for status, VALUE: 0=waiting, 1=ready
 ;      for count,  VALUE: count of items
 ;      don't update to finished value if just tracking metastamp
 ;
 I $G(HMPMETA)'="" S ^XTMP(HMPBATCH,0,ATTRIB,DOMAIN,$S(HMPMETA=1:"MetaStamp",HMPMETA=2:"Combined",1:"Staging"),$S(VALUE:"Stop",1:"Start"))=$H Q:(HMPMETA=1&VALUE)  ;cpc TA41760 10/7/2015 add time logging
 S ^XTMP(HMPBATCH,0,ATTRIB,DOMAIN)=VALUE
 Q
 ;
 ;
SETMARK(TYPE,HMPFDFN,HMPBATCH) ; Post markers for begin and end of initial synch
 ; called by:
 ;   PUTSUB
 ;   PUTSUB-QREJOIN
 ;   QUINIT^HMPMETA
 ;   DQINIT^HMPDJFSQ
 ; calls:
 ;   POST^HMPDJFS
 ;   SETTIDY
 ;
 ; ^XTMP("HMPFP","tidy",hmpServer,fmDate,sequence)=batch
 Q:$G(HMPENVIR("converting"))  ; don't set markers during conversion
 N HMPSRV,NODES,X
 S HMPSRV=$P(HMPBATCH,"~",2)
 D POST^HMPDJFS(HMPFDFN,"sync"_TYPE,HMPBATCH,"",HMPSRV,.NODES)
 Q:TYPE="Start"!(TYPE="Meta")  ; US11019
 D SETTIDY("<done>",.NODES)
 Q
 ;
 ;
DQINIT ; task Dequeue initial extracts
 ; called by: none
 ; calls:
 ;   DQINIT^HMPDJFSQ
 ;
 do DQINIT^HMPDJFSQ
 ;
 quit  ; end of DQINIT
 ;
 ;
DOMPT(HMPFADOM) ; Load a patient domain
 ; called by:
 ;   DQBACKDM^HMPDJFS1
 ;   DQINIT^HMPDJFSQ
 ; calls:
 ;   $$CHNKCNT
 ;   GET^HMPDJ
 ;   SETDOM
 ;   CHNKFIN
 ;
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
 ;
DOMOPD(HMPFADOM) ; Load an operational domain in smaller batches
 ; called by: none
 ; calls:
 ;   DOMOPD^HMPDJFSQ
 ;
 D DOMOPD^HMPDJFSQ(HMPFADOM) Q
 ;
 ;
CHNKCNT(DOMAIN) ; -- get patient object chunk count trigger                        *BEGIN*S68-JCH*
 ; called by:
 ;   DOMPT
 ; calls:
 ;   $$GET^XPAR
 ; input:
 ;   DOMAIN := current domain name being processed
 ;
 Q $S(+$$GET^XPAR("PKG","HMP DOMAIN SIZES",$P($G(DOMAIN),"#"),"Q")>3000:500,1:1000)  ; *END*S68-JCH*
 ;
 ;
CHNKINIT(HMP,HMPI) ; -- init chunk section callback  *BEGIN*S68-JCH*
 ; called by:
 ;   GET^HMPDJ
 ;   DQINIT^HMPDJFSQ
 ;   CHNKCHK
 ; calls: none
 ; input by ref:
 ;   HMP := $NA of location for chunk of objects
 ;   HMPI := number of objects in @HMP
 ;
 ; -- quit if not in chunking mode
 Q:'$D(HMPCHNK)
 ;
 S $P(HMPCHNK,"#",2)=$S(HMPCHNK["#":$P(HMPCHNK,"#",2)+1,1:0)
 S HMP=$NA(^XTMP(HMPBATCH,HMPFZTSK,HMPCHNK))
 K @HMP
 S HMPI=0
 Q  ; *END*S68-JCH*
 ;
 ;
CHNKCHK(HMP,HMPI) ; -- check if chunk should be queued callback *BEGIN*S68-JCH*
 ; called by:
 ;   ADD^HMPDJ
 ;   HMP1^HMPDJ02
 ; calls:
 ;   GTQ^HMPDJ
 ;   CHNKFIN
 ;   CHKXTMP
 ;   CHNKINIT
 ; input by ref:
 ;   HMP := $NA of location for chunk of objects
 ;   HMPI := number of objects in @HMP
 ;
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
 ;
CHNKFIN ; -- finish chunk section callback *BEGIN*S68-JCH*
 ; called by:
 ;   DOMPT
 ;   CHNKCHK
 ; calls:
 ;   MOD4STRM
 ;   POSTSEC
 ;
 ; -- quit if not in chunking mode
 Q:'$D(HMPCHNK)
 ;
 D MOD4STRM(HMPCHNK)
 ; -- domain#number, <no estimated do> , chunk trigger count for domain
 D POSTSEC(HMPCHNK,,HMPCHNK("trigger count"))
 Q  ; *END*S68-JCH*
 ;
 ;
MOD4STRM(DOMAIN) ; modify extract to be ready for stream
 ; called by:
 ;   DOMOPD^HMPDJFSQ
 ;   CHNKFIN
 ; calls:
 ;   SETDOM
 ; expects:
 ;   HMPBATCH, HMPFSYS, HMPFZTSK
 ; results are in:
 ;   ^XTMP("HMPFX~hmpsrv~dfn",DFN,DOMAIN,...)
 ;
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
 ;
POSTSEC(DOMAIN,ETOTAL,SECSIZE) ; post domain section to stream and set tidy nodes
 ; called by:
 ;   DOMOPD^HMPDJFSQ
 ;   CHNKFIN
 ; calls:
 ;   POST^HMPDJFS
 ;   SETTIDY
 ;
 N DFN,HMPSRV,COUNT,X,NODES
 S COUNT=^XTMP(HMPBATCH,HMPFZTSK,DOMAIN,"total")
 S ETOTAL=$G(ETOTAL,COUNT)
 s SECSIZE=$G(SECSIZE,0)
 S DFN=$P(HMPBATCH,"~",3)
 S HMPSRV=$P(HMPBATCH,"~",2)
 D POST^HMPDJFS(DFN,"syncDomain",DOMAIN_":"_HMPFZTSK_":"_COUNT_":"_ETOTAL_":"_SECSIZE,"",HMPSRV,.NODES)
 D SETTIDY(DOMAIN,.NODES)
 I $G(HMPQREF)'="" S @HMPQREF=$P($H,",",2) ;update heartbeat US13442
 Q
 ;
 ;
SETTIDY(DOMAIN,NODES) ; Set tidy nodes for clean-up of the extracts in ^XTMP
 ; called by:
 ;   SETMARK
 ;   POSTSEC
 ; calls: none
 ; expects:
 ;   HMPBATCH,HMPFZTSK
 ;
 N X,STREAM,SEQ
 S X="" F  S X=$O(NODES(X)) Q:X=""  D      ; iterate hmp servers
 . S STREAM="HMPFS~"_X_"~"_$P(NODES(X),U)  ; HMPFS~hmpSrv~fmDate
 . S SEQ=$P(NODES(X),U,2)
 . S ^XTMP(STREAM,"tidy",SEQ,"batch")=HMPBATCH
 . S ^XTMP(STREAM,"tidy",SEQ,"domain")=DOMAIN
 . S ^XTMP(STREAM,"tidy",SEQ,"task")=HMPFZTSK
 Q
 ;
 ;
MVFRUPD(HMPBATCH,HMPFDFN) ; Move freshness updates over active stream
 ; called by: none
 ; calls:
 ;   MVFRUPD^HMPDJFSQ
 ;
 do MVFRUPD^HMPDJFSQ(HMPBATCH,HMPFDFN)
 ;
 quit  ; end of MVFRUPD
 ;
 ;
BLDSERR(DFN,DOMAIN,ERRJSON) ; Create syncError object in ERRJSON
 ; called by: none
 ; calls:
 ;   DECODE^HMPJSON
 ;   ENCODE^HMPJSON
 ; expects:
 ;   HMPBATCH, HMPFSYS, HMPFZTSK
 ;
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
 ;
POSTERR(COUNT,DFN) ; put error into ^XTMP(batch)
 ; called by:
 ;   DQINIT^HMPDJFSQ
 ; calls:
 ;   POST^HMPDJFS
 ;
 N CNT,NODE,HMPSRV
 S HMPSRV=$P(HMPBATCH,"~",2)
 S CNT=0 F  S CNT=$O(^TMP("HMPERR",$J,CNT)) Q:CNT'>0  D
 .S NODE=$G(^TMP("HMPERR",$J,CNT,1))
 .S ^XTMP(HMPBATCH,HMPFZTSK,"error",CNT,1)=NODE
 .I CNT>1 S ^XTMP(HMPBATCH,HMPFZTSK,"error",CNT,.3)=","
 D POST^HMPDJFS(DFN,"syncError","error:"_HMPFZTSK_":"_COUNT_":"_COUNT,"",HMPSRV)
 Q
 ;
 ;
INITDONE(HMPBATCH) ; Return 1 if all domains are done
 ; called by:
 ;   DQINIT^HMPDJFSQ
 ; calls: none
 ;
 N X,DONE
 S X="",DONE=1
 F  S X=$O(^XTMP(HMPBATCH,0,"status",X)) Q:'$L(X)  I '^(X) S DONE=0
 Q DONE
 ;
 ;
SETPAT(DFN,SRV,NEWSUB) ; Add patient to 800000 if not there
 ; called by:
 ;   EN^HMPMETA
 ;   PUTSUB
 ; calls:
 ;   SETERR^HMPDJFS
 ;   UPDOPD
 ;   ADDPAT
 ;
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
 ;
UPDOPD(SRV,STS) ; Update status of operational synch
 ; called by:
 ;   UNSUB^HMPMETA
 ;   UPDSTS
 ;   SETPAT
 ; calls:
 ;   FILE^DIE
 ;   SETERR^HMPDJFS
 ;   CLEAN^DILF
 ;
 N FDA,ERR,DIERR
 S FDA(800000,SRV_",",.03)=STS
 D FILE^DIE("","FDA","ERR")
 I $D(ERR) D SETERR^HMPDJFS("Error changing operational status")
 D CLEAN^DILF
 Q
 ;
 ;
ADDPAT(DFN,SRV) ; Add a patient as subscribed for server
 ; called by:
 ;   SETPAT
 ; calls:
 ;   $$NOW^XLFDT
 ;   UPDATE^DIE
 ;   SETERR^HMPDJFS
 ;   CLEAN^DILF
 ;
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
 ;
UPDSTS(DFN,SRVNM,STS) ; Update the sync status
 ; called by:
 ;   PUTSUB-QREJOIN
 ;   MVFRUPD^HMPDJFSQ
 ; calls:
 ;   SETERR^HMPDJFS
 ;   UPDOPD
 ;   $$NOW^XLFDT
 ;   FILE^DIE
 ;   CLEAN^DILF
 ;
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
CHKXTMP(HMPBATCH,HMPFZTSK) ; -- ^XTMP check at end each domain loop iteration ; if too big HANG
 ; called by:
 ;   DQINIT^HMPDJFSQ
 ;   CHNKCHK
 ;
 N HMPOK S HMPOK=0  ; OK to run flag
 F  D  Q:HMPOK
 . ; if max disk size > estimated size then done with HANG 
 . I $$GETMAX^HMPUTILS>$$GETSIZE^HMPUTILS("estimate") K ^XTMP(HMPBATCH,0,"task",HMPFZTSK,"hanging") S HMPOK=1 Q
 . S ^("hanging")=$G(^XTMP(HMPBATCH,0,"task",HMPFZTSK,"hanging"))+1  ; increment
 . I $G(HMPQREF)'="" S @HMPQREF=$P($H,",",2)  ;update heartbeat US13442
 . H $$GETSECS
 Q
 ;
GETSECS() ; return default # of seconds to requeue in future or hang when processing domains
 ; called by:
 ;   CHKSP^HMPUTILS
 ;   CHKXTMP
 ;
 N SECS S SECS=+$$GET^XPAR("SYS","HMP EXTRACT TASK REQUEUE SECS")
 Q $S(SECS>0:SECS,1:10)   ; if not set, wait 10 seconds
 ;
