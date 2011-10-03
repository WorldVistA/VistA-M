PRCATR3 ; GENERATED FROM 'PRCA TRANS PROFILE' PRINT TEMPLATE (#421) ; 06/27/96 ; (FILE 433, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(421,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D N:$X>0 Q:'DN  W ?0 W "ACCOUNT:"
 D N:$X>9 Q:'DN  W ?9 X DXS(1,9) K DIP K:DN Y W $E(X,1,25)
 D N:$X>34 Q:'DN  W ?34 W "SSN:"
 W ?40 S X=$$SSN^RCFN01(+$$EN^PRCAFN1(D0)),X=$S(X<0:"",1:X) W ?40,X K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "TRANS. NO:"
 S X=$G(^PRCA(433,D0,0)) D N:$X>11 Q:'DN  W ?11,$E($P(X,U,1),1,9)
 D N:$X>34 Q:'DN  W ?34 W "BILL NO:"
 D N:$X>49 Q:'DN  W ?49 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^PRCA(430,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>0 Q:'DN  W ?0 W "TRANS. DATE:"
 S X=$G(^PRCA(433,D0,1)) D N:$X>17 Q:'DN  W ?17 S Y=$P(X,U,1) D DT
 D N:$X>34 Q:'DN  W ?34 W "TRANS. TYPE:"
 D N:$X>49 Q:'DN  W ?49 X DXS(2,9.4) S X=X_Y K DIP K:DN Y W $E(X,1,26)
 D T Q:'DN  W ?2 D EN1^PRCADR3 K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W " "
 D N:$X>0 Q:'DN  W ?0 W "Brief Comment: "
 S X=$G(^PRCA(433,D0,5)) D N:$X>15 Q:'DN  W ?15,$E($P(X,U,2),1,30)
 D N:$X>49 Q:'DN  W ?49 W "Follow-up Date: "
 D N:$X>65 Q:'DN  W ?65 S DIP(1)=$S($D(^PRCA(433,D0,5)):^(5),1:"") S X=$P(DIP(1),U,3) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W " "
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "COMMENTS: "
 S X=$G(^PRCA(433,D0,8)) D T Q:'DN  W ?12,$E($P(X,U,6),1,75)
 S I(1)=7,J(1)=433.041 F D1=0:0 Q:$O(^PRCA(433,D0,7,D1))'>0  S D1=$O(^(D1)) D:$X>89 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^PRCA(433,D0,7,D1,0)) S DIWL=13,DIWR=78 D ^DIWP
 Q
A1R ;
 D A^DIWW
 D N:$X>0 Q:'DN  W ?0 W "RECEIPT #: "
 S X=$G(^PRCA(433,D0,1)) W ?13,$E($P(X,U,3),1,10)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "PROCESSED BY: "
 S X=$G(^PRCA(433,D0,0)) W ?16 S Y=$P(X,U,9) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
