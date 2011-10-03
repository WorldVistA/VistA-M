SROPDEL ;BIR/MAM - DELETE CASE ;06/14/05
 ;;3.0; Surgery ;**67,100,142,167**;24 Jun 93;Build 27
DEL W !!,"Are you sure that you want to delete this case ?  NO//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 Q
 S:SRYN="" SRYN="N" S SRYN=$E(SRYN)
 I "YyNn"'[SRYN W !!,"Enter 'YES' to delete this surgical case from your records.  If you have",!,"selected this option inadvertantly and do not want to remove this case,",!,"enter RETURN or 'NO'." G DEL
 I "Yy"'[SRYN S SRSOUT=1 Q
 S SRCC="",SROPCOM="Operation..."
 I $P($G(^SRF(SRTN,.2)),"^",12)'="" W !!,"This case has been completed and must remain in the file for your records." D RET Q
 I $D(^SRF(SRTN,"LOCK")),^("LOCK")=1 W !!,"This case has been verified and locked.  It cannot be deleted unless unlocked",!,"by your Chief of Surgery, or someone appointed by him/her." D RET Q
 I $P($G(^SRF(SRTN,30)),"^") S SROPCAN=1
 I $P($G(^SRF(SRTN,31)),"^",8)'="" S SROPCAN=1
 I $D(SROPCAN) W !!,"This case has been cancelled and must remain in the file for your records." D RET Q
 I $P($G(^SRF(SRTN,31)),"^",4) W !!,"You cannot delete a procedure that has already been scheduled.  If you",!,"would like to cancel this procedure, use the option 'Cancel Scheduled ",!,"Operation'." D RET Q
 S Y=$G(^SRF(SRTN,"TIU")) I $P(Y,"^")!$P(Y,"^",2)!$P(Y,"^",4) W !!,"You cannot delete a procedure that has one or more operative documents." D RET Q
 K ^TMP("SRTP",$J) D TP I SRSOUT=1 Q  ;checking associated transplant assessments
KILL ; delete entry
 Q:'$$LOCK^SROUTL(SRTN)
 S SRCONC=$P($G(^SRF(SRTN,"CON")),"^") I SRCONC K ^SRF(SRCONC,"CON")
 D DEL^SROERR
 W !!,"  Deleting "_SRCC_SROPCOM I $P($G(^SRF(SRTN,.2)),"^",10) S DIE=130,DA=SRTN,DR=".205///@" D ^DIE K DA
 S SRX=$P($G(^SRF(SRTN,0)),"^",15) I SRX S SRVSIT=SRX D DEL^SROPCEP ; delete visit
 I $D(^SRO(136,SRTN,0)) S DA=SRTN,DIK="^SRO(136," D ^DIK K DA,DIK ; remove entry in file 136
 S (DA,SRTN1)=SRTN,DIK="^SRF(" D ^DIK,UNLOCK^SROUTL(SRTN) K DA,DIK,SRTN
 I SRCONC D UNLOCK^SROUTL(SRCONC),CON I SRCONC D KILL
 I $D(^TMP("SRTP",$J)) D KTP
 Q
CON ; delete concurrent case ?
 S SRTN=SRCONC W !!,"There is a concurrent procedure associated with this case.  Do you want to",!,"delete it also ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRCONC=0 Q
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter RETURN to delete this concurrent case.  If you are not sure whether to",!,"delete the other case, enter 'NO'.  It can be removed later if necessary." G CON
 I "Nn"[SRYN S SRCONC=0
 Q
RET W !!,"Press RETURN to continue  " R X:DTIME K SRTN
 Q
TP N SRATP,SRTPN,SRTPP S SRATP=0
 F  S SRATP=$O(^SRT("B",DFN,SRATP)) Q:'SRATP  S SRTPN=$G(^SRT(SRATP,0)) S:$P(SRTPN,"^",3)=SRTN ^TMP("SRTP",$J,SRATP)=""
 Q:'$D(^TMP("SRTP",$J))
 W !!,"Deleting this case will also delete the transplant assessment(s) associated",!,"with this case. Are you sure you want to delete this case?  NO// " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 Q
 S:SRYN="" SRYN="N" S SRYN=$E(SRYN)
 I "YyNn"'[SRYN W !!,"Enter YES to delete this case and its transplant assessment(s). Otherwise,",!,"enter NO." G TP
 I "Yy"'[SRYN S SRSOUT=1 Q
 Q
KTP ; delete transplant assessments
 S SRTPP=0 F  S SRTPP=$O(^TMP("SRTP",$J,SRTPP)) Q:'SRTPP  D
 .K DA,DIK S DA=SRTPP,DIK="^SRT(" D ^DIK K DA,DIK W !!,"Deleting Transplant Assessment #",SRTPP
 K ^TMP("SRTP",$J)
 Q
