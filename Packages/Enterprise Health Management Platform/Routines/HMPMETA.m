HMPMETA ;SLC/PJH,ASM/RRB,CPC-collect domains, uids, & stamptimes ;2016-07-01 13:16Z
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**1,2**;Sep 01, 2011;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 quit  ; no entry from top of routine HMPMETA
 ;
 ; primary development
 ;
 ; original author: (pjh)
 ; additional author: Ray Blank (rrb)
 ; additional author: Frederick D. S. Marshall (toad)
 ; additional author: Chris P. Casey (cpc)
 ; original org: U.S. Department of Veterans Affairs (va)
 ; prime contractor ASM Research (asmr)
 ; other development orgs: VISTA Expertise Network (asmr-ven)
 ;
 ; 2013-08-14 va-islc/pjh: last update by VA before code transfered
 ; to asmr for eHMP contract.
 ;
 ; 2015-11-04 asmr/rrb: fix first three lines for sac compliance,
 ; [DE2818/RRB: SQA findings 1st 3 lines].
 ;
 ; 2016-03-29/04-13 asmr-ven/toad: change MESNOK to call
 ; $$GETSIZE^HMPMONX instead of $$GETSIZE^HMPUTILS; pass user # by
 ; reference; fix MESOK likewise, send e-mail to g.HMP IRM GROUP,
 ; refactor both, fix org.
 ;
 ; 2016-04-14 asmr/cpc [DE3759]: avoid multiple edge case in METAOP.
 ;
 ; 2016-04-14 asmr/bl HMP*2.0*2: update lines 2 & 3.
 ;
 ; 2016-06-30/07-01 ven/toad: XINDEX is four years behind 2012 VA SAC;
 ; convert variables in MESNOK & MESOK to uppercase; add EOR line;
 ; update dev history; add contents; repoint QUINIT from
 ; DQINIT^HMPDJFSP to DQINIT^HMPDJFSQ.
 ;
 ;
 ; contents
 ;
 ; ADD: Build array for metastamp
 ; DONE: Check if metastamp compile is complete
 ; $$OPD = Check if OPD metastamp is ready to collect
 ; INIT: Set metastamp status as in progress
 ; UPD: Update metastamp domain as complete
 ; MERGE1: US11019 Merge a single domain
 ; MERGE: Merge metastamp data into XTMP, mark domain complete
 ; METAPT: MetaStamp for patient data
 ; METAOP: MetaStamp for operational data
 ; STATUS: Set HMP GLOBAL USAGE MONITOR status
 ; SET: Flag set/reset, Stamptime set
 ; CHECK: Check status, send HMP GLOBAL USAGE MONITOR message
 ; MESNOK: e-mail if space limit on ^xtmp breached
 ; MESOK: e-mail if space limit on ^xtmp breached
 ; EN: Build XTMP for patient
 ; QUINIT: Queue the initial extracts for a patient
 ; UNSUB: Unsubscribe
 ;
 ;
 ; New routine for US6734
 ;
 ;
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
 .S:$G(^XTMP(HMPBATCH,0,"MSTA",HMPDOM))=0 HMPCOMP=0
 Q HMPCOMP
 ;
 ;
OPD(HMPFHMP) ;Check if OPD metastamp is ready to collect
 Q $S($$DONE("OPD","HMPFX~"_HMPFHMP_"~OPD"):1,1:0)
 ;
 ;
INIT(HMPBATCH,HMPFDFN,ARGS) ; Set metastamp status as in progress
 N DOMAINS
 ; set up domains to extract
 D @($S(HMPFDFN="OPD":"OPDOMS",1:"PTDOMS")_"^HMPDJFSD(.DOMAINS)")
 I $G(ARGS("domains"))'="" D
 . S I=""
 . F I=1:1 Q:'$D(DOMAINS(I))  D
 .. I ARGS("domains")'[DOMAINS(I) K DOMAINS(I)
 N HMPDOM,I
 F I=1:1 S HMPDOM=$G(DOMAINS(I)) Q:HMPDOM=""  S ^XTMP(HMPBATCH,0,"MSTA",HMPDOM)=0
 Q
 ;
 ;
UPD(HMPDOM) ; Update metastamp domain as complete
 S ^XTMP(HMPBATCH,0,"MSTA",HMPDOM)=1
 Q
 ;
 ;
