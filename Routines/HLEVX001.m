HLEVX001 ;O-OIFO/LJA - Event Monitor "Mother" ;02/04/2004 14:42
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
MOTHER ; The "Mother of All" monitors!  (Monitors the Event Monitor)
 ;HLEVIENE,HLEVIENJ,HLEVIENM -- req
 D START^HLEVAPI()
 D MASTER
 D MONITOR
 D CHECKOUT^HLEVAPI
 Q
 ;
MASTER ; Collect master job information...
 D LASTNEXT
 D MSTRUNS
 Q
 ;
MSTRUNS ; Show master runs and status counts...
 N CT,CTM,STAT,STATM
 KILL ^TMP($J,"SV")
 D RUNS("SV")
 D ADD50("")
 D ADD50("# job runs last 24 hours",$G(^TMP($J,"SV")))
 D ADD50("   "_$$REPEAT^XLFSTR("-",40))
 S STAT=""
 F  S STAT=$O(^TMP($J,"SV",STAT)) Q:STAT']""  D
 .  S CT=^TMP($J,"SV",STAT)
 .  D ADD50("#"_$$STAT2(STAT),CT)
 Q
 ;
STAT2(STAT) ; Return status for 776.2 0;4...
 Q $S(STAT="E":"ERROR",STAT="F":"FINISHED",STAT="Q":"QUEUED",STAT="R":"RUNNING",STAT="P":"PARM STOP",STAT="S":"STOP REQUESTED",STAT="A":"JOB ABORTED",1:STAT)
 ;
STAT2M(STAT) ; REturn status for 776.2051 0;2 & 0;6...
 Q $S(STAT="E":"TOO EARLY",STAT="I":"INACTIVE",STAT="M":"M-CHK-FAIL",STAT="Q":"QUEUED",STAT="R":"RUNNING",STAT="XM":"M CODE",$E(STAT)="X":"ERROR",1:STAT)
 ;
LASTNEXT ; Show last completed run and next queued run...
 N IENLAST,IENNEXT
 S IENLAST=+$$IEN7762("F"),NODE(+IENLAST)=$G(^HLEV(776.2,+IENLAST,0))
 S IENNEXT=+$$IEN7762("Q"),NODE(+IENNEXT)=$G(^HLEV(776.2,+IENNEXT,0))
 D ADD50("Last master job run",$$FMTE^XLFDT(+NODE(+IENLAST)))
 D ADD50("Next master job at",$$FMTE^XLFDT(+NODE(+IENNEXT))_"  Task#: "_$P(NODE(+IENNEXT),U,5))
 Q
 ;
RUNS(SUB) ; Find number runs and results...
 N ABORT,CUT,DATA,IEN,IENM,LASTDT,RES,STAT,STATM,STATM5
 S CUT=$$FMADD^XLFDT($$NOW^XLFDT,-1),ABORT=0
 S LASTDT=":"
 F  S LASTDT=$O(^HLEV(776.2,"B",LASTDT),-1) Q:'LASTDT!(LASTDT<CUT)!(ABORT)  D
 .  S IEN=":"
 .  F  S IEN=$O(^HLEV(776.2,"B",LASTDT,IEN),-1) Q:'IEN!(ABORT)  D
 .  .  S DATA=$G(^HLEV(776.2,+IEN,0))
 .  .  S STAT=$P(DATA,U,4),STAT=$S(STAT]"":STAT,1:"?")
 .  .  S ^TMP($J,SUB)=$G(^TMP($J,SUB))+1
 .  .  S ^TMP($J,SUB,STAT)=$G(^TMP($J,SUB,STAT))+1
 .  .  S IENM=0
 .  .  F  S IENM=$O(^HLEV(776.2,+IEN,51,IENM)) Q:IENM'>0  D
 .  .  .  S DATA=^HLEV(776.2,+IEN,51,+IENM,0)
 .  .  .  S STATM=$P(DATA,U,2),STATM=$S(STATM]"":STATM,1:"?")
 .  .  .  S STATM5=$P(DATA,U,5),STATM=$$STATM5(STATM,STATM5)
 .  .  .  S ^TMP($J,SUB,STAT,STATM)=$G(^TMP($J,SUB,STAT,STATM))+1
 Q
 ;
STATM5(STATM,STATM5) ; Return sorting subscript RESULTS
 QUIT:$E(STATM5)="X" STATM5
 Q STATM
 ;
ADD50(TAG,TXT) ; Add to ^HLEV(776,+HLEVIENJ,50)...
 ; HLEVIENJ -- req
 N POSX
 ;
 S TAG=$G(TAG),TXT=$G(TXT)
 ;
 ; If TXT passed & TAG not passed...
 I TXT]"",TAG']"" D  QUIT  ;->
 .  D WPTXT^HLEVUTIL(776,+HLEVIENJ,50,776.002,TXT)
 ;
 ; If TXT not passed...
 I TXT']"" D  ;-> Blank line...
 .  ; If TAG not passed...
 .  I TAG']"" D  QUIT  ;-> Blank line...
 .  .  D WPTXT^HLEVUTIL(776,+HLEVIENJ,50,776.002,"")
 .  ; If TAG passed...
 .  I TAG]"" D  QUIT  ;-> Separator line or something
 .  .  D WPTXT^HLEVUTIL(776,+HLEVIENJ,50,776.002,TAG)
 ;
 S TAG=$E($$REPEAT^XLFSTR(" ",40),1,30-$L(TAG))_TAG_":   "
 S POSX=$L(TAG),TXT=TAG_TXT
 ;
 F  QUIT:TXT']""  D
 .  D WPTXT^HLEVUTIL(776,+HLEVIENJ,50,776.002,$E(TXT,1,74))
 .  S TXT=$E(TXT,75,999) QUIT:TXT']""  ;->
 .  S TXT=$$REPEAT^XLFSTR(" ",POSX)_TXT
 ;
 Q
 ;
