HLEVAPI3 ;O-OIFO/LJA/PIJ - Event Monitor APIs ;12/08/2010
 ;;1.6;HEALTH LEVEL SEVEN;**109,153**;Oct 13, 1995;Build 11
 ;Per VHA Directive 2004-038, this routine should not be modified.
EVENTONE(HLEVIENM,HLEVNM,HLEVIENE) ; Master job check of an event...
 ; ZTSKMST -- req
 N CONT,CURR,CURRNOW,IEN,LAPSEMIN,LASTRUN,MAILGRP,MCHECK,MSTART,NO,NODE
 N NODE0,NODE40,PAR1,PAR2,PAR3,PAR4,PAR5,PAR6,PAR7,PAR8,RUNNOW
 N START,STAT,ZTDESC,ZTDTH,ZTIO,ZTRTN
 ;
 S NODE0=$G(^HLEV(776.1,+$G(HLEVIENE),0))
 I NODE0']"" D RECEVM(HLEVIENM,HLEVIENE,"X^NO-0-NODE") QUIT  ;->
 S STAT=$P(NODE0,U,2) I STAT'="A" D RECEVM(HLEVIENM,HLEVIENE,"I") QUIT  ;->
 ; Requeue minutes for monitor...
 S LAPSE=$P(NODE0,U,4) I LAPSE'?1.N D RECEVM(HLEVIENM,HLEVIENE,"X^INVALID-LAPSE") QUIT  ;->
 ;
 ; Required M TAG^RTN for monitor...
 S MSTART=$TR($P(NODE0,U,6),"~",U) I '$$OKMCODE^HLEVAPI0(MSTART) D  QUIT  ;->
 .  D RECEVM(HLEVIENM,HLEVIENE,"X^INVALID-M ["_$TR(MSTART,U,"~")_"]")
 ;
 ; Optional M $$EXTFUNCTION^RTN for determining whether new job should start
 S MCHECK=$TR($P(NODE0,U,7),"~",U)
 ;
 ; If M check for start code exists, but is not valid M code, quit...
 I MCHECK]"",'$$OKMCODE^HLEVAPI0($P(MCHECK,"$$",2,99)) D  QUIT  ;->
 .  D RECEVM(HLEVIENM,HLEVIENE,"X-INVALID-M-CHK ["_$TR(MCHECK,U,"~")_"]")
 ;
 ; When last run (started)?  Return NULL if not completed...
 S IEN=$O(^HLEV(776,"M",+HLEVIENE,":"),-1)
 S (NODE,LASTRUN(1))=$G(^HLEV(776,+IEN,0))
 S LASTRUN=$P(NODE,U),LASTRUN=$S(LASTRUN?7N1"."1.N:LASTRUN,1:"")
 S X=$P(NODE,U,2) I X?7N1"."1.N S LASTRUN=X
 ;
 ; Set start new job default to YES...
 S CONT=1
 ;
 ; If M start check code doesn't exist, check usual fields...
 I MCHECK']"" D  QUIT:'CONT  ;->
 .
 .  ;Start new monitor if last job running and timestamp is current,
 .  ;or monitor never run...
 .
 .  ; Never run, so start new monitor...
 .  QUIT:LASTRUN']""
 .
 .  ; Monitor running now, and is current, so don't do anything...
 .  S CURRNOW=$$CURR^HLEVAPI1(+IEN) I CURRNOW D  QUIT  ;->
 .  .  I CURRNOW S CONT=0
 .  .  D RECEVM(HLEVIENM,HLEVIENE,"R") ; Monitor running already...
 .
 .  ; Monitor run, and if time to run new monitor, quit...
 .  S RUNNOW=$$RUNEV^HLEVAPI0(LASTRUN,LAPSE) QUIT:RUNNOW  ;->
 .
 .  S CONT=0 ; Set "no new monitor job needed" variable...
 .  D RECEVM(HLEVIENM,HLEVIENE,"E") QUIT  ;-> Too early...
 ;
 I MCHECK]"" D  QUIT:'CONT  ;->
 .  N HLEVRUN
 .  D RUNS(HLEVIENE,.HLEVRUN) ; Define recent monitor runs for API call...
 .  S CONT="S CONT="_MCHECK X CONT
 .  S CONT=$S(CONT=1:1,1:0) QUIT:CONT  ;->
 .  D RECEVM(HLEVIENM,HLEVIENE,"M") ; Package API check failed...
 ;
 S HLEVIENJ=$$NEWEVENT^HLEVAPI(HLEVIENE) I HLEVIENJ'>0 D  QUIT  ;->
 .  KILL HLPAR1D,HLPAR2D,HLPAR3D,HLPAR4D,HLPAR5D,HLPAR6D,HLPAR7D,HLPAR8D
 ;
 ; Queue a new job...
 S ZTIO="",ZTDTH=$H,ZTDESC="HL Event Monitor - #"_HLEVIENE
 S ZTRTN="QUEUEV^HLEVAPI3"
 S ZTSAVE("HLEVIENJ")="",ZTSAVE("HLEVIENE")=""
 S ZTSAVE("HLEVNM")="",ZTSAVE("HLEVIENM")=""
 D ^%ZTLOAD
 ;
 ; Save info in 776.2...
 D RECEVM(HLEVIENM,HLEVIENE,"Q",ZTSK,+HLEVIENJ)
 ;
 ; Save task number in 776...
 D UPDFLDE^HLEVAPI(+HLEVIENJ,8,ZTSK)
 ;
 ; Reset back...
 S ZTSK=ZTSKMST
 ;
 QUIT
 ;
