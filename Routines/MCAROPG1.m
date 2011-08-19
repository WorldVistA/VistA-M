MCAROPG1 ; GENERATED FROM 'MCARPG' PRINT TEMPLATE (#988) ; 10/04/96 ; (continued)
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
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "COMMENTS: "
 S I(1)=10,J(1)=698.01 F D1=0:0 Q:$O(^MCAR(698,D0,10,D1))'>0  S D1=$O(^(D1)) D:$X>14 T Q:'DN  D B1
 G B1R
B1 ;
 S X=$G(^MCAR(698,D0,10,D1,0)) S DIWL=14,DIWR=78 D ^DIWP
 Q
B1R ;
 D 0^DIWW K DIP K:DN Y
 D ^DIWW
 S I(100)="^MCAR(690,",J(100)=690 S I(0,0)=D0 S DIP(1)=$S($D(^MCAR(698,D0,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X S D(0)=+X S D0=D(0) I D0>0 D C1
 G C1R
C1 ;
 D T Q:'DN  D N D N D N:$X>31 Q:'DN  W ?31 X DXS(7,9) K DIP K:DN Y W X
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
 S X=$G(^MCAR(690,D0,"P2")) W ?16 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(14,Y)):DXS(14,Y),1:Y)
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 X DXS(8,9.3) S X=X_$P($P(DIP(106),$C(59)_$P(DIP(101),U,1)_":",2),$C(59),1),X=$S(DIP(103):DIP(104),DIP(105):X) K DIP K:DN Y W X
 D N:$X>5 Q:'DN  W ?5 X DXS(9,9.3) S X=$S(DIP(103):DIP(104),DIP(105):X) K DIP K:DN Y W X
 D N:$X>5 Q:'DN  W ?5 X DXS(10,9.2) S DIP(103)=X S X="",DIP(104)=X S X=1,DIP(105)=X S X="SUDDENESS: ",X=$S(DIP(103):DIP(104),DIP(105):X) K DIP K:DN Y W X
 S X=$G(^MCAR(690,D0,"P3")) S Y=$P(X,U,3) W:Y]"" $S($D(DXS(15,Y)):DXS(15,Y),1:Y)
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 X DXS(11,9.2) S X=$S(DIP(102):DIP(103),DIP(104):X) K DIP K:DN Y W X
 S X=$G(^MCAR(690,D0,"P3")) S Y=$P(X,U,4) D DT
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 X DXS(12,9.2) S X=$S(DIP(102):DIP(103),DIP(104):X) K DIP K:DN Y W X
 S X=$G(^MCAR(690,D0,"P3")) W ?0,$E($P(X,U,5),1,25)
 Q
C1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
