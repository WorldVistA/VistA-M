PSGFILD3 ;BIR/CML3-RETURN OF VARIOUS FILES' UPKEEP ;12 DEC 97 / 10:53 AM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
ENRBLU ;
 S Y=DA(2) N DA,DIC,DIE,DIX,DO,DR
 S DIC="^DG(405.4,",DIC(0)="EIMZ",DIC("S")="I $D(^(""W"",""B"","_Y_"))" D DO^DIC1,^DIC I Y'>0 K X Q
 I $D(^PS(57.7,"AWRT",D0,X)) D EN^DDIOL("THIS ROOM-BED ALREADY ASSIGNED TO TEAM FOR THIS WARD!") K X Q
 S X=Y(0,0) Q
 ;
ENRBQ ;
 S X=DZ,Y=DA(1) N D,DA,DIC,DIE,DO,DR,DZ,XQH
 S DIC="^DG(405.4,",DIC(0)="EIMQ",DIC("S")="I $D(^(""W"",""B"","_Y_"))" D DO^DIC1,^DIC Q
 ;
ENATC ;
 K DIR S DIR(0)="SAO^O:ONE ATC;M:MULTIPLE ATCS",DIR("A",1)="Do you want to set up your drugs for",DIR("A")="(O)ne ATC or (M)ultiple ATCs? ",DIR("B")="ONE ATC",DIR("?")="^D ATCH^PSGFILD3" D ^DIR
 S ATC=$S($D(DIROUT):1,$D(DIRUT):1,$D(DTOUT):1,$D(DTOUT):1,Y="":1,1:Y) I ATC="O" K PSGW S PSGW=0 F Q=0:0 S Q=$O(^PS(57.5,Q)) Q:'Q  I $D(^(Q,0)),$P(^(0),"^",2)="P" S PSGW=PSGW+1,PSGW(Q)=""
 I 'ATC,$S(ATC="O":'PSGW,1:'$D(^PS(57.5,"AP"))) W $C(7),!!?3,"NOTE: No PHARMACY ward groups are found.  You will not be able to enter",!?9,"canister numbers for selected drugs.",!
 I 'ATC F FQ=0:0 W ! S DIC="^PSDRUG(",DIC(0)="QEAM",DIC("S")="I $D(^(2)),$P(^(2),""^"",3)[""U""" D ^DIC K DIC Q:Y'>0  D ATCED
 K ATC,ATCN,DA,DIC,DIE,DIR,DIROUT,DIRUT,DTOUT,DUOUT,DLAYGO,DR,FQ,PSGW,X,Y Q
 ;
ATCED ;
 K DA,DR S DIE="^PSDRUG(",DA=+Y,DR=212.2 I ATC="M",$D(^PS(57.5,"AP")) S DR=DR_";212",DR(2,50.0212)="1"
 D ^DIE Q:$S($D(Y):1,ATC="M":1,1:'PSGW)  K DIR S DIR(0)="50.0212,1" D ^DIR Q:'Y  S ATCN=+Y,DA(1)=DA W !,"...working..." S:'$D(^PSDRUG(DA,212,0)) ^(0)="^50.0212P" F FQ=0:0 S FQ=$O(PSGW(FQ)) Q:'FQ  D ATCCNS
 Q
 ;
ATCCNS ;
 W "." S DA=$O(^PSDRUG(DA(1),212,"B",FQ,0)) I DA,$D(^PSDRUG(DA(1),212,DA,0)) Q:$P(^(0),"^",2)=ATCN  S DIE="^PSDRUG("_DA(1)_",212,",DR="1////"_ATCN D ^DIE Q
 K DD,DO S DIC="^PSDRUG("_DA(1)_",212,",DIC(0)="L",DIC("DR")="1////"_ATCN,DLAYGO=50.0212,X=FQ D FILE^DICN Q
 ;
ATCH ;
 W !!?2,"Enter 'M' to set up your drugs for use with multiple ATC Dispensing machines,",!,"for which you will have to enter a canister number for each ward group.  Enter",!,"'O' to set up your drugs for use with one ATC Dispensing machine"
 W ", for which",!,"the ward groups will be automatically set up for each canister number.",!,"CHOOSE FROM:",!?5,"O - ONE ATC",!?5,"M - MULTIPLE ATCS" Q
 ;
ENIU ; mark/unmark drugs for Unit Dose use
 K DIR S DIR(0)="SAO^M:MARK FOR UNIT DOSE;U:UNMARK FOR UNIT DOSE",DIR("A")="Do you want to (M)ARK or (U)NMARK items for Unit Dose? ",DIR("B")="UNMARK",DIR("?")="^D ENIUH^PSGFILD3"
 W ! D ^DIR K DIR,DIROUT,DIRUT,DTOUT,DUOUT I Y'="U",Y'="M" K X,Y Q
 S PSGY=Y,PSGS="I $P($G(^(2)),""^"",3)"_$E("'",PSGY="M")_"[""U""",PSIUX="U" K DIC
 F  S DIC="^PSDRUG(",DIC(0)="QEAM",DIC("A")="Select DRUG: ",DIC("S")=PSGS W ! D ^DIC K DIC Q:Y'>0  S PSIUDA=+Y D:PSGY="U" END^PSGIU D:PSGY="M" ENS^PSGIU W "..." W:PSGY="U" "UN" W "MARKED..."
 K FQ,PSIUDA,PSIUX,PSGS,PSGY Q
 ;
ENIUH ;
 W !!?2,"Enter 'M' to mark items for use by the Unit Dose Medications package.  (You",!,"will only be shown items that have not been marked for Unit Dose.)",!?2,"Enter 'U' to unmark items that have previously been marked for use with Unit"
 W !,"Dose.  (You will be shown only items that have already been marked for Unit",!,"Dose.)",!!,"Choose from:",!?3,"M  MARK ITEMS FOR UNIT DOSE",!?3,"U  UNMARK ITEMS FOR UNIT DOSE" Q
