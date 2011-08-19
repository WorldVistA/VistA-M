SRSUTL2 ;B'HAM ISC/MAM - MISC. UTILITIES ; [ 04/28/97  1:40 PM ]
 ;;3.0; Surgery ;**34,67,107**;24 Jun 93
 ;
 ; Reference to ^TMP("CSLSUR1" supported by DBIA #3498
 ;
CANCC ; cancel concurrent cases
 I SRSOUT G NOCC
 S SRDEAD=0 I $P(^SRO(135,SRSCAN,0),"^",2)="D" S (SRBOTH,SRDEAD)=1 G UPDTCC
 W !!,"There is a concurrent case associated with this operation.  Do you want to",!,"cancel it also ? YES// " R SRBOTH:DTIME I '$T S SRBOTH="^"
 S SRBOTH=$E(SRBOTH) S:SRBOTH="" SRBOTH="Y"
 D:SRBOTH="^" NOCC Q:SRBOTH="^"  I "YyNn"'[SRBOTH W !!,"If you want to cancel both cases, enter 'YES'.  If you answer 'NO', the cases",!,"will no longer be associated with each other" G CANCC
 I "Yy"[SRBOTH S SRBOTH=1
 I SRBOTH'=1 D NOCC
UPDTCC S SRSCC=1 Q:SRBOTH'=1  S SRTN=$P(^SRF(SRTOLD,"CON"),"^"),DR="17////"_$P(^SRF(SRTOLD,30),"^")_";18////"_SRSCAN_";.02///@",DIE=130,DA=SRTN D ^DIE
 D ^SRSCG I $D(SRTNEW) S SRCON=SRTNEW,SRTOLD=SRTN
 S SRSDOC=$P(^SRF(SRTN,.1),"^",4),SRSOP=$P(^SRF(SRTN,"OP"),"^"),$P(^SRF(SRTN,31),"^",4)="",$P(^(31),"^",5)=""
 Q
NOCC ; no longer concurrent cases
 S DA=$P(^SRF(SRTN,"CON"),"^"),DIE=130,DR="35///@" D ^DIE S SROERR=$P(^SRF(SRTN,"CON"),"^") D ^SROERR0 S DA=SRTN D ^DIE S SROERR=SRTN,^TMP("CSLSUR1",$J)="" D ^SROERR0
 I $D(SRTNEW) S DA=SRTNEW D ^DIE S SROERR=SRTNEW,^TMP("CSLSUR1",$J)="" D ^SROERR0
 Q
TIMES ; calculated times
 S Z1=X1,Z2=X2 D ^%DTC S Z0=X,X1=Z1-(Z1\1)*10000,X2=Z2-(Z2\1)*10000,Z0=X1\100-(X2\100)+(Z0*24),X1=X1-(X1\100*100),X2=X2-(X2\100*100),X=Z0*60+X1-X2 K Z0,Z1,Z2,X1,X2
 Q
MINS ; difference between 2 times in minutes
 S Y=$E(X1_"000",9,10)-$E(X_"000",9,10)*60+$E(X1_"00000",11,12)-$E(X_"00000",11,12),X2=X,X=$P(X,".",1)'=$P(X1,".",1) D ^%DTC:X S X=X*1440+Y
 Q
CAN ; scheduled ?
 I $P($G(^SRF(SRTN,31)),"^",4)="" W !!,"This case has not been scheduled."
 Q
