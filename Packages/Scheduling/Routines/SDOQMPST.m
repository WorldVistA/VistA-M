SDOQMPST ;ALB/SCK - Performance Measure Post-Init ; 7/25/96
 ;;5.3;SCHEDULING;**47**;AUG 13,1993
 ;
START ;
 I 'XPDQUES("POST001") S XPDABORT=1 Q
 ;
 D BMES^XPDUTL("Beginning Post-Install")
 ;
 I '$$NEWCP^XPDUTL("POST_1","OPT1^SDOQMPST",0) D
 . D BMES^XPDUTL("Error creating checkpoint OPT1")
 ;
 I '$$NEWCP^XPDUTL("POST_2","OPT2^SDOQMPST",0) D
 . D BMES^XPDUTL("Error creating checkpoint OPT2")
 ;
 I '$$NEWCP^XPDUTL("POST_3","MAIL1^SDOQMPST",0) D
 . D BMES^XPDUTL("Error creating checkpoint MAIL1")
 ;
 I '$$NEWCP^XPDUTL("POST_4","NET^SDOQMPST",0) D
 . D BMES^XPDUTL("Error creating checkpoint for Domain Name")
QUIT Q
 ;
OPT1 ;
 N SDIEN,SDSIEN,SCERR,MSG,SDFLAG,DIFROM
 ;
 S SDIEN="",SDIEN=$O(^DIC(19,"B","SDOQM PM NIGHTLY JOB",SDIEN))
 I SDIEN']"" D  Q
 . S MSG(1)="Error: the SDOQM PM NIGHTLY JOB option was not loaded during the"
 . S MSG(2)="KIDs install.  This option will need to be created."
 . D MES^XPDUTL(.MSG) K MSG
 ;
 S (SDFLAG,SDSIEN)="",SDSIEN=$O(^DIC(19.2,"B",SDIEN,SDSIEN))
 S:SDSIEN']"" SDFLAG="L"
 ;
 I SDSIEN]"",+$P($G(^DIC(19.2,SDSIEN,0)),U,2)>0 S Y=$P(^(0),U,2) D  Q
 . D DD^%DT
 . D BMES^XPDUTL("The SDOQM PM NIGHTLY JOB is already scheduled for "_Y)
 ;
 D RESCH^XUTMOPT("SDOQM PM NIGHTLY JOB","","","1D",SDFLAG)
 S SDSIEN="",SDSIEN=$O(^DIC(19.2,"B",SDIEN,SDSIEN))
 I SDSIEN']"" D  Q
 . K MSG
 . S MSG(1)="The SDOQM PM NIGHTLY JOB scheduling option was not created."
 . S MSG(2)="You will need to create this entry in the OPTION SCHEDULING ile"
 . S MSG(3)="manually."
 . D MES^XPDUTL(.MSG)
 ;
 Q
 ;
OPT2 ;
 N SDIEN
 S SDIEN="",SDIEN=$O(^DIC(19,"B","SDOQM CLINIC NEXT AVAIL REPORT",SDIEN))
 I SDIEN']"" D
 . D BMES^XPDUTL("Error: the SDOQM CLINIC NEXT AVAIL REPORT option was not loaded")
 Q
 ;
MAIL1 ;
 N SDMIEN,DES,MSG,SDMAIL
 ;
 D BMES^XPDUTL("Creating local mail group for PM nightly job...")
 ;
 S SDMAIL="SD PM NOTIFICATION"
 S SDMIEN="",SDMIEN=$O(^XMB(3.8,"B",SDMAIL,SDMIEN))
 I SDMIEN']"" D  Q
 . S DES(0)="Mail group for local receipt of Performance Measure access extracts."
 . S X=$$MG^XMBGRP(SDMAIL,0,$S(+$G(DUZ)>0:DUZ,1:.5),0,"",.DES,1)
 . I 'X D  Q
 .. D BMES^XPDUTL("There was an error setting up the Mail group.")
 . S MSG(0)="The SD PM NOTIFICATION mail group has been created."
 . S MSG(1)="After this install is completed, you will need to add"
 . S MSG(2)="the appropriate members who need to receive the PM"
 . S MSG(3)="confirmation messages from the server."
 . D MES^XPDUTL(.MSG)
 ;
 I SDMIEN]"" D
 . D BMES^XPDUTL("Mail group already exists, please make sure appropriate members are added.")
 ;
 Q
NET ;
 N MSG
 ;
 I '$D(^XMB("NETNAME")) D  Q
 . S MSG(0)="The Domain Name for this server is not defined.  You will not"
 . S MSG(1)="be able to receive the PM confirmation messages from the data collection server."
 . S MSG(2)="Please contact your IRM staff for assistance."
 . D MES^XPDUTL(.MSG)
 ;
 D BMES^XPDUTL("Domain Name OK")
 Q
