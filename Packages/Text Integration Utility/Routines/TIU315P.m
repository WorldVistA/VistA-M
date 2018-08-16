TIU315P ;HPS/CWB - Post Installation Tasks;MAR 3, 2017@3:47pm
 ;;1.0;TEXT INTEGRATION UTILITIES;**315**;Jun 20, 1997;Build 10
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
 D EN^XPAR("SYS","TIU MED GUI VERSION",1,"2.3.315.1")
 D BMES^XPDUTL(" TIU*1.0*315 Post Install complete")
 ;
 Q
 ;
