HMPDJFS ;SLC/KCM,ASMR/RRB,JD,CK,CPC -- Asynchronous Extracts and Freshness via stream;Apr 27, 2016 10:35:07
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**1,2**;May 15, 2016;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; JD - 1/14/15 - Removed "+" from "$$GETICN^MPIF001(DFN)" so that the
 ;                full value of icn (<icn>V<checksum>) could be captured. US4194.
 ; JD - 3/16/15 - Added checks to prevent restaging of data if the data has
 ;                already been staged.  US4304
 ; CPC - 3/4/16 - Prevent dual execution. DE3411
 ;
 ; PUT/POST   call $$TAG^ROUTINE(.args,.body)
 ; GET/DELETE call   TAG^ROUTINE(.response,.args)
 ;
 Q
 ;
API(HMPFRSP,ARGS) ;
 N HMPFERR,HMPFHMP,HMPFLOG,CNT,ACNT
 K ^TMP("HMPF",$J)
 S HMPFHMP=$TR($G(ARGS("server")),"~","=")
 S HMPFRSP=$NA(^TMP("HMPF",$J))
 S HMPFLOG=+$$GET^XPAR("ALL","HMP LOG LEVEL")
 I HMPFLOG D LOGREQ(HMPFHMP,.ARGS)
 S HMPSYS=$$SYS^HMPUTILS
 I '$L(HMPFHMP) D SETERR("Missing HMP Server ID") QUIT
 I '$O(^HMP(800000,"B",HMPFHMP,0)) D SETERR("HMP Server not registered") QUIT
 ;
 ; begin select case
 I ARGS("command")="putPtSubscription" D  G XAPI
 . N LOC
 . S LOC=$$PUTSUB^HMPDJFSP(.ARGS) ; Added ELSE for US4304
 . I $L(LOC) S ^TMP("HMPF",$J,1)="{""apiVersion"":""1.0"",""location"":"""_LOC_""""_$$PROGRESS_"}"
 I ARGS("command")="startOperationalDataExtract" D  G XAPI
 . N HMPX2,LOC
 . S ARGS("localId")="OPD"  ; use OPD to indicate "sync operational"
 . ; Next 2 lines added for US4304
 . S HMPX2="HMPFX~"_$G(HMPFHMP)_"~OPD"
 . D  ;DE5181 submit ODS only if not already run or running
 ..  N HMPUID
 ..  I $D(^XTMP(HMPX2)) S LOC="/hmp/subscription/operational data/" Q
 ..  S HMPUID=$O(^HMP(800000,"B",HMPFHMP,0))
 ..  I HMPUID,$P($G(^HMP(800000,HMPUID,0)),U,3)=2 S LOC="/hmp/subscription/operational data/" Q
 ..  S LOC=$$PUTSUB^HMPDJFSP(.ARGS)
 . I $L(LOC) S ^TMP("HMPF",$J,1)="{""apiVersion"":""1.0"",""location"":"""_LOC_"""}"
 I ARGS("command")="getPtUpdates" D  G XAPI
 . L +^TMP("HMPDJFSG "_$G(HMPFHMP)):2 E  D SETERR^HMPDJFS("Only one extract can run for a single server") Q  ;DE3411
 . D GETSUB^HMPDJFSG(HMPFRSP,.ARGS)
 . L -^TMP("HMPDJFSG "_$G(HMPFHMP)) ;DE3411
 I ARGS("command")="resetAllSubscriptions" D  G XAPI
 . D RESETSVR(.ARGS)
 . S ^TMP("HMPF",$J,1)="{""apiVersion"":""1.0"",""removed"":""true""}"
 I ARGS("command")="checkHealth" D  G XAPI
 . D HLTHCHK^HMPDJFSM(.ARGS)
 ; else
 D SETERR("command not recognized")  ; should not get this far
 ;
XAPI ; end select case
 ;
 I HMPFLOG=2 D LOGRSP(HMPFHMP)
 Q
 ;
LOGREQ(SRV,ARGS) ; Log the request
 I $D(^XTMP("HMPFLOG",0,"start")) D  Q:'$$GET^XPAR("ALL","HMP LOG LEVEL")
 . N ELAPSED S ELAPSED=$$HDIFF^XLFDT($H,^XTMP("HMPFLOG",0,"start"),2)
 . I ELAPSED>$$GET^XPAR("ALL","HMP LOG LIMIT") D PUT^XPAR("SYS","HMP LOG LEVEL",1,0)
 E  D
 . D NEWXTMP("HMPFLOG",1,"HMP Freshness Logging")
 . S ^XTMP("HMPFLOG",0,"start")=$H
 S ^XTMP("HMPFLOG",0,"total")=$G(^XTMP("HMPFLOG",0,"total"))+1
 S:'$L(SRV) SRV="unknown"
 N SEQ
 S SEQ=+$G(^XTMP("HMPFLOG",SRV))+1,^XTMP("HMPFLOG",SRV)=SEQ
 M ^XTMP("HMPFLOG",SRV,SEQ,"request")=ARGS
 S HMPFLOG("seq")=SEQ
 Q
LOGRSP(SRV) ; Log the response
 M ^XTMP("HMPFLOG",SRV,HMPFLOG("seq"),"response")=^TMP("HMPF",$J)
 Q
 ;
 ; delete a patient subscription
DELSUB(RSP,ARGS) ; cancel a subscription
 ; DELETE with: /hmp/subscription/{hmpSrvId}/patient/{pid}
 ; remove patient from HMP SUBSCRIPTION file
 ; remove ^XTMP(HMPX and ^XTMP(HMPH nodes
 ; look ahead (from lastId) and remove any nodes for the patient
 N DFN,HMPSRV,BATCH,HMPSRVID
 K ^TMP("HMPF",$J)
 S DFN=$$DFN(ARGS("pid")) Q:$D(HMPFERR)
 S HMPSRV=ARGS("hmpSrvId")
 S BATCH="HMPFX~"_HMPSRV_"~"_DFN
 L +^XTMP("HMPFP",DFN,HMPSRV):20 E  D SETERR("unable to get lock") Q
 ; if extract still running, it should remove itself when it finishes
 K ^XTMP("HMPFX~"_HMPSRV_"~"_DFN) ; kill extract nodes
 K ^XTMP("HMPFH~"_HMPSRV_"~"_DFN) ; kill held freshness updates
 ; remove all nodes for this patient between "last" and "next"
 ; loop forward from "last" in ^XTMP("HMPFP",0,hmpSrv) and remove nodes for this DFN
 K ^XTMP("HMPFP",DFN,HMPSRV)      ; kill subscription
 D DELPT(DFN,HMPSRV)
 L -^XTMP("HMPFP",DFN,HMPSRV)
 S RSP="{""apiVersion"":""1.0"",""success"":""true""}" ; if successful
 Q
DELPT(DFN,SRV) ; delete patient DFN for server SRV
 N DIK,DA
 S DA(1)=$O(^HMP(800000,"B",SRV,"")) Q:'DA(1)
 S DA=DFN Q:'DA
 S DIK="^HMP(800000,"_DA(1)_",1,"
 D ^DIK
 Q
 ;
 ; --- post freshness updates (internal to VistA)
 ;
POST(DFN,TYPE,ID,ACT,SERVER,NODES) ; adds new freshness item, return DT-seq
 ; if initializing use: ^XTMP("HMPFH-hmpserverid-dfn",seq#)    -hold
 ;       otherwise use: ^XTMP("HMPFS-hmpserverid-date",seq#)   -stream
 ;
 ; loop through subscribing streams for this patient
 ; if patient is initialized for an hmp server send events directly to stream
 ; otherwise, events go to temporary holding area
 ; initial extracts always sent directly to stream
 N HMPSRV,INIT,STREAM,DATE,SEQ,CNT
 S DATE=$$DT^XLFDT
 S HMPSRV="" F  S HMPSRV=$O(^HMP(800000,"AITEM",DFN,HMPSRV)) Q:'$L(HMPSRV)  D
 . I SERVER'="",HMPSRV'=SERVER Q
 . I '$D(^HMP(800000,"AITEM",DFN,HMPSRV)) Q          ; patient not subscribed
 . S INIT=(^HMP(800000,"AITEM",DFN,HMPSRV)=2),CNT=1  ; 2 means patient initialized
 . I $E(TYPE,1,4)="sync" S INIT=1                 ; sync* goes to main stream
 . I TYPE="syncDomain" S CNT=+$P(ID,":",3) S:CNT<1 CNT=1 ; CNT must be >0
 . S STREAM=$S(INIT:"HMPFS~",1:"HMPFH~")_HMPSRV_"~"_$S(INIT:DATE,1:DFN)
 . I '$D(^XTMP(STREAM)) D NEWXTMP(STREAM,8,"HMP Freshness Stream")
 . L +^XTMP(STREAM):5 E  S $EC=",Uno lock obtained," Q  ; throw error
 . S SEQ=$G(^XTMP(STREAM,"last"),0)+CNT
 . S ^XTMP(STREAM,SEQ)=DFN_U_TYPE_U_ID_U_$G(ACT)_U_$P($H,",",2)
 . S ^XTMP(STREAM,"last")=SEQ
 . L -^XTMP(STREAM)
 . ; NODES(hmpserverid)=streamDate^sequence -- optionally returned
 . S NODES($P(STREAM,"~",2))=$S(INIT:DATE,1:0)_U_SEQ
 Q
 ;
NEWXTMP(NODE,DAYS,DESC) ; Set a new node in ^XTMP
 K ^XTMP(NODE)
 S ^XTMP(NODE,0)=$$HTFM^XLFDT(+$H+DAYS)_U_$$HTFM^XLFDT(+$H)_U_DESC
 Q
PIDS(DFN) ; return string containing patient id's ready for JSON
 ; expects HMPFSYS, HMPFHMP
 Q:'DFN ""
 ;
 N X
 S X=",""pid"":"""_$$PID(DFN)_""""
 S X=X_",""systemId"":"""_HMPSYS_""""
 S X=X_",""localId"":"""_DFN_""""
 S X=X_",""icn"":"""_$$GETICN^MPIF001(DFN)_"""" ; US4194
 Q X
 ;
PID(DFN) ; return most likely PID (ICN or SYS;DFN)
 Q:'DFN ""
 I '$D(HMPSYS) S HMPSYS=$$SYS^HMPUTILS
 Q HMPSYS_";"_DFN            ; otherwise use SysId;DFN
 ;
DFN(PID) ; return the DFN given the PID (ICN or SYS;DFN)
 N DFN
 S PID=$TR(PID,":",";")
 I PID'[";" D  Q DFN  ; treat as ICN
 . S DFN=$$GETDFN^MPIF001(PID)
 . I DFN<0 D SETERR($P(DFN,"^",2))
 ; otherwise
 I $P(PID,";")'=$$SYS^HMPUTILS D SETERR("DFN unknown to this system") Q 0
 Q $P(PID,";",2)
 ;
PROGRESS(LASTITM) ; set the node in REF with progress properties
 ; expects HMPFHMP,HMPSYS
 N RSLT,HMPIEN,CNT,STS,TS,DFN,FIRST
 S HMPIEN=$O(^HMP(800000,"B",HMPFHMP,0)) Q:'HMPIEN ""
 S CNT=0,RSLT=""
 F STS=0,1 D  ; 0=uninitialized, 1=initializing
 . S FIRST=1
 . S RSLT=$S(STS=0:",""waitingPids"":[",1:RSLT_"],""processingPids"":[")
 . S TS=0 F  S TS=$O(^HMP(800000,HMPIEN,1,"AP",STS,TS)) Q:'TS  D  Q:CNT>99
 . . S DFN=0 F  S DFN=$O(^HMP(800000,HMPIEN,1,"AP",STS,TS,DFN)) Q:'DFN  D
 . . . S CNT=CNT+1
 . . . S RSLT=RSLT_$S(FIRST=1:"",1:",")_""""_HMPSYS_";"_DFN_""""
 . . . S FIRST=0
 S RSLT=RSLT_"]"
 ;
 N STRM,STRMDT,CURRDT
 I $G(LASTITM)="" S LASTITM=$P(^HMP(800000,HMPIEN,0),U,2)
 I $L(LASTITM,"-")<2 S LASTITM=$$DT^XLFDT_"-"_+LASTITM
 S STRMDT=$P(LASTITM,"-"),CURRDT=$$DT^XLFDT,SEQ=$P(LASTITM,"-",2)
 S CNT=0 F  D  Q:$$FMDIFF^XLFDT(STRMDT,CURRDT,1)'<0
 . S STRM="HMPFS~"_HMPFHMP_"~"_STRMDT
 . S CNT=CNT+$G(^XTMP(STRM,"last"))-SEQ
 . S STRMDT=$$FMADD^XLFDT(STRMDT,1),SEQ=0
 S RSLT=RSLT_",""remainingObjects"":"_CNT
 Q RSLT
 ;
 ; --- handle errors
 ;
SETERR(MSG) ; create error object in ^TMP("HMPFERR",$J) and set HMPFERR
 ; TODO: escape MSG for JSON
 S @HMPFRSP@(1)="{""apiVersion"":""1.0"",""error"":{""message"":"""_MSG_"""}}"
 S ^TMP("HMPFERR",$J,$H)=MSG
 S HMPFERR=1
 Q
 ;
DEBUG(MSG) ;
 S ^TMP("HMPDEBUG",$J,0)=$G(^TMP("HMPDEBUG",$J,0),0)+1
 I $D(MSG)'=1 M ^TMP("HMPDEBUG",$J,^TMP("HMPDEBUG",$J,0))=MSG Q
 S ^TMP("HMPDEBUG",$J,^TMP("HMPDEBUG",$J,0))=MSG
 Q
RESETSVR(ARGS) ;
 N DA,DIE,DIK,DR,IEN,SRV,SRVIEN,X
 S SRV=$G(ARGS("server")) I SRV="" Q
 S DA=$O(^HMP(800000,"B",SRV,"")) I DA'>0 Q
 S SRVIEN=DA
 L +^HMP(800000,SRVIEN):5 E  S $EC=",Uno lock obtained," Q
 ;delete operational data field
 S DIE="^HMP(800000,",DR=".03///@" D ^DIE
 S DA(1)=DA,DA=0
 ;delete patient multiple values
 S DIK="^HMP(800000,"_DA(1)_",1,"
 F  S DA=$O(^HMP(800000,DA(1),1,DA)) Q:DA'>0  D ^DIK
 ;kill server ^XTMP
 S X="HMPF" F  S X=$O(^XTMP(X)) Q:$E(X,1,4)'="HMPF"  D
 . I X[SRV K ^XTMP(X) I 1
 ;kill tidy node
 K ^XTMP("HMPFP","tidy",SRV)
 L -^HMP(800000,SRVIEN)
 Q
 ;
CLEARDOM(SVR,PAT) ;
 Q
 ;
CLEARPAT(SVR,PAT) ;
 I '$D(^XTMP("HMPFP",PAT,SVR)) Q
 ;do we need a check for patient initialized?
 K ^XTMP("HMPFP",PAT,SVR)
 Q
 ;
HMPSET(DA,NEW) ;
 N IEN,NAME
 S IEN=0 F  S IEN=$O(^HMP(800000,IEN)) Q:IEN'>0  D
 .S NAME=$P(^HMP(800000,IEN,0),U)
 .I $D(^HMP(800000,IEN,1,NEW(1)))>0 S ^HMP(800000,"AITEM",NEW(1),NAME)=NEW(2)
 Q
 ;
HMPKILL(DA,OLD) ;
 N NAME
 S NAME=$P($G(^HMP(800000,DA(1),0)),U) I NAME="" Q
 K ^HMP(800000,"AITEM",OLD(1),NAME)
 Q
 ;
HMPOSET(DA,NEW) ;
 N IEN,NAME
 S IEN=0 F  S IEN=$O(^HMP(800000,IEN)) Q:IEN'>0  D
 .S NAME=$P(^HMP(800000,IEN,0),U)
 .S ^HMP(800000,"AITEM","OPD",NAME)=NEW
 Q
 ;
HMPOKILL(DA) ;
 N NAME
 S NAME=$P($G(^HMP(800000,DA,0)),U) I NAME="" Q
 K ^HMP(800000,"AITEM","OPD",NAME)
 Q
KILL ; clear out all ^XTMP nodes
 N X
 S X="HMPF" F  S X=$O(^XTMP(X)) Q:$E(X,1,4)'="HMPF"  W !,X  K ^XTMP(X)
 Q
KILLSVR(SVR) ; clear out for specific machine
 N X
 S X="HMPF" F  S X=$O(^XTMP(X)) Q:$E(X,1,4)'="HMPF"  D
 . I X[SVR W !,X  K ^XTMP(X) I 1
 S X="" F  S X=$O(^XTMP("HMPFP",X)) Q:X=""  D
 . I $D(^XTMP("HMPFP",X,SVR)) K ^XTMP("HMPFP",X,SVR)
 Q
