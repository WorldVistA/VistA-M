EC2P151 ;ALB/TXH - Inactive Stop Code DSS Unit Review; JUN 11, 2020@09:53
 ;;2.0;EVENT CAPTURE;**151**;May 8, 1996;Build 4
 ;
 ;This routine is part of a combined build with scheduling to 
 ;inactivate any DSS units that are set to send no records 
 ;and have an inactive/invalid stop code.
 ;
 Q
 ;
POST ;entry point
 N ZTRTN,ZTDTH,ZTDESC,ZTIO,ZTSK
 D BMES^XPDUTL("Queuing the inactivation of any DSS Units, that are set")
 D MES^XPDUTL("to send no records and have an inactive/invalid stop code,")
 D MES^XPDUTL("for 10/01/20 at 1:00 AM. If this patch is installed after that time")
 D MES^XPDUTL("the post-install will queue immediately.")
 ;
 S ZTRTN="CHKDSS^ECUTL3",ZTDTH=3201001.0100
 S ZTDESC="Inactivate DSS Units with invalid stop codes",ZTIO=""
 D ^%ZTLOAD
 ;
 D BMES^XPDUTL("Done. You will receive a MailMan message with the results on 10/01/20.")
 Q
