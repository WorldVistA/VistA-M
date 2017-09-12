PX166P ; ISA/KWP - Update PCE Mapping File and Immunization file ;3/3/99
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**66**;AUG 12, 1996
 ;Post install routine for Patch PX*1.0*66
 I $$CONVERT^PXUACM(1,2) D BMES^XPDUTL("PCE Code Mapping and Immunization File Update Successful.") Q
 D BMES^XPDUTL("PCE Code Mapping and Immunization File Update FAILED.")
 Q
