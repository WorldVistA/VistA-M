SRONOP1 ;BIR/MAM - NON-O.R. PROCEDURES ;06/15/05
 ;;3.0; Surgery ;**44,56,58,48,67,70,88,100,142**;24 Jun 93
 S X=$P($G(VADM(6)),"^") I X D  I SRSOUT D ^SRSKILL G ^SRONOP
 .S SRDEATH=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) W @IOF,!,?1,VADM(1)_"   "_VA("PID")_"        * Died "_SRDEATH_" *"
 .W !!,$C(7) K DIR S DIR("A",1)=">>> The patient you have selected died on "_SRDEATH_"."
 .S DIR("A")="    Are you sure this is the correct patient ? ",DIR("B")="NO",DIR(0)="YA" D ^DIR K DIR
 .I 'Y!$D(DTOUT)!$D(DUOUT) S SRSOUT=1
 W @IOF,!,"Entering a new non-O.R. procedure for "_SRNM_".",!!
OP ; principal procedure
 W ! K DIR S DIR(0)="130,26A",DIR("A")="Enter the Procedure: " D ^DIR K DIR I $D(DTOUT)!(X="^") S SRSOUT=1 G END
 S SROPER=Y
DATE W ! K %DT S %DT="AEX",%DT("A")="Select the Date of the Procedure: " D ^%DT I X="" W !!,"The Date of the Procedure MUST be entered." G DATE
 I Y<0!$D(DTOUT) S SRSOUT=1 G END
 S SRSDATE=+Y
DOC W ! K DIR S DIR("A")="Provider",DIR(0)="130,123" D ^DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 G END
 S SRSDOC=+Y
SPEC W ! K DIR S DIR("A")="Medical Specialty",DIR(0)="130,125" D ^DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 G END
 S SRSPEC=+Y
SUMM ; dictated summary expected?
 N SREXPT W ! K DIR S DIR("A")="Will a summary of this procedure be dictated? (Y/N)"
 S DIR("?",1)="This field indicates if the provider will dictate a summary of this",DIR("?",2)="procedure to be electronically signed. Enter YES if a dictated summary"
 S DIR("?")="is expected. Enter NO or leave blank if no summary is expected.",DIR(0)="Y" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 G END
 S SREXPT=Y
 K DIC,DO,DA,DD,DINUM,SRTN S X=DFN,DIC="^SRF(",DIC(0)="L",DLAYGO=130 D FILE^DICN K DD,DO,DIC,DLAYGO S SRTN=+Y
 N SRLCK S SRLCK=$$LOCK^SROUTL(SRTN) I 'SRLCK S Q3("VIEW")=""
 K DR S DIE=130,DR="120///"_SRSDATE_";26///"_SROPER_";118///Y;123////"_SRSDOC_";125////"_SRSPEC_";1004////"_SREXPT,DA=SRTN D ^DIE K DR,DA,DIE S ^SRF(SRTN,8)=SRSITE("DIV")
 D RT S SRSOUT=1,SRN=$E(SRNM,1,20),Q3(1)="** NON-O.R. PROCEDURE **  CASE #"_SRTN_"  "_SRN_" "
 S SRDTIME=DTIME,DTIME=3600,ST="NON-O.R. PROCEDURE",DIE=130,DR="[SRNON-OR]",DA=SRTN D ^SRCUSS S DTIME=SRDTIME D ^SROPCE1 S SRSOUT=0
 S SRSOP=SROPER,SRL=$P(^SRF(SRTN,"NON"),"^",2) S ORL=$S(SRL:SRL_";SC(",1:"") D ^SROERR
 D ^SRSKILL I $G(SRLCK) D UNLOCK^SROUTL(SRTN)
 Q
END I SRSOUT W !!,"No action taken.",!!,"Press RETURN to continue  " R X:DTIME
 D ^SRSKILL K SRTN W @IOF
 Q
RT ; start RT logging
 I $D(XRTL) S ZRTN="SRONOP1" D T0^%ZOSV
 Q
DEL ; delete procedure
 W !!,"Are you sure that you want to remove this procedure from your ",!,"records ?  NO// " R X:DTIME I '$T!(X="^") W !!,"No action taken..." Q
 S X=$E(X) S:X="" X="N" I "YyNn"'[X W !!,"Enter RETURN or 'NO' if this procedure should remain on file.  Enter 'YES'",!,"to delete this procedure."
 I "Nn"[X W !!,"No action taken." Q
 I $P($G(^SRF(SRTN,"TIU")),"^",3) D EN^DDIOL("This case can't be deleted, there is a Procedure Report (Non-O.R.) associated with it.",,"!!,?2,$C(7)") Q
 W !!,"Deleting procedure..."
 S SRX=$P($G(^SRF(SRTN,0)),"^",15) I SRX S SRVSIT=SRX D DEL^SROPCEP ; delete visit
 I $D(^SRO(136,SRTN,0)) S DA=SRTN,DIK="^SRO(136," D ^DIK K DA,DIK ; remove entry in file 136
 D DEL^SROERR S DA=SRTN,DIK="^SRF(" D ^DIK
 Q
