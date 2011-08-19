HLEVREP2 ;O-OIFO/LJA - Event Monitor REPORTS ;02/04/2004 14:42
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
CTRL ; Called by 'Display monitor details [HLEV MONITOR DETAILS]'
 N MONM
 ;
 KILL ^TMP($J)
 ;
 D HD
 D EX
 W !
 QUIT:$$BTE^HLCSMON("Press RETURN to collect data, or enter '^' to exit... ")  ;->
 D MONVALL
 ;
 F  D  QUIT:MONM']""
 .  D MONLIST
 .  W !
 .  S MONM=$$ASKMON QUIT:MONM']""  ;->
 .  S WAY=$$ORDER I WAY'?1N S MONM="" QUIT  ;->
 .  I WAY=1 D SHOWR(MONM)
 .  I WAY=2 D SHOWF(MONM)
 .  D HD
 ;
 KILL ^TMP($J)
 ;
 Q
 ;
SHOWF(MONM) ; Show monitors from oldest to newest
 N ABRT,HLEVIENJ,PMT
 W !
 S ABRT=0,HLEVIENJ=0
 F  S HLEVIENJ=$O(^TMP($J,"HLMONL",MONM,HLEVIENJ)) Q:'HLEVIENJ!(ABRT)  D
 .  S X=$$NEXT,ABRT=$P(X,U,2),PRINT=+X QUIT:ABRT  ;->
 .  I PRINT D SHOW(HLEVIENJ) W !
 Q
 ;
SHOWR(MONM) ; Show monitors from newest to oldest
 N ABRT,HLEVIENJ,PRINT,X
 W !
 S ABRT=0,HLEVIENJ=":"
 F  S HLEVIENJ=$O(^TMP($J,"HLMONL",MONM,HLEVIENJ),-1) Q:'HLEVIENJ!(ABRT)  D
 .  S X=$$NEXT,ABRT=$P(X,U,2),PRINT=+X QUIT:ABRT  ;->
 .  I PRINT D SHOW(HLEVIENJ) W !
 Q
 ;
NEXT() ; Show next entry?
 N ANS
 S ANS=$$YN^HLEVUTIL("Display monitor ""run"" started at "_$P(^TMP($J,"HLMON",+HLEVIENJ,"START"),U,3),"No")
 I ANS=1 QUIT "1^0" ;-> Display^Abort
 I ANS="" QUIT "0^0" ;->
 Q "0^1"
 ;
SHOW(HLEVIENJ) ; Ask if want to view...
 N GBL,LINES,MONM
 ;
 S GBL=$NA(^TMP($J,"HLMON",HLEVIENJ))
 ;
 ;
 S LINES=$O(@GBL@("VIEW",":"),-1)
 S MONM=$P($G(@GBL@("MONM")),U,3) QUIT:MONM']""  ;->
 S MONM=MONM_"[#"_HLEVIENJ_"]"
 ;
 I LINES<22 D  QUIT  ;->
 .  W @IOF,$$CJ^XLFSTR(MONM,IOM),!,$$REPEAT^XLFSTR("=",IOM)
 .  S NO=0
 .  F  S NO=$O(^TMP($J,"HLMON",+HLEVIENJ,"VIEW",NO)) Q:NO'>0  D
 .  .  W !,^TMP($J,"HLMON",+HLEVIENJ,"VIEW",NO)
 ;
 D BROWSE^DDBR($NA(^TMP($J,"HLMON",+HLEVIENJ,"VIEW")),"N",MONM)
 ;
 Q
 ;
ORDER() ; $ORDER direction...
 N DIR,DIRUT,DTOUT,DUOUT
 S DIR(0)="S^1:Show entries from newest to oldest;2:Show entries from oldest to newest;3:Exit"
 S DIR("A")="Select display direction"
 S DIR("B")=1
 D ^DIR
 Q $S(+Y=1!(+Y=2):+Y,1:"")
 ;
