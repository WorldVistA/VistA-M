WV7PST ;HCIOFO/FT-Patch 7 Post-Installation Routine ;10/1/99  18:00
 ;;1.0;WOMEN'S HEALTH;**7**;Sep 30, 1998
 ;
EN ; Start post-install
 D XREF,RCODE,ZERO
 D QMAIL
 Q
XREF ; Index new cross-reference added to File 790.2 (CPT CODE - .08)
 N DIK
 S DIK="^WV(790.2,",DIK(1)=".08"
 D ENALL^DIK
 Q
RCODE ; Put R code in PACKAGE (#.05), File 790.2
 N DA,DIE,DR,WVLOOP
 F WVLOOP="BREAST ULTRASOUND","MAMMOGRAM DX BILAT","MAMMOGRAM DX UNILAT","MAMMOGRAM SCREENING","PELVIC ULTRASOUND","VAGINAL ULTRASOUND" D
 .S DA=$O(^WV(790.2,"B",WVLOOP,0))
 .Q:'DA
 .S DR=".05///"_"R",DIE="^WV(790.2,"
 .D ^DIE
 .Q
 Q
QMAIL ; Queue mail message
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 S ZTRTN="MAIL^WV7PST",ZTDESC="WV*1*7 INSTALLED"
 S ZTIO="",ZTDTH=$H
 D ^%ZTLOAD
 Q
MAIL ; Send message to Default Case Managers to 
 ; 1) enter parameters for new procedures
 ; 2) include |APPOINTMENTS| on form letters (if desired).
 N XMDUZ,XMSUB,XMTEXT,XMY,WVSITE,WVIEN,WVLINE,WVMSG
 S (WVLINE,WVSITE)=0
 F  S WVSITE=$O(^WV(790.02,WVSITE)) Q:'WVSITE  D
 .S WVIEN=$P($G(^WV(790.02,WVSITE,0)),U,2) ;default case manager
 .Q:'WVIEN
 .S XMY(WVIEN)=""
 .Q
 I '$O(XMY(0)) Q
SEND ; Create mail message and send
 S XMDUZ=.5 ;message sender
 S XMSUB="Women's Health patch #7 installed"
 S WVMSG(+$$LINE())="Patch #7 for the Women's Health package was installed. This patch adds 3"
 S WVMSG(+$$LINE())="new procedures for tracking. They are: Tubal Ligation, Pelvic Ultrasound"
 S WVMSG(+$$LINE())="and Vaginal Ultrasound. Please update your site parameters:"
 S WVMSG(+$$LINE())=" "
 S WVMSG(+$$LINE())="   Go to the: File Maintenance menu"
 S WVMSG(+$$LINE())="  Select the: Edit Site Parameters option"
 S WVMSG(+$$LINE())=" Select your: Site/Facility"
 S WVMSG(+$$LINE())="Go to pages 5 and 6"
 S WVMSG(+$$LINE())=" "
 S WVMSG(+$$LINE())="Enter YES in the 'Active' column and a numeric value in the 'DAYS DELINQUENT'"
 S WVMSG(+$$LINE())="column for each new procedure."
 S WVMSG(+$$LINE())=" "
 S WVMSG(+$$LINE())="Exit and save your changes."
 S WVMSG(+$$LINE())=" "
 S WVMSG(+$$LINE())="==================================================="
 S WVMSG(+$$LINE())=" "
 S WVMSG(+$$LINE())="Also, you can automatically have a patient's future appointments display in"
 S WVMSG(+$$LINE())="a notification letter. To do so:"
 S WVMSG(+$$LINE())=" "
 S WVMSG(+$$LINE())="   Go to the: File Maintenance menu"
 S WVMSG(+$$LINE())="  Select the: Add/Edit a Notification Purpose & Letter option"
 S WVMSG(+$$LINE())=" "
 S WVMSG(+$$LINE())="Select the notification letter which will display the future appointments."
 S WVMSG(+$$LINE())=" "
 S WVMSG(+$$LINE())="Answer NO to the 'Do you wish to delete the old letter for this Purpose of"
 S WVMSG(+$$LINE())="Notification and replace it with the generic sample letter?"
 S WVMSG(+$$LINE())="Enter Yes or No: NO//' prompt."
 S WVMSG(+$$LINE())=" "
 S WVMSG(+$$LINE())="Navigate to the FORM LETTER (WP) field."
 S WVMSG(+$$LINE())=" "
 S WVMSG(+$$LINE())="In the text of the letter type ""|APPOINTMENTS|"" (without the quotes) along"
 S WVMSG(+$$LINE())="with any other text that should appear in the letter."
 S WVMSG(+$$LINE())=" "
 S WVMSG(+$$LINE())="For example, create a new paragraph:"
 S WVMSG(+$$LINE())=" "
 S WVMSG(+$$LINE())="Your future appointments are:"
 S WVMSG(+$$LINE())="|APPOINTMENTS|"
 S WVMSG(+$$LINE())=" "
 S WVMSG(+$$LINE())=" "
 S XMTEXT="WVMSG("
 D ^XMD
 Q
LINE() ; Increment line counter by 1
 S WVLINE=+$G(WVLINE)+1
 Q WVLINE
 ;
ZERO ; Set Fields .77, .78 and .79 in File 790.71 entries to zero
 ; (pieces 28, 29 & 30 of node 2).
 N WVLOOP,WVNODE,WVX
 S WVLOOP=0
 F  S WVLOOP=$O(^WV(790.71,WVLOOP)) Q:'WVLOOP  D
 .S WVNODE=$G(^WV(790.71,WVLOOP,2))
 .Q:WVNODE=""
 .F WVX=28,29,30 S:$P(WVNODE,U,WVX)="" $P(WVNODE,U,WVX)=0
 .S ^WV(790.71,WVLOOP,2)=WVNODE
 .Q
 Q
