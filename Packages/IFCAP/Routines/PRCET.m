PRCET ; GENERATED FROM 'PRCE DAILY RECORD EDIT' PRINT TEMPLATE (#344) ; 10/27/00 ; (FILE 424.1, MARGIN=80)
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
 I $D(DXS)<9 M DXS=^DIPT(344,"DXS")
 S I(0)="^PRC(424.1,",J(0)=424.1
 D N:$X>21 Q:'DN  W ?21 W "DAILY RECORD:"
 S X=$G(^PRC(424.1,D0,0)) W ?36,$E($P(X,U,1),1,20)
 D N:$X>13 Q:'DN  W ?13 W "AUTHORIZATION NUMBER:"
 W ?36 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^PRC(424,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,15)
 D N:$X>10 Q:'DN  W ?10 W "AUTHORIZATION REFERENCE:"
 W ?36 X DXS(1,9.2) S X=$P(DIP(101),U,10) S D0=I(0,0) K DIP K:DN Y W X
 D N:$X>12 Q:'DN  W ?12 W "AUTHORIZATION BALANCE:"
 W ?36 W "$"
 W ?39 X DXS(2,9.2) S X=$P(DIP(101),U,5) S D0=I(0,0) K DIP K:DN Y W:X'?."*" $J(X,12,2)
 D N:$X>7 Q:'DN  W ?7 W "OBLIGATION SERVICE BALANCE:"
 W ?36 W "$"
 W ?39 X DXS(3,9) K DIP K:DN Y W:X'?."*" $J(X,12,2)
 D T Q:'DN  D N W ?0 W "--------------------------------------------------------------------------------"
 D N:$X>0 Q:'DN  W ?0 W "1.)"
 D N:$X>15 Q:'DN  W ?15 W "AMOUNT:"
 W ?24 S DIP(1)=$S($D(^PRC(424.1,D0,0)):^(0),1:"") S X=$P(DIP(1),U,3)/-1 K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W "2.)"
 D N:$X>5 Q:'DN  W ?5 W "VENDOR INVOICE #:"
 S X=$G(^PRC(424.1,D0,0)) W ?24,$E($P(X,U,6),1,15)
 D N:$X>0 Q:'DN  W ?0 W "3.)"
 D N:$X>12 Q:'DN  W ?12 W "REFERENCE:"
 W ?24,$E($P(X,U,8),1,15)
 D N:$X>0 Q:'DN  W ?0 W "4.)"
 D N:$X>13 Q:'DN  W ?13 W "COMMENTS:"
 S X=$G(^PRC(424.1,D0,1)) D T Q:'DN  W ?24,$E($P(X,U,1),1,245)
 D T Q:'DN  W ?0 W "--------------------------------------------------------------------------------"
 D T Q:'DN  D N D N:$X>6 Q:'DN  W ?6 W "LAST EDITED BY :"
 S X=$G(^PRC(424.1,D0,0)) W ?24 S Y=$P(X,U,10) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D N:$X>10 Q:'DN  W ?10 W "LAST EDITED: "
 W ?25 S Y=$P(X,U,4) D DT
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
