SRONEW ;B'HAM ISC/MAM - ENTER A NEW CASE ;01/29/01  1:09 PM
 ;;3.0; Surgery ;**3,23,26,30,47,58,48,67,107,100,144**;24 Jun 93
 ;
 ; Reference to ^TMP("CSLSUR1" supported by DBIA #3498
 ;
DEAD S SRSOUT=0,X=$P($G(VADM(6)),"^") I X D  I SRSOUT D ^SRSKILL G ^SROP
 .S SRDEATH=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) W @IOF,!,?1,VADM(1)_"   "_VA("PID")_"        * Died "_SRDEATH_" *"
 .W !!,$C(7) K DIR S DIR("A",1)=">>> The patient you have selected died on "_SRDEATH_"."
 .S DIR("A")="    Are you sure this is the correct patient ? ",DIR("B")="NO",DIR(0)="YA" D ^DIR K DIR
 .W @IOF I 'Y!$D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 .W !,"Entering a new surgical case for "_VADM(1)_".",!!
DATE K %DT W ! S %DT("A")="Select the Date of Operation: ",%DT="AEX" D ^%DT I Y<0 W !!,"When entering a new surgery case, a date MUST be entered.  If you do not",!,"know the date of operation, enter this patient on the Waiting List."
 I Y<0 D CONT G:"Yy"'[SRYN END G DATE
 G:Y'>0 END S SRSDATE=Y
 S SRSC1=1 K SRCTN S SRSDPT=DFN,SRSCC="" D CON G:SRSCC="^" END
OP D ^SROPROC I SRSOUT G END
 S SRPRIN=SRSOP
