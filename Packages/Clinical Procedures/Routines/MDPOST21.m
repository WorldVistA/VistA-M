MDPOST21 ; HOIFO/NCA - Post Init ;2/7/07  16:15
 ;;1.0;CLINICAL PROCEDURES;**21**;Apr 01, 2004;Build 30
 ; Integration Agreements:
 ; IA#  2263 [Supported] XPAR routine calls. 
 ;      4677 [Subscription] XUSAP routine call
 ;     10060 [Supported] New Person file #200 Read w/Fileman
 ;     10141 [Supported] XPDUTL routine call
 ;
EN ; [Procedure] Setup Application PROXY 
 ; This submodule is called during the KIDS installation
 ; process.
 ;
 ; New private variables
 N MDFD,MDFMC,MDHERR,MDHLST,MDK,MDL,MDOPT,MDAPU S MDAPU="CLINICAL,DEVICE PROXY SERVICE"
 S MDOPT("MD GUI USER")=1,MDOPT("MD GUI MANAGER")=1,MDFMC=""
 S MDFD=$$FIND1^DIC(200,,"X",MDAPU,"B") Q:+MDFD
 S MDK=+$$CREATE^XUSAP(MDAPU,MDFMC,.MDOPT)
 I MDK>0 S MDTXT(1)="'"_MDAPU_"' has been created as an Application Proxy User."
 I MDK<0 S XPDABORT=1 D
 .S MDTXT(1)="The post-init routine has stopped.  The Application Proxy User"
 .S MDTXT(2)="was not created.  Make sure the name '"_MDAPU_"' is unique in"
 .S MDTXT(3)="the NEW PERSON file (#200).  The patch can not continue until"
 .S MDTXT(4)="the Application Proxy User can be created."
 D:$O(MDTXT(0)) BMES^XPDUTL(.MDTXT)
 Q:+$$PATCH^XPDUTL("MD*1.0*21")
 D GETLST^XPAR(.MDHLST,"SYS","MD GET HIGH VOLUME")
 I +$G(MDHLST) D NDEL^XPAR("SYS","MD GET HIGH VOLUME",.MDHERR)
 Q
