DGPTX16 ; ;07/14/09
 S X=DG(DQ),DIC=DIE
 X ^DD(2,.32103,1,1,1.3) I X S X=DIV S Y(2)=";"_$S($D(^DD(2,.3212,0)):$P(^(0),U,3),1:""),Y(1)=$S($D(^DPT(D0,.321)):^(.321),1:"") S X=$P($P(Y(2),";"_$P(Y(1),U,12)_":",2),";",1) S DIU=X K Y S X=DIV S X="" X ^DD(2,.32103,1,1,1.4)
 S X=DG(DQ),DIC=DIE
 X ^DD(2,.32103,1,2,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.321)):^(.321),1:"") S X=$P(Y(1),U,11) S DIU=X K Y S X=DIV S X="" X ^DD(2,.32103,1,2,1.4)
 S X=DG(DQ),DIC=DIE
 D AUTOUPD^DGENA2(DA)
