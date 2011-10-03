SDXLST ; GENERATED FROM 'SD-AMB-PROC-LIST' PRINT TEMPLATE (#231) ; 06/13/96 ; (FILE 409.72, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(231,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 S X=$G(^SD(409.72,D0,0)) D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^SD(409.71,Y,0))#2:$P(^(0),U,1),1:Y) S Y=$S(Y="":Y,$D(^ICPT(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,5)
 X $P(^DD(409.72,.025,0),U,5,99) S DIP(1)=X S X=" - "_DIP(1) K DIP K:DN Y W X
 D N:$X>41 Q:'DN  W ?41 S DIP(2)=$S($D(^SD(409.72,D0,0)):^(0),1:"") S X="    ",DIP(1)=X S X=$P(DIP(2),U,4),X=X S Y=X,X=DIP(1),X=X S X=X_Y K DIP K:DN Y W X
 S X=$G(^SD(409.72,D0,0)) D N:$X>54 Q:'DN  W ?54 S Y=$P(X,U,5) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 S DICMX="D L^DIWP" D T Q:'DN  D N D N:$X>2 Q:'DN  S DIWL=3,DIWR=78 X DXS(1,9.3) S DIP(101)=$S($D(^SD(409.71,D0,0)):^(0),1:""),D0=$P(DIP(101),U,1) S:'$D(^ICPT(+D0,0)) D0=-1 X DXS(1,9.2):D0>0 S X="" S D0=I(0,0) K DIP K:DN Y
 D A^DIWW
 D T Q:'DN  D N W ?0 W ""
 D N:$X>19 Q:'DN  W ?19 W "RAM Reimbursement: "
 S %=$O(^SD(409.82,"AIVDT",+$P(^SD(409.72,D0,0),U,4),(9999998-$S($D(SDEFDT):SDEFDT,1:^(0))))) S X=$S('%:0,$D(^SD(409.82,+$O(^(%,0)),0)):$P(^(0),U,3),1:0) S X=$J(X,0,2) W:X'?."*" $J(X,7,2) K Y(409.72,203)
 D N:$X>19 Q:'DN  W ?19 W "       Local Cost: "
 S X=$G(^SD(409.72,D0,0)) S Y=$P(X,U,6) W:Y]"" $J(Y,7,2)
 D N:$X>52 Q:'DN  W ?52 W "Effective Date: "
 S Y=$P(X,U,1) D DT
 D N:$X>0 Q:'DN  W ?0 S X="-",DIP(1)=X,DIP(2)=X,X=$S($D(IOM):IOM,1:80) S X=X,X1=DIP(1) S %=X1 X:%]"" "F X=X:0 S %=%_X1 Q:$L(%)>X" S X=$E(%,1,X) K DIP K:DN Y W X
 K Y K DIWF
 Q
HEAD ;
 W !,?0,"CPT/HCPCS"
 W !,?0,"CODE",?41,"RAM GROUP",?54,"STATUS"
 W !,"--------------------------------------------------------------------------------",!!
