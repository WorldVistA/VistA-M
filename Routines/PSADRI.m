PSADRI ; GENERATED FROM 'PSADRI' PRINT TEMPLATE (#492) ; 11/05/97 ; (FILE 50, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(492,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D N:$X>0 Q:'DN  W ?0 W "DRUG file"
 D N:$X>39 Q:'DN  W ?39 W "ITEM MASTER file"
 D N:$X>0 Q:'DN  W ?0 S X="_",DIP(1)=X S X=80,X1=DIP(1) S %=X,X="" Q:X1=""  S $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) K DIP K:DN Y W X
 S X=$G(^PSDRUG(D0,0)) D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0,$E($P(X,U,1),1,35)
 S I(100)="^PRC(441,",J(100)=441 X DXS(1,9.2) S DIP(101)=$S($D(^PRC(441,D0,0)):^(0),1:"") S X=$P(DIP(101),U,1) S D0=I(0,0) S D0=D(0) I D0>0 D A1
 G A1R
A1 ;
 S I(101)=1,J(101)=441.02 F D1=0:0 Q:$O(^PRC(441,D0,1,D1))'>0  S D1=$O(^(D1)) D:$X>37 T Q:'DN  D A2
 G A2R
A2 ;
 S X=$G(^PRC(441,D0,1,D1,0)) S DIWL=38,DIWR=77 D ^DIWP
 Q
A2R ;
 D 0^DIWW K DIP K:DN Y
 S NO=D0 K DIP K:DN Y
 D ^DIWW
 D N:$X>39 Q:'DN  W ?39 S DIP(101)=$S($D(^PRC(441,D0,0)):^(0),1:"") S X="ITEM NUMBER: "_$P(DIP(101),U,1) K DIP K:DN Y W X
 D T Q:'DN  D N W ?0 S DIP(1)=$S($D(^PSDRUG(I(0,0),0)):^(0),1:"") S X=$P(DIP(1),U,6) K DIP K:DN Y W X
 D N:$X>29 Q:'DN  W ?29 W "-NSN-"
 S X=$G(^PRC(441,D0,0)) D N:$X>39 Q:'DN  W ?39,$E($P(X,U,5),1,17)
 D T Q:'DN  D N W ?0 S DIP(1)=$S($D(^PSDRUG(I(0,0),2)):^(2),1:"") S X=$P(DIP(1),U,4) K DIP K:DN Y W X
 W ?11 S NDC=X K DIP K:DN Y
 D N:$X>29 Q:'DN  W ?29 W "-NDC-"
 D N:$X>39 Q:'DN  W ?39 S VE=$O(^PRC(441,"F",NDC,+NO,"")) W $P(^PRC(441,+NO,2,+VE,0),U,5) K DIP K:DN Y
 D T Q:'DN  D N W ?0 S DIP(1)=$S($D(^PSDRUG(I(0,0),660)):^(660),1:"") S X="$"_$P(DIP(1),U,3)_"/"_$S('$D(^DIC(51.5,+$P(DIP(1),U,2),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 D N:$X>29 Q:'DN  W ?29 W "-COST-"
 D N:$X>39 Q:'DN  W ?39 X DXS(2,9) K DIP K:DN Y
 W ?50 W "Date of price: " S Y=$P(^PRC(441,+NO,2,+VE,0),U,6) X ^DD("DD") W Y K DIP K:DN Y
 D T Q:'DN  D N W ?0 S DIP(1)=$S($D(^PSDRUG(I(0,0),660)):^(660),1:"") S X=$P(DIP(1),U,5)_"/"_$S('$D(^DIC(51.5,+$P(DIP(1),U,2),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 D N:$X>29 Q:'DN  W ?29 W "-PKG-"
 D N:$X>39 Q:'DN  W ?39 X DXS(3,9) K DIP K:DN Y
 D T Q:'DN  D N W ?0 S DIP(1)=$S($D(^PSDRUG(I(0,0),660)):^(660),1:"") S X="$"_$P(DIP(1),U,6)_"/"_$P(DIP(1),U,8) K DIP K:DN Y W X
 D N:$X>26 Q:'DN  W ?26 W "-UNIT COST-"
 D N:$X>39 Q:'DN  W ?39 W "$" K DIP K:DN Y
 S PR=$P(^PRC(441,+NO,2,+VE,0),U,2) K DIP K:DN Y
 X DXS(4,9) K DIP K:DN Y W X
 W ?50 W "(Based on dispense unit)"
 D T Q:'DN  D N W ?0 S DIP(1)=$S($D(^PSDRUG(I(0,0),660)):^(660),1:"") S X=$P(DIP(1),U,7) K DIP K:DN Y W X
 D N:$X>28 Q:'DN  W ?28 W "-SOURCE-"
 D N:$X>39 Q:'DN  W ?39 W $P($G(^PRC(440,+$P(^PRC(441,+NO,2,+VE,0),U),0)),U) K DIP K:DN Y
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 S DIP(101)=$S($D(^PRC(441,D0,0)):^(0),1:"") S X="Purchasing Agent:  "_$S('$D(^VA(200,+$P(DIP(101),U,11),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 S I(200)="^VA(200,",J(200)=200 X DXS(5,9.2) S DIP(201)=$S($D(^VA(200,D0,0)):^(0),1:"") S X=$P(DIP(201),U,1) S D0=I(100,0) S D0=D(0) I D0>0 D B2
 G B2R
B2 ;
 D N:$X>39 Q:'DN  W ?39 S DIP(201)=$S($D(^VA(200,D0,.13)):^(.13),1:"") S X="Phone:  "_$P(DIP(201),U,2) K DIP K:DN Y W X
 Q
B2R ;
 K J(200),I(200) S:$D(I(100,0)) D0=I(100,0)
 Q
A1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
