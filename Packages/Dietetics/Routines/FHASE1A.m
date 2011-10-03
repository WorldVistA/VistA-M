FHASE1A ; HISC/REL/NCA - Encounter Statistics (cont.) ;9/6/94  13:13 
 ;;5.5;DIETETICS;;Jan 28, 2005
Q1 ; Calculate the Encounters
 K ^TMP($J) S X1=SDT\1-.0001,X2=EDT\1+.3
 S TIT=";"_$P(^DD(115.6,10,0),"^",3)
R1 S X1=$O(^FHEN("AT",X1)) I X1<1!(X1>X2) G P1
 S E1=0
R2 S E1=$O(^FHEN("AT",X1,E1)) G:E1="" R1
 S Y=$G(^FHEN(E1,0))
 S D1=$P(Y,"^",3),D2=$P(Y,"^",4) G:'D2 R2 I FHX1>0,D1'=FHX1 G R2
 S D6=$P(Y,"^",7),D3=$P(Y,"^",8),D9=$P(Y,"^",9),D5=$P(Y,"^",11) D CNT
 S D2=$P($G(^FH(115.6,D2,0)),"^",1,2) G:"^"[D2 R2
 S Z1=$P(D2,"^",2),D2=$P(D2,"^",1)
 S D8=$F(TIT,";"_Z1_":") G:D8<0 R2
 S:D6="F" D2=D2_"~F"
 S S1=$G(^TMP($J,0,D8,D2)) D UPD S ^TMP($J,0,D8,D2)=S1
 G R2:FHX1<0,R2:'D1 I '$D(^TMP($J,D1)) S NAM=$P(^VA(200,D1,0),"^",1),^TMP($J,$E(NAM,1,30),D1)=""
 S S1=$G(^TMP($J,D1,D8,D2)) D UPD S ^TMP($J,D1,D8,D2)=S1 G:'FHX2 R2
 S (DTP,W1)=$P(Y,"^",2)\1 D DTP^FH I '$D(^TMP($J,D1,D8,D2,W1)) S ^TMP($J,D1,D8,D2,W1)=DTP,^(W1,0)=0
 I '$D(^FHEN(E1,"P")) G R4
 F DFN=0:0 S DFN=$O(^FHEN(E1,"P",DFN)) Q:DFN<1  D R3
 G R2
R3 S L=^TMP($J,D1,D8,D2,W1,0)+1,^(0)=L
 S ^TMP($J,D1,D8,D2,W1,L)=DFN Q
R4 S DFN="^"_D5 D R3 G R2
CNT S C(8)=$P(Y,"^",10),(C(1),C(2),C(3),C(4),C(5),C(6),C(7))=0
 F DFN=0:0 S DFN=$O(^FHEN(E1,"P",DFN)) Q:DFN<1  S X=^(DFN,0) D C1
 S C(7)=C(8)-C(1)-C(2)-C(4)-C(5) S:C(7)<1 C(7)=0
 I D9'="I" S TM=C(1)+C(4)+C(7) I TM S TM=D3/TM,C(3)=TM*C(1),C(6)=TM*C(4),C(3)=$J(C(3),0,1),C(6)=$J(C(6),0,1) Q
 Q
C1 S Z=$P(X,"^",2) G:Z<1 C2 S Z=$P($G(^SC(+Z,0)),"^",3) G:Z'="W" C2
 S C(1)=C(1)+1,C(2)=C(2)+$P(X,"^",3) S:D9="I" C(3)=C(3)+D3 Q
C2 S C(4)=C(4)+1,C(5)=C(5)+$P(X,"^",3) S:D9="I" C(6)=C(6)+D3 Q
UPD S $P(S1,"^",1)=$P(S1,"^",1)+1,$P(S1,"^",2)=$P(S1,"^",2)+D3
 F K=1:1:8 I C(K) S $P(S1,"^",K+2)=$P(S1,"^",K+2)+C(K)
 Q
P1 S DTP=SDT\1 D DTP^FH S DTE=DTP_" to " S DTP=EDT\1 D DTP^FH S DTE=DTE_DTP,PG=0 D HEAD I FHX1>0 G D0
 S D8="",CT=0 F K=1:1:11 S (I(K),J(K))=0
 F KK=0:0 S D8=$O(^TMP($J,0,D8)) Q:D8=""  S CT=CT+1 D:CT'=1 STOT W ! D PR S NX="" F K=0:0 S NX=$O(^TMP($J,0,D8,NX)) Q:NX=""  S X1=$P(NX,"~",1)_$S($P(NX,"~",2)="F":"  (F)",1:"") Q:X1=""  S S1=^TMP($J,0,D8,NX) D PP
 D STOT W ! S X="T O T A L" D TOT W ! Q:FHX1<0  D HEAD
D0 S NX=":" F K=0:0 S NX=$O(^TMP($J,NX)) Q:NX=""  F D1=0:0 S D1=$O(^TMP($J,NX,D1)) Q:D1<1  D P2
 W ! Q
P2 D:$Y>(IOSL-6) HEAD W !!,NX S D8="",CT=0 F K=1:1:11 S (I(K),J(K))=0
 F L=0:0 S D8=$O(^TMP($J,D1,D8)) Q:D8=""  S CT=CT+1 D:CT'=1 STOT W ! D PR S D2="" F L1=0:0 S D2=$O(^TMP($J,D1,D8,D2)) Q:D2=""  S S1=^(D2),X1=$P(D2,"~",1)_$S($P(D2,"~",2)="F":"  (F)",1:"") D PP I FHX2 D P3
 D STOT W ! S X="TOTAL ENCOUNTERS" D TOT Q
P3 S DTP=""
P4 S DTP=$O(^TMP($J,D1,D8,D2,DTP)) Q:DTP=""  S S1=^(DTP),W1=0
P5 S W1=$O(^TMP($J,D1,D8,D2,DTP,W1)) G:W1="" P4 S DFN=^(W1) G:DFN<1 P6
 S Y=$G(^DPT(DFN,0)) G:Y="" P5 D PID^FHDPA
 W !?7,S1,?17,BID,?26,$P(Y,"^",1) G P5
P6 W !?7,S1,?17,$P(DFN,"^",2) G P5
PP D:$Y>(IOSL-6) HEAD W !?5,X1,?47,$J($P(S1,"^",1),6,0) S I(1)=I(1)+$P(S1,"^",1),J(1)=J(1)+$P(S1,"^",1)
 F K=1:1:6 S Z=$P(S1,"^",K+2),I(K+2)=I(K+2)+Z,J(K+2)=J(K+2)+Z W $S(K=3!(K=6):$S(Z:$J(Z,8,1),1:$J("",8)),1:$J($S(Z:Z,1:""),6))
 S Z=$P(S1,"^",9),I(9)=I(9)+$S(Z'<1:Z,1:0),J(9)=J(9)+$S(Z'<1:Z,1:0) W ?97,$J($S(Z'<1:Z,1:""),6)
 I Z S Z=$P(S1,"^",2)-$P(S1,"^",5)-$P(S1,"^",8),I(10)=I(10)+$S(Z'<1:Z,1:0),J(10)=J(10)+$S(Z'<1:Z,1:0)
 W $S(Z'<1:$J(Z,8,1),1:$J("",8))
 S Z=$P(S1,"^",10),I(11)=I(11)+Z,J(11)=J(11)+Z W ?113,$J($S(Z'<1:Z,1:""),6)
 I $P(S1,"^",2) W $J($P(S1,"^",2),8,1) S I(2)=I(2)+$P(S1,"^",2),J(2)=J(2)+$P(S1,"^",2)
 Q
PR S X=$P($E(TIT,D8,999),";",1)
 D:$Y>(IOSL-6) HEAD W !?3,X Q
STOT W !?5,"Subtotal",?47,$J(J(1),6) F K=1:1:6 W $S(K=3!(K=6):$S(J(K+2):$J(J(K+2),8,1),1:$J("",8)),1:$J($S(J(K+2):J(K+2),1:""),6))
 W ?97,$S(J(9):$J(J(9),6),1:$J("",6)),$S(J(10):$J(J(10),8,1),1:$J("",8))
 W ?113,$S(J(11):$J(J(11),6),1:$J("",6)),$S(J(2):$J(J(2),8,1),1:$J("",8))
 F K=1:1:11 S J(K)=0
 Q
TOT W !?3,X,?47,$J(I(1),6) F K=1:1:6 W $S(K=3!(K=6):$S(I(K+2):$J(I(K+2),8,1),1:$J("",8)),1:$J($S(I(K+2):I(K+2),1:""),6))
 W ?97,$S(I(9):$J(I(9),6),1:$J("",6)),$S(I(10):$J(I(10),8,1),1:$J("",8))
 W ?113,$S(I(11):$J(I(11),6),1:$J("",6)),$S(I(2):$J(I(2),8,1),1:$J("",8)) Q
HEAD ;W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 W !?30,"D I E T E T I C   E N C O U N T E R   S T A T I S T I C S",?120,"Page ",PG
 W @IOF S PG=PG+1 W !?30,"D I E T E T I C   E N C O U N T E R   S T A T I S T I C S",?120,"Page ",PG
 W !!?(114-$L(DTE)\2),DTE,!?47,"Number      Inpatients         Outpatients            Others           Total"
 W !?56,"Pat   Col   Units   Pat   Col   Units",?98,"Persn   Units   Persn   Units",! Q
