ICPT64PR ;ALB/ESD - ICPT Pre-Init Driver; 2/10/98
 ;;6.0;CPT/HCPCS;**4**;May 19, 1997
 ;
 ;- This routine will delete the data in the CPT global files (#81-81.3).
 ;  These files MUST be reloaded upon completion of the patch installation.
 ;  The associated file saves (from %GTO) are ICPT6_4A.GBL (file 81) and ICPT6_4B.GBL (files 81.1-81.3)
 ;
EN ;- Main entry point
 ;
 N I,ICPTX,XPDIDTOT
 ;
 ;- Leave header node to preserve global placement
 D BMES^XPDUTL("Deleting the CPT CATEGORY file (#81.1)...")
 S I="" F  S I=$O(^DIC(81.1,I)) Q:I=""  K ^(I)
 D BMES^XPDUTL("Deleting the CPT COPYRIGHT file (#81.2)...")
 S I="" F  S I=$O(^DIC(81.2,I)) Q:I=""  K ^(I)
 D BMES^XPDUTL("Deleting the CPT MODIFIER file (#81.3)...")
 S I="" F  S I=$O(^DIC(81.3,I)) Q:I=""  K ^(I)
 S I="",XPDIDTOT=14500
 D BMES^XPDUTL("Deleting the CPT file (#81)...")
 F ICPTX=1:1 S I=$O(^ICPT(I)) Q:I=""  K ^(I) I '(ICPTX#725) D UPDATE^XPDID(ICPTX)
 D BMES^XPDUTL(">>> File deletions complete!  Please use the appropriate global loader")
 D MES^XPDUTL("    to restore the CPT global files from ICPT6_4A.GBL (CPT file, #81)")
 D MES^XPDUTL("    and ICPT6_4B.GBL [CPT CATEGORY (#81.1); CPT COPYRIGHT (#81.2)")
 D MES^XPDUTL("    and the CPT MODIFIER (#81.3) files] IMMEDIATELY after installing")
 D MES^XPDUTL("    this patch. >>>")
ENQ Q
