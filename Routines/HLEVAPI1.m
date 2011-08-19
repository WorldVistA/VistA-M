HLEVAPI1 ;O-OIFO/LJA - Event Monitor APIs ;02/04/2004 14:42
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
SYSETUP ; Called by option's entry action...
 N DATA,LAST,NEXT,STAT
 ;
 ; Make sure master job is current...
 D CHECKMST^HLEVMST
 ;
 S DATA=$G(^HLEV(776.999,1,0)),LAST=$$LAST7762,NEXT=$$NEXT7762
 ;
 S STAT=$P(DATA,U,2)
 S STAT="-------- Master job status is "_$S(STAT="A":"ACTIVE",STAT="I":"INACTIVE",1:"NOT SET YET")_" --------"
 W !!!,$$CJ^XLFSTR(STAT,IOM)
 S X=$$LAST7762 I X]"" W !,$$CJ^XLFSTR(X,IOM)
 S X=$$NEXT7762 I X]"" W !,$$CJ^XLFSTR(X,IOM)
 ;
 S STAT=$P(DATA,U,6)
 W !,$$CJ^XLFSTR("-------- Event monitoring status is "_$S(STAT="A":"ACTIVE",STAT="I":"INACTIVE",1:"NOT SET YET")_" --------",IOM)
 ;
 Q
 ;
LAST7762() ; Return d/h/m/s since last master job run...
 N DATA,FIEN,IEN,LASTDT
 ;
 S LASTDT=":",FIEN=0
 F  S LASTDT=$O(^HLEV(776.2,"B",LASTDT),-1) Q:'LASTDT!(FIEN)  D
 .  S IEN=":"
 .  F  S IEN=$O(^HLEV(776.2,"B",+LASTDT,IEN),-1) Q:'IEN!(FIEN)  D
 .  .  S DATA=$G(^HLEV(776.2,+IEN,0)) QUIT:$P(DATA,U,4)'="F"  ;->
 .  .  S FIEN=IEN
 ;
 QUIT:'FIEN "Unknown last master job run time..." ;->
 ;
 QUIT $$DT7762(FIEN,0)
 ;
NEXT7762() ; Return d/h/m/s till next master job run...
 N DATA,FIEN,IEN,LASTDT
 ;
 S LASTDT=":",FIEN=0
 F  S LASTDT=$O(^HLEV(776.2,"B",LASTDT),-1) Q:'LASTDT!(FIEN)  D
 .  S IEN=":"
 .  F  S IEN=$O(^HLEV(776.2,"B",+LASTDT,IEN),-1) Q:'IEN!(FIEN)  D
 .  .  S DATA=$G(^HLEV(776.2,+IEN,0)) QUIT:$P(DATA,U,4)'="Q"  ;->
 .  .  S FIEN=IEN
 ;
 QUIT:'FIEN "Unknown next master job run time..." ;->
 ;
 Q $$DT7762(+FIEN,1)
 ;
