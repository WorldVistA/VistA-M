BPSOSUD ;BHAM ISC/FCS/DRS/FLS - utils, some options ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Some utilities.
 ; Some options- goal is to move them out to other routines
 ;
 Q
 ;
INCSTAT(N1,P1,N2,P2,N3,P3) ;EP - BPSBUTL,BPSOSQL
 ; increment the given N nodes at the P pieces
 D ADD1STAT(N1,P1,1)
 Q:'$D(N2)  D ADD1STAT(N2,P2,1)
 Q:'$D(N3)  D ADD1STAT(N3,P3,1)
 Q
ADDSTAT(N1,P1,Q1,N2,P2,Q2,N3,P3,Q3) ;
 ; add Quantities to given Nodes,Pieces
 D ADD1STAT(N1,P1,Q1)
 Q:'$D(N2)  D ADD1STAT(N2,P2,Q2)
 Q:'$D(N3)  D ADD1STAT(N3,P3,Q3)
 Q
ADD1STAT(N,P,Q) ;
 L +^BPSECX("S",1,N):5
 I '$D(^BPSECX("S",1,N)) S ^BPSECX("S",1,N)=""
 S $P(^BPSECX("S",1,N),U,P)=$P(^BPSECX("S",1,N),U,P)+Q
 L -^BPSECX("S",1,N)
 Q
 ;
DATETIME(Y) ;EP - convert fileman date.time to printable
 X ^DD("DD") Q Y
TIMEAGO(THEN) ; external form for TIMEAGOI
 N %,%H,%I,X D NOW^%DTC Q $$TIMEDIF(THEN,%)
TIMEAGOI(THEN) ; how many seconds ago was it? returns positive value
 N %,%H,%I,X D NOW^%DTC ; giving %
 Q $$TIMEDIFI(THEN,%)
TIMEDIFI(X1,X2) ;EP - Computed field of BPS Log of Transactions and BPS Transactions
 ; time difference in seconds, negative if X1>X2
 I X1>X2 Q -$$TIMEDIFI(X2,X1)
 N %,X,%H,%T,%Y,D1,T1,D2,T2
 S X=X1 D H^%DTC S D1=%H,T1=%T
 S X=X2 D H^%DTC S D2=%H,T2=%T
 S X=D2-D1*86400+T2-T1
 Q X
TIMEDIF(X1,X2) ;EP - Computed field of BPS Log of Transactions and BPS Transactions
 N X S X=$$TIMEDIFI(X1,X2)
 N SGN S SGN=$S(X<0:-1,1:1),X=X*SGN
 Q $S(SGN<0:"-",1:"")_$$SECSDHMS(X)
SECSDHMS(X) ;EP - seconds ->  # da # hr # min # sec
 N % S %=""
 I X'<86400 S %=X\86400_" da",X=X#86400
 I X'<3600!(%]"") S:%]"" %=%_" " S %=%_(X\3600)_" hr",X=X#3600
 I X'<60!(%]"") S:%]"" %=%_" " S %=%_(X\60)_" min",X=X#60
 S:%]"" %=%_" " S %=%_X_" sec"
 Q %
PRESSANY D PRESSANY^BPSOSU5() Q
CONTINUE(DEF) ;EP -
 ; returns a single character
 ; or returns DEF, the default
CONT1 ;
 S X=$$FREETEXT^BPSOSU2("Type C to continue or Q to quit: ",,1,1,1,15)
 Q X
 ;
TT() Q "S:Y[""."" Y=$P(Y,""."",2) S Y=Y_""000000"" S Y=""@""_$E(Y,1,2)_"":""_$E(Y,3,4)_"":""_$E(Y,5,6)" ; TT is kind of like ^DD("DD") but just for our times
SHOULDNT W "this should never happen" Q
TDIFNOW(T) ;EP - ; compute time difference between T and NOW
 ; returns # of seconds, positive if T precedes now (how long ago)
 ;   negative if T follows NOW (countdown "T minus...")
 N %,%H,%I,X D NOW^%DTC ; giving %
 Q $$TDIF(%,T)
