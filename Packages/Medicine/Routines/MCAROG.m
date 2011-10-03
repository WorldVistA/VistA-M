MCAROG ; GENERATED FROM 'MCAROG' PRINT TEMPLATE (#984) ; 10/04/96 ; (FILE 699, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(984,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D N:$X>1 Q:'DN  W ?1 W "PROCEDURE: "
 X DXS(1,9.2) S X=$P(DIP(101),U,8) S D0=I(0,0) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 W "WARD/CLINIC: "
 S X=$G(^MCAR(699,D0,0)) S Y=$P(X,U,11) S Y=$S(Y="":Y,$D(^SC(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,20)
 D N:$X>1 Q:'DN  W ?1 W "Endoscopist: "
 D N:$X>15 Q:'DN  W ?15 S Y=$P(X,U,8) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D N:$X>44 Q:'DN  W ?44 W "FELLOW: "
 S X=$G(^MCAR(699,D0,200)) S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D N:$X>44 Q:'DN  W ?44 W "2ND FELLOW: "
 S X=$G(^MCAR(699,D0,29)) S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 S X=1 X "F I=1:1:X "_$S($D(^UTILITY($J,"W")):"S X="" |TAB|"" D L^DIWP",1:"W !") S X="" K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 X DXS(2,9) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Liver Biopsy: "
 X DXS(3,9.2) S DIP(101)=$S($D(^MCAR(690,D0,"GI")):^("GI"),1:"") S X=$P($P(DIP(102),$C(59)_$P(DIP(101),U,1)_":",2),$C(59),1) S D0=I(0,0) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 W "Bleeding Disorder: "
 X DXS(4,9) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Valvular Heart Disease: "
 X DXS(5,9.2) S DIP(101)=$S($D(^MCAR(690,D0,"GI")):^("GI"),1:"") S X=$P($P(DIP(102),$C(59)_$P(DIP(101),U,4)_":",2),$C(59),1) S D0=I(0,0) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 W "Glaucoma: "
 X DXS(6,9.2) S DIP(101)=$S($D(^MCAR(690,D0,"GI")):^("GI"),1:"") S X=$P($P(DIP(102),$C(59)_$P(DIP(101),U,5)_":",2),$C(59),1) S D0=I(0,0) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Allergies:"
 S I(100)="^MCAR(690,",J(100)=690 S I(0,0)=D0 S DIP(1)=$S($D(^MCAR(699,D0,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X S D(0)=+X S D0=D(0) I D0>0 D A1
 G A1R
A1 ;
 X ^DD(690,2,9.3) S X=$S('$D(^DIC(57,+$P(Y(690,2,202),U,1),0)):"",1:$P(^(0),U,1)) S D0=Y(690,2,80) S D1=Y(690,2,181) W $J(X,9) K Y(690,2)
 Q
A1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D N:$X>2 Q:'DN  W ?2 W "Comments:  "
 X DXS(7,9.2) S X=$P(DIP(101),U,6) S D0=I(0,0) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 X DXS(8,9) K DIP K:DN Y W X
 W ?0 D IND^MCARGS K DIP K:DN Y
 D N:$X>2 Q:'DN  W ?2 W "COMMENT:"
 S X=$G(^MCAR(699,D0,0)) D N:$X>12 Q:'DN  S DIWL=13,DIWR=80 S Y=$P(X,U,6) S X=Y D ^DIWP
 D A^DIWW
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 X DXS(9,9) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Where Performed: "
 S X=$G(^MCAR(699,D0,0)) S Y=$P(X,U,10) S Y=$S(Y="":Y,$D(^SC(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>44 Q:'DN  W ?44 W "Start - End: "
 S DIP(1)=$S($D(^MCAR(699,D0,9)):^(9),1:"") S X=$P(DIP(1),U,1)_" - "_$P(DIP(1),U,2) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Urgency: "
 S X=$G(^MCAR(699,D0,9)) S Y=$P(X,U,3) W:Y]"" $S($D(DXS(10,Y)):DXS(10,Y),1:Y)
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Instrument:"
 S I(1)=34,J(1)=699.05 F D1=0:0 Q:$O(^MCAR(699,D0,34,D1))'>0  X:$D(DSC(699.05)) DSC(699.05) S D1=$O(^(D1)) Q:D1'>0  D:$X>15 T Q:'DN  D B1
 G B1R
B1 ;
 S X=$G(^MCAR(699,D0,34,D1,0)) D N:$X>4 Q:'DN  W ?4 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(699.48,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 Q
B1R ;
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Insertion Depth: "
 S X=$G(^MCAR(699,D0,15)) S Y=$P(X,U,6) S Y=$S(Y="":Y,$D(^MCAR(697,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 W ?21 D:MCARGNAM="COL" COL^MCARGS K DIP K:DN Y
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Medications Used:"
 S I(1)=8,J(1)=699.38 F D1=0:0 Q:$O(^MCAR(699,D0,8,D1))'>0  X:$D(DSC(699.38)) DSC(699.38) S D1=$O(^(D1)) Q:D1'>0  D:$X>21 T Q:'DN  D C1
 G C1R^MCAROG1
C1 ;
 S X=$G(^MCAR(699,D0,8,D1,0)) D N:$X>21 Q:'DN  W ?21 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(695,Y,0))#2:$P(^(0),U,1),1:Y) S Y=$S(Y="":Y,$D(^PSDRUG(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,40)
 W "  "
 G ^MCAROG1