MERGE1(HMPBATCH,HMPDOM) ; US11019 Merge a single domain
 M ^XTMP(HMPBATCH,0,"META",HMPDOM)=^TMP("HMPMETA",$J,HMPDOM)
 K ^TMP("HMPMETA",$J,HMPDOM)
 Q
 ;
 ;
MERGE(HMPBATCH) ; Merge metastamp data into XTMP and mark domain complete in metastamp
 ;Formatting of metastamp into JSON format by HMPMETA goes here when ready
 N HMPDOM
 S HMPDOM="PATIENT"
 F  S HMPDOM=$O(^TMP("HMPMETA",$J,HMPDOM)) Q:HMPDOM=""  D
 .M ^XTMP(HMPBATCH,0,"META",HMPDOM)=^TMP("HMPMETA",$J,HMPDOM)
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
 ; --Local variables
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
 I '$D(U) S U="^"
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
 ; --Local variables
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
 I '$D(U) S U="^"
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
 ;
SET(STOP,HMPSRV) ; Flag set/reset, Stamptime set
 Q:'$G(HMPSRV)
 L +^HMP(800000,HMPSRV,0):5 E  Q
 S $P(^HMP(800000,HMPSRV,0),U,5,6)=STOP_U_$$NOW^XLFDT
 L -^HMP(800000,HMPSRV,0)
 Q
 ;
 ;
CHECK(HMPFHMP) ; Check status and send HMP GLOBAL USAGE MONITOR message if appropriate
 ; Input HMPFHMP - server name
 Q:$G(HMPFHMP)=""
 N HMPFLG,HMPSTMP,HMPDIFF,HMPSRV
 S HMPSRV=$O(^HMP(800000,"B",HMPFHMP,"")) Q:'HMPSRV
 S HMPFLG=$P($G(^HMP(800000,HMPSRV,0)),U,5)
 ;No action required if status is not set
 I HMPFLG="" Q
 ;Get stamptime
 S HMPSTMP=$P($G(^HMP(800000,HMPSRV,0)),U,6) Q:HMPSTMP=""
 ;If stamptime < five minutes ago no action
 I $$FMDIFF^XLFDT($$NOW^XLFDT,HMPSTMP,2)<300 Q
 ;Otherwise send message
 D:HMPFLG MESNOK
 D:'HMPFLG MESOK
 ;Clear DISK USAGE STATUS and DISK USAGE STATUS TIME in subscription file
 L +^HMP(800000,HMPSRV,0):5 E  Q
 S $P(^HMP(800000,HMPSRV,0),U,5,6)=""
 L -^HMP(800000,HMPSRV,0):5
 Q
 ;
 ;
MESNOK ; e-mail if space limit on ^xtmp breached
 ;islc/pjh,ven/toad;private;procedure;clean;silent;sac
 ; called by:
 ;   CHECK
 ; calls:
 ;   $$GETSIZE^HMPMONX = size of ehmp's usage of ^xtmp
 ;   $$GETMAX^HMPDJFSP = max size of that usage allowed
 ;   $$NOW^XLFDT = current date-time in fileman format
 ;   $$FMTE^XLFDT = convert fileman date-time to external
 ;   SENDMSG^XMXAPI: send e-mail
 ; input:
 ;   from the database, within $$GETSIZE & $$GETMAX
 ; output:
 ;  e-mail created & sent to g.HMP IRM GROUP
 ; examples:
 ;   [develop examples]
 ; to do:
 ;   convert this message and the one in MESOK to bulletins
 ;
 new HMPUSER set HMPUSER=.5 ; send as postmaster
 set HMPUSER(0)="@" ; with programmer privileges
 new SUBJECT set SUBJECT="HMP GLOBAL USAGE MONITOR"
 ;
 new TEXT set TEXT="HMPTEXT"
 new HMPTEXT
 do
 . ; estimated usage of ^xtmp:
 . new SIZE set SIZE=$justify($piece($$GETSIZE^HMPMONX,",")/1000000,2,2)
 . ; maximum usage allowed:
 . new MAX set MAX=$justify($$GETMAX^HMPDJFSP/1000000,2,2)
 . set HMPTEXT(1)="Alert: eHMP usage of global ^XTMP has exceeded "
 . set HMPTEXT(1)=HMPTEXT(1)_MAX_" MB for more than 5 minutes."
 . set HMPTEXT(2)=" "
 . set HMPTEXT(3)="       eHMP subscribing is paused."
 . set HMPTEXT(4)=" "
 . set HMPTEXT(5)="       eHMP usage of global ^XTMP is "_SIZE_" MB."
 . set HMPTEXT(6)=" "
 . set HMPTEXT(7)="       Disk space check at "_$$FMTE^XLFDT($$NOW^XLFDT)
 . set HMPTEXT(8)=" "
 . quit
 ;
 new HMPRECIP set HMPRECIP("HMP IRM GROUP")=""
 new HMPMSG
 ;
 do SENDMSG^XMXAPI(.HMPUSER,SUBJECT,TEXT,.HMPRECIP,,.HMPMSG)
 ;
 quit  ; end of MESNOK
 ;
 ;
