ICPT606P ;ALB/DW - ICPT*6.0*6 POST INSTALL ROUTINE ; 22 JUNE 1999
 ;;6.0;CPT/HCPCS;**6**;May 19, 1997
 ;
 ;
 Q
POST ;This routine will delete file ^DIC(81.3, the CPT modifier file.
 N XPDIDTOT,ICPTX,X
 S X=0,XPDIDTOT=400
 D BMES^XPDUTL("Deleting the CPT MODIFIER file (#81.3)...")
 F ICPTX=1:1 S X=$O(^DIC(81.3,X)) Q:X=""  K ^(X) I '(ICPTX#40) D UPDATE^XPDID(ICPTX)
 D BMES^XPDUTL("You must restore the CPT MODIFIER file after installation of this patch.")
 D MES^XPDUTL("The file is located in ICPT6_6.GBL.")
 Q
