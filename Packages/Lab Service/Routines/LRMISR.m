LRMISR ;SLC/CJS/BA - INPUT TRANSFORM FOR ANTIBIOTIC SENSITIVITIES ;6/14/89  08:36 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 ;input transform for antibiotics
FILE I $L(X)>20!($L(X)<1) K X Q
 S C6=+$O(^LAB(62.06,"C",$P(DQ(DQ),U),0)) I X["*" D STAR^LRMISR1 D @$S($D(X):"SET",1:"OUT") Q
 I '$D(^LAB(62.06,C6,1,"B",X)) K X,C6 Q
 S LRBN=+$P(DQ(DQ),U,4) I 'LRBN K C6,LRBN Q
 S LRR=X D IS^LRMISR1
SET S $P(^LR(LRDFN,"MI",DA(1),3,DA,LRBN),U,2)=LRISR,$P(^(LRBN),U,3)=LRSCREEN W:$L(LRISR) "  (",LRISR,")" I $L(LRSCREEN) W $S(LRSCREEN="N":"  (not displayed)",LRSCREEN="R":"  (restricted display)",1:"")
OUT K C6,C4,C2,LRBN,LRR,LRISR,LRSCREEN
 Q
EN ;help prompts for antibiotic interpretations
 S LRBN=+$P(DQ(DQ),U,4) Q:'LRBN  S C8=$S($D(^LR(LRDFN,"MI",LRIDT,3,DA,LRBN))#2:^(LRBN),1:"")
 I $L($P(C8,U)) W !,"Result: ",$P(C8,U),?25,"Interpretation: ",$S($L($P(C8,U,2)):$P(C8,U,2),1:$P(C8,U)),?53,"Screen: ",$S($P(C8,U,3)="N":"Never",$P(C8,U,3)="R":"Restricted",1:"Always")," Display",!
 S C6=+$O(^LAB(62.06,"C",$P(DQ(DQ),U),0)) W !,"CHOOSE FROM:"
 S LRR="" F A6=0:1 S LRR=$O(^LAB(62.06,C6,1,"B",LRR)) Q:LRR=""  S C4=+$O(^(LRR,0)) D INTRP^LRMISR1 W ?15,LRR,?24,$S('A6:" FOR:   ",1:"  "),?32,LRISR,! K C2,C4,LRISR
 K A6,C6,C8,LRBN,LRR
 Q
HELP S XQH="LRHM LRMIEDZ Example1" H 1 D EN^XQH K X
 Q
INT I '$D(^LAB(62.06,"AJ",$P($P(DQ(DQ),U,4),";"),X)) K X
 Q
HINT W !,"Interpretations for this antibiotic:" S J=0 F I=0:0 S J=$O(^LAB(62.06,"AJ",$P($P(DQ(DQ),U,4),";"),J)) Q:J=""  W !,?25,J
 Q
COM ;input transform for AFB antibiotics - will expand lab descriptions
 I $L(X)>20!($L(X)<1)!(X'?.ANP) K X Q
 S B3="" F A6=1:1 Q:$P(X," ",A6,99)=""  S B6=$P(X," ",A6) D:B6]"" Z2 S A4=$L(B3)+$L(B6) S:A4'>68 B3=B3_B6_" " I A4>68 W "  too long",! K X Q
 W "  (",$E(B3,1,$L(B3)-1),")" S X=B3 K A4,A6,B3,B6
 Q
Z2 S A2=0 F I=0:0 S A2=$O(^LAB(62.5,"B",B6,A2)) Q:A2<1  I "KMTVP"[$P(^LAB(62.5,A2,0),U,4) S B6=$P(^LAB(62.5,A2,0),U,2) Q:'$D(^(9))  S B4=$P(X," ",A6-1),B4=$E(B4,$L(B4)) S:B4>1 B6=^(9) Q
 K A2,B4
 Q
ZQ ;AFB prompts from lab descriptions
 S X=$S(X="??":"??",1:"?"),DIC="^LAB(62.5,",DIC(0)="Q",DIC("S")="I ""KMTVP""[$P(^(0),U,4)",D="B",DZ=X K DO D DQ^DICQ K DIC S DIC=DIE D DO^DIC1
 Q
