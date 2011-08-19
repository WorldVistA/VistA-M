ONCOXA1 ; GENERATED FROM 'ONCOXA1' PRINT TEMPLATE (#827) ; 08/13/03 ; (FILE 165.5, MARGIN=80)
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
 I $D(DXS)<9 M DXS=^DIPT(827,"DXS")
 S I(0)="^ONCO(165.5,",J(0)=165.5
 D N:$X>14 Q:'DN  W ?14 W "**********  Print Abstract-Brief  **********"
 D T Q:'DN  W ?68 S X=DT S Y=X K DIP K:DN Y S Y=X D DT
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 S X=$P($G(^ONCO(165.5,D0,2)),U),X=$S(X="":"",1:"C"_$E(X,3,4)_"."_$E(X,5)) W $E(X,1,5) K Y(165.5,20.1)
 D N:$X>9 Q:'DN  W ?9 X DXS(1,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Reporting Hospital: "
 S X=$G(^ONCO(165.5,D0,0)) D N:$X>25 Q:'DN  W ?25 S Y=$P(X,U,3) S Y(0)=Y I Y'="" S Y=$P($G(^ONCO(160.19,Y,0)),U,2) W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Date of First Contact: "
 S X=$G(^ONCO(165.5,D0,0)) D N:$X>25 Q:'DN  W ?25 S Y=$P(X,U,35) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,10)
 D N:$X>2 Q:'DN  W ?2 W "Histology: "
 W ?15 X DXS(2,9) K DIP K:DN Y
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 X DXS(3,9) K DIP K:DN Y W X
 D N:$X>39 Q:'DN  W ?39 W "Alias: "
 W ?48 X DXS(4,9.2) S X=DIP(101) S D0=I(0,0) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Acc/Seq Number: "
 D N:$X>27 Q:'DN  W ?27 X ^DD(165.5,.061,9.3) S X=$E(Y(165.5,.061,5),Y(165.5,.061,6),X) S Y=X,X=Y(165.5,.061,4),X=X_Y_"/"_$P(Y(165.5,.061,1),U,6) W $J(X,14) K Y(165.5,.061)
 D N:$X>2 Q:'DN  W ?2 W "Medical Record Number: "
 D N:$X>28 Q:'DN  W ?28 X DXS(5,9.2) S X=DIP(101) S D0=I(0,0) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Telephone:"
 D N:$X>28 Q:'DN  W ?28 X DXS(6,9.2) S X=DIP(101) S D0=I(0,0) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Type of Reporting Source: "
 S X=$G(^ONCO(165.5,D0,0)) S Y=$P(X,U,10) W:Y]"" $S($D(DXS(9,Y)):DXS(9,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Class of Case: "
 D N:$X>28 Q:'DN  W ?28 X DXS(7,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Marital Status at Dx: "
 D N:$X>28 Q:'DN  W ?28 X DXS(8,9.2) S DIP(4)=$G(X) S X=1,X=$P(DIP(3),DIP(4),X) K DIP K:DN Y W X
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
