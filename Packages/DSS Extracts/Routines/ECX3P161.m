ECX3P161 ;ALB/DAN - DSS FY2017 Conversion, Post-init ;5/2/16  13:05
 ;;3.0;DSS EXTRACTS;**161**;Dec 22, 1997;Build 6
 ;
POST ;Post-install items
 N UPDATE
 D TEST ;Set testing site information
 D FIXATS ;Change any action to send values from 1 to 5
 D CHKDSS ;Look for DSS Units that don't have an associated stop code
 D MAIL ;Send email with results of DSS Unit check
 D MENU ;update menus
 Q
 ;
TEST ;turn-on fld #73 in file #728 for Field Test Site;
 ;allows use of option ECX FISCAL YEAR EXTRACT by test sites;
 D MES^XPDUTL(" ")
 D MES^XPDUTL("Providing special menu option access for DSS FY Conversion test sites.")
 D TESTON^ECXTREX(XPDNM,"FY2017")
 D MES^XPDUTL(" ")
 ;if this is the national released version, then fld #73 will be turned-off
 ;the first time any user attempts to use ECX FISCAL YEAR EXTRACT option
 Q
 ;
FIXATS ;Update action to send field in file 728.44 from 1 to 5, if found.
 N CIEN
 D BMES^XPDUTL("Checking ACTION TO SEND field in the CLINICS AND STOP CODES file...")
 S CIEN=0 F  S CIEN=$O(^ECX(728.44,CIEN)) Q:'+CIEN  I $P($G(^ECX(728.44,CIEN,0)),U,6)=1 S $P(^ECX(728.44,CIEN,0),U,6)=5,$P(^ECX(728.44,CIEN,0),U,7)=""
 D MES^XPDUTL("Check complete!")
 Q
 ;
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
 S XMDUZ="PATCH ECX*3*161 POST-INSTALL"
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
 S OPTION="ECX CLN STOP REP",MENU="ECX SETUP CLINIC"
 S CHECK=$$DELETE^XPDMENU(MENU,OPTION)
 D BMES^XPDUTL(">>> "_OPTION_" OPTION "_$S(CHECK:"REMOVED FROM ",1:"DOES NOT EXIST IN ")_MENU_" <<<")
 D OUT^XPDMENU(OPTION,"OUT OF ORDER, DO NOT USE THIS OPTION!!!")
 D BMES^XPDUTL(">>> "_OPTION_" OPTION PLACED OUT ORDER <<<")
 Q
