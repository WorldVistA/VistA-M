XVEMSNR ;DJB/VSHL**Enter New Routine ;2017-08-16  10:25 AM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; New Error trap in TOP,GETCODE & tiny change in SAVRTN (c) 2016 Sam Habiel
 ;
TOP ;Allow user to start a new routine
 NEW CNT,CODE,DEF,FLAGQ,I,LINE,RTN,TMP,TAG,XVVS,X
 N $ESTACK,$ETRAP S $ETRAP="D ERROR,UNWIND^XVEMSY"
 S FLAGQ=0 D INIT Q:FLAGQ  KILL ^UTILITY($J)
 S CNT=1 D HD,GETCODE
 I $D(^UTILITY($J)) W ! D SAVRTN
EX ;
 KILL ^UTILITY($J)
 Q
 ;
GETCODE ;
 I $G(XVSIMERR) S $EC=",U-SIM-ERROR,"
 R !,"*",CODE:300 Q:CODE=""
 I $$CODECHK(CODE) G GETCODE
 S TAG=$P(CODE,$C(9),1),LINE=$P(CODE,$C(9),2)
 S ^UTILITY($J,0,CNT)=TAG_" "_LINE,CNT=CNT+1
 G GETCODE
 ;
SAVRTN ;Save routine
 NEW VRRPGM
 S DEF=$P(^UTILITY($J,0,1)," ",1)
 S:DEF["(" DEF=$P(DEF,"(",1)
 W !,"Save to routine name: ^"
 I DEF]"" W DEF,"// "
 R RTN:300 S:'$T RTN="^" S:RTN="" RTN=DEF
 I "^"[RTN W !,"Not saved.." Q
 I "??"[RTN D  G SAVRTN
 . W !,"Enter a valid routine name, <RETURN> for default name, or '^' to quit."
 I RTN'?1A.AN D MSG(5) G SAVRTN
 I $$EXIST^XVEMKU(RTN) D MSG(6) G SAVRTN
 I DEF]"",DEF'=RTN D  ;
 . S TMP=$P(^UTILITY($J,0,1)," ",1)
 . S TMP=$S(TMP'["(":"",1:"("_$P(TMP,"(",2,99))
 . S $P(^UTILITY($J,0,1)," ",1)=RTN_TMP
 S VRRPGM=RTN D E2^XVSE ; X ^XVEMS("E",2)
 W !,"^",RTN," Saved to disk."
 Q
 ;
HD ;Heading
 W !!,"MAKE A NEW ROUTINE"
 W !,"-----------------------------------------"
 W !,"Use <TAB> key as line start character."
 W !,"Enter <RETURN> at '*' prompt to exit."
 W !,"-----------------------------------------"
 W !,"Begin.....",!
 Q
 ;
CODECHK(CODE) ;Check code. 1=Line bad,2=Line null,3=Line Label bad
 I $G(CODE)']"" Q 0
 I $L(CODE)>245 D MSG(4) Q 1
 NEW LINE,TAG,TAG1,TAG2,TEST
 S TAG=$P(CODE,$C(9),1),TAG1=$P(TAG,"("),LINE=$P(CODE,$C(9),2,999)
 I $L(CODE,$C(9))'>1 D MSG(3) Q 1
 I LINE="" Q 2
 I TAG']"" Q 0
 I $L(TAG1)>8 D MSG(1) Q 3
 I $E(TAG1)'?1AN,$E(TAG1)'="%" D MSG(1) Q 3
 I $L(TAG1)>1,$E(TAG1)'?1N,$E(TAG1,2,999)'?1.AN D MSG(1) Q 3
 I $E(TAG1)?1N,TAG1'?1.N D MSG(1) Q 3
 I TAG'?.E1"(".E Q 0
 I $E(TAG,$L(TAG))'=")" D MSG(2) Q 3
 S TAG2=$P(TAG,"(",2,99),TAG2=$E(TAG2,1,$L(TAG2)-1) I TAG2="" Q 0
 S TEST=0 F I=1:1:$L(TAG2,",") I $P(TAG2,",",I)'?1A.AN S TEST=1 Q
 I TEST D MSG(2) Q 3
 Q 0
 ;
INIT ;
 I '$D(XVV("OS")) D OS^XVEMKY Q:FLAGQ
 D ZSAVE^XVEMKY3
 Q
 ;
ERROR ;
 KILL ^UTILITY($J)
 D ERRMSG^XVEMKU1("'Create Rtn'"),PAUSE^XVEMKU(2)
 Q
 ;
MSG(NUM) ;Messages
 ;NUM=Subroutine
 Q:$G(NUM)'>0  D @NUM
 Q
1 W $C(7),!,"Invalid Line Tag" Q
2 W $C(7),!,"Line Tag has an invalid subscript" Q
3 W $C(7),!,"Illegal Line" Q
4 W $C(7),!!,"Code length may not exceed 245 characters",! Q
5 W $C(7),"   Invalid routine name" Q
6 W $C(7),!,"A routine with this name already exists." Q
