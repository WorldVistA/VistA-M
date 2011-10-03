WV14PST1 ;HCIOFO/FT-WV*1*14/Print Sexual Trauma Data Transfer to DG MST Module (cont.) ;4/3/01  16:11
 ;;1.0;WOMEN'S HEALTH;**14**;Sep 30, 1998
 ;
EMAIL ; Create report in mail message
 S WVDASHES=$$REPEAT^XLFSTR("-",79) ;line of dashes
 S WVSPACES=$$REPEAT^XLFSTR(" ",79) ;line of spaces
 S WVDATE=$$FMTE^XLFDT($$NOW^XLFDT(),"2") ;current date & time
 S WVUSER=$$PERSON^WVUTL1(DUZ) ;user's name
 D INTRO
 D HDRY
 I '$D(^TMP($J,"WVYES")) D NONEY
 I $D(^TMP($J,"WVYES")) D YES
 D HDRN
 I '$D(^TMP($J,"WVNO")) D NONEN
 I $D(^TMP($J,"WVNO")) D NO
 D SEND
 Q
HDRY ; header for entries added to MST
 S ^TMP($J,"WVMSG",+$$LINE())=" "
 S ^TMP($J,"WVMSG",+$$LINE())="Patient Data Added to MST Module"
 S ^TMP($J,"WVMSG",+$$LINE())="Report Run by: "_WVUSER
 S ^TMP($J,"WVMSG",+$$LINE())="     Run Date: "_WVDATE
 S ^TMP($J,"WVMSG",+$$LINE())=$$FILLER(55,0)_"DETERMINING"
 S WVX="  PATIENT"
 S WVX=WVX_$$FILLER(34,$L(WVX))_"WH VALUE"
 S WVX=WVX_$$FILLER(44,$L(WVX))_"MST VALUE"
 S WVX=WVX_$$FILLER(55,$L(WVX))_"PROVIDER"
 S ^TMP($J,"WVMSG",+$$LINE())=WVX
 S ^TMP($J,"WVMSG",+$$LINE())=WVDASHES
 Q
HDRN ; header for entries not added to MST
 S ^TMP($J,"WVMSG",+$$LINE())=" "
 S ^TMP($J,"WVMSG",+$$LINE())=" "
 S ^TMP($J,"WVMSG",+$$LINE())="Patient Data Not Added to MST Module"
 S ^TMP($J,"WVMSG",+$$LINE())="Report Run by: "_WVUSER
 S ^TMP($J,"WVMSG",+$$LINE())="     Run Date: "_WVDATE
 S ^TMP($J,"WVMSG",+$$LINE())=" "
 S WVX="  PATIENT"
 S WVX=WVX_$$FILLER(34,$L(WVX))_"WH VALUE"
 S WVX=WVX_$$FILLER(44,$L(WVX))_"REASON DATA NOT ADDED"
 S ^TMP($J,"WVMSG",+$$LINE())=WVX
 S ^TMP($J,"WVMSG",+$$LINE())=WVDASHES
 Q
NONEY ; no wh patient data was added to MST module
 S ^TMP($J,"WVMSG",+$$LINE())="<No Women's Health patient data was added to the MST module>"
 S ^TMP($J,"WVMSG",+$$LINE())="<of the Registration package.>"
 Q
NONEN ; no unsuccessful attempts to add MST data
 S ^TMP($J,"WVMSG",+$$LINE())="<All Women's Health patient data that could be added to the MST>"
 S ^TMP($J,"WVMSG",+$$LINE())="<module was added successfully.>"
 Q
YES ; List patient data successfully added to MST module
 S (WVMGRN,WVMGRO)=""
 F  S WVMGRN=$O(^TMP($J,"WVYES",WVMGRN)) Q:WVMGRN=""  S WVMGR=0 F  S WVMGR=$O(^TMP($J,"WVYES",WVMGRN,WVMGR)) Q:'WVMGR  D
 .I WVMGRN'=WVMGRO S ^TMP($J,"WVMSG",+$$LINE())="CASE MGR: "_WVMGRN S WVMGRO=WVMGRN ;identify cm
 .S WVNAME=""
 .F  S WVNAME=$O(^TMP($J,"WVYES",WVMGRN,WVMGR,WVNAME)) Q:WVNAME=""  S WVDFN=0 F  S WVDFN=$O(^TMP($J,"WVYES",WVMGRN,WVMGR,WVNAME,WVDFN)) Q:'WVDFN  D
 ..S WVNODE=^TMP($J,"WVYES",WVMGRN,WVMGR,WVNAME,WVDFN)
 ..S WVST=$P(WVNODE,U,1),WVDGMST=$P(WVNODE,U,2),WVPROV=$P(WVNODE,U,3)
 ..S WVSSN=$P(WVNODE,U,4)
 ..S WVX="  "_WVNAME
 ..S WVX=WVX_$$FILLER(34,$L(WVX))_WVST
 ..S WVX=WVX_$$FILLER(44,$L(WVX))_WVDGMST
 ..S WVX=WVX_$$FILLER(54,$L(WVX))_WVPROV
 ..S ^TMP($J,"WVMSG",+$$LINE())=WVX
 ..S ^TMP($J,"WVMSG",+$$LINE())="  ("_WVSSN_")"
 ..Q
 .Q
 Q
