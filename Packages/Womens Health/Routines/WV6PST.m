WV6PST ;HCIOFO/FT-Patch 6 Post-Installation Routine ;4/6/99  14:42
 ;;1.0;WOMEN'S HEALTH;**6**;Sep 30, 1998
 ;
EN ; Start post-install
 D QMAIL
 Q
QMAIL ; Queue mail message
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 S ZTRTN="MAIL^WV6PST",ZTDESC="WV*1*6 INSTALLED"
 S ZTIO="",ZTDTH=$H
 D ^%ZTLOAD
 Q
MAIL ; Send a message to Default Case Managers to answer new site
 ; parameter question for lab tests.
 N XMDUZ,XMSUB,XMTEXT,XMY,WVSITE,WVIEN
 S WVSITE=0
 F  S WVSITE=$O(^WV(790.02,WVSITE)) Q:'WVSITE  D
 .S WVIEN=$P($G(^WV(790.02,WVSITE,0)),U,2) ;default case manager
 .Q:'WVIEN
 .S XMY(WVIEN)=""
 .Q
 I '$O(XMY(0)) Q
SEND ; Create mail message and send
 S XMDUZ=.5 ;message sender
 S XMSUB="Women's Health patch #6 installed"
 S WVMSG(1)="Patch #6 for the Women's Health package was installed. This"
 S WVMSG(2)="patch provides a link with the Lab package to transfer lab data"
 S WVMSG(3)="to the Women's Health package. If you would like to activate this"
 S WVMSG(4)="link in the Women's Health package:"
 S WVMSG(5)=" "
 S WVMSG(6)="   Go to the: File Maintenance menu"
 S WVMSG(7)="  Select the: Edit Site Parameters option"
 S WVMSG(8)=" Select your: Site/Facility"
 S WVMSG(9)="Go to page 2:"
 S WVMSG(10)=" "
 S WVMSG(11)="Answer YES to the 'Import Tests from Laboratory' prompt"
 S WVMSG(12)=" "
 S WVMSG(13)="Exit and save your changes."
 S XMTEXT="WVMSG("
 D ^XMD
 Q
