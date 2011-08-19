RACTRT ; GENERATED FROM 'RA REPORT PRINT STATUS' PRINT TEMPLATE (#612) ; 08/23/96 ; (FILE 74, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(612,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D N:$X>0 Q:'DN  W ?0 W "Report   :"
 S X=$G(^RARPT(D0,0)) W ?12,$E($P(X,U,1),1,12)
 D N:$X>35 Q:'DN  W ?35 W "Patient :"
 W ?46 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^DPT(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,20)
 W ?68 S RADFN=+$P(^RARPT(D0,0),U,2) W $$SSN^RAUTL(RADFN) K RADFN,RASSN K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Procedure:"
 W ?12 S RAEXFLD="PROC" D ^RARTFLDS K RAEXFLD W $E(X,1,20) K Y(74,102)
 D N:$X>37 Q:'DN  W ?37 W "Verified:"
 S X=$G(^RARPT(D0,0)) W ?48 S Y=$P(X,U,7) D DT
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "Routing Queue"
 D N:$X>24 Q:'DN  W ?24 W "Date Printed"
 D N:$X>44 Q:'DN  W ?44 W "Printed By"
 D N:$X>62 Q:'DN  W ?62 W "Ward/Clinic"
 D N:$X>4 Q:'DN  W ?4 W "-------------"
 D N:$X>24 Q:'DN  W ?24 W "------------"
 D N:$X>44 Q:'DN  W ?44 W "----------"
 D N:$X>62 Q:'DN  W ?62 W "-----------"
 S DIXX(1)="A1",I(0,0)=D0 S I(0,0)=$S($D(D0):D0,1:"") X DXS(1,9.2) S X="" S D0=I(0,0)
 G A1R
A1 ;
 I $D(DSC(74.4)) X DSC(74.4) E  Q
 W:$X>75 ! S I(100)="^RABTCH(74.4,",J(100)=74.4
 S X=$G(^RABTCH(74.4,D0,0)) D N:$X>4 Q:'DN  W ?4 S Y=$P(X,U,11) S Y=$S(Y="":Y,$D(^RABTCH(74.3,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>24 Q:'DN  W ?24 S Y=$P(X,U,4) D DT
 D N:$X>44 Q:'DN  W ?44 S Y=$P(X,U,3) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D N:$X>62 Q:'DN  W ?62 X DXS(2,9.3) S X=$S(DIP(102):DIP(103),DIP(104):X) K DIP K:DN Y W X
 Q
A1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 S X="=",DIP(1)=X,DIP(2)=X,X=$S($D(IOM):IOM,1:80) S X=X,X1=DIP(1) S %=X,X="" Q:X1=""  S $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) K DIP K:DN Y W X
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
