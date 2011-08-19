XUCT01 ; GENERATED FROM 'XUSERINQ' PRINT TEMPLATE (#27) ; 12/12/07 ; (FILE 200, MARGIN=80)
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
 I $D(DXS)<9 M DXS=^DIPT(27,"DXS")
 S I(0)="^VA(200,",J(0)=200
 D N:$X>0 Q:'DN  W ?0 X DXS(1,9.2) S %=$L(X),%1=$X,$P(%2,"-",%)="-" W X,!,?%1,%2 K %1,%2 S X="" K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W "Service/Section: "
 S X=$G(^VA(200,D0,5)) W ?19 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^DIC(49,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 X DXS(2,9.2) S X1=DIP(3) S:X]""&(X?.ANP)&(X1'[U)&(X1'["$C(94)") DIPA($E(X,1,30))=X1 S X="" K DIP K:DN Y W X
 W ?51 W:$L($P(^VA(200,D0,0),U,11)) !,$C(7),?5,"Terminated:   ",DIPA("TD") K DIP K:DN Y
 X DXS(3,9.2) S X1=DIP(3) S:X]""&(X?.ANP)&(X1'[U)&(X1'["$C(94)") DIPA($E(X,1,30))=X1 S X="" K DIP K:DN Y W X
 W ?62 W:DIPA("DIS")["Y" !,?8,"Disuser:   ",DIPA("DIS") K DIP K:DN Y
 D T Q:'DN  W ?2 D INQ^XUS9 S X="" K DIP K:DN Y
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 S X="ATTRIBUTES",%=$L(X),%1=$X,$P(%2,"-",%)="-" W X,!,?%1,%2 K %1,%2 S X="" K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Creator"
 W ?11 X DXS(4,9.2) S X1=DIP(2) S %=$X,%1=$S(X>%:X-%,1:0),%="",$P(%,".",%1)="." W %,X1 K %,%1 S (X,X1)="" K DIP K:DN Y W X
 D N:$X>42 Q:'DN  W ?42 S X="Date entered" K DIP K:DN Y W X
 W ?53 X DXS(5,9.2) S X1=DIP(3) S %=$X,%1=$S(X>%:X-%,1:0),%="",$P(%,".",%1)="." W %,X1 K %,%1 S (X,X1)="" K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Mult Sign-on"
 W ?16 X DXS(6,9.2) S X1=DIP(3) S %=$X,%1=$S(X>%:X-%,1:0),%="",$P(%,".",%1)="." W %,X1 K %,%1 S (X,X1)="" K DIP K:DN Y W X
 D N:$X>42 Q:'DN  W ?42 W "Fileman codes"
 W ?57 X DXS(7,9.2) S X1=DIP(2) S %=$X,%1=$S(X>%:X-%,1:0),%="",$P(%,".",%1)="." W %,X1 K %,%1 S (X,X1)="" K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Time-out"
 W ?12 X DXS(8,9.2) S X1=DIP(2) S %=$X,%1=$S(X>%:X-%,1:0),%="",$P(%,".",%1)="." W %,X1 K %,%1 S (X,X1)="" K DIP K:DN Y W X
 D N:$X>42 Q:'DN  W ?42 W "Type-ahead"
 W ?54 X DXS(9,9.2) S X1=DIP(3) S %=$X,%1=$S(X>%:X-%,1:0),%="",$P(%,".",%1)="." W %,X1 K %,%1 S (X,X1)="" K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Title"
 W ?9 X DXS(10,9.2) S X1=DIP(2) S %=$X,%1=$S(X>%:X-%,1:0),%="",$P(%,".",%1)="." W %,X1 K %,%1 S (X,X1)="" K DIP K:DN Y W X
 D N:$X>42 Q:'DN  W ?42 W "Office Phone"
 W ?56 X DXS(11,9.2) S X1=DIP(2) S %=$X,%1=$S(X>%:X-%,1:0),%="",$P(%,".",%1)="." W %,X1 K %,%1 S (X,X1)="" K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Auto-Menu"
 W ?13 X DXS(12,9.2) S X1=DIP(3) S %=$X,%1=$S(X>%:X-%,1:0),%="",$P(%,".",%1)="." W %,X1 K %,%1 S (X,X1)="" K DIP K:DN Y W X
 D N:$X>42 Q:'DN  W ?42 W "Voice Pager"
 W ?55 X DXS(13,9.2) S X1=DIP(2) S %=$X,%1=$S(X>%:X-%,1:0),%="",$P(%,".",%1)="." W %,X1 K %,%1 S (X,X1)="" K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Last Sign-on"
 W ?16 X DXS(14,9.2) S X1=DIP(3) S %=$X,%1=$S(X>%:X-%,1:0),%="",$P(%,".",%1)="." W %,X1 K %,%1 S (X,X1)="" K DIP K:DN Y W X
 D N:$X>42 Q:'DN  W ?42 W "Digital Pager"
 W ?57 X DXS(15,9.2) S X1=DIP(2) S %=$X,%1=$S(X>%:X-%,1:0),%="",$P(%,".",%1)="." W %,X1 K %,%1 S (X,X1)="" K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Has a E-SIG"
 S DIPA("ESIG")=$S($L($P($G(^VA(200,D0,20)),U,4)):"Yes",1:"No") K DIP K:DN Y
 W ?15 X DXS(16,9.2) S X1=DIP(1) S %=$X,%1=$S(X>%:X-%,1:0),%="",$P(%,".",%1)="." W %,X1 K %,%1 S (X,X1)="" K DIP K:DN Y W X
 D N:$X>42 Q:'DN  W ?42 W "Write Med's"
 W ?55 X DXS(17,9.2) S X1=DIP(3) S %=$X,%1=$S(X>%:X-%,1:0),%="",$P(%,".",%1)="." W %,X1 K %,%1 S (X,X1)="" K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W " "
 D N:$X>2 Q:'DN  W ?2 W "NPI"
 W ?7 X DXS(18,9.2) S X1=DIP(2) S %=$X,%1=$S(X>%:X-%,1:0),%="",$P(%,".",%1)="." W %,X1 K %,%1 S (X,X1)="" K DIP K:DN Y W X
 D N:$X>42 Q:'DN  W ?42 W "Taxonomy"
 S DIPA("TAX")=$P($$TAXINQ^XUSTAX(D0),"^") K DIP K:DN Y
 W ?52 X DXS(19,9.2) S X1=DIP(1) S %=$X,%1=$S(X>%:X-%,1:0),%="",$P(%,".",%1)="." W %,X1 K %,%1 S (X,X1)="" K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Person Class: "
 W ?18 D SHPC^XUSER1(D0) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W " "
 X DXS(20,9.2) S X1=DIP(2) S:X]""&(X?.ANP)&(X1'[U)&(X1'["$C(94)") DIPA($E(X,1,30))=X1 S X="" K DIP K:DN Y W X
 W ?3 W:$G(DIPA("POS"))'="" !,"Clinical Trainee Data" K DIP K:DN Y
 W ?14 W:$G(DIPA("POS"))'="" !,"---------------------" K DIP K:DN Y
 X DXS(21,9.2) S X1=DIP(2) S:X]""&(X?.ANP)&(X1'[U)&(X1'["$C(94)") DIPA($E(X,1,30))=X1 S X="" K DIP K:DN Y W X
 W ?25 W:$G(DIPA("POS"))'="" !,?2,"Current Degree Level: ",DIPA("F12.1") K DIP K:DN Y
 W ?36 X DXS(22,9.2) S X1=DIP(2) S:X]""&(X?.ANP)&(X1'[U)&(X1'["$C(94)") DIPA($E(X,1,30))=X1 S X="" K DIP K:DN Y W X
 W ?47 W:$G(DIPA("POS"))'="" !,?2,"Program of Study: ",DIPA("F12.2") K DIP K:DN Y
 W ?58 X DXS(23,9.3) S X1=DIP(2) S:X]""&(X?.ANP)&(X1'[U)&(X1'["$C(94)") DIPA($E(X,1,30))=X1 S X="" K DIP K:DN Y W X
 W ?69 W:$G(DIPA("POS"))'="" !,?2,"Last Training Year: ",DIPA("F12.3") K DIP K:DN Y
 D T Q:'DN  W ?2 X DXS(24,9.2) S X1=DIP(2) S:X]""&(X?.ANP)&(X1'[U)&(X1'["$C(94)") DIPA($E(X,1,30))=X1 S X="" K DIP K:DN Y W X
 W ?13 W:$G(DIPA("POS"))'="" !,?2,"VHA Training Facility: ",DIPA("F12.4") K DIP K:DN Y
 W ?24 W:$G(DIPA("POS"))'="" !," " K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^VA(200,D0,201)):^(201),1:"") S X="Primary Menu: "_$P($G(^DIC(19,+$P(DIP(1),U,1),0)),U) K DIP K:DN Y W X
 D N:$X>39 Q:'DN  W ?39 X DXS(25,9.2) S X=$P(DIP(101),U,2) S D0=I(0,0) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 S X="Secondary Menu(s)",%=$L(X),%1=$X,$P(%2,"-",%)="-" W X,!,?%1,%2 K %1,%2 S X="" K DIP K:DN Y W X
 S I(1)=203,J(1)=200.03 F D1=0:0 Q:$O(^VA(200,D0,203,D1))'>0  X:$D(DSC(200.03)) DSC(200.03) S D1=$O(^(D1)) Q:D1'>0  D:$X>11 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^VA(200,D0,203,D1,0)) D N:$X>1 Q:'DN  W ?1,$E($P(X,U,2),1,4)
 D N:$X>7 Q:'DN  W ?7 S DIP(1)=$S($D(^VA(200,D0,203,D1,0)):^(0),1:"") S X="["_$P($G(^DIC(19,+$P(DIP(1),U,1),0)),U)_"]" K DIP K:DN Y W X
 D N:$X>41 Q:'DN  W ?41 X DXS(26,9.2) S X=$P(DIP(101),U,2) S D0=I(0,0) S D1=I(1,0) K DIP K:DN Y W X
 Q
A1R ;
 D T Q:'DN  D N W ?0 S X="Keys Held",%=$L(X),%1=$X,$P(%2,"-",%)="-" W X,!,?%1,%2 K %1,%2 S X="" K DIP K:DN Y W X
 W ?11 D GKEYS^XUSER1(D0,.DIP),SHLIST^XUSER1(.DIP,3,4) K DIP K:DN Y
 D T Q:'DN  D N W ?0 S X="Patient Selection",%=$L(X),%1=$X,$P(%2,"-",%)="-" W X,!,?%1,%2 K %1,%2 S X="" K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Restrict?:"
 S X=$G(^VA(200,D0,101)) D N:$X>13 Q:'DN  W ?13 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(29,Y)):DXS(29,Y),1:Y)
 D N:$X>1 Q:'DN  W ?1 W "OE/RR List:"
 D N:$X>13 Q:'DN  W ?13 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^OR(100.21,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 D T Q:'DN  D N W ?0 S X="CPRS Access Tabs",%=$L(X),%1=$X,$P(%2,"-",%)="-" W X,!,?%1,%2 K %1,%2 S X="" K DIP K:DN Y W X
 W ?11 X DXS(27,9) K DIP K:DN Y
 S I(1)="""ORD""",J(1)=200.010113 F D1=0:0 Q:$O(^VA(200,D0,"ORD",D1))'>0  X:$D(DSC(200.010113)) DSC(200.010113) S D1=$O(^(D1)) Q:D1'>0  D:$X>22 T Q:'DN  D B1
 G B1R^XUCT011
B1 ;
 S X=$G(^VA(200,D0,"ORD",D1,0)) D N:$X>2 Q:'DN  W ?2 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^ORD(101.13,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,3)
 G ^XUCT011
