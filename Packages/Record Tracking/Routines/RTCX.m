RTCX ; GENERATED FROM 'RT PENDING REQUESTS' PRINT TEMPLATE (#478) ; 07/15/96 ; (FILE 190.1, MARGIN=132)
 G BEGIN
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
 S X=$G(^RTV(190.1,D0,0)) D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,1),C=1 D D S C=$P(^DD(190.1,.01,0),U,2) D Y^DIQ:Y S C="," W $E(Y,1,15)
 S I(100)="^RT(",J(100)=190 S I(0,0)=D0 S DIP(1)=$S($D(^RTV(190.1,D0,0)):^(0),1:"") S X=$P(DIP(1),U,1),X=X S D(0)=+X S D0=D(0) I D0>0 D A1
 G A1R
A1 ;
 S I(200)="^DPT(",J(200)=2 S I(100,0)=D0 S DIP(101)=$S($D(^RT(D0,0)):^(0),1:"") S X=$P(DIP(101),U,9),X=X S D(0)=+X S D0=D(0) I D0>0 D A2
 G A2R
A2 ;
 D N:$X>16 Q:'DN  W ?16 S DIP(201)=$S($D(^DPT(D0,0)):^(0),1:"") S X=$P(DIP(201),U,9),DIP(202)=X S X=6,DIP(203)=X S X=10,X=$E(DIP(202),DIP(203),X) K DIP K:DN Y S Y=X,C=2 D D S X=Y W X
 Q
A2R ;
 K J(200),I(200) S:$D(I(100,0)) D0=I(100,0)
 S I(200)="^DIC(195.2,",J(200)=195.2 S I(100,0)=D0 S DIP(101)=$S($D(^RT(D0,0)):^(0),1:"") S X=$P(DIP(101),U,3),X=X S D(0)=+X S D0=D(0) I D0>0 D B2
 G B2R
B2 ;
 S X=$G(^DIC(195.2,D0,0)) D N:$X>22 Q:'DN  W ?22,$E($P(X,U,2),1,3)
 Q
B2R ;
 K J(200),I(200) S:$D(I(100,0)) D0=I(100,0)
 S DIP(101)=$S($D(^RT(D0,0)):^(0),1:"") S X=""_$P(DIP(101),U,7) K DIP K:DN Y W X
 D N:$X>29 Q:'DN  W ?29 S Y=D0 W:Y]"" $J(Y,10,0)
 S X=$G(^RT(D0,"CL")) D N:$X>41 Q:'DN  W ?41 S Y=$P(X,U,5) S C=$P(^DD(190,105,0),U,2) D Y^DIQ:Y S C="," W $E(Y,1,15)
 S I(200)="^RTV(195.9,",J(200)=195.9 S I(100,0)=D0 S DIP(101)=$S($D(^RT(D0,"CL")):^("CL"),1:"") S X=$P(DIP(101),U,5),X=X S D(0)=+X S D0=D(0) I D0>0 D C2
 G C2R
C2 ;
 S X=$G(^RTV(195.9,D0,0)) D N:$X>59 Q:'DN  W ?59,$E($P(X,U,7),1,15)
 Q
C2R ;
 K J(200),I(200) S:$D(I(100,0)) D0=I(100,0)
 Q
A1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D N:$X>84 Q:'DN  W ?84,$E(D0,1,9)
 S X=$G(^RTV(190.1,D0,0)) D N:$X>95 Q:'DN  W ?95 S Y=$P(X,U,5) S C=$P(^DD(190.1,5,0),U,2) D Y^DIQ:Y S C="," W $E(Y,1,15)
 D N:$X>112 Q:'DN  W ?112 S Y=$P(X,U,4) D DT
 S:$D(RTCOUNT) RTCOUNT=RTCOUNT+1 K DIP K:DN Y
 K Y
 Q
HEAD ;
 W !,?41,"CURRENT",?112,"DATE/TIME RECORD"
 W !,?0,"NAME",?22,"TYPE",?35,"REC#",?41,"LOCATION",?59,"Phone/Room",?84,"REQ#",?95,"REQUESTOR",?112,"NEEDED"
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
