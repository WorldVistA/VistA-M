HLEVAPI2 ;O-OIFO/LJA - Event Monitor APIs ;02/04/2004 14:42
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
VARLIST(HLEVIENJ,SUB) ; Return event variable information in ^TMP($J,SUB)...
 N CT,DATA,EXP,MIEN,VAL,VAR
 ;
 QUIT:$G(^HLEV(776,+$G(HLEVIENJ),0))']"" "" ;->
 ;
 S MIEN=0,CT=""
 F  S MIEN=$O(^HLEV(776,HLEVIENJ,52,MIEN)) Q:MIEN'>0  D
 .  S CT=CT+1
 .  S DATA=$G(^HLEV(776,+HLEVIENJ,52,+MIEN,0))
 .  S VAR=$P(DATA,U),EXP=$P(DATA,U,2)
 .  S VAL=$G(^HLEV(776,+HLEVIENJ,52,+MIEN,52))
 .  S ^TMP($J,SUB,VAR,"V")=VAL
 .  I EXP]"" S ^TMP($J,SUB,VAR,"E")=EXP
 ;
 Q CT
 ;
PREVENT(HLEVIENE,SUB,STATUS) ; Return <PR>evious <event> runs in ^TMP($J,SUB)
 N CT,DATA,IEN
 ;
 S HLEVIENE=$G(HLEVIENE) QUIT:HLEVIENE']"" "" ;->
 QUIT:$G(SUB)']"" "" ;->
 ;
 S STATUS=$$UP^XLFSTR($E($G(STATUS)))
 ;
 ; Maybe passed in the event name...
 I HLEVIENE'=+HLEVIENE D  QUIT:HLEVIENE'>0 "" ;->
 .  S HLEVIENE=$O(^HLEV(776.1,"B",HLEVIENE,0))
 ;
 ; Loop thru entries...
 S IEN=0,CT=0
 F  S IEN=$O(^HLEV(776,"M",+HLEVIENE,IEN)) Q:IEN'>0  D
 .  S DATA=$G(^HLEV(776,+IEN,0)) QUIT:DATA']""  ;->
 .  I STATUS]"",$P(DATA,U,4)'=STATUS QUIT  ;->
 .  S CT=CT+1
 .  S X=$P(DATA,U,4),STATUS(1)=$S(X]"":X,1:"?")
 .  S ^TMP($J,SUB,"D",IEN)=DATA
 .  S ^TMP($J,SUB,"S",STATUS(1),IEN)=""
 ;
 Q CT
 ;
EVCHKD(HLEVIENM,HLEVIENE,HLEVIENJ,STATUS) ; Event code finished.  Mark event check multiple in 776.2 done...
 ; ZTSK -- req
 N DATA,MIEN
 ;
 QUIT:HLEVIENM=9999999  ;-> No master job...
 ; Not usually passed.  But, passed by ABORT^HLEVAPI...
 S STATUS=$S($G(STATUS)]"":$E(STATUS),1:"F")
 ;
 S MIEN=$O(^HLEV(776.2,+$G(HLEVIENM),51,"B",+$G(HLEVIENE),":"),-1) QUIT:MIEN'>0  ;->
 S DATA=$G(^HLEV(776.2,+HLEVIENM,51,+MIEN,0)) QUIT:$P(DATA,U,4)'=$G(ZTSK)  ;->
 S $P(DATA,U,5)=STATUS,$P(DATA,U,6)=$$NOW^XLFDT,$P(DATA,U,8)=$G(HLEVIENJ)
 S ^HLEV(776.2,+HLEVIENM,51,+MIEN,0)=DATA
 Q
 ;
