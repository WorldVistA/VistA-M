PRCBTCP ; GENERATED FROM 'PRCB READER DISP' PRINT TEMPLATE (#333) ; 10/27/00 ; (FILE 421.6, MARGIN=80)
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
 I $D(DXS)<9 M DXS=^DIPT(333,"DXS")
 S I(0)="^PRCF(421.6,",J(0)=421.6
 S DIWF="W"
 D N:$X>0 Q:'DN  W ?0 W "Transfer Transaction Summary"
 D N:$X>19 Q:'DN  W ?19 W "   "
 D N:$X>8 Q:'DN  W ?8 W "To Control Point: "
 S X=$G(^PRCF(421.6,D0,0)) W ?28,$E($P(X,U,3),1,30)
 D N:$X>6 Q:'DN  W ?6 W "From Control Point: "
 W ?28,$E($P(X,U,2),1,30)
 D N:$X>8 Q:'DN  W ?8 W "Transaction Date: "
 W ?28 S Y=$P(X,U,5) D DT
 D N:$X>17 Q:'DN  W ?17 W "Quarter: "
 W ?28 X DXS(1,9.3) S X=$S(DIP(3):DIP(4),DIP(5):DIP(6),DIP(7):DIP(8),DIP(9):X) S Y=X,X=DIP(2),X=X_Y K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W "Amount to be Transferred: "
 W ?28 X DXS(2,9.2) S X=X_Y K DIP K:DN Y W X
 D N:$X>20 Q:'DN  W ?20 W "R/NR: "
 S X=$G(^PRCF(421.6,D0,2)) W ?28 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(4,Y)):DXS(4,Y),1:Y)
 D N:$X>11 Q:'DN  W ?11 W "Annualization: "
 W ?28 X DXS(3,9.2) S X=X_Y K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "Description: "
 S I(1)=1,J(1)=421.65 F D1=0:0 Q:$O(^PRCF(421.6,D0,1,D1))'>0  S D1=$O(^(D1)) D:$X>15 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^PRCF(421.6,D0,1,D1,0)) S DIWL=16,DIWR=78 D ^DIWP
 Q
A1R ;
 D 0^DIWW K DIP K:DN Y
 D ^DIWW K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
