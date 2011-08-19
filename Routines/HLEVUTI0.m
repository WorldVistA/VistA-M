HLEVUTI0 ;O-OIFO/LJA - Event Monitor UTILITIES ;02/04/2004 14:42
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
SENDATA ; Interactively asks for 772 entry and returns Mailman message...
 ;
 N CT,IEN,IEN772,RECIP,SCRN,TXT,X,XMDUZ,XMSUB,XMTEXT,XMY,Y
 ;
 D HDASK,EXASK
 ;
 S SCRN=0
 ;
 KILL ^TMP($J,"HLIEN"),^TMP($J,"HLMAIL")
 ;
S0 W !!,"The most recent 772 IEN is... ",$O(^HL(772,":"),-1)
 W !
 ;
S1 F  D  I 'IEN772 Q:'$D(^TMP($J,"HLIEN"))  W ! S X=$$YN^HLCSRPT4("Stop entering 772 IENs") W:'X ! Q:X
 .  S IEN772=$$ASK772 QUIT:IEN772'>0  ;->
 .  S ^TMP($J,"HLIEN",+IEN772)=""
 ;
S2 I '$D(^TMP($J,"HLIEN")) D  QUIT  ;->
 .  W "  no entries selected..."
 ;
S3 W !
 F  D  I RECIP']"" W ! S X=$$YN^HLCSRPT4("Stop entering recipients") W:'X ! Q:X
 .  S RECIP=$$FT("Enter RECIPIENT","O") QUIT:RECIP']""  ;->
 .  S XMY(RECIP)=""
 .  W "    added..."
 ;
S4 I '$D(XMY) D  I 'SCRN KILL ^TMP($J,"HLIEN") QUIT  ;->
 .  W !!,"No recipients were entered.  You may just display the data on-screen."
 .  W !
 .  S SCRN=$$YN^HLCSRPT4("Display to screen","Yes")
 ;
S5 W !
 I 'SCRN QUIT:$$BTE^HLCSMON("Press RETURN to send message, or '^' to exit... ")  ;->
 ;
 I SCRN W @IOF
 ;
 ; Collect data...
S6 S IEN=0
 F  S IEN=$O(^TMP($J,"HLIEN",IEN)) Q:'IEN  D
 .  S IEN(1)=0,TXT="Requested 772#: "_IEN_"  ",CT=0
 .  F  S IEN(1)=$O(^HLMA("B",+IEN,IEN(1))) Q:'IEN(1)  D
 .  .  S ^TMP($J,"HLIEN",IEN,IEN(1))=""
 .  .  S CT=CT+1
 .  .  S TXT=TXT_$S(CT=1:"[773 #s: ",1:",")_IEN(1)
 .  I CT>0 S TXT=TXT_"]"
 .  D ADD(TXT)
 ;
S7 D ADD(""),ADD($$CJ^XLFSTR(" Requested Data ",74,"="))
 S IEN=0
 F  S IEN=$O(^TMP($J,"HLIEN",IEN)) Q:'IEN  D
 .  D COLLECT^HLEVUTI1(IEN)
 ;
 I SCRN D  G SENDATA ;->
 .  W !
 .  S X=$$BTE^HLCSMON("Press RETURN to continue... ")
 ;
 ; Email message...
 S XMTEXT="^TMP("_$J_",""HLMAIL"",",XMDUZ=DUZ
 S X=$$SITE^VASITE,XMSUB="HL7 Data - "_$P(X,U,2)_" ["_$P(X,U,3)_"]"
 ;
S8 D ^XMD
 ;
S9 W "  ",$S($G(XMZ):" msg# "_XMZ_"...",1:"no msg sent...")
 ;
 KILL ^TMP($J,"HLIEN"),^TMP($J,"HLMAIL")
 ;
 Q
 ;
ADD(TXT) D ADD^HLEVUTI1(TXT)
 Q
 ;
ASK772() ; Ask user for IENs...
 N CT,I773,IEN,POSX
ASK7721 S IEN=$$ASKNUM("Enter 772 IEN") QUIT:'IEN "" ;->
 I $D(^HL(772,+IEN,0)),$O(^HLMA("B",IEN,0))>0 D
 .  W:$X>55 ! W "    Adding 773s... "
 .  S POSX=$X
 .  S I773=0,CT=0
 .  F  S I773=$O(^HLMA("B",+IEN,I773)) Q:'I773  D
 .  .  S CT=CT+1
 .  .  I ($X+$L(I773)+3)>IOM S CT=0 W !
 .  .  W:$X<POSX ?POSX
 .  .  W $S(CT>1:", ",1:"")
 .  .  W I773
 QUIT:$D(^HL(772,+IEN,0)) IEN ;->
 W "  entry not found..."
 G ASK7721 ;->
 ;
FT(PMT,WAY,DEF,LF) ; Free-text DIR request...
 N DIR,DIRUT,DTOUT,DUOUT,I,X,Y
 F I=1:1:$G(LF) Q:($Y+3)>IOSL  W !
 S DIR(0)="F"_$G(WAY),DIR("A")=PMT
 D ^DIR
 QUIT:$D(DIRUT)!($D(DTOUT))!($D(DUOUT)) "" ;->
 Q Y
 ;
