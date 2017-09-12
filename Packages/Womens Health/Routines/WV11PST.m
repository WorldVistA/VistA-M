WV11PST ;HCIOFO/FT-Patch 11 Post-Installation Routine ;5/18/00  11:39
 ;;1.0;WOMEN'S HEALTH;**11**;Sep 30, 1998
 ;
 ; This routine uses the following IAs:
 ; #1157 - $$ADD^XPDMENU (supported)
 ;
 N WVADD
 D ADDOPT
 D QMAIL
 Q
ADDOPT ; Add/Update options on menus
 N WVFLAG,WVMENU,WVOPTION,WVORDER,WVSYN
 ; Add WV ADD TO MST option to WV MENU-FILE MAINTENANCE menu.
 S WVMENU="WV MENU-FILE MAINTENANCE"
 S WVOPTION="WV ADD TO MST",WVSYN="MST",WVORDER=13
 S WVFLAG=$$ADD^XPDMENU(WVMENU,WVOPTION,WVSYN,WVORDER)
 ; Enter DISPLAY ORDER for WV ADD/EDIT REFERRAL SOURCE option on
 ; WV MENU-FILE MAINTENANCE menu.
 S WVMENU="WV MENU-FILE MAINTENANCE"
 S WVOPTION="WV ADD/EDIT REFERRAL SOURCE",WVSYN="RS",WVORDER=12
 S WVFLAG=$$ADD^XPDMENU(WVMENU,WVOPTION,WVSYN,WVORDER)
 ; Enter DISPLAY ORDER for WV SEXUAL TRAUMA SUMMARY option on
 ; WV MENU-MANAGEMENT REPORTS menu.
 S WVMENU="WV MENU-MANAGEMENT REPORTS"
 S WVOPTION="WV SEXUAL TRAUMA SUMMARY",WVSYN="ST",WVORDER=6
 S WVFLAG=$$ADD^XPDMENU(WVMENU,WVOPTION,WVSYN,WVORDER)
 ; Add WV SEXUAL TRAUMA LIST to WV MENU-MANAGEMENT REPORTS menu.
 S WVMENU="WV MENU-MANAGEMENT REPORTS"
 S WVOPTION="WV SEXUAL TRAUMA LIST",WVSYN="LST",WVORDER=7
 S WVFLAG=$$ADD^XPDMENU(WVMENU,WVOPTION,WVSYN,WVORDER)
 ; Add DGMST ENTER NEW MST option to WV MENU-PATIENT MANAGEMENT menu.
 S WVMENU="WV MENU-PATIENT MANAGEMENT"
 S WVOPTION="DGMST ENTER NEW MST",WVSYN="MST",WVORDER=13
 S WVADD=$$ADD^XPDMENU(WVMENU,WVOPTION,WVSYN,WVORDER)
 Q
QMAIL ; Queue mail message
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 S ZTRTN="MAIL^WV11PST",ZTDESC="WV*1*11 INSTALLED"
 S ZTIO="",ZTDTH=$H,ZTSAVE("WVADD")=""
 D ^%ZTLOAD
 Q
MAIL ; Send message to default case managers to inform them of the changes
 N XMDUZ,XMSUB,XMTEXT,XMY,WVSITE,WVIEN,WVLINE,WVMSG
 I $D(ZTQUEUED) S ZTREQ="@"
 S (WVLINE,WVSITE)=0
 F  S WVSITE=$O(^WV(790.02,WVSITE)) Q:'WVSITE  D
 .S WVIEN=$P($G(^WV(790.02,WVSITE,0)),U,2) ;default case manager
 .Q:'WVIEN
 .S XMY(WVIEN)=""
 .Q
 ; Include patch installer if DG option not added to WH menu
 I $G(WVADD)=0 S XMY(DUZ)=""
 I '$O(XMY(0)) Q
SEND ; Create and send mail message
 S XMDUZ=.5 ;message sender
 S XMSUB="Women's Health patch #11 installed"
 S WVMSG(+$$LINE())="Patch #11 for the Women's Health (WH) package was installed. This patch"
 S WVMSG(+$$LINE())="makes the following changes:"
 S WVMSG(+$$LINE())=" "
 S WVMSG(+$$LINE())="1) Adds the 'MST Status Add/Edit' option to the Patient Management menu."
 S WVMSG(+$$LINE())="This is the same option used by the MST module of the Registration package."
 S WVMSG(+$$LINE())="This option allows the user to enter Military Sexual Trauma (MST) data"
 S WVMSG(+$$LINE())="directly into the MST module."
 S WVMSG(+$$LINE())=" "
 S WVMSG(+$$LINE())="2) Adds a new option, 'List Sexual Trauma Data', on the Management Reports"
 S WVMSG(+$$LINE())="menu. This option prints a list of WH patients, their WH Sexual Trauma"
 S WVMSG(+$$LINE())="value, and MST module value."
 S WVMSG(+$$LINE())=" "
 S WVMSG(+$$LINE())="3) Adds a new option, 'Add Sexual Trauma Data to MST Module' to the"
 S WVMSG(+$$LINE())="File Maintenance menu. This option will copy WH Sexual Trauma data into"
 S WVMSG(+$$LINE())="the MST module of the Registration package."
 I $G(WVADD)=0 D
 .S WVMSG(+$$LINE())=" "
 .S WVMSG(+$$LINE())="The 'MST Status Add/Edit' option could not be added to the Patient Management"
 .S WVMSG(+$$LINE())="menu. This mail message is being sent to the patch installer, too."
 .S WVMSG(+$$LINE())="Attention patch installer: Please contact National Vista Support and"
 .S WVMSG(+$$LINE())="report this problem. Thank you."
 .Q
 S XMTEXT="WVMSG("
 D ^XMD
 Q
LINE() ; Increment line counter by 1
 S WVLINE=+$G(WVLINE)+1
 Q WVLINE
 ;
