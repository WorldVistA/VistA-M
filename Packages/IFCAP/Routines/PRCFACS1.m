PRCFACS1 ;WISC/PL-BULLETIN FOR RETURNED PRUCHASE ORDER ;12/17/93
 ;;5.1;IFCAP;**97**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 K ^UTILITY($J),MSG S DIWL=0,DIWR=79,DIWF=""
 S MSG(1,0)="The following purchase order was not obligated",MSG(2,0)="and has been  'RETURNED'  by Fiscal Service !! ",MSG(3,0)="Purchase Order information is as follows:"
 S MSG(4,0)="   ",MSG(5,0)="Purchase Order Number: "_$P(^PRC(442,DA,0),"^",1)
 S XMSUB="RETURNED PURCHASE ORDER NOTIFICATION"
 D MSG W !! S X="...Purchase Order returned, bulletin transmitted...*" D MSG^PRCFQ
EXIT ;
 K DIWF,DIWL,DIWR,X,X1,XMDUZ,XMSUB,XMTEXT,XMY
 Q
 ;
MSG ;SET VARIABLES AND CALL XMD
 S XMDUZ=DUZ,X=$S($D(^PRC(442,DA,1)):^(1),1:"") I $P(X,"^",10)]"" S X1=$P(X,"^",10) I X1]"" S XMY(+X1)="",XMTEXT="MSG(" D WAIT^PRCFYN N DIFROM D ^XMD
 Q
