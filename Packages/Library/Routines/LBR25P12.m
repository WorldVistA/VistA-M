LBR25P12 ;ALB/MRY - Environment/Post-init ;[08/19/04 15:44 PM ]
 ;;2.5;Library;**12**;Mar 11,  1996
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
PRE ; Set 'NO' to COREFLS ACTIVE (#.1) in LIBRARY PARAMETERS (680.6) File.
 N SEQ,IEN,OUT,DA K OUT
 D LIST^DIC(680.6,"","@","","","","","","","","OUT")
 S SEQ=0 F  S SEQ=$O(OUT("DILIST",2,SEQ)) Q:'SEQ  D
 . S IEN=OUT("DILIST",2,SEQ)
 . S DA=IEN,DR=".1///NO",DIE="^LBRY(680.6," D ^DIE
 Q
 ;
POST ;Post init - Disable Corefls option.
 N DIC,TEXT,COUNT
 S DIC="^DIC(19,",DIC(0)="X",COUNT=0
 F X="LBRY LOCAL VENDOR ADD","LBRY COREFLS CONVERSION" D
 . D ^DIC Q:Y<0  S COUNT=COUNT+1 D
 .. I COUNT=1 D BMES^XPDUTL("*****")
 .. D MES^XPDUTL("Putting ["_X_"] option - 'out of order'")
 .. S TEXT="CoreFLS Disabled (LBR*2.5*12)"
 .. D OUT^XPDMENU(X,TEXT)
 Q
