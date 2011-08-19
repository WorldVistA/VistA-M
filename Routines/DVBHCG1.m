DVBHCG1 ; GENERATED FROM 'DVBHINQ PAT-HINQ COMP' PRINT TEMPLATE (#513) ; 03/30/98 ; (continued)
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
 W ! I $D(DVBEOD(2)),DVBEOD(2)?7N S Y=DVBEOD(2) X ^DD("DD") W ?1,Y K Y K DIP K:DN Y
 I $D(DVBRAD(2)),DVBRAD(2)?7N S Y=DVBRAD(2) X ^DD("DD") W ?15,Y K Y K DIP K:DN Y
 I $D(DVBBOS(2)) W ?34,DVBBOS(2) K DIP K:DN Y
 I $D(DVBCSVC(2)) W ?48,DVBCSVC(2) K DIP K:DN Y
 I $D(DVBSN(2)) W ?62,DVBSN(2) K DIP K:DN Y
 W ! I $D(DVBEOD(3)),DVBEOD(3)?7N S Y=DVBEOD(3) X ^DD("DD") W ?1,Y K Y K DIP K:DN Y
 I $D(DVBRAD(3)),DVBRAD(3)?7N S Y=DVBRAD(3) X ^DD("DD") W ?15,Y K Y K DIP K:DN Y
 I $D(DVBBOS(3)) W ?34,DVBBOS(3) K DIP K:DN Y
 I $D(DVBCSVC(3)) W ?48,DVBCSVC(3) K DIP K:DN Y
 I $D(DVBSN(3)) W ?62,DVBSN(3) K DIP K:DN Y
 W ! I $D(DVBEOD(4)),DVBEOD(4)?7N S Y=DVBEOD(4) X ^DD("DD") W ?1,Y K Y K DIP K:DN Y
 I $D(DVBRAD(4)),DVBRAD(4)?7N S Y=DVBRAD(4) X ^DD("DD") W ?15,Y K Y K DIP K:DN Y
 I $D(DVBBOS(4)) W ?34,DVBBOS(4) K DIP K:DN Y
 I $D(DVBCSVC(4)) W ?48,DVBCSVC(4) K DIP K:DN Y
 I $D(DVBSN(4)) W ?62,DVBSN(4) K DIP K:DN Y
 W !!,?34,"Patient File" K DIP K:DN Y
 W ?44 W !,"-------------------------------------------------------------------------------" K DIP K:DN Y
 W !," Last episode" K DIP K:DN Y
 S X=$G(^DPT(D0,.32)) D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,6) D DT
 D N:$X>14 Q:'DN  W ?14 S Y=$P(X,U,7) D DT
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,5) S Y=$S(Y="":Y,$D(^DIC(23,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>47 Q:'DN  W ?47 S Y=$P(X,U,4) S Y=$S(Y="":Y,$D(^DIC(25,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,20)
 D N:$X>61 Q:'DN  W ?61,$E($P(X,U,8),1,15)
 W !," NTL episode" K DIP K:DN Y
 S X=$G(^DPT(D0,.32)) D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,11) D DT
 D N:$X>14 Q:'DN  W ?14 S Y=$P(X,U,12) D DT
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,10) S Y=$S(Y="":Y,$D(^DIC(23,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>47 Q:'DN  W ?47 S Y=$P(X,U,9) S Y=$S(Y="":Y,$D(^DIC(25,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,20)
 D N:$X>61 Q:'DN  W ?61,$E($P(X,U,13),1,15)
 D T Q:'DN  W ?2 W !," NNTL episode" K DIP K:DN Y
 S X=$G(^DPT(D0,.32)) D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,16) D DT
 D N:$X>14 Q:'DN  W ?14 S Y=$P(X,U,17) D DT
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,15) S Y=$S(Y="":Y,$D(^DIC(23,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>47 Q:'DN  W ?47 S Y=$P(X,U,14) S Y=$S(Y="":Y,$D(^DIC(25,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,20)
 D N:$X>61 Q:'DN  W ?61,$E($P(X,U,18),1,15)
 W ?61 X DXS(8,9) K DIP K:DN Y
 D T Q:'DN  D N D N D N:$X>0 Q:'DN  W ?0 W "Other Annual Retirement (PAYEE):"
 S X=$G(^DPT(D0,.362)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,18) W:Y]"" $S($D(DXS(13,Y)):DXS(13,Y),1:Y)
 W ?34 I $D(DVBRETT) S V=DVBRETT D TR^DVBHS6 W ?52,V K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Amt. other Annl. Ret. (PAYEE):"
 S X=$G(^DPT(D0,.362)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,8) W:Y]"" $J(Y,9,2)
 W ?34 I $D(DVBRETO) W ?52,DVBRETO K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Amt. other Annl. Inc. (PAYEE):"
 S X=$G(^DPT(D0,.362)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,9) W:Y]"" $J(Y,9,2)
 W ?34 I $D(DVBOINC) W ?52,DVBOINC K DIP K:DN Y
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
