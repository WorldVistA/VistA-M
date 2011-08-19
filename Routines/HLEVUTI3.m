HLEVUTI3 ;O-OIFO/LJA - Event Monitor UTILITIES ;02/04/2004 14:42
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
MOVETMP(FILE,IEN,GBLSV) ; Move ^UTILITY data into ^TMP and prep it...
 N DATA,FLD,FLDLEN,FLDNM,GBL,MNO,NO,NUM,STR
 ;
 KILL ^TMP($J,"HLTMP")
 ;
 S GBL=$NA(^UTILITY("DIQ1",$J))
 ;
 D ADDLN(GBLSV,$$CJ^XLFSTR(" "_FILE_"#: "_IEN_" ",74,"="))
 ;
 S FLD=0
 F  S FLD=$O(@GBL@(FILE,IEN,FLD)) Q:FLD'>0  D
 .  S FLDNM="["_$P($G(^DD(+FILE,+FLD,0)),U)
 .  S DATA=$G(@GBL@(FILE,IEN,+FLD,"E"))
 .  I DATA]"" D  QUIT  ;->
 .  .  S NO=$O(^TMP($J,"HLTMP",":"),-1)+1
 .  .  S ^TMP($J,"HLTMP",+NO)=FLDNM_U_FLD_U_DATA_"]"
 .  S MNO=0,FLD(1)=FLD
 .  F  S MNO=$O(@GBL@(FILE,IEN,FLD,"E",MNO)) Q:MNO'>0  D
 .  .  S DATA=$G(@GBL@(FILE,IEN,FLD,"E",+MNO))
 .  .  S NO=$O(^TMP($J,"HLTMP",":"),-1)+1
 .  .  S ^TMP($J,"HLTMP",+NO)=FLDNM_U_FLD(1)_U_DATA_"]"
 ;
 S NO=0,STR=""
 F  S NO=$O(^TMP($J,"HLTMP",NO)) Q:NO'>0  D
 .  S DATA=^TMP($J,"HLTMP",NO) QUIT:DATA']""  ;->
 .  S FLDNM=$P(DATA,U),FLD=$P(DATA,U,2),DATA=$P(DATA,U,3,999)
 .  I FILE=772,FLD=200 S FLDNM="MSG"
 .  S FLDNM=$S(FLDNM]"":FLDNM_": ",1:""),FLDLEN=$L(FLDNM)
 .  S DATA=$$LOW^XLFSTR(FLDNM)_DATA
 .  I FLD']"" D  QUIT  ;-> standalone line...
 .  .  I STR]"" D ADDLN(GBLSV,STR)
 .  .  D ADDLN(GBLSV,"     "_DATA)
 .  I ($L(STR)+$L(DATA)+3)>74 D
 .  .  I STR]"" D ADDLN(GBLSV,STR)
 .  .  S STR=""
 .  S STR=STR_$$PAD(STR,$L(DATA))_DATA QUIT:$L(STR)<74  ;->
 .  F  D  QUIT:STR']""
 .  .  D ADDLN(GBLSV,$E(STR,1,74))
 .  .  S STR=$E(STR,75,999) QUIT:STR']""  ;->
 .  .  S STR="     "_STR
 I STR]"" D ADDLN(GBLSV,STR)
 ;
 KILL ^TMP($J,"HLTMP")
 ;
 Q
 ;
PAD(STR,LEN) ; Add spaces to right justify...
 QUIT:STR']"" "" ;->
 I ($L(STR)+LEN)<40 QUIT "   " ;->
 Q $$REPEAT^XLFSTR(" ",74-$L(STR)-LEN)
 ;
ADDLN(GBLSV,DATA) ; Add one line of text...
 N NUM
 S NUM=$O(^TMP($J,GBLSV,":"),-1)+1
 S ^TMP($J,GBLSV,+NUM)=DATA
 Q
 ;
LASTIEN ; Display last IEN of files 772 & 773 every 15 seconds...
 N B,CT,DIFF,DIR,DIROUT,DIRUT,DTOUT,DUOUT,IEN772,IEN773
 N LAST772,LAST773,STOP,TIMEOUT,X,Y
 ;
 W @IOF,$$CJ^XLFSTR("File 772 & 773 IEN Display",IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 ;
 W !!,"This API displays the last internal entry number (IEN) in the following files:"
 W !!,"  * HL Message Text file (#772)."
 W !,"  * HL Message Administration file (#773)."
 W !!,"The last IEN in these files are recollected and redisplayed every 15 seconds."
 W !,"After every display of these IENs, you may take the following actions:"
 W !!,"  * Do nothing, & the information will be redisplayed in 15 seconds."
 W !,"    (You may change the refresh seconds by entering a number of seconds"
 W !,"    and pressing RETURN.)"
 W !!,"  * Hit return to force information redisplay."
 W !!,"  * Enter an uparrow ('^') and press RETURN to exit."
 ;
 F  QUIT:($Y+3)>IOSL  W !
 QUIT:$$BTE^HLCSMON("Press RETURN to start, or '^' to exit... ")  ;->
 ;
 W @IOF
 S X=$$SITE^VASITE W $$CJ^XLFSTR(" "_$P(X,U,2)_" ["_$P(X,U,3)_"] ",IOM,"=")
 D HDRIEN
 ;
 S CT=0,TIMEOUT=15,B="|"
 S (IEN772,IEN773,LAST772,LAST773)=""
 ;
 F  D  QUIT:STOP
 .  S CT=CT+1
 .  S IEN772=$O(^HL(772,":"),-1),IEN773=$O(^HLMA(":"),-1)
 .  I '(CT#22) W !! D HDRIEN
 .  W !,$$SDT($$NOW^XLFDT),?19,B
 .  W ?21,IEN772,?36,$$DIFFIEN(IEN772,LAST772),?45,B
 .  W ?47,IEN773,?61,$$DIFFIEN(IEN773,LAST773),?73,B
 .  S LAST772=IEN772,LAST773=IEN773
 .  S STOP=1
 .  R " ",X:TIMEOUT
 .  QUIT:X[U  ;->
 .  S STOP=0
 .  QUIT:'$T  ;-> Timed out...
 .  I X=+X,X>0 S TIMEOUT=X D  QUIT  ;->
 .  .  W """"
 .  ; User pressed RETURN...
 .  W "<ret>"
 ;
 Q
 ;
DIFFIEN(LAST,BEFORE) ; Return number new entries right justified in 3 col's
 N DIFF
 QUIT:LAST'>0!(BEFORE'>0) "" ;->
 S DIFF=LAST-BEFORE QUIT:DIFF'>0 "" ;->
 QUIT $J(DIFF,3)
 ;
HDRIEN ;
 N B
 S B="|"
 W:$X>0 !
 W "Time",?19,B,?21,"LAST-772-IEN",?36,"#772",?45,B
 W ?47,"LAST-773-IEN",?61,"#773",?73,B
 W !,$$REPEAT^XLFSTR("=",IOM)
 Q
 ;
SDT(FMTIME) ; Return DD/MM/YY@HH:MM:SS
 N DATE,TIME
 QUIT:$G(FMTIME)'?7N.E "" ;->
 S TIME=$S(FMTIME?7N1"."1.N:"@"_$E($P($$FMTE^XLFDT(FMTIME),"@",2)_":00:00",1,8),1:"")
 S DATE=$E(FMTIME,4,5)_"/"_$E(FMTIME,6,7)_"/"_$E(FMTIME,2,3)
 Q DATE_TIME
 ;
EOR ;HLEVUTI3 - Event Monitor UTILITIES ;5/16/03 14:42