ASKMON() ; Ask user to select a monitor...
 N DIC,X,Y
 S DIC=776.1,DIC(0)="AEMQ",DIC("A")="Select MONITOR: "
 S DIC("S")="S HLEV=$P($G(^HLEV(776.1,+Y,0)),U) I HLEV]"""",$D(^TMP($J,""HLMONL"",HLEV))"
 D ^DIC
 Q $S(+Y>0:$P(Y,U,2),1:"")
 ;
HD W @IOF,$$CJ^XLFSTR("Display Monitor Details",IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 QUIT
 ;
EX N I,T F I=1:1 S T=$T(EX+I) QUIT:T'[";;"  W !,$P(T,";;",2,99)
 ;;This option displays a detailed view of monitor run-time data.  You can loop
 ;;through all occurrences of a monitor from oldest to most recent, or from most
 ;;recent to oldest.
 QUIT
 ;
MONLIST ; Create and print list of monitors...
 N DATA,HLEVIENJ
 ;
 I '$D(^TMP($J,"HLMONL")) D  QUIT:'$D(^TMP($J,"HLMONL"))  ;->
 .  S HLEVIENJ=0
 .  F  S HLEVIENJ=$O(^TMP($J,"HLMON",HLEVIENJ)) Q:'HLEVIENJ  D
 .  .  S MONM=$P($G(^TMP($J,"HLMON",+HLEVIENJ,"MONM")),U,3) QUIT:MONM']""  ;->
 .  .  S ^TMP($J,"HLMONL",MONM)=$G(^TMP($J,"HLMONL",MONM))+1
 .  .  S ^TMP($J,"HLMONL",MONM,+HLEVIENJ)=""
 ;
 W !!,"""Runs"" for the following monitors have been found..."
 W !!
 ;
 S MONM=""
 F  S MONM=$O(^TMP($J,"HLMONL",MONM)) Q:MONM']""  D
 .  S CT=^TMP($J,"HLMONL",MONM),MONM(1)=MONM_"[#"_CT_"]"
 .  W:$X>40 ! W:$X>1 ?40
 .  W MONM(1)
 ;
 Q
 ;
MONVALL ; Collect and build screens for all HLEVIENJs...
 N CT,HLEVIENJ
 ;
 KILL ^TMP($J,"HLMON")
 ;
 ; Load here...
 S HLEVIENJ=0,CT=0
 F  S HLEVIENJ=$O(^HLEV(776,HLEVIENJ)) Q:HLEVIENJ'>0  D
 .  D MONALL(+HLEVIENJ)
 .  S CT=CT+1 W:'(CT#50) "."
 ;
 Q
 ;
MONALL(HLEVIENJ) ; Build screen for one entry...
 N GBL
 ;
 S GBL=$NA(^TMP($J,"HLMON",+HLEVIENJ))
 KILL @GBL
 ;
 D MONLOAD^HLEVREP3(+HLEVIENJ) QUIT:'$D(^TMP($J,"HLMON",+HLEVIENJ))  ;->
 D MONHHDR(+HLEVIENJ) ; Build HEADER portion of screen
 D MONVVAR(+HLEVIENJ) ; Build VARIABLE portion of screen
 D MONRRD(+HLEVIENJ) ; Build RUN DIARY portion of screen
 D MONMMT(+HLEVIENJ) ; Build MSG TEXT portion of screen
 ;
 Q
 ;
 ;
MONHHDR(HLEVIENJ) ; Build header...
 ; ^TMP($J,"HLMON",+HLEVIENJ) -- req
 N TXT
 ;
 D ADDLINE("Start        Timestamp    Finish       Status   Appl        Mail")
 D ADDLINE($$REPEAT^XLFSTR("=",IOM))
 ;
 S TXT=""
 D ADD("START",11),ADD("TIME",11),ADD("DONE",11),ADD("STATR",7)
 D ADD("MAIL",14)
 D ADDLINE(TXT)
 ;
 Q
 ;
MONVVAR(HLEVIENJ) ; Create screens in ^TMP
 ; GBL,^TMP($J,"HLMON",+HLEVIENJ) -- req
 ;
 ;
 N NOPG,NOVAR
 ;
 S X=$G(@GBL@("VX")),NOVAR=$P(X,U),NOPG=$P(X,U,4)
 ;
 ; Vertical alignment?
 I NOPG>1!(NOVAR<6) D MVSCRNV QUIT  ;->
 ;
 ; Horizontal alignment...
 D MVSCRNH
 ;
 Q
 ;
