TIU374P ;SLC/TP - Post Installation Tasks ;Aug 13, 2025@10:50:12
 ;;1.0;TEXT INTEGRATION UTILITIES;**374**;Jun 20, 1997;Build 11
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
 D EN^XPAR("SYS","TIU MED GUI VERSION",1,"2.3.374.4",.TIUERR)
 I TIUERR=0 D BMES^XPDUTL(" TIU*1.0*374 Post Install complete") Q
 D BMES^XPDUTL("Error: "_$P(TIUERR,U,2))
 ;
 Q
