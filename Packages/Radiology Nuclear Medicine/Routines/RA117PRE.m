RA117PRE ;BP/KAM - Pre-init Driver, patch 117 ; 3/10/14 9:22am
VERSION ;;5.0;Radiology/Nuclear Medicine;**117**;Mar 16, 1998;Build 1
 ; Backup 73.2 file during a pre-install process.
 Q
PRE ;
 I '$D(^XTMP("PRE 2014-UPDATE BACKUP OF 73.2")) D
 . N X1,X2,X
 . S X1=DT,X2=180 D C^%DTC
 . S ^XTMP("PRE 2014-UPDATE BACKUP OF 73.2",0)=$G(X)_"^"_$G(DT)_"^"_"Backup of file 73.2 before 2014 update is performed Patch RA*5*117"
 . D EN^DDIOL("Backing up file 73.2 to ^XTMP.","","!!?1")
 . M ^XTMP("PRE 2014-UPDATE BACKUP OF 73.2",73.2)=^RA(73.2)
 . D EN^DDIOL("Backup complete","","!!?1")
 Q
