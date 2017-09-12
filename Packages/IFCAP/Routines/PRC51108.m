PRC51108 ;BP-OIFO/TJH ; POST INSTALL ROUTINE FOR PRC*5.1*108 ; APRIL 20, 2007
 ;;5.1;IFCAP;**108**;Oct 20, 2000;Build 10
 ;
 Q  ; access from top not allowed
 ;
EN ; Entry point
 N DA,DIC,DIE,X,Y,PRCWP,PRCERR
 S DIC="^DIC(19,",X="PRCP NON-SS ORDER BULIDER" ; look up misspelled option
 D ^DIC
 Q:Y<0  ; not found, possibly already corrected
 D BMES^XPDUTL("Correcting option name PRCP NON-SS ORDER BULIDER.")
 S DA=+Y,DIE="^DIC(19,",DR=".01////PRCP NON-SS ORDER BUILDER" D ^DIE
 S PRCWP(1)="This option will be activated only through the Task Manager and will"
 S PRCWP(2)="control the effort to automatically generate a distribution order for"
 S PRCWP(3)="all secondary inventory points not linked to a supply station."
 D WP^DIE(19,DA_",",3.5,"","PRCWP","PRCERR")
 I $D(PRCERR("DIERR")) D  Q
 . D BMES^XPDUTL("Correction of the DESCRIPTION field unsuccessful for the following reason:")
 . D MES^XPDUTL(PRCERR("DIERR",1,"TEXT",1))
 D BMES^XPDUTL("Option name has been corrected to PRCP NON-SS ORDER BUILDER")
 Q
