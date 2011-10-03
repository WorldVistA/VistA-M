PSDNACT ;BIR/JPW-Inactivate NAOUs ; 6 July 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 W !!,?10,"Inactivate NAOUs" D NOW^%DTC S PSDT=X
NAOU ;
 K DIC F  W ! S DIC=58.8,DIC(0)="QEA",DIC("A")="Select NAOU: ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$P(^(0),""^"",2)'=""P""" D ^DIC K DIC Q:Y<0  S PSDA=+Y,PSDN=$P(Y,"^",2) K DA,DIE,DR S DIE=58.8,DA=+PSDA,DR="4" D ^DIE K DIE,DR D LOOP
END K %,%H,%I,DA,DIC,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT,PSDA,PSDN,PSDR,PSDT,X,Y
 Q
LOOP ;asks for inactivating drugs and loops to complete
 I $S('$D(^PSD(58.8,PSDA,"I")):1,'^("I"):1,^("I")>DT:1,1:0) W !!,"This NAOU is now ACTIVE.  Use the Inactivate NAOU Stock Drug option",!,"to reactivate stocked drugs within "_PSDN_"." Q
 W !! K DA,DIR S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you want to inactivate ALL stocked drugs within this NAOU"
 S DIR("?",1)="Answer 'YES' to inactivate all stocked drugs in this NAOU,",DIR("?")="answer 'NO' to leave all stocked drugs ACTIVE in this NAOU."
 D ^DIR K DIR I 'Y!$D(DIRUT) D MSG Q
 I '$D(^PSD(58.8,PSDA,1,0)) W !!,"There are no stocked drugs for this NAOU!!",!! Q
 W !!,"Inactivating all stocked drugs within "_PSDN_"..."
 F PSDR=0:0 S PSDR=$O(^PSD(58.8,PSDA,1,PSDR)) Q:'PSDR  I $D(^PSD(58.8,PSDA,1,PSDR,0)) K DA,DIE,DR S DA=+PSDR,DA(1)=+PSDA,DIE="^PSD(58.8,"_PSDA_",1,",DR="13////"_PSDT_";14////O;14.5////NAOU INACTIVATED" D ^DIE K DIE,DR W "."
MSG W !!,PSDN," has been inactivated.",!
 Q
