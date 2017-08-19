TIUCTM ; GENERATED FROM 'TIU HT TITLE MAPPINGS' PRINT TEMPLATE (#1561) ; 08/18/17 ; (FILE 8925.1, MARGIN=80)
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
 S I(0)="^TIU(8925.1,",J(0)=8925.1
 S X=$G(^TIU(8925.1,D0,0)) W ?0,$E($P(X,U,1),1,60)
 D N:$X>62 Q:'DN  W ?62 S Y=$P(X,U,7) S Y=$S(Y="":Y,$D(^TIU(8925.6,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,17)
 S X=$G(^TIU(8925.1,D0,15)) D T Q:'DN  W ?2 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^TIU(8926.1,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,90)
 K Y
 Q
HEAD ;
 W !,?0,"NAME",?62,"STATUS"
 W !,?2,"VHA ENTERPRISE STANDARD TITLE"
 W !,"--------------------------------------------------------------------------------",!!
