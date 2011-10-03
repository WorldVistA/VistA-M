ONCOX5 ; GENERATED FROM 'ONCOX5' PRINT TEMPLATE (#846) ; 08/13/03 ; (FILE 165.5, MARGIN=132)
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
 I $D(DXS)<9 M DXS=^DIPT(846,"DXS")
 S I(0)="^ONCO(165.5,",J(0)=165.5
 D T Q:'DN  D N W ?0 X DXS(1,9) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>14 Q:'DN  W ?14 W "DX Date:  "
 S X=$G(^ONCO(165.5,D0,0)) S Y=$P(X,U,16) S Y(0)=Y S X=Y D DATEOT^ONCOES W $J(Y,13)
 D N:$X>69 Q:'DN  W ?69 W "Class of Case:  "
 X DXS(2,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>14 Q:'DN  W ?14 W "Type of Reporting Source:  "
 X DXS(3,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>12 Q:'DN  W ?12 W "Histology:  "
 S DIP(1)=$S($D(^ONCO(165.5,D0,2)):^(2),1:"") S X=$P(DIP(1),U,3),X=X K DIP K:DN Y W X
 W " "
 X DXS(4,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>71 Q:'DN  W ?71 W "Dx Facility:  "
 X DXS(5,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>7 Q:'DN  W ?7 W "Text Histology:  "
 X DXS(6,9) K DIP K:DN Y W X
 D N:$X>16 Q:'DN  W ?16 W "Grade:"
 S X=$G(^ONCO(165.5,D0,2)) W ?24 S Y=$P(X,U,5) S Y(0)=Y S:Y'="" Y=$P(^ONCO(164.43,Y,0),U,1) W $E(Y,1,30)
 S DIWL=57,DIWR=130 X DXS(7,9.2) S X=$P(DIP(101),U,2) S D0=I(0,0) K DIP K DIP K:DN Y D ^DIWP
 D 0^DIWW
 D ^DIWW
 D T Q:'DN  W ?2 S TM1=$$PRINT^ONCOTM(D0,1) K DIP K:DN Y
 W ?13 W !?7,TM1_":" K DIP K:DN Y
 S X=$G(^ONCO(165.5,D0,24)) W ?24 S Y=$P(X,U,2) S Y(0)=Y S Y=$P($G(^ONCO(164.15,+Y,0)),U,2) W $E(Y,1,30)
 D N:$X>7 Q:'DN  W ?7 W "Tumor Marker 2:"
 S X=$G(^ONCO(165.5,D0,24)) W ?24 S Y=$P(X,U,3) S Y(0)=Y S Y=$P($G(^ONCO(164.15,+Y,0)),U,2) W $E(Y,1,30)
 D T Q:'DN  D N D N:$X>12 Q:'DN  W ?12 W "ICDO-Site:  "
 X DXS(8,9.2) S X=$P(DIP(101),U,2) S D0=I(0,0) K DIP K:DN Y W X
 W " "
 X DXS(9,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>64 Q:'DN  W ?64 W "Referring Facility:  "
 X DXS(10,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>11 Q:'DN  W ?11 W "Laterality:  "
 X DXS(11,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>65 Q:'DN  W ?65 W "Transfer Facility:  "
 X DXS(12,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>6 Q:'DN  W ?6 W "DX Confirmation:  "
 X DXS(13,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>56 Q:'DN  W ?56 W "Primary Payer at Diagnosis:  "
 X DXS(14,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>9 Q:'DN  W ?9 W "IP/OP status:  "
 S X=$G(^ONCO(165.5,D0,0)) S Y=$P(X,U,23) W:Y]"" $S($D(DXS(18,Y)):DXS(18,Y),1:Y)
 D N:$X>5 Q:'DN  W ?5 W "Screening Result:  "
 S Y=$P(X,U,25) W:Y]"" $S($D(DXS(19,Y)):DXS(19,Y),1:Y)
 D N:$X>68 Q:'DN  W ?68 W "Screening Date:  "
 S Y=$P(X,U,24) S Y(0)=Y D DATEOT^ONCOPCE W $E(Y,1,30)
 D N:$X>1 Q:'DN  W ?1 W "Presentation at Cancer Conference:  "
 S X=$G(^ONCO(165.5,D0,0)) S Y=$P(X,U,26) W:Y]"" $S($D(DXS(20,Y)):DXS(20,Y),1:Y)
 D N:$X>65 Q:'DN  W ?65 W "Date of Cancer Conference:  "
 S Y=$P(X,U,27) S Y(0)=Y D DATEOT^ONCOPCE W $E(Y,1,30)
 D N:$X>1 Q:'DN  W ?1 W "Referral to Support Services:  "
 S X=$G(^ONCO(165.5,D0,0)) W ?34 S Y=$P(X,U,28) W:Y]"" $S($D(DXS(21,Y)):DXS(21,Y),1:Y)
 D T Q:'DN  D N D N:$X>14 Q:'DN  W ?14 W "Site/Gp:  "
 X DXS(15,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 W "      Primary Sequence No:  "
 S X=$G(^ONCO(165.5,D0,0)) W ?0,$E($P(X,U,6),1,2)
 D N:$X>4 Q:'DN  W ?4 W "Text-Primary Site Title:  "
 X DXS(16,9) K DIP K:DN Y W X
 D N:$X>6 Q:'DN  W ?6 W " "
 D N:$X>4 Q:'DN  W ?4 W "Text-Dx Proc-PE: "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=10,J(1)=165.5104 F D1=0:0 Q:$O(^ONCO(165.5,D0,10,D1))'>0  S D1=$O(^(D1)) D:$X>23 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^ONCO(165.5,D0,10,D1,0)) S DIWL=24,DIWR=130 D ^DIWP
 Q
A1R ;
 D 0^DIWW
 D ^DIWW
 D N:$X>4 Q:'DN  W ?4 W "Text-Dx Proc-X-ray/scan: "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=11,J(1)=165.5105 F D1=0:0 Q:$O(^ONCO(165.5,D0,11,D1))'>0  S D1=$O(^(D1)) D:$X>31 T Q:'DN  D B1
 G B1R
B1 ;
 S X=$G(^ONCO(165.5,D0,11,D1,0)) S DIWL=32,DIWR=130 D ^DIWP
 Q
B1R ;
 D 0^DIWW
 D ^DIWW
 D N:$X>4 Q:'DN  W ?4 W "Text-Dx Proc-Op: "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=9,J(1)=165.5103 F D1=0:0 Q:$O(^ONCO(165.5,D0,9,D1))'>0  S D1=$O(^(D1)) D:$X>23 T Q:'DN  D C1
 G C1R
C1 ;
 S X=$G(^ONCO(165.5,D0,9,D1,0)) S DIWL=24,DIWR=130 D ^DIWP
 Q
C1R ;
 D 0^DIWW
 D ^DIWW
 D N:$X>4 Q:'DN  W ?4 W "Text-Dx Proc-Lab Tests: "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=22,J(1)=165.5116 F D1=0:0 Q:$O(^ONCO(165.5,D0,22,D1))'>0  S D1=$O(^(D1)) D:$X>30 T Q:'DN  D D1
 G D1R
D1 ;
 S X=$G(^ONCO(165.5,D0,22,D1,0)) S DIWL=31,DIWR=130 D ^DIWP
 Q
D1R ;
 D 0^DIWW
 D ^DIWW
 D N:$X>4 Q:'DN  W ?4 W "Text-Dx Proc-Scopes: "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=12,J(1)=165.5106 F D1=0:0 Q:$O(^ONCO(165.5,D0,12,D1))'>0  S D1=$O(^(D1)) D:$X>27 T Q:'DN  D E1
 G E1R
E1 ;
 S X=$G(^ONCO(165.5,D0,12,D1,0)) S DIWL=28,DIWR=130 D ^DIWP
 Q
E1R ;
 D 0^DIWW
 D ^DIWW
 D N:$X>4 Q:'DN  W ?4 W "Text-Dx Proc-Path: "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=13,J(1)=165.5107 F D1=0:0 Q:$O(^ONCO(165.5,D0,13,D1))'>0  S D1=$O(^(D1)) D:$X>25 T Q:'DN  D F1
 G F1R
F1 ;
 S X=$G(^ONCO(165.5,D0,13,D1,0)) S DIWL=26,DIWR=130 D ^DIWP
 Q
F1R ;
 D 0^DIWW
 D ^DIWW
 D T Q:'DN  D N W ?0 X DXS(17,9) K DIP K:DN Y W X
 D T Q:'DN  D N W ?0 S X="" D SDP^ONCOCOM W $E(X,1,80) K Y(165.5,48)
 K Y K DIWF
 Q
HEAD ;
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
