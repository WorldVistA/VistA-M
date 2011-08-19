MCAROPA ; GENERATED FROM 'MCAROPA' PRINT TEMPLATE (#989) ; 10/04/96 ; (FILE 698.2, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(989,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D N:$X>32 Q:'DN  W ?32 X DXS(1,9) K DIP K:DN Y W X
 D T Q:'DN  D N D N D N:$X>2 Q:'DN  W ?2 S DIP(1)=$S($D(^MCAR(698.2,D0,0)):^(0),1:"") S X="MODEL: "_$S('$D(^MCAR(698.4,+$P(DIP(1),U,3),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 S DIP(1)=$S($D(^MCAR(698.2,D0,0)):^(0),1:"") S X="MANUFACTURER: "_$S('$D(^MCAR(698.6,+$P(DIP(1),U,4),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 S DIP(1)=$S($D(^MCAR(698.2,D0,0)):^(0),1:"") S X="SERIAL NUMBER: "_$P(DIP(1),U,5) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "ATTENDING PHYSICIAN: "
 S X=$G(^MCAR(698.2,D0,3)) S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D N:$X>2 Q:'DN  W ?2 W "FELLOW-1st: "
 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D N:$X>2 Q:'DN  W ?2 W "FELLOW-2nd: "
 S Y=$P(X,U,3) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "THRESHOLD (VOLTS):"
 S X=$G(^MCAR(698.2,D0,0)) S Y=$P(X,U,6) W:Y]"" $J(Y,5,1)
 D N:$X>44 Q:'DN  W ?44 S DIP(1)=$S($D(^MCAR(698.2,D0,0)):^(0),1:"") S X="RESISTANCE (OHMS): "_$P(DIP(1),U,8) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "           (mA'S):"
 S X=$G(^MCAR(698.2,D0,0)) S Y=$P(X,U,7) W:Y]"" $J(Y,5,1)
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 S DIP(1)=$S($D(^MCAR(698.2,D0,0)):^(0),1:"") S X="P WAVE AMPLITUDE (mV): "_$P(DIP(1),U,9) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 S DIP(1)=$S($D(^MCAR(698.2,D0,0)):^(0),1:"") S X="PSA USED: "_$S('$D(^MCAR(698.4,+$P(DIP(1),U,10),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 X DXS(2,9.2) S X="LEAD EXPLANT REASON: ",X=$S(DIP(2):DIP(3),DIP(4):X) K DIP K:DN Y W X
 S X=$G(^MCAR(698.2,D0,1)) S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^MCAR(695.8,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,60)
 S DIP(1)=$S($D(^MCAR(698.2,D0,1)):^(1),1:"") S X=$P(DIP(1),U,1)="",DIP(2)=X S X="",DIP(3)=X S X=1,DIP(4)=X S X=", ",X=$S(DIP(2):DIP(3),DIP(4):X) K DIP K:DN Y W X
 S X=$G(^MCAR(698.2,D0,1)) S Y=$P(X,U,1) D DT
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "COMMENTS: "
 S I(1)=10,J(1)=698.21 F D1=0:0 Q:$O(^MCAR(698.2,D0,10,D1))'>0  S D1=$O(^(D1)) D:$X>14 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^MCAR(698.2,D0,10,D1,0)) S DIWL=15,DIWR=79 D ^DIWP
 Q
A1R ;
 D 0^DIWW K DIP K:DN Y
 D ^DIWW
 S I(100)="^MCAR(690,",J(100)=690 S I(0,0)=D0 S DIP(1)=$S($D(^MCAR(698.2,D0,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X S D(0)=+X S D0=D(0) I D0>0 D B1
 G B1R^MCAROPA1
B1 ;
 D T Q:'DN  D N D N D N:$X>29 Q:'DN  W ?29 X DXS(3,9) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "PACING INDICATION:"
 S I(101)="""P""",J(101)=690.07 F D1=0:0 Q:$O(^MCAR(690,D0,"P",D1))'>0  X:$D(DSC(690.07)) DSC(690.07) S D1=$O(^(D1)) Q:D1'>0  D:$X>22 T Q:'DN  D A2
 G A2R
A2 ;
 S X=$G(^MCAR(690,D0,"P",D1,0)) D T Q:'DN  W ?0 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(694.1,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,100)
 Q
A2R ;
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "RISK FACTORS: "
 S I(101)="""P1""",J(101)=690.08 F D1=0:0 Q:$O(^MCAR(690,D0,"P1",D1))'>0  X:$D(DSC(690.08)) DSC(690.08) S D1=$O(^(D1)) Q:D1'>0  D:$X>18 T Q:'DN  D B2
 G B2R
B2 ;
 S X=$G(^MCAR(690,D0,"P1",D1,0)) D N:$X>17 Q:'DN  W ?17 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(695.4,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,40)
 W ", "
 S Y=$P(X,U,2) D DT
 Q
B2R ;
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "PSC STATUS: "
 S X=$G(^MCAR(690,D0,"P2")) W ?16 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(9,Y)):DXS(9,Y),1:Y)
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 X DXS(4,9.3) S X=X_$P($P(DIP(106),$C(59)_$P(DIP(101),U,1)_":",2),$C(59),1),X=$S(DIP(103):DIP(104),DIP(105):X) K DIP K:DN Y W X
 D N:$X>5 Q:'DN  W ?5 X DXS(5,9.3) S X=$S(DIP(103):DIP(104),DIP(105):X) K DIP K:DN Y W X
 G ^MCAROPA1
