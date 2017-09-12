PRCH130 ;WISC/AS-post init patch 130 ;5/18/09  12:27
 ;;5.1;IFCAP;**130**;Oct 20, 2000;Build 25
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
INIT ;
 ; Populate values of password, and user name of the report production
 ; server By envoke EN^XPAR using methods detailed in IA #2263 
 ;
 N PRCP1,PRCP2,PRCP3
 S PRCP3=0                                  ; Error Flag
 I '$$PROD^XUPROD() S PRCP3=2 G EXIT        ; Quit if not production
 S PRCP1="2w5`WNj:c1"                       ; Encrypted password value
 D EN^XPAR("SYS","PRCPLO PASSWORD",1,PRCP1,.PRCP2)
 I PRCP2=0 D BMES^XPDUTL("PRCPLO PASSWORD successfully populated")
 I PRCP2'=0 S PRCP3=1 D BMES^XPDUTL("Error while trying to populate the PRCPLO PASSWORD:") D MES^XPDUTL($P(PRCP2,"^",2))
 S PRCP1="/?uK!26%Yh!"                      ; Encrypted user name value
 D EN^XPAR("SYS","PRCPLO USER NAME",1,PRCP1,.PRCP2)
 I PRCP2=0 D BMES^XPDUTL("PRCPLO USER NAME successfully populated")
 I PRCP2'=0 S PRCP3=1 D BMES^XPDUTL("Error while trying to populate the PRCPLO USER NAME:") D MES^XPDUTL($P(PRCP2,"^",2))
EXIT ;
 I PRCP3=0 D MES^XPDUTL("POST-INSTALL COMPLETED SUCCESSFULLY!")
 I PRCP3=1 D MES^XPDUTL("POST-INSTALL COMPLETED WITH ERRORS!!!")
 I PRCP3=2 N PRCMSG S PRCMSG(1)="As this is not a production system, username and password for the FTP Server",PRCMSG(2)="  were not filed." D MES^XPDUTL(.PRCMSG)
 Q
