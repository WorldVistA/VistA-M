LBR258P ;ALB/MRY - Env/Pre/Post-install of consolidation ;[ 02/08/01 08:21 AM]
 ;;2.5;Library;**8**;Mar 11, 1996
 ;
EN ; Environment check
 ;
 I '$G(DUZ)!($G(DUZ(0))'["@") W !,"USER 'DUZ' VARIABLES **NOT** CORRECTLY DEFINED.  CONFIRM THAT DUZ(0)='@'.  THEN D ^XUP." S XPDQUIT=1 Q
 ;
 I $$VERSION^XPDUTL("LBRY")<2.5 S QUIT=0 D  G ABRT:QUIT
 . I $$VERSION^XPDUTL("LBR")>2 Q
 . W !!,"VERSION 2.5 OF LIBRARY HAS NOT BEEN LOADED",! S QUIT=1
 D BMES^XPDUTL(">> Environment check complete and okay.")
 ;
 K QUIT Q
 ;
POST ; Post-install 
 ; Beta sites who installed a previous version of LBR*8. Otherwise, quit.
 ;
 D BMES^XPDUTL(">> Running Post-install...")
 D MES^XPDUTL("     ...Cleaning up version numbers.")
 ;
 ; Clean up version number
 S N=679.9999 F  S N=$O(^DD(N)) Q:N>689.4  I $$GET1^DID(N,"","","VERSION")?1"2.5"1A.N S ^DD(N,0,"VR")=2.5
 ;
 G POST2 ; After V7
 ;
 ; Delete fields (#40/#41 of File #682.1) previously install from
 ; patch *8 in beta sites.  These fields are not used.
 ;
 ; Quit if a field isn't found at site.
 I $$GET1^DID(682.1,41,"","LABEL")="" G POST2
 D MES^XPDUTL("     ...Removing from File (#682.1) fields #40, #41 and its data.")
 ;
 ; Delete data
 N LBRN
 S LBRN=0
 F  S LBRN=$O(^LBRY(682.1,LBRN)) Q:'LBRN  D
 . S DIE="^LBRY(682.1,",DA=LBRN,DR="40///@" D ^DIE
 . ; If data exists for field #41 (12th node), then delete.
 . I $D(^LBRY(682.1,DA,12,0)) D
 . . S DIE="^LBRY(682.1,",DA=LBRN,DR="41///@" D ^DIE
 K DIE,DA,DR
 ;
 ; Remove DD fields
 S DIK="^DD(682.1,",DA=40,DA(1)=682.1 D ^DIK
 S DIK="^DD(682.1,",DA=41,DA(1)=682.1 D ^DIK
 K DIK,DA
 ;
POST2 D BMES^XPDUTL(">> Post-install complete.")
 G EXIT
ABRT S XPDQUIT=1 Q
EXIT K QUIT,LBRN D CLEAN^DILF
 Q
