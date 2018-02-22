XVEMSRL ;DJB/VSHL**Routine Lister [9/29/97 8:03pm];2017-08-16  10:39 AM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
EN ;
 NEW %,CEMETHOD,LINE,RLIOF,RLSIZE,RTNSIZE,TYPE
 NEW FLAGCHK,FLAGP,FLAGQ
 D INIT
TOP ;
 S (FLAGP,FLAGQ)=0
 W @RLIOF,!,"ROUTINE LISTER - David Bolduc"
 D SELECT^XVEMRUS G:$O(^UTILITY($J," "))="" EX
 D GETTYPE G:FLAGQ TOP
 I $D(^%ZIS) D DEVICE G:POP EX U IO
 D @$S(TYPE="B":"PRINT2",1:"PRINT")
 I $D(^%ZIS) D ^%ZISC
 D:'FLAGQ PAUSE^XVEMKU(2,"P")
 G TOP
EX ;
 KILL ^UTILITY($J)
 Q
 ;==================================================================
DEVICE ;
 NEW %,%X,%XX,%Y,%YY
 S %ZIS="M" D ^%ZIS Q:POP
 ;
 ;Check for TRACE devices
 S CEMETHOD=$S(ION="TRACE SCREEN CAPTURE":"S",ION="TRACE FILE":"F",1:"P")
 I CEMETHOD'="P" D ^%ZISC
 ;
 S RLIOF=IOF,RLSIZE=(IOSL-5)
 S:$E(IOST,1,2)="P-" FLAGP=1
 Q
GETTYPE ;
 W !!,"Select [B]LOCK [L]IST or [#]LINES: L// "
 R TYPE:300 S:'$T TYPE="^" S:TYPE="" TYPE="L"
 I TYPE="^" S FLAGQ=1 Q
 S TYPE=$TR(TYPE,"bl","BL")
 I ",B,L,"'[(","_TYPE_","),TYPE'?1.N D  G GETTYPE
 . W "   Enter 'B', 'L', or number of program lines to display."
 Q
PRINT ;Print routines
 NEW BYTES,CHK,CNT,I,RTN,TOTAL,X,Y
 I FLAGP=1 W !!
 E  W @RLIOF
 D HD
 S CNT=1,TOTAL=0
 S RTN=" "
 F  S RTN=$O(^UTILITY($J,RTN)) Q:RTN=""!FLAGQ  D PRINT1
 I TOTAL>0,'FLAGQ D TOTAL
 Q
PRINT1 ;
 X RTNSIZE S TOTAL=TOTAL+BYTES
 S CHK=" "
 S X=$P($T(+1^@RTN)," ")
 S:$F(X,"(") X=$P(X,"(")
 I X'=RTN S CHK="*"
 W !,CHK,$J(CNT,3),". ",RTN,?14,$J(BYTES,7)
 W ?23,$E($P($T(^@RTN)," ",2,999),6,59)
 S CNT=CNT+1
 D:$Y>RLSIZE PAGE Q:FLAGQ
 I TYPE?1.N F I=2:1:TYPE D  Q:FLAGQ
 . W !?22,$E($T(+I^@RTN),1,55)
 . I $Y>RLSIZE D PAGE
 Q
PRINT2 ;List
 NEW COL,RTN
 W @RLIOF
 S COL=1
 S RTN=" "
 F  S RTN=$O(^UTILITY($J,RTN)) Q:RTN=""!(FLAGQ)  D  ;
 . I COL=1,$Y>RLSIZE D PAGE Q:FLAGQ
 . W:COL=1 !
 . W ?COL,RTN
 . S COL=COL+10 I COL>75 S COL=1
 Q
TOTAL ;Print Total
 W !,?16,"====="
 W !?5,"TOTAL",?11,$J(TOTAL,10,0)
 Q
PAGE ;
 NEW XX
 I $O(^UTILITY($J,RTN))="" Q
 I FLAGP W @RLIOF,!! D HD Q
 D PAUSE^XVEMKU(2,"Q") Q:FLAGQ  W @RLIOF D HD
 Q
HD ;Header
 Q:TYPE'="L"
 W !?6,"ROUTINE",?16,"BYTES",?33,"CHARACTERS 20-74 OF ROUTINES TOP LINE"
 W !?6,"--------",?16,"-----",?23,"--------------------------------------------------------"
 Q
INIT ;
 I $D(^%ZOSF("SIZE")) D  I 1
 . S RTNSIZE="ZL @RTN X ^%ZOSF(""SIZE"") S BYTES=Y"
 E  S RTNSIZE="S BYTES=0 F I=1:1 S %=$T(+I^@RTN) Q:%=""""  S BYTES=BYTES+$L(%)+2"
 S $P(LINE,"=",212)=""
 S RLIOF=XVV("IOF"),RLSIZE=18
 Q
