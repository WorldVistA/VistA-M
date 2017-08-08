HMPMETA ;SLC/PJH,ASM/RRB,CPC-collect domains, uids, & stamptimes ;Jan 20, 2017 17:18:18
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**1,2,3**;Sep 01, 2011;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; no entry from top
 ;
 ; New routine for US6734
 ; DE6644 - fixes and general code cleanup, 7 September 2016
 ;
ADD(HMPDMNM,HMPUID,HMPSTMP) ; Build array for metastamp - called from HMPDJ0* routines
 I ($G(HMPUID)="")!($G(HMPDMNM)="") Q
 ;For quick orders the JDS domain is 'qo'
 S:HMPDMNM="quick" HMPDMNM="qo"
 S ^TMP("HMPMETA",$J,HMPDMNM,HMPUID)=HMPSTMP
 ;unit tests use following nodes
 S ^TMP("HMPMETA",$J,HMPDMNM)=$G(^TMP("HMPMETA",$J,HMPDMNM))+1
 S ^TMP("HMPMETA",$J,"PATIENT")=$G(^TMP("HMPMETA",$J,"PATIENT"))+1
 Q
 ;
 ;
DONE(HMPFDFN,HMPBATCH) ; Check if metastamp compile is complete
 ;For patients this will always be true since all patient domains compiled by one task
 Q:+$G(HMPFDFN) 1
 ;For OPD requires to check that all domain compiles are completed
 N HMPDOM,HMPCOMP
 S HMPDOM="",HMPCOMP=1 F  S HMPDOM=$O(^XTMP(HMPBATCH,0,"MSTA",HMPDOM)) Q:HMPDOM=""  D  Q:'HMPCOMP
 . S:$G(^XTMP(HMPBATCH,0,"MSTA",HMPDOM))=0 HMPCOMP=0
 Q HMPCOMP
 ;
 ;
OPD(HMPFHMP) ;Check if OPD metastamp is ready to collect
 Q $S($$DONE("OPD","HMPFX~"_HMPFHMP_"~OPD"):1,1:0)
 ;
 ;
INIT(HMPBATCH,HMPFDFN,ARGS) ; Set metastamp status as in progress
 N DOMAINS,HMPDOM,I
 ; set up domains to extract
 D @($S(HMPFDFN="OPD":"OPDOMS",1:"PTDOMS")_"^HMPDJFSD(.DOMAINS)")
 ; remove any unneeded domains
 I $G(ARGS("domains"))'="" F I=1:1 Q:'$D(DOMAINS(I))  I ARGS("domains")'[DOMAINS(I) K DOMAINS(I)
 ; put the domains into the batch in ^XTMP
 F I=1:1 S HMPDOM=$G(DOMAINS(I)) Q:HMPDOM=""  S ^XTMP(HMPBATCH,0,"MSTA",HMPDOM)=0
 Q
 ;
 ;
UPD(HMPDOM) ; Update metastamp domain as complete
 S ^XTMP(HMPBATCH,0,"MSTA",HMPDOM)=1 Q
 ;
MERGE1(HMPBATCH,HMPDOM) ; US11019 Merge a single domain
 M ^XTMP(HMPBATCH,0,"META",HMPDOM)=^TMP("HMPMETA",$J,HMPDOM)
 K ^TMP("HMPMETA",$J,HMPDOM)
 Q
 ;
MERGE(HMPBATCH) ; Merge metastamp data into XTMP and mark domain complete in metastamp
 ;Formatting of metastamp into JSON format by HMPMETA goes here when ready
 N HMPDOM
 S HMPDOM="PATIENT"
 F  S HMPDOM=$O(^TMP("HMPMETA",$J,HMPDOM)) Q:HMPDOM=""  M ^XTMP(HMPBATCH,0,"META",HMPDOM)=^TMP("HMPMETA",$J,HMPDOM)
 K ^TMP("HMPMETA",$J)
 Q
 ;
 ;
