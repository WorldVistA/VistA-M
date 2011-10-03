RA96PST ;BP/KAM - Post-init Driver, patch 96 ;08/21/08  12:13
VERSION ;;5.0;Radiology/Nuclear Medicine;**96**;Mar 16, 1998;Build 11
 ; Backup 73.2 file during a pre-install process.
 ; Delete CPT 90659 from file 73.2 (CPT by Procedure Type) during a
 ; post-install process of Patch RA*5*96
PRE ;
 I '$D(^XTMP("PRE-UPDATE BACKUP OF 73.2")) D
 . N X1,X2,X
 . S X1=DT,X2=180 D C^%DTC
 . S ^XTMP("PRE-UPDATE BACKUP OF 73.2",0)=$G(DT)_"^"_$G(X)_"^"_"Backup of file 73.2 before 2008 update is performed Patch RA*5*96"
 . D EN^DDIOL("Backing up file 73.2 to ^XTMP.","","!!?1")
 . M ^XTMP("PRE-UPDATE BACKUP OF 73.2",73.2)=^RA(73.2)
 Q
 ;
POST ;
 N RECIEN
 I $D(^RA(73.2,"B",90659)) D
 . S RECIEN=$O(^RA(73.2,"B",90659,""))
 . S DIK="^RA(73.2,",DA=RECIEN D ^DIK K DIK,DA
 E  D EN^DDIOL("CPT 90659 NOT FOUND","","!!?1")
 Q
