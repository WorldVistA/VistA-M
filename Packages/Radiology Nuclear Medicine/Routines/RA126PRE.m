RA126PRE ;BP/KAM - Pre-init Driver, patch 126 ; 1/14/16 12:57pm
VERSION ;;5.0;Radiology/Nuclear Medicine;**126**;Mar 16, 1998;Build 4
 ; Backup 73.2 file during a pre-install process.
 Q
PRE ;
 I '$D(^XTMP("PRE 2016-UPDATE BACKUP OF 73.2")) D
 . N X1,X2,X
 . S X1=DT,X2=180 D C^%DTC
 . S ^XTMP("PRE 2016-UPDATE BACKUP OF 73.2",0)=$G(X)_"^"_$G(DT)_"^"_"Backup of file 73.2 before 2016 update is performed by Patch RA*5*126"
 . D EN^DDIOL("Backing up file 73.2 to ^XTMP.","","!!?1")
 . M ^XTMP("PRE 2016-UPDATE BACKUP OF 73.2",73.2)=^RA(73.2)
 . D EN^DDIOL("Backup complete","","!!?1")
DIAG ;
 ; Update Diagnosis Code 1217 from LUNGRADS 5 TO lUNGRADS S
 ;
 S KMCODE="LUNGRADS S: SIGNIFICANT INCIDENTAL FINDING"
 K KMFDA S KMFDA(78.3,1217_",",.01)=KMCODE D FILE^DIE("","KMFDA","KMMSG")
 I $D(KMMSG) D EN^DDIOL("File 78.3 Error Message - "_KMMSG,"","!!?1")
 K KMFDA,KMMSG,KMCODE
 Q
