DVBAXP1 ; GENERATED FROM 'DVBA STATUS' PRINT TEMPLATE (#517) ; 08/19/96 ; (continued)
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
 S X=$G(^DVB(396,D0,1)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,5) D DT
 S X=$G(^DVB(396,D0,2)) D N:$X>49 Q:'DN  W ?49,$E($P(X,U,1),1,11)
 S X=$G(^DVB(396,D0,6)) D N:$X>61 Q:'DN  W ?61 S Y=$P(X,U,21) S Y=$S(Y="":Y,$D(^DG(40.8,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,16)
 F Y=0:0 Q:$Y>11  W !
 D N:$X>1 Q:'DN  W ?1 W "Asset Information:"
 S X=$G(^DVB(396,D0,0)) D N:$X>22 Q:'DN  W ?22 S Y=$P(X,U,23) W:Y]"" $S($D(DXS(13,Y)):DXS(13,Y),1:Y)
 S X=$G(^DVB(396,D0,1)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,6) D DT
 S X=$G(^DVB(396,D0,2)) D N:$X>49 Q:'DN  W ?49,$E($P(X,U,2),1,11)
 S X=$G(^DVB(396,D0,6)) D N:$X>61 Q:'DN  W ?61 S Y=$P(X,U,23) S Y=$S(Y="":Y,$D(^DG(40.8,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,16)
 F Y=0:0 Q:$Y>12  W !
 D N:$X>2 Q:'DN  W ?2 W "Admission Report:"
 S X=$G(^DVB(396,D0,1)) D N:$X>22 Q:'DN  W ?22 S Y=$P(X,U,7) W:Y]"" $S($D(DXS(14,Y)):DXS(14,Y),1:Y)
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,8) D DT
 S X=$G(^DVB(396,D0,2)) D N:$X>49 Q:'DN  W ?49,$E($P(X,U,3),1,11)
 S X=$G(^DVB(396,D0,6)) D N:$X>61 Q:'DN  W ?61 S Y=$P(X,U,7) S Y=$S(Y="":Y,$D(^DG(40.8,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,16)
 F Y=0:0 Q:$Y>13  W !
 D N:$X>1 Q:'DN  W ?1 W "OPT Treatment Rpt:"
 S X=$G(^DVB(396,D0,0)) D N:$X>22 Q:'DN  W ?22 S Y=$P(X,U,26) W:Y]"" $S($D(DXS(15,Y)):DXS(15,Y),1:Y)
 S X=$G(^DVB(396,D0,1)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,9) D DT
 S X=$G(^DVB(396,D0,2)) D N:$X>49 Q:'DN  W ?49,$E($P(X,U,4),1,11)
 S X=$G(^DVB(396,D0,6)) D N:$X>61 Q:'DN  W ?61 S Y=$P(X,U,26) S Y=$S(Y="":Y,$D(^DG(40.8,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,16)
 F Y=0:0 Q:$Y>14  W !
 D N:$X>5 Q:'DN  W ?5 W "Beg Date/Care:"
 S X=$G(^DVB(396,D0,0)) D N:$X>22 Q:'DN  W ?22 S Y=$P(X,U,28) W:Y]"" $S($D(DXS(16,Y)):DXS(16,Y),1:Y)
 S X=$G(^DVB(396,D0,1)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,10) D DT
 S X=$G(^DVB(396,D0,2)) D N:$X>49 Q:'DN  W ?49,$E($P(X,U,5),1,11)
 S X=$G(^DVB(396,D0,6)) D N:$X>61 Q:'DN  W ?61 S Y=$P(X,U,28) S Y=$S(Y="":Y,$D(^DG(40.8,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,16)
 F Y=0:0 Q:$Y>16  W !
 W ?0 W "REMARKS:"
 S I(1)=5,J(1)=396.02 F D1=0:0 Q:$O(^DVB(396,D0,5,D1))'>0  S D1=$O(^(D1)) D:$X>10 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^DVB(396,D0,5,D1,0)) S DIWL=11,DIWR=78 D ^DIWP
 Q
A1R ;
 D A^DIWW
 F Y=0:0 Q:$Y>18  W !
 W ?0 W "Requesting location: "
 D N:$X>22 Q:'DN  W ?22 S DIP(1)=$S($D(^DVB(396,D0,2)):^(2),1:"") S X=$P(DIP(1),U,7),DIP(2)=X S X=1,DIP(3)=X S X=20,X=$E(DIP(2),DIP(3),X) K DIP K:DN Y W X
 W ?33 X DXS(3,9) K DIP K:DN Y
 W ?44 X DXS(4,9) K DIP K:DN Y
 F Y=0:0 Q:$Y>19  W !
 D N:$X>7 Q:'DN  W ?7 W "Requested by: "
 D N:$X>22 Q:'DN  W ?22 S DIP(1)=$S($D(^DVB(396,D0,2)):^(2),1:"") S X=$P(DIP(1),U,8),DIP(2)=X S X=1,DIP(3)=X S X=25,X=$E(DIP(2),DIP(3),X) K DIP K:DN Y W X
 W ?33 X DXS(5,9) K DIP K:DN Y
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
