MCARORE1 ; GENERATED FROM 'MCRHPHYS2' PRINT TEMPLATE (#1011) ; 10/04/96 ; (continued)
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
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,34) W:Y]"" $S($D(DXS(21,Y)):DXS(21,Y),1:Y)
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,35) W:Y]"" $S($D(DXS(22,Y)):DXS(22,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "TMJ:"
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,38) W:Y]"" $S($D(DXS(23,Y)):DXS(23,Y),1:Y)
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,39) W:Y]"" $S($D(DXS(24,Y)):DXS(24,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "COSTOCHONDRAL:"
 S X=$G(^MCAR(701,D0,1)) D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,11) W:Y]"" $S($D(DXS(25,Y)):DXS(25,Y),1:Y)
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,12) W:Y]"" $S($D(DXS(26,Y)):DXS(26,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "SACROILIAC:"
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,13) W:Y]"" $S($D(DXS(27,Y)):DXS(27,Y),1:Y)
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,14) W:Y]"" $S($D(DXS(28,Y)):DXS(28,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "HIP:"
 S X=$G(^MCAR(701,D0,5)) D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,40) W:Y]"" $S($D(DXS(29,Y)):DXS(29,Y),1:Y)
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,41) W:Y]"" $S($D(DXS(30,Y)):DXS(30,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "KNEE:"
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,42) W:Y]"" $S($D(DXS(31,Y)):DXS(31,Y),1:Y)
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,43) W:Y]"" $S($D(DXS(32,Y)):DXS(32,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "ANKLE:"
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,44) W:Y]"" $S($D(DXS(33,Y)):DXS(33,Y),1:Y)
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,45) W:Y]"" $S($D(DXS(34,Y)):DXS(34,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "MTP:"
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,46) W:Y]"" $S($D(DXS(35,Y)):DXS(35,Y),1:Y)
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,47) W:Y]"" $S($D(DXS(36,Y)):DXS(36,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "TOES-PIP:"
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,48) W:Y]"" $S($D(DXS(37,Y)):DXS(37,Y),1:Y)
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,49) W:Y]"" $S($D(DXS(38,Y)):DXS(38,Y),1:Y)
 D N:$X>24 Q:'DN  W ?24 W "CERVICAL SPINE:"
 D N:$X>44 Q:'DN  W ?44 S Y=$P(X,U,50) W:Y]"" $S($D(DXS(39,Y)):DXS(39,Y),1:Y)
 D N:$X>24 Q:'DN  W ?24 W "THORACIC SPINE:"
 S X=$G(^MCAR(701,D0,1)) D N:$X>44 Q:'DN  W ?44 S Y=$P(X,U,15) W:Y]"" $S($D(DXS(40,Y)):DXS(40,Y),1:Y)
 D N:$X>24 Q:'DN  W ?24 W "LUMBAR SPINE:"
 S X=$G(^MCAR(701,D0,5)) D N:$X>44 Q:'DN  W ?44 S Y=$P(X,U,51) W:Y]"" $S($D(DXS(41,Y)):DXS(41,Y),1:Y)
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
