RA115PRE ;BP/KAM - Pre-init Driver, patch 115 ; 3/6/13 9:30am
VERSION ;;5.0;Radiology/Nuclear Medicine;**115**;Mar 16, 1998;Build 1
 ; Backup 73.2 file during a pre-install process.
 Q
PRE ;
 I '$D(^XTMP("PRE 2013-UPDATE BACKUP OF 73.2")) D
 . N X1,X2,X
 . S X1=DT,X2=180 D C^%DTC
 . S ^XTMP("PRE 2013-UPDATE BACKUP OF 73.2",0)=$G(X)_"^"_$G(DT)_"^"_"Backup of file 73.2 before 2013 update is performed Patch RA*5*115"
 . D EN^DDIOL("Backing up file 73.2 to ^XTMP.","","!!?1")
 . M ^XTMP("PRE 2013-UPDATE BACKUP OF 73.2",73.2)=^RA(73.2)
 . D EN^DDIOL("Backup complete","","!!?1")
 Q
