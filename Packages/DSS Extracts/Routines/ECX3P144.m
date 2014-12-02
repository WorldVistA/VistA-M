ECX3P144 ;ALB/DAN - DSS FY2014 Conversion, Post-init ;8/16/13  10:07
 ;;3.0;DSS EXTRACTS;**144**;Dec 22, 1997;Build 9
PRETRAN ;Loads gold 4 char codes into KIDS build
 M @XPDGREF@("ECX4CHAR")=^XTMP("ECX4CHAR")
 Q
 ;
POST ;Post-install items
 N UPDATE
 D TEST ;Set testing site information
 D CLEAN ;Delete values no longer needed
 D UPDATEDD("O") ;allow editing of fields during post install
 D LOADG4CH ;Load gold 4 char codes into XTMP
 I +$G(XPDQUIT) Q  ;abort installation if error loading gold codes
 D UPDCODES ;Compare gold codes to site change as needed
 D UPDATEDD("C") ;put restrictions back on file
 D MAIL ;send mail to holders of ECXMGR
 D MENU ;add new transmission menu option, update order and titles
 Q
 ;
TEST ;turn-on fld #73 in file #728 for Field Test Site;
 ;allows use of option ECX FISCAL YEAR EXTRACT by test sites;
 D MES^XPDUTL(" ")
 D MES^XPDUTL("Providing special menu option access for DSS FY Conversion test sites.")
 D TESTON^ECXTREX(XPDNM,"FY2014")
 D MES^XPDUTL(" ")
 ;if this is the national released version, then fld #73 will be turned-off
 ;the first time any user attempts to use ECX FISCAL YEAR EXTRACT option
 Q
 ;
CLEAN ;Delete dates from the last date clinic visits and last date clinic II fields
 ;Delete the CLINIC and CLINIC II fields so the "running" flag is removed
 N DIE,DA,IEN
 D BMES^XPDUTL("Clearing Last Date Clinic II and Last Date Clinic Visit fields.")
 D BMES^XPDUTL("Clearing CLINIC and CLINIC II fields.")
 S IEN=0 F  S IEN=$O(^ECX(728,IEN)) Q:'+IEN  D
 .S DIE="^ECX(728,",DA=IEN,DR="17///@;65///@;32///@;66///@"
 .D ^DIE
 D BMES^XPDUTL("Last Date Clinic II and Last Date Clinic Visit fields cleared.")
 D BMES^XPDUTL("CLINIC and CLINIC II fields cleared.")
 Q
 ;
LOADG4CH ;Put gold codes in local XTMP
 K ^XTMP("ECX4CHAR")
 M ^XTMP("ECX4CHAR")=@XPDGREF@("ECX4CHAR")
 I '$D(^XTMP("ECX4CHAR")) D BMES^XPDUTL("Gold code table not loaded - INSTALLATION ABORTED") S XPDQUIT=2 Q
 Q
 ;