TDIF(T1,T2) ; compute time difference T1-T2 = how many seconds
 ;T1,T2 both Fileman date.times
 S T1=$TR($J(T1,16,8)," ","0"),T2=$TR($J(T2,16,8)," ","0")
 N R S R=$P(T1,".")-$P(T2,".")*86400 ; days' difference
 S T1=$P(T1,".",2),T2=$P(T2,".",2) ; hhmmsstt
 S T1=$E(T1,1,2)*60+$E(T1,3,4)*60+$E(T1,5,6)
 S T2=$E(T2,1,2)*60+$E(T2,3,4)*60+$E(T2,5,6)
 I $E(T1,7,8) S T1=$E(T1,7,8)/100+T1
 I $E(T2,7,8) S T2=$E(T2,7,8)/100+T2
 S R=R+T1-T2
 Q R
TADDSECS(T1,SECS) ; add SECS seconds to T1
 N T2 S T2=$$SECS2T2(SECS)
 Q $$TADD(T1,T2)
BADPARAM(VARNAME,ATLABEL) D IMPOSS^BPSOSUE("P,DB","TI","Bad parameter "_VARNAME_"="_$G(@VARNAME),,ATLABEL,$T(+0)) Q
TADDNOWS(SECS) ;EP - add SECS seconds to NOW
 I SECS'?1N.N D BADPARAM("SECS","TADDNOWS") Q ""
 N T2 S T2=$$SECS2T2(SECS)
 Q $$TADDNOW(T2)
SECS2T2(SECS) ; convert integer seconds into a fileman time format
 N T2,NEG S NEG=(SECS<0) I NEG S SECS=-SECS
 I SECS>86400 S T2=SECS\86400,SECS=SECS#86400_"."
 E  S T2="."
 N % S %=SECS\3600,SECS=SECS#3600 S:$L(%)=1 %="0"_% S T2=T2_%
 S %=SECS\60,SECS=SECS#60 S:$L(%)=1 %="0"_% S T2=T2_%
 S:$L(SECS)=1 SECS="0"_SECS S T2=T2_SECS
 Q $S(NEG:"-",1:"")_T2
TADDNOW(T2) ;EP - ; add T2 time differential to NOW
 N %,%H,%I,X D NOW^%DTC ; giving %
 Q $$TADD(%,T2)
TADD(T1,T2) ;EP -  ; add T2 time differential to T1
 I T1<0 D BADPARAM("T1","TADD") Q  ; but T2 can be negative
 N SGN S SGN=$S(T2<0:-1,1:1),T2=T2*SGN
 I SGN<0,T2>T1 D BADPARAM("T2","TADD") Q  ; can't handle this case (yet)
 S T1=$TR($J(T1,16,8)," ","0"),T2=$TR($J(T2,16,8)," ","0")
 N R ;S R=$P(T1,".",1)+($P(T2,".",1)*SGN) ; add days portion
 S R=$$CDTC($P(T1,"."),$P(T2,".")*SGN)
 S T2=$P(T2,".",2) ; note: without the sign
 S T1=$P(T1,".",2)
 S T1=$E(T1,1,2)*60+$E(T1,3,4)*60+$E(T1,5,6) ; seconds
 S T2=$E(T2,1,2)*60+$E(T2,3,4)*60+$E(T2,5,6) ; seconds
 I $E(T1,7,8) S T1=$E(T1,7,8)/100+T1 ; hundredths
 I $E(T2,7,8) S T2=$E(T2,7,8)/100+T2 ; hundredths
 S T2=T2*SGN ; restore sign to T2's hundredths
 N S S S=T1+T2
 I S>86400 S S=S-86400,R=$$CDTC(R,1) ; R+1 ; carry
 E  I S<0 S S=S+86400,R=$$CDTC(R,-1) ; R-1 ; borrow
 S T2=S\3600,S=S#3600
 S R=R_"."_$TR($J(T2,2)," ","0") ; hours
 S T2=S\60,S=S#60
 S R=R_$TR($J(T2,2)," ","0") ; minutes
 S T2=S\1,S=S#1
 S R=R_$TR($J(T2,2)," ","0") ; seconds
 S T2=S*100\1,R=R_$TR($J(T2,2)," ","0") ; hundredths of seconds
 S R=+R ; removes trailing zeroes
 Q R
CDTC(X1,X2) N X,%H D C^%DTC Q X
