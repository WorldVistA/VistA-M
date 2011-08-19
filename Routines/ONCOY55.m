ONCOY55 ; GENERATED FROM 'ONCOY55' PRINT TEMPLATE (#813) ; 04/10/06 ; (FILE 165.5, MARGIN=80)
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
 I $D(DXS)<9 M DXS=^DIPT(813,"DXS")
 S I(0)="^ONCO(165.5,",J(0)=165.5
 S DIWF="W"
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Chemotherapy..................:"
 S X=$G(^ONCO(165.5,D0,3)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,11) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 S X=$G(^ONCO(165.5,D0,3)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,13) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Chemotherapy @Fac.............:"
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,15) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,14) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Hormone Therapy...............:"
 S X=$G(^ONCO(165.5,D0,3)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,14) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 S X=$G(^ONCO(165.5,D0,3)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,16) W:Y]"" $S($D(DXS(3,Y)):DXS(3,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Hormone Therapy @Fac..........:"
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,17) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,16) W:Y]"" $S($D(DXS(4,Y)):DXS(4,Y),1:Y)
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Immunotherapy.................:"
 S X=$G(^ONCO(165.5,D0,3)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,17) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 S X=$G(^ONCO(165.5,D0,3)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,19) W:Y]"" $S($D(DXS(5,Y)):DXS(5,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Immunotherapy @Fac............:"
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,19) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,18) W:Y]"" $S($D(DXS(6,Y)):DXS(6,Y),1:Y)
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Hema Trans/Endocrine Proc.....:"
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,35) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,36) S Y(0)=Y I Y'="" S Y=$P($G(^ONCO(167,Y,0)),U,2) W $E(Y,1,34)
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Other Treatment...............:"
 S X=$G(^ONCO(165.5,D0,3)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,23) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 S X=$G(^ONCO(165.5,D0,3)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,25) W:Y]"" $S($D(DXS(7,Y)):DXS(7,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Other Treatment @Fac..........:"
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,21) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,20) W:Y]"" $S($D(DXS(8,Y)):DXS(8,Y),1:Y)
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Protocol Eligibility Status...:"
 S X=$G(^ONCO(165.5,D0,"BLA2")) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(9,Y)):DXS(9,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Year Put on Protocol..........:"
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>34 Q:'DN  W ?34,$E($P(X,U,4),1,4)
 D N:$X>2 Q:'DN  W ?2 W "Protocol Participation........:"
 S X=$G(^ONCO(165.5,D0,"STS2")) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,31) W:Y]"" $S($D(DXS(10,Y)):DXS(10,Y),1:Y)
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Text-Remarks:"
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=19,J(1)=165.5113 F D1=0:0 Q:$O(^ONCO(165.5,D0,19,D1))'>0  S D1=$O(^(D1)) D:$X>17 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^ONCO(165.5,D0,19,D1,0)) S DIWL=3,DIWR=78 D ^DIWP
 Q
A1R ;
 D 0^DIWW
 D ^DIWW K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
