SDXAMB ; GENERATED FROM 'SD-AMB-PROC-DISPLAY' PRINT TEMPLATE (#229) ; 06/13/96 ; (FILE 409.71, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(229,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D T Q:'DN  D N W ?0 W ""
 D N:$X>0 Q:'DN  W ?0 W "CPT/HCPCS Code"
 D N:$X>59 Q:'DN  W ?59 W "Synonyms"
 D N:$X>0 Q:'DN  W ?0 W "--------------"
 D N:$X>59 Q:'DN  W ?59 W "--------"
 S X=$G(^SD(409.71,D0,0)) D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^ICPT(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,5)
 D N:$X>6 Q:'DN  W ?6 X $P(^DD(409.71,.015,0),U,5,99) S DIP(1)=X S X="- "_DIP(1) K DIP K:DN Y W X
 S I(1)="""S""",J(1)=409.711 F D1=0:0 Q:$O(^SD(409.71,D0,"S",D1))'>0  X:$D(DSC(409.711)) DSC(409.711) S D1=$O(^(D1)) Q:D1'>0  D:$X>17 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^SD(409.71,D0,"S",D1,0)) D N:$X>59 Q:'DN  W ?59,$E($P(X,U,1),1,30)
 Q
A1R ;
 S DICMX="D L^DIWP" D T Q:'DN  D N D N:$X>4 Q:'DN  S DIWL=5,DIWR=78 X DXS(1,9) K DIP K:DN Y
 D A^DIWW
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Effective Date"
 D N:$X>19 Q:'DN  W ?19 W "Status"
 D N:$X>41 Q:'DN  W ?41 W "RAM Group"
 D N:$X>54 Q:'DN  W ?54 W "Reimbursement"
 D N:$X>69 Q:'DN  W ?69 W "Local Cost"
 D N:$X>2 Q:'DN  W ?2 W "--------------"
 D N:$X>19 Q:'DN  W ?19 W "------"
 D N:$X>41 Q:'DN  W ?41 W "---------"
 D N:$X>54 Q:'DN  W ?54 W "-------------"
 D N:$X>69 Q:'DN  W ?69 W "----------"
 D N:$X>2 Q:'DN  W ?2 W "** Current **"
 D N:$X>19 Q:'DN  W ?19 S X=DT S X=X,Y(409.71,205,1)=X S X=$S('$D(D0):"",D0<0:"",1:D0),X1=Y(409.71,205,1) D STATUS^SDAMBAE4 W $E(X,1,20) K Y(409.71,205)
 D N:$X>41 Q:'DN  W ?41 S X=DT S X=X,Y(409.71,204,1)=X S X=$S('$D(D0):"",D0<0:"",1:D0),X1=Y(409.71,204,1) D GROUP^SDAMBAE4 W $E(X,1,10) K Y(409.71,204)
 D N:$X>54 Q:'DN  W ?54 S X=DT S X=X,Y(409.71,203,1)=X S X=$S('$D(D0):"",D0<0:"",1:D0),X1=Y(409.71,203,1) D REIMB^SDAMBAE4 W:X'?."*" $J(X,11,2) K Y(409.71,203)
 D N:$X>67 Q:'DN  W ?67 S X=DT S X=X,Y(409.71,206,1)=X S X=$S('$D(D0):"",D0<0:"",1:D0),X1=Y(409.71,206,1) D COST^SDAMBAE4 W:X'?."*" $J(X,11,2) K Y(409.71,206)
 S DIXX(1)="B1",I(0,0)=D0 S I(0,0)=$S($D(D0):D0,1:"") X DXS(2,9.2) S X="" S D0=I(0,0)
 G B1R
B1 ;
 I $D(DSC(409.72)) X DSC(409.72) E  Q
 W:$X>80 ! S I(100)="^SD(409.72,",J(100)=409.72
 S X=$G(^SD(409.72,D0,0)) D N:$X>2 Q:'DN  W ?2 S Y=$P(X,U,1) D DT
 D N:$X>19 Q:'DN  W ?19 S Y=$P(X,U,5) W:Y]"" $S($D(DXS(3,Y)):DXS(3,Y),1:Y)
 D N:$X>41 Q:'DN  W ?41 S Y=$P(X,U,4) S Y=$S(Y="":Y,$D(^SD(409.81,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>54 Q:'DN  W ?54 S %=$O(^SD(409.82,"AIVDT",+$P(^SD(409.72,D0,0),U,4),(9999998-$S($D(SDEFDT):SDEFDT,1:^(0))))) S X=$S('%:0,$D(^SD(409.82,+$O(^(%,0)),0)):$P(^(0),U,3),1:0) S X=$J(X,0,2) W:X'?."*" $J(X,11,2) K Y(409.72,203)
 S X=$G(^SD(409.72,D0,0)) D N:$X>68 Q:'DN  W ?68 S Y=$P(X,U,6) W:Y]"" $J(Y,10,2)
 Q
B1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D T Q:'DN  D N W ?0 W ""
 D N:$X>0 Q:'DN  W ?0 S X="-",DIP(1)=X,DIP(2)=X,X=$S($D(IOM):IOM,1:80) S X=X,X1=DIP(1) S %=X1 X:%]"" "F X=X:0 S %=%_X1 Q:$L(%)>X" S X=$E(%,1,X) K DIP K:DN Y W X
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
