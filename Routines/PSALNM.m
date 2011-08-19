PSALNM ;BIR/LTL-NDC Duplicates Report (ITEM MASTER file) ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;; 10/24/97
 ;This routine manually loops through the DRUG file for any unmatched
 ;entries that have an NDC link to an item in the ITEM MASTER file.
 ;
 D DT^DICRW
START ;sets up edit loop
 N D0,D1,DA,DIC,DIE,DLAYGO,DR,DTOUT,DUOUT,DIRUT,PSA,PSAD,PSADD,PSAIT,X,Y S (PSA,PSAD)=0,Y=1
EXPL W !,"I'll look through your DRUG file for any unmatched entries that have",!,"an NDC link to an item in the ITEM MASTER file.",!
LOOP F  K PSADD S PSAD=$O(^PSDRUG(PSAD)) G:'PSAD!($D(DIRUT)) QUIT I $P($G(^PSDRUG(PSAD,2)),U,4)]"" S PSAD(1)=$P($G(^(2)),U,4) D:'$D(^PSDRUG(PSAD,"I"))
 .S PSAIT=$$ITEM^PSAUTL(PSAD(1)) Q:'PSAIT  I $D(^PRC(441,+PSAIT,0)) D  Q:$D(PSADD)  W !,$E($P(^PSDRUG(PSAD,0),U),1,39)
NOT ..S:$O(^PSDRUG("AB",PSAIT,"")) PSADD="" I $D(^PRC(441,PSAIT,3)),$P(^(3),U)=1 S PSADD=""
 .I $L($G(^PRC(441,+PSAIT,1,1,0)))<40,'$O(^PRC(441,+PSAIT,1,1)) W ?40,$G(^PRC(441,+PSAIT,1,1,0)) G ED
 .K ^UTILITY($J,"W") S DIWL=40,DIWR=80,DIWP="W"
 .F  S PSA=$O(^PRC(441,+PSAIT,1,PSA)) Q:'PSA  S X=$G(^PRC(441,+PSAIT,1,+PSA,0)) D ^DIWP D ^DIWW
 .S PSA=0
ED .S DIR(0)="Y",DIR("A")="Do we have a match",DIR("B")="Yes" W ! D ^DIR K DIR W ! Q:Y<1  D
OK ..S DIE=50,DA=PSAD,DR="441///^S X=PSAIT" D ^DIE W "  Linked to Item #"_PSAIT
QUIT Q