NO ; List patient data not added to MST module and reason it wasn't added
 S (WVMGRN,WVMGRO)=""
 F  S WVMGRN=$O(^TMP($J,"WVNO",WVMGRN)) Q:WVMGRN=""  S WVMGR=0 F  S WVMGR=$O(^TMP($J,"WVNO",WVMGRN,WVMGR)) Q:'WVMGR  D
 .I WVMGRN'=WVMGRO D
 ..S ^TMP($J,"WVMSG",+$$LINE())="CASE MGR: "_WVMGRN S WVMGRO=WVMGRN ;identify cm
 .S WVNAME=""
 .F  S WVNAME=$O(^TMP($J,"WVNO",WVMGRN,WVMGR,WVNAME)) Q:WVNAME=""  S WVDFN=0 F  S WVDFN=$O(^TMP($J,"WVNO",WVMGRN,WVMGR,WVNAME,WVDFN)) Q:'WVDFN  D
 ..S WVNODE=^TMP($J,"WVNO",WVMGRN,WVMGR,WVNAME,WVDFN)
 ..S WVST=$P(WVNODE,U,1),WVSSN=$P(WVNODE,U,4),WVREASON=$P(WVNODE,U,5)
 ..S WVX="  "_WVNAME
 ..S WVX=WVX_$$FILLER(34,$L(WVX))_WVST
 ..S WVX=WVX_$$FILLER(44,$L(WVX))_WVREASON
 ..S ^TMP($J,"WVMSG",+$$LINE())=WVX
 ..S ^TMP($J,"WVMSG",+$$LINE())="  ("_WVSSN_")"
 ..Q
 .Q
 Q
LINE() ; Increment line counter by 1
 S WVLINE=+$G(WVLINE)+1
 Q WVLINE
 ;
FILLER(L,S) ; Returns the number of spaces desired.
 ; L - larger number
 ; S - smaller number
 ; WVSPACES must be defined.
 I '$D(WVSPACES) Q ""
 Q $E(WVSPACES,1,L-S)
 ;
SEND ; Send mail message to case managers
 S XMDUZ=.5 ;message sender
 S XMSUB="Women's Health patch #14 installed"
 S XMTEXT="^TMP($J,""WVMSG"","
 D ^XMD
 Q
INTRO ; Set message introduction text
 S ^TMP($J,"WVMSG",+$$LINE())="Patch WV*1*14 for the Women's Health (WH) package was installed. This patch"
 S ^TMP($J,"WVMSG",+$$LINE())="modifies the way the WH package stores and retrieves Military Sexual Trauma"
 S ^TMP($J,"WVMSG",+$$LINE())="(MST) data. MST data that was stored in the WH package is now stored in the"
 S ^TMP($J,"WVMSG",+$$LINE())="Registration package. This message identifies WH patients whose MST data was"
 S ^TMP($J,"WVMSG",+$$LINE())="successfully added to the Registration package and those WH patients whose"
 S ^TMP($J,"WVMSG",+$$LINE())="MST data could not be added to the Registration package. If the patient's"
 S ^TMP($J,"WVMSG",+$$LINE())="WH sexual trauma status matched the MST status in the Registration package,"
 S ^TMP($J,"WVMSG",+$$LINE())="then no additional entry was made in the Registration package. MST data was"
 S ^TMP($J,"WVMSG",+$$LINE())="transferred to the Registration package for veterans only. All MST data"
 S ^TMP($J,"WVMSG",+$$LINE())="has been deleted from the WH package. Civilian Sexual Trauma (CST) data"
 S ^TMP($J,"WVMSG",+$$LINE())="continues to be stored in the WH package."
 S ^TMP($J,"WVMSG",+$$LINE())=" "
 S ^TMP($J,"WVMSG",+$$LINE())="To see what other changes were made to the WH reports and displays, please"
 S ^TMP($J,"WVMSG",+$$LINE())="contact your IRMS support person for the WH User Manual changes concerning"
 S ^TMP($J,"WVMSG",+$$LINE())="this patch."
 Q
