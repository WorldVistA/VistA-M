ONCOX71 ; GENERATED FROM 'ONCOX7' PRINT TEMPLATE (#848) ; 03/18/98 ; (continued)
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
 W "    # Fractions:  "
 S Y=$P(X,U,5) W:Y]"" $J(Y,3,0)
 W "    Predominant FXN size:  "
 S Y=$P(X,U,6) W:Y]"" $J(Y,5,0)
 D N:$X>16 Q:'DN  W ?16 W "# Days:  "
 S Y=$P(X,U,7) W:Y]"" $J(Y,4,0)
 W "      Start Date:  "
 S Y=$P(X,U,8) D DT
 W "      Stop Date:  "
 S Y=$P(X,U,9) D DT
 S I(2)=1,J(2)=165.529 F D2=0:0 Q:$O(^ONCO(165.5,D0,6,D1,1,D2))'>0  S D2=$O(^(D2)) D:$X>27 T Q:'DN  D A2
 G A2R
A2 ;
 S X=$G(^ONCO(165.5,D0,6,D1,1,D2,0)) S DIWL=1,DIWR=103 D ^DIWP
 Q
A2R ;
 D A^DIWW
 D T Q:'DN  D N D N:$X>1 Q:'DN  W ?1 W "  "
 Q
C1R ;
 D N:$X>6 Q:'DN  W ?6 W "- Text Rx-Rad (BEAM):  "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=15,J(1)=165.5109 F D1=0:0 Q:$O(^ONCO(165.5,D0,15,D1))'>0  S D1=$O(^(D1)) D:$X>31 T Q:'DN  D D1
 G D1R
D1 ;
 S X=$G(^ONCO(165.5,D0,15,D1,0)) S DIWL=1,DIWR=99 D ^DIWP
 Q
D1R ;
 D A^DIWW
 D N:$X>6 Q:'DN  W ?6 W "- Text Rx-Rad-Other:  "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=16,J(1)=165.53 F D1=0:0 Q:$O(^ONCO(165.5,D0,16,D1))'>0  S D1=$O(^(D1)) D:$X>30 T Q:'DN  D E1
 G E1R
E1 ;
 S X=$G(^ONCO(165.5,D0,16,D1,0)) S DIWL=1,DIWR=100 D ^DIWP
 Q
E1R ;
 D 0^DIWW K DIP K:DN Y
 W ?30 W "Radiation Therapy to CNS DAte:  "
 S X=$G(^ONCO(165.5,D0,3)) S Y=$P(X,U,8) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 D ^DIWW
 D N:$X>39 Q:'DN  W ?39 X DXS(13,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 S X=$G(^ONCO(165.5,D0,3)) D N:$X>59 Q:'DN  W ?59 S Y=$P(X,U,10) W:Y]"" $S($D(DXS(15,Y)):DXS(15,Y),1:Y)
 K Y K DIWF
 Q
HEAD ;
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
