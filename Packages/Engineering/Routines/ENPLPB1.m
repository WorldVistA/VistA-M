ENPLPB1 ; GENERATED FROM 'ENPLP006' PRINT TEMPLATE (#158) ; 06/11/96 ; (continued)
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
 W "* Reserved for Future Use *"
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "21. DEPARTMENT/SERVICE OR TECHNICAL"
 D N:$X>74 Q:'DN  W ?74 W "22. FDP CRITICAL"
 D N:$X>99 Q:'DN  W ?99 W "23. FDP CORRECTIVE"
 D N:$X>4 Q:'DN  W ?4 W "DEFICIENCIES TO BE ADDRESSED"
 D N:$X>78 Q:'DN  W ?78 W "RATING"
 D N:$X>103 Q:'DN  W ?103 W "ACTION #"
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W ""
 D N:$X>29 Q:'DN  W ?29 W "* Reserved for Future Use *"
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "24. PROJECT SCOPE: "
 D N:$X>4 Q:'DN  W ?4 W "25. CODE"
 D N:$X>19 Q:'DN  W ?19 W "26. DEPARTMENT/SERVICE"
 D N:$X>69 Q:'DN  W ?69 W "27.       NEW"
 D N:$X>107 Q:'DN  W ?107 W "28. RENOVATED"
 D N:$X>72 Q:'DN  W ?72 W "NSF           GSF"
 D N:$X>105 Q:'DN  W ?105 W "NSF           GSF"
 S I(1)=22,J(1)=6925.03 F D1=0:0 Q:$O(^ENG("PROJ",D0,22,D1))'>0  X:$D(DSC(6925.03)) DSC(6925.03) S D1=$O(^(D1)) Q:D1'>0  D:$X>124 T Q:'DN  D D1
 G D1R
D1 ;
 D N:$X>8 Q:'DN  W ?8 X DXS(9,9.2) S DIP(101)=$S($D(^OFM(7336.6,D0,0)):^(0),1:"") S X=$P(DIP(101),U,2) S D0=I(0,0) S D1=I(1,0) K DIP K:DN Y W X
 D N:$X>23 Q:'DN  W ?23 X DXS(10,9.2) S DIP(101)=$S($D(^OFM(7336.6,D0,0)):^(0),1:"") S X=$P(DIP(101),U,1) S D0=I(0,0) S D1=I(1,0) K DIP K:DN Y W X
 S X=$G(^ENG("PROJ",D0,22,D1,0)) D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,2) W:Y]"" $J(Y,9,0)
 D N:$X>83 Q:'DN  W ?83 S Y=$P(X,U,3) W:Y]"" $J(Y,9,0)
 D N:$X>102 Q:'DN  W ?102 S Y=$P(X,U,4) W:Y]"" $J(Y,9,0)
 D N:$X>116 Q:'DN  W ?116 S Y=$P(X,U,5) W:Y]"" $J(Y,9,0)
 Q
D1R ;
 D T Q:'DN  D N D N:$X>39 Q:'DN  W ?39 W "29.-30. NSF & GSF TOTALS: "
 D N:$X>69 Q:'DN  W ?69 X DXS(11,9) K DIP K:DN Y W $J(X,9)
 D N:$X>83 Q:'DN  W ?83 X DXS(12,9) K DIP K:DN Y W $J(X,9)
 D N:$X>102 Q:'DN  W ?102 X DXS(13,9) K DIP K:DN Y W $J(X,9)
 D N:$X>116 Q:'DN  W ?116 X DXS(14,9) K DIP K:DN Y W $J(X,9)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "31.-39. (ISSUES) SITE: "
 S X=$G(^ENG("PROJ",D0,29)) W ?0,$E($P(X,U,1),1,90)
 D N:$X>0 Q:'DN  W ?0 W ?11 W "HISTORICAL: "
 W ?0,$E($P(X,U,2),1,90)
 D N:$X>0 Q:'DN  W ?0 W ?8 W "ENVIRONMENTAL: "
 S X=$G(^ENG("PROJ",D0,32)) W ?0,$E($P(X,U,2),1,90)
 D N:$X>0 Q:'DN  W ?0 W ?14 W "SEISMIC: "
 S X=$G(^ENG("PROJ",D0,30)) W ?0,$E($P(X,U,1),1,90)
 D N:$X>0 Q:'DN  W ?0 W ?5 W "HAZARDOUS MAT'LS: "
 W ?0,$E($P(X,U,2),1,90)
 D N:$X>0 Q:'DN  W ?0 W ?12 W "TRANSPORT: "
 S X=$G(^ENG("PROJ",D0,31)) W ?0,$E($P(X,U,1),1,90)
 D N:$X>0 Q:'DN  W ?0 W ?14 W "PARKING: "
 W ?0,$E($P(X,U,2),1,90)
 D N:$X>0 Q:'DN  W ?0 W ?15 W "IMPACT: "
 W ?25 W "Information (if any) moved to Impact Justification on page 3."
 F Y=0:0 Q:$Y>(IOSL-6)  W !
 D N:$X>0 Q:'DN  W ?0 W "VAF 10-1193 REVISED 5/95 p.1"
 K Y K DIWF
 Q
HEAD ;
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
