SROTHER ;BIR/MAM - OTHER PROCEDURES ;05/14/99  12:14 PM
 ;;3.0; Surgery ;**38,88,142**;24 Jun 93
 S SRSOUT=0 I '$D(SRTN) W @IOF,!!,"A surgical case must be selected prior to using this option.",!!,"Press RETURN to continue  " R X:DTIME S SRSOUT=1 G END
 D ^SROAUTL S SR(0)=^SRF(SRTN,0),Y=$P(SR(0),"^",9),SRDATE=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3),SRLINE="" F I=0:1:79 S SRLINE=SRLINE_"-"
START D HDR K SROTHER S (OTH,CNT)=0 F  S OTH=$O(^SRF(SRTN,13,OTH)) Q:'OTH!($D(SROTHER))  Q:SRSOUT  S CNT=CNT+1 D LIST I CNT=13 W !!,SRLINE D SEL
 I SRSOUT Q
 I $D(SROTHER) D EDIT G START
 I CNT W !!,SRLINE
 I CNT=0 D ASK G:'SRSOUT START S SRSOUT=0 Q
OPT W !!,"Enter "_$S(CNT=1:1,1:"(1-"_CNT_")")_" to edit an existing procedure, or 'NEW' to",!,"enter another operative procedure: " R X:DTIME I '$T!("^"[X) Q
 I $E(X)="N" D NEW G START
 I '$D(OTHER(X)) W !!,"Select the number corresponding to the procedure you want to edit, or 'NEW' to",!,"enter an additional operative procedure." G OPT
 S SROTHER=$P(OTHER(X),"^",3) D EDIT G START
 Q
END I 'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 D ^SRSKILL W @IOF
 Q
LIST ; list existing procedures
 S X=^SRF(SRTN,13,OTH,0),CPT=$P($G(^SRF(SRTN,13,OTH,2)),"^") I CPT S Y=$P($$CPT^ICPTCOD(CPT),"^",2),SRDA=OTH D SSOTH^SROCPT S CPT=Y
 I CPT="" S CPT="NOT ENTERED"
 S OTHER(CNT)=$P(X,"^")_"^"_CPT_"^"_OTH
 W !,$S(CNT<10:" ",1:"")_CNT_". "_$P(OTHER(CNT),"^")_$S('$D(SRSUPCPT):" (CPT: "_$P(OTHER(CNT),"^",2)_")",1:"")
 Q
SEL ; select procedure
 W !!,"Select (1-"_CNT_") to edit an existing procedure, or RETURN to continue: " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 I X="" S CNT=0 K OTHER D HDR Q
 I '$D(OTHER(X)) W !!,"Enter the number corresponding to the procedure you want to edit, or RETURN",!,"to continue listing procedures." G SEL
 S SROTHER=$P(OTHER(X),"^",3)
 Q
HDR ; print screen header
 S SRPAGE="OTHER OPERATIVE PROCEDURES" D HDR^SROAUTL
 Q
EDIT ; edit one procedure
 D HDR W ! S DA=SROTHER,DIE="^SRF("_SRTN_",13,",DA(1)=SRTN,DR=".01T"_$S('$D(SRSUPCPT):";3T",1:"")
 D ^DIE K DR,DIE
 Q
ASK W !!,"There are no additional procedures entered for this case.  Do you want to add",!,"a new procedure ? YES// " R SRYN:DTIME I '$T!(SRYN["^") S SRYN="N"
 S:SRYN="" SRYN="Y"
 S SRYN=$E(SRYN) I "YyNn"'[SRYN W !!,"Enter 'YES' to add another operative procedure, or 'NO' to return to the",!,"previous screen." G ASK
 I "Nn"[SRYN S SRSOUT=1 Q
NEW D HDR W ! K DIR,DA S DIR(0)="130.16,.01",DIR("A")="Other Operative Procedure" D ^DIR I Y=""!$D(DTOUT)!$D(DUOUT) Q
 I '$D(^SRF(SRTN,13,0)) S ^SRF(SRTN,13,0)="^130.16A^^"
 K DA,DIC,DD,DO,DINUM S DA(1)=SRTN,X=Y,DIC="^SRF("_SRTN_",13,",DIC(0)="L" D FILE^DICN K DA,DIC,DD,DO,DINUM
 I '$D(SRSUPCPT) K DR,DIE S DA=+Y,DA(1)=SRTN,DR="3T",DIE="^SRF("_SRTN_",13," D ^DIE K DR
 Q