OPD ; Principal Preoperative Diagnosis
 K DIR S DIR(0)="130,32",DIR("A")="Principal Preoperative Diagnosis" D ^DIR K DIR I $D(DTOUT)!(X="^") S SRSOUT=1 G END
 I Y=""!(X["^") W !!,"A Principal Preoperative Diagnosis must be entered",!,"when creating a new case. Enter '^' to exit.",! G OPD
 I X[";" W !,"The Principal Preoperative Diagnosis cannot contain a semicolon (;).",!,"Please re-enter the Diagnosis, using commas in place of the semicolons." G OPD
 S SRSOPD=Y
 W !!,"The information entered into the Principal Preoperative Diagnosis field",!,"has been transferred into the Indications for Operation field.",!,"The Indications for Operation field can be updated later if necessary.",!
DOC W ! S DIC("A")="Select Surgeon: ",DIC=200,DIC(0)="QEAM",SRSDOC="" D ^DIC K DIC("A") I $D(DTOUT)!(X="^") S SRSOUT=1 G END
 I Y<0!(X["^") W !!,"A Surgeon must be entered when creating a case.  Enter '^' to exit.",! G DOC
 S (DA,SRSDOC)=+Y
 S RESTRICT="130,.14",Y=SRSDOC K SROK D KEY^SROXPR I '$D(SROK) W !!,"The person you selected does not have the appropriate keys necessary to be",!,"entered as a surgeon.  Please make another selection.",! K SRSDOC,DA,DIC G DOC
CASE ; create case in SURGERY file
 K DA,DIC,DD,DO,DINUM,SRTN S X=DFN,DIC="^SRF(",DIC(0)="L" D FILE^DICN K DIC S SRTN=+Y G:'$$LOCK^SROUTL(SRTN) DEL
 S ^SRF(SRTN,8)=SRSITE("DIV"),^SRF(SRTN,"OP")=""
 K DIE,DR S DA=SRTN,DIE=130,DR=".09////"_SRSDATE_";26////"_SRPRIN_";68////"_SRPRIN_";.14////"_SRSDOC D ^DIE K DR
ASURG ; attending surgeon
 K DIR S DIR(0)="130,.164",DIR("A")="Attending Surgeon" D ^DIR K DIR I $D(DTOUT)!(X="^") S SRSOUT=1 G DEL
 I Y=""!(X["^") W !!,"An Attending Surgeon must be entered when creating a case. Enter '^' to exit.",! G ASURG
 S SRATTND=+Y
SPEC W ! K DIC S DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Select Surgical Specialty: ",DIC("S")="I '$P(^(0),""^"",3)" D ^DIC I $D(DTOUT)!(X="^") S SRSOUT=1 G DEL
 I Y<0!(X["^") W !!,"To create a surgical case, a Surgical Specialty MUST be selected.  Enter '^'",!,"to exit.",! G SPEC
 S SRSS=+Y
UPDATE ; update case in SURGERY file
 S DA=SRTN,DIE=130,DR=".04////"_SRSS_";.164////"_SRATTND_";32////"_SRSOPD D ^DIE K DR
 S SRSOPD(1)=SRSOPD D WP^DIE(130,SRTN_",",55,"A","SRSOPD")
 ; Brief Clinical History
 K DR S DR="60T",DA=SRTN,DIE=130 W ! D ^DIE
 K DR,DA S DR="[SRO-NOCOMP]",DA=SRTN,DIE=130 D ^DIE K DR
 S ^SRF(SRTN,8)=SRSITE("DIV") D ^SROXRET
DIE D ^SROBLOD K DR,DIE,DA S DR="38////"_BLOOD_";40////"_CROSSM,DA=SRTN,DIE=130 D ^DIE K DR,DA,DIE
 S DR="[SRSRES1]",DIE=130,DA=SRTN D ^DIE,RT S ST="NEW SURGERY" D EN2^SROVAR
 S SPD=$$CHKS^SRSCOR(SRTN)
 K DR S DR="[SRSRES-ENTRY]",DIE=130,DA=SRTN D ^SRCUSS,RISK^SROAUTL3,^SROPCE1
 I SPD'=$$CHKS^SRSCOR(SRTN) S ^TMP("CSLSUR1",$J)=""
 I $D(SRCTN) D
 .S SRCTN(.02)=$P(^SRF(SRCTN,0),"^",2),SRCTN(10)=$P($G(^SRF(SRCTN,31)),"^",4),SRCTN(11)=$P($G(^SRF(SRCTN,31)),"^",5)
 .S DIE=130,DR=".02////"_SRCTN(.02)_";10////"_SRCTN(10)_";11////"_SRCTN(11)_";35////"_SRCTN,DA=SRTN D ^DIE
 .S DR="35////"_SRTN,DA=SRCTN,DIE=130 D ^DIE
 D UNLOCK^SROUTL(SRTN),^SROERR
 Q
DEL S DA=SRTN,DIK="^SRF(" D ^DIK
END K SRTN D ^SRSKILL
 Q
CONT ; continue new entry ?
 W !!,"Do you want to continue  ?  YES//  " R SRYN:DTIME I '$T S SRYN="N" Q
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y" I "YyNn"'[SRYN W !!,"Enter RETURN if you want to re-enter a date and continue creating a new",!,"case, or 'NO' to leave this option." G CONT
 Q
RT ;start RT logging
 I $D(XRTL) S XRTN="SRONEW" D T0^%ZOSV
 Q
CON ; check for concurrent case
 S SRSCON=0,SRDT=SRSDATE-.0001 F  S SRDT=$O(^SRF("AC",SRDT)) Q:'SRDT!($E(SRDT,1,7)'=SRSDATE)!(SRSCON)  S (SRSCC,SRSCON)=0 F  S SRSCC=$O(^SRF("AC",SRDT,SRSCC)) Q:'SRSCC  D  Q:SRSCON
 .I ^(SRSCC)=SRSDPT,'$P($G(^SRF(SRSCC,"CON")),"^"),$P($G(^SRF(SRSCC,"NON")),"^")'="Y",'$P($G(^SRF(SRSCC,30)),"^"),'$P($G(^SRF(SRSCC,.2)),"^",12),'$P($G(^SRF(SRSCC,"LOCK")),"^") S SRSCON=1
 .I SRSCON D CC^SRSREQ I '$D(SRCTN) S SRSCON=0
 Q
