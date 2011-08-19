PRCFAC32 ;WISC/SJG-BULLETIN TO SUPPLY FOR FISCAL VENDOR ADD/EDIT ;7/24/00  23:21
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
BULLET(VEN) ;
 K ^UTILITY($J),MSG S DIWL=0,DIWR=79,DIWF=""
 S MSG(1,0)="The following Vendor has been added or edited by Fiscal Service."
 S MSG(2,0)="  "
 S MSG(3,0)="  ",MSG(4,0)="Vendor information is as follows:"
 S MSG(5,0)="  ",MSG(6,0)="Vendor Name: "_PRCTMP(440,VEN,.01,"E")
 S MSG(7,0)="  ",MSG(8,0)="Please update other information as necessary."
 S XMSUB="VENDOR ADD/EDIT BY FISCAL"
 D MSG,MSG1
EXIT ;
 K DIWF,DIWL,DIWR,X,X1,XMDUZ,XMSUB,XMTEXT,XMY
 Q
 ;
MSG ; Set Variables and Call XMD
 ; Sent to members of mail group SUPPLY NOTIFICATION
 S N=$O(^XMB(3.8,"B","SUPPLY NOTIFICATION","")) Q:N=""
 S M="" F  S M=$O(^XMB(3.8,N,1,"B",M)) Q:M=""  S XMY(+M)=""
 Q:'$O(XMY(""))  S XMDUZ=DUZ,XMTEXT="MSG("
 W ! D WAIT^PRCFYN,^XMD
 Q
MSG1 ; Message Processing
 W !!,"...Vendor payment information has been added or edited, bulletin has been transmitted..."
 W !!,"...Supply has been notified...",!!
 Q