DT7762(FIEN,NXT) ; Called by $$LAST7762 & NEXT7762...
 N DATA,DATE
 S DATA=$G(^HLEV(776.2,+FIEN,0))
 S DATE=$P(DATA,U,$S('NXT:2,1:6)) QUIT:DATE'?7N1"."1.N "" ;->
 S DATE=$$DHMSFM^HLEVUTIL(DATE,$$NOW^XLFDT,1)
 I 'NXT D  QUIT DATE ;-> Last...
 .  I DATE["[" S DATE="Unknown last master job run..." QUIT  ;->
 .  S DATE="Last master job run was "_DATE_" ago..."
 I NXT D  QUIT DATE ;-> Next...
 .  I DATE'["[" S DATE="Unknown next master job run..." QUIT  ;->
 .  S DATE="Next run "_$S($P(DATA,U,5):"[task# "_$P(DATA,U,5)_"] ",1:"")_"is "_$P($P(DATE,"[",2),"]")_" in the future..."
 Q ""
 ;
LOADALL(HLEVIENJ,SVSUB) ; Load all sections into global for mailing...
 N NO,TXT
 S SVSUB=$S($G(SVSUB)]"":SVSUB,1:"HLMAILMSG") ; Save Subscript...
 D LOADDESC(HLEVIENJ,SVSUB) ; Short description of monitor.
 D LOADCOMP(HLEVIENJ,SVSUB) ; Completed line...
 D LOADBODY^HLEVAPI2(HLEVIENJ,SVSUB) ; Start/end/Status/Status-Appl...
 S NO=0
 F  S NO=$O(HLEVTXT(NO)) Q:NO'>0  D
 .  S TXT=$G(HLEVTXT(NO)) QUIT:TXT']""  ;->
 .  S TXT=$$UP^XLFSTR($TR(TXT," ",""))
 .  I TXT="RUNDIARY" D LOADDGBL^HLEVAPI2(HLEVIENJ,50,SVSUB) QUIT  ;->
 .  I TXT="MESSAGETEXT" D LOADDGBL^HLEVAPI2(HLEVIENJ,51,SVSUB) QUIT  ;->
 .  I TXT="VARIABLEVALUE" D LOADVAR(HLEVIENJ,SVSUB) QUIT  ;->
 .  KILL X S X="W "_TXT D ^DIM Q:'$D(X)  ;->
 .  D LOADUSER(TXT,SVSUB)
 Q
 ;
LOADUSER(GBL,SVSUB) ; Load user data into Mailman message...
 N NO,TXT
 ;
 QUIT:$O(@GBL@(0))'>0  ;->
 ;
 S NO=0
 F  S NO=$O(@GBL@(NO)) Q:NO'>0  D
 .  S TXT=$G(@GBL@(NO))
 .  F  D  Q:TXT']""
 .  .  D ADD($E(TXT,1,74))
 .  .  S TXT=$E(TXT,75,999) QUIT:TXT']""  ;->
 .  .  S TXT="   "_TXT
 ;
 Q
 ;
LOADDESC(HLEVIENJ,SVSUB) ; Load description if it exists...
 N DESC,HLEVIENE
 S SVSUB=$S($G(SVSUB)]"":SVSUB,1:"HLMAILMSG")
 S HLEVIENE=$P($G(^HLEV(776,+HLEVIENJ,0)),U,3)
 S DESC=$P($G(^HLEV(776,+$G(HLEVIENE),0)),U,3) QUIT:DESC']""  ;->
 ; First line...
 D ADD("Monitor description: "_DESC)
 D ADD("")
 Q
 ;
LOADCOMP(HLEVIENJ,SVSUB) ; Load generic event monitor info into XMTEXT...
 N HLEVIENE,HLEVNM
 S SVSUB=$S($G(SVSUB)]"":SVSUB,1:"HLMAILMSG")
 S HLEVIENE=$P($G(^HLEV(776,+HLEVIENJ,0)),U,3)
 S HLEVNM=$P($G(^HLEV(776.1,+HLEVIENE,0)),U)
 ; First line...
 D ADD("The '"_HLEVNM_"' event monitor has completed.")
 D ADD("")
 Q
 ;