ASKNUM(PMT,DEF) ; Ask user for a number via DIR...
 N DIR,DIRUT,DTOUT,DUOUT,IEN,X,Y
 S DIR(0)="NOA^1:999999999999999999",DIR("A")=PMT_": "
 I $G(DEF)]"",DEF=+DEF S DIR("B")=DEF
 D ^DIR
 QUIT:$D(DIRUT)!($D(DTOUT))!($D(DUOUT)) "" ;->
 I $L(Y,773)=3,$P(Y,773,2)>0 D  QUIT Y
 .  S IEN=$P(Y,773,2) ; 773 ien...
 .  S IEN=+$G(^HLMA(+IEN,0)) QUIT:'IEN  ;->
 .  S Y=IEN
 .  W "  selecting 772# ",IEN,"..."
 Q +Y
 ;
HDASK W @IOF,$$CJ^XLFSTR("Send File 772 & 773 Data to Remote Recipient(s)",IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 QUIT
 ;
EXASK N I,T F I=1:1 S T=$T(EXASK+I) QUIT:T'[";;"  W !,$P(T,";;",2,99)
 ;;This utility collects data from the HL Message Text file (#772) and the 
 ;;HL Message Administration file (#773) and forwards the data to local and
 ;;remote recipients.
 ;;
 ;;Before starting this utility you must know the file# 772 internal entry 
 ;;number(s) (IEN).  When data is collected for file# 772 entries you have
 ;;entered, any file# 773 data linked to the selected 772 entries will also be
 ;;automatically collected and included in the transmitted message.
 QUIT
 ;
GENREP(GBLS,GBLR,NOSUB,SEQ) ; Generic report generator...
 ; GBLS = Global source...
 ; GBLR = Global report location...
 ; NOSUB = # subscript levels...
 ; --- Must be 2 to 4
 ; --- 1st subscript must be descriptive of problem, and <15 characters.
 ;     It will be placed in a field of 15 characters.
 ; --- 2nd subscript must be descriptive of entry, and <15 characters.
 ;     It will be placed in a field of 15 characters.
 ;     If the 2nd subscript is the last subscript, entries at this level
 ;     will be concatenated.
 ; --- Last subscript must identify entry, and will be concatenated.
 ; (See RECORD^HLEVX000 for example of data creation.)
 ; SEQ = Sequential & Numeric.  0/1
 ; --- If the last subscript is required to be numeric and sequential,
 ;     (like the 870 in and out queues), then combine iens into range
 ;     statements... eg, 25123-25131(#9)
 ;
 ; Stop all event monitoring to enable on-site debugging...
 QUIT:$G(^TMP("HLEVFLAG",$J))["STOP"  ;->
 ;
 S SEQ=+$G(SEQ)
 ;
 ; Make sure you don't return "leftovers" from before...
 KILL @GBLR
 ;
 ; Checks...
 QUIT:'$D(@GBLS)!($G(NOSUB)'>1)  ;->
 ;
 ; Create header...
 S TXT="List of problems" D STORE(0)
 S TXT=$$REPEAT^XLFSTR("-",74) D STORE(0)
 S TXT=""
 ;
 ; Setup & looping...
 S PROBL="",TXT="",PNO=0
 F  S PROBL=$O(@GBLS@(PROBL)) Q:PROBL']""  D
 .  S PNO=PNO+1
 .  S TXT=$E(PROBL_$$REPEAT^XLFSTR(" ",15),1,15)
 .  S SUB2=""
 .  F  S SUB2=$O(@GBLS@(PROBL,SUB2)) Q:SUB2']""  D
 .  .  I NOSUB=2 D CONCAT($$SUBSTORE(PROBL,SUB2),15) QUIT  ;->
 .  .  S TXT=$E($E(TXT,1,15)_$E(SUB2,1,15)_$$REPEAT^XLFSTR(" ",30),1,30)
 .  .  I SEQ,NOSUB=3 D CONDENSE(PROBL,SUB2)
 .  .  S SUB3=""
 .  .  F  S SUB3=$O(@GBLS@(PROBL,SUB2,SUB3)) Q:SUB3']""  D
 .  .  .  I NOSUB=3 D CONCAT($$SUBSTORE(PROBL,SUB2,SUB3),30) QUIT  ;->
 .  .  .  S TXT=$E($E(TXT,1,30)_$E(SUB3,1,30)_$$REPEAT^XLFSTR(" ",45),1,45)
 .  .  .  X "F I=$L(TXT):-1:1 Q:$E(TXT,I)'="" """ S POSX=I+2
 .  .  .  S TXT=$E(TXT_$$REPEAT^XLFSTR(" ",45),1,POSX)
 .  .  .  I SEQ,NOSUB=4 D CONDENSE(PROBL,SUB2,SUB3)
 .  .  .  S SUB4=""
 .  .  .  F  S SUB4=$O(@GBLS@(PROBL,SUB2,SUB3,SUB4)) Q:SUB4']""  D
 .  .  .  .  D CONCAT($$SUBSTORE(PROBL,SUB2,SUB3,SUB4),POSX)
 .  .  .  .  ;Subscript limit!
 .  .  .  I TXT]"" D STORE(POSX)
 .  .  I TXT]"" D STORE(30)
 .  I TXT]"" D STORE(15)
 I TXT D STORE(0)
 ;
 S TXT="" D STORE(0)
 S TXT="Problem          totals" D STORE(0)
 S TXT=$$REPEAT^XLFSTR("-",74) D STORE(0)
 ;
 S PROBL=""
 F  S PROBL=$O(@GBLS@(PROBL)) Q:PROBL']""  D
 .  S NUM=$G(@GBLS@(PROBL)) Q:NUM']""  ;->
 .  S TXT=$E(PROBL_$$REPEAT^XLFSTR(" ",15),1,15)_"  #"_NUM
 .  D STORE(30)
 ;
 Q
 ;
SUBSTORE(S1,S2,S3,S4) ; Should subscript be stored, or condensed value?
 ; GBLS -- req
 N VAL
 ;
 I $G(S4)]"" D  QUIT S4 ;->
 .  S VAL=$G(@GBLS@(S1,S2,S3,S4)) QUIT:VAL']""  ;->
 .  S S4=VAL
 ;
 I $G(S3)]"" D  QUIT S3 ;->
 .  S VAL=$G(@GBLS@(S1,S2,S3)) QUIT:VAL']""  ;->
 .  S S3=VAL
 ;
 I $G(S2)]"" D  QUIT S2 ;->
 .  S VAL=$G(@GBLS@(S1,S2)) QUIT:VAL']""  ;->
 .  S S2=VAL
 ;
 Q S2
 ;
