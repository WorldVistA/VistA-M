LBR25P9 ;ALB/MRY - Patch #9 Environment Check ;[04/22/02 15:44 PM ]
 ;;2.5;Library;**9**;mAR 11,  1996
EN ;
 S XPDABORT=""
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D  G ABRT
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("Your programming variables are not set up properly.")
 . D MES^XPDUTL("Installation aborted.")
 ; Verify that Library v2.5 exists, else quit
 I +$$VERSION^XPDUTL("LBR")'="2.5" D  G ABRT
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("VERSION 2.5 OF LIBRARY HAS NOT BEEN LOADED.")
 . D MES^XPDUTL("Installation aborted.")
 W !!,">> Environment check complete and okay."
 Q
 ;
ABRT ; Abort transport, but leave in ^XTMP.
 S ^XPDABORT=2 Q
 ;
POST ;Post init - remove 'out of order' messages.
 ;
 N DIC,COUNT
 S DIC="^DIC(19,",DIC(0)="X",COUNT=0
 F X="LBRY TITLES VENDOR","LBRY TITLES DUE RENEWAL" D
 . D ^DIC Q:Y<0  D
 . . S IENS=+Y_","
 . . I $$GET1^DIQ(19,IENS,2)'="" D
 . . . S COUNT=COUNT+1
 . . . I COUNT=1 D BMES^XPDUTL("*****")
 . . . I COUNT=1 D MES^XPDUTL("Clearing 'OUT OF ORDER MESSAGE for options...")
 . . . I X="LBRY TITLES VENDOR" D MES^XPDUTL("LBRY TITLES VENDOR  -  Local Titles By Vendor")
 . . . I X="LBRY TITLES DUE RENEWAL" D MES^XPDUTL("LBRY TITLES DUE RENEWAL  -  Titles Due For Renewal")
 . . . D OUT^XPDMENU(X,"")
 Q
