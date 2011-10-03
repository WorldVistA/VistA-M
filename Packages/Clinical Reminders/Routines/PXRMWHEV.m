PXRMWHEV ; SLC/AGP - Environment check for PXRM*2.0*1 ;09/01/2004
 ;;2.0;CLINICAL REMINDERS;**1**;Feb 04, 2005
 ;
ENVCHK ;
 N TEXTI
 I +$$VERSION^XPDUTL("PXRM")'="2" S XPDABORT=1
 I $G(XPDABORT) D
 . S TEXTI(1)="This Patch is for Version 2, you are running Version 1.5."
 . S TEXTI(2)="This Patch cannot be installed until Clinical Reminders version 2 is installed."
 E  D
 . S TEXTI(1)="Environment check passed, ok to install PXRM*2.0*1"
 D EN^DDIOL(.TEXTI)
 Q
