LBRYPT1 ; GENERATED FROM 'LBRY PATRON TITLES' PRINT TEMPLATE (#618) ; 08/23/96 ; (FILE 680.5, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(618,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "TITLE: "
 S X=$G(^LBRY(680.5,D0,0)) D N:$X>7 Q:'DN  W ?7,$E($P(X,U,1),1,160)
 S I(100)="^LBRY(680,",J(100)=680 X DXS(1,9.2) S DIP(101)=$S($D(^LBRY(680,D0,0)):^(0),1:"") S X=$S('$D(^LBRY(680.5,+$P(DIP(101),U,1),0)):"",1:$P(^(0),U,1)) S D0=I(0,0) S D0=D(0) I D0>0 D A1
 G A1R
A1 ;
 D N:$X>0 Q:'DN  W ?0 W "INACTIVE: "
 S X=$G(^LBRY(680,D0,0)) D N:$X>10 Q:'DN  W ?10 S Y=$P(X,U,2) W:Y]"" $S($D(DXS(3,Y)):DXS(3,Y),1:Y)
 Q
A1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D N:$X>0 Q:'DN  W ?0 W "FORMERLY: "
 S X=$G(^LBRY(680.5,D0,3)) D N:$X>10 Q:'DN  W ?10 S Y=$P(X,U,6) S Y=$S(Y="":Y,$D(^LBRY(680.5,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,160)
 D N:$X>0 Q:'DN  W ?0 W "CONTINUED BY: "
 D N:$X>14 Q:'DN  W ?14 S Y=$P(X,U,7) S Y=$S(Y="":Y,$D(^LBRY(680.5,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,160)
 S I(100)="^LBRY(680,",J(100)=680 X DXS(2,9.2) S DIP(101)=$S($D(^LBRY(680,D0,0)):^(0),1:"") S X=$S('$D(^LBRY(680.5,+$P(DIP(101),U,1),0)):"",1:$P(^(0),U,1)) S D0=I(0,0) S D0=D(0) I D0>0 D B1
 G B1R
B1 ;
 D N:$X>0 Q:'DN  W ?0 W "PLACEMENT: "
 S X=$G(^LBRY(680,D0,1)) D N:$X>11 Q:'DN  W ?11 S Y=$P(X,U,3) S Y=$S(Y="":Y,$D(^LBRY(680.7,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D N:$X>0 Q:'DN  W ?0 W "MICROFILM HOLDINGS: "
 S X=$G(^LBRY(680,D0,2)) D N:$X>20 Q:'DN  W ?20,$E($P(X,U,2),1,75)
 D N:$X>0 Q:'DN  W ?0 W "DETAILED HOLDINGS: "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(101)=12,J(101)=680.05 F D1=0:0 Q:$O(^LBRY(680,D0,12,D1))'>0  S D1=$O(^(D1)) D:$X>21 T Q:'DN  D A2
 G A2R
A2 ;
 S X=$G(^LBRY(680,D0,12,D1,0)) S DIWL=3,DIWR=78 D ^DIWP
 Q
A2R ;
 D A^DIWW
 D N:$X>0 Q:'DN  W ?0 W "SUMMARY HOLDINGS: "
 S X=$G(^LBRY(680,D0,9)) D N:$X>18 Q:'DN  W ?18,$E($P(X,U,1),1,50)
 D N:$X>0 Q:'DN  W ?0 W "GAPS: "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(101)=11,J(101)=680.04 F D1=0:0 Q:$O(^LBRY(680,D0,11,D1))'>0  S D1=$O(^(D1)) D:$X>8 T Q:'DN  D B2
 G B2R
B2 ;
 S X=$G(^LBRY(680,D0,11,D1,0)) S DIWL=3,DIWR=78 D ^DIWP
 Q
B2R ;
 D A^DIWW
 D N:$X>0 Q:'DN  W ?0 W "RETENTION POLICY: "
 S X=$G(^LBRY(680,D0,9)) D N:$X>19 Q:'DN  W ?19,$E($P(X,U,4),1,20)
 Q
B1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
