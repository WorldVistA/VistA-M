PRCAKM ;WASH-ISC@ALTOONA,PA/CMS-AR Mark as PENDING ARCHIVE ;10/20/94  2:20 PM
V ;;4.5;Accounts Receivable;**104**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 NEW BEG,FDT,ND,PAGE,X,X1,X2,Y,ZTDESC,ZTIO,ZTRTN,ZTSAVE,%DT
 W !!,"This option will change the status of the AR Records whose Date of",!,"Last Activity is within the time frame selected to Pending Archive.",!
 S X1=DT,X2=-3*365 D C^%DTC S (FDT,Y)=$E(X,1)_$$FY^RCFN01(X)_1001
 ;S (FDT,Y)=$E(DT,1)_($$FY^RCFN01(X))_1001 
 W !!,"NOTE:  The Archive Ending Date must be before  " D DD^%DT W Y,!
 I $P(^PRCA(430.3,+$O(^PRCA(430.3,"AC",114,0)),0),U)'="PENDING ARCHIVE" W !!,"The PENDING ARCHIVE entry is not setup properly in File 430.3" G Q
BEG W !!,"IF you want to archive all valid records through the ending date,",!,"press return to take the default of NONE.",!
 D NOW^%DTC S %DT(0)=-%,%DT="AEXP",%DT("A")="Archive Starting from Date: NONE//" D ^%DT S:X="" Y=2010101 G:Y<0 Q S BEG=Y
 S %DT="AEXP",%DT("A")="Archive Ending through Date: " D ^%DT G:Y<0 Q S END=Y
 I BEG>END W !!,*7,"*** Beginning date is greater than Ending date ***",! G BEG
 I END'<FDT W !!,*7,"*** Ending date is after cut-off date ***",! G BEG
 S X2=BEG,X1=END D ^%DTC I X>365 W !!,*7,"WARNING: The date range is greater than one year.",!,"This may cause a large amount of system activity during the Archive processes!",!
 W !!,"Are you sure" S %=2 D YN^DICN I %'=1 Q
 S ZTRTN="DQ^PRCAKM",ZTSAVE("BEG")="",ZTSAVE("END")="",ZTDESC="Mark AR Records for Archive",ZTIO="" D ^%ZTLOAD
Q Q
DQ ;
 NEW CNT,DATE,PRCA,PRCABN,STAT
 L +^PRCAK("PRCAK"):1 I '$T D BUSY^PRCAKS("Mark AR records for PENDING ARCHIVE") G END
 S CNT=0,PRCA("STATUS")=$O(^PRCA(430.3,"AC",114,0)),PRCA("SDT")=DT
 F PRCABN=0:0 S PRCABN=$O(^PRCA(430,PRCABN)) Q:'PRCABN  D
 .I $P($G(^PRCA(430,PRCABN,0)),U,8)=PRCA("STATUS") S CNT=CNT+1 Q
 .Q:$P($G(^PRCA(430,PRCABN,0)),U,8)=49
 .S DATE=$$PUR^PRCAFN(PRCABN) I DATE&(DATE'>END)&(DATE'<BEG)!(DATE=-2) D UPSTATS^PRCAUT2 S CNT=CNT+1
 D BULL
 L -^PRCAK("PRCAK")
END Q
BULL ;Send total in bulletin
 N XMDUZ,XMSUB,XMTEXT,XMY
 S XMDUZ="AR ARCHIVE PACKAGE",XMSUB="AR PENDING ARCHIVE TOTAL",XMY(+DUZ)="",XMTEXT="X1("
 S X1(1)="The total number of bills marked as Pending Archive is "_CNT,X1(2)=" "
 S X1(3)="Date Range selected: "_$S(BEG=2010101:"Beginning",1:$$SLH^RCFN01(BEG))_" thru "_$$SLH^RCFN01(END)
 S X1(4)=" "
 S X1(5)="Please forward this total to the IRM System Manager."
 S X1(6)="This total will help IRM determine the amount of system activity",X1(7)="that will occur during the AR Archival processes."
 S X1(8)=" ",X1(9)="NOTE:  This total includes the number of bills, only!"
 S X1(10)="       The number of archived records created will include the"
 S X1(11)="       number of bills and all corresponding transactions."
XM D ^XMD
 Q
