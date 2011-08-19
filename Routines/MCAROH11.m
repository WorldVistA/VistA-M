MCAROH11 ; GENERATED FROM 'MCARHOLT1' PRINT TEMPLATE (#979) ; 10/04/96 ; (continued)
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
 S X=$G(^MCAR(691.6,D0,6)) D N:$X>39 Q:'DN  W ?39 S Y=$P(X,U,1) W:Y]"" $J(Y,8,0)
 D N:$X>48 Q:'DN  W ?48 W "BLOCKED APCS"
 S X=$G(^MCAR(691.6,D0,4)) D N:$X>3 Q:'DN  W ?3 S Y=$P(X,U,15) W:Y]"" $J(Y,8,0)
 D N:$X>12 Q:'DN  W ?12 W "COUPLETS"
 D N:$X>39 Q:'DN  W ?39 S Y=$P(X,U,26) W:Y]"" $J(Y,8,0)
 D N:$X>48 Q:'DN  W ?48 W "COUPLETS"
 D N:$X>3 Q:'DN  W ?3 S Y=$P(X,U,17) W:Y]"" $J(Y,8,0)
 D N:$X>12 Q:'DN  W ?12 W "BEATS IN RUNS"
 S X=$G(^MCAR(691.6,D0,6)) D N:$X>39 Q:'DN  W ?39 S Y=$P(X,U,2) W:Y]"" $J(Y,8,0)
 D N:$X>48 Q:'DN  W ?48 W "RUNS SV-T"
 S X=$G(^MCAR(691.6,D0,4)) D N:$X>3 Q:'DN  W ?3 S Y=$P(X,U,18) W:Y]"" $J(Y,8,0)
 D N:$X>12 Q:'DN  W ?12 W "BEATS IN LONGEST RUN"
 S X=$G(^MCAR(691.6,D0,6)) D N:$X>39 Q:'DN  W ?39 S Y=$P(X,U,3) W:Y]"" $J(Y,8,0)
 D N:$X>48 Q:'DN  W ?48 W "BEATS IN RUNS"
 S X=$G(^MCAR(691.6,D0,4)) D N:$X>3 Q:'DN  W ?3 S Y=$P(X,U,19) W:Y]"" $J(Y,8,0)
 D N:$X>12 Q:'DN  W ?12 W "BEATS FASTEST RUN AT"
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,20) W:Y]"" $J(Y,3,0)
 D N:$X>37 Q:'DN  W ?37 W "BPM"
 S X=$G(^MCAR(691.6,D0,6)) D N:$X>40 Q:'DN  W ?40 S Y=$P(X,U,4) W:Y]"" $J(Y,7,0)
 D N:$X>48 Q:'DN  W ?48 W "BEATS IN LONGEST RUN"
 D N:$X>39 Q:'DN  W ?39 S Y=$P(X,U,5) W:Y]"" $J(Y,8,0)
 D N:$X>48 Q:'DN  W ?48 W "BTS FASTEST RUN AT"
 D N:$X>67 Q:'DN  W ?67 S Y=$P(X,U,6) W:Y]"" $J(Y,3,0)
 D N:$X>71 Q:'DN  W ?71 W "BPM"
 D T Q:'DN  D N D N:$X>7 Q:'DN  W ?7 X DXS(4,9) K DIP K:DN Y W X
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
