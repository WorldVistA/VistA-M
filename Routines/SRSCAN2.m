SRSCAN2 ;BIR/MAM - MAKE NEW REQUEST WHEN CANCELLED ; [ 06/14/01  9:57 AM ]
 ;;3.0; Surgery ;**3,16,34,67,77,88,92,103,144**;24 Jun 93
START W !!,"Do you want to create a new request for this cancelled case ??  YES// " R SRYN:DTIME I '$T!(SRYN["^") Q
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter 'YES' to automatically move the information contained in this scheduled",!,"case to a new request, or 'NO' to not create a new request." G START
 I "Yy"'[SRYN Q
 D NEWDT
DATE W ! K %DT S %DT="AEFX",%DT("A")="Make the new request for which Date ?  ",%DT("B")=SRY D ^%DT I Y<0 S OK=1 D HELP Q:'OK  G DATE
 S SRX=+Y D CHK G:$D(SRLATE) DATE S SRNEWDT=SRX W !!,"Creating the new request..."
 K DA,DIC,DD,DO,DINUM S X=SRSDPT,DIC="^SRF(",DIC(0)="L",DLAYGO=130 D FILE^DICN K DD,DO,DIC,DLAYGO S SRTNEW=+Y
 S %X="^SRF("_SRTOLD_",",%Y="^SRF("_SRTNEW_"," D %XY^%RCR K ^SRF(SRTNEW,"PFSS")
 S SRSOP=$P(^SRF(SRTNEW,"OP"),"^"),SRSCPT=$P(^SRF(SRTNEW,"OP"),"^",2),SRSDOC=$S($D(^SRF(SRTNEW,.1)):$P(^(.1),"^",4),1:"")
 K ^SRF(SRTNEW,31),^SRF(SRTNEW,30) S $P(^SRF(SRTNEW,0),"^",2)=""
 N SREQ D NOW^%DTC S SREQ(130,SRTNEW_",",1.098)=+$E(%,1,12),SREQ(130,SRTNEW_",",1.099)=DUZ D FILE^DIE("","SREQ","^TMP(""SR"",$J)")
 S DR="36////1;Q;.09////"_SRNEWDT_";26////"_SRSOP,DA=SRTNEW,DIE=130 D ^DIE
 K DR,DA S DR="[SRO-NOCOMP]",DA=SRTNEW,DIE=130 D ^DIE K DR
 K DR S DIE=130,DA=SRTNEW,DR="68////"_SRSOP D ^DIE K DR
 S SRATT=$P($G(^SRF(SRTN,.1)),"^",13)
 K DIE,DR,DA S DIE=130,DA=SRTNEW,DR=".14////"_SRSDOC_";.164////"_SRATT_";.04////"_$P(^SRF(SRTN,0),"^",4) D ^DIE K DR S SRTN=SRTNEW D ^SROXRET
 I $D(^SRF(SRTNEW,"CON")) S DA=SRTNEW,DIE=130,DR="35///@" D ^DIE K DR,DA
 D NOW^%DTC S SRCAN=+$E(%,1,12),DA=SRTOLD,DIE=130,DR=".02///@;17////"_SRCAN D ^DIE K DR
 S $P(^SRF(SRTOLD,31),"^",4)="",$P(^(31),"^",5)=""
 S SRTN=SRTNEW D ^SROERR S SRTN=SRTOLD
 Q
HELP W !!,"To make a new request, you must select a future date.  Do you want to select",!,"another date ?  YES// " R X:DTIME I '$T!(X["^") S OK=0 Q
 S X=$E(X) I "YyNn"'[X W !!,"Enter 'YES' to select another date, or 'NO' to bypass making a new request." G HELP
 I "Yy"'[X S OK=0
 Q
NEWDT ; get six month default date for new request
 S SRX1=$E($P(^SRF(SRTOLD,0),"^",9),1,7),SRX2=182 K SRCHK D DAY S Y=SRX D D^DIQ S SRY=Y
 Q
CHK ; check for valid request date
 N SRSDATE S SRSDATE=SRX K SRLATE D LATE^SRSREQ
 Q
DAY ; get valid default request date
 S X1=SRX1,X2=SRX2 D C^%DTC I X<DT S SRX1=DT,SRX2=1 G DAY
 S SRX=X K DIC S DIC=40.5,DIC(0)="XM" D ^DIC K DIC
 I Y'=-1,'$D(^SRO(133,SRSITE,3,X,0)) S SRX2=SRX2+1 G DAY
 S X=SRX D H^%DTC S SRDAY=%Y+1 S SRDL=$P($G(^SRO(133,SRSITE,2)),"^",SRDAY) S:SRDL="" SRDL=1 I 'SRDL S SRX2=SRX2+1 G DAY
 Q:'$D(SRSITE("REQ"))  S X1=SRX,X2=-SRDL D C^%DTC S SRDTL=X S DIC=40.5,DIC(0)="XM" D ^DIC K DIC I Y'=-1,'$D(^SRO(133,SRSITE,3,X,0)) S SRX2=SRX2+1 G DAY
 S SRTCHK=SRDTL_"."_SRSITE("REQ") D NOW^%DTC I %>SRTCHK S SRX2=SRX2+1 G DAY
 Q
