ENXIP62 ;WCIOFO/SAB-PATCH INSTALL ROUTINE ;12/15/1999
 ;;7.0;ENGINEERING;**62**;Aug 17, 1993
 Q
 ;
PR ;Pre Install Entry Point
 ; DBIA #2878 allows update of DD global to remove cross-reference logic
 N DA,DIK
 ; set DIK to the root of the "xref multiple"
 S DIK="^DD(6926.01,.01,1,"
 ; set up DA array where
 ;   DA(2) = subfile#
 ;   DA(1) = field#
 ;   DA = xref#
 S DA(2)=6926.01,DA(1)=.01,DA=2
 ; call DIK to delete xref definition
 D ^DIK
 ; NOTE: since the triggered field is with subfile 6927.03 and is being
 ; deleted during the post install, no clean-up needs to be taken
 ; for it.
 ;
 ; if patch DI*22*12 installed then use new API to delete trigger logic
 ; since Engr patch brings in a new definition with fewer lines of code.
 S X="DDMOD" X ^%ZOSF("TEST") D:$T DELIX^DDMOD(6928,.01,2),MSG^DIALOG()
 Q
 ;
PS ;Post Install Entry Point
 N ENX
 ; create KIDS checkpoints with call backs
 F ENX="XREF","ZZSF","ISSDTO","DELTQI" D
 . S Y=$$NEWCP^XPDUTL(ENX,ENX_"^ENXIP62")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_ENX_" Checkpoint.")
 Q
 ;
XREF ; build new x-ref
 N DA,DIK
 ;
 D BMES^XPDUTL("   Building new x-ref (K) for file 6926 KEYS ISSUED...")
 ;
 ; loop thru employees
 S DA(1)=0 F  S DA(1)=$O(^ENG("KEY",DA(1))) Q:'DA(1)  D
 . ; build x-ref for entries in subfile
 . S DIK="^ENG(""KEY"","_DA(1)_",1,"
 . S DIK(1)=".01^K"
 . D ENALL^DIK
 ;
 Q
 ;
ZZSF ; remove ZZ prefixes from #6928.1 local entries when not duplicate
 N DA,DIE,DR,ENC,ENSF,ENSFX,X,Y
 ;
 D BMES^XPDUTL("   Removing ZZ prefixes from ENG SPACE FUNCTION...")
 ;
 S ENC=0 ; initialize count of modified entries
 ;
 S DIE="^ENG(6928.1,",DR=".01///^S X=ENSFX"
 ; loop thru local entries in ENG SPACE FUNCTION
 S ENSF="ZY" F  S ENSF=$O(^ENG(6928.1,"B",ENSF)) Q:ENSF=""  D
 . Q:$E(ENSF,1,2)'="ZZ"
 . S DA=$O(^ENG(6928.1,"B",ENSF,0)) Q:'DA
 . S ENSFX=$E(ENSF,3,999)
 . I ENSFX]"",'$O(^ENG(6928.1,"B",ENSFX,0)) D ^DIE S ENC=ENC+1
 D MES^XPDUTL("     ZZ prefix was removed from "_ENC_" local entries.")
 Q
 ;
ISSDTO ; Delete data dictionary and data of ISSUED TO subfile within LOCKS file
 N DIU
 ;
 I $$GET1^DID(6927.03,.01,"","LABEL")'="ISSUED TO" D  Q
 . D BMES^XPDUTL("   ISSUED TO subfile #6927.03 aleady deleted.")
 ;
 D BMES^XPDUTL("   Deleting ISSUED TO subfile #6927.03...")
 S DIU=6927.03,DIU(0)="SD" D EN^DIU2
 ;
 Q
 ;
DELTQI ; Delete TOTAL QUANTITY ISSUED field from file 6926.01
 N DIE,DA,ENFDA,ENDA,ENDA1
 ;
 I $$GET1^DID(6926.01,2,"","LABEL")'="TOTAL QUANTITY ISSUED" D  Q
 . D BMES^XPDUTL("   TOTAL QUANTITY ISSUED aleady deleted.")
 ;
 D BMES^XPDUTL("   Deleting TOTAL QUANTITY ISSUED from #6926.01...")
 ;
 ; delete data from file
 ; loop thru employees
 S ENDA=0 F  S ENDA=$O(^ENG("KEY",ENDA)) Q:'ENDA  D
 . ; loop thru keys
 . S ENDA1=0 F  S ENDA1=$O(^ENG("KEY",ENDA,1,ENDA1)) Q:'ENDA1  D
 . . ; delete value in total quantity issued
 . . Q:$P($G(^ENG("KEY",ENDA,1,ENDA1,0)),U,3)=""  ; nothing to delete
 . . K ENFDA
 . . S ENFDA(6926.01,ENDA1_","_ENDA_",",2)="@"
 . . D FILE^DIE("","ENFDA") D MSG^DIALOG()
 ;
 ; delete field from DD
 K DA S DIK="^DD(6926.01,",DA=2,DA(1)=6926.01 D ^DIK
 ;
 Q
 ;ENXIP62