CONDENSE(PROBL,SUB2,SUB3) ; Condense sequential numerics...
 N DIFF,FIRST,GBL,IEN,LAST,NO
 ;
 I $G(SUB3)']"" S GBL=$$COND2GBL(PROBL,SUB2)
 I $G(SUB3)]"" S GBL=$$COND3GBL(PROBL,SUB2,SUB3)
 ;
 S (FIRST,LAST)=$O(@GBL@(0)) Q:LAST'>0  ;->
 S IEN=0
 F  S IEN=$O(@GBL@(IEN)) Q:'IEN  D
 .
 .  QUIT:IEN=LAST  ;-> Must be first $O...
 .
 .  ; If IEN isn't one more than the last IEN, seq string broken
 .  I IEN'=(LAST+1) D SEQBR
 .
 .  ; Record the last IEN found...
 .  S LAST=IEN
 ;
 ; If the last entry is not one more # than the first entry...
 I LAST'=(FIRST+1) D SEQBR
 ;
 Q
 ;
SEQBR ; Sequence BRoken actions...
 ; FIRST,GBL,IEN,LAST -- req --> FIRST,@GBL[S] (reset)
 N DIFF,VAL
 S DIFF=LAST-FIRST+1 ; # IENs difference...
 S VAL=FIRST_":"_LAST_"(#"_DIFF_")"
 I (($L(LAST)*DIFF)+(DIFF))<$L(VAL) D  QUIT  ;-> No space savings
 .  S FIRST=IEN
 S @GBL@(FIRST)=VAL
 F NO=FIRST+1:1:LAST KILL @GBL@(NO)
 S FIRST=IEN
 Q
 ;
COND2GBL(PROBL,SUB2) ; Return global for NOSUB=2 looping...
 ; GBLS -- req
 N GBL
 S GBL=$E(GBLS,1,$L(GBLS)-1)_","_$$AQ(PROBL)_","_$$AQ(SUB2)_")"
 Q GBL
 ;
COND3GBL(PROBL,SUB2,SUB3) ; Return global for NOSUM=3 looping...
 ; GBLS -- req
 N GBL
 S GBL=$E(GBLS,1,$L(GBLS)-1)_","_$$AQ(PROBL)_","_$$AQ(SUB2)_","_$$AQ(SUB3)_")"
 Q GBL
 ;
AQ(VAL) ; Add quotes around non-numeric values...
 QUIT:VAL=+VAL VAL ;-> Numeric...
 QUIT """"_VAL_""""
 ;
CONCAT(VAL,PAD) ; Concatenate, separated w/commas, the VALs
 ; TXT -- req
 I ($L(TXT)+$L(VAL)+1)>74 D STORE(PAD)
 S TXT=TXT_$S($L(TXT)>PAD:",",1:"")_VAL
 Q
 ;
STORE(PAD) ; Store data in @GBLR@ in report-ready format
 ; GBLR,TXT -- req
 N NO
 S NO=$O(@GBLR@(":"),-1)+1
 S @GBLR@(+NO)=TXT
 S TXT=$$REPEAT^XLFSTR(" ",PAD)
 Q
 ;
EOR ;HLEVUTI0 - Event Monitor UTILITIES ;5/16/03 14:42
