LRBLJL1 ;AVAMC/REG/CYM - UNIT RELOCATION ; 12/18/00 1:49pm
 ;;5.2;LAB SERVICE;**72,79,90,247,267**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 ;
 ; Reference to ^SC( supported by DBIA908
 ;
 S X="N",%DT="T" D ^%DT S H=Y,(A,LR("Q"),C)=0
 F C(1)=0:0 S C=$O(^LRD(65,"AP",LRDFN,C)) Q:'C  D L
 S (A,F)=0 F B=0:0 S A=$O(^TMP($J,"B",A)) Q:A=""  D
 . F C=0:0 S C=$O(^TMP($J,"B",A,C)) Q:'C  D
 .. F E=0:0 S E=$O(^TMP($J,"B",A,C,E)) Q:'E  D
 ... S F=F+1,^TMP($J,"C",A,F)=^TMP($J,"B",A,C,E)
 K ^TMP($J,"B")
 S (B,F)=0 F A=1:1 S B=$O(^TMP($J,"C",B)) Q:B=""!(LR("Q"))  D
 . W:A>1 ! F C=0:0 S C=$O(^TMP($J,"C",B,C)) Q:'C!(LR("Q"))  S LRX=^(C) D S
 K ^TMP($J,"C") Q
 ;
L I $D(^LRD(65,C,4)),$P(^(4),"^")]"" K ^LRD(65,"AP",LRDFN,C) Q
 S X=^LRD(65,C,0) Q:DUZ(2)'=$P(X,U,16)
 S (T,Y)=$P(X,U,6),L=+$O(^(3,0)),LRG=$G(^(L,0)),L=$S($P(LRG,U,4)]"":$P(LRG,U,4),1:"Blood Bank"),LRG=$P(LRG,U,2)
 ; The following 2 lines searches ALL previous relocation
 ; episodes to see if there have been any previous inspections
 ; of Unsatisfactory.
 N LRDT F LRDT=0:0 S LRDT=$O(^LRD(65,C,3,LRDT)) Q:LRDT'>0  D
 . I $D(^LRD(65,C,3,LRDT,0)) S:$P(^(0),U,2)="U" LRG(C)="U"
 S:T'["." T=T+.99
 S M=^LAB(66,$P(X,U,4),0),Z=$P(M,U,26),Z=$S($P(M,U,19):1,'Z:"?",1:Z)
 S LR(65.01)=$P($G(^LRD(65,C,2,LRDFN,0)),"^",2)
 S A=A+1,^TMP($J,"B",Z,Y,A)=C_"^"_$P(X,"^")_"^"_$E($P(M,"^"),1,19)_"^"_$P(X,"^",7)_" "_$P(X,"^",8)_"^"_Y_"^"_L_"^"_$S(T<H:"*",1:"")_"^"_$P(M,"^",9)_"^"_$P(M,"^",19)_"^"_$P(M,"^",25)_"^"_LRG_"^"_LR(65.01)
 D:$P(M,U,14) N Q
 ;
S S F=F+1,^TMP($J,F)=^TMP($J,"C",B,C)
 W:F=1 !,"Unit assigned/xmatched:",?48,"Exp date",?67,"Location" D:F#21=0 M^LRU W !,$J(F,2),")"
W W:$P(LRX,U,11)="U" ?5,"#" W ?6,$P(LRX,U,2),?20,$P(LRX,U,3),?41,$P(LRX,U,4) S Y=$P(LRX,U,5),L=$P(LRX,U,6) S:L="" L="Blood Bank" D A^LRU W ?48,Y,$P(LRX,U,7),?67,$E(L,1,13) S:$P(LRX,U,7)]"" V=1 S:$P(LRX,U,11)="U" LRG(1)=1
 S I=+LRX
 F E=0:0 S E=$O(^LRD(65,I,2,E)) Q:'E  D
 . I LRDFN'=E,$D(^LRD(65,"AP",E,I)) S X=^LR(E,0),Y=$P(X,"^",3),X=$P(X,"^",2),X=^DIC(X,0,"GL"),N=@(X_Y_",0)") W !?6,$C(7),"*** Also assigned/xmatched to ",$P(N,"^")," ",$P(N,"^",9)
 Q
 ;
N S Z(1)=Y,LRX=^TMP($J,"B",Z,Y,A)
 W ! D W
 K ^TMP($J,"B",Z,Z(1),A)
 W $C(7),!?6,"This unit needs to be modified before release !" Q
 ;
A S (A,B,C)=0
 F  S A=$O(^SC("B",A)) Q:A=""  I A["BLOOD BANK" F  S B=$O(^(A,B)) Q:'B  I DUZ(2)=+$$SITE^VASITE(DT,($P($G(^SC(B,0)),U,15))) S C=C+1,C(C)=A
 I 'C W $C(7),!!,"There must be an entry in the HOSPITAL LOCATION file",!,"containing 'BLOOD BANK' in the name for ",LRAA(4) S Y=-1 Q
 S LR(44)=C(1)
 I C>1 S Y=-1 W $C(7),!!,"There can only be one entry in the HOSPITAL LOCATION file",!,"containing 'BLOOD BANK' in the name for ",LRAA(4) F A=0:0 S A=$O(C(A)) Q:'A  W !?3,C(A)
 K A,B,C Q
