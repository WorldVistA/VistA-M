ONCOY53 ; GENERATED FROM 'ONCOY53' PRINT TEMPLATE (#863) ; 12/17/21 ; (FILE 165.5, MARGIN=80)
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
 S I(0)="^ONCO(165.5,",J(0)=165.5
 D T Q:'DN  D N W ?0 W "* STAGE OF DISEASE AT DIAGNOSIS *"
 D N:$X>2 Q:'DN  W ?2 W "TNM Clinical..................:"
 W ?35 N IEN S IEN=D0,STGIND="C" D TNMDSP^ONCSGA8U K DIP K:DN Y
 D N:$X>2 Q:'DN  W ?2 W "Stage Group Clinical..........:"
 S X=$G(^ONCO(165.5,D0,"AJCC8")) D N:$X>35 Q:'DN  W ?35,$E($P(X,U,5),1,15)
 D N:$X>2 Q:'DN  W ?2 W "Staged By (Clinical)..........:"
 S X=$G(^ONCO(165.5,D0,3)) D N:$X>35 Q:'DN  W ?35 S Y=$P(X,U,32) S Y(0)=Y S:Y'="" Y=$P(^ONCO(165.7,Y,0),U,1)_" "_$P(^ONCO(165.7,Y,0),U,2) W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "TNM Pathologic................:"
 W ?35 N IEN S IEN=D0,STGIND="P" D TNMDSP^ONCSGA8U K DIP K:DN Y
 D N:$X>2 Q:'DN  W ?2 W "Stage Group Pathologic........:"
 S X=$G(^ONCO(165.5,D0,"AJCC8")) D N:$X>35 Q:'DN  W ?35,$E($P(X,U,9),1,15)
 D N:$X>2 Q:'DN  W ?2 W "Staged By (Pathologic)........:"
 S X=$G(^ONCO(165.5,D0,2.1)) D N:$X>35 Q:'DN  W ?35 S Y=$P(X,U,5) S Y(0)=Y S:Y'="" Y=$P(^ONCO(165.7,Y,0),U,1)_" "_$P(^ONCO(165.7,Y,0),U,2) W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "TNM Post-Therapy (yc).........:"
 W ?35 N IEN S IEN=D0,STGIND="Y" D TNMDSP^ONCSGA8U K DIP K:DN Y
 D N:$X>2 Q:'DN  W ?2 W "TNM Post-Therapy (yp).........:"
 W ?35 N IEN S IEN=D0,STGIND="T" D TNMDSP^ONCSGA8U K DIP K:DN Y
 D N:$X>2 Q:'DN  W ?2 W "Stage Group Post-Therapy (yp).:"
 S X=$G(^ONCO(165.5,D0,"AJCC8")) D N:$X>35 Q:'DN  W ?35,$E($P(X,U,13),1,15)
 W ?52 N IEN S IEN=D0 D SSDI^ONCOPA4 K DIP K:DN Y
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
