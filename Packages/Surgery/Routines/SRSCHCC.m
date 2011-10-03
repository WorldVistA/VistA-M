SRSCHCC ;B'HAM ISC/MAM - DELETE CONCURRENT CASES ; [ 04/26/97  3:08 PM ]
 ;;3.0; Surgery ;**3,67**;24 Jun 93
BEG W @IOF,!,"The following information has already been entered." S CON=0 F I=0:0 S CON=$O(SRSCON(CON)) Q:'CON  D LIST^SRSCHDC
 W !!!,"Since you have not entered all of the required operating room information, the",!,"schedule cannot be updated."
 W !!,"You have the following options available to you at this point.  One of these",!,"two options must be selected.  Entering an '^' will not be accepted."
ASK W !!,"1. Create an Operation Request for the "_$S($D(SRSCON(2)):"Concurrent Cases",1:"Case"),!,"2. Delete the "_$S($D(SRSCON(2)):"Concurrent Cases",1:"Case")
 W !!,"Select Number:  1//  " R X:DTIME I '$T S X=2
 S:X="" X=1 I X["^" G BEG
 I X'=1,X'=2 D HELP G ASK
 I X=2 D DEL Q
 S CON=0 F I=0:0 S CON=$O(SRSCON(CON)) Q:'CON  D REQ
 Q
REQ ; make requests
 S SRTN=SRSCON(CON),SRSOP=SRSCON(CON,"OP"),SRSDOC=SRSCON(CON,"DOC")
 D NOW^%DTC S SRDT=$E(%,1,12)
 K DIE,DR,DA S DIE=130,DR="36////1;Q;.09////"_SRSDATE_";1.099////"_DUZ_";1.098////"_SRDT,DA=SRTN D ^DIE
 S SROERR=SRTN D ^SROERR0
 Q
DEL W !!,"Are you sure you want to delete "_$S($D(SRSCON(2)):"these cases",1:"this case")_" ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRYN="Y"
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN S SRTN=1 W !!,"Enter RETURN to delete the "_$S($D(SRSCON(2)):"entries",1:"entry")_" from your records."
 I "Yy"'[SRYN S SRSOUT=0 Q
 S CON=0 F  S CON=$O(SRSCON(CON)) Q:'CON  W !!,"  Deleting Case "_SRSCON(CON)_" ..." D OERR S DA=SRSCON(CON),DIK="^SRF(" D ^DIK K SRTN
 Q
OERR ; delete from ORDER file (100)
 N SRTN S SRTN=SRSCON(C0N) D DEL^SROERR
 Q
HELP W !!,"If you want to make an operation request for the "_$S($D(SRSCON(2)):"cases",1:"case")_" entered, select '1'."
 W !,"A request will be created for "_$S($D(SRSCON(2)):"both cases",1:"case "_SRSCON(1))_" on "_SRSDT_"."
 W !!,"Select '2' if you want to REMOVE this record ENTIRELY from your records. "
 Q
