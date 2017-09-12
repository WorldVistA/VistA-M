ICD15PR ;ALB/ABR - DRG GROUPER 15 PRE-INSTALL ; 07-JAN-98
 ;;15.0;DRG Grouper;;Feb 23, 1998
 ;
 ;  This routine kills the ICD9 and ICD0 globals 
 ;  (files 80 and 80.1)
 ;
 ;  These files must be reloaded upon completion of the
 ;  patch installation.
 ;
EN ;
 N I,XPDIDTOT,ICDX
 S I=""
 D BMES^XPDUTL("Deleting ICD OPERATION/PROCEDURE file.")
 S XPDIDTOT=4140
 F ICDX=1:1 S I=$O(^ICD0(I)) Q:I=""  K ^(I) I '(ICDX#414) D UPDATE^XPDID(ICDX)
 D BMES^XPDUTL("Deleting ICD DIAGNOSIS file.")
 S XPDIDTOT=14000
 F ICDX=1:1 S I=$O(^ICD9(I)) Q:I=""  K ^(I) I '(ICDX#700) D UPDATE^XPDID(ICDX)
 D BMES^XPDUTL(">>> File deletion complete!  Please use the appropriate global loader")
 D MES^XPDUTL("    to restore the files from ICD0_15.GBL and ICD9_15.GBL")
 D MES^XPDUTL("    IMMEDIATELY after installing this package.")
 Q
