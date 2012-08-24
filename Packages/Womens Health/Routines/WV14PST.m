WV14PST ;HCIOFO/FT-WV*1*14 POST INSTALL/Transfer Sexual Trauma Data to DG MST Module ;4/4/01  11:41
 ;;1.0;WOMEN'S HEALTH;**14**;Sep 30, 1998
 ;
 ; This routine uses the following IAs:
 ; #1625 - $$GET^XUA4A72      (supported)
 ; #2716 - $$GETSTAT^DGMSTAPI (supported)
 ; #2716 - $$NEWSTAT^DGMSTAPI (supported)
 ; #1157 - $$DELETE^XPDMENU   (supported)
 ;
DESC ; Description of post install
 ; This post install converts the WH Sexual Trauma data (File 790,
 ; Field .27) into a Military Sexual Trauma (MST) value and a Civilian
 ; Sexual Trauma (CST) value. The MST value is then transferred to the
 ; Registration package. The CST value is stored in the Women's Health
 ; package. The MST module tracks data for veterans only. Data for
 ; non-veterans is not added to the MST module. WH patients whose Sexual
 ; Trauma value is 'Military', 'Civilian', 'Both' or 'None' will have
 ; that value translated into a MST value and added to the MST module.
 ;  WH value      MST value     CST value
 ;  --------      ---------     ---------
 ;  Military      Yes           No
 ;  Civilian      No            Yes
 ;  Both          Yes           Yes
 ;  None          No            No
 ;  <null>        no transfer   Unknown
 ;
 ; NOTE: If a WH patient is already in the MST module with a value of
 ; 'Yes' then no additional MST entry is made. Also, if a WH patient
 ; is already in the MST module with a value of 'No' and the WH Sexual
 ; Trauma value is 'None' or 'Civilian' then no additional MST entry
 ; is made.
 ; The provider who determined the value must be stored in the MST
 ; module. If the case manager associated with the patient or the user
 ; running this option is a provider, then the case manager or the user
 ; is identified as the provider who did the screening. If neither is
 ; a provider, then that patient's data is not added to the MST module.
 ; This option will display a list of WH patients whose data was added
 ; to the MST module. It will also display a list of WH patients whose
 ; data could not be added to the MST module. These lists are then sent
 ; to the case managers in a MailMan message.
 ;
EN ; Run in the background
 N WVMESAGE,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 S ZTRTN="Q^WV14PST",ZTDESC="WV*1*14 INSTALLED"
 S ZTIO="",ZTDTH=$H
 D ^%ZTLOAD
 S WVMESAGE="The post-installation will run as background job #"_$G(ZTSK)
 D MES^XPDUTL(WVMESAGE)
 Q
Q ; Entry point for the background job
 D REMOVE
 D START
 D DELETE
 D EXIT
 Q
EXIT ; Exit and clean up
 K ^TMP($J)
 K WVCST,WVDASHES,WVDATE,WVDFN,WVDGMST,WVDUZ,WVFLAG,WVLINE,WVMGR,WVMGRN
 K WVMGRO,WVMSG,WVNAME,WVNODE,WVPROV,WVREASON,WVSPACES,WVSSN,WVST
 K WVTITLEN,WVTITLEY,WVUSER,WVX
 K X,XMDUN,XMDUZ,XMSUB,XMTEXT,XMY,XMZ,Y
 Q
START ; Loop through FILE 790
 I $D(ZTQUEUED) S ZTREQ="@"
 K ^TMP($J)
 S WVDFN=0
 F  S WVDFN=$O(^WV(790,WVDFN)) Q:'WVDFN  D SET
 D EMAIL^WV14PST1 ;send email to case manager(s).
 Q
