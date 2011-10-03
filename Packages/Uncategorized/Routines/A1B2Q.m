A1B2Q ;JLU/ALB; National inquiry of patients; 1/13/90
 ;;Version 1.55 (local for MAS v5 sites);;
ADD W !!,"Address:"
 I A1B2A1'="" W ?9,A1B2A1,!
 I A1B2A2'="" W ?9,A1B2A2,!
 I A1B2A3'="" W ?9,A1B2A3,!
 W ?9,$S(A1B2A4'="":A1B2A4,1:""),"  ",$S(A1B2A5'="":A1B2A5,1:"")," ",$S(A1B2A6'="":A1B2A6,1:"")
 Q
PG D HOME^%ZIS W @IOF
 Q
 ;
ST ;For end of screen.
 S DIR(0)="E" D ^DIR S A1B2E=Y
 I A1B2E D PG
 Q
 ;
B ;Entry point for inquiry display.
 S A1B2X=^A1B2(11500.1,A1B2Y,0)
 I $D(^A1B2(11500.1,A1B2Y,.11)) S A1B2X1=^(.11),A1B2A1=$P(A1B2X1,U,1),A1B2A2=$P(A1B2X1,U,2),A1B2A3=$P(A1B2X1,U,3),A1B2A4=$P(A1B2X1,U,4),A1B2A5=$S($P(A1B2X1,U,5):$P(^DIC(5,$P(A1B2X1,U,5),0),U),1:""),A1B2A6=$P(A1B2X1,U,6)
 S A1B2SS=$P(A1B2X,U),A1B2NA=$P(A1B2X,U,2),A1B2DB=$P(A1B2X,U,3),A1B2BS=$P(A1B2X,U,4),A1B2RA=$P(A1B2X,U,5),A1B2CD=$S($P(A1B2X,U,7)="S":"Seriously Ill",1:"")
 I A1B2RA S A1B2RA=$P(^DIC(25002.1,A1B2RA,0),U)
 I A1B2DB S (X2,Y)=A1B2DB D DD^%DT S A1B2DB=Y,X1=DT D ^%DTC S A1B2AG=X\365.25
 I A1B2BS S A1B2BS=$P(^DIC(23,A1B2BS,0),U)
 F A1B2LP=0:0 S A1B2LP=$O(^A1B2(11500.2,"C",A1B2Y,A1B2LP)) Q:'A1B2LP  S Y1=^A1B2(11500.2,A1B2LP,0) I $P(Y1,U,15) D AD
 F A1B2LP=0:0 S A1B2LP=$O(^A1B2(11500.4,"C",A1B2Y,A1B2LP)) Q:'A1B2LP  S Y1=^A1B2(11500.4,A1B2LP,0) I $P(Y1,U,15) D RD
 Q
 ;
AD S A1B2AS=$P(Y1,U,3)
 ;FAC^DT AD^AD SP^DC DT^DC SP^TRAN TO^TRAN TY
 S X=U_+Y1_U_$S(A1B2AS:$P(^DIC(42.4,A1B2AS,0),U),1:"")_U_$P(Y1,U,6)_U_$S($P(Y1,U,5):$P(^DG(405.2,$P(Y1,U,5),0),U),1:"")_U_$P(Y1,U,10)_U_$P(Y1,U,11)
 X ^DD("FUNC",14,1) S $P(X,U)=$P(Y1,U,8),A1B2AD(9999999-+Y1)=X
 Q
 ;
RD S A1B2DP=$P(Y1,U,5)
 S X=U_+Y1_U_$S(A1B2DP:$P(^DIC(37,A1B2DP,0),U),1:"")
 X ^DD("FUNC",14,1) S $P(X,U)=$P(Y1,U,8),A1B2RD(9999999-+Y1)=X
 Q
 ;
C ;Entry point for display.
 D PG,HD1
 W !!,"Patient: ",A1B2NA I A1B2CD'="",$S('$D(A1B2NTY):1,1:$P(A1B2NTY,U,3)) W ?45,"*** ",A1B2CD," ***"
 W !,?4,"SSN: ",A1B2SS,?41,"Service Branch: ",$E(A1B2BS,1,23)
 W !,?4,"DOB: ",A1B2DB,?51,"Rank: ",A1B2RA
 W !,?4,"Age: ",$S($D(A1B2AG):A1B2AG,1:"")
 I $D(A1B2NTY),$D(A1B2X1) D ADD
 ;Came from A1B2ZUTL to display
 I $D(A1B2ZU) D EX Q
 S A1B2L="- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - "
 S A1B2E=1
 I $D(A1B2AD) W !,A1B2L F A1B2LP=0:0 S A1B2LP=$O(A1B2AD(A1B2LP)) Q:'A1B2LP  D:$Y>(IOSL-5) ST Q:'A1B2E  D WA
 I $D(A1B2RD) W !!,A1B2L F A1B2LP=0:0 S A1B2LP=$O(A1B2RD(A1B2LP)) Q:'A1B2LP  D:$Y>(IOSL-5) ST Q:'A1B2E  D WR
 W !!!
 Q
 ;
