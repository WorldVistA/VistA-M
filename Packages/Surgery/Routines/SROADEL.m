SROADEL ;BIR/MAM - DELETE ASSESSMENT ;05/05/10
 ;;3.0; Surgery ;**38,83,100,174**;24 Jun 93;Build 8
 S SRASTAT=$P($G(^SRF(SRTN,"RA")),"^")
 I SRASTAT="T" W !!,"This assessment has already been verified and transmitted.  It cannot be",!,"deleted.  If the assessment was transmitted in error, use the option 'Update",!,"an Assessment Transmitted in Error'." D RET Q
 I SRASTAT="V" W !!,"This assessment has already been verified.  It cannot be deleted.  If the",!,"assessment was verified in error, use the option 'Update an Assessment Verified",!,"in Error'." D RET Q
DEL W !!,"This assessment has a current status of "_$S(SRASTAT="I":"'Incomplete'",1:"'Complete/Unverified'"),!!,"Are you sure that you want to delete this assessment ? NO//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 Q
 S SRYN=$E(SRYN) I "Nn"[SRYN S SRSOUT=1 Q
 I "Yy"'[SRYN W !!,"Enter <RET> if this assessment was selected in error and should not be deleted.",!,"If you want to delete this assessment, enter 'YES'." G DEL
 I $$LOCK^SROUTL(SRTN) D  D UNLOCK^SROUTL(SRTN)
 .K DR,DIE,DA S DA=SRTN,DIE=130,DR="235///@;284///@;393///@;260///@;272///@;272.1///@;323///@;102///@" D ^DIE W !!,"Deleting Assessment..."
 .K DA,DIK S DIK="^SRF(",DIK(1)=".232^AQ",DA=SRTN D EN1^DIK
 Q
RET W !!,"Press <RET> to continue  " R X:DTIME
 K SRTN
 Q
