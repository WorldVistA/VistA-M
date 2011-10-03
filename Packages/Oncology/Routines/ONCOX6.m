ONCOX6 ; GENERATED FROM 'ONCOX6' PRINT TEMPLATE (#847) ; 08/02/04 ; (FILE 165.5, MARGIN=132)
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
 I $D(DXS)<9 M DXS=^DIPT(847,"DXS")
 S I(0)="^ONCO(165.5,",J(0)=165.5
 D T Q:'DN  D N W ?0 X DXS(1,9) K DIP K:DN Y W X
 D N:$X>29 Q:'DN  W ?29 W " "
 D N:$X>1 Q:'DN  W ?1 W "Clinical TNM:  "
 D N:$X>16 Q:'DN  W ?16 S STGIND="C",X=$$TNMOUT^ONCOTNO(D0) W $J(X,15) K Y(165.5,37)
 D N:$X>54 Q:'DN  W ?54 W "Pathologic TNM:  "
 D N:$X>71 Q:'DN  W ?71 S STGIND="P",X=$$TNMOUT^ONCOTNO(D0) W $J(X,15) K Y(165.5,89.1)
 D N:$X>1 Q:'DN  W ?1 W "Clinical T:     "
 S X=$G(^ONCO(165.5,D0,2)) D N:$X>17 Q:'DN  W ?17 S Y=$P(X,U,25) S Y(0)=Y S ONCOX="T",STGIND="C" D OT^ONCOTNM W $E(Y,1,30)
 D N:$X>54 Q:'DN  W ?54 W "Pathologic T:    "
 S X=$G(^ONCO(165.5,D0,2.1)) D N:$X>72 Q:'DN  W ?72 S Y=$P(X,U,1) S Y(0)=Y S ONCOX="T",STGIND="P" D OT^ONCOTNM W $E(Y,1,30)
 D N:$X>1 Q:'DN  W ?1 W "Clinical N:     "
 S X=$G(^ONCO(165.5,D0,2)) D N:$X>17 Q:'DN  W ?17 S Y=$P(X,U,26) S Y(0)=Y S ONCOX="N",STGIND="C" D OT^ONCOTNM W $E(Y,1,30)
 D N:$X>54 Q:'DN  W ?54 W "Pathologic N:    "
 S X=$G(^ONCO(165.5,D0,2.1)) D N:$X>72 Q:'DN  W ?72 S Y=$P(X,U,2) S Y(0)=Y S ONCOX="N",STGIND="P" D OT^ONCOTNM W $E(Y,1,30)
 D N:$X>1 Q:'DN  W ?1 W "Clinical M:     "
 S X=$G(^ONCO(165.5,D0,2)) D N:$X>17 Q:'DN  W ?17 S Y=$P(X,U,27) S Y(0)=Y S ONCOX="M",STGIND="C" D OT^ONCOTNM W $E(Y,1,30)
 D N:$X>54 Q:'DN  W ?54 W "Pathologic M:     "
 S X=$G(^ONCO(165.5,D0,2.1)) D N:$X>72 Q:'DN  W ?72 S Y=$P(X,U,3) S Y(0)=Y S ONCOX="M",STGIND="P" D OT^ONCOTNM W $E(Y,1,30)
 D N:$X>1 Q:'DN  W ?1 W "Clinical Stage Group:  "
 S X=$G(^ONCO(165.5,D0,2)) D N:$X>27 Q:'DN  W ?27 S Y=$P(X,U,20) S Y(0)=Y S X="" D OT^ONCOTNS W $E(Y,1,30)
 D N:$X>54 Q:'DN  W ?54 W "Pathologic Stage Group:  "
 S X=$G(^ONCO(165.5,D0,2.1)) D N:$X>80 Q:'DN  W ?80 S Y=$P(X,U,4) S Y(0)=Y S X="" D OT^ONCOTNS W $E(Y,1,30)
 D N:$X>1 Q:'DN  W ?1 W "Staged By (Clin):  "
 S X=$G(^ONCO(165.5,D0,3)) D N:$X>20 Q:'DN  W ?20 S Y=$P(X,U,32) W:Y]"" $S($D(DXS(4,Y)):DXS(4,Y),1:Y)
 D N:$X>54 Q:'DN  W ?54 W "Staged By (Path):  "
 S X=$G(^ONCO(165.5,D0,2.1)) D N:$X>73 Q:'DN  W ?73 S Y=$P(X,U,5) W:Y]"" $S($D(DXS(5,Y)):DXS(5,Y),1:Y)
 D N:$X>1 Q:'DN  W ?1 W "Other Stage:  "
 S X=$G(^ONCO(165.5,D0,2)) D N:$X>17 Q:'DN  W ?17 S Y=$P(X,U,21) S Y=$S(Y="":Y,$D(^ONCO(164.3,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 D N:$X>1 Q:'DN  W ?1 W "Size of Tumor: "
 D N:$X>16 Q:'DN  W ?16 S Y=$P(X,U,9) S Y(0)=Y D STOT^ONCOOT W $J(Y,7)
 D N:$X>1 Q:'DN  W ?1 W "Positive nodes: "
 S X=$G(^ONCO(165.5,D0,2)) D N:$X>19 Q:'DN  W ?19 S Y=$P(X,U,12) S Y(0)=Y D RNP^ONCOOT W $J(Y,3)
 D N:$X>49 Q:'DN  W ?49 W "Peripheral Blood Inv.: "
 S X=$G(^ONCO(165.5,D0,24)) D N:$X>72 Q:'DN  W ?72 S Y=$P(X,U,5) W:Y]"" $S($D(DXS(6,Y)):DXS(6,Y),1:Y)
 D N:$X>1 Q:'DN  W ?1 W "Nodes Examined: "
 S X=$G(^ONCO(165.5,D0,2)) D N:$X>19 Q:'DN  W ?19 S Y=$P(X,U,13) S Y(0)=Y D RNE^ONCOOT W $J(Y,3)
 D N:$X>49 Q:'DN  W ?49 W "Associated with HIV: "
 S X=$G(^ONCO(165.5,D0,2)) D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,23) W:Y]"" $S($D(DXS(7,Y)):DXS(7,Y),1:Y)
 D N:$X>1 Q:'DN  W ?1 W "Extension:  "
 D N:$X>14 Q:'DN  W ?14 X DXS(2,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>49 Q:'DN  W ?49 W "Metastasis-1:  "
 S X=$G(^ONCO(165.5,D0,2)) S Y=$P(X,U,14) W:Y]"" $S($D(DXS(8,Y)):DXS(8,Y),1:Y)
 D N:$X>1 Q:'DN  W ?1 W "Lymph Nodes:  "
 D N:$X>15 Q:'DN  W ?15 X DXS(3,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>49 Q:'DN  W ?49 W "Metastasis-2:  "
 S X=$G(^ONCO(165.5,D0,2)) S Y=$P(X,U,15) W:Y]"" $S($D(DXS(9,Y)):DXS(9,Y),1:Y)
 D N:$X>1 Q:'DN  W ?1 W "General Summary Stage:  "
 D N:$X>25 Q:'DN  W ?25 S Y=$P(X,U,17) W:Y]"" $S($D(DXS(10,Y)):DXS(10,Y),1:Y)
 D N:$X>49 Q:'DN  W ?49 W "Metastasis-3:  "
 S Y=$P(X,U,16) W:Y]"" $S($D(DXS(11,Y)):DXS(11,Y),1:Y)
 K Y
 Q
HEAD ;
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
