IBXBCR ; GENERATED FROM 'IB BILLING CLOCK INQ' PRINT TEMPLATE (#243) ; 06/27/96 ; (FILE 351, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(243,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D N:$X>0 Q:'DN  W ?0 W ?6 W "Reference Number:"
 S X=$G(^IBE(351,D0,0)) W ?25,$E($P(X,U,1),1,12)
 D N:$X>0 Q:'DN  W ?0 W ?16 W "Status:"
 W ?25 S Y=$P(X,U,4) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W ?4 W "Primary Elig. Code:"
 W ?25 X DXS(1,9.2) S X=$S('$D(^DIC(8,+$P(DIP(101),U,1),0)):"",1:$P(^(0),U,1)) S D0=I(0,0) K DIP K:DN Y W $E(X,1,40)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W ?6 W "Clock Begin Date:"
 W ?25 S DIP(1)=$S($D(^IBE(351,D0,0)):^(0),1:"") S X=$P(DIP(1),U,3),X=$P(X,".",1) S Y=X K DIP K:DN Y S Y=X D DT
 D N:$X>0 Q:'DN  W ?0 W ?8 W "Clock End Date:"
 W ?25 S DIP(1)=$S($D(^IBE(351,D0,0)):^(0),1:"") S X=$P(DIP(1),U,10),X=$P(X,".",1) S Y=X K DIP K:DN Y S Y=X D DT
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W ?1 W "Number Inpatient Days:"
 S X=$G(^IBE(351,D0,0)) W ?25,$E($P(X,U,9),1,40)
 D T Q:'DN  D N D N:$X>1 Q:'DN  W ?1 W "90 Day Inpatient Amounts"
 D N:$X>0 Q:'DN  W ?0 W ?5 W "1st 90 Day Amount:"
 D N:$X>23 Q:'DN  W ?23 S Y=$P(X,U,5) W:Y]"" $J(Y,8,2)
 D N:$X>0 Q:'DN  W ?0 W ?5 W "2nd 90 Day Amount:"
 D N:$X>23 Q:'DN  W ?23 S Y=$P(X,U,6) W:Y]"" $J(Y,8,2)
 D N:$X>0 Q:'DN  W ?0 W ?5 W "3rd 90 Day Amount:"
 D N:$X>23 Q:'DN  W ?23 S Y=$P(X,U,7) W:Y]"" $J(Y,8,2)
 D N:$X>0 Q:'DN  W ?0 W ?5 W "4th 90 Day Amount:"
 D N:$X>23 Q:'DN  W ?23 S Y=$P(X,U,8) W:Y]"" $J(Y,8,2)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W ?6 W "Date Entry Added:"
 W ?25 S DIP(1)=$S($D(^IBE(351,D0,1)):^(1),1:"") S X=$P(DIP(1),U,2),X=$P(X,".",1) S Y=X K DIP K:DN Y S Y=X D DT
 D N:$X>0 Q:'DN  W ?0 W ?5 W "Date Last Updated:"
 W ?25 S DIP(1)=$S($D(^IBE(351,D0,1)):^(1),1:"") S X=$P(DIP(1),U,4),X=$P(X,".",1) S Y=X K DIP K:DN Y S Y=X D DT
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W ?9 W "Update Reason:"
 S X=$G(^IBE(351,D0,0)) W ?25,$E($P(X,U,11),1,40)
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
