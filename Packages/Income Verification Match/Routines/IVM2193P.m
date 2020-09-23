IVM2193P ;ALB/JAM - IVM*2.0*193 PRE-INSTALL ROUTINE ;3/31/2020 3:21pm
 ;;2.0;INCOME VERIFICATION MATCH;**193**;21-OCT-94;Build 37
 ;
 ;Clean up 301.92 file (IVM DEMOGRAPHIC UPLOAD FIELDS) - remove IENs over 150 if patch 941 had been installed more than once
 ;and patch IVM 193 has not already been installed.
 ;
 ; IAs:
 ;  BMES^XPDUTL, MES^XPDUTL, INSTALDT^XPDUTL:  Supported by IA #10141
 Q
EP ; Entry Point
 D BMES^XPDUTL(">>> Cleanup of IENs in IVM DEMOGRAPHIC UPLOAD FIELDS file (#301.92)...")
 ;
 ; No need for cleanup if patch IVM 193 has already been installed
 I $$INSTALDT^XPDUTL("IVM*2.0*193") D MES^XPDUTL(" Patch IVM*2.0*193 previously installed - cleanup not needed.") Q
 ;
 N IVMX,IVMRESULT
 ; No need for cleanup if patch 941 has been installed only once
 S IVMX=$$INSTALDT^XPDUTL("DG*5.3*941",.IVMRESULT)
 I IVMRESULT=1 D MES^XPDUTL(" Patch DG*5.3*941 not installed multiple times - cleanup not needed.") Q
 ;
 N IVMIEN,IVMNUM
 ; sweep through 301.92 file removing any IENs above 150 (PHONE NUMBER [WORK])
 S IVMNUM=0,IVMIEN=150
 F  S IVMIEN=$O(^IVM(301.92,IVMIEN)) Q:'IVMIEN  D
 . S IVMNUM=IVMNUM+1
 . ; remove the IEN from the file
 . S DA=IVMIEN,DIK="^IVM(301.92," D ^DIK K DA,DIK
 D MES^XPDUTL(" Cleanup is complete.")
 D MES^XPDUTL(" Number of IENs removed:"_IVMNUM)
 Q
