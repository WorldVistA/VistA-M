SROAERR ;BIR/MAM - UPDATE ASSESSMENTS ENTERED IN ERROR ;05/05/10
 ;;3.0; Surgery ;**38,65,100,174**;24 Jun 93;Build 8
TRANS ; update assessments transmitted in error
 I '$D(SRSTAT) S SRSTAT="T"
 S SRSOUT=0 K SRNEW D ^SROASS I '$D(SRTN) S SRSOUT=1 G END
 S SRASTAT=$P($G(^SRF(SRTN,"RA")),"^") I SRSTAT'=SRASTAT D GOOF I GOOF G END
ASK W !!,"Are you sure that you want to change the status of this assessment"
 W !,"from "_$S(SRASTAT="C":"'COMPLETE'",1:"'TRANSMITTED'")_" to 'INCOMPLETE' ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) I "YyNn"'[SRYN D HELP G ASK
 S:SRYN="" SRYN="Y" I "Nn"[SRYN G END
 I $$LOCK^SROUTL(SRTN) D STAT Q
 E  W !!,"No action taken." G END
 Q
STAT K DR S DIE=130,DA=SRTN,DR="235////I;393////"_$S(SRASTAT="T":1,1:"") D ^DIE K DR
 I SRASTAT="C"&($P($G(^SRF(SRTN,"RA")),"^",3)'="1") K DR S DIE=130,DA=SRTN,DR="272///@;272.1///@" D ^DIE K DR
 W !!,"The Assessment Status has been changed to 'INCOMPLETE'."
 D UNLOCK^SROUTL(SRTN)
END I 'SRSOUT W !!,"Press <RET> to continue  " R X:DTIME
 D ^SRSKILL K SRTN W @IOF
 Q
GOOF S GOOF=0 I SRASTAT="I" W !!,"This assessment already has the status, 'INCOMPLETE'." S GOOF=1 Q
 Q
HELP W !!,"Enter RETURN if the assessment was "_$S(SRASTAT="C":"completed",1:"transmitted")_" in error and the status",!,"should be changed to 'INCOMPLETE' to allow editing.  Otherwise, enter 'NO'."
 Q
