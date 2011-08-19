PRCHAMBL ;WISC/SJG/AKS-BULLETIN FOR RETURNED PURCHASE ORDER AMENDMENT ;
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
BULLET(POIEN,AMIEN,AUTODATE) ;
 K ^UTILITY($J),MSG S DIWL=0,DIWR=79,DIWF=""
 S MSG(1,0)="Fiscal Service has taken no action on the following Purchase Order Amendment."
 S MSG(2,0)="The Amendment Status has been Pending Fiscal Action for 4 or more days.!!"
 S MSG(3,0)="   ",MSG(4,0)="Purchase Order information is as follows:"
 S MSG(5,0)="   ",MSG(6,0)="Purchase Order Number: "_$P(^PRC(443.6,POIEN,0),"^",1)
 S MSG(7,0)="   ",MSG(8,0)="Amendment Number: "_AMIEN
 S XMSUB="PURCHASE ORDER AMENDMENT NOTIFICATION"
 D MSG
EXIT ;
 K DIWF,DIWL,DIWR,X,X1,XMDUZ,XMSUB,XMTEXT,XMY,AMIEN,AUTODATE,POIEN
 QUIT
 ;
MSG ; Set Variables and Call XMD
 S XMDUZ=.5,X=$O(^PRC(443.6,POIEN,6,0))
 S X1=$P($G(^PRC(443.6,POIEN,6,X,1)),U) I X1]"" S XMY(+X1)=""
 S XMY("G.SUPPLY NOTIFICATION")=""
 S XMY("G.FISCAL NOTIFICATION")="",XMTEXT="MSG(" D ^XMD
 Q
