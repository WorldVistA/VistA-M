HLEVREP3 ;O-OIFO/LJA - Event Monitor REPORTS ;02/04/2004 14:42
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
REMREQO ; Remote Requestable printout - [HLEV REMOTE REQUESTABLE LIST]
 N BY,DIC,DIOEND,FLDS,HLEVRRQ
 W @IOF,$$CJ^XLFSTR("Remote Requestable Monitors Report",IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 W !,"Some monitors may be activated by remote server request.  This option sorts"
 W !,"all monitors by whether they are ""remote requestable""."
 W !
 S L="",DIC=776.1,BY="[HLEV REPORT MONITOR]",DIOEND="D RRQSUMM^HLEVREP3"
 S FLDS="[HLEV REMOTE REQUESTABLE]"
 D EN1^DIP
 Q
 ;
RRQSUMM ; Remote request summary...
 QUIT:'$D(HLEVRRQ("[NO]"))  ;->
 W !,"Fields having [NO] in the remote requestable field are not answered YES or"
 W !,"NO.  But, since the default action is NO, these blank fields are actually"
 W !,"an implied NO (no remote requesting allowed.)"
 I '$D(ZTQUEUED) D TELL^HLEVMST0("","0^0^0")
 Q
 ;
REMREQ() ; Called by [HLEV REMOTE REQUESTABLE] print template
 ; Return whether entry is remote requestable
 ; HLEVRRQ newed at top of print template run...
 S HLEVRRQ=$S(X=1:"YES",X=0:"NO",1:"[NO]")
 S HLEVRRQ(HLEVRRQ)=$G(HLEVRRQ(HLEVRRQ))+1
 Q HLEVRRQ
 ;
MONLOAD(HLEVIENJ) ; Load data into ^TMP...
 N DATA,EXPL,LEN,MIEN,NO,PAGE,REF,SUB,SUM,SUMX,SUMY,TITLE,VAR
 ;
 KILL ^TMP($J,"HLMON",+HLEVIENJ)
 ;
 ; Zero node
 S DATA=$G(^HLEV(776,+$G(HLEVIENJ),0)) QUIT:DATA']""  ;->
 D SET("START","Start",$$SDT^HLEVX001($P(DATA,U)))
 D SET("DONE","Finish",$$SDT^HLEVX001($P(DATA,U,2)))
 D SET("MONM","Monitor",$P($G(^HLEV(776.1,+$P(DATA,U,3),0)),U))
 D SET("STATR","Status",$$STAT776($P(DATA,U,4)))
 D SET("STATA","Appl",$P(DATA,U,5))
 D SET("TIME","T-Stamp",$$SDT^HLEVX001($P(DATA,U,6)))
 D SET("MAIL","Mail",$P(DATA,U,7))
 D SET("ZTSK","Task",$P(DATA,U,8))
 D SET("MST","Master",$P(DATA,U,9))
 ;
 ; Run Diary and Message Text...
 F SUB=50,51 D
 .  S TITLE=$S(SUB=50:"RUN",1:"MSG")
 .  S MIEN=0
 .  F  S MIEN=$O(^HLEV(776,+HLEVIENJ,SUB,MIEN)) Q:MIEN'>0  D
 .  .  S NO=$O(^TMP($J,"HLMON",+HLEVIENJ,TITLE,":"),-1)+1
 .  .  S ^TMP($J,"HLMON",+HLEVIENJ,TITLE,+NO)=^HLEV(776,+HLEVIENJ,SUB,MIEN,0)
 ;
 ; Variables...
 S MIEN=0,SUMX="",SUMY=""
 F  S MIEN=$O(^HLEV(776,+HLEVIENJ,52,MIEN)) Q:MIEN'>0  D
 .  S REF=$G(^HLEV(776,+HLEVIENJ,52,+MIEN,0)) QUIT:$P(REF,U)']""  ;->
 .  S VAR=$P(REF,U),EXPL=$P(REF,U,2),EXPL=$S(EXPL]"":EXPL,1:REF)
 .  S DATA=$G(^HLEV(776,+HLEVIENJ,52,+MIEN,52))
 .  S ^TMP($J,"HLMON",+HLEVIENJ,"VD",VAR,EXPL)=DATA
 .
 .  S LEN=$L(DATA) ; Length of data
 .  S LEN(1)=$L(EXPL) ; Length column header
 .  S LEN(2)=$S(LEN>LEN(1):LEN,1:LEN(1))+2 ; Largest length-data or header
 .  S LEN(3)=LEN+LEN(1)+3 ; Length - data + header
 .
 .  S ^TMP($J,"HLMON",+HLEVIENJ,"VX",LEN(2),VAR,EXPL)=""
 .  S ^TMP($J,"HLMON",+HLEVIENJ,"VY",+LEN(3),VAR,EXPL)=""
 .
 .  S $P(SUMX,U)=$P(SUMX,U)+1 ; # variables...
 .  S $P(SUMX,U,2)=$P(SUMX,U,2)+LEN(2)+2 ; Total columns required...
 .  I $P(SUMX,U,3)<(LEN(2)+1) S $P(SUMX,U,3)=LEN(2) ; Largest column
 .
 .  S $P(SUMY,U)=$P(SUMY,U)+1
 .  S $P(SUMY,U,2)=$P(SUMY,U,2)+1
 .  I $P(SUMY,U,3)<(LEN(3)+1) S $P(SUMY,U,3)=LEN(3)
 ;
 ; # Var header, Line and Var data "pages"...
 S LEN=0,PAGE=0,SUM=0
 F  S LEN=$O(^TMP($J,"HLMON",+HLEVIENJ,"VX",LEN)) Q:LEN'>0  D
 .  S:PAGE=0 PAGE=1
 .  I (SUM+LEN)>80 D
 .  .  S PAGE=PAGE+1,SUM=0
 .  S SUM=SUM+LEN
 S:PAGE $P(SUMX,U,4)=PAGE
 ;
 I SUMX]"" S ^TMP($J,"HLMON",+HLEVIENJ,"VX")=SUMX
 I SUMY]"" S ^TMP($J,"HLMON",+HLEVIENJ,"VY")=SUMY
 ;
 Q
 ;
 ;
