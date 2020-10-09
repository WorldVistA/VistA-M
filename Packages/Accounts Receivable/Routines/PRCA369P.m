PRCA369P ;;MNTVBB,RGB-Set new code auto recall code in file 430.3 ;12/14/19 3:34 PM
V ;;4.5;Accounts Receivable;**369**;Mar 20, 1995;Build 15
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;;PRCA*4.5*369 Will set new transaction code 'CS AUTO RECALL BILL <$25'
 ;;             into file 430.3
 Q
EN D BMES^XPDUTL(">>> Adding entry to file 430.3 [ACCOUNTS RECEIVABLE TRANS.TYPE]..")
 ;New National Transaction code:  CS AUTO RECALL BILL <$25
 S U="^"
 S PRCATXCD="CS AUTO RECALL BILL <$25"
 ;-quit w/error message if entry already exists in file #430.3
 I $$FIND1^DIC(430.3,"","X",PRCATXCD) D  Q
 . D BMES^XPDUTL(">>>..."_PRCATXCD_" not added, code already exists.")
 . D BMES^XPDUTL("*** Please contact support for assistance. ***")
 ;
 ;-setup field values of new entry
 S PRCADA(430.3,"+1,",.01)=PRCATXCD
 S PRCADA(430.3,"+1,",1)="AR"
 S PRCADA(430.3,"+1,",2)=66
 S PRCADA(430.3,"+1,",5)=1
 ;-add new entry to file #430.3
 D UPDATE^DIE("E","PRCADA","","PRCAERR")
 ;
 I '$D(PRCAERR) D BMES^XPDUTL(">>>...."_PRCATXCD_" - "_"AR/66  added to file.")
 I $D(PRCAERR) D BMES^XPDUTL(">>>....Unable to add "_PRCATXCD_" to the file.") D
 .D BMES^XPDUTL("*** Please contact support for assistance. ***")
 .Q
 K PRCATXCD,PRCAERR,PRCADA,DIE,DIC
 Q
