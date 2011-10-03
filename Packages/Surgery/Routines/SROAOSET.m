SROAOSET ;B'HAM ISC/MAM - SET SRAO ARRAY ; 17 MAR 1992 1:55 pm
 ;;3.0; Surgery ;**127**;24 Jun 93
 S SRA(0)=^SRF(SRTN,0),SRA(34)=$G(^SRF(SRTN,34)),X=$P(SRA(34),"^",2) S:X X=$$ICDDX^ICDCODE(X,$P(SRA(0),"^",9)),X=$P(X,"^",2)_"   "_$P(X,"^",4) S SRAO(1)=X_"^66" K SRA(34)
 S SRA(205)=$G(^SRF(SRTN,205)),X=$P(SRA(205),"^") S:X X=X_" DAYS" S SRAO(2)=X_"^247"
 S X=$P(SRA(205),"^",2),X=$S(X="":"",X=1:"DISCHARGED ALIVE",X=2:"DIED IN HOSPITAL",X=3:"REMAINS IN VAMC FACILITY",X=4:"TRANSFERRED TO ANOTHER VAMC",X=5:"READMITTED",X="NS":"NO STUDY",1:"")
 S SRAO(3)=X_"^341"
DISP W @IOF,!,SRANAME,?65,"PAGE: 1",! F MOE=1:1:80 W "-"
 W !,"1. Postoperative Diagnosis Code (ICD9):",?43,$P(SRAO(1),"^"),!,"2. Length of Postoperative Hospital Stay:",?43,$P(SRAO(2),"^"),!,"3. 30 Day Postoperative Status:",?43,$P(SRAO(3),"^")
 W ! F MOE=1:1:80 W "-"
 Q
YN ;
 S SHEMP=$S(NYUK="NS":"NS",NYUK="N":"NO",NYUK="Y":"YES",1:"")
 Q