ADDXMYS(HLEVIENE,XTMP) ; Set up XMY()s...
 N DATA,MIEN,MONM,NODE,RECIP
 ;
 ; Any recipients built into monitor?
 F NODE=60,61,62 D
 .  S MIEN=0
 .  F  S MIEN=$O(^HLEV(776.1,+HLEVIENE,+NODE,MIEN)) Q:MIEN'>0  D
 .  .  S DATA=$P($G(^HLEV(776.1,+HLEVIENE,+NODE,+MIEN,0)),U) QUIT:DATA']""  ;->
 .  .  I NODE=60 S DATA=$P($G(^XMB(3.8,+DATA,0)),U),DATA=$S(DATA]"":"G."_DATA,1:"") QUIT:DATA']""  ;->
 .  .  S XMY(DATA)=""
 ;
 ; Any recipients passed in in data request?
 QUIT:$G(XTMP)']""  ;->
 S MONM=$P($G(^HLEV(776.1,+HLEVIENE,0)),U) QUIT:MONM']""  ;->
 S RECIP=""
 F  S RECIP=$O(^XTMP(XTMP,"MONREQ","MON",+HLEVIENE,RECIP)) Q:RECIP']""  D
 .  S XMY(RECIP)=""
 ;
 Q
 ;
MGRP(HLEVIENE) ; Return G.MAIL-GROUP...
 N MGRP
 S MGRP=$P($G(^HLEV(776.1,+$G(HLEVIENE),0)),U,5)
 S MGRP=$P($G(^XMB(3.8,+MGRP,0)),U) QUIT:MGRP']"" "" ;->
 Q "G."_MGRP
 ;
LOADBODY(HLEVIENJ,SVSUB) ; Load body into global to mail...
 N END,NODE,P1,P2,P3,P4,P5,P6,P7,PCE,START,TXT
 ;
 S SVSUB=$S($G(SVSUB)]"":SVSUB,1:"HLMAILMSG")
 ;
 S NODE=$G(^HLEV(776,+HLEVIENJ,0))
 F PCE=1:1:7 S @("P"_PCE)=$P(NODE,U,PCE)
 ;
 ; START - END
 S START=$$FMTE^XLFDT(P1),END=$$FMTE^XLFDT(P2)
 S TXT(1)=$E("Start time: "_START_$$REPEAT^XLFSTR(" ",40),1,34)_"  "
 S TXT(2)="End time: "_END
 D ADD^HLEVAPI1(TXT(1)_TXT(2))
 ;
 ; STATUS-RUN - STATUS-APPL
 S P4=$S(P4="E":"ERROR",P4="F":"FINISHED",P4="Q":"QUEUED (NOT RUNNING YE T)",1:"??")
 S TXT(1)=$E("Status: "_P4_$$REPEAT^XLFSTR(" ",40),1,34)_"  "
 S TXT(2)=$S(P5]"":"Status-Appl: "_P5,1:"")
 D ADD^HLEVAPI1(TXT(1)_TXT(2))
 ;
 Q
 ;
LOADDGBL(HLEVIENJ,SUBDD,SVSUB) ; Load event text into global to mail...
 N HDR,MIEN
 S HDR=$S(SUBDD=50:"Run Diary",SUBDD=51:"Additional Text",1:"")
 S SVSUB=$S($G(SVSUB)]"":SVSUB,1:"HLMAILMSG")
 I $O(^HLEV(776,+HLEVIENJ,SUBDD,0))>0 D
 .  D ADD^HLEVAPI1("") ; Always add a blank line...
 .  I HDR]"" D ADD^HLEVAPI1(HDR),ADD^HLEVAPI1($$REPEAT^XLFSTR("-",$L(HDR)))
 S MIEN=0
 F  S MIEN=$O(^HLEV(776,+HLEVIENJ,SUBDD,MIEN)) Q:'MIEN  D
 .  D ADD^HLEVAPI1($G(^HLEV(776,+HLEVIENJ,SUBDD,+MIEN,0)))
 Q
 ;
DEBUGSET ; Set debugging on/off for a tag...
 N CUT,TAG
DSET1 ;
 I $O(^XTMP("HLEV DEBUG",0))']"" D
 .  KILL ^XTMP("HLEV DEBUG")
 ;
 I $O(^XTMP("HLEV DEBUG",""))]"" D
 .  W !!,"Current debug sets..."
 .  W !
 .  S TAG=0
 .  F  S TAG=$O(^XTMP("HLEV DEBUG",TAG)) Q:TAG']""  D
 .  .  S CUT=$G(^XTMP("HLEV DEBUG",TAG)) QUIT:CUT']""  ;->
 .  .  W !,TAG,?20,CUT,"..."
 ;
 R !!,"Tag: ",TAG:99 Q:TAG']""  ;->
 S CUT=$G(^XTMP("HLEV DEBUG",TAG))
 I CUT]"" W "    ... set to ",CUT," ..."
 R !,"Cutoff time (FM): ",CUT:99
 ;
 I CUT="@" D
 .  KILL ^XTMP("HLEV DEBUG",TAG)
 .  W "  removing data..."
 .  I $O(^XTMP("HLEV DEBUG",0))']"" KILL ^XTMP("HLEV DEBUG")
 ;
 I CUT?7N1"."1.N D DSET2(TAG,CUT) W "  setting cutoff time..."
 ;
 G DSET1 ;->
 ;
