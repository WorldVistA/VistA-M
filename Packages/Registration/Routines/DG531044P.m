DG531044P ;ALB/ARF,KUM - DG*5.3*1044 INSTALL UTILITY;02/23/2021 15:21pm
 ;;5.3;Registration;**1044**;Feb 23 2021;Build 13
 ;
QUIT ;No direct entry
 ;
 ;---------------------------------------------------------------------------
 ;Patch DG*5.3*1044: Environment, Pre-Install, and Post-Install entry points.
 ;---------------------------------------------------------------------------
 ;
ENV ;Main entry point for Environment check
 Q
 ;
PRE ;Main entry point for Pre-Install items
 Q
 ;
POST ;Main entry point for Post-Install items
 D POST1  ;Recompile all compiled input templates
 D POST2  ;Update PERIOD OF SERVICE (#21) File entry AIR FORCE--ACTIVE DUTY to USAF, USSF - ACTIVE DUTY
 ;
 D BMES^XPDUTL(">>> Patch DG*5.3*1044 - Post-install complete.")
 Q
 ;
POST1 ;Recompile all compiled input templates
 ;Recompile all compiled input templates that contain specific fields.
 ;This is needed because the data dictionary definition of these fields
 ;has changed and they are being exported via KIDS.
 ;
 ; Supported ICR's:
 ;   10141: BMES^XPDUTL
 ;        : MES^XPDUTL
 ;    3352: DIEZ^DIKCUTL3
 ;
 N DGFLD
 ;
 D BMES^XPDUTL(">>> Recompile all compiled input templates that contain the following fields:")
 ;
 D BMES^XPDUTL(" o NUMBER (#.001) field in the BRANCH OF SERVICE (#23) file")
 ;build array of file and field numbers for top-level file and fields being exported
 ;array format: DGFLD(file#,field)=""
 ;recompile all compiled input templates that contain the fields in the DGLFD array passed by reference 
 S DGFLD(23,.001)=""  ;BRANCH OF SERVICE file - NUMBER field (.001)
 D DIEZ^DIKCUTL3(23,.DGFLD)
 K DGFLD
 ;
 D BMES^XPDUTL(">>> Re-compile completed.")
 ;
 Q
POST2 ; Update entry in the PERIOD OF SERVICE File (#21)
 ;
 N DGIEN,DGERR,DGNAM,DGFDA,DGIEN1,DGNAM1
 S DGERR=""
 S DGNAM="AIR FORCE--ACTIVE DUTY"
 ;
 D BMES^XPDUTL(">>> Updating PERIOD OF SERVICE file (#21) entry - AIR FORCE--ACTIVE DUTY")
 ; Check if entry exists, use it if it does
 S DGIEN=$O(^DIC(21,"B",DGNAM,0))
 I 'DGIEN D BMES^XPDUTL("    "_DGNAM_" does not exist, no action is taken.  ") Q
 S DGIEN1=DGIEN
 S DGIEN=DGIEN_","
 ;
 L +^DIC(21,0):10 I '$T D BMES^XPDUTL("     PERIOD OF SERVICE file (#21) is locked by another user. Please log CA SDM ticket. ") Q
 S DGFDA(21,DGIEN,.01)="USAF, USSF - ACTIVE DUTY"
 D UPDATE^DIE("E","DGFDA","","DGERR")
 I $D(DGERR("DIERR")) D
 . S DGERR=$G(DGERR("DIERR",1,"TEXT",1)) Q
 . D BMES^XPDUTL("     *** An Error occurred during updating PERIOD OF SERVICE file (#21) entry - AIR FORCE--ACTIVE DUTY")
 . D MES^XPDUTL("     Please log CA SDM ticket.")
 . Q
 ;
 I DGERR="" D
 . S DGNAM1=$P(^DIC(21,DGIEN1,0),"^",1)
 . D BMES^XPDUTL(" o "_DGNAM_" entry's NAME field (#.01) is updated in PERIOD OF SERVICE file (#21) to "_DGNAM1_".")
 L -^DIC(21,0)
 D BMES^XPDUTL(">>> Update of PERIOD OF SERVICE file (#21) completed.")
 Q
 ;
