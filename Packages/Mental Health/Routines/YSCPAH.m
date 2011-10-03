YSCPAH ; GENERATED FROM 'YSSR DATE MGT HEADER' PRINT TEMPLATE (#554) ; 08/21/96 ; (FILE 615.2, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(554,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D N:$X>0 Q:'DN  W ?0 W "VAMC "
 D N:$X>5 Q:'DN  W ?5 S X=^DD("SITE") K DIP K:DN Y W X
 D N:$X>67 Q:'DN  W ?67 S X="PAGE:  ",DIP(1)=X,X=$S($D(DC)#2:DC,1:"") S Y=X,X=DIP(1),X=X S X=X_Y K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 S X="SECLUSION/RESTRAINT MANAGEMENT REPORT",X=$J("",$S($D(IOM):IOM,1:80)-$L(X)\2-$X)_X K DIP K:DN Y W X
 D N:$X>14 Q:'DN  W ?14 X DXS(1,9.2) S X=$P(DIP(3),X) S Y=X,X=DIP(1),X=X_Y K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 X DXS(2,9.2) S X=$P(DIP(3),X) S Y=X,X=DIP(1),X=X_Y K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 S X="BY DATE",X=$J("",$S($D(IOM):IOM,1:80)-$L(X)\2-$X)_X K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 S X="-------",X=$J("",$S($D(IOM):IOM,1:80)-$L(X)\2-$X)_X K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W ""
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