MESOK ; e-mail if space limit on ^xtmp breached
 ;islc/pjh,ven/toad;private;procedure;clean;silent;sac
 ; called by:
 ;   CHECK
 ; calls:
 ;   $$GETMAX^HMPDJFSP = max size of that usage allowed
 ;   $$NOW^XLFDT = current date-time in fileman format
 ;   $$FMTE^XLFDT = convert fileman date-time to external
 ;   SENDMSG^XMXAPI: send e-mail
 ; input:
 ;   from the database, within $$GETMAX
 ; output:
 ;  e-mail created & sent to g.HMP IRM GROUP
 ; examples:
 ;   [develop examples]
 ; to do:
 ;   convert this message and the one in MESNOK to bulletins
 ;
 new HMPUSER set HMPUSER=.5 ; send as postmaster
 set HMPUSER(0)="@" ; with programmer privileges
 new SUBJECT set SUBJECT="HMP GLOBAL USAGE MONITOR"
 ;
 new TEXT set TEXT="HMPTEXT"
 new HMPTEXT
 do
 . ; maximum usage allowed:
 . new MAX set MAX=$justify($$GETMAX^HMPDJFSP/1000000,2,2)
 . set HMPTEXT(1)="Alert: eHMP usage of global ^XTMP has been below "
 . set HMPTEXT(1)=HMPTEXT(1)_MAX_" MB for more than 5 minutes."
 . set HMPTEXT(2)=" "
 . set HMPTEXT(3)="       eHMP subscribing is restarted."
 . set HMPTEXT(4)=" "
 . set HMPTEXT(7)="       Disk space check at "_$$FMTE^XLFDT($$NOW^XLFDT)
 . set HMPTEXT(8)=" "
 . quit
 ;
 new HMPRECIP set HMPRECIP("HMP IRM GROUP")=""
 new HMPMSG
 ;
 do SENDMSG^XMXAPI(.HMPUSER,SUBJECT,TEXT,.HMPRECIP,,.HMPMSG)
 ;
 quit  ; end of MESOK
 ;
 ;
 ;Following tags used by VPRJTT0 unit test routines
 ;-------------------------------------------------