DSET2(TAG,CUT) ;
 S ^XTMP("HLEV DEBUG",0)=$$FMADD^XLFDT($$NOW^XLFDT,0,1)_U_$$NOW^XLFDT_U_"HL7 event monitor debug data"
 S ^XTMP("HLEV DEBUG",TAG)=CUT ; Cutoff time after which not to store...
 Q
 ;
DEBUG(TAG,TMPSUB) ; Conditionally store ^XTMP debug data...
 ; Pass-by-reference references to save by merging...
 ; TMPSUB(SAVESUB)=REFERENCE 
 ; (E.g., TMPSUB("HLEVREP")=$NA(^TMP($J,"HLEVREP")))
 N DATE,NO,SUB,REF,X
 ;
 ; Is debugging enabled?
 S DATE=$G(^XTMP("HLEV DEBUG",TAG)) QUIT:DATE<$$NOW^XLFDT  ;->
 ;
 ; There must be a task number...
 I $G(ZTSK)'>0 N ZTSK S ZTSK=9999999
 ;
 ; Save data...
 S NO=$O(^XTMP("HLEV DEBUG",TAG,ZTSK,":"),-1)+1
 S ^XTMP("HLEV DEBUG",TAG,ZTSK,+NO)=$$NOW^XLFDT
 S X="^XTMP(""HLEV DEBUG"","""_TAG_""","_ZTSK_","_NO_"," D DOLRO^%ZOSV
 ;
 ; Save reference data by merging...
 S SUB=""
 F  S SUB=$O(TMPSUB(SUB)) Q:SUB']""  D
 .  S REF=TMPSUB(SUB) QUIT:REF']""  ;->
 .  MERGE ^XTMP("HLEV DEBUG",TAG,ZTSK,NO,SUB)=@REF
 ;
 ; Remove all but last 20 entries for TAG...
 F NO(1)=NO-20:-1:1 KILL ^XTMP("HLEV DEBUG",TAG,ZTSK,NO(1))
 ;
 Q
 ;
ASKDATE(DATEPMT,PARM,DEFAULT) ; Select date...
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="DO^::"_$S($G(PARM):PARM,1:"EXT")
 S DIR("A")=$S($G(DATEPMT)]"":DATEPMT,1:"Select DATE")
 I $G(DEFAULT)]"" S DIR("B")=DEFAULT
 D ^DIR
 I $G(PARM)]"",PARM'["T" QUIT:+Y?7N +Y ;->
 I +Y?7N1"."1.N Q +Y
 Q ""
 ;
LOG(ETYPE,STORE) ; Log event type, record variables, create index...
 ;
 ; STORE = variables to store, separated by up-arrows.  (At the time
 ;         of call to LOG, the value of the variables must be set to
 ;         the value to be stored!)
 ;
 ; Returns:  Piece 1  --  0 -> No new log entry made
 ;                        1 -> New log entry made
 ;           Piece 2  --  776.4 IEN
 ;
 N IEN1,IEN2,LIEN,LIST,LOG,PCE,VAR,X,XRF
 ;
 ; Quit if no event type passed.  (Event type always used for APPNAME)
 QUIT:$G(ETYPE)']"" "" ;->
 ;
 ; Defaults...
 S LOG="",STORE=$G(STORE)
 ;
 ; Extract out the variables used for index (and stored below)...
 F PCE=1:1:$L($G(STORE),U) D
 .  S VAR=$P(STORE,U,+PCE) QUIT:VAR']""!('($D(@VAR)#2))  ;->
 .  S LIST(PCE)=@VAR
 ;
 ; Quit if this problem has already been logged?
 I STORE]"" D  QUIT:+LOG=1 "^"_$P(LOG,U,2) ;->
 .  S LOG=$$LOGGED^HLEME1(ETYPE,.LIST)
 ;
 ; Make a log entry...
 S LIEN=$$EVENT^HLEME(ETYPE,"HEALTH LEVEL SEVEN") QUIT:'LIEN "" ;->
 ;
 ; Store event in log, log in event, and create xref...
 I $G(HLEVIENJ) D
 .
 .  N LIST
 .
 .  ; Store event in log...
 .  S X=$$ADDNOTE^HLEME(+LIEN,"Event monitor# "_HLEVIENJ_" created this log entry.")
 .  ; Store log in event...
 .  KILL ^TMP($J,"HLZZ")
 .  S ^TMP($J,"HLZZ",1)="Log# "_LIEN_" was created by this event monitor.)"
 .  D RUNDIARY^HLEVAPI1($NA(^TMP($J,"HLZZ")))
 .  KILL ^TMP($J,"HLZZ")
 .
 .  ; Add Xrefs...
 .  S LIST(1)="X776",LIST(2)=HLEVIENJ,LIST(3)=LIEN
 .  S X=$$NEWINDEX^HLEME1(+LIEN,ETYPE,.LIST)
 .
 .  S LIST(1)="X7764",LIST(2)=LIEN,LIST(3)=HLEVIENJ
 .  S X=$$NEWINDEX^HLEME1(+LIEN,ETYPE,.LIST)
 ;
 ; If no variables to store, stop now...
 I STORE']"" QUIT 1_U_LIEN ;->
 ;
 ; Re-extract variables, get values, and store in log entry...
 F PCE=1:1:$L($G(STORE),U) D
 .  S VAR=$P(STORE,U,+PCE) QUIT:VAR']""!('($D(@VAR)#2))  ;->
 .  S X=$$STOREVAR^HLEME(+LIEN,@VAR,VAR) ; Store variable
 .  S LIST(PCE)=@VAR
 ;
 ; Make a new index...
 S X=$$NEWINDEX^HLEME1(+LIEN,ETYPE,.LIST)
 ;
 Q 1_U_LIEN
 ;
LOGVAR(IEN,VAR) ; Store variable in 776.4...
 N CT,MIEN,ZERO
 ;
 QUIT:$G(^HLEV(776.4,+$G(IEN),0))']""!('$D(@VAR))  ;->
 S ZERO=$G(^HLEV(776.4,+IEN,3,0)),$P(ZERO,U,2)=776.43
 ;
 S CT=0
 ;
 ; Individual variable...
 I $D(VAR)#2 D SV(VAR,@VAR) QUIT:'CT  ;->
 ;
 S ^HLEV(776.4,+IEN,3,0)=ZERO
 ;
 Q
 ;
LOGQUERY(IEN,QUERYBEG,QUERYEND) ; Store ARR() in 776.4...
 N CT,MIEN,ZERO
 ;
 QUIT:$G(^HLEV(776.4,+$G(IEN),0))']""  ;->
 S ZERO=$G(^HLEV(776.4,+IEN,3,0)),$P(ZERO,U,2)=776.43
 ;
 S CT=0
 F  S QUERYBEG=$Q(@QUERYBEG) Q:QUERYBEG'[QUERYEND  D
 .  D SV(QUERYBEG,@QUERYBEG)
 ;
 QUIT:CT'>0  ;->
 ;
 S ^HLEV(776.4,+IEN,3,0)=ZERO
 ;
 Q
 ;
SV(VAR,VAL) ; Store individual variable... (Increments CT, updates ZERO,
 ; and creates MIEN.)
 ; CT,IEN,ZERO -- req --> CT,MIEN,ZERO
 S CT=CT+1
 S MIEN=$O(^HLEV(776.4,+IEN,3,":"),-1)+1
 S ^HLEV(776.4,+IEN,3,+MIEN,0)=VAR_"="_VAL
 S $P(ZERO,U,3)=MIEN,$P(ZERO,U,4)=MIEN
 Q
 ;
EOR ;HLEVAPI2 - Event Monitor APIs ;5/16/03 14:42
