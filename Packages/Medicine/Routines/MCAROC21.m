MCAROC21 ; GENERATED FROM 'MCARCATH2' PRINT TEMPLATE (#973) ; 10/04/96 ; (continued)
 G BEGIN
N W !
T W:$X ! I '$D(DIOT(2)),DN,$D(IOSL),$S('$D(DIWF):1,$P(DIWF,"B",2):$P(DIWF,"B",2),1:1)+$Y'<IOSL,$D(^UTILITY($J,1))#2,^(1)?1U1P1E.E X ^(1)
 S DISTP=DISTP+1,DILCT=DILCT+1 D:'(DISTP#100) CSTP^DIO2
 Q
DT I $G(DUZ("LANG"))>1,Y W $$OUT^DIALOGU(Y,"DD") Q
 I Y W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" " W:Y#100 $J(Y#100\1,2)_"," W Y\10000+1700 W:Y#1 "  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12) Q
 W Y Q
M D @DIXX
 Q
BEGIN ;
 S:'$D(DN) DN=1 S DISTP=$G(DISTP),DILCT=$G(DILCT)
 D N:$X>31 Q:'DN  W ?31 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,0)):^(0),1:"") S X="V: "_$P(DIP(1),U,14) K DIP K:DN Y W X
 D N:$X>54 Q:'DN  W ?54 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,1)):^(1),1:"") S X="D: "_$P(DIP(1),U,2) K DIP K:DN Y W X
 D N:$X>10 Q:'DN  W ?10 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,0)):^(0),1:"") S X="M: "_$P(DIP(1),U,4) K DIP K:DN Y W X
 D N:$X>31 Q:'DN  W ?31 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,0)):^(0),1:"") S X="M: "_$P(DIP(1),U,15) K DIP K:DN Y W X
 D N:$X>54 Q:'DN  W ?54 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,1)):^(1),1:"") S X="M: "_$P(DIP(1),U,3) K DIP K:DN Y W X
 D N:$X>7 Q:'DN  W ?7 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,0)):^(0),1:"") S X="RV S: "_$P(DIP(1),U,6) K DIP K:DN Y W X
 D N:$X>28 Q:'DN  W ?28 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,0)):^(0),1:"") S X="LA A: "_$P(DIP(1),U,16) K DIP K:DN Y W X
 D N:$X>51 Q:'DN  W ?51 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,0)):^(0),1:"") S X="LV S: "_$P(DIP(1),U,22) K DIP K:DN Y W X
 D N:$X>10 Q:'DN  W ?10 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,0)):^(0),1:"") S X="D: "_$P(DIP(1),U,7) K DIP K:DN Y W X
 D N:$X>31 Q:'DN  W ?31 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,0)):^(0),1:"") S X="V: "_$P(DIP(1),U,17) K DIP K:DN Y W X
 D N:$X>50 Q:'DN  W ?50 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,0)):^(0),1:"") S X="PRE A: "_$P(DIP(1),U,20) K DIP K:DN Y W X
 D N:$X>31 Q:'DN  W ?31 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,0)):^(0),1:"") S X="M: "_$P(DIP(1),U,18) K DIP K:DN Y W X
 D N:$X>54 Q:'DN  W ?54 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,0)):^(0),1:"") S X="Z: "_$P(DIP(1),U,21) K DIP K:DN Y W X
 D N:$X>7 Q:'DN  W ?7 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,0)):^(0),1:"") S X="PA S: "_$P(DIP(1),U,9) K DIP K:DN Y W X
 D N:$X>51 Q:'DN  W ?51 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,0)):^(0),1:"") S X="LV S: "_$P(DIP(1),U,24) K DIP K:DN Y W X
 W ?62 W "(POST DYE)"
 D N:$X>10 Q:'DN  W ?10 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,0)):^(0),1:"") S X="D: "_$P(DIP(1),U,10) K DIP K:DN Y W X
 D N:$X>50 Q:'DN  W ?50 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,0)):^(0),1:"") S X="PRE A: "_$P(DIP(1),U,25) K DIP K:DN Y W X
 D N:$X>10 Q:'DN  W ?10 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,0)):^(0),1:"") S X="M: "_$P(DIP(1),U,11) K DIP K:DN Y W X
 D N:$X>54 Q:'DN  W ?54 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,0)):^(0),1:"") S X="Z: "_$P(DIP(1),U,26) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>6 Q:'DN  W ?6 W "SATURATIONS: "
 D N:$X>9 Q:'DN  W ?9 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,0)):^(0),1:"") S X="RA: "_$P(DIP(1),U,5) K DIP K:DN Y W X
 D N:$X>30 Q:'DN  W ?30 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,0)):^(0),1:"") S X="PA: "_$P(DIP(1),U,12) K DIP K:DN Y W X
 D N:$X>46 Q:'DN  W ?46 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,0)):^(0),1:"") S X="LV: "_$P(DIP(1),U,23) K DIP K:DN Y W X
 D N:$X>63 Q:'DN  W ?63 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,1)):^(1),1:"") S X="IVC: "_$P(DIP(1),U,8) K DIP K:DN Y W X
 D N:$X>9 Q:'DN  W ?9 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,0)):^(0),1:"") S X="RV: "_$P(DIP(1),U,8) K DIP K:DN Y W X
 D N:$X>30 Q:'DN  W ?30 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,0)):^(0),1:"") S X="LA: "_$P(DIP(1),U,19) K DIP K:DN Y W X
 D N:$X>46 Q:'DN  W ?46 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,1)):^(1),1:"") S X="AO: "_$P(DIP(1),U,4) K DIP K:DN Y W X
 D N:$X>63 Q:'DN  W ?63 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,1)):^(1),1:"") S X="SVC: "_$P(DIP(1),U,6) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>6 Q:'DN  W ?6 W "OUTPUT AND INDEX"
 D N:$X>29 Q:'DN  W ?29 W "(L/MIN)"
 D N:$X>54 Q:'DN  W ?54 W "(L/MIN/M2)"
 D N:$X>9 Q:'DN  W ?9 W "ASSUMED FICK"
 S X=$G(^MCAR(691.1,D0,19,D1,1)) D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,9) W:Y]"" $J(Y,6,2)
 D N:$X>55 Q:'DN  W ?55
 G ^MCAROC22
