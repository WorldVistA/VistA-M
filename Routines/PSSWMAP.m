PSSWMAP ;BIR/EJW-MAP WARNINGS FROM RX CONSULT FILE TO FDB ;05/21/04
 ;;1.0;PHARMACY DATA MANAGEMENT;**87**;9/30/97
 ;
 ;Reference to ^PS(50.625 supported by DBIA 4445
 ; This routine provides the ability to map entries from the RX CONSULT file (#54)
 ; to the new warning data source - First Data Bank's WARNING LABEL-ENGLISH file (#50.625)
 ; USERS CAN ENTER THEIR OWN MAPPING TO BE USED WITH THE WARNING LABEL BUILDER
 ;
 Q
FILL ;
 D BMES^XPDUTL("Populating the warning mapping from RX CONSULT file entries 1-6,8-11,12,13")
 D BMES^XPDUTL("and 15 to the equivalent WARNING LABEL-ENGLISH file entries.")
 N JJ
 F JJ=1:1:6,8:1:11 S DIE="^PS(54,",DA=JJ,DR="2///"_JJ D ^DIE K DIE,DA,DR
 S DIE="^PS(54,",DA=12,DR="2///19" D ^DIE K DIE,DA,DR
 S DIE="^PS(54,",DA=13,DR="2///20" D ^DIE K DIE,DA,DR
 S DIE="^PS(54,",DA=15,DR="2///30" D ^DIE K DIE,DA,DR
 S DIE="^PS(54,",DA=20,DR="3///PRECAUCION: La ley federal prohibe la transferencia de este medicamento a otro paciente para el que no fue recetado." D ^DIE K DIE,DA,DR
 D BMES^XPDUTL("Mapping complete and Spanish translation for warning number 20 populated.")
 Q
EDIT ; ADD WARNING MAPPING AND/OR SPANISH TRANSLATION TO RX CONSULT FILE ENTRY
 N MAP,NEW,RXNUM,PSSTXT
 W !!," Note: Warning mapping is only used as an aid when using the warning builder."
 W !," If a DRUG WARNING is defined with a warning mapping of 0, that entry will be"
 W !," skipped when choosing option 6 Drug has WARNING LABEL that does not map to"
 W !," new data source."
 D HDR
 S RXNUM=0 F  S RXNUM=$O(^PS(54,RXNUM)) Q:'RXNUM  D
 .D FULL I '$G(PSSOUT) W !,RXNUM,?8,$P($G(^PS(54,RXNUM,0)),"^"),?40," ",$G(^PS(54,RXNUM,2))
EDIT1 W ! S DIC=54,DIC(0)="AEMQ",DIC("A")="Enter a valid Rx Consult file number: " D ^DIC K DIC I Y<1 Q
 S RXNUM=+Y
 S PSSTXT=0 F  S PSSTXT=$O(^PS(54,RXNUM,1,PSSTXT)) Q:'PSSTXT  W !,?3,^PS(54,RXNUM,1,PSSTXT,0)
 W !
 S MAP=$P($G(^PS(54,RXNUM,2)),"^") I MAP'="" W !,"Rx Consult file number "_RXNUM_" is mapped to WARNING LABEL-ENGLISH number "_MAP D  G ASK
 .S PSSTXT=0 F  S PSSTXT=$O(^PS(50.625,MAP,1,PSSTXT)) Q:'PSSTXT  W !,?3,^PS(50.625,MAP,1,PSSTXT,0)
 K DIR W ! S DIR(0)="N0",DIR("B")=$S(MAP'="":MAP,1:""),DIR("A")="Enter a number from WARNING LABEL-ENGLISH file to map to: " D ^DIR K DIR
 I Y<0!($E(Y)="^") G SPANISH
 S NEW=+Y
 S DIE="^PS(54,",DA=RXNUM,DR="2///"_NEW D ^DIE K DIE,DA,DR
 S PSSTXT=0 F  S PSSTXT=$O(^PS(50.625,NEW,1,PSSTXT)) Q:'PSSTXT  W !,?3,^PS(50.625,NEW,1,PSSTXT,0)
 G SPANISH
ASK K DIR W ! S DIR(0)="Y",DIR("B")="N",DIR("A")="Do you want to change the mapping" D ^DIR K DIR
 I 'Y G SPANISH
 S DIE="^PS(54,",DA=RXNUM,DR="2" D ^DIE K DIE,DA,DR
 I X>0 S PSSTXT=0 F  S PSSTXT=$O(^PS(50.625,X,1,PSSTXT)) Q:'PSSTXT  W !,?3,^PS(50.625,X,1,PSSTXT,0)
SPANISH ;
 K DIR W ! S DIR(0)="Y",DIR("B")="N",DIR("A")="Do you want to enter/edit a Spanish translation for this entry" D ^DIR K DIR
 I 'Y W ! G EDIT1
 S DIE="^PS(54,",DA=RXNUM,DR=3 D ^DIE K DIE,DA,DR
 W ! G EDIT1
 Q
 ;
FULL ;
 I ($Y+3)>IOSL&('$G(PSSOUT)) D HDR
 Q
HDR ;
 K DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSSOUT=1,QUIT=1 Q
 W @IOF
 W !!,"     CURRENT WARNING MAPPING",!!
 W "DRUG WARNING",?30,"Mapped to New data source number"
 Q
