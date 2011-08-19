XUGET ; SF/XAK - PACKAGE INTEGRITY CHECKER ;12/14/92  11:47 ;
 ;;8.0;KERNEL;;Jul 10, 1995
1 W ! S DIR("A",1)="This answer is case sensitive.",DIR("A")="Select PACKAGE PREFIX",DIR(0)="FO^2:4"
 S DIR("?")="Prefix must be 2 to 4 characters in length.",DIR("??")="^D H^XUGET"
 D ^DIR G END:$D(DIRUT) S X=X_"NTEG"
 X ^%ZOSF("TEST") I '$T W !!?5,"Integrity program does not exist." G 1
 W ! S XD="^"_X S %ZIS="Q" D ^%ZIS G END:POP
 I $D(IO("Q")) K IO("Q") S ZTRTN="GO^XUGET",ZTSAVE("XD")="",ZTDESC="ROUTINE INTEGRITY CHECKER",ZTIO=ION D ^%ZTLOAD G 1
GO W !,"Running "_XD_"..." D @XD G END:$D(ZTSK)
 G 1
H ;
 S DZ="?",DIC="^DIC(9.4,",DIC(0)="QE",D="C",DIC("S")="N X S X=$P(^(0),U,2)_""NTEG"" X ^%ZOSF(""TEST"")"
 S DIC("W")="W ?15,$P(^(0),U)" D DQ^DICQ
 K %,%Y,DD,DIX,DIY,DO,DISYS,D,DIC,DZ
 Q
END K %I,ZTSK,XD,IO("Q"),POP,LN,I,L,X,DIR,DIRUT S U="^" Q
