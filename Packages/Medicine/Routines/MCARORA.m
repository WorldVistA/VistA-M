MCARORA ; GENERATED FROM 'MCRHPROG' PRINT TEMPLATE (#1010) ; 10/04/96 ; (FILE 701, MARGIN=80)
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
 D T Q:'DN  D N D N D N:$X>0 Q:'DN  W ?0 W "PROVIDER: "
 S X=$G(^MCAR(701,D0,"PROV")) S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D N:$X>0 Q:'DN  W ?0 W "PROBLEM LIST"
 S X=$G(^MCAR(701,D0,0)) D T Q:'DN  D N D N D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,1) D DT
 D N:$X>0 Q:'DN  W ?0 W "PATIENT"
 D N:$X>16 Q:'DN  W ?16 W "DATE"
 D N:$X>29 Q:'DN  W ?29 W "DIAGNOSIS"
 D N:$X>67 Q:'DN  W ?67 W "ICD9 CODE"
 D N:$X>0 Q:'DN  W ?0 W "-------"
 D N:$X>16 Q:'DN  W ?16 W "----"
 D N:$X>29 Q:'DN  W ?29 W "---------"
 D N:$X>67 Q:'DN  W ?67 W "---------"
 D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^MCAR(690,Y,0))#2:$P(^(0),U,1),1:Y) S Y=$S(Y="":Y,$D(^DPT(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,15)
 S I(1)=13,J(1)=701.0615 F D1=0:0 Q:$O(^MCAR(701,D0,13,D1))'>0  X:$D(DSC(701.0615)) DSC(701.0615) S D1=$O(^(D1)) Q:D1'>0  D:$X>17 T Q:'DN  D A1
 G A1R
A1 ;
 D N:$X>16 Q:'DN  W ?16 S DIP(1)=$S($D(^MCAR(701,D0,13,D1,0)):^(0),1:"") S X=$P(DIP(1),U,2) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) K DIP K:DN Y W $E(X,1,10)
 S X=$G(^MCAR(701,D0,13,D1,0)) D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(697.5,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 W ?66 D PRINT^MCRH2 K DIP K:DN Y
 Q
A1R ;
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
