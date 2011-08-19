PRCFRET ;WISC/SJG-RETURN PO AND AMENDMENTS TO SUPPLY ;7/24/00  23:08
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ; 
 ; No top level entry
 QUIT
EN1 ; Return Purchase Order to Supply
 QUIT
EN2 ; Return Purchase Order Amendment to Supply
 D ^PRCFSITE Q:'%  D OUT1
 K FAIL D ES2 I $D(FAIL) K FAIL G OUT1
START K DIC("A") S D="E",DIC("S")="I +^(0)=PRC(""SITE"") S FSO=$O(^PRC(443.6,""D"",+Y,0)) I FSO=26!(FSO=31)!(FSO=36)!(FSO=45)!(FSO=71)",DIC("A")="Select Purchase Order Number: ",DIC=443.6,DIC(0)="AEQZ"
 D IX^DIC K DIC("S"),DIC("A"),FSO G:+Y<0 OUT1
 S FLG=0,PO(0)=Y(0),PO=Y,PRCFPODA=+Y,PRCFA("PODA")=+Y
 I '$D(^PRC(443.6,+PO,6)) D NOA G START
 I $P(^PRC(443.6,+PO,6,0),"^",4)<0 D NOA G START
 I '$$VERIFY^PRCHES5(PRCFPODA) W !!,"This Purchase Order has been tampered with.  Please notify IFCAP APPLICATION COORDINATOR." G OUT1
AMEND S DIC="^PRC(443.6,"_+PO_",6,",DIC("A")="Select AMENDMENT: ",DIC(0)="AEMNZQ" D ^DIC K DIC("A") I Y<0 D MSG G START
 S PO(6)=Y(0),PO(6,1)=^PRC(443.6,+PO,6,+Y,1),PRCFA("AMEND#")=+Y,PRCFAA=+Y
 I $P($G(^PRC(443.6,+PO,6,PRCFAA,1)),U,2)="" D MSG2 G START
 W ! D READ I 'Y!($D(DIRUT))  D MSG G START
 I Y D
 .D REMOVE^PRCHES10(+PO,PRCFAA) I Y=-1 W !,"INCOMPLETE RECORD" G OUT1
 .N DA S DIE="^PRC(443.6,"_+PO_",6,",DA=PRCFAA,DR="15///TODAY+7" D ^DIE
 .N SUBINFO S SUBINFO="443.67^15^"_PRCFAA
 .D GENDIQ^PRCFFU7(443.6,+PO,50,"IEN",SUBINFO)
 .S AUTODEL=$G(PRCTMP(443.67,PRCFAA,15,"E"))
 .D BULLET^PRCFACS3(+PO,PRCFAA,AUTODEL)
 .Q
 G START
ES2 ; E-Sig code for amendment
 N MESSAGE S MESSAGE=""
 D ESIG^PRCUESIG(DUZ,.MESSAGE)
 G:(MESSAGE=0)!(MESSAGE=-3) FAIL ;3 TRIES or NO SIG ON FILE
 G:(MESSAGE=-1)!(MESSAGE=-2) FAIL1 ;ARROWED OUT or TIMED OUT
 Q
READ ; Reader 
 S DIR(0)="Y",DIR("A",1)="Are you sure that you do not want to obligate this Purchase Order",DIR("A")="Amendment",DIR("B")="YES"
 S DIR("?")="Enter 'NO' or 'N' or '^' to exit this option."
 S DIR("?",1)="Enter 'YES' or 'Y' or 'RETURN' to return this Purchase Order to",DIR("?",2)="Supply, unobligated.",DIR("?",3)=" "
 D ^DIR K DIR
 Q
OUT1 K FLG,%,%Y,DIC,I,J,K,P,PO,PRCFA,PRCFAA,PRCFPODA,PRCFCHG,X,Y,Z
 Q
NOA ; Message Processing for No Amendment
 W !! S X="NO AMENDMENT EXISTS FOR THIS ORDER - PLEASE CHECK WITH SUPPLY.  OPTION IS BEING ABORTED.*" D MSG^PRCFQ W ! Q
MSG ; Message Processing for exit
 W !! S X="No further processing is being taken on this amendment obligation.*" D MSG^PRCFQ W ! Q
MSG2 ; Message Processing for amendments still in Supply
 W !! S X="This Purchase Order Amendment is still awaiting signature by Supply.*" D MSG^PRCFQ W ! Q
 ; E-SIG Message Processing
FAIL S FAIL="" W !,$C(7),"   SIGNATURE CODE FAILURE " R X:3 Q
FAIL1 S FAIL="" Q
