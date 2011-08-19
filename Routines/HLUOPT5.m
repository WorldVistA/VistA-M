HLUOPT5 ;OIFO-O/LJA - Purging Entries in file #772 and #773 ;02/04/2004 16:37
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
 ; This routine was created by patch HL*1.6*109
 ;
GRAPH ; Display graph for all entries in ^XTMP
 N DATA,DATE,END,HOLD,MAX,MULT,START,TXT,TYPE,VAL,XTMP
 ;
 ; Create HOLD(...) with entry data, and max values...
 S XTMP="HLUOPT1 "
 F  S XTMP=$O(^XTMP(XTMP)) Q:XTMP'["HLUOPT1 "  D
 .
 .  S DATA=$G(^XTMP(XTMP,"RUN")) Q:$P(DATA,U,5)'["FINISHED"  ;->
 .
 .  S START=$P(DATA,U,2) QUIT:START'?7N.E  ;->
 .  S END=$P(DATA,U,4) QUIT:END'?7N.E  ;->
 .  S DIFF=$$FMDIFF^XLFDT(END,START,2) ; Hours difference
 .  D HOLD(1,DIFF)
 .
 .  S DEL772=$P(DATA,U,8)
 .  D HOLD(2,DEL772)
 .
 .  S DEL773=$P(DATA,U,10)
 .  D HOLD(3,DEL773)
 .
 .  S HOLD($P(XTMP," ",2))=DIFF_U_DEL772_U_DEL773
 ;
 QUIT:'$D(HOLD)  ;->
 ;
 ; Calculate graph multiplier...
 F TYPE=1,2,3 D
 .  S MAX=HOLD(TYPE)
 .  S MULT(TYPE)=MAX/21\1
 ;
 W !,"VistA HL7 Purge Graph"
 W !,"Purge-Date  | Purge-Time           | 772 Deletions        | 773 Deletions"
 W !,$$REPEAT^XLFSTR("=",IOM)
 W !,?12,"| Max Hr = ",$J(HOLD(1)/(3600),0,1)
 W ?35,"| Max # = ",$FN(HOLD(2),",")
 W ?58,"| Max # = ",$FN(HOLD(3),",")
 W !,$$REPEAT^XLFSTR("=",IOM)
 ;
 S DATE=0
 F  S DATE=$O(HOLD(DATE)) Q:'DATE  D
 .
 .  QUIT:DATE'?7N1"."1.N  ;->
 .  S TXT=$$SDT^HLUOPT4(DATE)_" |"
 .
 .  S DATA=HOLD(DATE) ; Get data...
 .
 .  S VAL=$P(DATA,U) ; Time difference...
 .  D PAD(VAL,21,1)
 .
 .  S VAL=$P(DATA,U,2) ; #772 deleted...
 .  D PAD(VAL,21,2)
 .
 .  S VAL=$P(DATA,U,3) ; #773 deleted...
 .  D PAD(VAL,21,3)
 .
 .  W !,TXT
 ;
 Q
 ;
