MCAROH1 ; GENERATED FROM 'MCARHOLT1' PRINT TEMPLATE (#979) ; 07/25/98 ; (FILE 691.6, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(979,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D N:$X>4 Q:'DN  W ?4 S DIP(1)=$S($D(^MCAR(691.6,D0,0)):^(0),1:"") S X="WARD/CLINIC: "_$S('$D(^SC(+$P(DIP(1),U,18),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "REQUESTED BY: "
 S X=$G(^MCAR(691.6,D0,0)) S Y=$P(X,U,5) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "REASON FOR STUDY:"
 S I(1)=8,J(1)=691.65 F D1=0:0 Q:$O(^MCAR(691.6,D0,8,D1))'>0  X:$D(DSC(691.65)) DSC(691.65) S D1=$O(^(D1)) Q:D1'>0  D:$X>23 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^MCAR(691.6,D0,8,D1,0)) D N:$X>24 Q:'DN  W ?24 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(5,Y)):DXS(5,Y),1:Y)
 Q
A1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "REVIEWED BY: "
 S X=$G(^MCAR(691.6,D0,0)) S Y=$P(X,U,15) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 X DXS(1,9) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 S DIP(1)=$S($D(^MCAR(691.6,D0,4)):^(4),1:"") S X="HOURS: "_$P(DIP(1),U,2)_" TOTAL,  "_$P(DIP(1),U,3)_" READABLE" K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "MALFUNCTIONS:"
 S I(1)=3,J(1)=691.62 F D1=0:0 Q:$O(^MCAR(691.6,D0,3,D1))'>0  S D1=$O(^(D1)) D:$X>19 T Q:'DN  D B1
 G B1R
B1 ;
 S X=$G(^MCAR(691.6,D0,3,D1,0)) S DIWL=20,DIWR=79 D ^DIWP
 Q
