MDPOST62 ;HPS/CW - Post Installation Tasks ; 2/12/19 4:17pm
 ;;1.0;CLINICAL PROCEDURES;**62**;Apr 01, 2004;Build 6
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
 ;Disable all old values of the parameters
 D GETLST^XPAR(.MDKLST,"SYS","MD VERSION CHK")
 F MDK=0:0 S MDK=$O(MDKLST(MDK)) Q:'MDK  D
 .I $P(MDKLST(MDK),":",1)="CPUSER.EXE" D EN^XPAR("SYS","MD VERSION CHK",$P(MDKLST(MDK),"^",1),0)
 N MDK,MDKLST
 D GETLST^XPAR(.MDKLST,"SYS","MD CRC VALUES")
 F MDK=0:0 S MDK=$O(MDKLST(MDK)) Q:'MDK  D
 .I $P(MDKLST(MDK),":",1)="CPUSER.EXE" D EN^XPAR("SYS","MD CRC VALUES",$P(MDKLST(MDK),"^",1),0)
 ; Update MD PARAMETERS with new build numbers for executables.  
 D EN^XPAR("SYS","MD VERSION CHK","CPUSER.EXE:1.0.62.0",1)
 D EN^XPAR("SYS","MD CRC VALUES","CPUSER.EXE:1.0.62.0","CCC3D1AB")
 ;
 K MDK,MDKLST
 D MES^XPDUTL(" MD*1.0*62 Post Init complete")
 ;
 Q
 ;
ROLLBACK ;Rollback code
 ;Rollback to previous versions
 N MDK,MDKLST
 ;Issue message rollback is taking place
 D MES^XPDUTL("Rolling back versions to the previous CP USER")
 ;Clean out all old values of the parameters
 D GETLST^XPAR(.MDKLST,"SYS","MD VERSION CHK")
 F MDK=0:0 S MDK=$O(MDKLST(MDK)) Q:'MDK  D
 .I $P(MDKLST(MDK),":",1)="CPUSER.EXE" D EN^XPAR("SYS","MD VERSION CHK",$P(MDKLST(MDK),"^",1),0)
 N MDK,MDLST
 D GETLST^XPAR(.MDKLST,"SYS","MD CRC VALUES")
 F MDK=0:0 S MDK=$O(MDKLST(MDK)) Q:'MDK  D
 .I $P(MDKLST(MDK),":",1)="CPUSER.EXE" D EN^XPAR("SYS","MD CRC VALUES",$P(MDKLST(MDK),"^",1),0)
 ; Now set back the parameter to the previous version
 D EN^XPAR("SYS","MD VERSION CHK","CPUSER.EXE:1.0.49.0",1)
 D EN^XPAR("SYS","MD CRC VALUES","CPUSER.EXE:1.0.49.0","948B05D2")
 ;
 K MDK,MDLST
 D MES^XPDUTL(" MD*1.0*62 Rollback complete")
 ;
 Q
