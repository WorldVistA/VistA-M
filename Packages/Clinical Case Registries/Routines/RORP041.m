RORP041 ;ALB/FPT - CCR PRE/POST-INSTALL PATCH 41 ;5 JAN 2023  4:08 PM
 ;;1.5;CLINICAL CASE REGISTRIES;**41**;Feb 17, 2006;Build 1
 ;
 ;*****************************************************************************
 ;*****************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;  
 ;PKG/PATCH    DATE       DEVELOPER    MODIFICATION
 ;-----------  ---------  -----------  ----------------------------------------
 ;ROR*1.5*41   JAN 2023   F TRAXLER    Change NATIONAL (#.09) field value in
 ;                                     ROR REGISTRY PARAMETERS (#798.1) file 
 ;                                     for VA HEPC and VA HIV entries.          
 ;******************************************************************************
 ;******************************************************************************
 ; 
 ;SUPPORTED CALLS:
 ; BMES^XPDUTL   #10141
 ;
PRE ; --- Pre-Install routine for Patch 41
 N RORREG,REGIEN
 N RORPARM
 S RORPARM("DEVELOPER")=1
 D BMES^XPDUTL("Updating FILE 798.1, FIELD #.09")
 F RORREG="VA HEPC","VA HIV" D
 . S REGIEN=$$REGIEN^RORUTL02(RORREG)
 . I REGIEN'>0 D  Q
 . . D BMES^XPDUTL("Cannot find the "_RORREG_" entry in FILE #798.1.")
 . . D BMES^XPDUTL("Log a ticket.")
 . ;Change NATIONAL field value
 . K RORFDA,RORMSG
 . S RORFDA(798.1,REGIEN_",",.09)=0
 . D UPDATE^DIE(,"RORFDA",,"RORMSG")
 D BMES^XPDUTL("COMPLETED.")
 Q
