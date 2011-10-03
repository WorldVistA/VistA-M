DGODMT ;ALB/MRL - DETERMINE & STORE PTF MEANS TEST INDICATOR ; 10 FEB 87
 ;;5.3;Registration;;Aug 13, 1993
 ;;V 4.5 ;; ALB/EG - MODIFIED TO DETERMINE MT, NO UPDATE ; 11 APR 89
EN ;
 S DGZEC=$S($D(^DPT(DFN,.36)):$P(^(.36),U,1),1:""),DGZEC=$S($D(^DIC(8,+DGZEC,0)):^(0),1:"") I $P(DGZEC,U,5)="N" S DGX="N" Q
 I $D(AD),AD<2860701 S DGX="X" Q
 I $D(^DGPT(PTF,101)) S DGT=+^(101) I DGT=48!(DGT=49)!(DGT=50) S DGX="X" Q
 I $P(^DG(43,1,0),U,21),AD]"" S DGT=AD D ^DGINPW I DG1,$S('$D(^DIC(42,+DG1,0)):0,$P(^(0),U,3)="D":1,1:0) S DGX="X" Q
 S DGT=$S($D(^DGPT(PTF,70)):$P(^(70),U,1),1:""),DGT=9999999-$S(DGT]"":DGT,1:DT_.9) G AS:'$D(^DG(41.3,DFN,0)) F DGZ=0:0 S DGZ=$O(^DG(41.3,DFN,2,DGZ)) Q:'DGZ!($D(DGZ1))  I DGZ>DGT S DGZ1=^(DGZ,0)
 S DGX=$S('$D(DGZ1):"U",1:$P(DGZ1,U,2)),DGX=$S(DGX="A":"AN","BN"[DGX:DGX,"CP"[DGX:"C",1:"U") I DGX'="N" Q
AS S DGZ=$S($D(^DPT(DFN,.321)):^(.321),1:0) I $P(DGZ,U,2)="Y"!($P(DGZ,U,3)="Y") S DGX="AS" Q
 I $P(DGZEC,U,5)="Y",$P(DGZEC,U,4)<4,"^2^15^"'[("^"_$P(DGZEC,U,9)_"^") S DGX="AS" Q
 I DGZEC]"" S DGX="AN" Q
 S DGX="U" K DGZEC,DGZ,DGZ1,DG1,DR,DGT
 Q
TOTW ;get inpatients remaining in hospital
 S (DG0X,X)=0 F I=0:0 S X=$O(^DPT("CN",X)) Q:X=""  I $O(^DIC(42,"B",X,0))'="",$P(^DIC(42,$O(^DIC(42,"B",X,0)),0),U,11)'="" D TOTW0
 S X="" F I=A2:1 S X=$O(Z(X)) Q:X=""  S DGDVN=$S($D(^DG(40.8,"C",X))>0:^DG(40.8,$O(^DG(40.8,"C",X,0)),0),1:"^"),DGDV=$P(DGDVN,U,1),DGDVN=$P(DGDVN,U,2),^UTILITY("DGOD",$J,"AI",I+1)=DGDV_U_DGDVN_U_Z(X),^(0)=A2
 Q
TOTW0 I $D(Z($P(^DG(40.8,$P(^DIC(42,$O(^DIC(42,"B",X,0)),0),U,11),0),U,2)))=0 S Z($P(^DG(40.8,$P(^DIC(42,$O(^DIC(42,"B",X,0)),0),U,11),0),U,2))=0,DG0X=DG0X+1
 S:$D(A(DG0X+A2))=0 A(DG0X+A2)=^DG(40.8,$P(^DIC(42,$O(^DIC(42,"B",X,0)),0),U,11),0) D TOTW1
 Q
TOTW1 S Y=0,DGDV=$P(^DG(40.8,$P(^DIC(42,$O(^DIC(42,"B",X,0)),0),U,11),0),U,2)
 F I=0:0 S Y=$O(^DPT("CN",X,Y)) Q:Y=""  S Z($P(^DG(40.8,$P(^DIC(42,$O(^DIC(42,"B",X,0)),0),U,11),0),U,2))=Z($P(^DG(40.8,$P(^DIC(42,$O(^DIC(42,"B",X,0)),0),U,11),0),U,2))+1
 Q
