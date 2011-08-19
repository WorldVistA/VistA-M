ONCOX10 ; GENERATED FROM 'ONCOX10' PRINT TEMPLATE (#851) ; 03/02/04 ; (FILE 165.5, MARGIN=132)
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
 I $D(DXS)<9 M DXS=^DIPT(851,"DXS")
 S I(0)="^ONCO(165.5,",J(0)=165.5
 S DIWF="W"
 D T Q:'DN  D N W ?0 X DXS(1,9) K DIP K:DN Y W X
 S I(1)=4,J(1)=165.51 F D1=0:0 Q:$O(^ONCO(165.5,D0,4,D1))'>0  X:$D(DSC(165.51)) DSC(165.51) S D1=$O(^(D1)) Q:D1'>0  D:$X>0 T Q:'DN  D A1
 G A1R
A1 ;
 D T Q:'DN  D N D N:$X>29 Q:'DN  W ?29 W "Date started:  "
 S X=$G(^ONCO(165.5,D0,4,D1,0)) S Y=$P(X,U,1) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 D N:$X>9 Q:'DN  W ?9 W "Surgery:  "
 S X=$G(^ONCO(165.5,D0,4,D1,0)) S Y=$P(X,U,11) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 W " "
 S X=$G(^ONCO(165.5,D0,4,D1,0)) S Y=$P(X,U,4) S Y(0)=Y S FIELD=.04 D SPSOT^ONCOSUR W $J(Y,3)
 D N:$X>9 Q:'DN  W ?9 W "Radiation:  "
 S X=$G(^ONCO(165.5,D0,4,D1,0)) S Y=$P(X,U,12) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 W " "
 S X=$G(^ONCO(165.5,D0,4,D1,0)) S Y=$P(X,U,5) W:Y]"" $S($D(DXS(3,Y)):DXS(3,Y),1:Y)
 D N:$X>9 Q:'DN  W ?9 W "Radiation Sequence: "
 S Y=$P(X,U,2) W:Y]"" $S($D(DXS(4,Y)):DXS(4,Y),1:Y)
 D N:$X>9 Q:'DN  W ?9 W "Radiation Therapy to CNS:  "
 S Y=$P(X,U,17) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 W " "
 S X=$G(^ONCO(165.5,D0,4,D1,0)) S Y=$P(X,U,10) W:Y]"" $S($D(DXS(5,Y)):DXS(5,Y),1:Y)
 D N:$X>9 Q:'DN  W ?9 W "Chemotherapy: "
 S Y=$P(X,U,13) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 W " "
 S X=$G(^ONCO(165.5,D0,4,D1,0)) S Y=$P(X,U,6) W:Y]"" $S($D(DXS(6,Y)):DXS(6,Y),1:Y)
 D N:$X>9 Q:'DN  W ?9 W "Hormone/Therapy: "
 S Y=$P(X,U,14) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 W " "
 S X=$G(^ONCO(165.5,D0,4,D1,0)) S Y=$P(X,U,7) W:Y]"" $S($D(DXS(7,Y)):DXS(7,Y),1:Y)
 D N:$X>9 Q:'DN  W ?9 W "Immunotherapy (BRM): "
 S Y=$P(X,U,15) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,18)
 W " "
 S X=$G(^ONCO(165.5,D0,4,D1,0)) S Y=$P(X,U,8) W:Y]"" $S($D(DXS(8,Y)):DXS(8,Y),1:Y)
 D N:$X>9 Q:'DN  W ?9 W "Other Cancer Therapy: "
 S Y=$P(X,U,16) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 W " "
 S X=$G(^ONCO(165.5,D0,4,D1,0)) S Y=$P(X,U,9) W:Y]"" $S($D(DXS(9,Y)):DXS(9,Y),1:Y)
 D N:$X>1 Q:'DN  W ?1 W "Place: "
 S Y=$P(X,U,3) S Y(0)=Y S:Y'="" Y=$S($D(^ONCO(160.19,Y,0)):$P(^(0),U,2),1:Y) W $E(Y,1,30)
 D N:$X>1 Q:'DN  W ?1 W "Comment(s): "
 S DICMX="D ^DIWP" S DIWL=16,DIWR=130 X DXS(2,9) K DIP K:DN Y
 D 0^DIWW
 D ^DIWW
 Q
A1R ;
 K Y K DIWF
 Q
HEAD ;
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
