PSSHELP ;BIR/SAB-PDM UTILITY ROUTINE ; 09/02/97 8:37
 ;;1.0;PHARMACY DATA MANAGEMENT;**125**;9/30/97;Build 2
ADD ;add/edited local drug/drug interactions
 W ! S DIC("A")="Select Drug Interaction: ",DIC(0)="AEMQL",(DIC,DIE)="^PS(56,",DIC("S")="I '$P(^(0),""^"",5)",DLAYGO=56
 D ^DIC G:"^"[X QU G:Y<0 ADD S DA=+Y,DR="[PSS INTERACT]" L +^PS(56,DA):$S($G(DILOCKTM)>0:DILOCKTM,1:3) W:'$T !,$C(7),"Already being edited." I $T D ^DIE L:$G(DA) -^PS(56,DA) K DA G ADD
QU K X,DIC,DIE,DA
 Q
CRI ;change drug interaction severity to critical from significant
 W ! S DIC("A")="Select Drug Interaction: ",DIC(0)="AEQM",(DIC,DIE)="^PS(56,",DIC("S")="I $P(^(0),""^"",4)=2"
 D ^DIC G:"^"[X QU G:Y<0 CRI S DA=+Y,DR=3 L +^PS(56,DA):$S($G(DILOCKTM)>0:DILOCKTM,1:3) W:'$T !,$C(7),"Already being edited." I $T D ^DIE L -^PS(56,DA) K DA G CRI
 G QU
 Q
