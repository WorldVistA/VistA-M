ONCOY54 ; GENERATED FROM 'ONCOY54' PRINT TEMPLATE (#812) ; 04/10/06 ; (FILE 165.5, MARGIN=80)
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
 I $D(DXS)<9 M DXS=^DIPT(812,"DXS")
 S I(0)="^ONCO(165.5,",J(0)=165.5
 D T Q:'DN  D N W ?0 W "* FIRST COURSE OF TREATMENT *"
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "First Course of Treatment Date:"
 D N:$X>34 Q:'DN  W ?34 S X="" D DFC^ONCOCOM W $E(X,1,10) K Y(165.5,49)
 D N:$X>2 Q:'DN  W ?2 W "Date of No Treatment..........:"
 S X=$G(^ONCO(165.5,D0,2.1)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,11) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Date First Surgical Procedure.:"
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,38) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Surgery of Primary............:"
 S X=$G(^ONCO(165.5,D0,3)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,1) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,29) S Y(0)=Y S FIELD=58.6 D SPSOT^ONCOSUR W $E(Y,1,34)
 D N:$X>2 Q:'DN  W ?2 W "Surgery of Primary @Fac.......:"
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,8) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,30) S Y(0)=Y S FIELD=58.7 D SPSOT^ONCOSUR W $E(Y,1,34)
 D N:$X>2 Q:'DN  W ?2 W "Surgical Margins..............:"
 S X=$G(^ONCO(165.5,D0,3)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,28) S Y(0)=Y S FILNUM=165.5,FLDNUM=59 D SOC^ONCOOT W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Scope of LN Surgery...........:"
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,22) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,31) W:Y]"" $S($D(DXS(3,Y)):DXS(3,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Scope of LN Surgery @Fac......:"
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,23) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,32) W:Y]"" $S($D(DXS(4,Y)):DXS(4,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Surg Proc/Other Site..........:"
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,24) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,33) W:Y]"" $S($D(DXS(5,Y)):DXS(5,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Surg Proc/Other Site @Fac.....:"
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,25) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,34) W:Y]"" $S($D(DXS(6,Y)):DXS(6,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Reason No Surgery of Primary..:"
 D N:$X>34 Q:'DN  W ?34 X DXS(1,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Radiation.....................:"
 S X=$G(^ONCO(165.5,D0,3)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,4) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 S X=$G(^ONCO(165.5,D0,3)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,6) W:Y]"" $S($D(DXS(7,Y)):DXS(7,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Radiation @Fac................:"
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,13) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,12) W:Y]"" $S($D(DXS(8,Y)):DXS(8,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Radiation/Surgery Sequence....:"
 D N:$X>34 Q:'DN  W ?34 X DXS(2,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Regional Dose: cGy............:"
 S X=$G(^ONCO(165.5,D0,"THY1")) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,43) S Y(0)=Y S Y=$S(Y="00000":"Radiation tx not administered",Y=88888:"NA, brachytherapy/radioisotopes administered",Y=99999:"Dose unknown/unknown if administered",1:Y) W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Regional Treatment Modality...:"
 S X=$G(^ONCO(165.5,D0,"BLA2")) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,18) S Y(0)=Y S Y=$P($G(^ONCO(166.13,+Y,0)),U,2) W $E(Y,1,30)
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
