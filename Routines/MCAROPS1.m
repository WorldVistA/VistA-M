MCAROPS1 ; GENERATED FROM 'MCAROPS' PRINT TEMPLATE (#991) ; 10/04/96 ; (continued)
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
 D N:$X>5 Q:'DN  W ?5 S DIP(1)=$S($D(^MCAR(698.3,D0,0)):^(0),1:"") S X="A-V DELAY (mSec): "_$P(DIP(1),U,17) K DIP K:DN Y W X
 D N:$X>5 Q:'DN  W ?5 S DIP(1)=$S($D(^MCAR(698.3,D0,0)):^(0),1:"") S X="HYSTERESIS: "_$P(DIP(1),U,18) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 X DXS(8,9) K DIP K:DN Y W X
 D N:$X>5 Q:'DN  W ?5 S DIP(1)=$S($D(^MCAR(698.3,D0,1)):^(1),1:"") S X="PULSE WIDTH (ATRIAL mSec): "_$P(DIP(1),U,8) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 S DIP(1)=$S($D(^MCAR(698.3,D0,2)):^(2),1:"") S X="PULSE WIDTH (VENT. mSec): "_$P(DIP(1),U,8) K DIP K:DN Y W X
 D N:$X>5 Q:'DN  W ?5 S DIP(1)=$S($D(^MCAR(698.3,D0,1)):^(1),1:"") S X="A-AMPLITUDE (VOLTS): "_$P(DIP(1),U,9) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 S DIP(1)=$S($D(^MCAR(698.3,D0,2)):^(2),1:"") S X="V-AMPLITUDE (VOLTS): "_$P(DIP(1),U,9) K DIP K:DN Y W X
 D N:$X>5 Q:'DN  W ?5 S DIP(1)=$S($D(^MCAR(698.3,D0,1)):^(1),1:"") S X="SENSITIVITY (ATRIAL mV): "_$P(DIP(1),U,10) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 S DIP(1)=$S($D(^MCAR(698.3,D0,2)):^(2),1:"") S X="SENSITIVITY (VENT. mV): "_$P(DIP(1),U,10) K DIP K:DN Y W X
 D N:$X>5 Q:'DN  W ?5 S DIP(1)=$S($D(^MCAR(698.3,D0,1)):^(1),1:"") S X="REFRACTORY PERIOD (ATRIAL): "_$P(DIP(1),U,11) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 S DIP(1)=$S($D(^MCAR(698.3,D0,2)):^(2),1:"") S X="REFRACTORY PERIOD (VENT.): "_$P(DIP(1),U,11) K DIP K:DN Y W X
 D N:$X>5 Q:'DN  W ?5 W "BATTERY VOLTAGE: "
 S X=$G(^MCAR(698.3,D0,0)) S Y=$P(X,U,13) W:Y]"" $J(Y,6,2)
 D N:$X>44 Q:'DN  W ?44 W "BATTERY RESISTANCE: "
 S Y=$P(X,U,14) W:Y]"" $J(Y,6,2)
 D T Q:'DN  D N D N:$X>5 Q:'DN  W ?5 W "REASON FOR REPROGRAMMING: "
 S Y=$P(X,U,20) S Y=$S(Y="":Y,$D(^MCAR(695.8,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,60)
 S I(100)="^MCAR(690,",J(100)=690 S I(0,0)=D0 S DIP(1)=$S($D(^MCAR(698.3,D0,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X S D(0)=+X S D0=D(0) I D0>0 D A1
 G A1R
A1 ;
 D T Q:'DN  D N D N D N:$X>31 Q:'DN  W ?31 X DXS(9,9) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>5 Q:'DN  W ?5 W "PACING INDICATION:"
 S I(101)="""P""",J(101)=690.07 F D1=0:0 Q:$O(^MCAR(690,D0,"P",D1))'>0  X:$D(DSC(690.07)) DSC(690.07) S D1=$O(^(D1)) Q:D1'>0  D:$X>25 T Q:'DN  D A2
 G A2R
A2 ;
 S X=$G(^MCAR(690,D0,"P",D1,0)) D T Q:'DN  W ?0 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(694.1,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,100)
 Q
A2R ;
 D T Q:'DN  D N D N:$X>5 Q:'DN  W ?5 W "RISK FACTORS: "
 S I(101)="""P1""",J(101)=690.08 F D1=0:0 Q:$O(^MCAR(690,D0,"P1",D1))'>0  X:$D(DSC(690.08)) DSC(690.08) S D1=$O(^(D1)) Q:D1'>0  D:$X>21 T Q:'DN  D B2
 G B2R
B2 ;
 S X=$G(^MCAR(690,D0,"P1",D1,0)) D N:$X>20 Q:'DN  W ?20 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(695.4,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,40)
 W ", "
 S Y=$P(X,U,2) D DT
 Q
B2R ;
 D T Q:'DN  D N D N:$X>5 Q:'DN  W ?5 W "PSC STATUS: "
 S X=$G(^MCAR(690,D0,"P2")) W ?19 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(19,Y)):DXS(19,Y),1:Y)
 D T Q:'DN  D N D N:$X>5 Q:'DN  W ?5 X DXS(10,9) K DIP K:DN Y W X
 D N:$X>8 Q:'DN  W ?8 X DXS(11,9.3) S X=$S(DIP(103):DIP(104),DIP(105):X) K DIP K:DN Y W X
 D N:$X>8 Q:'DN  W ?8 X DXS(12,9.2) S DIP(103)=X S X="",DIP(104)=X S X=1,DIP(105)=X S X="SUDDENESS: ",X=$S(DIP(103):DIP(104),DIP(105):X) K DIP K:DN Y W X
 S X=$G(^MCAR(690,D0,"P3")) S Y=$P(X,U,3) W:Y]"" $S($D(DXS(20,Y)):DXS(20,Y),1:Y)
 D N:$X>8 Q:'DN  W ?8 X DXS(13,9.2) S X=$S(DIP(102):DIP(103),DIP(104):X) K DIP K:DN Y W X
 S X=$G(^MCAR(690,D0,"P3")) S Y=$P(X,U,4) D DT
 D T Q:'DN  D N D N:$X>5 Q:'DN  W ?5 X DXS(14,9.2) S X=$S(DIP(102):DIP(103),DIP(104):X) K DIP K:DN Y W X
 S X=$G(^MCAR(690,D0,"P3")) W ?0,$E($P(X,U,5),1,25)
 Q
A1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
