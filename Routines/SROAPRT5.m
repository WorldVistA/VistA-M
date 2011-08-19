SROAPRT5 ;BIR/MAM - PRINT ASSESSMENT (CONT) ;01/14/08
 ;;3.0; Surgery ;**38,88,153,166**;24 Jun 93;Build 6
 K SRA S SRA(203)=$G(^SRF(SRTN,203)),SRA(204)=$G(^SRF(SRTN,204))
 W:$E(IOST)="P" ! W !,?22,"POSTOPERATIVE LABORATORY RESULTS",!!,?29," * Highest Value",!,?29,"** Lowest Value"
 W !!,$J("* Anion Gap: ",39) S X=$P(SRA(203),"^",16) W X S X=$P(SRA(204),"^",16) I X D DATE W ?48,"("_Y_")"
 W !,$J("* Serum Sodium: ",39) S X=$P(SRA(203),"^") W X S X=$P(SRA(204),"^") I X D DATE W ?48,"("_Y_")"
 W !,$J("** Serum Sodium: ",39) S X=$P(SRA(203),"^",2) W X S X=$P(SRA(204),"^",2) I X D DATE W ?48,"("_Y_")"
 W !,$J("* Potassium: ",39) S X=$P(SRA(203),"^",3) W X S X=$P(SRA(204),"^",3) I X D DATE W ?48,"("_Y_")"
 W !,$J("** Potassium: ",39) S X=$P(SRA(203),"^",4) W X S X=$P(SRA(204),"^",4) I X D DATE W ?48,"("_Y_")"
 W !,$J("* Serum Creatinine: ",39) S X=$P(SRA(203),"^",6) W X S X=$P(SRA(204),"^",6) I X D DATE W ?48,"("_Y_")"
 W !,$J("* CPK: ",39) S X=$P(SRA(203),"^",7) W X S X=$P(SRA(204),"^",7) I X D DATE W ?48,"("_Y_")"
 W !,$J("* CPK-MB Band: ",39) S X=$P(SRA(203),"^",8) W X S X=$P(SRA(204),"^",8) I X D DATE W ?48,"("_Y_")"
 W !,$J("* Total Bilirubin: ",39) S X=$P(SRA(203),"^",9) W X S X=$P(SRA(204),"^",9) I X D DATE W ?48,"("_Y_")"
 W !,$J("* White Blood Count: ",39) S X=$P(SRA(203),"^",10) W X S X=$P(SRA(204),"^",10) I X D DATE W ?48,"("_Y_")"
 W !,$J("** Hematocrit: ",39) S X=$P(SRA(203),"^",12) W X S X=$P(SRA(204),"^",12) I X D DATE W ?48,"("_Y_")"
 W !,$J("* Troponin I: ",39) S X=$P(SRA(203),"^",13) W X S X=$P(SRA(204),"^",13) I X D DATE W ?48,"("_Y_")"
 W !,$J("* Troponin T: ",39) S X=$P(SRA(203),"^",14) W X S X=$P(SRA(204),"^",14) I X D DATE W ?48,"("_Y_")"
 I $E(IOST)="P" W !!
 Q
DATE S Y=X X ^DD("DD")
 Q
