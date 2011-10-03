PRCST7 ; GENERATED FROM 'PRCSMDS' PRINT TEMPLATE (#313) ; 10/27/00 ; (FILE 410, MARGIN=80)
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
 I $D(DXS)<9 M DXS=^DIPT(313,"DXS")
 S I(0)="^PRCS(410,",J(0)=410
 S X=$G(^PRCS(410,D0,0)) D N:$X>0 Q:'DN  W ?0,$E($P(X,U,1),1,18)
 S I(1)="""IT""",J(1)=410.02 F D1=0:0 Q:$O(^PRCS(410,D0,"IT",D1))'>0  X:$D(DSC(410.02)) DSC(410.02) S D1=$O(^(D1)) Q:D1'>0  D:$X>20 T Q:'DN  D A1
 G A1R
A1 ;
 D N:$X>19 Q:'DN  W ?19 S DIP(1)=$S($D(^PRCS(410,D0,"IT",D1,0)):^(0),1:"") S X="#"_$P(DIP(1),U,1) K DIP K:DN Y W X
 S X=$G(^PRCS(410,D0,"IT",D1,0)) D N:$X>29 Q:'DN  W ?29,$E($P(X,U,5),1,30)
 W ?61 S Y=$P(X,U,2) W:Y]"" $J(Y,10,2)
 S DICMX="D ^DIWP" D N:$X>2 Q:'DN  S DIWL=3,DIWR=78 X DXS(1,9.2):D1>0 S X="",DIP(1)=X S X=1,DIP(2)=X S X=10,X=$E(DIP(1),DIP(2),X) K DIP K:DN Y
 D 0^DIWW K DIP K:DN Y
 S I(2)=2,J(2)=410.212 F D2=0:0 Q:$O(^PRCS(410,D0,"IT",D1,2,D2))'>0  X:$D(DSC(410.212)) DSC(410.212) S D2=$O(^(D2)) Q:D2'>0  D:$X>2 NX^DIWW D A2
 G A2R
A2 ;
 S X=$G(^PRCS(410,D0,"IT",D1,2,D2,0)) D N:$X>5 Q:'DN  W ?5 S Y=$P(X,U,1) W:Y]"" $J(Y,3,0)
 S I(100)="^PRCS(410.6,",J(100)=410.6 S I(2,0)=D2 S I(1,0)=D1 S I(0,0)=D0 S DIP(1)=$S($D(^PRCS(410,D0,"IT",D1,2,D2,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X S D(0)=+X S D0=D(0) I D0>0 D A3
 G A3R
A3 ;
 S X=$G(^PRCS(410.6,D0,0)) W ?11 S Y=$P(X,U,4) W:Y]"" $J(Y,5,0)
 W ?18 S DIP(101)=$S($D(^PRCS(410.6,D0,0)):^(0),1:"") S X=$P(DIP(101),U,2) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) K DIP K:DN Y W X
 S X=$G(^PRCS(410.6,D0,0)) W ?29 S Y=$P(X,U,6) W:Y]"" $J(Y,5,0)
 W ?36 S DIP(101)=$S($D(^PRCS(410.6,D0,0)):^(0),1:"") S X=$P(DIP(101),U,7) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) K DIP K:DN Y W X
 W ?47 X DXS(2,9.2) S X=$E(DIP(102),DIP(103),X) K DIP K:DN Y W X
 W ?58 X DXS(3,9.2) S X=$E(DIP(102),DIP(103),X) K DIP K:DN Y W X
 Q
A3R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0) S:$D(I(1,0)) D1=I(1,0) S:$D(I(2,0)) D2=I(2,0)
 Q
A2R ;
 D ^DIWW
 Q
A1R ;
 K Y K DIWF
 Q
HEAD ;
 W !,?0,"TRANS#",?19,"ITEM#",?29,"PR#",?63,"ITEM QTY"
 W !,?5,"SCH#",?13,"QTY",?18,"DATE DEL",?31,"QTY",?36,"DATE REC",?47,"SCP",?58,"LOCATION"
 W !,"--------------------------------------------------------------------------------",!!
