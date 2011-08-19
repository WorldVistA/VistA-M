MCAROP ; GENERATED FROM 'MCAROP' PRINT TEMPLATE (#1002) ; 10/04/96 ; (FILE 699, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(1002,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D N:$X>1 Q:'DN  W ?1 W "Procedure:  "
 X DXS(1,9.2) S X=$P(DIP(101),U,8) S D0=I(0,0) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 W "Ward/Clinic: "
 S X=$G(^MCAR(699,D0,0)) S Y=$P(X,U,11) S Y=$S(Y="":Y,$D(^SC(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,20)
 D N:$X>1 Q:'DN  W ?1 W "Bronchoscopist: "
 D N:$X>18 Q:'DN  W ?18 S Y=$P(X,U,8) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D N:$X>44 Q:'DN  W ?44 W "Fellow: "
 S X=$G(^MCAR(699,D0,200)) S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D N:$X>44 Q:'DN  W ?44 W "2nd Fellow: "
 S X=$G(^MCAR(699,D0,29)) S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 S X=1 X "F I=1:1:X "_$S($D(^UTILITY($J,"W")):"S X="" |TAB|"" D L^DIWP",1:"W !") S X="" K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 X DXS(2,9) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Glaucoma: "
 X DXS(3,9.2) S DIP(101)=$S($D(^MCAR(690,D0,"GI")):^("GI"),1:"") S X=$P($P(DIP(102),$C(59)_$P(DIP(101),U,5)_":",2),$C(59),1) S D0=I(0,0) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 W "Bleeding Disorder: "
 X DXS(4,9) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Valvular Heart Disease: "
 X DXS(5,9.2) S DIP(101)=$S($D(^MCAR(690,D0,"GI")):^("GI"),1:"") S X=$P($P(DIP(102),$C(59)_$P(DIP(101),U,4)_":",2),$C(59),1) S D0=I(0,0) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Comments:"
 X DXS(6,9.2) S X=$P(DIP(101),U,6) S D0=I(0,0) K DIP K:DN Y W X
 W ?13 D ^MCARGEA K DIP K:DN Y
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 X DXS(7,9) K DIP K:DN Y W X
 S I(1)=1,J(1)=699.16 F D1=0:0 Q:$O(^MCAR(699,D0,1,D1))'>0  X:$D(DSC(699.16)) DSC(699.16) S D1=$O(^(D1)) Q:D1'>0  D:$X>0 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^MCAR(699,D0,1,D1,0)) D T Q:'DN  W ?2 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(694.1,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,100)
 Q
A1R ;
 D N:$X>2 Q:'DN  W ?2 W "Comment: "
 S X=$G(^MCAR(699,D0,0)) D N:$X>12 Q:'DN  S DIWL=13,DIWR=80 S Y=$P(X,U,6) S X=Y D ^DIWP
 D 0^DIWW K DIP K:DN Y
 W ?12 D IND^MCARGS K DIP K:DN Y
 D ^DIWW
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 X DXS(8,9) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Where Performed: "
 S X=$G(^MCAR(699,D0,0)) S Y=$P(X,U,10) S Y=$S(Y="":Y,$D(^SC(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>44 Q:'DN  W ?44 W "Start - End: "
 S DIP(1)=$S($D(^MCAR(699,D0,9)):^(9),1:"") S X=$P(DIP(1),U,1)_" - "_$P(DIP(1),U,2) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Urgency: "
 S X=$G(^MCAR(699,D0,9)) S Y=$P(X,U,3) W:Y]"" $S($D(DXS(10,Y)):DXS(10,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Instrument: "
 S DICMX="D L^DIWP" S DIWL=1,DIWR=62 X DXS(9,9) K DIP K:DN Y
 D A^DIWW
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Medications Used:"
 S I(1)=8,J(1)=699.38 F D1=0:0 Q:$O(^MCAR(699,D0,8,D1))'>0  X:$D(DSC(699.38)) DSC(699.38) S D1=$O(^(D1)) Q:D1'>0  D:$X>21 T Q:'DN  D B1
 G B1R
B1 ;
 S X=$G(^MCAR(699,D0,8,D1,0)) D N:$X>21 Q:'DN  W ?21 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(695,Y,0))#2:$P(^(0),U,1),1:Y) S Y=$S(Y="":Y,$D(^PSDRUG(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,40)
 W "   "
 S DIP(1)=$S($D(^MCAR(699,D0,8,D1,0)):^(0),1:"") S X=$P(DIP(1),U,3)_" mg  " K DIP K:DN Y W X
 S X=$G(^MCAR(699,D0,8,D1,0)) S Y=$P(X,U,4) W:Y]"" $S($D(DXS(11,Y)):DXS(11,Y),1:Y)
 Q
B1R ;
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
