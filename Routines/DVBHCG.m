DVBHCG ; GENERATED FROM 'DVBHINQ PAT-HINQ COMP' PRINT TEMPLATE (#513) ; 01/12/06 ; (FILE 2, MARGIN=80)
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
 I $D(DXS)<9 M DXS=^DIPT(513,"DXS")
 S I(0)="^DPT(",J(0)=2
 W ?0 W @$S('$D(IOF):"#",IOF="":"#",1:IOF) K DIP K:DN Y
 X DXS(1,9) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Name:"
 S X=$G(^DPT(D0,0)) D N:$X>19 Q:'DN  W ?19,$E($P(X,U,1),1,30)
 W ?51 I $D(DVBADR(1)) W ?56,DVBADR(1) K DIP K:DN Y
 W ?62 I '$D(DVBADR(1)),$D(DVBNAME) W ?56,DVBNAME K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Address:"
 S X=$G(^DPT(D0,.11)) D N:$X>19 Q:'DN  W ?19,$E($P(X,U,1),1,35)
 W ?56 I $D(DVBADR(1)) W ?56,DVBADR(1) K DIP K:DN Y
 S X=$G(^DPT(D0,.11)) D N:$X>19 Q:'DN  W ?19,$E($P(X,U,2),1,30)
 W ?51 I $D(DVBADR(2)) W ?56,DVBADR(2) K DIP K:DN Y
 S X=$G(^DPT(D0,.11)) D N:$X>19 Q:'DN  W ?19,$E($P(X,U,3),1,30)
 W ?51 I $D(DVBADR(3)) W ?56,DVBADR(3) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "SSN:"
 S X=$G(^DPT(D0,0)) D N:$X>19 Q:'DN  W ?19,$E($P(X,U,9),1,10)
 W ?31 I $D(DVBSSN) W ?50,DVBSSN K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Claim number:"
 S X=$G(^DPT(D0,.31)) D N:$X>19 Q:'DN  W ?19 S Y=$P(X,U,3) S Y(0)=Y S Y=$E(Y,1,10) W $E(Y,1,9)
 I $D(DVBCN),DVBCN>0 W ?50,DVBCN K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Date of Birth:"
 S X=$G(^DPT(D0,0)) D N:$X>19 Q:'DN  W ?19 S Y=$P(X,U,3) S Y(0)=Y S X=Y(0) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_(1700+$E(X,1,3)) S Y=X W $E(Y,1,30)
 W ?19 X DXS(2,9) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Date of Death:"
 S X=$G(^DPT(D0,.35)) D N:$X>19 Q:'DN  W ?19 S Y=$P(X,U,1) D DT
 W ?19 X DXS(3,9) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Rated Incompetent:"
 S X=$G(^DPT(D0,.29)) D N:$X>19 Q:'DN  W ?19 S Y=$P(X,U,12) W:Y]"" $S($D(DXS(10,Y)):DXS(10,Y),1:Y)
 W ?19 X DXS(4,9) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "POW"
 S X=$G(^DPT(D0,.52)) D N:$X>19 Q:'DN  W ?19 S Y=$P(X,U,5) W:Y]"" $S($D(DXS(11,Y)):DXS(11,Y),1:Y)
 W ?19 X DXS(5,9) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Folder Location:"
 S X=$G(^DPT(D0,.31)) D N:$X>19 Q:'DN  W ?19 S Y=$P(X,U,4) S Y=$S(Y="":Y,$D(^DIC(4,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,27)
 W ?19 I $D(DVBFL) W ?50,$E(DVBFL,1,27) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Verified SVC:"
 S X=$G(^DPT(D0,.32)) D N:$X>19 Q:'DN  W ?19 S Y=$P(X,U,2) D DT
 W ?19 I $P(DVBP(6),U,8)'[" " W ?50 W:$P(DVBP(6),U,8)="Y" "YES" W:$P(DVBP(6),U,8)="N" "NO" K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Vietnam Service:"
 S X=$G(^DPT(D0,.321)) D N:$X>19 Q:'DN  W ?19 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(12,Y)):DXS(12,Y),1:Y)
 W ?19 I $P(DVBP(6),U,4)'[" " W ?50 W:$P(DVBP(6),U,4)="Y" "YES" W:$P(DVBP(6),U,4)="N" "NO" K DIP K:DN Y
 W ?30 X DXS(6,9) K DIP K:DN Y
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "Rated Disab. (Patient file)"
 W ?29 D LSTR^DVBHQUP K DIP K:DN Y
 W ?40 X DXS(7,9) K DIP K:DN Y
 W ?51 I $D(DVBDXNO),DVBDXNO'=0 D S1^DVBHQZ6 K DIP K:DN Y
 W !,?34,"HINQ Data" K DIP K:DN Y
 W !,?6,"EOD",?20,"RAD",?34,"Bran. Ser.",?48,"Char. Ser.",?62,"Ser Num." K DIP K:DN Y
 W ?62 W !,"--------------------------------------------------------------------------------" K DIP K:DN Y
 D T Q:'DN  W ?2 I +$G(DVBEOD(2))>0 K DVBEOD(1) K DIP K:DN Y
 W ?13 I +$G(DVBRAD(2))>0 K DVBRAD(1) K DIP K:DN Y
 W ?24 I $G(DVBCSVC(2))]"" K DVBCSVC(1) K DIP K:DN Y
 W ?35 I $G(DVBSN(2))]"" K DVBSN(1) K DIP K:DN Y
 W ?46 I $G(DVBBOS(2))]"" K DVBBOS(1) K DIP K:DN Y
 X DXS(8,9) K DIP K:DN Y
 X DXS(9,9) K DIP K:DN Y
 I $D(DVBBOS(1)) S Y=DVBBOS(1) D XBOS^DVBHQM12 W ?34,$E(Y,1,16) K Y K DIP K:DN Y
 I $D(DVBCSVC(1)) S I=1,Y=DVBCSVC(1) D DISCHG^DVBHQM1 W ?48,Y K Y K DIP K:DN Y
 I $D(DVBSN(1)) W ?62,DVBSN(1) K DIP K:DN Y
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
 W ?57 W !,"-------------------------------------------------------------------------------" K DIP K:DN Y
 W !," Last episode" K DIP K:DN Y
 S X=$G(^DPT(D0,.32)) D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,6) D DT
 D N:$X>14 Q:'DN  W ?14 S Y=$P(X,U,7) D DT
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,5) S Y=$S(Y="":Y,$D(^DIC(23,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 D N:$X>47 Q:'DN  W ?47 S Y=$P(X,U,4) S Y=$S(Y="":Y,$D(^DIC(25,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,20)
 D N:$X>61 Q:'DN  W ?61,$E($P(X,U,8),1,15)
 W !," NTL episode" K DIP K:DN Y
 S X=$G(^DPT(D0,.32)) D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,11) D DT
 D N:$X>14 Q:'DN  W ?14 S Y=$P(X,U,12) D DT
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,10) S Y=$S(Y="":Y,$D(^DIC(23,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 D N:$X>47 Q:'DN  W ?47 S Y=$P(X,U,9) S Y=$S(Y="":Y,$D(^DIC(25,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,20)
 D N:$X>61 Q:'DN  W ?61,$E($P(X,U,13),1,15)
 D T Q:'DN  W ?2 W !," NNTL episode" K DIP K:DN Y
 S X=$G(^DPT(D0,.32)) D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,16) D DT
 D N:$X>14 Q:'DN  W ?14 S Y=$P(X,U,17) D DT
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,15) S Y=$S(Y="":Y,$D(^DIC(23,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 D N:$X>47 Q:'DN  W ?47 S Y=$P(X,U,14) S Y=$S(Y="":Y,$D(^DIC(25,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,20)
 D N:$X>61 Q:'DN  W ?61,$E($P(X,U,18),1,15)
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
