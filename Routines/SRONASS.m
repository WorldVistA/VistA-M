SRONASS ;BIR/MAM - NO ASSESSMENT REASON ;05/05/10
 ;;3.0; Surgery ;**38,47,83,107,121,100,125,174**;24 Jun 93;Build 8
 K SRTN S SRSOUT=0 N SRSEL D ^SROPSEL I '$D(DFN) S SRSOUT=1 G END
 D @$S(SRSEL=2:"^SROPSN",1:"STL^SROPS") I '$D(SRTN) S SRSOUT=1 G END
 S X=$P($G(^SRF(SRTN,"RA")),"^",6) I X="Y" D ASS I 'OK G END
 N SRLCK S SRLCK=$$LOCK^SROUTL(SRTN) I 'SRLCK G END
 D SRA^SROES
 W ! K DIR S X=$P($G(^SRF(SRTN,"RA")),"^",7) I X'="" D SET S DIR("B")=X
 S DIR(0)="130,102",DIR("A")="Reason an Assessment was not Created" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!(Y=""&(X'="@")) S SRSOUT=1 G END
 I X="@" D DELETE G END1
 I X'="" K DR,DA,DIE S DIE=130,DR="102///"_X_";323////N;284////N;Q;235////C",DA=SRTN D ^DIE K DR,DIE,DA
 D ^SROAEX S SROERR=SRTN D ^SROERR0
END1 K DA,DIK S DIK="^SRF(",DIK(1)=".232^AQ",DA=SRTN D EN1^DIK
 D EXIT^SROES
END I $G(SRLCK) D UNLOCK^SROUTL(SRTN)
 K SRTN D ^SRSKILL W @IOF
 Q
LOOP ; break procedure
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<60  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
OTHER ; other operations
 S SRLONG=1 I $L(SROPER)+$L($P(^SRF(SRTN,13,SROTHER,0),"^"))>235 S SRLONG=0,SROTHER=999,SROPERS=" ..."
 I SRLONG S SROPERS=$P(^SRF(SRTN,13,SROTHER,0),"^")
 S SROPER=SROPER_$S(SROPERS=" ...":SROPERS,1:", "_SROPERS)
 Q
SET ; expand reason for no assessment code
 S Y=X,C=$P(^DD(130,102,0),"^",2) D Y^DIQ S X=Y
 Q
ASS ; assessment already exists
 S OK=0 W !!,"According to your records, an assessment should be created for this surgical",!,"case."
ASK W !!,"Do you want to update this information and not create a surgery risk ",!,"assessment for this case ?  NO// " R SRYN:DTIME I '$T!(SRYN["^") S OK="" Q
 S SRYN=$E(SRYN) S:SRYN="" SRYN="N" I "YyNn"'[SRYN S SRYN="?"
 I SRYN="?" W !!,"If this case will not be used for the risk assessment study, Enter 'YES' to ",!,"change the status.  You will then be prompted for the reason that no assessment",!,"was done.  Enter 'NO' to leave this case unchanged."
 I SRYN="?" G ASK
 I "Yy"[SRYN S OK=1
 I "Nn"[SRYN W !!,"No action taken.",!!,"Press RETURN to continue  " R X:DTIME
 Q
DELETE ; delete no assessment reason
 W !!,"If you delete the reason why no assessment was created for this case, the",!,"computer will automatically update your records to make this a non-assessed",!,"case."
 W !!,"Are you sure that you want to delete the reason ?  NO// " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 Q
 S SRYN=$E(SRYN) S:SRYN="" SRYN="N" I "YyNn"'[SRYN S SRYN="?"
 I SRYN="?" W !!,"By entering an '@', you have told the computer that you want to remove the ",!,"reason why no assessment was created for this case.  If this reason should be",!,"deleted, enter 'YES'." G DELETE
 I "Nn"[SRYN S SRSOUT=1 W !!,"No action taken.",!!,"Press RETURN to continue  " R X:DTIME Q
 W !!,"Updating to non-assessed status..." D DRDEL W !!,"Press RETURN to continue  " R X:DTIME
 Q
DRDEL K DR,DIE,DA S DIE=130,DA=SRTN,DR="235///@;284///@;393///@;260///@;272///@;272.1///@;323///@;102///@;260.1///@" D ^DIE K DR,DIE,DA
 Q
