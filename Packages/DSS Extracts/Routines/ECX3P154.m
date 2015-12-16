ECX3P154 ;ALB/DAN - DSS FY2016 Conversion, Post-init ;5/19/15  15:32
 ;;3.0;DSS EXTRACTS;**154**;Dec 22, 1997;Build 13
 ;
POST ;Post-install items
 N UPDATE
 D TEST ;Set testing site information
 D FIXATS ;Change any action to send values from 3 or 7 to 5
 D AUDIT ;Clean up audit files
 D CHKDSS ;Look for DSS Units that don't have an associated stop code
 D MAIL ;Send email with results of DSS Unit check
 D MENU ;update menus
 Q
 ;
TEST ;turn-on fld #73 in file #728 for Field Test Site;
 ;allows use of option ECX FISCAL YEAR EXTRACT by test sites;
 D MES^XPDUTL(" ")
 D MES^XPDUTL("Providing special menu option access for DSS FY Conversion test sites.")
 D TESTON^ECXTREX(XPDNM,"FY2016")
 D MES^XPDUTL(" ")
 ;if this is the national released version, then fld #73 will be turned-off
 ;the first time any user attempts to use ECX FISCAL YEAR EXTRACT option
 Q
 ;
FIXATS ;Update action to send field in file 728.44 from 3 or 7 to 5, if found.
 N CIEN
 D BMES^XPDUTL("Checking ACTION TO SEND field in the CLINICS AND STOP CODES file...")
 S CIEN=0 F  S CIEN=$O(^ECX(728.44,CIEN)) Q:'+CIEN  I "^3^7^"[("^"_$P($G(^ECX(728.44,CIEN,0)),U,6)_"^") S $P(^ECX(728.44,CIEN,0),U,6)=5,$P(^ECX(728.44,CIEN,0),U,7)=""
 D MES^XPDUTL("Check complete!")
 Q
 ;
AUDIT ;Delete audit logs for select extract files
 N FILE
 D BMES^XPDUTL("Deleting audit logs for files 727.809, 727.81, and 727.819...")
 F FILE=727.809,727.81,727.819 K ^DIA(FILE)
 D MES^XPDUTL("Process complete!")
 Q
CHKDSS ;Check DSS Units and report any that don't have a stop code
 N UNIT,DSS0
 S UNIT=0 F  S UNIT=$O(^ECD(UNIT)) Q:'+UNIT  D
 .S DSS0=$G(^ECD(UNIT,0))
 .I $P(DSS0,U,6) Q  ;DSS Unit is inactive
 .I $P(DSS0,U,14)'="N" Q  ;only look at "send no records" units
 .I $P(DSS0,U,10)="" S UPDATE($P(DSS0,U),UNIT)="" ;DSS Unit doesn't have a stop code assigned
 Q
MAIL ;Send email with results to holders of the ECXMGR key
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ,CNT,DIFROM,ECXTEXT,NUM,NAME
 S XMDUZ="PATCH ECX*3*154 POST-INSTALL"
 D GETXMY("ECXMGR",.XMY)
 S ECXTEXT(1)="The check for active DSS Units with a 'Send no records' PCE setting",ECXTEXT(2)="and without an associated stop code has completed.  Below are the results."
 S ECXTEXT(3)=""
 I '$D(UPDATE) S ECXTEXT(4)="No DSS Units were identified.  No further action is required."
 S CNT=4 ;start with line 4 to add to message
 I $D(UPDATE) D
 .S ECXTEXT(CNT)="The following DSS Units do not have a stop code assigned:",CNT=CNT+1,ECXTEXT(CNT)="",CNT=CNT+1
 .S ECXTEXT(CNT)="NAME"_$$REPEAT^XLFSTR(" ",28)_"DSS IEN",CNT=CNT+1,ECXTEXT(CNT)="----"_$$REPEAT^XLFSTR(" ",28)_"-------",CNT=CNT+1
 .S NAME="" F  S NAME=$O(UPDATE(NAME)) Q:NAME=""  S NUM=0 F  S NUM=$O(UPDATE(NAME,NUM)) Q:'+NUM  S ECXTEXT(CNT)=NAME_$$REPEAT^XLFSTR(" ",(32-$L(NAME)))_NUM,CNT=CNT+1
 S XMTEXT="ECXTEXT(",XMSUB="DSS Unit stop code review"
 D ^XMD
 Q
 ;
GETXMY(KEY,XMY) ;Put holders of the KEY into the XMY array to be recipients of the email
 I $G(KEY)'="" M XMY=^XUSEC(KEY)
 S:$G(DUZ) XMY(DUZ)="" ;Make sure there's at least one recipient
 Q
 ;
MENU ;update menus
 N DA,DIE,DR,MENU,OPTION,CHECK,IEN
 D BMES^XPDUTL("Updating option ECX NATIONAL CLINIC...")
 S DA=$$LKOPT^XPDMENU("ECX NATIONAL CLINIC")
 I 'DA D MES^XPDUTL("Update failed - contact product support for assistance!")
 S DIE="^DIC(19,",DR="1///CHAR4 Codes List"
 D ^DIE
 D MES^XPDUTL("Update successful.")
 D BMES^XPDUTL("Updating option ECX CLN STOP REP...")
 S DA=$$LKOPT^XPDMENU("ECX CLN STOP REP")
 I 'DA D MES^XPDUTL("Update failed - contact product support for assistance!")
 S DIE="^DIC(19,",DR="1///Stop Code Non-Conforming Clinics Report"
 D ^DIE
 D MES^XPDUTL("Update successful.")
 D BMES^XPDUTL("Updating option ECXSCEDIT...")
 S DA=$$LKOPT^XPDMENU("ECXSCEDIT")
 I 'DA D MES^XPDUTL("Update failed - contact product support for assistance!")
 S DIE="^DIC(19,",DR="1///Enter/Edit Clinic Parameters"
 D ^DIE
 D MES^XPDUTL("Update successful.")
 D BMES^XPDUTL("Updating option ECX STOP CODE VALIDITY...")
 S DA=$$LKOPT^XPDMENU("ECX STOP CODE VALIDITY")
 I 'DA D MES^XPDUTL("Update failed - contact product support for assistance!")
 S DIE="^DIC(19,",DR="1///Clinic & Stop Codes Validity Report"
 D ^DIE
 D MES^XPDUTL("Update successful.")
 Q
