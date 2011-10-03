DGHELP ;ALB/JDS - EXECUTABLE ADT HELP PROMPTS ; 14 JUN 84  11:29
 ;;5.3;Registration;;Aug 13, 1993
 ;
EN ;called from ques node on dispo multiple
 Q
P305 W !!,"Enter a string of characters, 1-5 characters in length",!,"It must only contain:",?25,"'A' for Aide and Assistance amount"
 W !?25,"'H' for HB amount",!?25,"'S' for Social Security amount",!?25,"'R' for Retirement pay amount",!?25,"'D' for Disability amount."
 W !?25,"'P' for Pension amount"
 Q
UP I X'?.UNP F %=1:1:$L(X) I $E(X,%)?1L S X=$E(X,0,%-1)_$C($A(X,%)-32)_$E(X,%+1,999)
 Q
IN S %=0 D UP I X]""&(Z[(U_X)) F I=$F(Z,U_X):1 S %=$E(Z,I) Q:%=U!(%']"")  W %
 E  S %=-1
 S:'% X=$E(X,1) K Z
 Q
LOCK I '$D(^XUSEC("DG ELIGIBILITY",DUZ)),$D(^DPT(DFN,.361)) I $P(^(.361),U,1)="V" W !,"Verification of Eligibility done Eligibility Key required to edit this field" K X
 Q
LOC I '$D(^XUSEC("DG ELIGIBILITY",DUZ)) W !,"Eligibility Key required to edit this field" K X
 Q
DOB S Y=$P(^DPT(DA,0),U,3) I Y,X<(100000+Y) K X X ^DD("DD") W !,"Patient's DOB is ",Y
 Q
SSN I X'?.UN F %=1:1:$L(X) I $E(X,%)?1P S X=$E(X,0,%-1)_$E(X,%+1,999)