B1R ;
 D A^DIWW
 D T Q:'DN  D N D N D N:$X>4 Q:'DN  W ?4 W "----------------------------  RESULTS  ----------------------------"
 D T Q:'DN  D N D N:$X>29 Q:'DN  W ?29 W "HEART RATE"
 D N:$X>57 Q:'DN  W ?57 W "TIME"
 D N:$X>29 Q:'DN  W ?29 W "----------"
 D N:$X>56 Q:'DN  W ?56 W "------"
 D N:$X>9 Q:'DN  W ?9 W "AVERAGE"
 S X=$G(^MCAR(691.6,D0,4)) D N:$X>32 Q:'DN  W ?32 S Y=$P(X,U,4) W:Y]"" $J(Y,4,0)
 D N:$X>9 Q:'DN  W ?9 W "MAXIMUM"
 D N:$X>32 Q:'DN  W ?32 S Y=$P(X,U,5) W:Y]"" $J(Y,4,0)
 D N:$X>57 Q:'DN  W ?57,$E($P(X,U,6),1,7)
 D N:$X>9 Q:'DN  W ?9 W "MINIMUM"
 D N:$X>32 Q:'DN  W ?32 S Y=$P(X,U,7) W:Y]"" $J(Y,4,0)
 D N:$X>57 Q:'DN  W ?57,$E($P(X,U,8),1,7)
 D T Q:'DN  D N D N:$X>13 Q:'DN  W ?13 W "VENTRICULAR"
 D N:$X>53 Q:'DN  W ?53 W "ATRIAL"
 D N:$X>7 Q:'DN  W ?7 W "-------------------------"
 D N:$X>44 Q:'DN  W ?44 W "-------------------------"
 D N:$X>3 Q:'DN  W ?3 S Y=$P(X,U,9) W:Y]"" $J(Y,8,0)
 D N:$X>12 Q:'DN  W ?12 W "TOTAL BEATS"
 D N:$X>39 Q:'DN  W ?39 S Y=$P(X,U,21) W:Y]"" $J(Y,8,0)
 D N:$X>48 Q:'DN  W ?48 W "TOTAL BEATS"
 D N:$X>3 Q:'DN  W ?3 S Y=$P(X,U,10) W:Y]"" $J(Y,8,0)
 D N:$X>12 Q:'DN  W ?12 W "TOTAL VPBS,"
 D N:$X>24 Q:'DN  W ?24 X ^DD(691.6,34,9.3) S X=X*100,X=$S(Y(691.6,34,2):Y(691.6,34,3),Y(691.6,34,4):Y(691.6,34,5),Y(691.6,34,6):X) S X=$J(X,0,1) W:X'?."*" $J(X,2,1) K Y(691.6,34)
 W ?28 W "% OF BTS"
 S X=$G(^MCAR(691.6,D0,4)) D N:$X>39 Q:'DN  W ?39 S Y=$P(X,U,22) W:Y]"" $J(Y,8,0)
 D N:$X>48 Q:'DN  W ?48 W "TOTAL ECTOPICS,"
 D N:$X>64 Q:'DN  W ?64 X ^DD(691.6,47,9.3) S X=X*100,X=$S(Y(691.6,47,2):Y(691.6,47,3),Y(691.6,47,4):Y(691.6,47,5),Y(691.6,47,6):X) S X=$J(X,0,1) S:X?1"0"1"."1"0" X="" W:X'?."*" $J(X,2,1) K Y(691.6,47)
 W ?68 W "% OF BTS"
 D N:$X>3 Q:'DN  W ?3 X DXS(2,9.2) S X=$P(DIP(1),U,10),X=$S($P(DIP(1),U,3):X\$P(DIP(1),U,3),1:"*******"),X=$S(DIP(2):DIP(3),DIP(4):DIP(5),DIP(6):X) K DIP K:DN Y W $J(X,8)
 D N:$X>12 Q:'DN  W ?12 W "AVE/HOUR"
 D N:$X>39 Q:'DN  W ?39 X DXS(3,9.2) S X=$P(DIP(1),U,22),X=$S($P(DIP(1),U,3):X\$P(DIP(1),U,3),1:"*******"),X=$S(DIP(2):DIP(3),DIP(4):DIP(5),DIP(6):X) K DIP K:DN Y W $J(X,8)
 D N:$X>48 Q:'DN  W ?48 W "AVE/HOUR"
 S X=$G(^MCAR(691.6,D0,4)) D N:$X>3 Q:'DN  W ?3 S Y=$P(X,U,12) W:Y]"" $J(Y,8,0)
 D N:$X>12 Q:'DN  W ?12 W "MAX/HOUR"
 D N:$X>39 Q:'DN  W ?39 S Y=$P(X,U,24) W:Y]"" $J(Y,8,0)
 D N:$X>48 Q:'DN  W ?48 W "MAX/HOUR"
 D N:$X>3 Q:'DN  W ?3 S Y=$P(X,U,13) W:Y]"" $J(Y,8,0)
 D N:$X>12 Q:'DN  W ?12 W "ISOLATED"
 D N:$X>39 Q:'DN  W ?39 S Y=$P(X,U,25) W:Y]"" $J(Y,8,0)
 D N:$X>48 Q:'DN  W ?48 W "ISOLATED"
 D N:$X>3 Q:'DN  W ?3 S Y=$P(X,U,14) W:Y]"" $J(Y,8,0)
 D N:$X>12 Q:'DN  W ?12 W "BIGEMINY"
 S X=$G(^MCAR(691.6,D0,6)) D N:$X>39 Q:'DN  W ?39 S Y=$P(X,U,1) W:Y]"" $J(Y,8,0)
 D N:$X>48 Q:'DN  W ?48 W "BLOCKED APCS"
 S X=$G(^MCAR(691.6,D0,4)) D N:$X>3 Q:'DN  W ?3 S Y=$P(X,U,15) W:Y]"" $J(Y,8,0)
 D N:$X>12 Q:'DN  W ?12 W "COUPLETS"
 D N:$X>39 Q:'DN  W ?39 S Y=$P(X,U,26) W:Y]"" $J(Y,8,0)
 D N:$X>48 Q:'DN  W ?48 W "COUPLETS"
 D N:$X>3 Q:'DN  W ?3 S Y=$P(X,U,17) W:Y]"" $J(Y,8,0)
 D N:$X>12 Q:'DN  W ?12 W "BEATS IN RUNS"
 S X=$G(^MCAR(691.6,D0,6)) D N:$X>39 Q:'DN  W ?39 S Y=$P(X,U,2) W:Y]"" $J(Y,8,0)
 D N:$X>48 Q:'DN  W ?48 W "RUNS SV-T"
 S X=$G(^MCAR(691.6,D0,4)) D N:$X>3 Q:'DN  W ?3 S Y=$P(X,U,18) W:Y]"" $J(Y,8,0)
 D N:$X>12 Q:'DN  W ?12 W "BEATS IN LONGEST RUN"
 S X=$G(^MCAR(691.6,D0,6)) D N:$X>39 Q:'DN  W ?39 S Y=$P(X,U,3) W:Y]"" $J(Y,8,0)
 D N:$X>48 Q:'DN  W ?48 W "BEATS IN RUNS"
 S X=$G(^MCAR(691.6,D0,4)) D N:$X>3 Q:'DN  W ?3 S Y=$P(X,U,19) W:Y]"" $J(Y,8,0)
 D N:$X>12 Q:'DN  W ?12 W "BEATS FASTEST RUN AT"
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,20) W:Y]"" $J(Y,3,0)
 D N:$X>37 Q:'DN  W ?37 W "BPM"
 S X=$G(^MCAR(691.6,D0,6)) D N:$X>40 Q:'DN  W ?40 S Y=$P(X,U,4) W:Y]"" $J(Y,7,0)
 D N:$X>48 Q:'DN  W ?48 W "BEATS IN LONGEST RUN"
 D N:$X>39 Q:'DN  W ?39 S Y=$P(X,U,5) W:Y]"" $J(Y,8,0)
 D N:$X>48 Q:'DN  W ?48 W "BTS FASTEST RUN AT"
 D N:$X>67 Q:'DN  W ?67 S Y=$P(X,U,6) W:Y]"" $J(Y,3,0)
 D N:$X>71 Q:'DN  W ?71 W "BPM"
 D T Q:'DN  D N D N:$X>7 Q:'DN  W ?7 X DXS(4,9) K DIP K:DN Y W X
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
