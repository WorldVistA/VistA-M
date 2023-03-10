DG1071P ;BIR/JFW - DG*5.3*1071 Post-Init ;2/22/22  16:02
 ;;5.3;Registration;**1071**;Aug 13, 1993;Build 4
 ;
 ;BMES^XPDUTL and MES^XPDUTL - DBIA #10141 Supported
 ;
 ;STORY VAMPI-13802 (jfw) - Enable Auditing on PHONE NUMBER [CELLULAR]
 ;STORY VAMPI-13671 (dri) - File '200CRNR' as this site's Cerner Station Number
 ;
POST ;
 D BMES^XPDUTL("Post-Install: Starting")
 D ENAUDIT  ;Enable auditing on Cell Phone (#.134) in the PATIENT File (#2)
 I $D(^MPIF(984.8)) D DEFCRNR ;File '200CRNR' as this site's Cerner Station Number, only file at sites installing mpif* patches (not legacy, forum, claims, etc.)
 D BMES^XPDUTL("Post-Install: Finished")
 Q
 ;
ENAUDIT ;Enable auditing on PATIENT (#2) field PHONE NUMBER [CELLULAR] (#.134)
 D BMES^XPDUTL("   >> Enabled AUDIT(ing) on the PHONE NUMBER [CELLULAR] field")
 D MES^XPDUTL("        in the PATIENT (#2) file!")
 D TURNON^DIAUTL(2,.134)  ;DBIA #4397 Supported
 Q
 ;
DEFCRNR ;File '200CRNR' as the Cerner Station Number for this site
 ;
 ;all sites will default to '200CRNR'
 ;some test environments could be updated to something else
 ;
 N DGFAC,DGIEN,DGMSG,DIERR,FDA,IEN
 S DGFAC="200CRNR" ;default Cerner Station Number
 D BMES^XPDUTL("   >> Filing '"_DGFAC_"' as the Cerner Station Number for this site.")
 S DGIEN=$O(^MPIF(984.8,"B","FOUR",0)) I DGIEN D BMES^XPDUTL("   >> '"_$P($G(^MPIF(984.8,DGIEN,0)),"^",5)_"' already defined for this site.") Q
 S FDA(984.8,"?+1,",.01)="FOUR"
 S FDA(984.8,"?+1,",4)=DGFAC ;STATUS (#4) field in the MPI ICN BUILD MANAGEMENT (#984.8) file
 S IEN(1)=4
 D UPDATE^DIE("E","FDA","IEN","DGMSG")
 I $D(DGMSG) D BMES^XPDUTL("   >> ERROR!!  The Cerner Station Number, '"_DGFAC_"' was NOT filed."),MES^XPDUTL("       [#"_$G(DGMSG("DIERR",1))_": "_$G(DGMSG("DIERR",1,"TEXT",1))_"]") Q
 D MES^XPDUTL("   >> '"_DGFAC_"' successfully filed.")
 Q
 ;
