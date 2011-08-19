SROAPRT3 ;BIR/MAM - PRINT OPERATION INFO ;01/23/07
 ;;3.0; Surgery ;**38,47,63,81,88,95,125,142,153,160**;24 Jun 93;Build 7
 K SRAO S (SRAO(7),SRAO(8))="",SRA("OP")=^SRF(SRTN,"OP")
 S SRAO(2)="^1" K SROPS S SROPER=$P(SRA("OP"),"^")
 S:$L(SROPER)<49 SROPS(1)=SROPER K M,MM,MMM I $L(SROPER)>48 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 S SRA(0)=^SRF(SRTN,0),X=$P(SRA(0),"^",4) S:X X=$P(^SRO(137.45,X,0),"^") S SRAO(2)=X_"^.04"
 W !,?29,"OPERATIVE INFORMATION",!!,$J("Surgical Specialty: ",39)_$P(SRAO(2),"^")
 W !!,$J("Principal Operation: ",39)_SROPS(1) I $D(SROPS(2)) W !,?40,SROPS(2) I $D(SROPS(3)) W !,?40,SROPS(3)
 D ^SROAOTH
 S X=$P(SRA(200),"^",52),SRAO(9)=X_"^214",NYUK=$P(SRA(0),"^",10),NYUK=$S(NYUK="EM":"YES",1:"NO") S SRAO(10)=NYUK_"^.035"
 S Y=$P($G(^SRF(SRTN,"1.0")),"^",8),C=$P(^DD(130,1.09,0),"^",2) D:Y'="" Y^DIQ S SRAO(11)=Y_"^1.09"
 S NYUK=$P(SRA(200),"^",53) D YN S SRAO(12)=SHEMP_"^201"
 S Y=$P($G(^SRF(SRTN,1.1)),"^",3),C=$P(^DD(130,1.13,0),"^",2) D:Y'="" Y^DIQ S SRAO(13)=Y_"^1.13"
 D TECH^SROPRIN S SRAO(14)=SRTECH
 S X=$P(SRA(200),"^",54),SRAO(15)=X_"^340"
 S Y=$P($G(^SRF(SRTN,200.1)),"^",4),C=$P(^DD(130,443,0),"^",2) D:Y'="" Y^DIQ S SRAO(5)=Y_"^443"
 S Y=$P($G(^SRF(SRTN,200.1)),"^",6),C=$P(^DD(130,446,0),"^",2) D:Y'="" Y^DIQ S SRAO(6)=Y_"^446"
 I $E(IOST)'="P" D PAGE^SROAPAS Q:SRSOUT  W !,?29,"OPERATIVE INFORMATION",!
 W !,$J("PGY of Primary Surgeon: ",39)_$P(SRAO(9),"^") W !,$J("Emergency Case (Y/N): ",39)_$P(SRAO(10),"^")
 W !,$J("Wound Classification: ",39)_$P(SRAO(11),"^")
 W !,$J("ASA Classification: ",39)_$P(SRAO(13),"^")
 W !,$J("Principal Anesthesia Technique: ",39)_$P(SRAO(14),"^")
 W !,$J("RBC Units Transfused: ",39)_$P(SRAO(15),"^")
 W !,$J("Intraop Disseminated Cancer: ",39)_$P(SRAO(5),"^")
 W !,$J("Intraoperative Ascites: ",39)_$P(SRAO(6),"^")
 I $E(IOST)="P" W !!
 Q
YN S SHEMP=$S(NYUK="NS":"NS",NYUK="N":"NO",NYUK="Y":"YES",1:"")
 Q
LOOP ; break procedures
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<49  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
OPTIMES ; print operation times
 K SRAO F I=1:1:7 S SRAO(I)=""
 W !,?24,"OPERATION DATE/TIMES INFORMATION"
 S X=$G(^SRF(SRTN,.2)),SRAO(1)=$P(X,"^",10),SRAO(2)=$P(X,"^",2),SRAO(3)=$P(X,"^",3),SRAO(4)=$P(X,"^",12),SRAO(5)=$P(X,"^"),SRAO(6)=$P(X,"^",4),SRAO(7)=$P($G(^SRF(SRTN,1.1)),"^",8)
 F SRI=1:1:7 S Y=SRAO(SRI) I Y X ^DD("DD") S X=$P(Y,"@")_"  "_$P(Y,"@",2),SRAO(SRI)=X
 W !!,$J("Patient in Room (PIR): ",39)_SRAO(1),!,$J("Procedure/Surgery Start Time (PST): ",39)_SRAO(2),!,$J("Procedure/Surgery Finish (PF): ",39)_SRAO(3)
 W !,$J("Patient Out of Room (POR): ",39)_SRAO(4),!,$J("Anesthesia Start (AS): ",39)_SRAO(5),!,$J("Anesthesia Finish (AF): ",39)_SRAO(6),!,$J("Discharge from PACU (DPACU): ",39)_SRAO(7)
 I $E(IOST)="P" W !
 Q
