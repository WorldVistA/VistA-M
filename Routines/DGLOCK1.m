DGLOCK1 ;ALB/MRL - PATIENT FILE DATA EDIT CHECK ; 28 JUL 86
 ;;5.3;Registration;**121,314**;Aug 13, 1993
AOD ;AO Delete
 I $D(^DPT(DFN,.321)),$P(^(.321),U,2)="Y" W !?4,*7,"Can't delete as long as Agent Orange exposure is indicated." K X
 Q
COMD ;Combat Delete
 I $D(^DPT(DFN,.52)),$P(^(.52),U,11)="Y" W !?4,*7,"Can't delete as long as Combat Service is indicated." K X
 Q
INED ;Ineligible Delete
 I $D(^DPT(DFN,.15)),$P(^(.15),U,2)]"" W !?4,*7,"Can't delete this field as long as 'INELIGIBLE DATE' is on file." K X
 Q
IRD ;ION Rad Delete
 I $D(^DPT(DFN,.321)),$P(^(.321),U,3)="Y" W !?4,*7,"Can't delete as long as Ionizing Radiation exposure is indicated." K X
 Q
POWD ;POW Delete
 I $D(^DPT(DFN,.52)),$P(^(.52),U,5)="Y" W !?4,*7,"Still identified as former POW...Change status to delete." K X
 Q
TADD ;Temp Add Delete
 I $D(^DPT(DFN,.121)),$P(^(.121),U,9)="Y" W !?4,*7,"Answer NO to the 'WANT TO ENTER TEMPORARY ADDRESS' prompt, then delete." K X
 Q
VND ;Viet Svc Delete
 I $D(^DPT(DFN,.321)),$P(^(.321),U,1)="Y" W !?4,*7,"Can't delete as long as Vietnam Service is still indicated." K X
 Q
SVDEL ;Panama, Grenada, Lebanon, Persian Gulf Svc Delete
 ;DGX = piece position of corresponding service indicated? field
 I $D(^DPT(DFN,.322)),$P(^(.322),U,DGX)="Y" W !?4,*7,"Can't delete as long as ",$S(DGX=1:"Lebanon",DGX=4:"Grenada",DGX=7:"Panama",1:"Persian Gulf")," is still indicated." K X
 K DGX
 Q
EC S DGEC=$S('$D(^DPT(DFN,.36)):"",$D(^DIC(8,+$P(^DPT(DFN,.36),U,1),0)):$P(^(0),U,9),1:"") I DGEC=5 W !?4,*7,"Eligibility Code is 'NSC'...Can't be YES." K X,DGEC Q
 K DGEC Q
POS ;Screen
 K DGEC D SV1^DGLOCK I $D(X) S DIC("S")="I '$P(^(0),""^"",8),$D(^DPT(DA,.36)),$D(^DIC(21,+Y,""E"",+$P(^(.36),U,1)))" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X D:'$D(X) POSH I $D(X),$D(^DIC(21,X,0)),$P(^(0),U,7)]"" D POS1 Q
 Q
POS1 S XX=$P(^DIC(21,X,0),U,7) I $P(^DPT(DA,0),U,3)]"" I $P(^(0),U,3)'>XX!($D(^XUSEC("DG ELIGIBILITY",DUZ))) K XX Q
 W !?5,*7,"Applicant is too young to have served in that period of service.",!?5,"See your supervisor if you require assistance." K X,XX Q
POSH S DGEC=$S('$D(^DPT(DFN,.36)):"",$D(^DIC(8,+$P(^(.36),U,1),0)):$P(^(0),U,1),1:"") W !?5,"Current Eligibility Code" W:DGEC]"" ": ",DGEC I DGEC']"" W " is not defined.  Must be defined in order",!?5,"to enter a POS."
 K DGEC Q
SC S DGSCON=$S('$D(^DPT(DFN,.3)):0,$P(^(.3),U,1)="Y":1,1:0) I 'DGSCON W !?4,*7,"Not possible, applicant is not service-connected." K X,DGSCON Q
 K DGSCON Q
 ;
ECD ;primary eligibility code input transform
 ;
 N DGNODE,DGPC,DGSER,DGVT,DGXX
 S DGVT=$G(^DPT(DFN,"VET")),DGSER=$S('$D(^DPT(DFN,.3)):0,$P(^(.3),U,1)="Y":1,1:0)
 I DGVT']"" K X W !?4,*7,"'VETERAN (Y/N)' prompt must be answered to select an Eligibility Code'" Q
 S DIC("S")="I $P(^DIC(8,+Y,0),U,5)=DGVT,'$P(^(0),U,7)" I DGVT="N" G ECDS
 I DGSER S DGPC=$S(+$P(^DPT(DFN,.3),U,2)>49:1,1:0),DGXX=$S(DGPC:1,1:3),DIC("S")=DIC("S")_",($P(^(0),U,9)="_DGXX_")" G ECDS ;sc only
 I $P($G(^DPT(DFN,.52)),"^",5)="Y" S DIC("S")=DIC("S")_",($P(^(0),U,9)=18)" G ECDS ;pow only
 S DGXX="^1^3^18^" ; no sc<50, sc 50-100, pow
 I $P($G(^DPT(DFN,.53)),U)="Y" S DIC("S")=DIC("S")_",($P(^(0),U,9)=22)" G ECDS ;checks for PH Indicator
 S DGXX=DGXX_"22^" ;adds PH to DGXX string
 S DGNODE=$G(^DPT(DFN,.362))
 I $P(DGNODE,"^",12)'="Y" S DGXX=DGXX_"2^"
 I $P(DGNODE,"^",14)'="Y" S DGXX=DGXX_"4^"
 I $P(DGNODE,"^",13)'="Y" S DGXX=DGXX_"15^"
 F I=12:1:14 I $P(DGNODE,"^",I)="Y" S DGXX=DGXX_"5^"_$S(I'=14:"4^",1:"")
 I $P($G(^DPT(DFN,0)),"^",3)>2200101 S DGXX=DGXX_"16^17^" ; WWI or mexican border only
 S DIC("S")=DIC("S")_",("""_DGXX_"""'[(U_$P(^(0),U,9)_U))"
ECDS D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 ;
 ;catastrophic disability can not be primary
 I $G(X),$$NATNAME^DGENELA(X)="CATASTROPHICALLY DISABLED" K X Q
 ;
 Q
