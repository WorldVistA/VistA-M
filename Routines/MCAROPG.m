MCAROPG ; GENERATED FROM 'MCARPG' PRINT TEMPLATE (#988) ; 10/04/96 ; (FILE 698, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(988,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D N:$X>32 Q:'DN  W ?32 X DXS(1,9) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 S DIP(1)=$S($D(^MCAR(698,D0,0)):^(0),1:"") S X="HOSPITAL WHERE IMPLANTED: "_$S('$D(^DIC(4,+$P(DIP(1),U,8),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "GENERATOR"
 D N:$X>5 Q:'DN  W ?5 S DIP(1)=$S($D(^MCAR(698,D0,0)):^(0),1:"") S X="MODEL: "_$S('$D(^MCAR(698.4,+$P(DIP(1),U,3),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 S DIP(1)=$S($D(^MCAR(698,D0,0)):^(0),1:"") S X="MANUFACTURER: "_$S('$D(^MCAR(698.6,+$P(DIP(1),U,4),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 D N:$X>5 Q:'DN  W ?5 S DIP(1)=$S($D(^MCAR(698,D0,0)):^(0),1:"") S X="SERIAL NUMBER: "_$P(DIP(1),U,5) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 X DXS(2,9) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "TRANSMITTER"
 D N:$X>5 Q:'DN  W ?5 S DIP(1)=$S($D(^MCAR(698,D0,1)):^(1),1:"") S X="MODEL: "_$S('$D(^MCAR(698.4,+$P(DIP(1),U,3),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 S DIP(1)=$S($D(^MCAR(698,D0,1)):^(1),1:"") S X="MANUFACTURER: "_$S('$D(^MCAR(698.6,+$P(DIP(1),U,4),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 X DXS(3,9) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "ATTENDING PHYSICIAN: "
 S X=$G(^MCAR(698,D0,3)) S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D N:$X>2 Q:'DN  W ?2 W "FELLOW-1st: "
 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D N:$X>2 Q:'DN  W ?2 W "FELLOW-2nd: "
 S Y=$P(X,U,3) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D N:$X>2 Q:'DN  W ?2 X DXS(4,9) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "FIRST SCHEDULED FOLLOW-UP: "
 S X=$G(^MCAR(698,D0,0)) S Y=$P(X,U,12) D DT
 D T Q:'DN  D N D N D N:$X>34 Q:'DN  W ?34 X DXS(5,9) K DIP K:DN Y W X
 D N:$X>54 Q:'DN  W ?54 X DXS(6,9) K DIP K:DN Y W X
 D N:$X>4 Q:'DN  W ?4 W "NON-MAG RATE"
 S X=$G(^MCAR(698,D0,4)) D N:$X>35 Q:'DN  W ?35 S Y=$P(X,U,1) W:Y]"" $J(Y,6,1)
 D N:$X>54 Q:'DN  W ?54 S Y=$P(X,U,5) W:Y]"" $J(Y,6,1)
 D N:$X>4 Q:'DN  W ?4 W "MAGNET RATE"
 D N:$X>35 Q:'DN  W ?35 S Y=$P(X,U,2) W:Y]"" $J(Y,6,1)
 D N:$X>54 Q:'DN  W ?54 S Y=$P(X,U,6) W:Y]"" $J(Y,6,1)
 D N:$X>4 Q:'DN  W ?4 W "NON-MAG PULSE WIDTH"
 D N:$X>37 Q:'DN  W ?37 S Y=$P(X,U,3) W:Y]"" $J(Y,5,2)
 D N:$X>56 Q:'DN  W ?56 S Y=$P(X,U,7) W:Y]"" $J(Y,5,2)
 D N:$X>4 Q:'DN  W ?4 W "MAGNET PULSE WIDTH"
 D N:$X>37 Q:'DN  W ?37 S Y=$P(X,U,4) W:Y]"" $J(Y,5,2)
 D N:$X>56 Q:'DN  W ?56 S Y=$P(X,U,8) W:Y]"" $J(Y,5,2)
 D N:$X>4 Q:'DN  W ?4 W "OTHER INDICATOR"
 D N:$X>36 Q:'DN  W ?36,$E($P(X,U,9),1,25)
 D N:$X>56 Q:'DN  S DIWL=57,DIWR=76 S Y=$P(X,U,10) S X=Y D ^DIWP
 D A^DIWW
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 S DIP(1)=$S($D(^MCAR(698,D0,0)):^(0),1:"") S X="NUMBER OF PULSE GENERATORS: "_$P(DIP(1),U,13) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "LAST PREVIOUS IMPLANT: "
 S X=$G(^MCAR(698,D0,0)) S Y=$P(X,U,14) D DT
 D N:$X>2 Q:'DN  W ?2 W "INCIPIENT MALFUNCTION: "
 S X=$G(^MCAR(698,D0,1)) S Y=$P(X,U,6) D DT
 D N:$X>2 Q:'DN  W ?2 W "PACING FAILURE: "
 S I(1)=2,J(1)=698.093 F D1=0:0 Q:$O(^MCAR(698,D0,2,D1))'>0  X:$D(DSC(698.093)) DSC(698.093) S D1=$O(^(D1)) Q:D1'>0  D:$X>20 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^MCAR(698,D0,2,D1,0)) W ?20 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(13,Y)):DXS(13,Y),1:Y)
 W ", "
 W ?37 S Y=$P(X,U,2) D DT
 Q
A1R ;
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "GENERATOR EXPLANT DATE: "
 S X=$G(^MCAR(698,D0,1)) S Y=$P(X,U,1) D DT
 D N:$X>2 Q:'DN  W ?2 S DIP(1)=$S($D(^MCAR(698,D0,1)):^(1),1:"") S X="REASON FOR CHANGE: "_$S('$D(^MCAR(695.8,+$P(DIP(1),U,2),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 G ^MCAROPG1
