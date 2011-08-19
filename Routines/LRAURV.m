LRAURV ;AVAMC/REG - AUTOPSY DATA REVIEW ;2/18/93  12:24 ;
 ;;5.2;LAB SERVICE;**155**;Sep 27, 1994
 S LRDICS="AU" D ^LRAP G:'$D(Y) END
 W !!?20,"Autopsy data review"
 D B^LRU G:Y<0 END S LRLDT=LRLDT+.99,LRSDT=LRSDT-.0001
 S LRB=0 W !!,"Count only in-patient deaths " S %=1 D YN^LRU G:%<1 END I %=1 S LRB=1
 S ZTRTN="QUE^LRAURV" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE K ^TMP($J) U IO S (LR("Q"),LRA,LRD,G(0),G(1),C(0),C(1),C(2))="" D XR^LRU,L^LRU,S^LRU,H S LR("F")=1
 S A=0 F B=0:0 S A=$O(^DG(405.2,"B",A)) Q:A=""  I A["DEATH"!(A="WHILE ASIH") S X=$O(^(A,0)) I X S:A["DEATH" LRC(X)="" S:A["ASIH" LRJ(X)="" ;MAS
 F A=LRSDT:0 S A=$O(^LR(LRXR,A)) Q:'A!(A>LRLDT)!(LR("Q"))  F LRDFN=0:0 S LRDFN=$O(^LR(LRXR,A,LRDFN)) Q:'LRDFN!(LR("Q"))  S LRX=$G(^LR(LRDFN,"AU")),LRAC=$P(LRX,U,6) I $P(LRAC," ")=LRABV D A Q:LR("Q")  I $D(^LR(LRDFN,83)) S X=^(83) D W
 Q:LR("Q")  I IOST?1"C".E W !!,"Please hold, calculating Autopsy% ...",!
 F A=LRSDT:0 S A=$O(^DPT("AEXP1",A)) Q:'A!(A>LRLDT)  F DFN=0:0 S DFN=$O(^DPT("AEXP1",A,DFN)) Q:'DFN  S:'LRB LRD=LRD+1 D:LRB P I $D(LRK) S LRD=LRD+1 K LRK
 S LRF=1 D H Q:LR("Q")  W !,$J(LRD,7),?10,$J(LRA,8),?25,$J(LRA/$S('LRD:1,1:LRD)*100,5,1),?34,$J(G(1),6),?45,$J(G(0),6),?55,$J(C(1),5),?63,$J(C(0),4),?70,$J(C(2),4)
 D END^LRUTL,END Q
W I LRB,'LRG Q
 S Y=$P(X,"^",2),X=$P(X,"^") S:X]"" G(X)=G(X)+1 S:Y]"" C(Y)=C(Y)+1 W:X ?36,"X" W:X=0 ?46,"X" W:Y=1 ?57,"X" W:Y=0 ?64,"X" W:Y=2 ?74,"X" Q
A D:$Y>(IOSL-6) H Q:LR("Q")  S LRG=0,Y=+LRX D D^LRU S LRY=Y I 'LRB D B S LRA=LRA+1 Q
 S X=^LR(LRDFN,0),DFN=$P(X,"^",3) Q:$P(X,"^",2)'=2  D P I $D(LRK) D B S LRA=LRA+1,LRG=1 K LRK
 Q
P S Y=0,X=$O(^DGPM("ATID3",DFN,0)) Q:'X  S Y=$O(^(X,0)) Q:'Y  S Z=$S($D(^DGPM(Y,0)):$P(^(0),"^",18),1:0) Q:'Z  I $D(LRC(Z)) S LRK=1 Q
 Q:'$D(LRJ(Z))  S X=$O(^DGPM("ATID3",DFN,X)) Q:'X  S Y=$O(^DGPM("ATID3",DFN,X,Y)) Q:'Y  S Z=+$S($D(^DGPM(Y,0)):$P(^(0),"^",18),1:0) S:$D(LRC(Z)) LRK=1 Q
 ;
B W !,LRAC,?15,LRY Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,LRO(68)," (",LRABV,") DATA REVIEW (",LRSTR,"-",LRLST,")"
 W !?34,"|DIAGNOSTIC",?54,"| CLINICAL DIAGNOSIS",! W "|----------",$S(LRB:"In-patient",1:"--Total---"),"-------------" W ?34,"|DISAGREEMENT",?54,"| CLARIFIED"
 I $D(LRF) W !,"# Deaths",?10,"# Autopsies",?25,"Autopsy%",?34,"|#Yes",?45,"#No",?54,"| #Yes",?63,"#No"
 E  W !,"Autopsy",?10,"Autopsy date",?34,"| Yes",?46,"No",?54,"|  Yes",?64,"No"
 W ?70,"Verified",!,LR("%") Q
 ;
END D V^LRU Q
