%ZTP1 ;SF/RWF -  PRINTS 1ST LINES IN SIZE OR DATE ORDER ;04/12/2007
 ;;7.3;TOOLKIT;**20,70,91,105**;Apr 25, 1995;Build 2
A W !!,"PRINTS FIRST LINES",!!
 K ^UTILITY($J) S DTIME=$G(DTIME,300)
 X ^%ZOSF("RSEL") G KIL:$O(^UTILITY($J,0))=""
A1 ;
 N ZTP1,Z2,X
A2 R !,"(A)lpha, (D)ate ,(P)atched, OR (S)ize ORDER: A//",ZTP1:DTIME
 S:ZTP1="" ZTP1="A" S ZTP1=$E(ZTP1,1) G KIL:ZTP1="^",A2:"ADPS"'[ZTP1
 S Z2=$S(ZTP1="P":"2",1:"None")
A3 W !,"Include line (2), Include lines 2&(3), (N)one: ",Z2,"//" R X:DTIME
 S X=$TR(X,"n","N")
 G KIL:X["^"!('$T) S:X="" X=Z2 G A3:"23N"'[$E(X) S Z2=+X
 S %ZIS="QM" D ^%ZIS G KIL:POP
 I $D(IO("Q")) D  D ^%ZISC Q
 . K IO("Q") S ZTRTN="B^%ZTP1",ZTSAVE("ZTP1")="",ZTSAVE("^UTILITY($J,")="",ZTSAVE("Z2")="",ZTDESC="FIRST LINES PRINT"
 . D ^%ZTLOAD K ZTSK Q
 ;Set RN for all loops
B ;Taskman entry point
 N %L,%R,%ZN,A,B,C,HED,JR,S,X,Y,ZTP,ZP,RN
 S RN=2 G DATE:ZTP1="D",SIZE:ZTP1="S",PATCH:ZTP1="P"
 ;
ALPHA F JP=1:1 S RN=$O(^UTILITY($J,RN)) Q:RN=""  S ^UTILITY($J,1,JP,RN)=0
 S HED="    FIRST LINE LIST:"
 G LIST
 ;
SIZE ;Sort by routine size
 F JR=1:1 S RN=$O(^UTILITY($J,RN)) Q:RN=""  D
 . D LOAD(RN)
 . S Y=$$SIZE2 W RN," ",Y,?$X\19+1*19
 . D KEEP(Y,RN) W:$X>66 !
 S HED="    SIZE RANKING:"
 G LIST
 ;
LOAD(X,R) ;Load routine
 N DIF,XCNP K ^TMP($J)
 S DIF="^TMP($J,",XCNP=0 X ^%ZOSF("LOAD")
 I $D(R) S R(1)=$G(^TMP($J,1,0)),R(2)=$G(^TMP($J,2,0)),R(3)=$G(^TMP($J,3,0))
 Q
 ;
KEEP(IX1,IX2) ;
 S ^UTILITY($J,1,IX1,IX2)=2
 S ^UTILITY($J,1,IX1,IX2,1)=^TMP($J,1,0),^UTILITY($J,1,IX1,IX2,2)=^TMP($J,2,0),^UTILITY($J,1,IX1,IX2,3)=$G(^TMP($J,3,0))
 Q
 ;
LIST ;All 3 sorts come here to print the list.
 N %X,QUIT,L,L1,L2,S,PL,X
 S PL=IOSL-3-Z2,X=$H X ^%ZOSF("ZD")
 S HED=Y_"   "_HED X ^%ZOSF("UCI") S HED=Y_"   "_HED
 U IO D HED
 S ZP=0,X=0,QUIT=0,S=0
 F  S S=$O(^UTILITY($J,1,S)),RN="" Q:(S'>0)!(QUIT)  D
 . F  S RN=$O(^UTILITY($J,1,S,RN)) Q:'$L(RN)!QUIT  D
 . . D:$Y>PL WAIT I X["^" S RN="zz",QUIT=1,S=" " Q
 . . S ZP=ZP+1 D L2
 I 'QUIT W !!?14,ZP," ROUTINES",!
KIL D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K ^UTILITY($J)
 Q
 ;
L2 ;Write one
 N LI
 I ^UTILITY($J,1,S,RN) S LI(1)=^(RN,1),LI(2)=^(2),LI(3)=^(3)
 I '$T S LI=0 D LOAD(RN,.LI) S LI(1)=$P(LI(1)," ",2,999)
 W RN,?10 W:ZTP1="S" $J(S,4)," - " S %X=$X-1 D WR(LI(1))
 I Z2 W ?%X D WR(LI(2)) I Z2>2 W ?%X D WR(LI(3)):Z2>2
 Q
 ;
WR(STR) ;Write line w/ wrap
 N %1,%2
 S %1=$X+1,%2=IOM-1-%1
 F  W $E(STR,1,%2) S STR=$E(STR,%2+1,9999) Q:'$L(STR)  W !,?%1
 W:$X>0 !
 Q
 ;
WAIT ;Wait at end of page
 I IOST["C-" R !,"Enter Return to continue ",X:DTIME Q:X["^"
HED W @IOF,!?8,HED,! Q
 ;
DATE ;Sort by date
 F JR=1:1 S RN=$O(^UTILITY($J,RN)) Q:RN=""  D
 . N L S L=0 D LOAD(RN,.L)
 . S X=$$DTF(L(1)) D KEEP(9999999-X,RN)
 . W RN," ",Y,?$X\19+1*19 W:$X>66 !
 . Q
 S HED="    REVERSE DATE ORDER:"
 G LIST
DTF(L) ;Find the date
 N %,PC,%DT,B,S
 F PC=2:1:$L(L,";") S B=1,X=$P(L,";",PC) D  Q:Y>0
 . S Y=-1,%DT="T"
 . S:X?.E1"["1.2N1"/"1.2N1"/"2N1" "1.2N1":"1.2N.E1"]  ".E X=$P($P(X,"[",2),"]",1)
 . F %=1:1:$L(X) D  Q:Y>0
 . . S S=$E(X,%)?1P S:B&S X=$E(X,1,%-1)_$E(X,%+1,999),%=%-1
 . . S:'S B=0 S:$E(X,%+1,999)?1N.N1":".E X=$E(X,1,%-1)_"@"_$E(X,%+1,999),%=999
 . . I %>$L(X) N % D ^%DT
 . . Q
 . Q
 Q Y
 ;,X=$P(ZTP,"" ;"",3) X A(1) S B=1,X=$P(ZTP,"";"",4) X:Y<0 A(1)
 ;
PATCH ;Sort by first patch number
 N S2
 F S2=0:0 S RN=$O(^UTILITY($J,RN)) Q:RN=""  D
 . N L S L=0 D LOAD(RN,.L)
 . S X=$P(L(2),";",5) I X]"" S S=+$P(X,"**",2) D KEEP(S,RN)
 S HED="    Patched routines"
 G LIST
 ;
SIZE2() ; Return size in bytes of routine in ^TMP($J)
 N NUM,LINE,SIZE ; line number, line text, size
 S SIZE=0
 F NUM=1:1 S LINE=$G(^TMP($J,NUM,0)) Q:LINE=""  S SIZE=SIZE+$L(LINE)+2
 Q SIZE
 ;
BUILD ;
 N Y,BLDA,%N,S2
 I '$D(^XPD(9.6,0)) W !,"No BUILD file to work from." Q
 S Y=$$BUILD^XTRUTL1 G KIL:Y'>0 S BLDA=+Y
 D RTN^XTRUTL1(BLDA)
 I '$D(^UTILITY($J)) W !,"No routines in this build." G KIL
 G A1
 ;
POST ;POST-INIT
 N %D,%S,I,SCR,ZTOS,ZTMODE
 S ZTMODE=2,ZTOS=$$OS^ZTMGRSET()
 S %S="ZTP1",%D="%ZTP1",SCR="I 1" D MOVE^ZTMGRSET
 Q
