PRCHRET ;WISC/AKS-PULL AMENDMENTS BACK TO SUPPLY ;7/19/95  13:56
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
PULL ;Return Purchase Order Amendment to Supply
 D ^PRCFSITE Q:'%
 D KILL
ASKPO ;Ask for purchase order and validate it.
 K DIC("A") S D="E"
 S DIC("S")="I +^(0)=PRC(""SITE"") S FSTAT=$O(^PRC(443.6,""D"",+Y,0)) I FSTAT=26!(FSTAT=31)!(FSTAT=36)!(FSTAT=45)!(FSTAT=71)"
 S DIC("A")="Select Purchase Order Number: ",DIC=443.6,DIC(0)="AEQZ"
 D IX^DIC K DIC,FSTAT,D G:+Y<0 KILL
 S FLG=0,NODE0=Y(0),PO=Y,PRCFPODA=+Y,PRCFA("PODA")=+Y
 I '$D(^PRC(443.6,+PO,6)) D  G ASKPO
 .W !! S X="NO AMENDMENT EXISTS FOR THIS ORDER .  OPTION IS BEING ABORTED." D MSG^PRCFQ W !
 I '$$VERIFY^PRCHES5(PRCFPODA) D  G KILL
 .W !!,"This Purchase Order has been tampered with.  Please notify IFCAP APPLICATION COORDINATOR."
 S AMEND=$O(^PRC(443.6,+PO,6,0)) I +AMEND'>0 D NOSIGN G ASKPO
 S AMEND1=$G(^PRC(443.6,+PO,6,+AMEND,1)) I $P(AMEND1,U,2)="" D NOSIGN G ASKPO
 S PRCFA("AMEND#")=+AMEND,PRCFAA=+AMEND
 W ! D READ I 'Y!($D(DIRUT))  D NOPROC K DIRUT G ASKPO
 I Y D
 .D REMOVE^PRCHES10(+PO,PRCFAA) I Y=-1 W !,"INCOMPLETE RECORD" G KILL
 .N DA,DIE,DR
 .S DIE="^PRC(443.6,"_+PO_",6,",DA=PRCFAA,DR="15///TODAY+7" D ^DIE
 .Q
 W !! G ASKPO
READ ; Reader 
 S DIR(0)="Y",DIR("A")="Amendment",DIR("B")="YES"
 S DIR("A",1)="Are you sure you want to pull back this Purchase Order"
 S DIR("?")="Enter 'NO' or 'N' or '^' to exit this option."
 S DIR("?",1)="Enter 'YES' or 'Y' or 'RETURN' to pull back this Purchase Order to"
 S DIR("?",2)="Supply.",DIR("?",3)=" "
 D ^DIR K DIR
 Q
NOAMEND ;No amendment to pull
 W !! S X="NO AMENDMENT EXISTS FOR THIS ORDER .  OPTION IS BEING ABORTED ." D MSG^PRCFQ W !
 Q
NOSIGN ; Message Processing for amendments still in Supply
 W !! S X="This Purchase Order Amendment is already in Supply.*" D MSG^PRCFQ W !
 Q
NOPROC ; Message Processing for exit
 W !! S X="No further processing is being taken on this amendment obligation.*" D MSG^PRCFQ W !
 Q
KILL ;Kill local variables
 K FLG,%,PO,PRCFA,PRCFAA,PRCFPODA,X,Y,NODE0,AMEND,AMEND1
 Q
