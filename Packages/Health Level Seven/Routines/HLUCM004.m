HLUCM004 ;CIOFO-O/LJA - HL7/Capacity Mgt API ;3/13/03 09:37
 ;;1.6;HEALTH LEVEL SEVEN;*88,103**;Oct 13, 1995
 ;
LOOPU ; Loop thru ^TMP($J,"HLUCMSTORE","U") data.  Full-screen view...
 N CT,DATA,EXCL,IEN772,IENPAR,INCL,IOINHI,IOINORM,RNOMSG,STOP,TYPE,X
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 ;
LOOPU1 KILL DATA,EXCL,INCL,IEN772,IENPAR,INCL,RNOMSG,STOP,TYPE
 W @IOF,$$CJ^XLFSTR("Display of ^TMP($J,""HLUCMSTORE"",""U"") Data",IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 ;
 W !!,$$CJ^XLFSTR("Type Totals",IOM)
 W !,$$CJ^XLFSTR("--------------------------------",IOM)
 S TYPE=""
 F  S TYPE=$O(^TMP($J,"HLUCMSTORE","T",TYPE)) Q:TYPE']""  D
 .  S DATA=$G(^TMP($J,"HLUCMSTORE","T",TYPE))
 .  W !,$$CJ^XLFSTR(TYPE_"   "_DATA,IOM)
 ;
 W !!,"Enter text in messages to include and exclude..."
 W !
 D EXCL(.EXCL)
 W !
 D INCL(.INCL)
 ;
 R !!,"Restrict # messages: 999// ",RNOMSG:999
 S:RNOMSG']"" RNOMSG=999
 QUIT:RNOMSG'?1.N  ;->
 ;
 S (CT,CT(1))=0,IENPAR=0,STOP=0
 F  S IENPAR=$O(^TMP($J,"HLUCMSTORE","U",IENPAR)) Q:'IENPAR!(STOP)  D
 .  S CT(1)=CT(1)+1
 .  QUIT:'$$OK(+IENPAR,RNOMSG,.EXCL,.INCL)  ;->
 .  S CT=CT+1
 .  D SHOWU(+IENPAR,"FULL")
 .  R X:999 I X[U S STOP=1
 ;
 I CT(1)'>0 W !!,"No data exists..." H 2
 ;
 I CT(1)>0 D
 .  W !!,$S('CT:"No matching entries found...",1:"#"_CT_" matching entries displayed...")
 .  S CT=CT(1)-CT W !,"#"_CT_" entries skipped..."
 ;
 Q
 ;
OK(IENPAR,RNOMSG,EXCL,INCL) ; Exclude and INcludes..
 N DATA,FAIL,HOLDEXCL,IEN772,NUM
 ;
 ; Count messages...
 S NUM=0,IEN772=0
 F  S IEN772=$O(^TMP($J,"HLUCMSTORE","U",+IENPAR,IEN772)) Q:'IEN772  D
 .  S NUM=NUM+1
 ;
 ; Quit if number messages in unit isn't right...
 I RNOMSG=999 QUIT:NUM>RNOMSG "" ;-> Should never happen!
 I RNOMSG'=999 QUIT:NUM'=RNOMSG "" ;->
 ;
 ; Parent node check...
 S DATA=$G(^TMP($J,"HLUCMSTORE","U",+IENPAR))
 ;
 ; Exclusions...
 QUIT:$$HOLDEXCL(DATA,.EXCL) "" ;->
 ;
 ; Child nodes check...
 I $O(EXCL(""))]"" D
 .  S IEN772=0,HOLDEXCL=0
 .  F  S IEN772=$O(^TMP($J,"HLUCMSTORE","U",+IENPAR,IEN772)) Q:'IEN772!(HOLDEXCL)  D
 .  .  S DATA=$$DATA(+IEN772)
 .  .  S HOLDEXCL=$$HOLDEXCL(DATA,.EXCL)
 ;
 QUIT:$G(HOLDEXCL) "" ;->
 ;
 ; Quit, if no INCLUDES...
 QUIT:$O(INCL(""))']"" 1 ;->
 ;
 ; Inclusion check for parent node...
 QUIT:$$HOLDINCL(DATA,.INCL) 1 ;->
 ;
 ; Child node inclusion checks...
 S IEN772=0,HOLDINCL=0
 F  S IEN772=$O(^TMP($J,"HLUCMSTORE","U",+IENPAR,IEN772)) Q:'IEN772!(HOLDINCL)  D
 .  S DATA=$$DATA(+IEN772)
 .  S HOLDINCL=$$HOLDINCL(DATA,.INCL)
 ;
 Q HOLDINCL
 ;
EXCL(EXCL) ; What entries to exclude? (Searches PARENT node)
 W !!,"Every parent node that includes one of the EXCLUDE values that you enter now"
 W !,"will not be included in the entries displayed."
 W !
 D ASK("EXCLUDE",.EXCL)
 Q
 ;
HOLDEXCL(DATA,EXCL) ; Includes text that should be excluded?
 N HOLD
 S EXCL="",HOLD=0
 F  S EXCL=$O(EXCL(EXCL)) Q:EXCL']""!(HOLD)  D
 .  I DATA[EXCL S HOLD=1
 Q HOLD
 ;
INCL(INCL) ; What entries to include? (Searches PARENT node)
 W !!,"Every parent node that doesn't include one of the INCLUDE values that you"
 W !,"enter now will not be included in the entries displayed."
 W !
 D ASK("INCLUDE",.INCL)
 Q
 ;
HOLDINCL(DATA,INCL) ; Does DATA hold one of the INCLUDEs?
 N HOLD
 S INCL="",HOLD=0
 F  S INCL=$O(INCL(INCL)) Q:INCL']""!(HOLD)  D
 .  I DATA[INCL S HOLD=1
 Q HOLD
 ;
ASK(TYPE,ENTRY) ; Repeatedly ask...
 N ANS
 F  D  QUIT:ANS']""
 .  W !,TYPE,": "
 .  R ANS:999 S:ANS=U ANS="" Q:ANS']""  ;->
 .  S ENTRY(ANS)=""
 Q
 ;
SHOWU(IENPAR,VIEW) ; Show one entry in VIEW format...
 N HL,X
 MERGE HL=^TMP($J,"HLUCMSTORE","U",+IENPAR)
 S X="D "_VIEW_"(.HL)" X X
 Q
 ;
FULL(HL) ; Display one entry in FULL format...
 ; IOINHI,IOINORM -- req
 N COUNT,DATA,DATA4,DATAN,DATAP,DATAR,IEN772,L,LEN
 N PNO,PROTP,PROTC,RES,STOP
 ;
 ; Header...
 W @IOF
 S DATA=HL
 F  D  Q:DATA']""
 .  W !,$$CJ^XLFSTR($E(DATA,1,70),IOM)
 .  S DATA=$E(DATA,71,999)
 W !,$$REPEAT^XLFSTR("=",IOM)
 ;
 S PROTP=$P(HL,U,7)
 ;
 ; Body...
 S COUNT=0,IEN772=0,STOP=0
 F  S IEN772=$O(HL(IEN772)) Q:'IEN772!(STOP)  D
 .  S COUNT=COUNT+1
 .  S DATA=$$DATA(+IEN772)
 .  S L=$L(DATA),X=$E(DATA,L-2,L) I X?3U,X'="CCC" S DATA=$E(DATA,1,L-3)_IOINHI_X_IOINORM
 .  S PROTC=$P(DATA,U,7)
 .  S $P(DATA,U,7)=$S(PROTP=PROTC:"...",1:"~hi~"_PROTC_"~hi~")
 .  W !,IEN772,?12,"-",?14
 .  F PNO=1:1:$L(DATA,U) D
 .  .  S DATAP=$P(DATA,U,+PNO)
 .  .  S DATAN=$P(DATA,U,+PNO+1)
 .  .  I DATAP["~hi~" D
 .  .  .  S DATAP=$P(DATAP,"~hi~",2),LEN=$L(DATAP)+1
 .  .  .  S DATAP=IOINHI_DATAP_IOINORM
 .  .  E  S LEN=$L(DATAP)+1
 .  .  S DATAP=DATAP_$S(DATAN]"":U,1:"")
 .  .  W:(IOM-$X-LEN)'>0 !,?14
 .  .  W DATAP
 .  I '(COUNT#4) W " ",IOINHI,"<",IOINORM R X:120 I X[U S STOP=1
 .  W !,$$REPEAT^XLFSTR($S($O(HL(IEN772)):"-",1:"="),IOM)
 ;
 ; Trailer...
 S RES="C"
 F  S RES=$O(HL(RES)) Q:RES'?3U  D
 .  S DATAR=HL(RES)
 .  W $$CJ^XLFSTR(RES_" - "_DATAR,IOM)
 ;
 Q
 ;
DATA(IEN772) ; Return what is displayed...
 N DATA,IENPAR,RES
 S IENPAR=+$G(^TMP($J,"HLUCMSTORE","X",+IEN772)) QUIT:'IENPAR "" ;->
 S RES=$O(^TMP($J,"HLUCMSTORE","U",+IENPAR,+IEN772,"")) ; CCC, CXC, etc
 S DATA=$G(^TMP($J,"HLUCMSTORE","U",+IENPAR,+IEN772,RES))_"   <<>>  "_$G(^TMP($J,"HLUCMSTORE","U",+IENPAR,+IEN772,RES,772))_"   <<>>  "_RES
 I $TR(DATA," <>","")']"" S DATA=""
 Q DATA
 ;
XTMPGBL(SHOW) ; Display XTMP data totals?
 N ANS,API,BEG,COND,DATA,END,HOLD,NO,RUN,SVNO,TIME,XTMP
 ;
 S XTMP="HLUCM ",SHOW=+$G(SHOW),HOLD=0
 QUIT:$O(^XTMP(XTMP))'?1"HLUCM "7N  ;->
 W !!,$$CJ^XLFSTR(" XTMP-stored Reports ",IOM),!,$$REPEAT^XLFSTR("=",IOM)
 W !,"#",?4,"Run-time",?20,"API Call"
 W !,$$REPEAT^XLFSTR("=",IOM)
 F  S XTMP=$O(^XTMP(XTMP)) Q:XTMP'?1"HLUCM "7N  D
 .  S BEG=0
 .  F  S BEG=$O(^XTMP(XTMP,"P",BEG)) Q:'BEG  D
 .  .  S END=0
 .  .  F  S END=$O(^XTMP(XTMP,"P",BEG,END)) Q:'END  D
 .  .  .  S COND=""
 .  .  .  F  S COND=$O(^XTMP(XTMP,"P",BEG,END,COND)) Q:COND']""  D
 .  .  .  .  S DATA=$G(^XTMP(XTMP,"P",BEG,END,COND)) QUIT:DATA']""  ;->
 .  .  .  .  S SVNO=+DATA,TIME=$P(DATA,U,2) QUIT:TIME']""  ;->
 .  .  .  .  S DATA=$G(^XTMP(XTMP,"N",+SVNO)),API=$P(DATA,U,4)
 .  .  .  .  S HOLD=HOLD+1
 .  .  .  .  S HOLD(TIME,HOLD)=XTMP_U_SVNO_"~"_$E(TIME_"                    ",1,16)_$E("$$"_API_"("_BEG_","_END_",1,1,"""_COND_""",TOTALS,.ERR)",1,60)
 .  .  .  .  S RUN(+SVNO)=XTMP
 S TIME=0,HOLD=0
 F  S TIME=$O(HOLD(TIME)) Q:'TIME  D
 .  S NO=0
 .  F  S NO=$O(HOLD(TIME,NO)) Q:NO'>0  D
 .  .  S DATA=HOLD(TIME,NO),XTMP=$P(DATA,U)
 .  .  S SVNO=$P($P(DATA,"~"),U,2),DATA=$P(DATA,"~",2,999)
 .  .  S HOLD=HOLD+1
 .  .  S HOLD("N",HOLD)=XTMP_U_SVNO
 .  .  W !,$E("#"_HOLD_"    ",1,4),DATA
 ;
 QUIT:HOLD'>0 "" ;->
 ;
 W !!,"You may choose to print the totals report from stored XTMP data if you like."
 W !,"If so, enter the number of the XTMP report from above now.  (Otherwise,"
 W !,"press RETURN.)"
 ;
 R !!,"Enter XTMP Report#: ",NO:999 Q:'$D(HOLD("N",+NO)) "" ;->
 S XTMP=$P(HOLD("N",+NO),U),SVNO=$P(HOLD("N",+NO),U,2)
 ;
 Q $NA(^XTMP(XTMP,"D",SVNO))
 ;
EOR ; HLUCM004 - HL7/Capacity Mgt API ;3/13/03 09:37
