ENPLPA1 ; GENERATED FROM 'ENPLP008' PRINT TEMPLATE (#161) ; 06/11/96 ; (continued)
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
 D N:$X>44 Q:'DN  W ?44 S DIP(1)=$S($D(^ENG("PROJ",D0,24)):^(24),1:"") S X=$P(DIP(1),U,4)+0 K DIP K:DN Y W $J(X,8)
 D N:$X>59 Q:'DN  W ?59 W "68. REGION SCORE: "
 S X=$G(^ENG("PROJ",D0,24)) W ?0,$E($P(X,U,10),1,3)
 D N:$X>0 Q:'DN  W ?0 W "62. RECURRING ALL OTHER $ : "
 D N:$X>44 Q:'DN  W ?44 S DIP(1)=$S($D(^ENG("PROJ",D0,24)):^(24),1:"") S X=$P(DIP(1),U,2)+0 K DIP K:DN Y W $J(X,8)
 D N:$X>0 Q:'DN  W ?0 W "63. EQUIPMENT $ : "
 D N:$X>44 Q:'DN  W ?44 S DIP(1)=$S($D(^ENG("PROJ",D0,24)):^(24),1:"") S X=$P(DIP(1),U,5)+0 K DIP K:DN Y W $J(X,8)
 D N:$X>0 Q:'DN  W ?0 W "64. NON-RECURRING ALL OTHER $ : "
 D N:$X>44 Q:'DN  W ?44 S DIP(1)=$S($D(^ENG("PROJ",D0,24)):^(24),1:"") S X=$P(DIP(1),U,6)+0 K DIP K:DN Y W $J(X,8)
 D N:$X>0 Q:'DN  W ?0 W "65. TRAVEL .007 $ : "
 D N:$X>44 Q:'DN  W ?44 S DIP(1)=$S($D(^ENG("PROJ",D0,24)):^(24),1:"") S X=$P(DIP(1),U,7)+0 K DIP K:DN Y W $J(X,8)
 D N:$X>59 Q:'DN  W ?59 W "69. TOTAL PROJECT SCORE: "
 X ^DD(6925,235,9.8) S X=X+Y W $E(X,1,6) K Y(6925,235)
 D T Q:'DN  D N D N:$X>45 Q:'DN  W ?45 W "***********  SIGNATURES  ***********"
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "70. CHIEF ENGINEERING SVC/DESIGNEE: "
 X DXS(3,9.3) S X=$S(DIP(2):DIP(102),DIP(103):X) S D0=I(0,0) K DIP K:DN Y W X
 D N:$X>89 Q:'DN  W ?89 W "71. DATE: "
 X DXS(4,9.2) S DIP(4)=X S X=1,DIP(5)=X S X="",X=$S(DIP(2):DIP(4),DIP(5):X) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W "72. DIRECTOR FACILITY/DESIGNEE: "
 X DXS(5,9.3) S X=$S(DIP(2):DIP(102),DIP(103):X) S D0=I(0,0) K DIP K:DN Y W X
 D N:$X>89 Q:'DN  W ?89 W "73. DATE: "
 X DXS(6,9.2) S DIP(4)=X S X=1,DIP(5)=X S X="",X=$S(DIP(2):DIP(4),DIP(5):X) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>45 Q:'DN  W ?45 W "************************************"
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "74. REGION PROJECT VALIDATION: "
 D N:$X>89 Q:'DN  W ?89 W "75. DATE: "
 F Y=0:0 Q:$Y>(IOSL-5)  W !
 D N:$X>0 Q:'DN  W ?0 W "VAF 10-1193 REVISED 5/95 p.2"
 W ?30 R:$E(IOST,1,2)="C-" X:DTIME W @IOF K DIP K:DN Y
 F Y=0:0 Q:$Y>-1  W !
 D N:$X>0 Q:'DN  W ?0 W "VHA"
 D N:$X>53 Q:'DN  W ?53 W "PROJECT APPLICATION"
 D N:$X>107 Q:'DN  W ?107 W "PROJECT NUMBER"
 D N:$X>54 Q:'DN  W ?54 W "EXECUTIVE SUMMARY"
 S X=$G(^ENG("PROJ",D0,0)) D N:$X>111 Q:'DN  W ?111,$E($P(X,U,1),1,11)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "DETAILED PROJECT DESCRIPTION:"
 S I(1)=46,J(1)=6925.0277 F D1=0:0 Q:$O(^ENG("PROJ",D0,46,D1))'>0  S D1=$O(^(D1)) D:$X>31 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^ENG("PROJ",D0,46,D1,0)) S DIWL=1,DIWR=99 D ^DIWP
 Q
A1R ;
 D A^DIWW
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "DETAILED PROJECT JUSTIFICATION:"
 S I(1)=47,J(1)=6925.0278 F D1=0:0 Q:$O(^ENG("PROJ",D0,47,D1))'>0  S D1=$O(^(D1)) D:$X>33 T Q:'DN  D B1
 G B1R
B1 ;
 S X=$G(^ENG("PROJ",D0,47,D1,0)) S DIWL=1,DIWR=97 D ^DIWP
 Q
B1R ;
 D A^DIWW
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "IMPACT JUSTIFICATION:"
 S DICMX="D ^DIWP" S DIWL=1,DIWR=107 X DXS(7,9.3) S X=$S(DIP(2):DIP(3),DIP(4):X) K DIP K:DN Y
 D A^DIWW
 F Y=0:0 Q:$Y>(IOSL-5)  W !
 D N:$X>0 Q:'DN  W ?0 W "VAF 10-1193 REVISED 5/95 p.3"
 K Y K DIWF
 Q
HEAD ;
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
