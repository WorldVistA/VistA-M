LRBLDA1 ;AVAMC/REG - BLOOD DONOR LABELS ; 10/23/88  15:45 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 U IO S LRP=LRP(1) F LRA=0:1 S LRP=$O(^LRE("B",LRP)) G:LRP=""!(LRP]LRP(2)) END F LRI=0:0 S LRI=$O(^LRE("B",LRP,LRI)) Q:'LRI  S LRW=$O(^LRE(LRI,5,0)) I LRW>LRSDT S LRW=^(LRW,0) D W
END D END^LRUTL,V^LRU Q
 ;
W S X=^LRE(LRI,0) Q:$P(X,"^",10)  Q:LRABO]""&($P(X,"^",5)'=LRABO)  Q:LRRH]""&($P(X,"^",6)'=LRRH)
 S LRW(7)=$P(LRW,"^",7) I LR,LRW(7)'=LR,'$D(^LRE(LRI,2,LR)) Q
 S C=1 W $P(LRP,",",2)_" "_$P(LRP,",")
 I $D(^LRE(LRI,1)) S X=^(1) D A
 F B=C:1:LR(1) W !
 Q
A F B=1:1:3 I $P(X,"^",B)]"" S C=C+1 W !,$P(X,"^",B)
 S C=C+1 W !,$P(X,"^",4) W:$P(X,"^",5) ", ",$P(^DIC(5,$P(X,"^",5),0),"^",2) W " ",$P(X,"^",6) Q
EN ;
AB R !,"ABO GROUP: ",X:DTIME I '$T!(X[U) K Y Q
 I X'=""&(X'="A")&(X'="B")&(X'="O")&(X'="AB") W $C(7),!!,"Enter A, O, B or AB" G AB
 S LRABO=X
R R !,"Rh TYPE: ",X:DTIME I '$T!(X[U) K Y Q
 I X'=""&(X'="P")&(X'="N") W $C(7),!!,"Enter P for POS or N for NEG" G R
 S LRRH=$S(X="N":"NEG",X="P":"POS",1:"") Q
EN1 ;RBC ANTIGENS ABSENT
 W !
B S DIC="^LAB(61.3,",DIC(0)="AEQM",DIC("S")="I $P(^(0),U,5)=""AN""",DIC("A")="Select RBC ANTIGEN ABSENT: " D ^DIC K DIC I Y>0 S LRJ(+Y)=$P(Y,U,2) G B
 S (B,X)="" F A=0:0 S A=$O(LRJ(A)) Q:'A  S B=B_LRJ(A)_", ",X=X+1
 S B=$E(B,1,$L(B)-2) I X>1 S B=$P(B,", ",1,X-1)_" and "_$P(B,", ",X)
 S LRF=B Q
