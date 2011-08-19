ONCOX7 ; GENERATED FROM 'ONCOX7' PRINT TEMPLATE (#848) ; 03/11/05 ; (FILE 165.5, MARGIN=132)
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
 I $D(DXS)<9 M DXS=^DIPT(848,"DXS")
 S I(0)="^ONCO(165.5,",J(0)=165.5
 D T Q:'DN  D N W ?0 X DXS(1,9) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>1 Q:'DN  W ?1 W "Dx/Stging/Palliative Proc:  "
 S X=$G(^ONCO(165.5,D0,3)) S Y=$P(X,U,31) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 S X=$G(^ONCO(165.5,D0,3)) D N:$X>59 Q:'DN  W ?59 S Y=$P(X,U,27) S Y(0)=Y D NCDSOT^ONCODSR W $E(Y,1,30)
 D N:$X>1 Q:'DN  W ?1 W "Surgery of Primary Site Date:  "
 S X=$G(^ONCO(165.5,D0,3)) S Y=$P(X,U,1) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 D N:$X>59 Q:'DN  W ?59 X DXS(2,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>59 Q:'DN  W ?59 X DXS(3,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>1 Q:'DN  W ?1 W "Surgical Approach:  "
 X DXS(4,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>1 Q:'DN  W ?1 W "Reconstruction/Restoration:  "
 X DXS(5,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>6 Q:'DN  W ?6 W "- Text Rx-Surgery/No Surgery:  "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=14,J(1)=165.5108 F D1=0:0 Q:$O(^ONCO(165.5,D0,14,D1))'>0  S D1=$O(^(D1)) D:$X>39 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^ONCO(165.5,D0,14,D1,0)) S DIWL=40,DIWR=130 D ^DIWP
 Q
A1R ;
 D 0^DIWW
 D ^DIWW
 D N:$X>6 Q:'DN  W ?6 W "- Text Rx-Other Cancer Directed Surgery:  "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=21,J(1)=165.5115 F D1=0:0 Q:$O(^ONCO(165.5,D0,21,D1))'>0  S D1=$O(^(D1)) D:$X>50 T Q:'DN  D B1
 G B1R
B1 ;
 S X=$G(^ONCO(165.5,D0,21,D1,0)) S DIWL=51,DIWR=130 D ^DIWP
 Q
B1R ;
 D 0^DIWW
 D ^DIWW
 D N:$X>1 Q:'DN  W ?1 W "Surgical Margins: "
 S X=$G(^ONCO(165.5,D0,3)) S Y=$P(X,U,28) S Y(0)=Y S FILNUM=165.5,FLDNUM=59 D SOC^ONCOOT W $E(Y,1,30)
 D N:$X>59 Q:'DN  W ?59 W "Reason for No Surgery:  "
 X DXS(6,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>1 Q:'DN  W ?1 W "Radiation Date:  "
 S X=$G(^ONCO(165.5,D0,3)) S Y=$P(X,U,4) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 D N:$X>39 Q:'DN  W ?39 X DXS(7,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 S X=$G(^ONCO(165.5,D0,3)) D N:$X>59 Q:'DN  W ?59 S Y=$P(X,U,6) W:Y]"" $S($D(DXS(14,Y)):DXS(14,Y),1:Y)
 D N:$X>1 Q:'DN  W ?1 W "Regional Dose:  "
 S X=$G(^ONCO(165.5,D0,"THY1")) S Y=$P(X,U,43) S Y(0)=Y S Y=$S(Y="00000":"Radiation tx not administered",Y=88888:"NA, brachytherapy/radioisotopes administered",Y=99999:"Dose unknown/unknown if administered",1:Y) W $E(Y,1,12)
 D N:$X>31 Q:'DN  W ?31 W "Regional Treatment Modality:  "
 S X=$G(^ONCO(165.5,D0,"BLA2")) S Y=$P(X,U,18) S Y(0)=Y S Y=$P($G(^ONCO(166.13,+Y,0)),U,2) W $E(Y,1,50)
 D N:$X>1 Q:'DN  W ?1 W "Reason for No Radiation:  "
 X DXS(8,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>7 Q:'DN  W ?7 W "Sequence:  "
 X DXS(9,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 S I(1)=6,J(1)=165.52 F D1=0:0 Q:$O(^ONCO(165.5,D0,6,D1))'>0  X:$D(DSC(165.52)) DSC(165.52) S D1=$O(^(D1)) Q:D1'>0  D:$X>20 T Q:'DN  D C1
 G C1R
C1 ;
 D N:$X>14 Q:'DN  W ?14 W "Radiation Treatment - (either radiation or prophylactic)  "
 D N:$X>16 Q:'DN  W ?16 W "Target Place:  "
 X DXS(10,9) K DIP K:DN Y W X
 W "    Target Site:  "
 X DXS(11,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 W "    Radiation Source:  "
 X DXS(12,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>16 Q:'DN  W ?16 W "Total due to target:  "
 S X=$G(^ONCO(165.5,D0,6,D1,0)) S Y=$P(X,U,4) W:Y]"" $J(Y,3,0)
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
 S X=$G(^ONCO(165.5,D0,6,D1,1,D2,0)) S DIWL=28,DIWR=130 D ^DIWP
 Q
A2R ;
 D 0^DIWW
 D ^DIWW
 D T Q:'DN  D N D N:$X>1 Q:'DN  W ?1 W "  "
 Q
C1R ;
 D N:$X>6 Q:'DN  W ?6 W "- Text Rx-Rad (BEAM):  "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=15,J(1)=165.5109 F D1=0:0 Q:$O(^ONCO(165.5,D0,15,D1))'>0  S D1=$O(^(D1)) D:$X>31 T Q:'DN  D D1
 G D1R
D1 ;
 S X=$G(^ONCO(165.5,D0,15,D1,0)) S DIWL=32,DIWR=130 D ^DIWP
 Q
D1R ;
 D 0^DIWW
 D ^DIWW
 D N:$X>6 Q:'DN  W ?6 W "- Text Rx-Rad-Other:  "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=16,J(1)=165.53 F D1=0:0 Q:$O(^ONCO(165.5,D0,16,D1))'>0  S D1=$O(^(D1)) D:$X>30 T Q:'DN  D E1
 G E1R
E1 ;
 S X=$G(^ONCO(165.5,D0,16,D1,0)) S DIWL=31,DIWR=130 D ^DIWP
 Q
E1R ;
 D 0^DIWW
 D ^DIWW
 D T Q:'DN  W ?2 W "Radiation Therapy to CNS DAte:  "
 S X=$G(^ONCO(165.5,D0,3)) S Y=$P(X,U,8) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 D N:$X>39 Q:'DN  W ?39 X DXS(13,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 S X=$G(^ONCO(165.5,D0,3)) D N:$X>59 Q:'DN  W ?59 S Y=$P(X,U,10) W:Y]"" $S($D(DXS(15,Y)):DXS(15,Y),1:Y)
 K Y K DIWF
 Q
HEAD ;
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