MVSCRNV ; Create variable screen VERTICALly...
 ; Called by MONVSCRN - GBL,HLEVIENJ -- req
 N COL,DATA,EXPL,LEN,TXT,VAR,VARX
 ;
 ; Get widest variable...
 S COL=$O(@GBL@("VY",":"),-1) QUIT:COL'>0  ;->
 S VAR=$O(@GBL@("VY",+COL,"ZZZZZZZZZ"),-1) QUIT:VAR']""  ;->
 S EXPL=$O(@GBL@("VY",+COL,VAR,"ZZZZZZZZZ"),-1) QUIT:EXPL']""  ;->
 S DATA=@GBL@("VD",VAR,EXPL)
 S VARX=$S(VAR'=EXPL:EXPL,1:VAR)
 ;
 ; Find where 'legend: ' should be...
 S TXT=$$CJ^XLFSTR(VARX_"~^~"_DATA,IOM)
 S LEN=$L($P(TXT,"~^~"))-2 ; this is critical number...
 ;
 D ADDLINE("")
 D ADDLINE($$CJ^XLFSTR("-------------------- Variables ----------------------",IOM))
 ;
 ; Loop thru fields now...
 S VAR=""
 F  S VAR=$O(@GBL@("VD",VAR)) Q:VAR']""  D
 .  S EXPL=""
 .  F  S EXPL=$O(@GBL@("VD",VAR,EXPL)) Q:EXPL']""  D
 .  .  S DATA=@GBL@("VD",VAR,EXPL)
 .  .  S TXT=$$PAD($S(EXPL=VAR:VAR,1:EXPL),LEN)_DATA
 .  .  D ADDLINE(TXT)
 ;
 Q
 ;
MVSCRNH ; Create variable screen HORIZONTALly... (Only called if PAGE=1)
 ; Called by MONVSCRN - GBL,HLEVIENJ -- req
 N DATA,EXPL,HDR,NO,TXTHDR,TXTVAR
 ;
 D ADDLINE("")
 D ADDLINE($$CJ^XLFSTR("-------------------- Variables ----------------------",IOM))
 ;
 ; Header
 S VAR="",TXTHDR="",NO=0
 F  S VAR=$O(@GBL@("VD",VAR)) Q:VAR']""  D
 .  S EXPL=""
 .  F  S EXPL=$O(@GBL@("VD",VAR,EXPL)) Q:EXPL']""  D
 .  .  S HDR=$S(EXPL'=VAR:EXPL,1:VAR)
 .  .  S DATA=@GBL@("VD",VAR,EXPL)
 .  .  S X=$L(HDR),Y=$L(DATA),LEN=$S(X>Y:X,1:Y)
 .  .  S NO=NO+1,NO(NO)=LEN_U_HDR_U_DATA
 ;
 ; Header line...
 S NO=0,TXTHDR=""
 F  S NO=$O(NO(NO)) Q:NO'>0  D
 .  S DATA=NO(+NO)
 .  S LEN=+DATA,DATA=$P(DATA,U,2)
 .  S TXTHDR=TXTHDR_$S(TXTHDR]"":"  ",1:"")
 .  S TXTHDR=TXTHDR_$E(DATA_$$REPEAT^XLFSTR(" ",LEN),1,LEN)
 D ADDLINE(TXTHDR)
 ;
 D ADDLINE($$REPEAT^XLFSTR("=",IOM))
 ;
 ; Variables...
 S NO=0,TXTVAR=""
 F  S NO=$O(NO(NO)) Q:NO'>0  D
 .  S DATA=NO(+NO)
 .  S LEN=+DATA,DATA=$P(DATA,U,3)
 .  S TXTVAR=TXTVAR_$S(TXTVAR]"":"  ",1:"")
 .  S TXTVAR=TXTVAR_$E(DATA_$$REPEAT^XLFSTR(" ",LEN),1,LEN)
 D ADDLINE(TXTVAR)
 ;
 Q
 ;
MONRRD(HLEVIENJ) ; Build RUN DIARY...
 ; GBL,^TMP($J,"HLMON",+HLEVIENJ) -- req
 N NO
 ;
 QUIT:'$D(@GBL@("RUN"))  ;->
 ;
 D ADDLINE("")
 D ADDLINE($$CJ^XLFSTR("---------------------- Run Diary ------------------------",IOM))
 ;
 S NO=0
 S NO=$O(@GBL@("RUN",NO)) Q:NO'>0  D
 .  D ADDLINE(@GBL@("RUN",+NO))
 ;
 Q
 ;
 ;
MONMMT(HLEVIENJ) ; Build MSG TEXT...
 ; ^TMP($J,"HLMON",+HLEVIENJ) -- req
 N NO
 ;
 QUIT:'$D(@GBL@("MSG"))  ;->
 ;
 D ADDLINE("")
 D ADDLINE($$CJ^XLFSTR("-------------------- Message Text ----------------------",IOM))
 ;
 S NO=0
 S NO=$O(@GBL@("MSG",NO)) Q:NO'>0  D
 .  D ADDLINE(@GBL@("MSG",+NO))
 ;
 Q
 ;
 ;
PAD(VAR,COL) ; Make  "    var: "
 QUIT:$L(VAR)>(COL-3) VAR_":  " ;->
 Q $$REPEAT^XLFSTR(" ",COL-$L(VAR))_VAR_":  "
 ;
ADDLINE(TXT) ; Add line of text...
 N NO
 S NO=$O(@GBL@("VIEW",":"),-1)+1
 S @GBL@("VIEW",+NO)=TXT
 Q
 ;
 ;
ADD(VAR,COL) ; Add to TXT...
 N VAL
 S VAL=$P($G(@GBL@(VAR)),U,$S(VAR="STATR":4,1:3))
 S TXT=TXT_$S(TXT]"":"  ",1:"")_$E(VAL_$$REPEAT^XLFSTR(" ",COL),1,COL)
 Q
 ;
EOR ;HLEVREP2 - Event Monitor REPORTS ;5/16/03 14:42
