ONCOY50 ; GENERATED FROM 'ONCOY50' PRINT TEMPLATE (#860) ; 04/10/06 ; (FILE 165.5, MARGIN=80)
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
 I $D(DXS)<9 M DXS=^DIPT(860,"DXS")
 S I(0)="^ONCO(165.5,",J(0)=165.5
 D T Q:'DN  D N W ?0 W "* PATIENT IDENTIFICATION *"
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Patient Name..................:"
 S X=$G(^ONCO(165.5,D0,0)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,2) S C=$P(^DD(165.5,.02,0),U,2) D Y^DIQ:Y S C="," W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Alias.........................:"
 D N:$X>34 Q:'DN  W ?34 X DXS(1,9.2) S X=DIP(101) S D0=I(0,0) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Address at Dx.................:"
 D N:$X>34 Q:'DN  W ?34 X DXS(2,9) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "City/town at Dx...............:"
 D N:$X>34 Q:'DN  W ?34 X DXS(3,9) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "State at Dx...................:"
 D N:$X>34 Q:'DN  W ?34 X DXS(4,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Postal Code at Dx.............:"
 S X=$G(^ONCO(165.5,D0,1)) D N:$X>34 Q:'DN  W ?34,$E($P(X,U,2),1,9)
 D N:$X>2 Q:'DN  W ?2 W "County at Dx..................:"
 D N:$X>34 Q:'DN  W ?34 X DXS(5,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Accession Year................:"
 S X=$G(^ONCO(165.5,D0,0)) D N:$X>34 Q:'DN  W ?34,$E($P(X,U,7),1,4)
 D N:$X>2 Q:'DN  W ?2 W "Accession/Sequence Number.....:"
 D N:$X>34 Q:'DN  W ?34 X ^DD(165.5,.061,9.3) S X=$E(Y(165.5,.061,5),Y(165.5,.061,6),X) S Y=X,X=Y(165.5,.061,4),X=X_Y_"/"_$P(Y(165.5,.061,1),U,6) W $E(X,1,13) K Y(165.5,.061)
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
