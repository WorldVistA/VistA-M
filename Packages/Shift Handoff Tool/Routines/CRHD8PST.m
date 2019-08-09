CRHD8PST ; HIOFO/FT - FIX PARAMETER SETTINGS ; 5/10/19 2:29pm
 ;;1.0;CRHD;****;Jan 28, 2008;Build 14
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
 D EN^XPAR("SYS","CRHD GUI VERSION",1,"1.0.8.3",.CRHDERR)
 I +$G(CRHDERR) D
 . D BMES^XPDUTL("    "_CRHDERR)
 . D BMES^XPDUTL("   ....Parameter not added  ")
 ;
 D BMES^XPDUTL(" CRHD*1.0*8 Post Install complete")
 K CRHDERR
 ;
 Q
 ;
