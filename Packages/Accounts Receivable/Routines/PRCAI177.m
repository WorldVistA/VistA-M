PRCAI177 ;WISC/RFJ-post init patch 177 ; 26 Jan 01
 ;;4.5;Accounts Receivable;**177**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
PREINIT ;  start pre init, check to make sure entries can be added to 430.2
 N RCDPOSIT,RCTRANDT
 ;
 D BMES^XPDUTL(" >>  Starting the Pre-Initialization routine ...")
 ;
 ;  remove duplicate deposit RCDPOSIT with transmission
 ;  date RCTRANDT.  You need both variables defined.
 ;
 S RCDPOSIT=269623,RCTRANDT=3020314
 D MES^XPDUTL("     ->  Removing payments for duplicate deposit "_RCDPOSIT_" ...")
 D REVERSE^RCDPXFIX(RCDPOSIT,RCTRANDT)
 D MES^XPDUTL("     ->  Finished removing duplicate deposit "_RCDPOSIT_".")
 ;
 S RCDPOSIT=269624,RCTRANDT=3020314
 D MES^XPDUTL("     ->  Removing payments for duplicate deposit "_RCDPOSIT_" ...")
 D REVERSE^RCDPXFIX(RCDPOSIT,RCTRANDT)
 D MES^XPDUTL("     ->  Finished removing duplicate deposit "_RCDPOSIT_".")
 ;
 S RCDPOSIT=269625,RCTRANDT=3020314
 D MES^XPDUTL("     ->  Removing payments for duplicate deposit "_RCDPOSIT_" ...")
 D REVERSE^RCDPXFIX(RCDPOSIT,RCTRANDT)
 D MES^XPDUTL("     ->  Finished removing duplicate deposit "_RCDPOSIT_".")
 ;
 S RCDPOSIT=269626,RCTRANDT=3020314
 D MES^XPDUTL("     ->  Removing payments for duplicate deposit "_RCDPOSIT_" ...")
 D REVERSE^RCDPXFIX(RCDPOSIT,RCTRANDT)
 D MES^XPDUTL("     ->  Finished removing duplicate deposit "_RCDPOSIT_".")
 ;
 S RCDPOSIT=269630,RCTRANDT=3020315
 D MES^XPDUTL("     ->  Removing payments for duplicate deposit "_RCDPOSIT_" ...")
 D REVERSE^RCDPXFIX(RCDPOSIT,RCTRANDT)
 D MES^XPDUTL("     ->  Finished removing duplicate deposit "_RCDPOSIT_".")
 ;
 S RCDPOSIT=269631,RCTRANDT=3020315
 D MES^XPDUTL("     ->  Removing payments for duplicate deposit "_RCDPOSIT_" ...")
 D REVERSE^RCDPXFIX(RCDPOSIT,RCTRANDT)
 D MES^XPDUTL("     ->  Finished removing duplicate deposit "_RCDPOSIT_".")
 ;
 D MES^XPDUTL(" >>  End of the Pre-Initialization routine.")
 Q
