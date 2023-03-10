CRHD10PI ; HIOFO/FT - FIX PARAMETER SETTINGS ; Nov 05, 2021@14:18:28
 ;;1.0;CRHD;**10**;Jan 28, 2008;Build 3
 Q
 ; This routine uses the following IAs:
 ;  #10141 - MES^XPDUTL    Kernel  (supported)
 ;  #2263  - EN^XPAR       Kernel  (supported)
 ;
 Q
EN ; main entry point  
 ;
 N CRHDERR
 S CRHDERR=""
 ; Installing commands in the command file...
 D MES^XPDUTL(" Post install starting....updating Parameters...")
 ;
 ; ADD CRHD GUI VERSION with new build numbers for executables.  
 D EN^XPAR("SYS","CRHD GUI VERSION",1,"1.0.10.2",.CRHDERR)
 I +$G(CRHDERR) D
 . D BMES^XPDUTL("    "_CRHDERR)
 . D BMES^XPDUTL("   ....Parameter not added  ")
 ;
 D BMES^XPDUTL(" CRHD*1.0*10 Post Install complete")
 K CRHDERR
 ;
 Q
 ;
