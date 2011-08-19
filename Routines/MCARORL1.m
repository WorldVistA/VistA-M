MCARORL1 ; GENERATED FROM 'MCRHLAB' PRINT TEMPLATE (#1009) ; 10/04/96 ; (continued)
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
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,13)) ^(13) K DIP K:DN Y
 D N:$X>39 Q:'DN  W ?39 W "VDRL"
 D N:$X>69 Q:'DN  W ?69 W:$D(^UTILITY("DIQ1",$J,63.04,DA,561)) ^(561) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Uric acid"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,11)) ^(11) K DIP K:DN Y
 D T Q:'DN  D N D N D N:$X>0 Q:'DN  W ?0 W "A D D I T I O N A L"
 D N:$X>0 Q:'DN  W ?0 W "C H E M I S T R Y :"
 D N:$X>39 Q:'DN  W ?39 W "U R I N E "
 D N:$X>0 Q:'DN  W ?0 W "Salicylate"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,45)) ^(45) K DIP K:DN Y
 D N:$X>39 Q:'DN  W ?39 W "UR Glucose"
 D N:$X>69 Q:'DN  W ?69 W:$D(^UTILITY("DIQ1",$J,63.04,DA,690)) ^(690) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "T-4"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,771)) ^(771) K DIP K:DN Y
 D N:$X>39 Q:'DN  W ?39 W "UR Protein"
 D N:$X>69 Q:'DN  W ?69 W:$D(^UTILITY("DIQ1",$J,63.04,DA,691)) ^(691) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "T-3"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,738)) ^(738) K DIP K:DN Y
 D N:$X>39 Q:'DN  W ?39 W "RBC/HPF"
 D N:$X>69 Q:'DN  W ?69 W:$D(^UTILITY("DIQ1",$J,63.04,DA,694)) ^(694) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "TSH"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,741)) ^(741) K DIP K:DN Y
 D N:$X>39 Q:'DN  W ?39 W "WBC/HPF"
 D N:$X>69 Q:'DN  W ?69 W:$D(^UTILITY("DIQ1",$J,63.04,DA,693)) ^(693) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Sodium"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,5)) ^(5) K DIP K:DN Y
 D N:$X>39 Q:'DN  W ?39 W "Granular/cast/lpf"
 D N:$X>69 Q:'DN  W ?69 W:$D(^UTILITY("DIQ1",$J,63.04,DA,703)) ^(703) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Choloride"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,7)) ^(7) K DIP K:DN Y
 D N:$X>39 Q:'DN  W ?39 W "WBC/CASTS/LPF"
 D N:$X>69 Q:'DN  W ?69 W:$D(^UTILITY("DIQ1",$J,63.04,DA,700)) ^(700) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Bicarbonate"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,454)) ^(454) K DIP K:DN Y
 D N:$X>39 Q:'DN  W ?39 W "Creatinine Clearance"
 D N:$X>69 Q:'DN  W ?69 W:$D(^UTILITY("DIQ1",$J,63.04,DA,96)) ^(96) K DIP K:DN Y
 D T Q:'DN  D N D N D N:$X>0 Q:'DN  W ?0 W "H E M A T O L O G Y :"
 D N:$X>0 Q:'DN  W ?0 W "WBC"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,384)) ^(384) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "HGB"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,386)) ^(386) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "HCT"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,387)) ^(387) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Neutrophil"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,468)) ^(468) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Bands"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,395)) ^(395) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Lymphs"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,396)) ^(396) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Monocytes"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,397)) ^(397) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Eosino"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,398)) ^(398) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Baso"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,399)) ^(399) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Platelet"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,649)) ^(649) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Reticulocytes"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,428)) ^(428) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Westergren ESR"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,469)) ^(469) K DIP K:DN Y
 G ^MCARORL2
