ONCOX51 ; GENERATED FROM 'ONCOX5' PRINT TEMPLATE (#846) ; 03/18/98 ; (continued)
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
 W "      Primary Sequence No:  "
 S X=$G(^ONCO(165.5,D0,0)) W ?0,$E($P(X,U,6),1,2)
 D N:$X>4 Q:'DN  W ?4 W "Text Primary Site:  "
 X DXS(16,9) K DIP K:DN Y W X
 D N:$X>6 Q:'DN  W ?6 W " "
 D N:$X>4 Q:'DN  W ?4 W "Text Dx Proc-Phys.Exam: "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=10,J(1)=165.5104 F D1=0:0 Q:$O(^ONCO(165.5,D0,10,D1))'>0  S D1=$O(^(D1)) D:$X>30 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^ONCO(165.5,D0,10,D1,0)) S DIWL=1,DIWR=100 D ^DIWP
 Q
A1R ;
 D A^DIWW
 D N:$X>4 Q:'DN  W ?4 W "Text Dx Proc-Xray/Scan: "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=11,J(1)=165.5105 F D1=0:0 Q:$O(^ONCO(165.5,D0,11,D1))'>0  S D1=$O(^(D1)) D:$X>30 T Q:'DN  D B1
 G B1R
B1 ;
 S X=$G(^ONCO(165.5,D0,11,D1,0)) S DIWL=1,DIWR=100 D ^DIWP
 Q
B1R ;
 D A^DIWW
 D N:$X>4 Q:'DN  W ?4 W "Text Dx Proc-Operation: "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=9,J(1)=165.5103 F D1=0:0 Q:$O(^ONCO(165.5,D0,9,D1))'>0  S D1=$O(^(D1)) D:$X>30 T Q:'DN  D C1
 G C1R
C1 ;
 S X=$G(^ONCO(165.5,D0,9,D1,0)) S DIWL=1,DIWR=100 D ^DIWP
 Q
C1R ;
 D A^DIWW
 D N:$X>4 Q:'DN  W ?4 W "Text Dx Proc-Lab Tests: "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=22,J(1)=165.5116 F D1=0:0 Q:$O(^ONCO(165.5,D0,22,D1))'>0  S D1=$O(^(D1)) D:$X>30 T Q:'DN  D D1
 G D1R
D1 ;
 S X=$G(^ONCO(165.5,D0,22,D1,0)) S DIWL=1,DIWR=100 D ^DIWP
 Q
D1R ;
 D A^DIWW
 D N:$X>4 Q:'DN  W ?4 W "Text Dx Proc-Endoscopy: "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=12,J(1)=165.5106 F D1=0:0 Q:$O(^ONCO(165.5,D0,12,D1))'>0  S D1=$O(^(D1)) D:$X>30 T Q:'DN  D E1
 G E1R
E1 ;
 S X=$G(^ONCO(165.5,D0,12,D1,0)) S DIWL=1,DIWR=100 D ^DIWP
 Q
E1R ;
 D A^DIWW
 D N:$X>4 Q:'DN  W ?4 W "Text Dx Proc-Path/Cyto: "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=13,J(1)=165.5107 F D1=0:0 Q:$O(^ONCO(165.5,D0,13,D1))'>0  S D1=$O(^(D1)) D:$X>30 T Q:'DN  D F1
 G F1R
F1 ;
 S X=$G(^ONCO(165.5,D0,13,D1,0)) S DIWL=1,DIWR=100 D ^DIWP
 Q
F1R ;
 D A^DIWW
 D T Q:'DN  D N W ?0 X DXS(17,9) K DIP K:DN Y W X
 D T Q:'DN  D N W ?0 S X="" D SDP^ONCOCOM W $E(X,1,80) K Y(165.5,48)
 K Y K DIWF
 Q
HEAD ;
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
