SROACS ;B'HAM ISC/MAM - SET SRAO ARRAY ; 4 MAR 1992 12:10 pm
 ;;3.0; Surgery ;;24 Jun 93
 S SRA(205)=$G(^SRF(SRTN,205))
 S NYUK=$P(SRA(205),"^",5) D YN S SRAO(1)=SHEMP_"^403",NYUK=$P(SRA(205),"^",6) D YN S SRAO("1A")=SHEMP_"^248",NYUK=$P(SRA(205),"^",7) D YN S SRAO("1B")=SHEMP_"^249",NYUK=$P(SRA(205),"^",8) D YN S SRAO("1C")=SHEMP_"^404"
 S NYUK=$P(SRA(205),"^",9) D YN S SRAO(2)=SHEMP_"^318",NYUK=$P(SRA(205),"^",10) D YN S SRAO("2A")=SHEMP_"^251",NYUK=$P(SRA(205),"^",11) D YN S SRAO("2B")=SHEMP_"^412",NYUK=$P(SRA(205),"^",12) D YN S SRAO("2C")=SHEMP_"^252"
 S NYUK=$P(SRA(205),"^",13) D YN S SRAO("2D")=SHEMP_"^285",X=$P(SRA(205),"^",14) S:X X=$P(^ICD9(X,0),"^") S SRAO("2E")=X_"^253"
 S NYUK=$P(SRA(205),"^",15) D YN S SRAO(3)=SHEMP_"^319",NYUK=$P(SRA(205),"^",16) D YN S SRAO("3A")=SHEMP_"^409",NYUK=$P(SRA(205),"^",17) D YN S SRAO("3B")=SHEMP_"^254",NYUK=$P(SRA(205),"^",18) D YN S SRAO("3C")=SHEMP_"^255"
 S X=$P(SRA(205),"^",19) S:X X=$P(^ICD9(X,0),"^") S SRAO("3D")=X_"^286"
 S NYUK=$P(SRA(205),"^",20) D YN S SRAO(4)=SHEMP_"^320",NYUK=$P(SRA(205),"^",21) D YN S SRAO("4A")=SHEMP_"^256",NYUK=$P(SRA(205),"^",22) D YN S SRAO("4B")=SHEMP_"^410",NYUK=$P(SRA(205),"^",23) D YN S SRAO("4C")=SHEMP_"^287"
 S X=$P(SRA(205),"^",24) S:X X=$P(^ICD9(X,0),"^") S SRAO("4D")=X_"^343"
 S NYUK=$P(SRA(205),"^",25) D YN S SRAO(5)=SHEMP_"^321",NYUK=$P(SRA(205),"^",26) D YN S SRAO("5A")=SHEMP_"^411",NYUK=$P(SRA(205),"^",27) D YN S SRAO("5B")=SHEMP_"^258",NYUK=$P(SRA(205),"^",28) D YN S SRAO("5C")=SHEMP_"^259"
 S X=$P(SRA(205),"^",29) S:X X=$P(^ICD9(X,0),"^") S SRAO("5D")=X_"^344"
 S NYUK=$P(SRA(205),"^",30) D YN S SRAO(6)=SHEMP_"^322",NYUK=$P(SRA(205),"^",31) D YN S SRAO("6A")=SHEMP_"^345",NYUK=$P(SRA(205),"^",32) D YN S SRAO("6B")=SHEMP_"^257"
 S NYUK=$P(SRA(205),"^",33) D YN S SRAO("6C")=SHEMP_"^261",NYUK=$P(SRA(205),"^",34) D YN S SRAO("6D")=SHEMP_"^263",NYUK=$P(SRA(205),"^",35) D YN S SRAO("6E")=SHEMP_"^250"
 S X=$P(SRA(205),"^",36) S:X X=$P(^ICD9(X,0),"^") S SRAO("6F")=X_"^392"
DISP ; display complications
 W @IOF,!,SRANAME,?65,"PAGE: 2 OF 2",! F I=1:1:80 W "-"
 W !,"1. WOUND COMPLICATIONS:",?32,$P(SRAO(1),"^"),?39,"4. CNS COMPLICATIONS:",?76,$P(SRAO(4),"^")
 W !,"   A. Superficial Infection:",?32,$P(SRAO("1A"),"^"),?39,"   A. Cerebral Vascular Accident:",?76,$P(SRAO("4A"),"^")
 W !,"   B. Deep Wound Infection:",?32,$P(SRAO("1B"),"^"),?39,"   B. Coma > 24 Hours:",?76,$P(SRAO("4B"),"^")
 W !,"   C. Wound Dehiscence:",?32,$P(SRAO("1C"),"^"),?39,"   C. Neurological Deficits:",?76,$P(SRAO("4C"),"^"),!,?39,"   D. Other (ICD9): "_$P(SRAO("4D"),"^")
 W !!,"2. RESPIRATORY COMPLICATIONS:",?32,$P(SRAO(2),"^"),?39,"5. CARDIAC COMPLICATIONS:",?76,$P(SRAO(5),"^")
 W !,"   A. Pneumonia:",?32,$P(SRAO("2A"),"^"),?39,"   A. Arrest Requiring CPR:",?76,$P(SRAO("5A"),"^")
 W !,"   B. Unplanned Intubation:",?32,$P(SRAO("2B"),"^"),?39,"   B. Myocardial Infarction:",?76,$P(SRAO("5B"),"^")
 W !,"   C. Pulmonary Embolism:",?32,$P(SRAO("2C"),"^"),?39,"   C. Pulmonary Edema:",?76,$P(SRAO("5C"),"^"),!,"   D. On Ventilator > 48 Hours:",?32,$P(SRAO("2D"),"^"),?39,"   D. Other (ICD9): "_$P(SRAO("5D"),"^")
 W !,"   E. Other (ICD9): "_$P(SRAO("2E"),"^")
 W !!,"3. URINARY TRACT COMPLICATIONS: ",?32,$P(SRAO(3),"^"),?39,"6. OTHER COMPLICATIONS:",?76,$P(SRAO(6),"^")
 W !,"   A. Renal Insufficiency: ",?32,$P(SRAO("3A"),"^"),?39,"   A. Ileus/Bowel Obstruction:",?76,$P(SRAO("6A"),"^")
 W !,"   B. Acute Renal Failure:",?32,$P(SRAO("3B"),"^"),?39,"   B. Bleeding/Transfusions:",?76,$P(SRAO("6B"),"^")
 W !,"   C. Urinary Tract Infection:",?32,$P(SRAO("3C"),"^"),?39,"   C. Graft/Prosthesis Failure:",?76,$P(SRAO("6C"),"^")
 W !,"   D. Other (ICD9): ",$P(SRAO("3D"),"^"),?39,"   D. DVT/Thrombophlebitis:",?76,$P(SRAO("6D"),"^"),!,?39,"   E. Systemic Sepsis: ",?76,$P(SRAO("6E"),"^")
 W !,?39,"   F. Other (ICD9): "_$P(SRAO("6F"),"^")
 W ! F LINE=1:1:80 W "-"
 Q
YN ; store answer
 S SHEMP=$S(NYUK="NS":"NS",NYUK="N":"NO",NYUK="Y":"YES",1:"")
 Q
