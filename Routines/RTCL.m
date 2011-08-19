RTCL ; GENERATED FROM 'RT MISSING' PRINT TEMPLATE (#482) ; 07/15/96 ; (FILE 190.2, MARGIN=132)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(482,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 S X=$G(^RTV(190.2,D0,0)) D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,1) S C=$P(^DD(190.2,.01,0),U,2) D Y^DIQ:Y S C="," W $E(Y,1,20)
 S I(100)="^RT(",J(100)=190 S I(0,0)=D0 S DIP(1)=$S($D(^RTV(190.2,D0,0)):^(0),1:"") S X=$P(DIP(1),U,1),X=X S D(0)=+X S D0=D(0) I D0>0 D A1
 G A1R
A1 ;
 S I(200)="^DPT(",J(200)=2 S I(100,0)=D0 S DIP(101)=$S($D(^RT(D0,0)):^(0),1:"") S X=$P(DIP(101),U,9),X=X S D(0)=+X S D0=D(0) I D0>0 D A2
 G A2R
A2 ;
 X DXS(1,9.4) S X=$E(DIP(209),DIP(210),X) S Y=X,X=DIP(208),X=X_Y K DIP K:DN Y W X
 Q
A2R ;
 K J(200),I(200) S:$D(I(100,0)) D0=I(100,0)
 S I(200)="^DIC(195.2,",J(200)=195.2 S I(100,0)=D0 S DIP(101)=$S($D(^RT(D0,0)):^(0),1:"") S X=$P(DIP(101),U,3),X=X S D(0)=+X S D0=D(0) I D0>0 D B2
 G B2R
B2 ;
 S X=$G(^DIC(195.2,D0,0)) D N:$X>39 Q:'DN  W ?39,$E($P(X,U,2),1,3)
 Q
B2R ;
 K J(200),I(200) S:$D(I(100,0)) D0=I(100,0)
 S X=$G(^RT(D0,0)) S Y=$P(X,U,7) W:Y]"" $J(Y,3,0)
 Q
A1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 S X=$G(^RTV(190.2,D0,0)) D N:$X>51 Q:'DN  W ?51 S Y=$P(X,U,4) W:Y]"" $S($D(DXS(3,Y)):DXS(3,Y),1:Y)
 S DIXX(1)="B1",I(0,0)=D0 X DXS(2,9)
 G B1R
B1 ;
 I $D(DSC(190.3)) X DSC(190.3) E  Q
 W:$X>63 ! S I(100)="^RTV(190.3,",J(100)=190.3
 S X=$G(^RTV(190.3,D0,0)) D N:$X>64 Q:'DN  W ?64 S Y=$P(X,U,5) S C=$P(^DD(190.3,5,0),U,2) D Y^DIQ:Y S C="," W $E(Y,1,20)
 D N:$X>89 Q:'DN  W ?89 S Y=$P(X,U,6) D DT
 D N:$X>114 Q:'DN  W ?114 S Y=$P(X,U,15) W:Y]"" $S($D(DXS(4,Y)):DXS(4,Y),1:Y)
 Q
B1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "Entered as Missing : "
 S X=$G(^RTV(190.2,D0,0)) S Y=$P(X,U,2) D DT
 D N:$X>49 Q:'DN  W ?49 W "Entered By: "
 S Y=$P(X,U,3) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "Supervisor Comments: "
 S I(1)=1,J(1)=190.21 F D1=0:0 Q:$O(^RTV(190.2,D0,1,D1))'>0  S D1=$O(^(D1)) D:$X>23 T Q:'DN  D C1
 G C1R
C1 ;
 S X=$G(^RTV(190.2,D0,1,D1,0)) S DIWL=25,DIWR=130 D ^DIWP
 Q
C1R ;
 D A^DIWW
 D N:$X>0 Q:'DN  W ?0 S X="-",DIP(1)=X,DIP(2)=X,X=$S($D(IOM):IOM,1:80) S X=X,X1=DIP(1) S %=X1 X:%]"" "F X=X:0 S %=%_X1 Q:$L(%)>X" S X=$E(%,1,X) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W "[The following fields will only contain information if the record was found by a user who is 'not' a file room supervisor.]"
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "Entered as Found   : "
 S X=$G(^RTV(190.2,D0,0)) S Y=$P(X,U,6) D DT
 D N:$X>49 Q:'DN  W ?49 W "Entered By: "
 S Y=$P(X,U,8) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D N:$X>89 Q:'DN  W ?89 W "Where it was found: "
 S Y=$P(X,U,5) S C=$P(^DD(190.2,5,0),U,2) D Y^DIQ:Y S C="," W $E(Y,1,30)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "User Comments      : "
 S I(1)=2,J(1)=190.22 F D1=0:0 Q:$O(^RTV(190.2,D0,2,D1))'>0  S D1=$O(^(D1)) D:$X>23 T Q:'DN  D D1
 G D1R
D1 ;
 S X=$G(^RTV(190.2,D0,2,D1,0)) S DIWL=25,DIWR=130 D ^DIWP
 Q
D1R ;
 D A^DIWW
 D N:$X>0 Q:'DN  W ?0 S X="=",DIP(1)=X,DIP(2)=X,X=$S($D(IOM):IOM,1:80) S X=X,X1=DIP(1) S %=X1 X:%]"" "F X=X:0 S %=%_X1 Q:$L(%)>X" S X=$E(%,1,X) K DIP K:DN Y W X
 D T Q:'DN  D N W ?0 W ""
 K Y K DIWF
 Q
HEAD ;
 W !,?0,"NAME",?39,"TYPE",?51,"STATUS",?64,"BORROWER HISTORY",?89,"CHARGED",?114,"BARCODED?"
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
