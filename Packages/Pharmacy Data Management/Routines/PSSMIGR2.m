PSSMIGR2 ;AJF - Receives and Process XML message from PEPS; 2/27/2012 1713
 ;;1.0;PHARMACY ENTERPRISE PRODUCT SYSTEM;;;Build 35
 ;;
 ; Called from PSSMIGR1
 ; Continue process migration request
 ;;
 ;
DSFO(IEN,RCNT,TYPE) ; Process Migration for DOSAGE FORM
 ;
 ;
 N CNT,XST,EFDC,IND,MIEN,NAME,PACK,PREP,PS0,PSM,PST0,VERB
 N UNAME,UNIT,XEFDC,XIEN,XIEN1,XPACK,XTYPE,XUNIT,XND,XNAME,XIND
 K ^TMP($J,50.606)
 S CNT=0,^TMP($J,50.606,"EOF")=0,XST=0
 S FNAME="drugMigrationResponse_DosageForm.XML",FNUM=50.606
 S FNAME1="dosageForm"
 I IEN<0 D OUT^PSSMIGR(" Error... Invalid IEN") Q
 I RCNT<1 D OUT^PSSMIGR(" Error... Invalid Starting Record Number") Q
 I TYPE>1!(TYPE<0) D OUT^PSSMIGR(" Error... Invalid TYPE") Q
 F  S IEN=$O(^PS(50.606,IEN)) D  Q:XST=1
 .I +IEN=0 S ^TMP($J,50.606,"EOF")=1,XST=1 Q
 .I RCNT=CNT S XST=1 Q
 .S PS0=^PS(50.606,IEN,0)
 .S NAME=$P(PS0,"^"),IND=$P(PS0,"^",2)
 .S XTYPE=$S(+IND:0,1:1)
 .;Q:XTYPE'=TYPE
 .S:+IND IND=$$FMTHL7^XLFDT(IND)
 .S PSM=$G(^PS(50.606,IEN,"MISC")),EFDC=$P($G(^PS(50.606,IEN,1)),"^")
 .S VERB=$P(PSM,"^"),PREP=$P(PSM,"^",3)
 .S XIEN="<dosageFormIen>"_IEN_"</dosageFormIen>"
 .S XNAME=$S(NAME="":"",1:"<name>"_NAME_"</name>")
 .S XIND=$S(IND="":"",1:"<inactivationDate>"_IND_"</inactivationDate>")
 .S XEFDC=$S(EFDC="":"",1:"<excludeFromDosageChecks>"_EFDC_"</excludeFromDosageChecks>")
 .;
 .S ^TMP($J,50.606,XTYPE,IEN)=XIEN_XNAME_XIND
 .S ^TMP($J,50.606,XTYPE,IEN,999999)=XEFDC
 .;
 .;
 .;Unit Multiple
 .I $D(^PS(50.606,IEN,"UNIT",0)) D
 ..S MIEN=0
 ..F  S MIEN=$O(^PS(50.606,IEN,"UNIT",MIEN)) Q:MIEN="B"!(MIEN="")  D
 ...S PST0=^PS(50.606,IEN,"UNIT",MIEN,0)
 ...S UNIT=$P(PST0,"^"),PACK=$P(PST0,"^",2)
 ...S:+UNIT UNAME=$P($G(^PS(50.607,UNIT,0)),"^")
 ...S XIEN1="<unitsIen>"_MIEN_"</unitsIen>"
 ...S XUNIT=$S(UNIT="":"",1:"<units>"_UNAME_"</units>")
 ...S XPACK=$S(PACK="":"",1:"<package>"_PACK_"</package>")
 ...S ^TMP($J,50.606,XTYPE,IEN,91_MIEN)="<units>"_XIEN1_XUNIT_XPACK_"</units>"
 .;
 .;Dispense Unit PER Dose Multiple
 .I $D(^PS(50.606,IEN,"DUPD",0)) D
 ..S MIEN=0
 ..F  S MIEN=$O(^PS(50.606,IEN,"DUPD",MIEN)) Q:MIEN="B"!(MIEN="")  D
 ...S PST0=^PS(50.606,IEN,"DUPD",MIEN,0)
 ...S UNIT=$P(PST0,"^"),PACK=$P(PST0,"^",2)
 ...S XIEN1="<dispenseUnitsPerDoseIen>"_MIEN_"</dispenseUnitsPerDoseIen>"
 ...S XUNIT=$S(UNIT="":"",1:"<dispenseUnitsPerDose>"_UNIT_"</dispenseUnitsPerDose>")
 ...S XPACK=$S(PACK="":"",1:"<package>"_PACK_"</package>")
 ...S ^TMP($J,50.606,XTYPE,IEN,999_MIEN)="<dispenseUnitsPerDose>"_XIEN1_XUNIT_XPACK_"</dispenseUnitsPerDose>"
 .S:XTYPE=TYPE CNT=CNT+1
 Q
 ;
