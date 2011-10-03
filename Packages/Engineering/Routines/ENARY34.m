ENARX44 ;(WIRMFO)/SAW/DH/SAB-Work Order Archive ;2.14.97
 ;;7.0;ENGINEERING;**40**;Aug 17, 1993
 ;
 ;
 K ^UTILITY("DIFROM",$J) S DIC(0)="LX",(DIC,DLAYGO)=3.6,N="BULL" D ADD:$D(^XMB(3.6,0)) S X=0 F R=0:0 S X=$O(^UTILITY("DIFROM",$J,X)) Q:X=""  W !,"'",X,"' BULLETIN FILED -- REMEMBER TO ADD ITS USER GROUPS"
 I $D(^DIC(9.4,0))#2,^(0)?1"PACKAGE".E S N="PK",(DIC,DLAYGO)=9.4 D ADD S:$D(^DIC(9.4,DA,22,DIFROM,0)) ^(0)=$P(^(0)_U,U,1,2)_U_DT I $D(^DIC(9.4,DA,0))#2 S X=^(0),%=$P(X,U,4) I %]"" S %=$O(^DIC(9.2,"B",%,0)) S:%]"" ^DIC(9.4,DA,0)=$P(X,U,1,3)_U_%
 K ^UTILITY("DIFROM",$J) I $D(^DIC(19,0))#2,^(0)?1"OPTION".E S (DIC,DLAYGO)=19,N="OPT" D ADD,OP
 I $D(^DIC(19.1,0))#2,^(0)?1"SECUR".E S (DIC,DLAYGO)=19.1,N="SE" D ADD K ^UTILITY("DIFROM",$J)
 S DIC=.5,DLAYGO=0,N="FUNC" D ADD
 I $D(^DIC(9.8,0))#2,^(0)?1"ROUTINE^".E S (DIC,DLAYGO)=9.8,N="ROU" D ADD
 S DIC("S")="I $P(^(0),U,4)=I" F N="DIPT","DIBT","DIE" S DIC=U_N_"(" D ADD
 K ^UTILITY(U,$J),DIC,DLAYGO F DIR="DIE","DIPT" D DIEZ
 Q
DIEZ S N=$O(^UTILITY("DIFROM",$J,DIR,0)) Q:N=""  S Y=+^(N) K ^(N) I $D(@("^"_DIR_"(Y,""ROU"")")) K ^("ROU") I $D(^("ROUOLD")) S X=^("ROUOLD"),DMAX=^DD("ROU") I $D(^("OS",^DD("OS"),"ZS")),X]"" D @("EN^DI"_$E(DIR,3)_"Z")
 G DIEZ
 ;
 ;
OP S R=$O(^UTILITY("DIFROM",$J,N,R)) I R="" K ^UTILITY("DIFROM",$J) S X="O" F R=0:0 S X=$O(^DIC(19,X)) G Q:X'?1"O".E K ^(X)
 W !,"'"_R_"' Menu Option Filed" S DA=+^UTILITY("DIFROM",$J,N,R) G:$P(^(R),U,2,3)="XUCORE^" OP
 S (DZ,DIX)=0,%=$P(^DIC(19,DA,0),U,7) S:%]"" %=$O(^DIC(9.2,"B",%,0)) S ^(0)=$P(^DIC(19,DA,0),U,1,6)_U_$S(%>0:%,1:"")_U_$P(^(0),U,8,99),%=$P(^(0),U,4)="M" K ^(10,"B"),^("C")
 F X=0:0 S X=$O(^DIC(19,DA,10,X)) Q:X'>0  S I=$S($D(^(X,0)):^(0),1:0),Y=$S($D(^(U)):^(U),1:"") K ^DIC(19,DA,10,X) I Y]"",% S D=$O(^DIC(19,"B",Y,0)) I D>0 S ^DIC(19,DA,10,X,0)=D_U_$P(I,U,2,9),DZ=DZ+1,DIX=X
 S:% ^DIC(19,DA,10,0)="^19.01PI^"_DZ_U_DIX D IX1^DIK G OP
 ;
ADD F R=0:0 S R=$O(^UTILITY(U,$J,N,R)) Q:R=""  S X=$P(^(R,0),U,1),I=$P(^(0),U,4) W "." D ^DIC I Y>0,'$D(DIFQ(N))!$P(Y,U,3) S Y=Y_U D A
Q Q
A K:N'="SE"&(N'="OPT") @(DIC_"+Y)") S ^UTILITY("DIFROM",$J,N,X)=Y S:N="PK" DIFROM(0)=+Y Q:$P(Y,U,2,3)="XUCORE^"
 I N="OPT",$O(^UTILITY(U,$J,N,R,1,0))>0 K @(DIC_"+Y,1)")
 S %X="^UTILITY(U,$J,N,R,",%Y=DIC_"+Y,",DA=+Y,DIK=DIC D %XY^%RCR,IX1^DIK:N'="OPT"
