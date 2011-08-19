MCAROPS ; GENERATED FROM 'MCAROPS' PRINT TEMPLATE (#991) ; 10/04/96 ; (FILE 698.3, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(991,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D N:$X>31 Q:'DN  W ?31 X DXS(1,9) K DIP K:DN Y W X
 D T Q:'DN  D N D N D N:$X>2 Q:'DN  W ?2 X DXS(2,9) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 S DIP(1)=$S($D(^MCAR(698.3,D0,0)):^(0),1:"") S X="CALLER: "_$S('$D(^VA(200,+$P(DIP(1),U,3),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "ATTENDING PHYSICIAN: "
 S X=$G(^MCAR(698.3,D0,3)) S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D N:$X>2 Q:'DN  W ?2 W "FELLOW: "
 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D N:$X>2 Q:'DN  W ?2 S DIP(1)=$S($D(^MCAR(698.3,D0,0)):^(0),1:"") S X="BASIC RHYTHM: "_$S('$D(^MCAR(698.9,+$P(DIP(1),U,9),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 S DIP(1)=$S($D(^MCAR(698.3,D0,0)):^(0),1:"") S X="PERCENT OF PACED BEATS: "_$P(DIP(1),U,10) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>40 Q:'DN  W ?40 X DXS(3,9) K DIP K:DN Y W X
 D N:$X>61 Q:'DN  W ?61 X DXS(4,9) K DIP K:DN Y W X
 D N:$X>5 Q:'DN  W ?5 W "PULSE INTERVAL (mSec)"
 S X=$G(^MCAR(698.3,D0,0)) D N:$X>42 Q:'DN  W ?42 S Y=$P(X,U,7) W:Y]"" $J(Y,5,0)
 D N:$X>62 Q:'DN  W ?62 S Y=$P(X,U,8) W:Y]"" $J(Y,5,0)
 D N:$X>5 Q:'DN  W ?5 W "RATE (BPM)"
 D N:$X>40 Q:'DN  W ?40 X ^DD(698.3,5,9.2) S X=$S(Y(698.3,5,2):Y(698.3,5,3),Y(698.3,5,4):X) S X=$J(X,0,1) W:X'?."*" $J(X,9,1) K Y(698.3,5)
 D N:$X>60 Q:'DN  W ?60 X ^DD(698.3,7,9.2) S X=$S(Y(698.3,7,2):Y(698.3,7,3),Y(698.3,7,4):X) S X=$J(X,0,1) W:X'?."*" $J(X,9,1) K Y(698.3,7)
 D N:$X>5 Q:'DN  W ?5 W "A-V DELAY (mSec)"
 S X=$G(^MCAR(698.3,D0,0)) D N:$X>42 Q:'DN  W ?42 S Y=$P(X,U,11) W:Y]"" $J(Y,5,0)
 D N:$X>62 Q:'DN  W ?62 S Y=$P(X,U,12) W:Y]"" $J(Y,5,0)
 D T Q:'DN  D N D N D N:$X>42 Q:'DN  W ?42 X DXS(5,9) K DIP K:DN Y W X
 D N:$X>61 Q:'DN  W ?61 X DXS(6,9) K DIP K:DN Y W X
 D N:$X>5 Q:'DN  W ?5 W "PULSE WIDTH (mSec)"
 S X=$G(^MCAR(698.3,D0,1)) D N:$X>43 Q:'DN  W ?43 S Y=$P(X,U,1) W:Y]"" $J(Y,5,2)
 S X=$G(^MCAR(698.3,D0,2)) D N:$X>64 Q:'DN  W ?64 S Y=$P(X,U,1) W:Y]"" $J(Y,5,2)
 D N:$X>5 Q:'DN  W ?5 W "MEASURED LEAD AMPLITUDE (mV)"
 S X=$G(^MCAR(698.3,D0,1)) D N:$X>41 Q:'DN  W ?41 S Y=$P(X,U,2) W:Y]"" $J(Y,6,1)
 S X=$G(^MCAR(698.3,D0,2)) D N:$X>62 Q:'DN  W ?62 S Y=$P(X,U,2) W:Y]"" $J(Y,6,1)
 D N:$X>5 Q:'DN  W ?5 W "RATIO (T/L)"
 S X=$G(^MCAR(698.3,D0,1)) D N:$X>42 Q:'DN  W ?42 S Y=$P(X,U,3) W:Y]"" $J(Y,7,3)
 S X=$G(^MCAR(698.3,D0,2)) D N:$X>63 Q:'DN  W ?63 S Y=$P(X,U,3) W:Y]"" $J(Y,3,0)
 D N:$X>5 Q:'DN  W ?5 W "THRESHOLD WIDTH"
 S X=$G(^MCAR(698.3,D0,1)) D N:$X>42 Q:'DN  W ?42 S Y=$P(X,U,4) W:Y]"" $J(Y,6,2)
 S X=$G(^MCAR(698.3,D0,2)) D N:$X>63 Q:'DN  W ?63 S Y=$P(X,U,4) W:Y]"" $J(Y,6,2)
 D N:$X>5 Q:'DN  W ?5 W "THRESHOLD AMPLITUDE"
 S X=$G(^MCAR(698.3,D0,1)) D N:$X>42 Q:'DN  W ?42 S Y=$P(X,U,5) W:Y]"" $J(Y,6,2)
 S X=$G(^MCAR(698.3,D0,2)) D N:$X>63 Q:'DN  W ?63 S Y=$P(X,U,5) W:Y]"" $J(Y,6,2)
 D N:$X>5 Q:'DN  W ?5 W "CAPTURE"
 S X=$G(^MCAR(698.3,D0,1)) D N:$X>43 Q:'DN  W ?43 S Y=$P(X,U,6) W:Y]"" $S($D(DXS(15,Y)):DXS(15,Y),1:Y)
 S X=$G(^MCAR(698.3,D0,2)) D N:$X>64 Q:'DN  W ?64 S Y=$P(X,U,6) W:Y]"" $S($D(DXS(16,Y)):DXS(16,Y),1:Y)
 D N:$X>5 Q:'DN  W ?5 W "SENSE"
 S X=$G(^MCAR(698.3,D0,1)) D N:$X>43 Q:'DN  W ?43 S Y=$P(X,U,7) W:Y]"" $S($D(DXS(17,Y)):DXS(17,Y),1:Y)
 S X=$G(^MCAR(698.3,D0,2)) D N:$X>64 Q:'DN  W ?64 S Y=$P(X,U,7) W:Y]"" $S($D(DXS(18,Y)):DXS(18,Y),1:Y)
 D T Q:'DN  D N D N D N:$X>31 Q:'DN  W ?31 X DXS(7,9) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>5 Q:'DN  W ?5 S DIP(1)=$S($D(^MCAR(698.3,D0,0)):^(0),1:"") S X="RATE: "_$P(DIP(1),U,15) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 S DIP(1)=$S($D(^MCAR(698.3,D0,0)):^(0),1:"") S X="RATE UPPER LIMIT: "_$P(DIP(1),U,16) K DIP K:DN Y W X
 G ^MCAROPS1
