SROALN3 ;BIR/MAM - LAB INFO ;06/27/06
 ;;3.0; Surgery ;**38,47,88,153**;24 Jun 93;Build 11
 F SHEMP=203,204 S SRA(SHEMP)=$G(^SRF(SRTN,SHEMP))
 S SHEMP=$P(SRA(203),"^",16),SRAO(1)=SHEMP_"^^445^445.1" S X=$P(SRA(204),"^",16) I X D DATE S SHEMP="("_Y_")",$P(SRAO(1),"^",2)=SHEMP
 S SHEMP=$P(SRA(203),"^"),SRAO(2)=SHEMP_"^^274^305" S X=$P(SRA(204),"^") I X D DATE S SHEMP="("_Y_")",$P(SRAO(2),"^",2)=SHEMP
 S SHEMP=$P(SRA(203),"^",2),SRAO(3)=SHEMP_"^^405^407" S X=$P(SRA(204),"^",2) I X D DATE S SHEMP="("_Y_")",$P(SRAO(3),"^",2)=SHEMP
 S SHEMP=$P(SRA(203),"^",3),SRAO(4)=SHEMP_"^^275^306" S X=$P(SRA(204),"^",3) I X D DATE S SHEMP="("_Y_")",$P(SRAO(4),"^",2)=SHEMP
 S SHEMP=$P(SRA(203),"^",4),SRAO(5)=SHEMP_"^^406^408" S X=$P(SRA(204),"^",4) I X D DATE S SHEMP="("_Y_")",$P(SRAO(5),"^",2)=SHEMP
 S SHEMP=$P(SRA(203),"^",6),SRAO(6)=SHEMP_"^^277^308" S X=$P(SRA(204),"^",6) I X D DATE S SHEMP="("_Y_")",$P(SRAO(6),"^",2)=SHEMP
 S SHEMP=$P(SRA(203),"^",7),SRAO(7)=SHEMP_"^^278^309" S X=$P(SRA(204),"^",7) I X D DATE S SHEMP="("_Y_")",$P(SRAO(7),"^",2)=SHEMP
 S SHEMP=$P(SRA(203),"^",8),SRAO(8)=SHEMP_"^^279^310" S X=$P(SRA(204),"^",8) I X D DATE S SHEMP="("_Y_")",$P(SRAO(8),"^",2)=SHEMP
 S SHEMP=$P(SRA(203),"^",9),SRAO(9)=SHEMP_"^^280^311" S X=$P(SRA(204),"^",9) I X D DATE S SHEMP="("_Y_")",$P(SRAO(9),"^",2)=SHEMP
 S SHEMP=$P(SRA(203),"^",10),SRAO(10)=SHEMP_"^^281^312" S X=$P(SRA(204),"^",10) I X D DATE S SHEMP="("_Y_")",$P(SRAO(10),"^",2)=SHEMP
 S SHEMP=$P(SRA(203),"^",12),SRAO(11)=SHEMP_"^^283^314" S X=$P(SRA(204),"^",12) I X D DATE S SHEMP="("_Y_")",$P(SRAO(11),"^",2)=SHEMP
 S SHEMP=$P(SRA(203),"^",13),SRAO(12)=SHEMP_"^^455^455.1" S X=$P(SRA(204),"^",13) I X D DATE S SHEMP="("_Y_")",$P(SRAO(12),"^",2)=SHEMP
 S SHEMP=$P(SRA(203),"^",14),SRAO(13)=SHEMP_"^^456^456.1" S X=$P(SRA(204),"^",14) I X D DATE S SHEMP="("_Y_")",$P(SRAO(13),"^",2)=SHEMP
 S SRPAGE="PAGE: 2 OF 2",SRHDR(.5)="POSTOP LAB RESULTS WITHIN 30 DAYS AFTER SURGERY" D HDR^SROAUTL
 W !," 1. Highest Anion Gap:",?30,$J($P(SRAO(1),"^"),6),?40,$P(SRAO(1),"^",2)
 W !," 2. Highest Serum Sodium:",?30,$J($P(SRAO(2),"^"),6),?40,$P(SRAO(2),"^",2)
 W !," 3. Lowest Serum Sodium:",?30,$J($P(SRAO(3),"^"),6),?40,$P(SRAO(3),"^",2)
 W !," 4. Highest Potassium:",?30,$J($P(SRAO(4),"^"),6),?40,$P(SRAO(4),"^",2)
 W !," 5. Lowest Potassium:",?30,$J($P(SRAO(5),"^"),6),?40,$P(SRAO(5),"^",2)
 W !," 6. Highest Serum Creatinine: ",?30,$J($P(SRAO(6),"^"),6),?40,$P(SRAO(6),"^",2)
 W !," 7. Highest CPK: ",?30,$J($P(SRAO(7),"^"),6),?40,$P(SRAO(7),"^",2)
 W !," 8. Highest CPK-MB Band: ",?30,$J($P(SRAO(8),"^"),6),?40,$P(SRAO(8),"^",2)
 W !," 9. Highest Total Bilirubin: ",?30,$J($P(SRAO(9),"^"),6),?40,$P(SRAO(9),"^",2)
 W !,"10. Highest WBC:",?30,$J($P(SRAO(10),"^"),6),?40,$P(SRAO(10),"^",2)
 W !,"11. Lowest Hematocrit:",?30,$J($P(SRAO(11),"^"),6),?40,$P(SRAO(11),"^",2)
 W !,"12. Highest Troponin I:",?30,$J($P(SRAO(12),"^"),6),?40,$P(SRAO(12),"^",2)
 W !,"13. Highest Troponin T:",?30,$J($P(SRAO(13),"^"),6),?40,$P(SRAO(13),"^",2)
 W !! F MOE=1:1:80 W "-"
 Q
DATE S Y=X X ^DD("DD")
 Q
