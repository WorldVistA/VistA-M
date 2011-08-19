YSCPAN ; GENERATED FROM 'YSSR REVIEW ACTION HEADER' PRINT TEMPLATE (#561) ; 08/21/96 ; (FILE 615.2, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(561,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D N:$X>0 Q:'DN  W ?0 W "VAMC"
 D N:$X>5 Q:'DN  W ?5 S X=^DD("SITE") K DIP K:DN Y W X
 D N:$X>67 Q:'DN  W ?67 S X="PAGE:  ",DIP(1)=X,X=$S($D(DC)#2:DC,1:"") S Y=X,X=DIP(1),X=X S X=X_Y K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 X DXS(1,9) K DIP K:DN Y W X
 D N:$X>14 Q:'DN  W ?14 X DXS(2,9.2) S X=$P(DIP(3),X) S Y=X,X=DIP(1),X=X_Y K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 X DXS(3,9.2) S X=$P(DIP(3),X) S Y=X,X=DIP(1),X=X_Y K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 S X="=",DIP(1)=X,DIP(2)=X,X=$S($D(IOM):IOM,1:80) S X=X,X1=DIP(1) S %=X,X="" Q:X1=""  S $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W "REVIEW"
 D N:$X>10 Q:'DN  W ?10 W "NAME OF PATIENT &"
 D N:$X>29 Q:'DN  W ?29 W "DATE/TIME"
 D N:$X>0 Q:'DN  W ?0 W "DATE"
 D N:$X>10 Q:'DN  W ?10 W "SSN"
 D N:$X>29 Q:'DN  W ?29 W "OF EPISODE"
 D N:$X>46 Q:'DN  W ?46 W "REASON FOR S/R"
 D N:$X>63 Q:'DN  W ?63 W "TYPE OF S/R"
 D N:$X>0 Q:'DN  W ?0 W "--------"
 D N:$X>10 Q:'DN  W ?10 W "-----------------"
 D N:$X>29 Q:'DN  W ?29 W "---------------"
 D N:$X>46 Q:'DN  W ?46 W "---------------"
 D N:$X>63 Q:'DN  W ?63 W "----------------"
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
