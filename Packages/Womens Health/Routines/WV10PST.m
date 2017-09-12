WV10PST ;HCIOFO/DS-Patch 10 Post-Installation Routine ;3/28/00  08:42
 ;;1.0;WOMEN'S HEALTH;**10**;Sep 30, 1998
 ;
 D QMAIL
 Q
 ;
QMAIL ; Queue mail message
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 S ZTRTN="MAIL^WV10PST",ZTDESC="WV*1*10 INSTALLED"
 S ZTIO="",ZTDTH=$H
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
 I '$O(XMY(0)) Q
SEND ; Create and send mail message
 S XMDUZ=.5 ;message sender
 S XMSUB="Women's Health patch #10 installed"
 S WVMSG(+$$LINE())="Patch #10 for the Women's Health package was installed. This patch adds"
 S WVMSG(+$$LINE())="additional site parameters for the Radiology/NM and Laboratory package links."
 S WVMSG(+$$LINE())="With these new parameters you can accept none, some or all non-veteran"
 S WVMSG(+$$LINE())="patient data from the Radiology/NM and Laboratory package links. To accept"
 S WVMSG(+$$LINE())="data for only certain non-veterans you must define the eligibility codes"
 S WVMSG(+$$LINE())="(e.g., TRICARE) you are interested in tracking."
 S WVMSG(+$$LINE())=" "
 S WVMSG(+$$LINE())="To set these new parameters, please do the following steps:"
 S WVMSG(+$$LINE())="1) Go to the File Maintenance Menu."
 S WVMSG(+$$LINE())="2) Select the Edit Site Parameters option."
 S WVMSG(+$$LINE())="3) Select a facility."
 S WVMSG(+$$LINE())="4) Go to page 2 of the data entry form."
 S WVMSG(+$$LINE())="5) If the 'Import Mammograms from Radiology:' value is NO or blank go to"
 S WVMSG(+$$LINE())="   Step 8."
 S WVMSG(+$$LINE())="6) Go to the first 'Include ALL Non-Veterans(Y/N)?:' prompt."
 S WVMSG(+$$LINE())="   a) Answer YES if you want all non-veteran data from Radiology/NM."
 S WVMSG(+$$LINE())="   b) Answer NO if you don't want any non-veteran data from Radiology/NM."
 S WVMSG(+$$LINE())="   c) Answer NO if you want only certain non-veterans."
 S WVMSG(+$$LINE())="   d) Leaving this answer blank is the same as YES."
 S WVMSG(+$$LINE())="If you opted for a, b or d, then skip to Step 8."
 S WVMSG(+$$LINE())="7) Go to the first 'ELIGIBILITY CODE(S):' prompt. This is a multiple answer"
 S WVMSG(+$$LINE())="   field."
 S WVMSG(+$$LINE())="   Enter each eligibility code you wish to accept data for from Radiology/NM."
 S WVMSG(+$$LINE())="8) If the 'Import Tests from Laboratory:' value is NO or blank go to Step 11."
 S WVMSG(+$$LINE())="9) Go to the second 'Include ALL Non-Veterans(Y/N)?:' prompt."
 S WVMSG(+$$LINE())="   a) Answer YES if you want all non-veteran data from Laboratory."
 S WVMSG(+$$LINE())="   b) Answer NO if you don't want any non-veteran data from Laboratory."
 S WVMSG(+$$LINE())="   c) Answer NO if you want only certain non-veterans."
 S WVMSG(+$$LINE())="   d) Leaving this answer blank is the same as YES."
 S WVMSG(+$$LINE())="If you opted for a, b or d, then skip to Step 11."
 S WVMSG(+$$LINE())="10) Go to the second 'ELIGIBILITY CODE(S):' prompt. This is a multiple answer"
 S WVMSG(+$$LINE())="    field."
 S WVMSG(+$$LINE())="   Enter each eligibility code you wish to accept data for from Laboratory."
 S WVMSG(+$$LINE())="11) Exit and Save any changes"
 S WVMSG(+$$LINE())=" "
 S WVMSG(+$$LINE())="Repeat steps 3-11 for each facility defined."
 S XMTEXT="WVMSG("
 D ^XMD
 Q
LINE() ; Increment line counter by 1
 S WVLINE=+$G(WVLINE)+1
 Q WVLINE
 ;