METAPT(A,HMPCDOM) ; MetaStamp for patient data (within its own syncStart chunk).;US11019 added second parameter
 ; --Input parameter
 ; A = "^^HMPFX~hmp-development-box~"<DFN> (e.g. ^^HMPFX~hmp-development-box~3)
 ; HMPCDOM = Single domain US11019
 ;
 ; --Expects
 ; DOMSIZE,OFFSET,HMPFCNT ;US11019 comment added not variables
 ;
 ; HMPA = "HMPFX~hmp-development-box~"<DFN>
 ; HMPB = ZTASK# --> ^XTMP(HMPA,<ZTASK#>
 ; HMPC = Domain (e.g. "allergy") --> ^XTMP(HMPA,HMPB,<Domain>
 ; HMPD = Counter (sequential number) --> ^XTMP(HMPA,HMPB,HMPC,<Counter>
 ; HMPN = Subscript --> ^XTMP(HMPA,HMPB,HMPC,HMPD,<Subscript>
 ; HMPE = ^XTMP(HMPA,HMPB,HMPC,HMPD,HMPN)
 ; HMPF = Domain id (e.g. the "C877:3:751" part of "urn:va:allergy:C877:3:751"
 ; HMPID = pid --> <site-hash>;DFN (e.g. C877;3)
 ; HMPZ1 = DFN
 ; HMPP = $$PIDS^HMPDJFS(HMPZ1)  --> JSON construct containing pid, systemId, localId, icn
 ; HMPQ = " (double quote literal)
 ; HMPT = The "total" node from ^XTMP --> ^XTMP(HMPA,HMPB,HMPC,"total")
 ; HMPX = JSON construct for the entire metaStamp
 ; HMPW = Event timeStamp
 ; HMPY = $$EN^HMPSTMP("NOW")
 ; HMPZ = Counter for breaking up the large nodes into sub-nodes in ^TMP
 ;
 S U="^"
 N HMPA,HMPB,HMPC,HMPC1,HMPD,HMPE,HMPF,HMPID,HMPM,HMPN
 N HMPP,HMPQ,HMPT,HMPW,HMPX,HMPY,HMPZ,HMPZ1
 S HMPA=$P(A,U,3),HMPB=$O(^XTMP(HMPA,0)),HMPZ1=$P(HMPA,"~",3)
 S HMPE="",HMPQ="""",HMPZ=0 ;US11019
 S HMPC=$G(HMPCDOM) ;US11019
 S HMPP=$$PIDS^HMPDJFS(HMPZ1)
 S HMPY=$$EN^HMPSTMP("NOW")
 S HMPX=",""metaStamp"":"_"{""icn"":"""_$$GETICN^MPIF001(HMPZ1)_""""_","
 S HMPX=HMPX_"""stampTime"":"""_HMPY_""""_",""sourceMetaStamp"":"_"{"
 S HMPID=$TR($P($P(HMPP,"pid",2),","),""":")
 S HMPX=HMPX_""""_$P(HMPID,";")_""""_":{"
 S HMPX=HMPX_"""pid"":"""_HMPID_""""_","
 S HMPX=HMPX_"""localId"":"""_$P(HMPID,";",2)_""""_","
 S HMPX=HMPX_"""stampTime"":"""_HMPY_""""_","
 S HMPX=HMPX_"""domainMetaStamp"""_":"_"{"
 ;Scan Domains
 D:HMPC'=""  I HMPC="" F  S HMPC=$O(^XTMP(HMPA,0,"META",HMPC)) Q:HMPC']""  D  ;US11019 allow process by single domain
 .S HMPX=HMPX_""""_HMPC_""""_":{"
 .S HMPX=HMPX_"""domain"":"""_HMPC_""""_","
 .S HMPX=HMPX_"""stampTime"":"""_HMPY_""""_","
 .S HMPD=0
 .S HMPX=HMPX_"""eventMetaStamp"""_":"_"{" ; Patient data
 .N HMPU,HMPS S HMPU=""
 .I $O(^XTMP(HMPA,0,"META",HMPC,HMPU))="" S HMPX=HMPX_"}" ;US11019 - cater for zero entries
 .F  S HMPU=$O(^XTMP(HMPA,0,"META",HMPC,HMPU)) Q:HMPU']""  D
 ..N VAR0,VAR1
 ..S HMPS=$G(^XTMP(HMPA,0,"META",HMPC,HMPU)),VAR0=$P(HMPU,":",3),VAR1=$P(HMPU,":",4,99)
 ..I $L(HMPX)>20000 S HMPZ=HMPZ+1,^TMP("HMPF",$J,HMPFCNT,.3,HMPZ)=HMPX,HMPX=""
 ..S HMPX=HMPX_"""urn:va:"_VAR0_":"_VAR1_""""_":{"
 ..S HMPX=HMPX_"""stampTime"":"""_HMPS_""""_"}"
 ..S HMPX=HMPX_$S($O(^XTMP(HMPA,0,"META",HMPC,HMPU))="":"}",1:",")
 .S HMPX=HMPX_"},"
 .I $L(HMPX)>20000 S HMPZ=HMPZ+1,^TMP("HMPF",$J,HMPFCNT,.3,HMPZ)=HMPX,HMPX=""
 I HMPZ!($L(HMPX)>0) D  ;DE3759 avoid multiple edge case
 .I $L(HMPX)=0 S HMPX=^TMP("HMPF",$J,HMPFCNT,.3,HMPZ),^TMP("HMPF",$J,HMPFCNT,.3,HMPZ)=$E(HMPX,1,$L(HMPX)-1),HMPX="" ;DE3759
 .S HMPZ=HMPZ+1
 .S HMPX=$E(HMPX,1,$L(HMPX)-1)_"}}}}" D
 ..I $E(HMPX,$L(HMPX))="{" S HMPX=HMPX_"""seq"":"_OFFSET_",""total"":"_DOMSIZE
 ..E  S HMPX=HMPX_",""seq"":"_OFFSET_",""total"":"_DOMSIZE
 .S HMPX=HMPX_",""object"":"
 .S ^TMP("HMPF",$J,HMPFCNT,.3,HMPZ)=HMPX
 Q
 ;
 ;
METAOP(A) ; MetaStamp for operational data (within its own syncStart chunk)
 ; A = HMPFX~hmp-development-box~OPD
 ;
 ; HMPA = "HMPFX~hmp-development-box~"<DFN>
 ; HMPB = ZTASK# --> ^XTMP(HMPA,<ZTASK#>
 ; HMPC = Domain (e.g. "allergy") --> ^XTMP(HMPA,HMPB,<Domain>
 ; HMPD = Counter (sequential number) --> ^XTMP(HMPA,HMPB,HMPC,<Counter>
 ; HMPN = Subscript --> ^XTMP(HMPA,HMPB,HMPC,HMPD,<Subscript>
 ; HMPE = ^XTMP(HMPA,HMPB,HMPC,HMPD,HMPN)
 ; HMPF = Domain id (e.g. the "C877:3:751" part of "urn:va:allergy:C877:3:751"
 ; HMPID = pid --> <site-hash>;DFN (e.g. C877;3)
 ; HMPZ1 = DFN
 ; HMPP = $$PIDS^HMPDJFS(HMPZ1)  --> JSON construct containing pid, systemId, localId, icn
 ; HMPQ = " (double quote literal)
 ; HMPT = The "total" node from ^XTMP --> ^XTMP(HMPA,HMPB,HMPC,"total")
 ; HMPX = JSON construct for the entire metaStamp
 ; HMPW = Event timeStamp
 ; HMPY = $$EN^HMPSTMP("NOW")
 ; HMPZ = Counter for breaking up the large nodes into sub-nodes in ^TMP
 ;
 S U="^"
 N HMPA,HMPJ,HMPQ,HMPSEP,HMPZ,HMPDAT,HMPDAT1,HMPDOM,HMPDOM1,HMPEVT,HMPX,HMPTOT,HMPTSK,HMPMOR,HMPLAS,HMPMOR,HMPLAS
 S HMPA=$P(A,U,3),HMPQ="""",HMPZ=0,HMPSEP=","""
 S HMPCNT=$G(HMPCNT)+1,HMPJ=$P(HMPA,"~",1,2)_"~OPD"
 S HMPSEP=HMPQ
 S HMPTSK=$O(^XTMP(A,0)),HMPY=$$EN^HMPSTMP("NOW"),HMPID=$$SYS^HMPUTILS
 S HMPX="{""collection"":"""_"OPDsyncStart"_""""_","
 S HMPX=HMPX_"""metaStamp"":"_"{"
 S HMPX=HMPX_"""stampTime"":"""_HMPY_""""_",""sourceMetaStamp"":"_"{"
 S HMPX=HMPX_""""_$P(HMPID,";")_""""_":{"
 S HMPX=HMPX_"""stampTime"":"""_HMPY_""""_","
 S HMPX=HMPX_"""domainMetaStamp"""_":"_"{"
 ;Scan Domains
 S HMPC=""
 F  S HMPC=$O(^XTMP(HMPA,0,"META",HMPC)) Q:HMPC']""  D
 .S HMPX=HMPX_""""_HMPC_""""_":{"
 .S HMPX=HMPX_"""domain"":"""_HMPC_""""_","
 .S HMPX=HMPX_"""stampTime"":"""_HMPY_""""_","
 .S HMPD=0
 .S HMPX=HMPX_"""itemMetaStamp"""_":"_"{" ; Patient data
 .N HMPU,HMPS S HMPU=""
 .F  S HMPU=$O(^XTMP(HMPA,0,"META",HMPC,HMPU)) Q:HMPU']""  D
 ..N VAR0,VAR1
 ..S HMPS=$G(^XTMP(HMPA,0,"META",HMPC,HMPU)),VAR0=$P(HMPU,":",3),VAR1=$P(HMPU,":",4,99)
 ..I $L(HMPX)>20000 S HMPZ=HMPZ+1,^TMP("HMPF",$J,HMPFCNT,.3,HMPZ)=HMPX,HMPX=""
 ..S HMPX=HMPX_"""urn:va:"_VAR0_":"_VAR1_""""_":{"
 ..S HMPX=HMPX_"""stampTime"":"""_HMPS_""""_"}"
 ..S HMPX=HMPX_$S($O(^XTMP(HMPA,0,"META",HMPC,HMPU))="":"}",1:",")
 .S HMPX=HMPX_"},"
 .I $L(HMPX)>20000 S HMPZ=HMPZ+1,^TMP("HMPF",$J,HMPFCNT,.3,HMPZ)=HMPX,HMPX=""
 I HMPZ!($L(HMPX)>0) D  ;DE3759 avoid multiple edge case
 .I $L(HMPX)=0 S HMPX=^TMP("HMPF",$J,HMPFCNT,.3,HMPZ),^TMP("HMPF",$J,HMPFCNT,.3,HMPZ)=$E(HMPX,1,$L(HMPX)-1),HMPX="" ;DE3759
 .S HMPZ=HMPZ+1
 .S HMPX=$E(HMPX,1,$L(HMPX)-1)_"}}}}},{"
 .S ^TMP("HMPF",$J,HMPFCNT,.3,HMPZ)=HMPX
 Q
 ;
 ;
STATUS(STOP,HMPFHMP) ; Set HMP GLOBAL USAGE MONITOR status
 Q:$G(STOP)=""  Q:$G(HMPFHMP)=""
 N HMPFLG,HMPSTMP,HMPSRV
 S HMPSRV=$O(^HMP(800000,"B",HMPFHMP,"")) Q:'HMPSRV
 S HMPFLG=$P($G(^HMP(800000,HMPSRV,0)),U,5),HMPSTMP=$P($G(^HMP(800000,HMPSRV,0)),U,6)
 ;If stopped and already flagged as stopped do nothing
 I STOP,HMPFLG Q
 ;If stopped but not flagged as stopped set flag and timestamp
 I STOP,'HMPFLG D SET(STOP,HMPSRV) Q
 ;If running and flagged as stopped flag as running
 I 'STOP,HMPFLG D SET(STOP,HMPSRV) Q
 ;No action needed if running and not flagged as stop
 Q
 ;
SET(STOP,HMPSRV) ; Flag set/reset, Stamptime set
 Q:'$G(HMPSRV)
 L +^HMP(800000,HMPSRV,0):5 E  Q
 S $P(^HMP(800000,HMPSRV,0),U,5,6)=STOP_U_$$NOW^XLFDT
 L -^HMP(800000,HMPSRV,0)
 Q
 ;
CHECK(HMPFHMP) ; Check storage status and send MailMan message if appropriate
 ; Input HMPFHMP - server name
 Q:$G(HMPFHMP)=""
 N HMPDIFF,HMPFLG,HMPSRV,HMPSTTM
 S HMPSRV=$O(^HMP(800000,"B",HMPFHMP,"")) Q:'HMPSRV
 ; ^DD(800000,.05,0)="DISK USAGE STATUS^S^0:WITHIN LIMIT;1:EXCEEDED LIMIT;^0;5^Q"
 S HMPFLG=$P($G(^HMP(800000,HMPSRV,0)),U,5)
 ;No action required if status is not set
 I HMPFLG="" Q
 ; (#.06) DISK USAGE STATUS TIME [6D]
 S HMPSTTM=$P($G(^HMP(800000,HMPSRV,0)),U,6) Q:HMPSTTM=""
 ;quit if status time < five minutes ago
 I $$FMDIFF^XLFDT($$NOW^XLFDT,HMPSTTM,2)<300 Q
 ;Otherwise send message
 D MSG(HMPFLG)
 ; Clear DISK USAGE STATUS and DISK USAGE STATUS TIME
 L +^HMP(800000,HMPSRV,0):5 E  Q  ; quit if no lock
 S $P(^HMP(800000,HMPSRV,0),U,5,6)=""
 L -^HMP(800000,HMPSRV,0)
 Q
 ;
 ; DE6644: 2 MailMan message subroutines combined, 13 January 2017
MSG(HMPFLG) ; send email about space limit for ^XTMP("HMP*")
 Q:'$D(HMPFLG)  ; must have flag, if HMPFLG then limit exceeded
 ; 1 megabyte = 2**20 bytes = 1048576 bytes
 N HMPMSG,HMPRCPNT,HMPSUBJ,HMPTXT,MAX
 S MAX=$$GETMAX^HMPUTILS  ; system parameter: HMP EXTRACT DISK SIZE LIMIT
 S HMPSUBJ="HMP namepsace XTMP Global Size Monitor "_$S(HMPFLG:"PAUSE",1:"RESTART")_" alert"
 D MSGLN(.HMPTXT,"*ALERT*: eHMP storage in the ^XTMP global has")
 D MSGLN(.HMPTXT,$S(HMPFLG:"exceeded ",1:"been below ")_$FN(MAX,",")_" bytes ("_$J(MAX/1048576,2,2)_" MB) for more than 5 minutes.")
 D MSGLN(.HMPTXT,"eHMP subscribing was "_$S(HMPFLG:"PAUSED.",1:"RESTARTED.")),MSGLN(.HMPTXT," ")
 D MSGLN(.HMPTXT,"HMP* namespace data stored in ^XTMP is "_$J($P($$GETSIZE^HMPUTILS,"^")/1048576,2,2)_" MB.")
 D MSGLN(.HMPTXT," "),MSGLN(.HMPTXT,"eHMP ^XTMP space check made "_$$HTE^XLFDT($H)),MSGLN(.HMPTXT," ")
 I $G(ZTSK) D MSGLN(.HMPTXT,"TaskMan task number: "_ZTSK)  ; add task number if available
 D MSGLN(.HMPTXT," ")
 S HMPRCPNT("G.HMP IRM GROUP")="",HMPRCPNT(DUZ)=""
 D SENDMSG^XMXAPI(DUZ,HMPSUBJ,"HMPTXT",.HMPRCPNT,,.HMPMSG)  ; HMPMSG returned as message number
 Q
 ;
MSGLN(TXTARY,LN) ; add LN to TXTARY (passed by ref.) for MailMan message
 Q:'$L($G(LN))  ; must have some text
 S TXTARY(0)=$G(TXTARY(0))+1,TXTARY(TXTARY(0))=LN Q
 ;
