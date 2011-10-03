RA105PRE ;BP/KAM - Pre-init Driver, patch 105 ; 3/9/10 1:45pm
VERSION ;;5.0;Radiology/Nuclear Medicine;**105**;Mar 16, 1998;Build 5
 ; Backup 73.2 file during a pre-install process.
 Q
PRE ;
 I '$D(^XTMP("PRE 2010-UPDATE BACKUP OF 73.2")) D
 . N X1,X2,X
 . S X1=DT,X2=180 D C^%DTC
 . S ^XTMP("PRE 2010-UPDATE BACKUP OF 73.2",0)=$G(DT)_"^"_$G(X)_"^"_"Backup of file 73.2 before 2010 update is performed Patch RA*5*105"
 . D EN^DDIOL("Backing up file 73.2 to ^XTMP.","","!!?1")
 . M ^XTMP("PRE 2010-UPDATE BACKUP OF 73.2",73.2)=^RA(73.2)
 . D EN^DDIOL("Backup complete","","!!?1")
 Q
