DGREGDEL ;ALB/XAK - DELETE A REGISTRATION ;01 JAN 86
 ;;5.3;Registration;**107**;Aug 13, 1993
FIND W !! S DIC="^DPT(",DIC(0)="AEQMZ",DIC("S")="S I=$O(^DPT(Y,""DIS"",0)),I=$S(I>0:^(I,0),1:"""") I I]"""",'$P(I,U,6)" D ^DIC K DIC("S"),DIC("A") G Q:Y'>0 S (DA,DFN)=+Y
 S I=$O(^DPT(DFN,"DIS",0)) I I']"" W !!,"No registrations on file." G FIND
 S X=^DPT(DFN,"DIS",I,0) I $P(X,"^",6),$P(X,"^",7) W !!,"All registrations are dispositioned." G FIND
 S:'$D(^DPT(DA,"DIS",0)) ^(0)="^2.101D^"_I_"^"
 W ! N IOM S DIC="^DPT("_DFN_",""DIS"",",DA=I,DR=0,IOM=40 D EN^DIQ
W W !,"Are you sure you want to delete this registration" S %=2 D YN^DICN I %,%'=1 G FIND
 I '% W !!?4,*7,"YES - If you want to permanently remove this registration.",!?4,"NO  - If you wish to retain this registration data on file.",! G W
 S DIK=DIC,DA(1)=DFN D ^DIK W !,"Deleted.",! G FIND
Q K DIC,DIK,DA,DFN,DGIOM Q
