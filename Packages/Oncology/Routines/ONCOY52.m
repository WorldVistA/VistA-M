ONCOY52 ; GENERATED FROM 'ONCOY52' PRINT TEMPLATE (#862) ; 12/17/21 ; (FILE 165.5, MARGIN=80)
 G BEGIN
N W !
T W:$X ! I '$D(DIOT(2)),DN,$D(IOSL),$S('$D(DIWF):1,$P(DIWF,"B",2):$P(DIWF,"B",2),1:1)+$Y'<IOSL,$D(^UTILITY($J,1))#2,^(1)?1U1P1E.E X ^(1)
 S DISTP=DISTP+1,DILCT=DILCT+1 D:'(DISTP#100) CSTP^DIO2
 Q
DT I $G(DUZ("LANG"))>1,Y W $$OUT^DIALOGU(Y,"DD") Q
 X ^DD("DD")
 W Y Q
M D @DIXX
 Q
BEGIN ;
 S:'$D(DN) DN=1 S DISTP=$G(DISTP),DILCT=$G(DILCT)
 I $D(DXS)<9 M DXS=^DIPT(862,"DXS")
 S I(0)="^ONCO(165.5,",J(0)=165.5
 D T Q:'DN  D N W ?0 W "* CANCER IDENTIFICATION *"
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Date Dx.......................:"
 S X=$G(^ONCO(165.5,D0,0)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,16) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,10)
 D N:$X>2 Q:'DN  W ?2 W "Class of Case.................:"
 S X=$G(^ONCO(165.5,D0,0)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,4) S Y(0)=Y S:Y'="" Y=$P(^ONCO(165.3,Y,0),U,1)_" "_$P(^ONCO(165.3,Y,0),U,2) W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Histology (ICD-O-3)...........:"
 D N:$X>34 Q:'DN  W ?34 X DXS(1,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Grade Clinical................:"
 S X=$G(^ONCO(165.5,D0,2.3)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,12) S Y(0)=Y D OT^ONCSCHMG W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Grade Pathological............:"
 S X=$G(^ONCO(165.5,D0,2.3)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,13) S Y(0)=Y D OT^ONCSCHMG W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Grade Post Therapy Clin (yc)..:"
 S X=$G(^ONCO(165.5,D0,2.3)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,15) S Y(0)=Y D OT^ONCSCHMG W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Grade Post Therapy Path (yp)..:"
 S X=$G(^ONCO(165.5,D0,2.3)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,14) S Y(0)=Y D OT^ONCSCHMG W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "AFIP/JPC Submission...........:"
 S X=$G(^ONCO(165.5,D0,0)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,21) W:Y]"" $E($$SET^DIQ(165.5,83,Y),1,7)
 D N:$X>2 Q:'DN  W ?2 W "Dx Confirmation...............:"
 D N:$X>34 Q:'DN  W ?34 X DXS(2,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Facility Referred From........:"
 D N:$X>34 Q:'DN  W ?34 N DIERR X DXS(3,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Facility Referred To..........:"
 D N:$X>34 Q:'DN  W ?34 N DIERR X DXS(4,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Presentation at Cancer Conf...:"
 S X=$G(^ONCO(165.5,D0,0)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,26) W:Y]"" $E($$SET^DIQ(165.5,120,Y),1,26)
 D N:$X>2 Q:'DN  W ?2 W "Date of Cancer Conf...........:"
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,27) S Y(0)=Y D DATEOT^ONCOPCE W $E(Y,1,30)
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
