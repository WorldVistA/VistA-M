SROPER ;B'HAM ISC/MAM - SELECT OPERATION ; [ 01/30/01  1:26 PM ]
 ;;3.0; Surgery ;**37,107,100**;24 Jun 93
 ;
 ; Reference to ^TMP("CSLSUR1" supported by DBIA #3498
 ;
NEW ; enter a new surgery
 S %DT("A")="Select the Date of Operation: ",%DT="AEX" D ^%DT I Y<0 W !!,"When entering a new surgery case, a date MUST be entered.  If you do not",!,"know the date of operation, enter this patient on the Waiting List." W !!!
 I Y<0 D CONT G:"Yy"'[SRYN END G NEW
 G:Y'>0 END S SRSDATE=Y
 S SRSC1=1 K SRCTN S SRSDPT=DFN,SRSCC="" D CONCUR^SRSREQ G:SRSCC="^" END
OPER D ^SROPROC I SRSOUT G END
 S SRPRIN=SRSOP K SRSOP
 G:Y'>0 END S SRSDATE=Y
 K DA,DIC,DO,DD,DINUM,SRTN S X=DFN,DIC="^SRF(",DIC(0)="L",DLAYGO=130 D FILE^DICN K DIC,DLAYGO S SRTN=+Y
 N SRLCK S SRLCK=$$LOCK^SROUTL(SRTN) I 'SRLCK Q
 K DIE,DR S DA=SRTN,DIE=130,DR=".09///"_SRSDATE_";26///"_SRPRIN_";68///"_SRPRIN D ^DIE K DR
 K DR,DA S DR="[SRO-NOCOMP]",DA=SRTN,DIE=130 D ^DIE K DR
 S ^SRF(SRTN,8)=SRSITE("DIV") D ^SROXRET
 D ^SROBLOD K DR,DIE,DA S DR="38////"_BLOOD_";40////"_CROSSM,DA=SRTN,DIE=130 D ^DIE K DR,DA,DIE
 S DR="[SRSRES1]",DIE=130,DA=SRTN D ^DIE D RT S SPD=$$CHKS^SRSCOR(SRTN),ST="" D EN2^SROVAR K DR S DR="[SRSRES-ENTRY]",DIE=130,DA=SRTN D ^SRCUSS I SPD'=$$CHKS^SRSCOR(SRTN) S ^TMP("CSLSUR1",$J)=""
 I $D(SRCTN) S DIE=130,DR="35////"_SRCTN,DA=SRTN D ^DIE S SROERR=SRTN D ^SROERR0 S DR="35////"_SRTN,DA=SRCTN,DIE=130 D ^DIE S SROERR=SRCTN D ^SROERR0
 D UNLOCK^SROUTL(SRTN)
 Q
END D ^SRSKILL
 Q
SEL ; select case
 W !!!,"Select Operation, or enter RETURN to continue listing Procedures: " R X:DTIME W @IOF I '$T!(X["^") S SRSOUT=1 Q
 I X="" Q
 I '$D(SRCASE(X)) W !!,"Please enter the number corresponding to the Surgical Case you want to edit.",!,"If the case desired does not appear, enter RETURN to continue listing",!,"additional cases."
 I '$D(SRCASE(X)) W !!,"Press RETURN to continue  " R X:DTIME S:'$T SRSOUT=1 S SRBACK=1 Q
 S SRTN=+SRCASE(X)
 Q
CONT ; continue new entry ?
 W !!,"Do you want to continue  ?  YES//  " R SRYN:DTIME I '$T S SRYN="N" Q
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y" I "YyNn"'[SRYN W !!,"Enter RETURN if you want to re-enter a date and continue creating a new",!,"case, or 'NO' to leave this option." G CONT
 Q
RT ; start RT logging
 I $D(XRTL) S XRTN="SROPER" D T0^%ZOSV
 Q
