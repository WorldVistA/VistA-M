PRSXP50 ;WCIOFO/MGD-POST INIT FOR PATCH 50 CLASS LENGTH--9/01/99
 ;;4.0;PAID;**50**;Sep 21, 1995
 ;
 ; Post install loops through ^PRSE(452.1, and looks for any classes 
 ; with a name that is exactly 53 characters long.  For each unique 
 ; class entry found the program will then see if the related file
 ; entries in the #452 are correct and if not it will update the
 ; entries.
 ; 
 Q
 ;
FIX ; Quit if patch has been previously installed
 N NAME,REC,XNAME,DA,DR,DIE,TOTREC,BADREC,TOTCLASS
 S (TOTREC,BADREC,TOTCLASS)=0
 I $$PATCH^XPDUTL("PRS*4.0*50") D  Q
 .D BMES^XPDUTL("     Post install routine skipped since PRS*4*50 was previously installed.")
 ;
 ;
 ; Loop through ^PRSE(452.1, and looks for any unique classes with a
 ; name that is exactly 53 characters long.
 ;
 S REC=0
 D MES^XPDUTL("    Class Updated  - # Records Updated")
 D MES^XPDUTL("    __________________________________")
 F  S REC=$O(^PRSE(452.1,REC)) Q:'REC  D
 .S NAME=$P($G(^PRSE(452.1,REC,0)),U,1)
 .S TOTCLASS=TOTCLASS+1
 .; If class name is < 53 no problem so quit
 .Q:$L(NAME)<53
 .S XNAME=$E(NAME,1,52)
 .; Quit if no entry in 452
 .Q:'$D(^PRSE(452,"CLS",XNAME))
 .; Get Record Number
 .S DA=0
 .S DIE="^PRSE(452,"
 .S DR="1///^S X=NAME"
 .S BADREC=0
 .F  S DA=$O(^PRSE(452,"CLS",XNAME,DA)) Q:'DA  D
 . .;For each record number update field #1
 . .S BADREC=BADREC+1
 . .D ^DIE
 .D MES^XPDUTL("    "_NAME_" - "_BADREC)
 .S TOTREC=TOTREC+BADREC
 D BMES^XPDUTL("     "_TOTCLASS_" Classes were on file in 452.1.")
 D MES^XPDUTL("     "_TOTREC_" Attendance records were updated in file 452.")
 D BMES^XPDUTL("    Please delete routine PRSXP50 when installation is complete.")
 Q