UPDATEDD(TYPE) ;Update DD for 728.441 to either unrestrict edits or restrict edits
 N I
 I TYPE="C" D  ;restrict file
 .S ^DD(728.441,.01,7.5)="I $G(DIC(0))[""L"",'$D(ECX4CHAR) D EN^DDIOL(""Entries can only be added by CHAR4 Council."","""",""!?5"") K X"
 .F I=.01,1,3 I $P(^DD(728.441,I,0),U,2)'["I" S $P(^DD(728.441,I,0),U,2)=$P(^DD(728.441,I,0),U,2)_"I" ;Makes all fields uneditable
 I TYPE="O" D  ;remove restrictions
 .K ^DD(728.441,.01,7.5)
 .F I=.01,1,3 S $P(^DD(728.441,I,0),U,2)=$TR($P(^DD(728.441,I,0),U,2),"I","")
 Q
 ;
UPDCODES ;Compare gold to existing and edit as needed
 N GOLD,LINE,CODE,DIE,DA,DR,DIC,IEN,X,Y
 ;Check "gold" file against existing and add new entries or update differences
 S CODE=0 F  S CODE=$O(^XTMP("ECX4CHAR",CODE)) Q:CODE=""  D
 .S GOLD=^XTMP("ECX4CHAR",CODE)
 .I '$D(^ECX(728.441,"B",CODE)) D  Q  ;Entry not found in site file, add it
 ..S DIC=728.441,DIC(0)="LX",X=CODE,DIC("DR")="1////"_$P(GOLD,U) D ^DIC
 ..I Y=-1!('+$P(Y,U,3)) S UPDATE("NA",CODE)="" ;Entry failed to be added to system, will report in findings
 ..S UPDATE("N",CODE)=$P(GOLD,U) ;new entry added
 .I $D(^ECX(728.441,"B",CODE)) S IEN=$O(^ECX(728.441,"B",CODE,0)) S LINE=^ECX(728.441,IEN,0) D
 ..I $P(LINE,U,2)'=$P(GOLD,U) S $P(^ECX(728.441,IEN,0),U,2)=$P(GOLD,U) S UPDATE("U",CODE)=$P(LINE,U,2)_"^"_$P(GOLD,U) ;Update short description if it doesn't match
 ;Check for entries in local site that aren't in gold and inactivate
 S CODE="" F  S CODE=$O(^ECX(728.441,"B",CODE)) Q:CODE=""  D
 .I $D(^XTMP("ECX4CHAR",CODE)) Q  ;Code is in gold, no update needed
 .S IEN=$O(^ECX(728.441,"B",CODE,0)) Q:'+IEN  ;Can't get IEN for record
 .S DIE="^ECX(728.441,",DA=IEN,DR="3////"_$S(DT'<3131031:3131101,1:DT) D ^DIE
 .S UPDATE("I",CODE)="" ;Note inactivated entry
 Q
 ;
MAIL ;Send email with results to holders of the ECXMGR key
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ,CNT,DIFROM,ECXTEXT
 S XMDUZ="PATCH ECX*3*144 POST-INSTALL"
 D GETXMY("ECXMGR",.XMY)
 S ECXTEXT(1)="The update to the NATIONAL CLINIC file (#728.441), commonly referred to as",ECXTEXT(2)="the 4CHAR code, has completed.  Below are the results."
 S ECXTEXT(3)=""
 I '$D(UPDATE) S ECXTEXT(4)="No updates to your file were necessary.  No further action is required."
 S CNT=4 ;start with line 4 to add to message
 I $D(UPDATE("N")) D  S ECXTEXT(CNT)="",CNT=CNT+1 ;Report entries that were added
 .S ECXTEXT(CNT)="The following entries were added to your system:",CNT=CNT+1,ECXTEXT(CNT)=$$REPEAT^XLFSTR("-",79),CNT=CNT+1,ECXTEXT(CNT)="",CNT=CNT+1
 .S CODE="" F  S CODE=$O(UPDATE("N",CODE)) Q:CODE=""  S ECXTEXT(CNT)=CODE_" - "_UPDATE("N",CODE),CNT=CNT+1
 I $D(UPDATE("U")) D  S ECXTEXT(CNT)="",CNT=CNT+1 ;Report entries that were updated
 .S ECXTEXT(CNT)="The following entries had their short description updated:",CNT=CNT+1,ECXTEXT(CNT)=$$REPEAT^XLFSTR("-",79),CNT=CNT+1,ECXTEXT(CNT)="",CNT=CNT+1
 .S CODE="" F  S CODE=$O(UPDATE("U",CODE)) Q:CODE=""  S ECXTEXT(CNT)="CODE: "_CODE_" from "_$P(UPDATE("U",CODE),U)_" to "_$P(UPDATE("U",CODE),U,2) S CNT=CNT+1
 I $D(UPDATE("I")) D  S ECXTEXT(CNT)="",CNT=CNT+1 ;Report entries that were inactivated
 .S ECXTEXT(CNT)="The following entries were inactivated with a date of "_$$FMTE^XLFDT($S(DT'<3131031:3131101,1:DT))_" and will no",CNT=CNT+1,ECXTEXT(CNT)="longer be available for use after that date:",CNT=CNT+1
 .S ECXTEXT(CNT)=$$REPEAT^XLFSTR("-",79),CNT=CNT+1,ECXTEXT(CNT)="",CNT=CNT+1
 .S CODE="" F  S CODE=$O(UPDATE("I",CODE)) Q:CODE=""  S ECXTEXT(CNT)=CODE,CNT=CNT+1
 I $D(UPDATE("NA")) D  ;Report any codes that couldn't be added
 .S ECXTEXT(CNT)="The following entries could NOT be added to your system.  Please log a remedy",CNT=CNT+1,ECXTEXT(CNT)="ticket for assistance with adding these codes.",CNT=CNT+1
 .S ECXTEXT(CNT)=$$REPEAT^XLFSTR("-",79),CNT=CNT+1,ECXTEXT(CNT)="",CNT=CNT+1
 .S CODE="" F  S CODE=$O(UPDATE("NA",CODE)) Q:CODE=""  S ECXTEXT(CNT)=CODE
 S XMTEXT="ECXTEXT(",XMSUB="National Clinic file (#728.441) standardization"
 D ^XMD
 ;
GETXMY(KEY,XMY) ;Put holders of the KEY into the XMY array to be recipients of the email
 I $G(KEY)'="" M XMY=^XUSEC(KEY)
 S:$G(DUZ) XMY(DUZ)="" ;Make sure there's at least one recipient
 Q
MENU ;add new transmission menu option, update display order, add 1 title, remove display option setting for 1 option and move routine information from entry action to routine field for one option
 ;Add new option and update order of options for pharmacy maintenance menu
 N MENU,DA,CHECK,ECXMSG
 S MENU=""
 S ECXMSG(1)=" "
 S ECXMSG(2)="** Looking for PURGE DATA FROM EXTRACT FILES menu **"
 S ECXMSG(3)="     If found, title will be updated  "
 D MES^XPDUTL(.ECXMSG)
 ;Order thru option file and find ECXPURG and retrieve IEN
 S MENU=$O(^DIC(19,"B","ECXPURG",MENU))
 I 'MENU D BMES^XPDUTL("** ECXPURG item not found **")
 I MENU D
 .S DR="1///Purge Extract Holding Files",DIE="^DIC(19,",DA=MENU D ^DIE
 .K ECXMSG
 .S ECXMSG(1)=" "
 .S ECXMSG(2)="*** PURGE DATA FROM EXTRACT FILES menu has been updated.. ***"
 .D MES^XPDUTL(.ECXMSG)
 ;add new menu option to ECX TRANSMISSION
 S CHECK=$$ADD^XPDMENU("ECX TRANSMISSION","ECXDELEF","D")
 D BMES^XPDUTL("ECXDELEF option "_$S('+$G(CHECK):"NOT ",1:"")_"added to menu ECX TRANSMISSION")
 D BMES^XPDUTL("Updating ECX TRANSMISSION menu display order...")
 S DA=$$ADD^XPDMENU("ECX TRANSMISSION","ECX EXTRACT LOG REVIEW",,5)
 S DA=$$ADD^XPDMENU("ECX TRANSMISSION","ECXTRANS",,10)
 S DA=$$ADD^XPDMENU("ECX TRANSMISSION","ECX EXTRACT LOG SUMMARY",,15)
 S DA=$$ADD^XPDMENU("ECX TRANSMISSION","ECXDELEF",,20)
 S DA=$$ADD^XPDMENU("ECX TRANSMISSION","ECXPURG",,25)
 S DA=$$ADD^XPDMENU("ECX TRANSMISSION","ECXRXHF",,30)
 D MES^XPDUTL("Display order updated")
 D BMES^XPDUTL("Removing 'DISPLAY OPTION' setting from ECX CLN STOP REP option")
 S MENU=$O(^DIC(19,"B","ECX CLN STOP REP",0))
 I MENU S DR="11///@",DIE="^DIC(19,",DA=MENU D ^DIE
 D BMES^XPDUTL("Moving routine information from ENTRY ACTION to ROUTINE field") D MES^XPDUTL("for option ECX STOP CODE VALIDITY")
 S MENU=$O(^DIC(19,"B","ECX STOP CODE VALIDITY",0))
 I MENU S DR="20///@;25///EN^ECXSCX3" S DA=MENU,DIE="^DIC(19," D ^DIE
 D BMES^XPDUTL("Updating Pharmacy Maintenance Menu")
 S CHECK=$$ADD^XPDMENU("ECX PHARMACY MAINTENANCE","ECX PHA COST",3)
 D BMES^XPDUTL("ECX PHA COST option "_$S('+$G(CHECK):"NOT ",1:"")_"added to menu ECX PHARMACY MAINTENACE")
 S DA=$$ADD^XPDMENU("ECX PHARMACY MAINTENANCE","ECX PHA VOL",4)
 S DA=$$ADD^XPDMENU("ECX PHARMACY MAINTENANCE","ECX PHA UDP/IVP SOURCE AUDIT",5)
 D BMES^XPDUTL("Option order updated on the ECX PHARMACY MAINTENANCE menu")
 Q
