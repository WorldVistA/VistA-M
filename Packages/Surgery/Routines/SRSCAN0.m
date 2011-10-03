SRSCAN0 ;B'HAM ISC/MAM - CANCEL SCHEDULED OPERATIONS (CONT) ;03/21/02  10:24 PM
 ;;3.0; Surgery ;**34,42,67,103,107,114,100,144**;24 Jun 93
 ;
 ; Reference to ^TMP("CSLSUR1" supported by DBIA #3498
 ;
CUT S X1=SRSDATE,X2=-1 D C^%DTC S SRSDT=X,X=$P($G(^SRO(133,SRSITE,0)),"^",12) S SRTIME=SRSDT_"."_$S(X'="":X,1:1500)
 S SRTYPE=$P(^SRF(SRTN,0),"^",10) I SRTYPE="S" W !!,"Case schedule type is STANDBY. "
 D NOW^%DTC S SRN=+$E(%,1,12) I SRTYPE'="S",SRN'<SRTIME G SWAP
 S SRBOTH=0 I $P($G(^SRF(SRTN,"CON")),"^") S SRBOTH=1
REQ I 'SRBOTH D ^SRSCG
 S SRSCHST=$P($G(^SRF(SRTN,31)),"^",4) K:SRSCHST&SRSOR ^SRF("AMM",SRSOR,SRSCHST,SRTN)
 S $P(^SRF(SRTN,31),"^",4)="",$P(^SRF(SRTN,31),"^",5)="",^SRF(SRTN,"REQ")=1,^SRF("AR",SRSDATE,DFN,SRTN)="",^TMP("SRPFSS",$J)=""
 K DR S DA=SRTN,DR=".02///@",DIE=130 D ^DIE K DR D OERR
 I '$P($G(^SRF(SRTN,"1.0")),"^",11) D
 .N SREQ
 .S SREQ(130,SRTN_",",1.098)=+SRN,SREQ(130,SRTN_",",1.099)=DUZ
 .D FILE^DIE("","SREQ","^TMP(""SR"",$J)")
 W !!,"Case #"_SRTN_" has been removed from the schedule and changed to a request."
 I SRBOTH G ASK
PRESS W ! K DIR S DIR(0)="E" D ^DIR
 Q
ASK S SRBOTH=0 W !!,"There is a concurrent case associated with this operation.  Do you want to",!,"remove it from the schedule also ? YES// " R SRYN:DTIME I '$T!(SRYN["^") S SRYN="N"
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"If you want to remove both cases from the schedule, enter 'YES'.  If you",!,"answer 'NO', the cases will no longer be associated with each other." G ASK
 I "Yy"[SRYN S SRTN=$P(^SRF(SRTN,"CON"),"^") G REQ
NOCC ; no longer concurrent cases
 S DA=$P(^SRF(SRTN,"CON"),"^"),DIE=130,DR="35///@" D ^DIE S SROERR=DA D ^SROERR0 S DA=SRTN D ^DIE,OERR,UNLOCK^SROUTL(DA)
 Q
SWAP ; move data into a new entry and set up the cancel date in the old
 W ! K DIR S DIR(0)="130,18",DIR("A")="Cancellation Reason" D ^DIR S SRSCAN=$P(Y,"^") I $D(DIRUT) W !!,"Case NOT cancelled." D PRESS G END
 K DR S SRCON=0,DA=SRTN,DR=".02///@;102///@;235///@;284///@;323///@;18////"_SRSCAN_";67T;70////"_DUZ,DIE=130 D ^DIE S:$D(DTOUT)!$D(DUOUT) SRSOUT=1
 S SRSCHST=$P($G(^SRF(SRTN,31)),"^",4),AVOID=$P(^(30),"^",2)
 I '$P($G(^SRF(SRTN,"CON")),"^") D ^SRSCG
 S SRSDPT=$P(^SRF(SRTN,0),"^"),SRSOP=$P(^SRF(SRTN,"OP"),"^")
 S SRSSET=$P(^SRF(SRTN,31),"^",5),$P(^SRF(SRTN,31),"^",4)="",$P(^SRF(SRTN,31),"^",5)=""
SWAP2 K:SRSCHST&SRSOR ^SRF("AMM",SRSOR,SRSCHST,SRTN) D NOW^%DTC S $P(^SRF(SRTN,30),"^")=$E(%,1,12)
 I '$P($G(^SRF(SRTN,"CON")),"^") D OERR
 I SRSCAN'="" G:$P(^SRO(135,SRSCAN,0),"^",2)="D" CON
 D:'SRSOUT ^SRSCAN2
CON I '$D(SRSCC),$D(^SRF(SRTN,"CON")),$P(^("CON"),"^")'="" D CANCC^SRSUTL2 Q:SRBOTH="^"!SRSOUT  I SRBOTH=1 G CON1
 I SRCON'=0,SRTNEW'=SRCON K DR S DA=SRTNEW,DIE=130,DR="35////"_SRCON D ^DIE S DA=SRCON,DR="35////"_SRTNEW D ^DIE K DR S SROERR=SRCON D ^SROERR0
 I $G(SRDEAD)=0,$G(SRBOTH)=1,$G(SRSCC)=1 S SROERR=$P(^SRF(SRTN,"CON"),"^") D ^SROERR0 S SROERR=SRTN,^TMP("CSLSUR1",$J)="" D ^SROERR0
END D UNLOCK^SROUTL(SRTN),^SRSKILL K SRTN W @IOF
 Q
CON1 I SRDEAD=0 G SWAP2
 K DR S DA=SRTN,DR=".02///@;102///@;235///@;284///@;323///@;18///"_$P(^SRO(135,SRSCAN,0),"^")_";67///"_AVOID_";70////"_DUZ,DIE=130 D ^DIE
 D NOW^%DTC S $P(^SRF(SRTN,30),"^")=$E(%,1,12),$P(^SRF(SRTN,31),"^",4)="",$P(^SRF(SRTN,31),"^",5)=""
OERR ; update ORDER file (100)
 S SROERR=SRTN K SRTX D ^SROERR0
 Q
