PRCAKUN ;WASH-ISC@ALTOONA,PA/CMS-Unmark Pending Archive ;8/24/93  8:09 AM
V ;;4.5;Accounts Receivable;**68**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EN1 ;Unmark records marked for archival entry point
 N %,DIC,DIR,DTOUT,DUOUT,PRCA,PRCABN,PRCATY,Y
 I $P($G(^PRCAK(430.8,0)),U,3)>0 W !!,"The PENDING ARCHIVE records were moved to temporary storage!",!,"You cannot unmark these records." G EN1Q
 S DIR("A")="Do you want to unmark ALL bills PENDING ARCHIVE",DIR("B")="NO",DIR(0)="Y",DIR("?")="Enter 'Y' to unmark all bills in this status for the same remarks" D ^DIR
 I $D(DTOUT)!$D(DUOUT) G EN1Q
 I Y=1 G ALL
 W ! S DIC("S")="I $P(^PRCA(430,+Y,0),U,8)=$O(^PRCA(430.3,""B"",""PENDING ARCHIVE"",0))",DIC(0)="AEQMZ",DIC="^PRCA(430," D ^DIC S PRCABN=+Y G:$G(PRCABN)'>0 EN1Q
 I '$P(^PRCA(430,PRCABN,9),U,6) W !!,"This bill does not have a previous status!" G EN1Q
EN1A W !,"Change the status of this bill back to ",$P($G(^PRCA(430.3,+$P(^PRCA(430,PRCABN,9),U,6),0)),U,1) S %=2 D YN^DICN D:%=1 EN1S
 I %=0 W !!,"Enter YES if you want to change the status of the bill back to the",!,"previous status to prevent the bill from being archived!",! G EN1A
EN1Q Q
EN1S ;prompt user for change status data.
 N DA,DIE,DR,X
 S DR="8////^S X="_$S($P($G(^PRCA(430,PRCABN,9)),U,6):$P(^(9),U,6),1:15)_";15;17////^S X="_$G(DUZ),DIE="^PRCA(430,",DA=PRCABN D ^DIE
 Q
ALL ;Loop on PENDING ARCHIVE status and reverse all bills
 N REM
 L +^PRCAK("PRCAK"):1 I '$T W *7,!!,"WARNING: Another AR Archive Process is still running!",!!
 L -^PRCAK("PRCAK")
 W !!,"Enter a Status Remark (3-45 characters) for all bills unmarked for archival."
REM R !,"Status Remark: ",REM:DTIME I '$T!(REM["^") G EN1Q
 I $G(REM)]"",($L(REM)<3!($L(REM)>45)) W !,"Remark must be 3-45 characters in length" G REM
 I $O(^PRCA(430.3,"AC",114,0))="" W !!,*7,"Please contact your IRM. The Pending Archive status is not setup properly!",! Q
 I '$O(^PRCA(430,"AC",$O(^PRCA(430.3,"AC",114,0)),0)) W !!,*7,"Cannot find any bills in the Pending Archive status!",! Q
 S ZTRTN="DQ^PRCAKUN",ZTIO="",ZTSAVE("REM")="" D ^%ZTLOAD
 Q
DQ ;
 NEW ST,PRCABN,X,DA,DIE,DR
 L +^PRCAK("PRCAK"):1 I '$T D BUSY^PRCAKS("Unmark ALL Pending Archive Records")  G END
 S ST=$O(^PRCA(430.3,"AC",114,0)) I ST="" G END
 S PRCABN="" F  S PRCABN=$O(^PRCA(430,"AC",ST,PRCABN)) Q:'PRCABN  D
 .I '$D(^PRCA(430,PRCABN,0)) K ^PRCA(430,"AC",ST,PRCABN) Q
 .S DR="8////^S X="_$S($P($G(^PRCA(430,PRCABN,9)),U,6):$P(^(9),U,6),1:15)_";15////^S X=$G(REM);17////^S X=DUZ",DIE="^PRCA(430,",DA=PRCABN D ^DIE
 .Q
END L -^PRCAK("PRCAK") Q
