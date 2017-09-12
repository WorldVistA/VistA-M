PRCP166P ;WISC/AS-post init patch 166 ;1/30/12  12:27
 ;;5.1;IFCAP;**166**;Oct 20, 2000;Build 4
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;;
 Q
 ;;
INIT ;
 ; Populate values of IP and password of the report production
 ; server By invoke EN^XPAR using methods detailed in IA #2263 
 ;
 N PRCP1,PRCP2,PRCP3
 S PRCP3=0
SETV ;Set new values (2nd instance) for new server access
 ;
IP S PRCP1="Vhahinwbdbair.v12.domain.ext"                       ; valid IP address for new server
 D EN^XPAR("SYS","PRC CLRS ADDRESS",1,PRCP1,.PRCP2)
 I PRCP2=0 D BMES^XPDUTL("PRC CLRS ADDRESS successfully populated")
 I PRCP2'=0 S PRCP3=1 D BMES^XPDUTL("Error while trying to populate the PRC CLRS ADDRESS:") D MES^XPDUTL($P(PRCP2,"^",2))
 ;
PW S PRCP1="AdminCLRS$4"                       ; Encrypted password value
 S PRCP1=$$ENCRYP^XUSRB1(PRCP1)
 D EN^XPAR("SYS","PRCPLO PASSWORD",1,PRCP1,.PRCP2)
 I PRCP2=0 D BMES^XPDUTL("PRCPLO PASSWORD successfully populated")
 I PRCP2'=0 S PRCP3=1 D BMES^XPDUTL("Error while trying to populate the PRCPLO PASSWORD:") D MES^XPDUTL($P(PRCP2,"^",2))
 ;
EXIT ;
 I PRCP3=0 D BMES^XPDUTL("POST-INSTALL COMPLETED SUCCESSFULLY!")
 I PRCP3=1 D BMES^XPDUTL("POST-INSTALL COMPLETED WITH ERRORS!!!")
 Q
