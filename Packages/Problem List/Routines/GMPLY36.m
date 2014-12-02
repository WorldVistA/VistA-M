GMPLY36 ; ISL/JER - Pre-/Post-Install Routine for GMPL*2*36 ;11/30/12  12:53
 ;;2.0;Problem List;**36**;Aug 25, 1994;Build 65
 Q
PRE ; Pre-install subroutine
 ;
 Q
 ;
POST ; Post-install subroutine
 ;
 ; if GMPL*2*44 has been installed, new indexes required by Reminders for ICD-10 will need
 ; to be re-installed and refreshed.
 ;
 ; Has GMPL*2*44 been installed?
 I '+$$PATCH^XPDUTL("GMPL*2.0*44") Q
 ; Call POST^GMPLP44I if available
 I '$L($T(POST^GMPLP44I)) Q
 D BMES^XPDUTL(" Reinstalling indexes from GMPL*2*44 required by Reminders...")
 D POST^GMPLP44I
 Q
