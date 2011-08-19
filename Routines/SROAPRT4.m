SROAPRT4 ;BIR/MAM - PRINT ASSESSMENT (CONT.) ;01/14/08
 ;;3.0; Surgery ;**38,125,153,160,166**;24 Jun 93;Build 6
 ;K SRA S SRA(201)=$G(^SRF(SRTN,201)),SRA(202)=$G(^SRF(SRTN,202))
 K SRA F I=201,202,203,204,202.1 S SRA(I)=$G(^SRF(SRTN,I))
 W !,?20,"PREOPERATIVE LABORATORY TEST RESULTS"
 W !!,$J("Anion Gap (in 48 hrs.): ",39) S X=$P(SRA(203),"^",15) W X S X=$P(SRA(204),"^",15) I X D DATE W ?48,"("_Y_")"
 W !,$J("Serum Sodium: ",39) S X=$P(SRA(201),"^") W X S X=$P(SRA(202),"^") I X D DATE W ?48,"("_Y_")"
 W !,$J("Serum Creatinine: ",39) S X=$P(SRA(201),"^",4) W X S X=$P(SRA(202),"^",4) I X D DATE W ?48,"("_Y_")"
 W !,$J("BUN: ",39) S X=$P(SRA(201),"^",5) W X S X=$P(SRA(202),"^",5) I X D DATE W ?48,"("_Y_")"
 W !,$J("Serum Albumin: ",39) S X=$P(SRA(201),"^",8) W X S X=$P(SRA(202),"^",8) I X D DATE W ?48,"("_Y_")"
 W !,$J("Total Bilirubin: ",39) S X=$P(SRA(201),"^",9) W X S X=$P(SRA(202),"^",9) I X D DATE W ?48,"("_Y_")"
 W !,$J("SGOT: ",39) S X=$P(SRA(201),"^",11) W X S X=$P(SRA(202),"^",11) I X D DATE W ?48,"("_Y_")"
 W !,$J("Alkaline Phosphatase: ",39) S X=$P(SRA(201),"^",12) W X S X=$P(SRA(202),"^",12) I X D DATE W ?48,"("_Y_")"
 W !,$J("White Blood Count: ",39) S X=$P(SRA(201),"^",13) W X S X=$P(SRA(202),"^",13) I X D DATE W ?48,"("_Y_")"
 W !,$J("Hematocrit: ",39) S X=$P(SRA(201),"^",14) W X S X=$P(SRA(202),"^",14) I X D DATE W ?48,"("_Y_")"
 W !,$J("Platelet Count: ",39) S X=$P(SRA(201),"^",15) W X S X=$P(SRA(202),"^",15) I X D DATE W ?48,"("_Y_")"
 W !,$J("PTT: ",39) S X=$P(SRA(201),"^",16) W X S X=$P(SRA(202),"^",16) I X D DATE W ?48,"("_Y_")"
 W !,$J("PT: ",39) S X=$P(SRA(201),"^",17) W X S X=$P(SRA(202),"^",17) I X D DATE W ?48,"("_Y_")"
 W !,$J("INR: ",39) S X=$P(SRA(201),"^",27) W X S X=$P(SRA(202),"^",27) I X D DATE W ?48,"("_Y_")"
 W !,$J("Hemoglobin A1c: ",39) S X=$P(SRA(201),"^",28) W X S X=$P(SRA(202.1),"^") I X D DATE W ?48,"("_Y_")"
 I $E(IOST)="P" W !!
 Q
DATE S Y=X X ^DD("DD")
 Q