SET(STORE,TAG,VAL) ; Store value to be displayed...
 S ^TMP($J,"HLMON",HLEVIENJ,STORE)=$S(VAL]"":1,1:"")_U_TAG_U_VAL
 Q
 ;
STAT776(STAT) ; Return status for use on report...
 QUIT STAT_U_$S(STAT="E":"Error",STAT="F":"Finish",STAT="Q":"Que'd",STAT="R":"Running",1:"")
 ;
CTRLMON ; Re/ask for monitor to display...
 N IEN776,IENDATE,IENONE,IOINHI,IOINORM,LASTONE,WORK,X
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 S WORK=0
 W !
 S IEN776=$$ASKMON QUIT:IEN776'>0  ;->
 S WORK=1
 S IENDATE=$$ASKDATE(IEN776) QUIT:IENDATE'>0  ;->
CTRLMON1 ; Reask entry point...
 S IENONE=$$ASKONE(IEN776,IENDATE) I IENONE'>0 D  QUIT  ;->
 .  W !!!!,IOINHI,"Returning to display of daily map views...",IOINORM
 .  W !!
 D SHOW^HLEVREP2(+IENONE)
 I $P(IENONE,U,2)>1 D  G CTRLMON1 ;->
 .  D TELL^HLEVMST0("","0^0^999","Press RETURN to continue... ")
 G CTRLMON ;->
 ;
ASKMON() ; Ask user for a monitor to show...
 N DIC,X,Y
 S DIC=776.1,DIC(0)="AEMQ",DIC("A")="Select monitor to view, or RETURN to continue: "
 S DIC("S")="I $D(^TMP($J,""HLMAP"",""E"",+Y))"
 D ^DIC
 Q $S(+Y>0:+Y,1:"")
 ;
ASKDATE(IEN776) ;
 ; DATESEL -- req
 N DATE,DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="DA",DIR("A")="Select monitor RUN DATE: "
 S X=$$FMTE^XLFDT($O(^TMP($J,"HLMAP","E",+IEN776,DATESEL-.000001))) I X]"" S DIR("B")=X
ASKDATE1 ;
 S DIR("?")="Enter one of the ""run dates"" for this monitor.  (Enter ?? to see list of run dates.)"
 S DIR("??")="^D ASKDHELP^HLEVREP1"
 D ^DIR
 QUIT:$D(DIRUT)!($D(DTOUT))!($D(DUOUT)) "" ;->
 QUIT:$D(^TMP($J,"HLMAP","E",+IEN776,+Y)) +Y ;->
 D ASKDHELP
 G ASKDATE1 ;->
 ;
ASKDHELP ; Help for $$ASKDATE...
 W !!,"You must enter one of the following dates.  Data exists for... "
 W !!
 S DATE=0
 F  S DATE=$O(^TMP($J,"HLMAP","E",IEN776,DATE)) Q:DATE'>0  D
 .  S DATE(1)=$$FMTE^XLFDT(DATE)
 .  W:$X>70 !
 .  W $J(DATE(1),15)
 W !
 Q
 ;
ASKONE(IEN776,IENDATE) ;
 ; Defines and returns LASTONE...
 N DATA,DATE,DIR,DIRUT,DTOUT,DUOUT,HOLD,IEN,LAST,NEXT,NO,STAT,X,Y
 ;
 ; Find entries and build DIR string...
 S NO=0,IEN=0,DIR(0)="SO^"
 F  S IEN=$O(^TMP($J,"HLMAP","E",+IEN776,+IENDATE,IEN)) Q:'IEN  D
 .  S DATA=$G(^HLEV(776,+IEN,0)) QUIT:DATA']""  ;->
 .  S NO=NO+1
 .  S DATE=$P(DATA,U),STAT=$$STAT776^HLEVREP3($P(DATA,U,4))
 .  S HOLD(NO)=IEN_U_DATE
 .  S DATE(DATE)=IEN_U_STAT
 .  S DIR(0)=DIR(0)_$S(DIR(0)'="SO^":";",1:"")_NO_":"_$TR($$FMTE^XLFDT(DATE),":",".")_"  ["_$P(STAT,U,2)_"]"
 QUIT:NO'>0 "" ;->
 QUIT:NO=1 +HOLD(1)_U_1 ;->
 ;
 W !!,"This monitor was run more than once on the date you selected.  Please select"
 W !,"specific run time now..."
 S NEXT=$S($G(LASTONE)'>0:1,1:LASTONE+1),NEXT=$S($D(HOLD(NEXT)):NEXT,1:"")
 S DIR("A")="Select RUN TIME"
 I NEXT S DIR("B")=NEXT
 D ^DIR
 ;
 QUIT:'$D(HOLD(+$G(X))) "" ;-> User answered by entering number...
 ;
 S LASTONE=+X ; Used for DIR("B") later...
 ;
 Q +HOLD(+X)_U_NO
 ;
EOR ;HLEVREP3 - Event Monitor REPORTS ;5/16/03 14:42
