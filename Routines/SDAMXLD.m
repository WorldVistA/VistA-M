SDAMXLD ; GENERATED FROM 'SDAMVLD' PRINT TEMPLATE (#232) ; 07/25/98 ; (FILE 409.65, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(232,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D N:$X>3 Q:'DN  W ?3 W "Appointment Date: "
 S X=$G(^SDD(409.65,D0,0)) S Y=$P(X,U,1) D DT
 D N:$X>0 Q:'DN  W ?0 W "Date Update Started: "
 S Y=$P(X,U,2) D DT
 D N:$X>10 Q:'DN  W ?10 W "Completed: "
 S Y=$P(X,U,5) D DT
 D N:$X>13 Q:'DN  W ?13 X DXS(1,9) K DIP K:DN Y W X
 D N:$X>17 Q:'DN  W ?17 S DIP(1)=$S($D(^SDD(409.65,D0,0)):^(0),1:"") S X="By: "_$S('$D(^VA(200,+$P(DIP(1),U,4),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W $E(X,1,25)
 D N:$X>0 Q:'DN  W ?0 S X="_",DIP(1)=X,DIP(2)=X,X=$S($D(IOM):IOM,1:80) S X=X,X1=DIP(1) S %=X,X="" Q:X1=""  S $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) K DIP K:DN Y W X
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
