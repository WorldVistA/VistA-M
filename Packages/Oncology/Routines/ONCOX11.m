ONCOX11 ; GENERATED FROM 'ONCOX11' PRINT TEMPLATE (#852) ; 05/01/00 ; (FILE 165.5, MARGIN=80)
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
 I $D(DXS)<9 M DXS=^DIPT(852,"DXS")
 S I(0)="^ONCO(165.5,",J(0)=165.5
 D T Q:'DN  D N W ?0 W "************************    FOLLOW-UP HISTORY    ************************"
 W ?0 S X="" D FHP^ONCODLF W $E(X,1,80) K Y(165.5,150)
 D N:$X>1 Q:'DN  W ?1 W "DATE OF LAST CONTACT:  "
 S X="" D PDLC^ONCOCRF S Y=X W ?(13-$S(Y#1:18,1:11)+$X) D DT
 D N:$X>44 Q:'DN  W ?44 W "TUMOR STATUS:  "
 S X=$G(^ONCO(165.5,D0,7)) S Y=$P(X,U,6) S Y=$S(Y="":Y,$D(^ONCO(164.42,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,40)
 D N:$X>9 Q:'DN  W ?9 W " " K DIP K:DN Y
 S I(100)="^ONCO(160,",J(100)=160 S I(0,0)=D0 S DIP(1)=$S($D(^ONCO(165.5,D0,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X S D(0)=+X S D0=D(0) I D0>0 D A1
 G A1R
A1 ;
 D N:$X>1 Q:'DN  W ?1 W "ICD Revision:  "
 S X=$G(^ONCO(160,D0,1)) S Y=$P(X,U,4) W:Y]"" $S($D(DXS(4,Y)):DXS(4,Y),1:Y)
 D N:$X>1 Q:'DN  W ?1 W "Place of Death:  "
 X DXS(1,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>1 Q:'DN  W ?1 W "Care Center at Death: "
 X DXS(2,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>1 Q:'DN  W ?1 W "Autopsy:  "
 X DXS(3,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>1 Q:'DN  W ?1 W "Autopsy Date/Time:  "
 S X=$G(^ONCO(160,D0,1)) S Y=$P(X,U,9) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 D N:$X>1 Q:'DN  W ?1 W "Autopsy No:  "
 S X=$G(^ONCO(160,D0,1)) W ?0,$E($P(X,U,10),1,15)
 D N:$X>1 Q:'DN  W ?1 W "ICD Cause of Death:  "
 S I(200)="^ICD9(",J(200)=80 S I(100,0)=D0 S DIP(101)=$S($D(^ONCO(160,D0,1)):^(1),1:"") S X=$P(DIP(101),U,3),X=X S D(0)=+X S D0=D(0) I D0>0 D A2
 G A2R
A2 ;
 S X=$G(^ICD9(D0,0)) W ?24,$E($P(X,U,1),1,7)
 W ?33 S DIP(201)=$S($D(^ICD9(D0,0)):^(0),1:"") S X=$P(DIP(201),U,3) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 Q
A2R ;
 K J(200),I(200) S:$D(I(100,0)) D0=I(100,0)
 D N:$X>1 Q:'DN  W ?1 W "Cause of Death/Cancer:  "
 S X=$G(^ONCO(160,D0,1)) S Y=$P(X,U,12) W:Y]"" $S($D(DXS(5,Y)):DXS(5,Y),1:Y)
 D N:$X>1 Q:'DN  W ?1 W "Date of Death:  "
 S Y=$P(X,U,8) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 D N:$X>1 Q:'DN  W ?1 W "Path/autopsy: "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(101)=4,J(101)=160.031 F D1=0:0 Q:$O(^ONCO(160,D0,4,D1))'>0  S D1=$O(^(D1)) D:$X>17 T Q:'DN  D B2
 G B2R
B2 ;
 S X=$G(^ONCO(160,D0,4,D1,0)) S DIWL=1,DIWR=61 D ^DIWP
 Q
B2R ;
 D A^DIWW
 D N:$X>0 Q:'DN  W ?0 W " " K DIP K:DN Y
 D N:$X>19 Q:'DN  W ?19 W "TUMOR Status at DEATH (Multiple Primaries)" K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W " " K DIP K:DN Y
 S X="" D MTS^ONCOCOF W $J(X,9) K Y(160,70)
 Q
A1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D T Q:'DN  D N W ?0 W "  "
 W ?4 I $G(PRTPCE)=1 D PCEPRT^ONCOGEN K DIP K:DN Y
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
