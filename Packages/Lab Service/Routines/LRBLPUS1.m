LRBLPUS1 ;AVAMC/REG/CYM - PATIENT UNIT SELECTION ;11/12/96  21:05 ; 11/30/00 4:21pm
 ;;5.2;LAB SERVICE;**72,139,247,267**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 ;References to ^DIC(4 in this routine are covered by DBIA 2508
 K A,LRB(1),F,Z S Z=0,X="N",%DT="T" D ^%DT S N=Y,H=$P(Y,".") W !! S X=$$READ^LRBLB("Select UNIT: ")
 Q:X=""!(X[U)  I X["?"!(X=" ") D H G LRBLPUS1
 I LR,$E(X,1,$L(LR(2)))=LR(2) D
 .D ^LRBLBU
 E  W $$STRIP^LRBLB(.X)  ; Strip off the data identifiers just in case
 Q:'$D(X)
 S DIC=65,DIC(0)="EQM",DIC("W")="W "" "",$P(^(0),U)",DIC("S")="I $P(^(0),U,16)=DUZ(2),$P(^(0),U,4)=C,$S('$D(^(4)):1,$P(^(4),U)="""":1,1:0)" D ^DIC K DIC S X=$P(Y,U,2)
 I Y<1 W $C(7),"  Enter a valid unit",!!,"You can only select units from your division [",LRAA(4),"]",!,"even though units from other divisions may be displayed." G LRBLPUS1
 S Y=+Y L +^LRD(65,Y):2 I '$T W !!,$C(7),"This unit currently unavailable.  Please try another ",!! G ^LRBLPUS1
 D ALL G LRBLPUS1
ALL S LRB(1)=1,Q=$O(^LRD(65,"AI",C,X,0)) I Q S A=X,Q=$O(^LRD(65,"AI",C,A,0)) Q:'Q  W !?3 D I G:$D(F) ^LRBLPUS2
 K ^TMP($J) W !?3 S A(2)="",Z(1)=1,A=X D D G ^LRBLPUS2:$D(F) I A(2)?1P W $C(7) Q
 I X'["E",X=+X,+$O(^LRD(65,"AI",X))=X S A=X_"?" D D
 G ^LRBLPUS2:$D(F) W $C(7) Q
 ;
H I '$D(^LRD(65,"AI",C)) W $C(7),!!,"No units to choose from !",! Q
 I X'["??" W !,"ANSWER WITH UNIT ID",!,"DO YOU WANT THE ENTIRE ",LRAA(4)," ",$P(^LRD(65,0),U)," LIST ? " S %="" D RX^LRU Q:%'=1
 S LR("M")=DUZ(2) I $P($G(^LAB(69.9,1,8.1,DUZ(2),0)),U,6) W !!,"DISPLAY AVAILABLE UNITS FROM OTHER DIVISIONS AS WELL" S %=2 D YN^LRU Q:%<1  S:%=1 LR("M")=""
 S (A,A(2))=0,A(1)=$Y+21 W !?3 F B=0:0 S A=$O(^LRD(65,"AI",C,A)) Q:A=""  F Q=0:0 S Q=$O(^LRD(65,"AI",C,A,Q)) Q:'Q  D:$Y>A(1)!'$Y MORE Q:A(2)?1P  D I
 Q
 ;
I I Q[".",Q<N K ^LRD(65,"AI",C,A,Q) Q
 I Q<H K ^LRD(65,"AI",C,A,Q) Q
 S V=$O(^LRD(65,"AI",C,A,Q,0)) I $D(^LRD(65,+V,4)),$P(^(4),"^")]"" K ^LRD(65,"AI",C,A,Q,V) Q
 I LR("M") Q:$P($G(^LRD(65,V,0)),"^",16)'=DUZ(2)
 I $D(^LRD(65,V,8)),+^(8) S Y=^(8) Q:+Y&(LRDFN'=+Y)  W $S($P(Y,"^",3)="A":"aut",$P(Y,"^",3)="D":"dir",1:"")
 S F=V_"^"_^LRD(65,V,0) I C(19),$P(F,"^",9)="POS",$D(R(LRB)) W:$D(LRB(1)) $C(7),!,$P(F,"^",2)," is Rh positive and the patient has ANTI-D antibodies." K F Q
 I C(7)+C(8) S I(7)=$P(F,"^",8),I(8)=$P(F,"^",9) D OK Q:'$D(F)
 S Z=Z+1 W:$D(Z(1)) $J(Z,2) W ?7,$P(F,"^",2),?20,$J($P(F,"^",8),2)," ",$P(F,"^",9) S Y=$P(F,"^",7) D DT^LRU W ?28,Y S Y=$P(F,"^",12) I Y,Y<LRV W "(",Y,"ml)"
 S Y=+$P(F,"^",17) I Y'=DUZ(2) W ?45,$P($G(^DIC(4,Y,0)),U)
 I C(9)=1,$D(R) S O=0 F O(1)=0:1 S O=$O(^LRD(65,V,70,O)) Q:'O  W:'O(1) !?48,"Antigen(s) ABSENT:" W !?48,$P(^LAB(61.3,O,0),"^")
 W !?3 Q
 ;
D K F F B=0:0 S A=$O(^LRD(65,"AI",C,A)) Q:$E(A,1,$L(X))'=X  F Q=0:0 S Q=$O(^LRD(65,"AI",C,A,Q)) Q:'Q!($A(A)>122)  D I I $D(F) S ^TMP($J,Z)=F K F I Z#5=0 D C Q:A(2)?1P
 D:Z#5&('$D(F)) C Q
 ;
OK I C(7)=1,I(7)'=LRPABO K F Q
 I C(8)=1,I(8)'=LRPRH K F Q
 I C(7)=1,C(8)=1 G CK
 I C(7) D @($S(C(9)'=2:LRPABO,1:LRPABO_"P")) Q:'$D(F)
 I C(8),LRPRH="NEG"&(I(8)="POS") K F Q
CK S O=0 I $D(LRK) F O=0:0 S O=$O(^LRD(65,V,2,O)) Q:'O  I $D(^LRD(65,"AP",O,V)) Q
 I O>0 K F Q
 I C(9)=1,$D(R) S O=0 F O(1)=0:1 S O=$O(^LRD(65,V,60,O)) Q:'O  I $D(R(O)) K F Q
 Q
O K:"AB"[I(7) F Q
A K:I(7)["B" F Q
B K:I(7)["A" F Q
AB Q
OP Q
AP K:I(7)="B"!(I(7)="O") F Q
BP K:I(7)="A"!(I(7)="O") F Q
ABP K:I(7)'="AB" F Q
 ;
MORE R "'^' TO STOP: ",A(2):DTIME I A(2)?1P S A=$C(126) Q
 S A(1)=A(1)+21 S:$Y<22 A(1)=$Y+21 W $C(13),$J("",15),$C(13),?3 Q
C I Z=1 S A(2)=1 G F
 W $C(13),"TYPE '^' TO STOP OR",!,"CHOOSE 1-",Z R ": ",A(2):DTIME I A(2)?1P!'$T S A=$C(126) Q
 I A(2)="" W !?3 Q
F I A(2)>0,A(2)<(Z+1) S F=^TMP($J,A(2))
 S A(2)="^",A=$C(126) Q
