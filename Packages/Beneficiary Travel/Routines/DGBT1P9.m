DGBT1P9 ;ALB/MRY - Patch #9 Environment/Post-init ; 8/18/04
 ;;1.0;Beneficiary Travel;**9**;Septembr 25, 2001
EN ;
 S XPDABORT=""
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D  G ABRT
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("Your programming variables are not set up properly.")
 . D MES^XPDUTL("Installation aborted.")
 ; Verify that Bene Travel v1.0 exists, else Quit.
 I $$VERSION^XPDUTL("DGBT")'="1.0" D  G ABRT
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("VERSION 1.0 OF BENEFICIARY TRAVEL HAS NOT BEEN LOADED.")
 . D MES^XPDUTL("Installation aborted.")
 W !!,">> Environment check complete and okay."
 Q
 ;
ABRT ; Abort transport, but leave in ^XTMP.
 S ^XPDABORT=2 Q
 ;
PRE ; Set 'NO' to COREFLS ACTIVE (#723) in MAS PARAMETERS (#43) File.
 N SEQ,IEN,OUT,DA K OUT
 D LIST^DIC(43,"","@","","","","","","","","OUT")
 S SEQ=0 F  S SEQ=$O(OUT("DILIST",2,SEQ)) Q:'SEQ  D
 . S IEN=OUT("DILIST",2,SEQ)
 . S DA=IEN,DR="723///NO",DIE="^DG(43," D ^DIE
 Q
 ;
POST ; Disable BeneTravel Corefls options.
 N DIC,TEXT,COUNT
 S DIC="^DIC(19,",DIC(0)="X",COUNT=0
 F X="DGBT LOCAL VENDOR ADD","DGBT LOCAL VENDOR MENU","DGBT LOCAL VENDOR UPDATE" D
 . D ^DIC Q:Y<0  S COUNT=COUNT+1 D
 .. I COUNT=1 D BMES^XPDUTL("*****")
 .. D MES^XPDUTL("Putting ["_X_"] option - 'out of order'")
 .. S TEXT="CoreFLS Disabled (DBGT*1*9)"
 .. D OUT^XPDMENU(X,TEXT)
 Q
