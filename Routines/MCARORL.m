MCARORL ; GENERATED FROM 'MCRHLAB' PRINT TEMPLATE (#1009) ; 10/04/96 ; (FILE 701, MARGIN=80)
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
 F Y=0:0 Q:$Y>-1  W !
 D N:$X>0 Q:'DN  W ?0 W "PATIENT LABORATORY INFORMATION"
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "C H E M I S T R Y :"
 D N:$X>39 Q:'DN  W ?39 W "S E R O L O G Y :"
 D N:$X>0 Q:'DN  W ?0 W "Aldolase"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,63)) ^(63) K DIP K:DN Y
 D N:$X>39 Q:'DN  W ?39 W "Anti-DNA Antibody"
 D N:$X>69 Q:'DN  W ?69 W:$D(^UTILITY("DIQ1",$J,63.04,DA,563)) ^(563) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Albumin"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,14)) ^(14) K DIP K:DN Y
 D N:$X>39 Q:'DN  W ?39 W "Anti-skeletal muscle"
 D N:$X>69 Q:'DN  W ?69 W:$D(^UTILITY("DIQ1",$J,63.04,DA,595)) ^(595) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Alkaline phosphatase"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,17)) ^(17) K DIP K:DN Y
 D N:$X>39 Q:'DN  W ?39 W "Anti-RNP"
 D N:$X>69 Q:'DN  W ?69 W:$D(^UTILITY("DIQ1",$J,63.04,DA,594)) ^(594) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Urea nitrogen"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,3)) ^(3) K DIP K:DN Y
 D N:$X>39 Q:'DN  W ?39 W "Hepatitis B Antibody"
 D N:$X>69 Q:'DN  W ?69 W:$D(^UTILITY("DIQ1",$J,63.04,DA,581)) ^(581) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Calcium"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,9)) ^(9) K DIP K:DN Y
 D N:$X>39 Q:'DN  W ?39 W "Hepatitis B Antigen"
 D N:$X>69 Q:'DN  W ?69 W:$D(^UTILITY("DIQ1",$J,63.04,DA,553)) ^(553) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Cholesterol"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,12)) ^(12) K DIP K:DN Y
 D N:$X>39 Q:'DN  W ?39 W "Complement CH50"
 D N:$X>69 Q:'DN  W ?69 W:$D(^UTILITY("DIQ1",$J,63.04,DA,587)) ^(587) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "CPK"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,41)) ^(41) K DIP K:DN Y
 D N:$X>39 Q:'DN  W ?39 W "Cryoglobulins"
 D N:$X>69 Q:'DN  W ?69 W:$D(^UTILITY("DIQ1",$J,63.04,DA,549)) ^(549) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Creatinine"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,4)) ^(4) K DIP K:DN Y
 D N:$X>39 Q:'DN  W ?39 W "Complement"
 D N:$X>69 Q:'DN  W ?69 W:$D(^UTILITY("DIQ1",$J,63.04,DA,547)) ^(547) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Glucose"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,2)) ^(2) K DIP K:DN Y
 D N:$X>39 Q:'DN  W ?39 W "Complement C4"
 D N:$X>69 Q:'DN  W ?69 W:$D(^UTILITY("DIQ1",$J,63.04,DA,548)) ^(548) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "LDH"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,18)) ^(18) K DIP K:DN Y
 D N:$X>39 Q:'DN  W ?39 W "HLA B27"
 D N:$X>69 Q:'DN  W ?69 W:$D(^UTILITY("DIQ1",$J,63.04,DA,174)) ^(174) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "PO4"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,10)) ^(10) K DIP K:DN Y
 D N:$X>39 Q:'DN  W ?39 W "IGA"
 D N:$X>69 Q:'DN  W ?69 W:$D(^UTILITY("DIQ1",$J,63.04,DA,625)) ^(625) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "SGOT"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,19)) ^(19) K DIP K:DN Y
 D N:$X>39 Q:'DN  W ?39 W "IGG"
 D N:$X>69 Q:'DN  W ?69 W:$D(^UTILITY("DIQ1",$J,63.04,DA,627)) ^(627) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "SPGT"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,20)) ^(20) K DIP K:DN Y
 D N:$X>39 Q:'DN  W ?39 W "IGM"
 D N:$X>69 Q:'DN  W ?69 W:$D(^UTILITY("DIQ1",$J,63.04,DA,631)) ^(631) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Bilirubin, total"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,15)) ^(15) K DIP K:DN Y
 D N:$X>39 Q:'DN  W ?39 W "Latex fixation"
 D N:$X>69 Q:'DN  W ?69 W:$D(^UTILITY("DIQ1",$J,63.04,639)) ^(639) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Protein, total"
 G ^MCARORL1
