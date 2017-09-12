ICPT63PR ;ALB/ESD - ICPT Pre-Init Driver; 2/10/98
 ;;6.0;CPT/HCPCS;**3**;May 19, 1997
 ;
 ;- This routine will delete the data in the ^ICPT global (file #81).
 ;  This file MUST be reloaded upon completion of the patch installation.
 ;
 ;
EN ;- Main entry point
 ;
 N I,ICPTX,XPDIDTOT
 ;
 ;- Leave header node to preserve global placement
 S I=0
 S XPDIDTOT=14300
 D BMES^XPDUTL("Deleting the CPT file (#81)...")
 F ICPTX=1:1 S I=$O(^ICPT(I)) Q:I=""  K ^(I) I '(ICPTX#650) D UPDATE^XPDID(ICPTX)
 D BMES^XPDUTL(">>> File deletion complete!  Please use the appropriate global loader")
 D MES^XPDUTL("    to restore the CPT global file from ICPT6_3.GBL IMMEDIATELY after")
 D MES^XPDUTL("    installing this patch. >>>")
ENQ Q