WA W !!,"Admitted to ",$S($L($P(A1B2AD(A1B2LP),U))>2:$E($P(A1B2AD(A1B2LP),U),1,26),1:"UNKNOWN")," on "
 S Y=$P(A1B2AD(A1B2LP),U,2) D DT^DIO2 W " to ",$P(A1B2AD(A1B2LP),U,3)
 I $L($P(A1B2AD(A1B2LP),U,4))>2 W !," Discharged from ",$S($L($P(A1B2AD(A1B2LP),U))>2:$E($P(A1B2AD(A1B2LP),U),1,26),1:"UNKNOWN")," on "
 I $L($P(A1B2AD(A1B2LP),U,4))>2 S Y=$P(A1B2AD(A1B2LP),U,4) D DT^DIO2 W " for ",$P(A1B2AD(A1B2LP),U,5)
 I $L($P(A1B2AD(A1B2LP),U,6))>2 W !,"  Transferred to ",$P(A1B2AD(A1B2LP),U,6),$S($P(A1B2AD(A1B2LP),U,7)=0:" (VAMC)",1:" (UNKNOWN)")
 Q
 ;
WR W !!,"Registered at ",$S($L($P(A1B2RD(A1B2LP),U))>2:$E($P(A1B2RD(A1B2LP),U),1,26),1:"UNKNOWN")," on "
 S Y=$P(A1B2RD(A1B2LP),U,2) D DT^DIO2 W " for ",$P(A1B2RD(A1B2LP),U,3)
 Q
 ;
HD1 ;Header for inquiry report.
 W !,?25,"*** ODS Patient Inquiry ***"
 ;;;W !,"------------------------------------------------------------------------------"
 Q
 ;
EX ;Kill point.
 K DIC,A1B2X,A1B2SS,A1B2NA,A1B2DB,A1B2BS,A1B2AD,A1B2RD,A1B2DP,A1B2AS,Y,A1B2LP,A1B2Y,A1B2E,A1B2RA,DIR,Y1,A1B2CD,A1B2Y3,Y2,Y3,A1B2A1,A1B2A2,A1B2A3,A1B2A4,A1B2A5,A1B2A6,A1B2X1,X,A1B2L,A1B2AG
 Q
 ;
A ;Entry point for inquiry lookup.
 S DIC="^A1B2(11500.1,",DIC(0)="AEMQ",DIC("A")="Select Patient: "
 S DIC("S")="I $P(^(0),U,8)=1 N X S X=$S($D(A1B2NTY):$P(A1B2NTY,U,2),1:"""") I $S(X=""""!(X=""A""):1,X=""V"":$D(^A1B2(11500.1,+Y,""NET"",""B"",+A1B2FN))>9,X=""R"":$D(^A1B2(11500.1,+Y,""NET"",""AR"",+A1B2VRG))>9,1:0)"
 D ^DIC K DIC I 'Y!(Y<0) Q
 S A1B2Y=+Y
 D B,C,EX G A
