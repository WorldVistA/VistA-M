ORUS4 ; slc/KCM - Select Items from List ;11/7/90  16:30 ;
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**65**;Dec 17, 1997
LOOK K ORFND S (ORFND,ORITM)=0 I $L(ORWRK)>60 S ORERR=1 Q
 D L1 I ORITM Q
 K ORFND S ORFND=0,A=$E(ORWRK,1,$L(ORWRK)-1)_$C($A($E(ORWRK,$L(ORWRK)))-1)_"~",ORBUF=A
 F I=0:0 S A=$O(@(ORLK_"A)")) Q:A=""  Q:$E(A,1,$L(ORWRK))'=ORWRK  S B="" F I=0:0 S B=$O(@(ORLK_"A,B)")) Q:B=""  I '$D(ORFND("B",B)),$D(@(ORUS_"B,0)")) S ORDA=B X ORSC I $T,$D(@(ORUS_"B,0)")) X ORWR I $L(X) D SFND
 S A=ORBUF F I=0:0 S A=$O(@(ORUS_"""B"",A)")) Q:A=""  Q:$E(A,1,$L(ORWRK))'=ORWRK  S B="" F I=0:0 S B=$O(@(ORUS_"""B"",A,B)")) Q:B=""  I '$D(ORFND("B",B)),$D(@(ORUS_"B,0)")) S ORDA=B X ORSC I $T,$D(@(ORUS_"B,0)")) X ORWR I $L(X) D SFND
 I $D(OR9)>0 S A=ORBUF F I=0:0 S A=$O(OR9("B",A)) Q:A=""  Q:$E(A,1,$L(ORWRK))'=ORWRK  S B=$O(OR9("B",A,0)) I $L(B),'$D(ORFND("B",B)) S ORFND=ORFND+1,ORFND(ORFND)=B_"^"_$P(OR9(B),"^")_"^9",ORFND("B",B)=""
 I $D(OR9),ORWRK?.N,$D(OR9("B",ORWRK)) S B=$O(OR9("B",+ORWRK,0)) I $L(B),'$D(ORFND("B",B)) S ORFND=ORFND+1,ORFND(ORFND)=B_"^"_$P(OR9(B),"^")_"^9",ORFND("B",B)=""
 I (ORSEL?1A.A1","1A.A.1" ".A),(ORFND=0) S ORERR=1
L1 I ORWRK?.N,ORUS(0)["N",$D(^XUTL("OR",$J,"ORW",ORWRK)) S ORDA=^(ORWRK) I '$D(ORFND("B",ORDA)),$D(@(ORUS_"ORDA,0)")) X ORWR S ORFND=ORFND+1,ORFND(ORFND)=ORDA_"^"_X_"^0",ORFND("B",ORDA)=""
 S ORITM=0
 I ORFND=1 S ORITM=ORFND(1) K ORFND Q
 I ORFND=0,X="ALL" D:ORUS(0)["S" SING^ORUS1 S:ORUS(0)'["S" ORITM=-1 Q
 I ORFND>0 D CHOOZ
 Q
CHOOZ S ORBUF=X F J=1:1:ORFND W !,$J(J,6),?9,$P(ORFND(J),"^",2)
 F I=0:0 W !,$S(ORSEL[","!(ORSEL["-"):"For entry """_ORWRK_""" ",1:""),"CHOOSE 1-",ORFND,": " R X:DTIME S:'$T X="^" S:X["^^" DIROUT=1 S:'$L(X)!(X["^") ORERR=1 Q:X'["?"  W !!,"Enter a number from 1 to ",ORFND," or type another selection.",!
 Q:ORERR
 I $D(ORFND(X)) S ORITM=ORFND(X),X=ORBUF K ORFND Q
 K ORFND S ORWRK=X D LOOK
 Q
SFND S ORFND=ORFND+1,ORFND(ORFND)=ORDA_"^"_X_"^0",ORFND("B",ORDA)=""
 Q
