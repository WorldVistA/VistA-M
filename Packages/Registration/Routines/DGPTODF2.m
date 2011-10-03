DGPTODF2 ;ALB/MTC - PTF DRG FREQUENCY REPORT,CONT. ; 9/14/01 4:34pm
 ;;5.3;Registration;**375**;Aug 13, 1993
HEAD I P S %=IOSL-14 F E=$Y:1:% W !    ;I E=(%-1) D DIS^DGPTOD1
 I P D DIS^DGPTOD1 W !!
 W:P ?62,"-",P,"-" W @IOF,!!?10,"Discharge Frequency Rank for ",$S(DGFLAG'["M":G2_" SERVICE",1:"MEDICAL CENTER"),$S(DGFLAG["Spec":" by Specialty",1:"") I 'DGD W " for Active Admissions"
 I DGD W " for " S Y=DGSD+.1 X ^DD("DD") W $P(Y,"@",1)," TO " S Y=DGED X ^DD("DD") W $P(Y,"@",1)
 W ?110,"Printed: " S Y=DT D DT^DIQ W !?15,$S(DGB:"",1:"Not "),"Including Transfer DRGs",!
 W !?11,H3,!?10,H,?50,"Total 1      Total #      Total       ALOS/",?123,"Average",!?10,H1,?49,"Day Stays    Discharges     LOS      Discharge    (*)Total Weight         Weight",!
 K E S $P(E,"=",133)="" W E K E
 S P=P+1 Q
COV K ^UTILITY($J,"DGTC"),DGCPG,DGTCH S DGCPG(1)="DRG FREQUENCY Report by "_DGFLAG,DGCPG(2)=$S(DGD:"for Discharge Dates Between ",1:"Active Admissions")
 I DGD S Y=DGSD+.1 X ^DD("DD") S %=Y,Y=$P(DGED,".") X ^DD("DD") S DGCPG(2)=DGCPG(2)_%_" to "_Y,DGCPG(3)=$S('DGB:"not ",1:"")_"including TRANSFER DRGs"
 S DGTCH="DRG FREQUENCY by "_P3_"^"_P3_"^PAGE #" D C^DGUTL Q
FD F I=0:0 S I=$O(^UTILITY($J,"DGPTFR","D",I)) Q:I'>0  S J=^(I),S=$S($D(^(I,"AT")):$P(^("AT"),U,3),1:0) D FD1
 I "SB"[DGS,$D(^UTILITY($J,"DGPTFR","SB")) S I=0 F I1=0:0 S I=$O(^UTILITY($J,"DGPTFR","SB",I)) Q:I']""  S S=^(I) F J=0:0 S J=$O(^UTILITY($J,"DGPTFR","SB",I,J)) Q:J'>0  S B=^(J) D E1
 Q
E1 F D=0:0 S D=$O(^UTILITY($J,"DGPTFR","SB",I,J,D)) Q:D'>0  S D1=^(D),T=$S($D(^(D,"AT")):$P(^("AT"),U,3),1:0),T1=$S($D(^UTILITY($J,"DGPTFR","SB",I,J,D,"BT")):$P(^("BT"),U,4,5)_U_$P(^("BT"),U,2),1:0_U_0),^UTILITY($J,"DGPTFR","FS",I)=S D E2
 Q
E2 S $P(^(D),U)=+D1+$S($D(^UTILITY($J,"DGPTFR","FS",I,D)):$P(^(D),U),1:0),$P(^(D),U,2)=$P(^(D),U,2)+$P(D1,U,2),$P(^(D),U,3,8)=$P(D1,U,3,8),$P(^(D),U,9)=$P(^(D),U,9)+T,$P(^(D),U,10)=+T1+$P(^(D),U,10),$P(^(D),U,11)=$P(^(D),U,11)+$P(T1,U,2)
 S $P(^(D),U,12)=$P(^UTILITY($J,"DGPTFR","FS",I,D),U,12)+$P(T1,U,3),^UTILITY($J,"DGPTFR","FB",I)=S,^(I,J)=B,^(J,(999999-$P(D1,U,2)),D)=D1_U_T_U_T1 Q
FD1 S S1=$S($D(^UTILITY($J,"DGPTFR","D",I,"BT")):$P(^("BT"),U,4,5),1:0_U_0),$P(S1,U,3)=$S($D(^("BT")):$P(^("BT"),U,2),1:0)+$P(S1,U,3),^UTILITY($J,"DGPTFR","FD",(999999-$P(J,U,2)),I)=J_U_S_U_S1 Q