IEN7762(STAT) ;
 N FIEN,IEN,LASTDT
 S LASTDT=":",FIEN=""
 F  S LASTDT=$O(^HLEV(776.2,"B",LASTDT),-1) Q:'LASTDT!(FIEN)  D
 .  S IEN=":"
 .  F  S IEN=$O(^HLEV(776.2,"B",+LASTDT,IEN),-1) Q:'IEN!(FIEN)  D
 .  .  QUIT:$P($G(^HLEV(776.2,+IEN,0)),U,4)'=STAT  ;->
 .  .  S FIEN=IEN
 Q FIEN
 ;
MONITOR ; Collect monitor information...
 ; HLEVIENJ -- req
 N DATA,DATE,EVIEN,EVNM,IEN,IENJ,IOINHI,IOINORM,LASTDT,MIEN
 N NO,RUNNING,STAT,X
 ;
 KILL ^TMP($J,"HLRUN")
 ;
 ; Find latest 776.2 master run...
 S LASTDT=":",NO=0
 F  S LASTDT=$O(^HLEV(776.2,"B",LASTDT),-1) Q:'LASTDT!(NO>3)  D
 .  S IEN=""
 .  F  S IEN=$O(^HLEV(776.2,"B",+LASTDT,IEN),-1) Q:'IEN!(NO>3)  D
 .  .  S DATA(776.2)=$G(^HLEV(776.2,+IEN,0)) QUIT:DATA(776.2)']""  ;->
 .  .  S STAT=$P(DATA(776.2),U,4),STAT=$S(STAT]"":STAT,1:" ")
 .  .  S NO=NO+1
 .  .  ; Add events monitored...
 .  .  S MIEN=0
 .  .  F  S MIEN=$O(^HLEV(776.2,+IEN,51,MIEN)) Q:MIEN'>0  D
 .  .  .  S DATA(51)=$G(^HLEV(776.2,+IEN,51,+MIEN,0)) Q:DATA(51)']""  ;->
 .  .  .  S EVIEN=+DATA(51)
 .  .  .  S EVNM=$P($G(^HLEV(776.1,+EVIEN,0)),U) QUIT:EVNM']""  ;->
 .  .  .  S IENJ=$P(DATA(51),U,8) QUIT:IENJ'>0  ;->
 .  .  .  S DATA(776)=$G(^HLEV(776,+IENJ,0)) QUIT:DATA(776)']""  ;->
 .  .  .  S ^TMP($J,"HLRUN","NO",IEN)=DATA(776.2)
 .  .  .  S ^TMP($J,"HLRUN","NO",IEN,EVNM)=DATA(51)
 .  .  .  S ^TMP($J,"HLRUN","NO",IEN,EVNM,IENJ)=DATA(776)
 .  .  .  S ^TMP($J,"HLRUN","NM",EVNM,IEN)="" ; xref...
 ;
 QUIT:'$D(^TMP($J,"HLRUN"))  ;->
 ;
 D ADD50("","Recent Event Runs")
 D ADD50("",$$REPEAT^XLFSTR("-",74))
 D ADD50("","Event-Name                      Run#1          Run#2          Run#3")
 D ADD50("",$$REPEAT^XLFSTR("-",74))
 S EVNM="",RUNNING=0
 F  S EVNM=$O(^TMP($J,"HLRUN","NM",EVNM)) Q:EVNM']""  D
 .  S TXT=$E(EVNM_$$REPEAT^XLFSTR(" ",30),1,30)_"  "
 .  S EVIEN=0
 .  F  S EVIEN=$O(^TMP($J,"HLRUN","NM",EVNM,EVIEN)) Q:EVIEN'>0  D
 .  .  S IENJ=0
 .  .  F  S IENJ=$O(^TMP($J,"HLRUN","NO",+EVIEN,EVNM,IENJ)) Q:'IENJ  D
 .  .  .  S DATA=$G(^TMP($J,"HLRUN","NO",+EVIEN,EVNM,+IENJ)) QUIT:DATA']""  ;->
 .  .  .  S STAT=$P(DATA,U,5),STAT=$S(STAT="F":1,1:0)
 .  .  .  S RUNNING=RUNNING+STAT
 .  .  .  S DATE=+DATA QUIT:DATE'?7N1"."1.N  ;->
 .  .  .  S DATE=$E("[",STAT)_$$SDT(DATE)_$E("]",STAT)
 .  .  .  S TXT=TXT_$E(DATE_"               ",1,15)
 .  D ADD50("",TXT)
 ;
 I RUNNING D ADD50(""),ADD50(" (Dates in [brackets] are still running.)")
 ;
 KILL ^TMP($J,"HLRUN")
 ;
 Q
 ;
SDT(DATE) ; Return shortened form of date...
 I DATE?7N QUIT $E(DATE,4,5)_"/"_$E(DATE,6,7) ;->
 I DATE?7N1"."1.N QUIT $E(DATE,4,5)_"/"_$E(DATE,6,7)_"@"_$E($P($$FMTE^XLFDT(DATE),"@",2),1,5)
 QUIT ""
 ;
EOR ;HLEVX001 - Event Monitor "Mother" ;5/16/03 14:42