RUNS(HLEVIENE,RUN) ; Find latest 10 runs for calling API...
 N CT,IEN,NODE
 KILL RUN
 S CT=0,IEN=":"
 F  S IEN=$O(^HLEV(776,"M",HLEVIENE,IEN),-1) Q:'IEN  D  QUIT:CT>9
 .  S NODE=$G(^HLEV(776,+IEN,0)) QUIT:NODE']""  ;->
 .  S CT=CT+1
 .  S RUN(CT)=NODE
 Q
 ;
RECEVM(HLEVIENM,HLEVIENE,RES,ZTSK,HLEVIENJ) ;
 N CT,DATA,REA
 ;
 I $E(RES)="X" S REA=$P(RES,U,2),RES="X"
 ;
 S RES=$S($G(RES)]"":RES,1:"?")
 S NOEVCHK(RES)=$G(NOEVCHK(RES))+1
 ;
 QUIT:$G(^HLEV(776.2,+$G(HLEVIENM),0))']""  ;->
 QUIT:$G(^HLEV(776.1,+$G(HLEVIENE),0))']""  ;->
 ;
 S CT=$O(^HLEV(776.2,+HLEVIENM,51,":"),-1)+1
 S ^HLEV(776.2,+HLEVIENM,51,0)="^776.2051PA^"_CT_U_CT
 S DATA=HLEVIENE_U_$G(RES)_U_$$NOW^XLFDT
 I $G(ZTSK) S $P(DATA,U,4)=ZTSK
 I $G(REA)]"" S $P(DATA,U,7)=REA
 I $G(HLEVIENJ)>0 S $P(DATA,U,8)=HLEVIENJ
 S ^HLEV(776.2,+HLEVIENM,51,+CT,0)=DATA
 S ^HLEV(776.2,+HLEVIENM,51,"B",HLEVIENE,CT)=""
 ;
 Q
 ;
