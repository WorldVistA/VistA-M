LRUTAD ;AVAMC/REG - ADD/DELETE LAB TEST/PROCEDURE ; 11/12/88  09:34 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 K T W !!?20 W:LRSS'="BB" "Add or Delete " W LRAA(1)," TEST/PROCEDURE" I LRSS="BB" W $S($D(LRDEL):" DELETION",1:" ADDITION")
 W !!,"For ",LRH(0)," OK " S %=1 D YN^LRU Q:%<1  I %=2 S %DT="AEX" D ^%DT Q:Y<1  S LRAD=Y D D^LRU S LRH(0)=Y
WH I LRSS'="BB" K LRDEL R !!,"Enter  A  for Add or D  for  Delete ==> ",X:DTIME Q:X'?1"D".E&(X'?1"A".E)  S:X?1"D".E LRDEL=1
ASK R !,"Select Accession Number: ",LRAN:DTIME Q:LRAN=""!(LRAN[U)  I LRAN'?1N.N W $C(7),!!,"Enter whole numbers only",!! G ASK
 W "  for ",LRH(0),!
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) W $C(7),!!,"Accession # ",LRAN," for ",LRH(0)," not in file",!! G ASK
 S LRDFN=+^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRI=$P(^(3),U,5) G:'$D(^LR(LRDFN,0)) BAD S Y=^(0),LRPFN=$P(Y,U,2),LRFNAM=$P(^DIC(LRPFN,0),U,1),LRPF=^(0,"GL"),Y=$P(Y,U,3)
 S LRP=@(LRPF_Y_",0)") W !,$P(LRP,U,1)," ID: ",$P(LRP,U,9) S Y=$P(LRP,U,3) D D^LRU W:Y'[1700 "  DOB: ",Y S LRSIT=$S($D(^LRO(68,LRAA,1,LRAD,LRAN,5,1,0)):+^(0),1:"") S:LRSIT LRSIT=$S($D(^LAB(61,LRSIT,0)):$P(^(0),U,1),1:"")
 W !!,"ACC # ",LRAN," ",$E(LRSIT,1,20) S Y=$S($D(^LRO(68,LRAA,1,LRAD,1,LRAN,3)):+^(3),1:"") D:Y D^LRU W "  DATE RECEIVED: ",Y," OK " S %=1 D YN^LRU G:%'=1 ASK
 I "AUCYEMSP"'[LRSS S LRSIT=$S($D(^LRO(68,LRAA,1,LRAD,1,LRAN,5,1,0)):+^(0),1:"") I LRPF'="^LRX(",'LRSIT W $C(7),!!,"NO SITE/SPECIMEN",!,"DELETE ACCESSION # AND REENTER",!! Q
Z I $D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,0)),$P(^(0),U,4)>0 W !?30,"Test/Procedure(s) ordered: ",?60,"STAT test= *" S N=0 F X=1:1 S N=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,N)) Q:'N  S T=^(N,0),T(X)=+T,T=$S($P(T,U,2)=1:"*",1:"") D L
ADD S X=X-1 I '$D(LRDEL) D EN1^LRUWLF G WH
LRDEL I $D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,0)),$P(^(0),U,4)<1 W $C(7),!!,"There are NO tests to delete !!!" G WH
 W !!,"Delete by selecting a number from 1",$S(X=1:"",1:"-"_X) R ": ",A("A"):DTIME G:A("A")<1!(A("A")>X) WH
 I $L($P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,T(A("A")),0),U,4)) W $C(7),!!,"Results entered for this test !! Cannot delete it !" G WH
 W !,"Delete ",$P(^LAB(60,T(A("A")),0),U,1) R "  OK ?  YES// ",N1:DTIME G:N1'?1"Y".E&(N1'="") LRDEL
 K ^LRO(68,LRAA,1,LRAD,1,LRAN,4,T(A("A")),0) S ^LRO(68,LRAA,1,LRAD,1,LRAN,4,0)="^68.04PA^^"_($P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,0),U,4)-1) K T(A("A")) G WH
L Q:'$D(^LAB(60,T(X),0))  W !,$J(X,38),")",T,?41,$E($P(^(0),U,1),1,38) Q
BAD W $C(7),!!,"Entry not in file",!! G ASK
