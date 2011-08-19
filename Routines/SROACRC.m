SROACRC ;B'HAM ISC/MAM - CARDIAC COMPLICATION DATA ; 5 MAR 1992  8:15 am
 ;;3.0; Surgery ;;24 Jun 93
 S SRA(208)=$G(^SRF(SRTN,208)),SRA(205)=$G(^SRF(SRTN,205))
 S NYUK=$P(SRA(208),"^") D YN S SRAO(1)=SHEMP_"^384",NYUK=$P($G(^DPT(DFN,.35)),"^") S:NYUK NYUK=$E(NYUK,4,5)_"/"_$E(NYUK,6,7)_"/"_$E(NYUK,2,3) S SRAO(2)=NYUK
 S NYUK=$P(SRA(208),"^",2) D YN S SRAO(3)=SHEMP_"^385",NYUK=$P(SRA(208),"^",3) D YN S SRAO(4)=SHEMP_"^386",NYUK=$P(SRA(205),"^",17) D YN S SRAO(5)=SHEMP_"^254",NYUK=$P(SRA(208),"^",4) D YN S SRAO(6)=SHEMP_"^387"
 S NYUK=$P(SRA(208),"^",5) D YN S SRAO(7)=SHEMP_"^388",NYUK=$P(SRA(208),"^",6) D YN S SRAO(8)=SHEMP_"^389",NYUK=$P(SRA(205),"^",13) D YN S SRAO(9)=SHEMP_"^285"
 S NYUK=$P(SRA(208),"^",7) D YN S SRAO(10)=SHEMP_"^391",NYUK=$P(SRA(205),"^",22) D YN S SRAO(11)=SHEMP_"^410",NYUK=$P(SRA(208),"^",8) D YN S SRAO(12)=SHEMP_"^390",NYUK=$P(SRA(205),"^",26) D YN S SRAO(13)=SHEMP_"^411"
 W @IOF,!,SRANAME,?67,"PAGE: 1",! F I=1:1:80 W "-"
 W !!," 1. Operative Death:",?53,$P(SRAO(1),"^"),!," 2. Date of Death:",?53,$P(SRAO(2),"^"),!!," 3. Perioperative MI:",?53,$P(SRAO(3),"^"),!," 4. Endocarditis:",?53,$P(SRAO(4),"^")
 W !," 5. Renal Failure Requiring Dialysis:",?53,$P(SRAO(5),"^"),!," 6. Low Cardiac Output  > or = 6 Hours:",?53,$P(SRAO(6),"^"),!," 7. Mediastinitis:",?53,$P(SRAO(7),"^")
 W !," 8. Reoperation for Bleeding:",?53,$P(SRAO(8),"^"),!," 9. On Ventilator > or = 48 Hours:",?53,$P(SRAO(9),"^"),!,"10. Repeat Cardiopulmonary Bypass:",?53,$P(SRAO(10),"^")
 W !,"11. Coma > or = 24 Hours:",?53,$P(SRAO(11),"^"),!,"12. Stroke:",?53,$P(SRAO(12),"^"),!,"13. Cardiac Arrest Requiring CPR:",?53,$P(SRAO(13),"^"),!! F MOE=1:1:80 W "-"
 Q
YN ; store answer
 S SHEMP=$S(NYUK="NS":"NS",NYUK="N":"NO",NYUK="Y":"YES",1:"")
 Q