VAPD(IEN,RCNT,TYPE) ; Process Migration for VA Product
 ;
 ;
 N CNT,ACTI,CPD,CSFS,CODE1,CLASS1,DOS,DOSF,EDCK,FMG,INAD,MIEN,MVUID,NAFI,NAFN,NAME,OVCK,XACTI,XCLASS1,XCODE1,XDOSF,XSVC,XTYPE,XUNTS,XVAPI,SVDC
 N PDTC,PP,PS0,PS01,PS1,PS7,PST0,PVDC,SMSP,STA,STRG,STRN,SVC,TRTC,UNIT,UNTS,VADU,VAGN,VAPI,VAPN,VUID,XCPD,XCSFS,XSTRN,XTMP,XUNIT,XVAGN,GCNS
 N XEDCK,XEDT,XFMG,XGCNS,XIEN,XIEN1,XINAD,XMIEN,XML,XML2,XML3,XMVUID,XNAFI,XNAFN,XOVCK,XPDTC,XPP,XPVDC,XSMSP,XSTA,XSTRG,XTRTC,XVADU,XVAPN,XVUID
 N MADD,MACD,MIDD,MASD,MISD,NSFR,NLTG,PREG,NAFR,EDT,XNNAME
 K ^TMP($J,50.68)
 S CNT=0,^TMP($J,50.68,"EOF")=0
 S FNAME="drugMigrationResponse_VAProduct.XML",FNUM=50.68
 S FNAME1="vaProduct"
 I IEN<0 D OUT^PSSMIGR(" Error... Invalid IEN") Q
 I RCNT<1 D OUT^PSSMIGR(" Error... Invalid Starting Record Number") Q
 I TYPE>1!(TYPE<0) D OUT^PSSMIGR(" Error... Invalid TYPE") Q
 F  S IEN=$O(^PSNDF(50.68,IEN)) D  Q:XST=1
 .I +IEN=0 S ^TMP($J,50.68,"EOF")=1,XST=1 Q
 .I RCNT=CNT S XST=1 Q
 .Q:'$D(^PSNDF(50.68,IEN,0))
 .S PS0=^PSNDF(50.68,IEN,0)
 .S NAME=$P(PS0,"^"),VAGN=$P(PS0,"^",2),DOSF=$P(PS0,"^",3),STRG=$P(PS0,"^",4),NAFN=$P(PS0,"^",6)
 .S UNIT=$P(PS0,"^",5) S:+UNIT UNIT=$P($G(^PS(50.607,UNIT,0)),"^",1)
 .S:VAGN]"" VAGN=$P($G(^PSNDF(50.6,VAGN,0)),"^")
 .S:DOSF]"" DOSF=$P($G(^PS(50.606,DOSF,0)),"^")
 .S PS1=$G(^PSNDF(50.68,IEN,1))
 .S VAPN=$P(PS1,"^"),VAPI=$P(PS1,"^",2),TRTC=$P(PS1,"^",3),VADU=$P(PS1,"^",4),GCNS=$P(PS1,"^",5),PREG=$P(PS1,"^",6),NLTG=$P(PS1,"^",7)
 .S VADU=$P($G(^PSNDF(50.64,+VADU,0)),"^")
 .S PVDC=$P($G(^PSNDF(50.68,IEN,3)),"^"),OVCK=$P($G(^PSNDF(50.68,IEN,9)),"^",1)
 .S EDCK=$P($G(^PSNDF(50.68,IEN,8)),"^")
 .;Drug class row
 .I +PVDC,$D(^PS(50.605,PVDC,0)) D
 ..S PS01=^PS(50.605,PVDC,0)
 ..S CODE1=$P(PS01,"^"),CLASS1=$P(PS01,"^",2)
 ..S XIEN1="<vaDrugClassIen>"_PVDC_"</vaDrugClassIen>"
 ..S XCODE1=$S(CODE1="":"",1:"<code>"_CODE1_"</code>")
 ..S XCLASS1=$S(CLASS1="":"",1:"<classification>"_CLASS1_"</classification>")
 ..S XTMP=XIEN1_XCODE1_XCLASS1
 .;
 .S SVDC=$P($G(^PSNDF(50.68,IEN,4,0)),"^")
 .S NAFI=$P($G(^PSNDF(50.68,IEN,5)),"^")
 .S NAFR=$P($G(^PSNDF(50.68,IEN,6,0)),"^")
 .S PS7=$G(^PSNDF(50.68,IEN,7))
 .S CSFS=$P(PS7,"^"),SMSP=$P(PS7,"^",2),INAD=$P(PS7,"^",3),MASD=$P(PS7,"^",4),MISD=$P(PS7,"^",5)
 .S MADD=$P(PS7,"^",6),MIDD=$P(PS7,"^",7),MACD=$P(PS7,"^",8)
 .S XTYPE=$S(+INAD:0,1:1)
 .S:+INAD INAD=$$FMTHL7^XLFDT(INAD)
 .S VUID=$P($G(^PSNDF(50.68,IEN,"VUID")),"^"),MVUID=$P($G(^PSNDF(50.68,IEN,"VUID")),"^",2)
 .S DOS=$G(^PSNDF(50.68,IEN,"DOS"))
 .S CPD=$P(DOS,"^"),PDTC=$P(DOS,"^",2),PP=$P(DOS,"^",3)
 .S FMG=$P($G(^PSNDF(50.68,IEN,"MG")),"^")
 .S SVC=$P($G(^PSNDF(50.68,IEN,"PFS")),"^")
 .;
 .S XIEN="<ndfProductIen>"_IEN_"</ndfProductIen>"
 .S XNAME=$S(NAME="":"",1:"<name><![CDATA["_NAME_"]]></name>")
 .S XVAGN=$S(VAGN="":"",1:"<vaGenericName><![CDATA["_VAGN_"]]></vaGenericName>")
 .S XDOSF=$S(DOSF="":"",1:"<dosageForm>"_DOSF_"</dosageForm>")
 .S XSTRG=$S(STRG="":"",1:"<strength><![CDATA["_STRG_"]]></strength>")
 .s XUNIT=$s(UNIT="":"",1:"<units>"_UNIT_"</units>")
 .S XNAFN=$S(NAFN="":"",1:"<nationalFormularyName><![CDATA["_NAFN_"]]></nationalFormularyName>")
 .S XVAPN=$S(VAPN="":"",1:"<vaPrintName><![CDATA["_VAPN_"]]></vaPrintName>")
 .S XVAPI=$S(VAPI="":"",1:"<vaProductIdentifier>"_VAPI_"</vaProductIdentifier>")
 .S XTRTC=$S(TRTC="":"",1:"<transmitToCmop>"_TRTC_"</transmitToCmop>")
 .S XVADU=$S(VADU="":"",1:"<vaDispenseUnit>"_VADU_"</vaDispenseUnit>")
 .S XGCNS=$S(GCNS="":"",1:"<gcnSeqNo>"_GCNS_"</gcnSeqNo>")
 .;
 .S XPVDC=$S(PVDC="":"",1:"<primaryVaDrugClass>"_XTMP_"</primaryVaDrugClass>")
 .S XNAFI=$S(NAFI="":"",1:"<nationalFormularyIndicator>"_NAFI_"</nationalFormularyIndicator>")
 .S XCSFS=$S(CSFS="":"",1:"<csFederalSchedule>"_CSFS_"</csFederalSchedule>")
 .S XSMSP=$S(SMSP="":"",1:"<singleMultiSourceProduct>"_SMSP_"</singleMultiSourceProduct>")
 .S XINAD=$S(INAD="":"",1:"<inactivationDate>"_INAD_"</inactivationDate>")
 .S XOVCK=$S(OVCK="":"",1:"<overrideDfDoseChkExclusion>"_OVCK_"</overrideDfDoseChkExclusion>")
 .S XEDCK=$S(EDCK="":"",1:"<excludeDrugDrugInteraction>"_EDCK_"</excludeDrugDrugInteraction>")
 .S XCPD=$S(CPD="":"",1:"<createPossibleDosage>"_CPD_"</createPossibleDosage>")
 .S XPP=$S(PP="":"",1:"<productPackage>"_PP_"</productPackage>")
 .S XMVUID=$S(MVUID="":"",1:"<masterEntryForVuid>"_MVUID_"</masterEntryForVuid>")
 .S XVUID=$S(VUID="":"",1:"<vuid>"_VUID_"</vuid>")
 .S XFMG=$S(FMG="":"",1:"<fdaMedGuide>"_FMG_"</fdaMedGuide>")
 .S XSVC=$S(SVC="":"",1:"<serviceCode>"_SVC_"</serviceCode>")
 .S XPDTC=$S(PDTC="":"",1:"<possibleDosagesToCreate>"_PDTC_"</possibleDosagesToCreate>")
 .;
 .S XML=XIEN_XNAME_XVAGN_XDOSF_XSTRG_XUNIT_XNAFN_XVAPN_XVAPI_XTRTC_XVADU_XGCNS
 .S XML2=XPVDC_XNAFI_XCSFS_XSMSP_XINAD_XOVCK_XEDCK_XCPD_XPP_XMVUID_XVUID
 .S XML3=XFMG_XSVC_XPDTC
 .S ^TMP($J,50.68,XTYPE,IEN)=XML
 .S ^TMP($J,50.68,XTYPE,IEN,9999)=XML2
 .S ^TMP($J,50.68,XTYPE,IEN,99999)=XML3
 .;
 .;Active Ingredients Multiple
 .I $D(^PSNDF(50.68,IEN,2,0)) D
 ..S MIEN=0
 ..F  S MIEN=$O(^PSNDF(50.68,IEN,2,MIEN)) Q:MIEN="B"!(MIEN="")  D
 ...S PST0=^PSNDF(50.68,IEN,2,MIEN,0)
 ...S ACTI=$P(PST0,"^"),STRN=$P(PST0,"^",2),UNTS=$P(PST0,"^",3)
 ...S ACTI=$P($G(^PS(50.416,+ACTI,0)),"^")
 ...S UNTS=$P($G(^PS(50.607,+UNTS,0)),"^")
 ...S XMIEN=$S(MIEN="":"",1:"<activeIngredientIen>"_MIEN_"</activeIngredientIen>")
 ...S XACTI=$S(ACTI="":"",1:"<ingredientName><![CDATA["_ACTI_"]]></ingredientName>")
 ...S XSTRN=$S(STRN="":"",2:"<strength><![CDATA["_STRN_"]]></strength>")
 ...S XUNTS=$S(UNTS="":"",3:"<units>"_UNTS_"</units>")
 ...S XTMP=XMIEN_XACTI_XSTRN_XUNTS
 ...S ^TMP($J,50.68,XTYPE,IEN,MIEN)="<activeIngredients>"_XTMP_"</activeIngredients>"
 .;
 .;Override DF Dose CHK Exclusion Multiple
 .I $D(^PSNDF(50.68,IEN,"TERMSTATUS",0)) D
 ..S MIEN=0
 ..F  S MIEN=$O(^PSNDF(50.68,IEN,"TERMSTATUS",MIEN)) Q:MIEN="B"  D
 ...S PST0=$G(^PSNDF(50.68,IEN,"TERMSTATUS",MIEN,0))
 ...S EDT=$P(PST0,"^"),STA=$P(PST0,"^",2)
 ...S EDT=$$FMTHL7^XLFDT(EDT)
 ...S XEDT="<effectiveDateTime>"_EDT_"</effectiveDateTime>"
 ...S XSTA="<status>"_STA_"</status>"
 ...S ^TMP($J,50.68,XTYPE,IEN,9999_MIEN)="<effectiveDateTime>"_XEDT_XSTA_"</effectiveDateTime>"
 .S:XTYPE=TYPE CNT=CNT+1
 ;
 Q