EN(HMPFDFN) ;Build XTMP for patient
 I $G(HMPFDFN)="" D MES^XPDUTL("No patient specified, call as D EN^HMPMETA(DFN)") Q
 N ARGS,DOMAINS,HMPSRV,NEWSUB,HMPFERR,HMPBATCH,HMPSTMP,SEQNODE,ZTSK,ZTQUEUED
 ;Select domains to compile
 ;OPD domains
 ;asu-class#asu-rule#category#charttab#displaygroup#doc-def#labgroup#labpanel#location#orderable#page#pt-select#
 ;personphoto#pointofcare#quick#roster#route#schedule#team#teamposition#user#usertabprefs#viewdefdef#
 ;viewdefdefcoldefconfigtemplate#immunization-list#allergy-list#signssymptoms-list#vitaltypes-list#
 ;vitalqualifier-list#vitalcategory-list
 ;Patient domains
 ;allergy#vital#problem#order#treatment#patient#consult#procedure#obs#visit#appointment#ptf#med#lab#
 ;image#surgery#document#mh#
 ;Patient PCE domains
 ;auxiliary#diagnosis#factor#immunization#task#vital#exam#cpt#education#pov#skin
 ;S ARGS("domains")="allergy#asu-class"
 ;
 ;Modify SEQNODE to extract required patient
 S SEQNODE=HMPFDFN_"^syncStart^HMPFX~hmp-development-box~"_HMPFDFN_"^^64671"
 S HMPBATCH=$P(SEQNODE,U,3),HMPSRV=$P(HMPBATCH,"~",2)
 S HMPSRV("ien")=$O(^HMP(800000,"B",HMPSRV,0)) Q:'HMPSRV("ien")
 ;Unsubscribe patient and clear cache
 D UNSUB(HMPFDFN,HMPSRV("ien")) K ^XTMP(HMPBATCH)
 ;Clear metastamp array
 K ^TMP("HMPMETA",$J)
 ; set up domains to extract
 D @($S(HMPFDFN="OPD":"OPDOMS",1:"PTDOMS")_"^HMPDJFSD(.DOMAINS)")
 ;Clear unwanted domains
 I $G(ARGS("domains"))'="" N I F I=1:1 Q:'$D(DOMAINS(I))  K:ARGS("domains")'[DOMAINS(I) DOMAINS(I)
 ;
 ; see if this is new subscription and task extract if new
 D SETPAT^HMPDJFSP(HMPFDFN,HMPSRV,.NEWSUB) Q:$G(HMPFERR) ""
 ;For operational data set stamptime as time subscription placed
 S:HMPFDFN="OPD" HMPSTMP=$$JSONDT^HMPUTILS($$NOW^XLFDT)
 I NEWSUB D  Q:$G(HMPFERR) ""
 . I HMPFDFN="OPD" D  ; queue each operational domain
 . . S I="" F  S I=$O(DOMAINS(I)) Q:'I  D
 . . . N HMPFDOM
 . . . S HMPFDOM(1)=DOMAINS(I)
 . . . D QUINIT(HMPBATCH,HMPFDFN,.HMPFDOM)
 . E  D  ; queue all domains for patient
 . . N HMPFDOM
 . . M HMPFDOM=DOMAINS
 . . ; if patients extracts are held (version mismatch), put DFN on wait list
 . . I $G(^XTMP("HMPFS~"_HMPSRV("ien"),"waiting")) S ^XTMP("HMPFS~"_HMPSRV("ien"),"waiting",HMPFDFN)="" QUIT
 . . ; otherwise queue patient
 . . D QUINIT(HMPBATCH,HMPFDFN,.HMPFDOM)
 Q
 ;
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
 ; only done once when beginning the batch, no matter how many tasked jobs
 L +^XTMP(HMPBATCH):5 E  D SETERR^HMPDJFS("Cannot lock batch:"_HMPBATCH) QUIT
 I '$D(^XTMP(HMPBATCH)) D
 . D NEWXTMP^HMPDJFS(HMPBATCH,2,"HMP Patient Extract")
 . I $G(ARGS("jobId"))]"" S ^XTMP(HMPBATCH,"JOBID")=ARGS("jobId")  ;US3907
 . I $G(ARGS("rootJobId"))]"" S ^XTMP(HMPBATCH,"ROOTJOBID")=ARGS("rootJobId")  ;US3907
 . S ^XTMP(HMPBATCH,0,"time")=$H
 . D SETMARK^HMPDJFSP("Start",HMPFDFN,HMPBATCH) ; sends full demographics
 L -^XTMP(HMPBATCH)
 ;
 ; set up the domains to be done by this task
 N I S I=0 F  S I=$O(HMPFDOM(I)) Q:'I  D SETDOM^HMPDJFSP("status",HMPFDOM(I),0)
 ;
 ;Call compile in foreground
 S ZTSK=$J,^XTMP(HMPBATCH,0,"task",ZTSK)=$H,ZTQUEUED="1" D DQINIT^HMPDJFSQ U 0
 Q
 ;
 ;
UNSUB(DFN,SRV) ;Unsubscribe
 ;Operational Data subscription
 I DFN="OPD" D UPDOPD^HMPDJFSP(SRV,"@") Q
 ;Patient subscription
 N DA,DIK
 S DA=DFN,DA(1)=SRV
 S DIK="^HMP(800000,"_DA(1)_",1,"
 D ^DIK
 Q
 ;
 ;
EOR ; end of routine HMPMETA
