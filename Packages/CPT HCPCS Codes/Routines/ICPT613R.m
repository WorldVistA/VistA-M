ICPT613R ;ALB/MRY- ICPT Pre-Init Driver; 1/2/03 11:00am
 ;;6.0;CPT/HCPCS;**13**;May 19,  1997
 ;
 ;- This routine will delete the data in the CPT global files (#81-81.3).
 ;  These files MUST be reloaded upon completion of the patch istallation.
 ;  The associated file saves (from %GTO) are ICPT6_13.GLB (file 81) and ICPT6_13A.GLB (files 81.1 thru 81.3)
 ;
EN ;- Main entry point
 ;
 N I,ICPTX,XPDIDTOT
 ;- Leave header node to preserve global placement
 D BMES^XPDUTL("Deleting the CPT CATEGORY file (#81.1)...")
 S I=0 F  S I=$O(^DIC(81.1,I)) Q:I=""  K ^(I)
 D BMES^XPDUTL("Deleting the CPT COPYRIGHT file (#81.2)...")
 S I=0 F  S I=$O(^DIC(81.2,I)) Q:I=""  K ^(I)
 D BMES^XPDUTL("Deleting the CPT MODIFIER file (#81.3)...")
 S I=0 F  S I=$O(^DIC(81.3,I)) Q:I=""  K ^(I)
 S I=0,XPDIDTOT=14700
 D BMES^XPDUTL("Deleting the CPT file (#81)...")
 F ICPTX=1:1 S I=$O(^ICPT(I)) Q:I=""  K ^(I) I '(ICPTX#725) D UPDATE^XPDID(ICPTX)
 D BMES^XPDUTL(">>> File deletions complete!  Please use the appropriate global loader")
 D MES^XPDUTL("   to restore the CPT global files from ICPT6_13.GLB (CPT file, #81)")
 D MES^XPDUTL("   and ICPT6_13A.GLB [CPT CATEGORY (#81.1); CPT COPYRIGHT (#81.2)")
 D MES^XPDUTL("   and the CPT MODIFIER (#81.3) files]  IMMEDIATELY after installing")
 D MES^XPDUTL("   this patch. >>>")