LOADVAR(HLEVIENJ,SVSUB) ; Load variable names...
 N CUT,MIEN,TXT,VAR
 ;
 QUIT:$O(^HLEV(776,+HLEVIENJ,52,0))'>0  ;->
 ;
 D ADD(""),ADD("Variable List"),ADD("-------------")
 ;
 S VAR=""
 F  S VAR=$O(^HLEV(776,+HLEVIENJ,52,"B",VAR)) Q:VAR']""  D
 .  S MIEN=0
 .  F  S MIEN=$O(^HLEV(776,+HLEVIENJ,52,"B",VAR,MIEN)) Q:MIEN'>0  D
 .  .  S TXT=$G(^HLEV(776,+HLEVIENJ,52,+MIEN,0)) QUIT:TXT']""  ;->
 .  .  S TXT=$P(TXT,U)_$S($P(TXT,U,2)]"":"["_$P(TXT,U,2)_"]",1:"")_"="
 .  .  S TXT(1)=$G(^HLEV(776,+HLEVIENJ,52,+MIEN,52))
 .  .  I ($L(TXT)+$L(TXT(1)))<240 S TXT=TXT_TXT(1),TXT(1)=""
 .  .  I TXT(1)]"" D
 .  .  .  S CUT(1)=$L(TXT),CUT(2)=$L(TXT(1)),CUT=240-CUT(1)
 .  .  .  S TXT=TXT_$E(TXT(1),1,CUT),TXT(1)=$E(TXT(1),CUT+1,999)
 .  .  F  D  QUIT:TXT']""
 .  .  .  D ADD($E(TXT,1,74))
 .  .  .  S TXT=$E(TXT,75,999) QUIT:TXT']""  ;->
 .  .  .  S TXT="   "_TXT
 .  .  .  QUIT:TXT(1)']""  ;->
 .  .  .  
 ;
 Q
 ;
ADD(TXT) ; Add TXT to global to be mailed out...
 ; SVSUB -- req
 N NO
 S NO=$O(^TMP($J,SVSUB,":"),-1)+1
 S ^TMP($J,SVSUB,+NO)=TXT
 Q
 ;
CURR(IEN776) ; Is job running and current?
 N DATA,DIFF,STAT,TSTAMP
 S DATA=$G(^HLEV(776,+IEN776,0))
 S STAT=$P(DATA,U,4) QUIT:STAT'="R" "" ;->
 S TSTAMP=$P(DATA,U,6) QUIT:TSTAMP'?7N1"."1.N "" ;->
 S TSTAMP=$$FMTH^XLFDT(TSTAMP)
 S DIFF=$$DIFFDH^HLCSFMN1(TSTAMP,$H) ; Difference...
 I DIFF'?1.N1"^"2N1":"2N1":"2N QUIT "" ;-> DD^HH:MM:SS
 I +DIFF>0 QUIT "" ;-> 1 or more days difference!
 S DIFF=$P(DIFF,U,2) ; HH:MM:SS now...
 ; If 1 or more hrs, or >15 minutes old...
 I +DIFF!(+$P(DIFF,":",2)>15) QUIT "" ;->
 Q 1
 ;
