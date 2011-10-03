SRSCHUN ;BIR/ADM - MAKE UNREQUESTED OPERATION ;06/20/06
 ;;3.0; Surgery ;**3,67,68,88,103,100,144,158**;24 Jun 93;Build 2
MUST S SRLINE="" F I=1:1:80 S SRLINE=SRLINE_"="
 W @IOF W:$D(SRCC) !,?29,$S(SRSCON=1:"FIRST",1:"SECOND")_" CONCURRENT CASE" W !,?14,"SCHEDULE UNREQUESTED OPERATION: REQUIRED INFORMATION",!!,SRNM_" ("_$G(SRSSN)_")",?65,SREQDT,!,SRLINE,!
SURG ; surgeon
 K DIR S DIR(0)="130,.14",DIR("A")="Surgeon" D ^DIR K DIR I $D(DTOUT)!(X="^") S SRSOUT=1 G END
 I Y=""!(X["^") W !!,"To create a surgical case, a surgeon MUST be selected.  Enter '^' to exit.",! G SURG
 S SRSDOC=+Y
CASE ; create case in SURGERY file
 K DA,DIC,DD,DO,DINUM,SRTN S X=SRSDPT,DIC="^SRF(",DIC(0)="L",DLAYGO=130 D FILE^DICN K DD,DO,DIC,DLAYGO S SRTN=+Y,SRLCK=$$LOCK^SROUTL(SRTN)
 S ^SRF(SRTN,8)=SRSITE("DIV"),^SRF(SRTN,"OP")=""
 D NOW^%DTC S SREQDAY=+$E(%,1,12),SRNOCON=1 K DR,DIE
 S DA=SRTN,DIE=130,DR=".09////"_SRSDATE_";.14////"_SRSDOC_";1.098////"_+SREQDAY_";1.099////"_DUZ_";Q;.02////"_SRSOR_";10////"_SRSDT1_";11////"_SRSDT2 D ^DIE K DR
ASURG ; attending surgeon
 K DA,DIC,DIQ,DR,SRY S DIC="^SRF(",DA=SRTN,DIQ="SRY",DIQ(0)="E",DR=.164 D EN^DIQ1 K DA,DIC,DIQ,DR
 I $G(SRY(130,SRTN,.164,"E"))'="" S SRATTND=SRY(130,SRTN,.164,"E") W !,"Attending Surgeon: "_SRATTND,! G SPEC
 K DIR S DIR(0)="130,.164",DIR("A")="Attending Surgeon" D ^DIR K DIR I $D(DTOUT)!(X="^") S SRSOUT=1 G DEL
 I Y=""!(X["^") W !!,"An Attending Surgeon must be entered when creating a case. Enter '^' to exit.",! G ASURG
 S SRATTND=+Y,DA=SRTN,DIE=130,DR=".164////"_SRATTND D ^DIE K DA,DIE,DR
SPEC ; surgical specialty
 K DIR S DIR(0)="130,.04",DIR("A")="Surgical Specialty" D ^DIR K DIR I $D(DTOUT)!(X="^") S SRSOUT=1 G DEL
 I Y=""!(X["^") W !!,"To create a surgical case, a surgical specialty MUST be selected.  Enter '^'",!,"to exit.",! G SPEC
 S SRSS=+Y
OP ; principal operative procedure
 K DIR S DIR(0)="130,26",DIR("A")="Principal Operative Procedure" D ^DIR K DIR I $D(DTOUT)!(X="^") S SRSOUT=1 G DEL
 I X["^" W !!,"Principal procedure must not contain an up-arrow (^).",! G OP
 S SRSOP=Y I SRSOP="" G OP
OPD ; Principal Preoperative Diagnosis
 K DIR S DIR(0)="130,32",DIR("A")="Principal Preoperative Diagnosis" D ^DIR K DIR I $D(DTOUT)!(X="^") S SRSOUT=1 G DEL
 I Y=""!(X["^") W !!,"A Principal Preoperative Diagnosis must be entered",!,"when creating a new case. Enter '^' to exit.",! G OPD
 I X[";" W !,"The Principal Preoperative Diagnosis cannot contain a semicolon (;).",!,"Please re-enter the Diagnosis, using commas in place of the semicolons." G OPD
 S SRSOPD=Y
 W !!,"The information entered into the Principal Preoperative Diagnosis field",!,"has been transferred into the Indications for Operation field.",!,"The Indications for Operation field can be updated later if necessary.",!
 W !!,"Press RETURN to continue  " R X:DTIME
UPDATE ; update case in SURGERY file
 S DA=SRTN,DIE=130,DR="26////"_SRSOP_";68////"_SRSOP_";36////0;Q;.04////"_SRSS_";32////"_SRSOPD D ^DIE
 K DR,DA S DR="[SRO-NOCOMP]",DA=SRTN,DIE=130 D ^DIE K DR
 D ^SROXRET K SRNOCON
OTHER ; other required fields
 S SRFLD=0 F  S SRFLD=$O(^SRO(133,SRSITE,4,SRFLD)) Q:'SRFLD!(SRSOUT)  D OTHDIR Q:SRSOUT
 I SRSOUT G DEL
 S SRSOPD(1)=SRSOPD D WP^DIE(130,SRTN_",",55,"A","SRSOPD")
 D:$G(SRLCK) UNLOCK^SROUTL(SRTN)
 S SROERR=SRTN D ^SROERR I $D(SRDUOUT) S SRSOUT=1
 I $D(SRCC),SRSCON=2 S DIE=130,DR="35////"_SRSCON(1),DA=SRTN D ^DIE K DR S DR="35////"_SRTN,DA=SRSCON(1),DIE=130 D ^DIE K DR,DA S SROERR=SRSCON(1) D ^SROERR0
 Q
DEL S DA=SRTN,DIK="^SRF(" D ^DIK G END
CON ; request concurrent case
 D MUST Q:SRSOUT  S SRSCON(SRSCON,"DOC")=$P(^VA(200,SRSDOC,0),"^"),SRSCON(SRSCON,"SS")=$P(^SRO(137.45,SRSS,0),"^"),SRSCON(SRSCON,"OP")=$P(^SRF(SRTN,"OP"),"^"),SRSCON(SRSCON)=SRTN K DA
 Q
OTHDIR ; call to reader for site specific required fields
 K DIR,SREQ,SRY S FLD=$P(^SRO(133,SRSITE,4,SRFLD,0),"^") D FIELD^DID(130,FLD,"","TITLE","SRY") S DIR(0)="130,"_FLD,DIR("A")=SRY("TITLE") D ^DIR I $D(DTOUT)!(X="^") S SRSOUT=1 Q
 I Y=""!(X["^") W !!,"It is mandatory that you provide this information before proceeding with this",!,"option.",! D ASK Q:SRSOUT  G OTHDIR
 S SREQ(130,SRTN_",",FLD)=$P(Y,"^") D FILE^DIE("","SREQ","^TMP(""SR"",$J)")
 Q
ASK K DIR S DIR(0)="Y",DIR("A")="Do you want to continue with this option ",DIR("B")="YES"
 S DIR("?")="Enter RETURN to continue with this option, or 'NO' to discontinue this option." D ^DIR S:'Y SRSOUT=1
 Q
END D:$G(SRLCK) UNLOCK^SROUTL(SRTN)
 I '$D(SRCC),SRSOUT W !!,"No surgical case has been scheduled.",! S SRTN("OR")=SRSOR,SRTN("START")=SRSDT1,SRTN("END")=SRSDT2,SRSEDT=$E(SRSDT2,1,7) D ^SRSCG
 Q
