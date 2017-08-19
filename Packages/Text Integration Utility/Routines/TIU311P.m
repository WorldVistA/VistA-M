TIU311P ;MNTVBB/RRA - Post Installation Tasks;02/01/17
 ;;1.0;TEXT INTEGRATION UTILITIES;**311**;Jun 20, 1997;Build 13
 ;;Per VA Directive 6402, this routine should not be modified..
 ;
 ; This routine uses the following IAs:
 ;  #10141       - MES^XPDUTL                   Kernel                         (supported)
 ;  #2263        - EN^XPAR                      Kernel                         (supported)
 ;
 Q
EN ; 
 ;
 N TIUERR
 S TIUERR=""
 ; Installing commands in the command file...
 D MES^XPDUTL(" Post install starting....updating Parameters...")
 ;
 ; ADD TIU MED GUI VERSION with new build numbers for executables.  
 D ADD^XPAR("SYS","TIU MED GUI VERSION",1,"2.3.311.6",.TIUERR)
 I +$G(TIUERR) D
 . D BMES^XPDUTL("    "_TIUERR)
 . D BMES^XPDUTL("   ....Parameter not added  ")
 ;
 D BMES^XPDUTL(" TIU*1.0*311 Post Install complete")
 ;
 Q
 ;
