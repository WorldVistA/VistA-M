PSAENT ;BIR/LTL,JMB-Set Up/Edit a Pharmacy Location ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**21**; 10/24/97
 ;
 ;References to ^PS(59.4, are covered under IA #2505
START D DT^DICRW
 N D0,D1,DA,DIE,DIC,DIR,DIRUT,DLAYGO,DR,DTOUT,DUOUT,PSA,PSAB,PSAC,PSADRUG,PSAII,PSAIT,PSAIPS,PSAINV,PSAISIT,PSAIVLOC,PSALOC,PSAOC,PSALOCN,PSAOSIT,PSASTO,PSAITY,PSANOW,PSAOP,PSAO,PSAI,PSAOU,X,Y
 ;pick type
 S DIR(0)="S^1:INPATIENT;2:OUTPATIENT;3:COMBINED (IP/OP)",DIR("A")="Select Pharmacy type",DIR("?")="You can separate Inpatient and Outpatient or combine into one Location.",DIR("??")="PSA LOCATION EDIT"
 D ^DIR K DIR Q:'Y  S PSAITY=+Y,PSALOCN=Y(0)
 ;new IP or combined
 D:'$O(^PSD(58.8,"ADISP","P",0))
 .W !!,"Creating ",PSALOCN H 1
 .S DIC="^PSD(58.8,",DIC(0)="L",DLAYGO=58.8,X=PSALOCN,DIC("DR")="1////P",DIC("S")="I $S($P($G(^(0)),U,2)]"""":$P($G(^(0)),U,2)=""P"",1:1)" D ^DIC K DIC S PSALOC=+Y
 D:PSAITY'=2
 .;check for more than one IP site
 .S (PSA(1),PSA(2))=0 F  S PSA(1)=$O(^PS(59.4,PSA(1))) Q:'PSA(1)  S:$P($G(^(PSA(1),0)),U,26)=1 PSA(2)=PSA(2)+1,PSAB=PSA(1)
 .I PSA(2)<1 W !!,"An Inpatient Site has not been identified for AR/WS.",!!,"AR/WS dispensing data may not be gathered.",!! S:PSAITY=3 PSAO=1 S:PSAITY=1 PSAOU=1 Q
 .S:PSA(2)=1 PSAISIT=PSAB
 .D:PSA(2)>1  I Y<1 S PSAOU=1 Q
 ..W !!,"Because there is more than one Inpatient Site at this facility, I need you to"
 ..S DIC="^PS(59.4,",DIC(0)="AEMQZ",DIC("A")="select an AR/WS Inpatient Site Name: ",DIC("S")="I $P($G(^(0)),U,26)=1" D ^DIC K DIC S:$D(DUOUT)!($D(DTOUT))!(X="") PSAOU=1 S:PSAITY=3&(Y<1) PSAO=1 Q:Y<1  S PSAISIT=+Y
 .I $D(PSALOC) D  Q
 ..S DIE="^PSD(58.8,",DA=PSALOC,DR="2////^S X=PSAISIT" D ^DIE K DIE S Y=0
 .S PSALOC=""
 .F  S PSALOC=$O(^PSD(58.8,"ASITE",PSAISIT,"P",PSALOC)) Q:'PSALOC  I $S('$G(^PSD(58.8,+PSALOC,"I")):1,+^("I")>DT:1,1:0) Q
 .D:'PSALOC
 ..K DD,DO S DIC="^PSD(58.8,",DIC(0)="LZ",X=PSALOCN,DIC("DR")="1////P;2////^S X=PSAISIT" D FILE^DICN K DIC S PSALOC=+Y,PSALOCN=Y(0,0)
 .I PSALOC S PSALOCN=$P($G(^PSD(58.8,+PSALOC,0)),U) D  Q:'Y
 ..W !!,PSALOCN," is set up to gather AR/WS dispensing data for ",$P($G(^PS(59.4,PSAISIT,0)),U)
 ..;PSA*3*21 (Dave B 0 Allow selection of linking/unlinking rooms)
 ..S DIR(0)="Y",DIR("A")="Do you wish to change this",DIR("B")="No" D ^DIR K DIR S:'Y PSAO=1 S:$D(DIRUT) PSAOU=1 Q:'Y
 ..S DIR(0)="Y",DIR("A")="Do you want to change "_PSALOCN_" to "_$S($E(PSALOCN)="I":"COMBINED (IP/OP)",$E(PSALOCN)="C":"INPATIENT",1:""),DIR("B")="No" D ^DIR K DIR S:'Y PSAO=1 S:$D(DIRUT) PSAOU=1 Q:'Y  D
 ...S DIE="^PSD(58.8,",DA=PSALOC,DR=$S($E(PSALOCN)="I":".01////COMBINED (IP/OP)",$E(PSALOCN)="C":".01////INPATIENT;20////@",1:"") D ^DIE K DIE,DA S Y=1 I $E(PSALOCN)="I" S PSAO=1,PSAOC=1
 ...S PSALOCN=$P($G(^PSD(58.8,+PSALOC,0)),U)
 D:PSAITY'=2&('$G(PSAOU)) ^PSAWARD S:PSAITY=2 PSAO=1 Q:$D(PSAOU)
 I $D(PSAO) D OP^PSAENTO G QUIT
 D:'$G(PSAPVMEN) ED^PSAENTO D:$G(PSAPVMEN) DRUGS^PSAENTO
QUIT Q:'$D(PSALOC)
 W ! S DIE="^PSD(58.8,",DA=PSALOC,DR=$S(+$G(PSAPVMEN):"34Maintain reorder levels;35Days to keep invoice data;4Inactive Date",1:"4Inactive Date") D ^DIE K DIE
 Q
