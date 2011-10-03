PRCFACS3 ;WISC/SJG-BULLETIN FOR RETURNED PRUCHASE ORDER AMENDMENT ;7/24/00  23:20
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
BULLET(POIEN,AMIEN,AUTODATE) ;
 K ^UTILITY($J),MSG S DIWL=0,DIWR=79,DIWF=""
 S MSG(1,0)="The following Purchase Order Amendment was not obligated"
 S MSG(2,0)="and has been 'RETURNED' by Fiscal Service !!"
 S MSG(3,0)="   ",MSG(4,0)="Purchase Order information is as follows:"
 S MSG(5,0)="   ",MSG(6,0)="Purchase Order Number: "_$P(^PRC(443.6,POIEN,0),"^",1)
 S MSG(7,0)="   ",MSG(8,0)="Amendment Number: "_AMIEN
 I AUTODATE]"" D
 .S MSG(9,0)="   ",MSG(10,0)="Automatic Deletion Date: "_AUTODATE
 .Q
 S XMSUB="RETURNED PURCHASE ORDER AMENDMENT NOTIFICATION"
 D MSG,MSG1
EXIT ;
 K DIWF,DIWL,DIWR,X,X1,XMDUZ,XMSUB,XMTEXT,XMY
 Q
 ;
MSG ; Set Variables and Call XMD
 S XMDUZ=DUZ,X=$S($D(^PRC(443.6,POIEN,1)):^(1),1:"") I $P(X,"^",10)]"" S X1=$P(X,"^",10) I X1]"" S XMY(+X1)="",XMTEXT="MSG(" W ! D WAIT^PRCFYN,^XMD
 Q
MSG1 ; Message Processing
 W !!,"...Purchase Order Amendment was returned, bulletin has been transmitted..."
 W !!,"...Supply has been notified...",!!
 Q
