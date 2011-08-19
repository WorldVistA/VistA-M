ENARX33 ;(WIRMFO)/SAW/DH/SAB-Work Order Archive ;2.14.97
 ;;7.0;ENGINEERING;**40**;Aug 17, 1993
 ;
 ;
 K ^UTILITY("DIFROM",$J),DIC
 I $D(^DIC(9.2,0))#2,^(0)?1"HELP".E S (DIC,DLAYGO)=9.2,N="HELP",DIC(0)="LX" G ADD
 Q
 ;
ADD F R=0:0 S R=$O(^UTILITY(U,$J,N,R)) Q:R=""  S X=$P(^(R,0),U,1) W "." D ^DIC I Y>0,'$D(DIFQ(N))!$P(Y,U,3) S ^UTILITY("DIFROM",$J,N,X)=+Y K ^DIC(9.2,+Y,1),^(2),^(3) S %X="^UTILITY(U,$J,N,R,",%Y=DIC_"+Y,",DA=+Y D %XY^%RCR
 S DIK=DIC
HELP S R=$O(^UTILITY("DIFROM",$J,N,R)) Q:R=""  W !,"'"_R_"' Help Frame filed." S DA=^(R) G IX:$O(^DIC(9.2,DA,2,0))'>0
 F X=0:0 S X=$O(^DIC(9.2,DA,2,X)) Q:X'>0  S I=$S($D(^(X,0)):^(0),1:0),Y=$P(I,U,2) S:Y]"" Y=$O(^DIC(9.2,"B",Y,0)) S ^(0)=$P(^DIC(9.2,DA,2,X,0),U,1)_U_$S(Y>0:Y,1:"")_U_$P(^(0),U,3,99)
IX D IX1^DIK G HELP
