PRCAKS ;WASH-ISC@ALTOONA,PA/CMS-AR Remove Records-Mark as ARCHIVED ;6/4/93  11:05 AM
V ;;4.5;Accounts Receivable;**67**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 NEW BEG,DATE,FDT,ND,PAGE,X,X1,X2,Y,ZTDESC,ZTRTN,ZTSAVE,%DT
 W !!,"This option will change the status of the AR Bills in the",!,"Pending Archive status that were moved to temporary storage"
 W !,"to the ARCHIVED status.  The bill data and corresponding",!,"transactions will be deleted."
 W !!,"The entries in the archival temporary storage file will be deleted."
 I $P(^PRCA(430.3,+$O(^PRCA(430.3,"AC",115,0)),0),U)'="ARCHIVED" W !!,"The ARCHIVED entry is not setup properly in File 430.3" G Q
 W !!,"Enter the Archive Date that is marked on the AR Archive Permanent Storage Label."
 W !,"This date will display when inquires are made to ARCHIVED bills.",!
 D NOW^%DTC S %DT="AEXP",%DT(0)=-%,%DT("A")="Enter the Archive Date: " D ^%DT G:+Y<1 Q S DATE=+Y
 W !!,"NOTE:  You should have verified that the data in the temporary",!,"storage file is in a permanent storage place before you continue!"
 W !!,"Are you sure you want to Archive AR data records" S %=2 D YN^DICN I %'=1 Q
 W !,"Okay, I'll send you a mail message when I'm done.",!
 S ZTRTN="DQ^PRCAKS",ZTSAVE("DATE")="",ZTDESC="Archive AR Records",ZTIO="" D ^%ZTLOAD
Q Q
DQ ;
 NEW ARN,BN0,OSTAT,PRCABN,STAT
 L +^PRCAK("PRCAK"):1 I '$T D BUSY^PRCAKS("Remove AR Records") G END
 S OSTAT=$O(^PRCA(430.3,"AC",114,0))
 S STAT=$O(^PRCA(430.3,"AC",115,0))
 F ARN=0:0 S ARN=$O(^PRCAK(430.8,ARN)) Q:'ARN  S BN0=$G(^PRCAK(430.8,ARN,0)) I BN0'="" S PRCABN=$O(^PRCA(430,"B",$P(BN0,"-",1,2),0)) I PRCABN D PUR
 D PUR^PRCAKTP
 D BULL
 L -^PRCAK("PRCAK")
END Q
PUR ;purge data records
 N DA,DIK,LN,TN
 I $P(^PRCA(430,PRCABN,0),U,8)'=OSTAT Q
 S DIK="^PRCA(433," F TN=0:0 S TN=$O(^PRCA(433,"C",PRCABN,TN)) Q:'TN  D
 .I $G(^PRCA(433,TN,0))']"" K ^PRCA(430,"C",PRCABN,TN) Q
 .S PRCAEN=TN,PRCAARC=1,PRCANOPR=1 D DELETE^PRCAWO1
 S LN=^PRCA(430,PRCABN,0)
 S DIK="^PRCA(430,",DA=PRCABN D ^DIK
 S ^PRCA(430,PRCABN,0)=$P(LN,U,1),$P(^(0),U,8)=STAT,$P(^(0),U,10)=DATE
 S DA=PRCABN D IX1^DIK
 S $P(^PRCA(430,0),U,4)=$P(^PRCA(430,0),U,4)+1
 K PRCAARC,PRCAEN,PRCANOPR
 Q
BULL ;Send total in bulletin
 N XMDUZ,XMSUB,XMTEXT,XMY
 S XMDUZ="AR ARCHIVE PACKAGE",XMSUB="AR ARCHIVE COMPLETION",XMY(+DUZ)="",XMTEXT="X1("
 S X1(1)="  The AR Archival of AR record data in the Accounts Receivable"
 S X1(2)="  File 430 and the corresponding AR Transactions in File 433"
 S X1(2)="  is complete.  The records in the temporary storage file"
 S X1(3)="  (AR Archive 430.8) were purged."
XM D ^XMD
 Q
 ;
BUSY(ARH) ;
 NEW XMDUZ,XMSUB,XMTEXT,XMY,X1
 S XMDUZ="AR ARCHIVE PACKAGE",XMSUB="Failure to Run (Busy)",XMY(+DUZ)="",XMTEXT="X1("
 S X1(1)="You attempted to run the archive process: "_ARH
 S X1(2)="This processes failed because another AR archive process",X1(3)="was already in progress."
 D ^XMD
 Q