APPSTAT(STATUS) ; Fill in application status...
 ; HLEVIENJ -- req
 N DA,DIE,DR
 ;
 D DEBUG^HLEVAPI2("VARIABLE") ; Debug data created conditionally
 ;
 ; Stop all event monitoring to enable on-site debugging...
 QUIT:$G(^TMP("HLEVFLAG",$J))["STOP"  ;->
 ;
 QUIT:$G(STATUS)']""  ;->
 QUIT:$G(^HLEV(776,+$G(HLEVIENJ),0))']""  ;->
 S DA=+HLEVIENJ,DIE=776,DR="5///"_$E(STATUS,1,10)
 D ^DIE
 Q
 ;
RUNDIARY(GBL) ; Move GBL data into RUN DIARY...
 ; HLEVIENJ -- req
 ;
 D DEBUG^HLEVAPI2("VARIABLE") ; Debug data created conditionally
 ;
 ; Stop all event monitoring to enable on-site debugging...
 QUIT:$G(^TMP("HLEVFLAG",$J))["STOP"  ;->
 ;
 D GBLMOVE(+$G(HLEVIENJ),50,$G(GBL))
 Q
 ;
MSGTEXT(GBL) ; Mark event job entry to NOTIFY MAIL GROUP...
 ; HLEVIENJ -- req
 ;
 D DEBUG^HLEVAPI2("VARIABLE") ; Debug data created conditionally
 ;
 ; Stop all event monitoring to enable on-site debugging...
 QUIT:$G(^TMP("HLEVFLAG",$J))["STOP"  ;->
 ;
 D GBLMOVE(+$G(HLEVIENJ),51,$G(GBL))
 Q
 ;
GBLMOVE(HLEVIENJ,SUB,GBL) ; Move GBL data into entry's WP text...
 N CT,NO,NODE
 ;
 S SUB=$G(SUB) QUIT:SUB'=51&(SUB'=52)  ;->
 QUIT:$G(^HLEV(776,+HLEVIENJ,0))']""  ;->
 ;
 ; Add event text...
 S NODE="^776.002",NO=0
 F  S NO=$O(@GBL@(NO)) Q:NO'>0  D
 .  S CT=$O(^HLEV(776,+HLEVIENJ,SUB,":"),-1)+1
 .  S ^HLEV(776,+HLEVIENJ,SUB,CT,0)=$G(@GBL@(+NO))
 S CT=$O(^HLEV(776,+HLEVIENJ,SUB,":"),-1) QUIT:CT'>0  ;->
 S $P(NODE,U,3)=CT,$P(NODE,U,4)=CT
 S ^HLEV(776,+HLEVIENJ,SUB,0)=NODE
 ;
 Q
 ;
ONETIME ;Start a one-time run of event monitor (w/no master job)
 N HLEVIENE,QTASK
 W @IOF,$$CJ^XLFSTR("One-time Queueing of Event Monitor",IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 W !,"Normally, the master job evaluates every event monitor and queues a background"
 W !,"job for those events ready for a new ""run.""  This option allows the running"
 W !,"of an event monitor between ""normal"" runs."
 W !!,"Do you want to start a new ""in-between"" run of a monitor?  If so, select"
 W !,"it now.  If not, press RETURN to exit..."
 W !
 ;
 S HLEVIENE=$$ASKIEN^HLEVREP(776.1) I HLEVIENE'>0 D  QUIT  ;->
 .  W "   exiting..."
 ;
 W !
 D ASKRUN(HLEVIENE)
 ;
 Q
 ;
ASKRUN(HLEVIENE) ; Ask if want to run a one-time...
 N DATA,QTASK,QTIME
 ;
 I $P($G(^HLEV(776.1,+$G(HLEVIENE),0)),U,2)'="A" D  QUIT  ;->
 .  QUIT:$G(^HLEV(776.1,+$G(HLEVIENE),0))']""  ;->
 .  D TELL^HLEVMST0("Event monitor is INACTIVE!!","1,2,999")
 ;
 I $$YN^HLCSRPT4("Run monitor now","No") D  QUIT  ;->
 .  D QIT($$NOW^XLFDT) W "   exiting..."
 ;
 W !!,"You may queue this monitor to run ""one-time"" in the future.  If so, enter a"
 W !,"future date/time now..."
 W !
 ;
 F  S QTIME=$$ASKDATE^HLEVAPI2("Enter future run time") D  QUIT:QTIME?7N1"."1.N!(QTIME']"")
 .  QUIT:QTIME'?7N1"."1.N  ;->
 .  I QTIME>$$NOW^XLFDT D QIT(QTIME) QUIT  ;->
 .  S QTIME="REASK"
 .  W "  enter a future time..."
 ;
 Q
 ;
QIT(QTIME) ; Queue it...
 N QTASK
 S QTASK=$$Q1TIME^HLEVAPI0(+HLEVIENE,0,QTIME)
 I +QTASK>0 W !!,"   Queued task# ",+QTASK," [#",$P(QTASK,U,2),"]..."
 I +QTASK'>0 W !!,"   Error occurred.  No monitor ""run"" started..."
 W !
 F  Q:($Y+3)>IOSL  W !
 S X=$$BTE^HLCSMON("Press RETURN to exit... ")
 Q
 ;
EOR ;HLEVAPI1 - Event Monitor APIs ;5/16/03 14:42
