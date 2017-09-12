WV9PST ;HCIOFO/DS-Patch 9 Post-Installation Routine ;1/26/00  16:18
 ;;1.0;WOMEN'S HEALTH;**9**;Jan 10, 2000
 ; Routine converts multiple address lines in WV(790.404 & WV(790.6
 ; to a single COMPLETE ADDRESS entry
 D PROC(790.404)
 D PROC(790.6)
 D QMAIL
 Q
 ;
PROC(WVFILE) ; Replace mailing address placeholders with |COMPLETE ADDRESS|
 N WVNODE,WVSUB1,WVSUB2,WVX
 S WVSUB1=0
 F  S WVSUB1=$O(^WV(WVFILE,WVSUB1)) Q:'WVSUB1  D
 . S WVSUB2=0
 . F  S WVSUB2=$O(^WV(WVFILE,WVSUB1,1,WVSUB2)) Q:'WVSUB2  D
 . . S WVNODE=$G(^WV(WVFILE,WVSUB1,1,WVSUB2,0))
 . . Q:WVNODE=""
 . . I WVNODE["|MAILING ADDRESS-STREET|" D
 . . . S WVX=$F(WVNODE,"|"),WVX=WVX-2
 . . . S ^WV(WVFILE,WVSUB1,1,WVSUB2,0)=$$REPEAT^XLFSTR(" ",WVX)_"|COMPLETE ADDRESS|"
 . . . I $G(^WV(WVFILE,WVSUB1,1,(WVSUB2+1),0))["|MAILING ADDRESS-CITY|" D
 . . . . S ^WV(WVFILE,WVSUB1,1,(WVSUB2+1),0)=" "
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q
QMAIL ; Queue mail message
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 S ZTRTN="MAIL^WV9PST",ZTDESC="WV*1*9 INSTALLED"
 S ZTIO="",ZTDTH=$H
 D ^%ZTLOAD
 Q
MAIL ; Send message to default case managers to inform them of the changes
 ; made to the address placeholders of the form letters (790.404 & 790.6)
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
 S XMSUB="Women's Health patch #9 installed"
 S WVMSG(+$$LINE())="Patch #9 for the Women's Health package was installed. This patch changes"
 S WVMSG(+$$LINE())="the '|placeholder|' text used in the notification form letter templates to"
 S WVMSG(+$$LINE())="determine the patient's mailing address. Specifically, it replaces:"
 S WVMSG(+$$LINE())=" "
 S WVMSG(+$$LINE())="|MAILING ADDRESS-STREET|"
 S WVMSG(+$$LINE())="|MAILING ADDRESS-CITY|, |MAILING ADDRESS-STATE| |MAILING ADDRESS-ZIP|"
 S WVMSG(+$$LINE())=" "
 S WVMSG(+$$LINE())="with |COMPLETE ADDRESS|."
 S WVMSG(+$$LINE())=" "
 S WVMSG(+$$LINE())="This change will allow the form letter to print mailing addresses that"
 S WVMSG(+$$LINE())="have more than one line for the street address portion."
 S WVMSG(+$$LINE())=" "
 S WVMSG(+$$LINE())="Recommendation: Run the 'Print Notification Purpose & Letter File'"
 S WVMSG(+$$LINE())="                option on the Maintenance Menu."
 S WVMSG(+$$LINE())="                Send the output to a printer."
 S WVMSG(+$$LINE())="                Review the name and address portion of the form letter"
 S WVMSG(+$$LINE())=" "
 S WVMSG(+$$LINE())="The name and address portion should appear as:"
 S WVMSG(+$$LINE())=" "
 S WVMSG(+$$LINE())="|$P(NAME,"","",2)| |$P(NAME,"","")|"
 S WVMSG(+$$LINE())="|COMPLETE ADDRESS|"
 S WVMSG(+$$LINE())=" "
 S WVMSG(+$$LINE())="If not, use the 'Add/Edit a Notification Purpose & Letter option on the"
 S WVMSG(+$$LINE())="Maintenance Menu to edit the form letter text."
 S WVMSG(+$$LINE())=" "
 S WVMSG(+$$LINE())=" "
 S WVMSG(+$$LINE())="Also, the generic form letter template used to create new form letters"
 S WVMSG(+$$LINE())="was modified to use the |COMPLETE ADDRESS| placeholder to generate the"
 S WVMSG(+$$LINE())="patient's mailing address."
 S XMTEXT="WVMSG("
 D ^XMD
 Q
LINE() ; Increment line counter by 1
 S WVLINE=+$G(WVLINE)+1
 Q WVLINE
 ;
