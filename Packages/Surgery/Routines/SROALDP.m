SROALDP ;BIR/MAM - DISPLAY PREOP LABS ;01/25/07
 ;;3.0; Surgery ;**38,47,81,125,153,160**;24 Jun 93;Build 7
 S SRPAGE="PAGE: 1 OF 2",SRHDR(.5)="LATEST PREOP LAB RESULTS IN 90 DAYS PRIOR TO SURGERY UNLESS OTHERWISE SPECIFIED" D HDR^SROAUTL
 W !," 1. Anion Gap (in 48 hrs.):",?31,$J($P(SRAO(1),"^"),6),?40,$P(SRAO(1),"^",2)
 W !," 2. Serum Sodium: ",?31,$J($P(SRAO(2),"^"),6),?40,$P(SRAO(2),"^",2)
 W !," 3. BUN:",?31,$J($P(SRAO(3),"^"),6),?40,$P(SRAO(3),"^",2)
 W !," 4. Serum Creatinine: ",?31,$J($P(SRAO(4),"^"),6),?40,$P(SRAO(4),"^",2)
 W !," 5. Serum Albumin:",?31,$J($P(SRAO(5),"^"),6),?40,$P(SRAO(5),"^",2)
 W !," 6. Total Bilirubin:",?31,$J($P(SRAO(6),"^"),6),?40,$P(SRAO(6),"^",2)
 W !," 7. SGOT:",?31,$J($P(SRAO(7),"^"),6),?40,$P(SRAO(7),"^",2)
 W !," 8. Alkaline Phosphatase:",?31,$J($P(SRAO(8),"^"),6),?40,$P(SRAO(8),"^",2)
 W !," 9. WBC:",?31,$J($P(SRAO(9),"^"),6),?40,$P(SRAO(9),"^",2)
 W !,"10. Hematocrit:",?31,$J($P(SRAO(10),"^"),6),?40,$P(SRAO(10),"^",2)
 W !,"11. Platelet Count:",?31,$J($P(SRAO(11),"^"),6),?40,$P(SRAO(11),"^",2)
 W !,"12. PTT: ",?31,$J($P(SRAO(12),"^"),6),?40,$P(SRAO(12),"^",2)
 W !,"13. PT: ",?31,$J($P(SRAO(13),"^"),6),?40,$P(SRAO(13),"^",2)
 W !,"14. INR: ",?31,$J($P(SRAO(14),"^"),6),?40,$P(SRAO(14),"^",2)
 W !,"15. Hemoglobin A1c (1000 days):",?31,$J($P(SRAO(15),"^"),6),?40,$P(SRAO(15),"^",2)
 W ! F MOE=1:1:80 W "-"
 Q
