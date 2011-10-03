PSSTXT ;BIR/WRT-Edit DRUG TEXT file routine ; 11/15/01 8:11
 ;;1.0;PHARMACY DATA MANAGEMENT;**29,55**;9/30/97
BEGIN S PSSNFI=1,PSSFG=0 W !,"This option enables you to edit entries in the DRUG TEXT file.",!! F PSSQQ=1:1 K DA D ASK Q:PSSFG
DONE K DA,PSSFG,PSSQQ,PSSNFI,NAME,PSSENT,PSSBEG,PSSEND,PSSSRT,PSSXX
 K %,D,D0,DI,DIE,DLAYGO,DQ,DR,X,Y
 Q
 ;
ASK W ! S DIC="^PS(51.7,",DIC(0)="QEALMN",DLAYGO=51.7 D ^DIC K DIC I Y<0 S PSSFG=1 Q
 S PSSENT=+Y D WRIT,REVW W ! S DA=PSSENT S DIE="^PS(51.7,"
 D NAME I PSSFG Q
 D TEXT I PSSFG Q
 W !
 S DR="1;2" D ^DIE,CHECKI
 Q
CHECK I '$O(^PS(51.7,DA,2,0)),'$D(^PS(50.7,"DTXT",DA)),'$D(^PSDRUG("DTXT",DA)) S DIK="^PS(51.7," D ^DIK K DIK
 Q
 ;
WRIT W !!,"There may be entries in your DRUG file and PHARMACY ORDERABLE ITEM file linked",!,"to this Drug Text Name. Editing information related to this Drug Text entry",!
 W "will affect the display of information related to these.",!
 Q
 ;
REVW K DIR S DIR("A")="Do you want to review the list of drugs and orderable items linked to this Drug Text entry? ",DIR(0)="Y",DIR("B")="YES"
 S DIR("?",1)="Answering 'Yes' will list all entries in the Drug file or Orderable Item file",DIR("?",2)="that are linked to this drug text entry.  The list could be long, so a "
 S DIR("?")="device can be entered to print a hard copy, if desired."
 D ^DIR K DIR
 I Y=1 D  D RPT^PSSDTR
 . S PSSSRT="S"
 . S (PSSXX,PSSBEG,PSSEND)=$P($G(^PS(51.7,PSSENT,0)),"^",1)
 Q
 ;
OUTMSG W !!,"IMPORTANT!! After editing the Drug Text Name OR Text, review the drugs and",!?12,"orderable items linked to this entry for accuracy."
 Q
 ;
CHECKI I $P($G(^PS(51.7,DA,0)),"^",2) D MSG
 Q
 ;
MSG W !!,"Because this entry was inactivated, drugs and orderable items that are linked",!,"to this entry will no longer display the text associated with this entry."
 W !,"You should review all drugs and orderable items associated with this Drug Text",!,"entry and update appropriately.",!
 Q
 ;
NAME ;
 N PSSNAME
 W ! K DIR S DIR(0)="Y",DIR("A")="Do you want to edit the Drug Text Name",DIR("B")="NO" D ^DIR K DIR
 I X["^" S PSSFG=1 Q
 D OUTMSG
 I '$G(Y) Q
 S PSSNAME=$P($G(^PS(51.7,DA,0)),"^",1)
 W ! K DIR S DIR(0)="FO^1:75",DIR("A")="Drug Text Name: ",DIR("B")=PSSNAME D ^DIR K DIR
 I $G(X)["^" S PSSFG=1 Q
 I X'="",X'=PSSNAME D
 . I X["@" W "  **DELETIONS ARE NOT ALLOWED!" Q
 . S ^PS(51.7,"B",X,DA)="" K ^PS(51.7,"B",PSSNAME,DA)
 . S $P(^PS(51.7,DA,0),"^",1)=X
 Q
 ;
TEXT ;
 W ! K DIR S DIR(0)="Y",DIR("A")="Do you want to edit the text for this entry",DIR("B")="YES" D ^DIR K DIR
 I $G(X)["^" S PSSFG=1 Q
 I '+($G(Y)) Q
 S DR="3" D ^DIE,CHECK
 Q
 ;