QUEUEV ; Queued event job starts here...
 ; HLEVIENE,HLEVIENJ,HLEVIENM -- req
 N EVMCODE,EVMGRP,EVNAME,NODE,EVPAR1,EVPAR2,EVPAR3,EVPAR4,EVPAR5
 N EVPAR6,DVPAR7,EVPAR8
 ;
 S ZTREQ="@"
 ;
 ; Mark RUNNING before doing anything else...
 D EVRES^HLEVAPI0(+HLEVIENM,+HLEVIENE,"R",+HLEVIENJ)
 ;
 ;*** P153 START CJM ***
 L +^HLEV(776.1,+$G(HLEVIENE),0):1 Q:'$T
 ;*** P153 END CJM
 S NODE=$G(^HLEV(776.1,+$G(HLEVIENE),0)) I NODE']"" D  QUIT  ;->
 .  D EVRES^HLEVAPI0(+HLEVIENM,+HLEVIENE,"XE",+HLEVIENJ)
 .  ;*** Begin HL7*1.6*153 - pij ***
 .  L -^HLEV(776.1,+$G(HLEVIENE),0)
 .  ;*** End HL7*1.6*153 - pij ***
 S EVNAME=$P(NODE,U),EVMGRP=$P(NODE,U,5)
 S EVMCODE=$TR($P(NODE,U,6),"~",U) I EVMCODE'?1.8E1"^"1.8E D  QUIT  ;->
 .  D EVRES^HLEVAPI0(+HLEVIENM,+HLEVIENE,"XE",+HLEVIENJ)
 .  ;*** Begin HL7*1.6*153 - pij ***
 .  L -^HLEV(776.1,+$G(HLEVIENE),0)
 .  ;*** End HL7*1.6*153 - pij ***
 ;
 ; Node 40...
 S NODE40=$G(^HLEV(776.1,+HLEVIENE,40))
 F NO=1:1:8 S @("EVPAR"_NO)=$P(NODE40,U,NO)
 ;
 ; Final M code check...
 I '$$OKMCODE^HLEVAPI0(EVMCODE) D  QUIT  ;->
 .  D EVRES^HLEVAPI0(+HLEVIENM,+HLEVIENE,"XM",+HLEVIENJ)
 .  ;*** Begin HL7*1.6*153 - pij ***
 .  L -^HLEV(776.1,+$G(HLEVIENE),0)
 .  ;*** End HL7*1.6*153 - pij ***
 ;
 D @EVMCODE
 ;*** Begin HL7*1.6*153 - pij ***
 L -^HLEV(776.1,+$G(HLEVIENE),0)
 ;*** End HL7*1.6*153 - pij ***
 ;
 D EVRES^HLEVAPI0(+HLEVIENM,+HLEVIENE,"F",+HLEVIENJ)
 ;
 Q
 ;
