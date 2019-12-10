PRCA350P ;ALB/YG - POST INSTALL ;04/15/19 3:34 PM
 ;;4.5;Accounts Receivable;**350**;Mar 20, 1995;Build 66
 ;;Per VA Directive 6402, this routine should not be modified.
POSTINIT ;
 ;
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine ...")
 D MES^XPDUTL(" ")
 I '$D(^PRCA(430.3,"B","CS RE-REFER BILL REQUEST")) D
 . S DIC="^PRCA(430.3,",DIC(0)="",DLAYGO=430.3 K D0
 . S X="CS RE-REFER BILL REQUEST"
 . S DIC("DR")="1///RR;2///63;5///0"
 . D FILE^DICN
 I '$D(^PRCA(430.3,"B","CS DEBTOR RE-REFER BILL")) D
 . S DIC="^PRCA(430.3,",DIC(0)="",DLAYGO=430.3 K D0
 . S X="CS DEBTOR RE-REFER BILL"
 . S DIC("DR")="1///RS;2///64;5///0"
 . D FILE^DICN
 I '$D(^PRCA(430.3,"B","CS RE-REFER BILL CANCEL")) D
 . S DIC="^PRCA(430.3,",DIC(0)="",DLAYGO=430.3 K D0
 . S X="CS RE-REFER BILL CANCEL"
 . S DIC("DR")="1///RC;2///65;5///0"
 . D FILE^DICN
 D MES^XPDUTL(" >>  End of the Post-Initialization routine ...")
 Q
