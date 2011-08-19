RTCH ; GENERATED FROM 'RT HOME LOCATION' PRINT TEMPLATE (#479) ; 07/15/96 ; (FILE 190, MARGIN=132)
 G BEGIN
CP G CP^DIO2
C S DQ(C)=Y
S S Q(C)=Y*Y+Q(C) S:L(C)>Y L(C)=Y S:H(C)<Y H(C)=Y
P S N(C)=N(C)+1
A S S(C)=S(C)+Y
 Q
D I Y=DITTO(C) S Y="" Q
 S DITTO(C)=Y
 Q
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(479,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 S X=$G(^RT(D0,0)) D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,1) S C=$P(^DD(190,.01,0),U,2) D Y^DIQ:Y S C="," W $E(Y,1,15)
 S I(100)="^DPT(",J(100)=2 S I(0,0)=D0 S DIP(1)=$S($D(^RT(D0,0)):^(0),1:"") S X=$P(DIP(1),U,9),X=X S D(0)=+X S D0=D(0) I D0>0 D A1
 G A1R
A1 ;
 D N:$X>16 Q:'DN  W ?16 X DXS(1,9.4) S X=$E(DIP(109),DIP(110),X) S Y=X,X=DIP(108),X=X_Y K DIP K:DN Y W X
 Q
A1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 S I(100)="^DIC(195.2,",J(100)=195.2 S I(0,0)=D0 S DIP(1)=$S($D(^RT(D0,0)):^(0),1:"") S X=$P(DIP(1),U,3),X=X S D(0)=+X S D0=D(0) I D0>0 D B1
 G B1R
B1 ;
 S X=$G(^DIC(195.2,D0,0)) D N:$X>39 Q:'DN  W ?39,$E($P(X,U,2),1,3)
 Q
B1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 S DIP(1)=$S($D(^RT(D0,0)):^(0),1:"") S X=""_$P(DIP(1),U,7) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 S Y=D0 W:Y]"" $J(Y,10,0)
 S X=$G(^RT(D0,"CL")) D N:$X>56 Q:'DN  W ?56 S Y=$P(X,U,5) S:Y]"" N(1)=N(1)+1 S C=$P(^DD(190,105,0),U,2) D Y^DIQ:Y S C="," W $E(Y,1,15)
 S I(100)="^RTV(195.9,",J(100)=195.9 S I(0,0)=D0 S DIP(1)=$S($D(^RT(D0,"CL")):^("CL"),1:"") S X=$P(DIP(1),U,5),X=X S D(0)=+X S D0=D(0) I D0>0 D C1
 G C1R
C1 ;
 S X=$G(^RTV(195.9,D0,0)) D N:$X>74 Q:'DN  W ?74,$E($P(X,U,7),1,15)
 Q
C1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 S X=$G(^RT(D0,"CL")) D N:$X>94 Q:'DN  W ?94 S Y=$P(X,U,6) D DT
 D N:$X>116 Q:'DN  W ?116 D OVER^RTUTL1 W $E(X,1,8) K Y(190,201)
 K Y
 Q
HEAD ;
 W !,?116,"DAYS"
 W !,?0,"NAME",?39,"TYPE",?49,"REC #",?56,"BORROWER",?74,"PHONE/ROOM",?94,"Since...",?116,"OVERDUE"
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