MAILIT ; Generic mail out call...
 ; HLEVIENE,HLEVIENJ -- req
 ; XMY(...) can be created before this call...
 N MGRP
 ;
 D DEBUG^HLEVAPI2("MAILIT") ; Debug data created conditionally
 ;
 ; Stop all event monitoring to enable on-site debugging...
 QUIT:$G(^TMP("HLEVFLAG",$J))["STOP"  ;->
 ;
 D ADDXMYS^HLEVAPI2(HLEVIENE,$G(XTMP))
 ;
 ; If no mail group, and no passed in XMY, use DUZ...
 I '$D(XMY),$G(DUZ)>0 S XMY(DUZ)=""
 ;
 QUIT:'$D(XMY)
 ;
 D SENDMAIL^HLEVAPI(HLEVIENE,+$G(HLEVIENJ),.XMY) ; Use generic email...
 ;
 KILL XMSUB,XMTEXT,XMY
 ;
 Q
 ;
MONFLAG(VAL) ; Set ^TMP("HLEVFLAG",$J), or return it's value...
 ; User may pass in the following values for VAL...
 ;
 ; * ABORT,STOP   -> Will set ^TMP("HLEVFLAG",$J)="STOP"
 ; * START,RUN,XEC -> Will kill ^TMP("HLEVFLAG",$J)
 ; * SHOW,"" -> Will return value of ^TMP("HLEVFLAG",$J)
 ;
 ; What did user pass in?  
 S VAL=$$UP^XLFSTR($G(VAL))
 S VAL=$S(VAL="STOP":"STOP",VAL="ABORT":"STOP",VAL="SET":"STOP",VAL="KILL":"@",VAL="START":"@",VAL="RUN":"@",VAL="XEC":"@",1:"")
 ;
 I VAL']"" QUIT $G(^TMP("HLEVFLAG",$J)) ;-> Just show value...
 I VAL="@" KILL ^TMP("HLEVFLAG",$J) QUIT "" ;->
 I VAL="STOP" S ^TMP("HLEVFLAG",$J)="STOP" QUIT "STOP" ;->
 ;
 Q $G(^TMP("HLEVFLAG",$J))
 ;
COUNT(MON,STATUS,GBL,LIM) ; Number of entries for monitor with STATUS...
 ;
 ; Pass in... MON    -> Name or IEN of monitor
 ;
 ;            STATUS -> 776's STATUS field code or full expansion
 ;                      -- Default = RUNNING
 ;                      -- Pass in ALL for all entries
 ;
 ;            [GBL]  -> Global for entry storage. [OPTIONAL]
 ;                      Creates @GBL@(#)=IEN ~ 776 zero node
 ;                      (KILL @GBL at beginning!)
 ;
 ;            [LIM]  -> Limit to # entries/status to store in GBL.
 ;                     
 ;
 ; Examples:  
 ; 
 ; $$COUNT("FAST HL7 PURGE #2") -> # events running (default)
 ; $$COUNT("FAST HL7 PURGE #2","R") -> # events running
 ; $$COUNT("FAST HL7 PURGE #2","ALL") -> # events of all statuses
 ;
 ; The call...  $$COUNT("FAST HL7 PURGE #2","ALL","HLEV",1)
 ;
 ; Returns...   (1) # event entries that exist of all statuses.
 ;              (2) Stores entries in HLEV(#)=zero node
 ;              (3) Stores only the most recent entry (LIM=1)
 ;
 ;              If LIM>2, for example, the most recent two entries
 ;              would be returned.  But, note that the subscripting
 ;              is not oldest to newest, but newest (with subscript 
 ;              of 1) to oldest (with subscript of 2.)
 ;
 N CT,IEN,NO
 ;
 QUIT:$G(MON)']"" "" ;->
 S:$G(STATUS)']"" STATUS="R" ; Default to RUNNING...
 S:STATUS="ALL" STATUS="EFQR"
 I STATUS'="EFQR" S STATUS=$$UP^XLFSTR($E($G(STATUS)_" "))
 QUIT:"EFQR"'[STATUS "" ;->
 ;
 ; If passed GBL, check/set limit..
 S GBL=$G(GBL),LIM=$G(LIM)
 S LIM=$S(LIM:LIM,1:999999)
 ;
 ; It's OK to pass in the IEN...
 I MON'=+MON S MON=$O(^HLEV(776.1,"B",MON,0)) QUIT:MON'>0 "" ;->
 ;
 ; Remove any data hanging around from before call...
 I GBL]"" KILL @GBL
 ;
 S CT=0,IEN=":"
 F  S IEN=$O(^HLEV(776,"M",+MON,IEN),-1) Q:'IEN  D
 .  S DATA=$G(^HLEV(776,+IEN,0))
 .  ; Don't count if doesn't even have a status!
 .  QUIT:$P(DATA,U,4)']""  ;->
 .  ; If STATUS="EFQR", every status should be counted...
 .  I STATUS'="EFQR" QUIT:$P(DATA,U,4)'=STATUS  ;->
 .  S CT=CT+1
 .  QUIT:$G(GBL)']""  ;-> Don't store and return...
 .  S CT(1)=$O(@GBL@($P(DATA,U,4),":"),-1)+1
 .  QUIT:CT(1)>LIM  ;->
 .  S @GBL@($P(DATA,U,4),+CT(1))=IEN_"~"_DATA
 ;
 Q $S(CT:CT,1:"")
 ;
MARKERR ; Mark any RUNNING, but non-current entry's status to ERROR...
 N DATA,IEN776,HLEVIENE,HLEVIENM,STAT
 ;
 S IEN776=0
 F  S IEN776=$O(^HLEV(776,IEN776)) Q:'IEN776  D
 .  S DATA=$G(^HLEV(776,+IEN776,0))
 .  S STAT=$P(DATA,U,4) QUIT:STAT'="R"&(STAT'="Q")  ;->
 .  QUIT:$$CURR^HLEVAPI1(+IEN776)  ;->
 .  S HLEVIENE=$P(DATA,U,3) QUIT:$G(^HLEV(776.1,+HLEVIENE,0))']""  ;->
 .  S HLEVIENM=$P(DATA,U,9) QUIT:$G(^HLEV(776.2,+HLEVIENM,0))']""  ;->
 .  D EVRES^HLEVAPI0(HLEVIENM,HLEVIENE,"XE",IEN776)
 ;
 Q
 ;
EOR ;HLEVAPI3 - Event Monitor APIs ;5/16/03 14:42
