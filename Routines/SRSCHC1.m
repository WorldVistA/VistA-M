SRSCHC1 ;B'HAM ISC/MAM - SCHEDULE CONCURRENT CASES ; [ 04/26/97   3:03 PM ]
 ;;3.0; Surgery ;**3,67**;24 Jun 93
 W @IOF,!,"Enter information related to the "_$S(SRSCON=1:"first",1:"second")_" concurrent case.",!
OPER D ^SROPROC I SRSOUT Q
 S SRSCON(SRSCON,"OP")=SRSOP
CPT W ! K SRSCPT,DIC S DIC=81,DIC(0)="QEAM",DIC("A")="Select the Principal Operation Code (CPT): " D ^DIC K DIC I Y>0 S SRSCPT=+Y I $P(^ICPT(+Y,0),"^",4) W !!,"This is an inactive code.  Please make another selection.",! G CPT
SPEC W ! K DIC S DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Select the Surgical Specialty: ",DIC("S")="I '$P(^(0),""^"",3)" D ^DIC I Y<0 D HELP I SRSOUT Q
 S SRSS=+Y,SRSCON(SRSCON,"SS")=$P(Y(0),"^"),(SRSDOC,SRSCON(SRSCON,"DOC"))=""
DOC W ! K DIC S DIC=200,DIC(0)="QEAMZ",DIC("A")="Enter the Surgeon's Name: " D ^DIC I $D(DUOUT) S SRSOUT=1 Q
 I Y<0 S SRSOUT=1 Q
 S SRSDOC=+Y,SRSCON(SRSCON,"DOC")=$P(Y(0),"^")
 K DA,DIC,DIE,DO,DD,DINUM,SRTN S X=SRSDFN,DIC="^SRF(",DIC(0)="L",DLAYGO=130 D FILE^DICN K DIC,DLAYGO S (SRTN,SRSCON(SRSCON))=+Y
 K DIE,DR,DIC S DA=SRTN,DIE=130,DR=".09////"_SRSDATE_";.04////"_SRSS_";.14////"_SRSDOC D ^DIE K DR
 S DIE=130,DA=SRTN,DR="26////"_SRSOP_";68////"_SRSOP D ^DIE K DR
 K DR,DA S DR="[SRO-NOCOMP]",DA=SRTN,DIE=130 D ^DIE K DR
IND W ! S DIE=130,DR="55T" D ^DIE I '$O(^SRF(SRTN,40,0)) D ^SRSIND S:'$D(SRTN) SRSOUT=1 Q:SRSOUT  G IND
 W ! K DR S DR="60T",DIE=130,DA=SRTN D ^DIE
 W ! K DR,Y S DA=SRTN,DIE=130,DR=".42T",DR(2,130.16)=".01T;1T;3T" W !!,"Other Operative Procedures by the same Surgical Specialty: ",! D ^DIE K DR I $D(Y) S SRSAVG="",SRDUOUT=1 Q
 I $D(SRSCPT) K DR S DR="27////"_SRSCPT,DIE=130,DA=SRTN D ^DIE K DR
 S ^SRF(SRTN,8)=SRSITE("DIV") D ^SROXRET
 I SRSCON=2 S DA=SRTN,DIE=130,DR="35////"_SRSCON(1) D ^DIE S DA=SRSCON(1),DIE=130,DR="35////"_SRSCON(2) D ^DIE K DR
 D ^SROERR
 Q
HELP ; surgical specialty help message
 W !!,"The Surgical Specialty must be entered when scheduling a surgery case."
 I SRSCON=1 W !,"If you do not know the surgical specialty, this entry cannot be completed."
 I SRSCON=2 W !,"Without entering a specialty, this case cannot be scheduled."
SP W !!,"Do you want to re-enter a Surgical specialty for this procedure ?  YES// " R SRYN:DTIME I '$T!(SRYN["^") S SRYN="N"
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter RETURN if you want to enter a specialty and continue entering information,",!,"or 'NO' to delete this case." G SP
 I "Yy"'[SRYN S SRSOUT=1
 Q
