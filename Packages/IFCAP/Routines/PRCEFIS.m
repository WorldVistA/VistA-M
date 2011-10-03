PRCEFIS ;WISC/CTB/CLH-FISCAL UTILITIES ;09/28/93  4:22 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
CLOSE ;Close/complete 1358
 N DIR,Y,X,PRC,PRCF,PRCFA,PO,ER,ZX,DIC,DA,Z,%,STATUS,LOOK
 S LOOK="",DIR("A",1)="This option will mark a 1358 as complete.  No further authorizations",DIR("A",2)="or liquidations may be made while the document is closed.",DIR("A")="Ok to continue",DIR(0)="YO",DIR("B")="Yes" D ^DIR K DIR
 I Y["^"!(Y=0) Q
 D LOOKUP I '% S X="Unable to find this document.  Contact application coordinator.*" D MSG^PRCFQ Q
 I STATUS=40 S X="This 1358 has already been marked as closed." D MSG^PRCFQ Q
 I STATUS'=100 S X="Only status of 'Obligated - 1358' documents may be closed.*" D MSG^PRCFQ Q
 S DA=PRCFA("PODA")
 S PO=$$BAL^PRCH58(DA) W !!,?3,"Obligation Blanace: $ ",$J($FN($P(PO(8),U),",",2),12),?48,"Service Balance: $ ",$J($FN($P(PO(8),U,3),",",2),12),!,?49,"Fiscal Balance: $ ",$J($FN($P(PO(8),U,2),",",2),12),!!
 S DIR("A")="Okay to continue",DIR("B")="Yes",DIR(0)="YO",DIR("?")="Enter yes or <RETURN> to complete this 1358" D ^DIR K DIR
 I Y=0!(Y["^") Q
 W !! S X=40 D ENF^PRCHSTAT S X="Status changed to 'TRANSACTION COMPLETE'.*" D MSG^PRCFQ Q
 ;
REOPEN ;reopen 1358 document
 N DIR,Y,X,PRC,PRCF,PRCFA,PO,ER,ZX,DIC,DA,Z,%,STATUS,LOOK
 S LOOK="",DIR("A",1)="This option will reopen a 1358 and make it available for posting authorizations",DIR("A",2)="and liquidations.",DIR("A")="Okay to continue",DIR(0)="YO",DIR("B")="Yes" D ^DIR K DIR
 I Y["^"!(Y=0) Q
 D LOOKUP Q:'%
 I STATUS'=40 S X="Only 1358 with status of 'Transaction Complete' may be reopened" D MSG^PRCFQ Q
 S DA=PRCFA("PODA")
 S PO=$$BAL^PRCH58(DA) W !!,?3,"Obligation Blanace: $ ",$J($FN($P(PO(8),U),",",2),12),?48,"Service Balance: $ ",$J($FN($P(PO(8),U,3),",",2),12),!,?49,"Fiscal Balance: $ ",$J($FN($P(PO(8),U,2),",",2),12),!!
 S DIR("A")="Okay to continue",DIR("B")="Yes",DIR(0)="YO",DIR("?")="Enter yes or <RETURN> to REOPEN this 1358" D ^DIR K DIR
 I Y=0!(Y["^") Q
 W !! S X=100 D ENF^PRCHSTAT S X="Status changed to 'Obligated - 1358'.*" D MSG^PRCFQ
 Q
 ;
LOOKUP ;lookup obligation
 S PRCF("X")="AS" D ^PRCFSITE Q:'%
 D LIQ^PRCH58LQ(.PRCFA,.Y,.ER,.PO) I 'ER S %=0 Q
 W ! S STATUS="" I $G(PO(7))]"",$D(^PRCD(442.3,$P(PO(7),U),0)) S STATUS=$P(PO(7),U,4)
 I STATUS="" S X="Invalid status - no action taken*" D MSG^PRCFQ S %=0
 I STATUS=105 S X="1358 has been cancelled.  No action taken.*" D MSG^PRCFQ S %=0 Q
 S %=1 Q
 ;
