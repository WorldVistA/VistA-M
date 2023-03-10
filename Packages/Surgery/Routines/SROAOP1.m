SROAOP1 ;BIR/MAM - SET OPERATION INFO ;02/28/07
 ;;3.0;Surgery;**38,47,63,81,88,95,97,125,142,153,160,177,182,200**;24 Jun 93;Build 9
 N SRCSTAT K SRA,SRAO F I=0,200,"OP" S SRA(I)=$G(^SRF(SRTN,I))
 S SRDOC="Primary Surgeon: "_$P(^VA(200,$P(^SRF(SRTN,.1),"^",4),0),"^") F I=4,5,6 S SRAO(I)=""
 K SROPS S SROPER=$P(SRA("OP"),"^")
 S SRAO(2)="^26"
 S:$L(SROPER)<49 SROPS(1)=SROPER K M,MM,MMM I $L(SROPER)>48 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 S X=$P(SRA(0),"^",4) S:X X=$P(^SRO(137.45,X,0),"^",1) S SRAO(1)=X_"^.04"
 S SRHDR(.5)=SRDOC,SRPAGE="PAGE: 1 OF 2"
 S SRCSTAT=">> Coding "_$S($P($G(^SRO(136,SRTN,10)),"^"):"",1:"Not ")_"Complete <<"
 D HDR^SROAUTL
 S X=$P($G(^SRO(136,SRTN,0)),"^",3) S:X X=$$ICD^SROICD(SRTN,X),X=$P(X,"^",2)_"   "_$P(X,"^",4)
 W "Postop Diagnosis Code "_$$ICDSTR^SROICD(SRTN)_": ",$S(X'="":X,1:"NOT ENTERED"),!
 W !," 1. Surgical Specialty: ",?33,$P(SRAO(1),"^"),!," 2. Principal Operation: ",?33,SROPS(1) I $D(SROPS(2)) W !,?33,SROPS(2) I $D(SROPS(3)) W !,?33,SROPS(3) I $D(SROPS(4)) W !,?33,SROPS(4)
 S Y=$P(SRA("OP"),"^",3),C=$P(^DD(130,2006,0),"^",2) D:Y'="" Y^DIQ S:$G(Y)']"" Y="NOT ENTERED" S SRAO(3)=Y_"^2006"
 W !," 3. Robotic Assistance (Y/N):",?33,$P(SRAO(3),"^")
 N SRPROC,SRL S SRL=49 D CPTS^SROAUTL0 W !," 4. CPT Codes (view only):" I SRPROC(1)="" S SRPROC(1)="NOT ENTERED"
 F I=1:1 Q:'$D(SRPROC(I))  W:I=1 ?33,SRPROC(I) W:I'=1 !,?33,SRPROC(I)
 W !," 5. Other Procedures:" W:$O(^SRF(SRTN,13,0)) ?33,"***INFORMATION ENTERED***"
 W !," 6. Concurrent Procedure:" S CON=$P($G(^SRF(SRTN,"CON")),"^") I CON,'($P($G(^SRF(CON,30)),"^")!($P($G(^SRF(CON,31)),"^",8))) W ?33,"***INFORMATION ENTERED***"
 S X=$P(SRA(200),"^",52),SRAO(7)=X_"^214",NYUK=$P(SRA(0),"^",10) D EMERG S SRAO(8)=SHEMP_"^.035"
 S Y=$P($G(^SRF(SRTN,"1.0")),"^",8),C=$P(^DD(130,1.09,0),"^",2) D:Y'="" Y^DIQ S SRAO(9)=Y_"^1.09"
 S Y=$P($G(^SRF(SRTN,1.1)),"^",3),C=$P(^DD(130,1.13,0),"^",2) D:Y'="" Y^DIQ S SRAO(10)=Y_"^1.13"
 D TECH^SROPRIN S SRAO(11)=SRTECH
 S X=$P(SRA(200),"^",54),SRAO(12)=X_"^340" K SRA(.2)
 S Y=$P($G(^SRF(SRTN,200.1)),"^",4) D
 .I Y="" S (Y,$P(^SRF(SRTN,200.1),"^",4))="N"
 .S C=$P(^DD(130,443,0),"^",2) D:Y'="" Y^DIQ S SRAO(13)=Y_"^443"
 S Y=$P($G(^SRF(SRTN,200.1)),"^",6) D
 .I Y="" S (Y,$P(^SRF(SRTN,200.1),"^",6))="N"
 .S C=$P(^DD(130,446,0),"^",2) D:Y'="" Y^DIQ S SRAO(14)=Y_"^446"
 W !," 7. PGY of Primary Surgeon:",?33,$P(SRAO(7),"^"),!," 8. Surgical Priority:",?33,$P(SRAO(8),"^"),!," 9. Wound Classification: ",?33,$P(SRAO(9),"^")
 W !,"10. ASA Classification:",?33,$P(SRAO(10),"^")
 W !,"11. Princ. Anesthesia Technique: ",$P(SRAO(11),"^")
 W !,"12. RBC Units Transfused:",?33,$P(SRAO(12),"^")
 W !,"13. Intraop Disseminated Cancer:",?33,$P(SRAO(13),"^")
 W !,"14. Intraoperative Ascites:",?33,$P(SRAO(14),"^")
 W ! F LINE=1:1:80 W "-"
 Q
YN S SHEMP=$S(NYUK="NS":"NS",NYUK="N":"NO",NYUK="Y":"YES",1:"")
 Q
LOOP ; break procedures
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<49  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
EMERG ; surgical priority
 I NYUK="" S SHEMP="" Q
 S Y=NYUK,C=$P(^DD(130,.035,0),"^",2) D Y^DIQ S SHEMP=Y
 Q
