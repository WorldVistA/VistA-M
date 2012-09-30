DG53644P ;BPFO/JRC - Home Telehealth Patient POST Install;10 January 2005 ; 4/8/08 10:02am
 ;;5.3;Registration;**644**;Aug 13, 1993;Build 11
 ;
EN ;Main entry point
 ;Init variables
 N VIEIP,LINK,DGARRAY,SITE,FLAG,RESPONSE
 S DGARRAY="^TMP(""DGHT"",$J,""IPARRAY"")"
 S SITE=+$P($$SITE^VASITE(),U,3),(LINK,RESPONSE)=0
 ;
 ;Setup ip address array
 D ARRAY
 ;
 ;Resolve ip address to use
 S VIEIP="",VIEIP=$O(@DGARRAY@(SITE,VIEIP))
 ;
 ;No ip address resolved, enter manually? if flag = 1 abort
 I VIEIP="" D ASKYN I 'RESPONSE D ERRMSG K @DGARRAY Q
 ;
 ;If response = 1, enter ip adress manually if flag = 1 abort
 I RESPONSE S VIEIP=0 D ASKIP I 'VIEIP D ERRMSG K @DGARRAY Q
 ;
 ;Order thru HL Logical Link file and retrieve IEN for 'DGHT' Link
 S LINK=$O(^HLCS(870,"B","DG HTH",LINK))
 ;
 ;If DG HTH logical link not found display message and quit
 I 'LINK K @DGARRAY D ERRMSG Q
 ;
 ;Update HL Logical Link file (#870)
 D BMES^XPDUTL("DG HTH Logical Link has been found ")
 D BMES^XPDUTL("Updating IP Address field (#400.01) ")
 I VIEIP D
 .;Prepare DIE filer call
 .N DGHFDA,DGHERR
 .S DGHFDA(870,LINK_",",400.01)=VIEIP
 .D FILE^DIE("EK","DGHFDA","DGHERR")
 .I $D(DGHERR) D ERRMSG Q
 .D BMES^XPDUTL("DG HTH Logical Link ip address updated successfully. ")
 D MENUS
 Q
 ;
ARRAY ;Set VIE IP Address Array
 ;Input  : DGARRAY - ip address array
 ;Output : VIE ip address array
 ;         @DGARRAY@(station,VieIpAddress) =  ""
 N OFF,TEXT,STATION,IP
 F OFF=1:1 S TEXT=$P($T(TABLE+OFF),";;",2) Q:TEXT="END"  D
 .S STATION=$P(TEXT,"^",1),IP=$P(TEXT,"^",2)
 .I STATION=""!(IP="") Q
 .S @DGARRAY@(STATION,IP)=""
 Q
 ;
ASKIP ;Prompt user for VIE IP address
 N DIR,DIRUT,X,Y
 S DIR(0)="F^^K:X'?1.3N1"".""1.3N1"".""1.3N1"".""1.3N X"
 S DIR("?",1)="Enter a valid IP address using the following format: nnn.nnn.nnn.nnn"
 S DIR("?")="Or '??' for a list of available station numbers & IP addresses."
 S DIR("??")="^D VIEHELP^DG53644P"
 S DIR("A")="Enter local VIE IP address"
 D ^DIR
 I $D(DIRUT) Q
 S VIEIP=Y
 Q
 ;
VIEHELP ;Help text listing Local VIE address"
 N OFF,TEXT,IP
 F OFF=1:1 S TEXT=$P($T(TABLE+OFF),";;",2) Q:TEXT="END"  D
 .S STATION=$P(TEXT,"^",1),IP=$P(TEXT,"^",2)
 .I STATION=""!(IP="") Q
 .W ?3,STATION,?12,IP,!
 Q
ASKYN ;Ask user if they want to enter IP address manually
 N DIR,DIRUT,X,Y
 S DIR(0)="Y"
 S DIR("A",1)="Unable to resolve VIE IP address."
 S DIR("A")="Would you like to enter it manually"
 D ^DIR
 I $D(DIRUT)!('Y) S FLAG=1 Q
 S RESPONSE=Y
 Q
 ;
ERRMSG ;Problem encountered updating IP address notify user
 D BMES^XPDUTL("DG HTH Logical Link's IP address was not updated. ")
 D MES^XPDUTL("See patch description for instructions on how ")
 D MES^XPDUTL("to update the IP address at a later time. ")
 Q
 ;
MENUS ;Place HTH menu options out of order
 N OPTION,MENU,TEXT
 ;Delete HTH main menu from registration options.
 S OPTION="DGHT HOME TELEHEALTH"
 F MENU="DG REGISTRATION MENU","DG SUPERVISOR MENU" D
 .D DELETE^XPDMENU(MENU,OPTION)
 D BMES^XPDUTL("Implementation of HTH requires OCC coordination/approval; hence the following")
 D BMES^XPDUTL("list of HTH menu options have been placed out of order by the installation.")
 S OPTION="",TEXT="Activation of option requires OCC approval."
 F OPTION="DGHT HOME TELEHEALTH","DGHT PATIENT SIGNUP","DGHT PATIENT INACTIVATION","DGHT SUMMARY REPORT","DGHT TRANSMISSION REPORT" D
 .D OUT^XPDMENU(OPTION,TEXT)
 .D BMES^XPDUTL("["_OPTION_"]")
 Q
TABLE ;VIE IP address array table syntax - station ^ vie ip
 ;;END
