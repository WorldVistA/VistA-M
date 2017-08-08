MDPOST49 ;MNTVBB/RRA - Post Installation Tasks;01/07/17
 ;;1.0;CLINICAL PROCEDURES;**49**;Apr 01, 2004;Build 2
 ;;Per VA Directive 6402, this routine should not be modified..
 ;
 ; This routine uses the following IAs:
 ; IA# 10141  MES^XPDUTL      Kernel
 ; IA# 2263 [Supported] XPAR Utilities
 ;
 Q
EN ; Post installation tasks to bring Legacy CP up to snuff
 ;
 N MDK,MDKLST
 ; Installing commands in the command file...
 D MES^XPDUTL(" Post install starting....updating Parameters...")
 ;
 ; Update MD PARAMETERS with new build numbers for executables.  
 D EN^XPAR("SYS","MD VERSION CHK","CPUSER.EXE:1.0.49.0",1)
 D EN^XPAR("SYS","MD CRC VALUES","CPUSER.EXE:1.0.49.0","948B05D2")
 ;
 D MES^XPDUTL(" MD*1.0*49 Post Init complete")
 ;
 Q
 ;