SET ; Set tmp global
 S WVNODE=$G(^WV(790,WVDFN,0)) Q:WVNODE=""
 S WVST=$P(WVNODE,U,27) ;WH sexual trauma value
 ; determine CST value
 S WVCST=$S(WVST="C":"Y",WVST="B":"Y",WVST="N":"N",WVST="M":"N",1:"U")
 S:$P(WVNODE,U,28)="" $P(^WV(790,WVDFN,0),U,28)=WVCST ;set CST value
 S $P(^WV(790,WVDFN,0),U,27)="" ;null out (new) MST field
 Q:WVST=""  ;no value to transfer to Registration
 Q:$$VET^WVUTL1A(WVDFN)'="Yes"  ;veterans only
 S WVMGR=$P(WVNODE,U,10) ;case manager ien
 I '$D(XMY(WVMGR)) S XMY(WVMGR)="" ;send message to these case mgrs
 ; $$GETSTAT^DGMSTAPI supported API - IA #2716
 S WVDGMST=$$GETSTAT^DGMSTAPI(WVDFN) ;get MST value from Registration
 Q:+WVDGMST=-1  ;couldn't retrieve MST status (i.e., DFN is null)
 S WVDGMST=$E($P(WVDGMST,U,2),1)
 Q:WVDGMST="Y"  ;MST already set to YES                                
 I WVST="N",WVDGMST="N" Q  ;both are NO, don't update MST
 I WVST="C",WVDGMST="N" Q  ;Civilian & No, don't update MST
 S WVDGMST=$$CONVERT(WVST)
 Q:WVDGMST=""  ;not an MST value                                        
 S WVMGRN=$$PERSON^WVUTL1(WVMGR) ;case manager name
 S WVPROV=$$PROVIDER(DUZ,WVMGR)
 S WVNAME=$$NAME^WVUTL1(WVDFN) ;patient name
 S WVSSN=$$SSN^WVUTL1(WVDFN) ;patient ssn
 S WVST=$S(WVST="M":"Military",WVST="C":"Civilian",WVST="B":"Both",WVST="N":"None",1:"<no value>")
 I WVPROV="" S ^TMP($J,"WVNO",WVMGRN,WVMGR,WVNAME,WVDFN)=WVST_U_U_U_WVSSN_U_"Determining Provider Unknown" Q
 ; $$NEWSTAT^DGMSTAPI supported API - IA 2716
 ; parameters(dfn,mst status,date/time,provider ien). A null d/t=NOW.
 S WVFLAG=$$NEWSTAT^DGMSTAPI(WVDFN,WVDGMST,"",WVPROV)
 ; +WVFLAG will be the ien of the MST entry, if successful
 I +WVFLAG=-1 S ^TMP($J,"WVNO",WVMGRN,WVMGR,WVNAME,WVDFN)=WVST_U_U_U_WVSSN_U_$P(WVFLAG,U,2) Q  ;no entry made in Registration
 S WVDGMST=$S(WVDGMST="Y":"Yes",WVDGMST="N":"No",WVDGMST="D":"Declined",WVDGMST="U":"Undefined",1:"<no value>")
 I WVPROV S WVPROV=$$PERSON^WVUTL1(WVPROV) ;get provider name
 I +WVFLAG S ^TMP($J,"WVYES",WVMGRN,WVMGR,WVNAME,WVDFN)=WVST_U_WVDGMST_U_WVPROV_U_WVSSN
 Q
CONVERT(WVST) ; Convert WH code to MST code
 ; Convert Military or Both to Yes.
 ;    "    Civilian or None to No.
 ; Ignore null.
 Q $S(WVST="M":"Y",WVST="C":"N",WVST="B":"Y",WVST="N":"N",1:"")
 ;
PROVIDER(WVDUZ,WVMGR) ; Determine provider.
 ; Try case manager first, then try user (i.e., DUZ). 
 ; $$GET^XUA4A72 supported API - IA #1625
 I WVMGR I +$$GET^XUA4A72(WVMGR)>0 Q WVMGR
 I WVDUZ I +$$GET^XUA4A72(WVDUZ)>0 Q WVDUZ
 Q ""
 ;
REMOVE ; Remove [WV ADD TO MST] option from File Maintenance Menu
 ; Remove [DGMST ENTER NEW MST] option from Patient Management menu
 N WVFLAG,WVMENU,WVOPTION
 S WVMENU="WV MENU-PATIENT MANAGEMENT"
 S WVOPTION="DGMST ENTER NEW MST"
 S WVFLAG=$$DELETE^XPDMENU(WVMENU,WVOPTION)
 Q
DELETE ; Delete the SEXUAL TRAUMA field (FILE 790, Field #.27)
 N DA,DIK
 S DIK="^DD(790,",DA=.27,DA(1)=790
 D ^DIK
 Q