PAD(NUM,COL,MULTNO) ; Add VAL to TXT...
 ; TXT -- req
 N CHAR
 S MULT=MULT(MULTNO)
 S CHAR=$S(MULT:$E($$REPEAT^XLFSTR("=",NUM\MULT),1,COL),1:"")
 S CHAR=$E(CHAR_$$REPEAT^XLFSTR(" ",COL),1,COL)
 S CHAR=CHAR_$S(MULTNO'=3:" |",1:"")
 S TXT=TXT_CHAR
 Q
 ;
HOLD(NUM,VAL) ; Update HOLD(#)...
 S:'$D(HOLD(NUM)) HOLD(NUM)=VAL
 S:VAL>HOLD(NUM) HOLD(NUM)=VAL ; Largest value...
 Q
 ;
GRAPHONE(XTMP) ; Display graph bar for one XTMP entry...
 ;
 Q
 ;
SHOWALL(XTMP) ; Show all information
 N I,ACTIVE,COLNO,CURR,LAST,PCE1,PCE2,PCE3,PCE4,PCE5,PCE6,PCE7
 N PCE8,PCE9,PCE10,PCE11,PCE12,PCE13,PCE14,PMT
 S COLNO=5
 F  D  Q:'$$BTE(PMT,1,120)  Q:'ACTIVE
 .  S RUN=$G(^XTMP(XTMP,"RUN")) I RUN']"" W "  no data..." QUIT  ;->
 .  F I=1:1:16 S CURR(I)=$P(RUN,U,I)
 .  F I=1:1:16 S @("PCE"_I)=$P(RUN,U,I)
 .  S PCE2=$$FMTE^XLFDT(PCE2),PCE3=$$FMTE^XLFDT(PCE3),PCE4=$$FMTE^XLFDT(PCE4)
 .  W !!,$$CJ^XLFSTR(" "_$$FMTE^XLFDT($$NOW^XLFDT)_"  ["_XTMP_"] ",IOM,"=")
 .  W !,$$D(2),?COLNO,"Start time: ",?(COLNO+25),PCE2,$$S(2)
 .  W !,$$D(3),?COLNO,"Last timestamp: ",?(COLNO+25),PCE3,$$S(3)
 .  W !,$$D(4),?COLNO,"End time: ",?(COLNO+25),PCE4,$$S(4)
 .  S PMT=$S(PCE4]"":"Press RETURN to exit... ",1:"Wait 120 seconds for refresh, or enter '^' to exit... ")
 .  S ACTIVE=$S(PCE4]"":0,1:1) ; Is last job still running?
 .  W !,$$D(5),?COLNO,"Status: ",?(COLNO+25),$J(PCE5,9),$$S(5,9)
 .  W !,$$D(6),?COLNO,"Location: ",?(COLNO+25),$J(PCE6,9),$$S(6,9)
 .  W !,$$D(1),?COLNO,"Task number: ",?(COLNO+25),$J(PCE1,9),$$S(1,9)
 .  W !,$$REPEAT^XLFSTR("-",IOM)
 .  W !,$$D(7),?COLNO,"#772 reviewed: ",?(COLNO+25),$J(PCE7,9),$$S(7,9)
 .  W !,$$D(12),?COLNO,"#772 revw'd w/o purging: ",?(COLNO+25),$J(PCE12,9),$$S(12,9)
 .  W !,$$D(11),?COLNO,"Last 772 reviewed: ",?(COLNO+25),$J(PCE11,9),$$S(11,9)
 .  S X=$$D(11) I X']"" W $$SDT^HLUOPT4(PCE15)
 .  W !,$$D(8),?COLNO,"#772 purged: ",?(COLNO+25),$J(PCE8,9),$$S(8,9)
 .  W !,$$REPEAT^XLFSTR("-",IOM)
 .  W !,$$D(9),?COLNO,"#773 reviewed: ",?(COLNO+25),$J(PCE9,9),$$S(9,9)
 .  W !,$$D(14),?COLNO,"#773 revw'd w/o purging: ",?(COLNO+25),$J(PCE14,9),$$S(14,9)
 .  W !,$$D(13),?COLNO,"Last 773 reviewed: ",?(COLNO+25),$J(PCE13,9),$$S(13,9)
 .  S X=$$D(13) I X']"" W $$SDT^HLUOPT4(PCE16)
 .  W !,$$D(10),?COLNO,"#773 purged: ",?(COLNO+25),$J(PCE10,9),$$S(10,9)
 .  F I=1:1:14 S LAST(I)=$P(RUN,U,I)
 QUIT
 ;
D(NO) ; Any change since last display?
 QUIT:'$D(LAST) "" ;->
 QUIT:CURR(NO)=LAST(NO) "" ;->
 QUIT "->"
 ;
S(NO,COL) ; Display previous value....
 N TXT
 S TXT="",COL=+$G(COL)
 QUIT:'$D(LAST) $J("",COL) ;->
 QUIT:CURR(NO)=LAST(NO) $J("",COL) ;->
 S TXT=$E($$REPEAT^XLFSTR("_",IOM),1,53-$X)
 I NO>3 S TXT=TXT_LAST(NO) QUIT $J(TXT,COL) ;->
 I LAST(NO)?7N.E W $J(TXT_$$FMTE^XLFDT(LAST(NO)),COL)
 QUIT ""
 ;
BTE(PMT,FF,TIMEOUT) ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 F X=1:1:$G(FF) W !
 S DIR(0)="EA",DIR("A")=PMT
 S:$G(TIMEOUT) DIR("T")=TIMEOUT
 D ^DIR
 QUIT:$D(DUOUT) "" ;->
 QUIT $S(Y=1!($D(DIRUT)):1,1:"") ; 1... if RETURN or timeout...
 ;
EOR ;HLUOPT5 - Purging Entries in file #772 and #773 ;12/10/02 16:37
