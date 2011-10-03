ONCOX8 ; GENERATED FROM 'ONCOX8' PRINT TEMPLATE (#849) ; 08/13/03 ; (FILE 165.5, MARGIN=132)
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
 I $D(DXS)<9 M DXS=^DIPT(849,"DXS")
 S I(0)="^ONCO(165.5,",J(0)=165.5
 D T Q:'DN  D N D N:$X>1 Q:'DN  W ?1 W "Chemotherapy Date: "
 S X=$G(^ONCO(165.5,D0,3)) S Y=$P(X,U,11) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 D N:$X>39 Q:'DN  W ?39 X DXS(1,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>59 Q:'DN  W ?59 X DXS(2,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>1 Q:'DN  W ?1 W "Reason for No Chemotherapy:  "
 S X=$G(^ONCO(165.5,D0,3)) S Y=$P(X,U,36) W:Y]"" $S($D(DXS(8,Y)):DXS(8,Y),1:Y)
 D N:$X>6 Q:'DN  W ?6 W "Text-Rx-Chemo:  "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=17,J(1)=165.5111 F D1=0:0 Q:$O(^ONCO(165.5,D0,17,D1))'>0  S D1=$O(^(D1)) D:$X>24 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^ONCO(165.5,D0,17,D1,0)) S DIWL=25,DIWR=130 D ^DIWP
 Q
A1R ;
 D 0^DIWW
 D ^DIWW
 D N:$X>1 Q:'DN  W ?1 W "Hormone Therapy Date:  "
 S X=$G(^ONCO(165.5,D0,3)) S Y=$P(X,U,14) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 D N:$X>39 Q:'DN  W ?39 X DXS(3,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>59 Q:'DN  W ?59 X DXS(4,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>1 Q:'DN  W ?1 W "Reason for No Hormone Therapy:  "
 S X=$G(^ONCO(165.5,D0,3)) S Y=$P(X,U,37) W:Y]"" $S($D(DXS(9,Y)):DXS(9,Y),1:Y)
 D N:$X>6 Q:'DN  W ?6 W "Text-Rx-Hormone:  "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=18,J(1)=165.5112 F D1=0:0 Q:$O(^ONCO(165.5,D0,18,D1))'>0  S D1=$O(^(D1)) D:$X>26 T Q:'DN  D B1
 G B1R
B1 ;
 S X=$G(^ONCO(165.5,D0,18,D1,0)) S DIWL=27,DIWR=130 D ^DIWP
 Q
B1R ;
 D 0^DIWW
 D ^DIWW
 D N:$X>1 Q:'DN  W ?1 W "Immunotherapy Date:  "
 S X=$G(^ONCO(165.5,D0,3)) S Y=$P(X,U,17) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 D N:$X>39 Q:'DN  W ?39 X DXS(5,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 S X=$G(^ONCO(165.5,D0,3)) D N:$X>59 Q:'DN  W ?59 S Y=$P(X,U,19) W:Y]"" $S($D(DXS(10,Y)):DXS(10,Y),1:Y)
 D N:$X>6 Q:'DN  W ?6 W "Text-RX-Immunotherapy:  "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=20,J(1)=165.5114 F D1=0:0 Q:$O(^ONCO(165.5,D0,20,D1))'>0  S D1=$O(^(D1)) D:$X>32 T Q:'DN  D C1
 G C1R
C1 ;
 S X=$G(^ONCO(165.5,D0,20,D1,0)) S DIWL=33,DIWR=130 D ^DIWP
 Q
C1R ;
 D 0^DIWW
 D ^DIWW
 D N:$X>1 Q:'DN  W ?1 W "Other Therapy Date:  "
 S X=$G(^ONCO(165.5,D0,3)) S Y=$P(X,U,23) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 D N:$X>39 Q:'DN  W ?39 X DXS(6,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>59 Q:'DN  W ?59 X DXS(7,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>6 Q:'DN  W ?6 W "Text-Rx-Other:  "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=21,J(1)=165.5115 F D1=0:0 Q:$O(^ONCO(165.5,D0,21,D1))'>0  S D1=$O(^(D1)) D:$X>24 T Q:'DN  D D1
 G D1R
D1 ;
 S X=$G(^ONCO(165.5,D0,21,D1,0)) S DIWL=25,DIWR=130 D ^DIWP
 Q
D1R ;
 D 0^DIWW
 D ^DIWW
 D N:$X>6 Q:'DN  W ?6 W " " K DIP K:DN Y
 D N:$X>1 Q:'DN  W ?1 W "Protocol Eligibility Status:  "
 S X=$G(^ONCO(165.5,D0,"BLA2")) S Y=$P(X,U,1) W:Y]"" $S($D(DXS(11,Y)):DXS(11,Y),1:Y)
 D N:$X>1 Q:'DN  W ?1 W "Protocol Participation:  "
 S X=$G(^ONCO(165.5,D0,"STS2")) D N:$X>31 Q:'DN  W ?31 S Y=$P(X,U,31) W:Y]"" $S($D(DXS(12,Y)):DXS(12,Y),1:Y)
 D N:$X>6 Q:'DN  W ?6 W " " K DIP K:DN Y
 D N:$X>6 Q:'DN  W ?6 W "Text Remarks:  "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=19,J(1)=165.5113 F D1=0:0 Q:$O(^ONCO(165.5,D0,19,D1))'>0  S D1=$O(^(D1)) D:$X>23 T Q:'DN  D E1
 G E1R
E1 ;
 S X=$G(^ONCO(165.5,D0,19,D1,0)) S DIWL=24,DIWR=130 D ^DIWP
 Q
E1R ;
 D 0^DIWW
 D ^DIWW
 D N:$X>6 Q:'DN  W ?6 W "Physician's Staging: "
 S X=$G(^ONCO(165.5,D0,7)) W ?0,$E($P(X,U,10),1,30)
 D N:$X>49 Q:'DN  W ?49 W "MD: "
 S Y=$P(X,U,11) S Y=$S(Y="":Y,$D(^ONCO(165,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 D N:$X>6 Q:'DN  W ?6 W "QA Selected: "
 S Y=$P(X,U,4) W:Y]"" $S($D(DXS(13,Y)):DXS(13,Y),1:Y)
 D N:$X>34 Q:'DN  W ?34 W "QA Review: "
 S Y=$P(X,U,8) W:Y]"" $S($D(DXS(14,Y)):DXS(14,Y),1:Y)
 D N:$X>54 Q:'DN  W ?54 W "QA Date: "
 S Y=$P(X,U,9) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 D N:$X>1 Q:'DN  W ?1 W " "
 K Y K DIWF
 Q
HEAD ;
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
