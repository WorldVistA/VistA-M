C0CDAC2 ; GPL - CCDA Header Routines ;/14/13  17:05
 ;;0.1;C0CDA;nopatch;noreleasedate;Build 1
 ;
 ; License AGPL v3.0
 ; 
 ; This software was funded in part by Oroville Hospital, and was
 ; created with help from Oroville's doctors and staff.
 ;
 Q
 ;
GETHDR(RTN,DFN) ; returns the built header xml
 N GBLD,GWRK,GRPT
 S GWRK=$NA(^TMP("CCDA",$J))
 K @GWRK
 S GBLD=$NA(@GWRK@("BLDLIST"))
 S GRPT=$NA(@GWRK@("CTRL","HEADER"))
 D HEADER(GBLD,DFN,GWRK)
 D BUILD^MXMLTMPL(GBLD,RTN)
 N G2
 D MISSING^MXMLTMPL(RTN,"G2")
 I $D(G2) D  ;
 . W !,"MISSING VARIABLES"
 . ZWR G2
 Q
 ;
HEADER(CCDABLD,DFN,CCDAWRK,CCDARPT,CCDACTRL) ; create a ccda header for patient DFN
 ; use workarea CCDAWRK passed by name
 ; return a build list in CCDABLD passed by name
 ;
 ; the header includes the start of the CCDA document and the patient, author
 ; documentationOf and componentOf sections
 ;
 I '$D(CCDAWRK) S CCDAWRK=$NA(^TMP("CCDA",$J))
 N CCDAV,CCDARTN,PARMS,HAVDTS
 I $D(@CCDACTRL@("PARMS")) M PARMS=@CCDACTRL@("PARMS")
 S HAVDTS=0
 I $D(PARMS("startDateTime")) S HAVDTS=1
 D GETPAT^C0CDACD(.CCDARTN,DFN,"demographics") ; get patient demographics
 M CCDAV=CCDARTN("patient",1)
 N G2
 D  ;
 . S G2(1)="address@stateProvince"
 . S G2(2)="address@city"
 . S G2(3)="address@postalCode"
 . S G2(4)="address@streetLine1"
 N ZI S ZI=""
 F  S ZI=$O(G2(ZI)) Q:ZI=""  D  ;
 . N GV S GV=G2(ZI)
 . I '$D(CCDAV(GV)) S CCDAV(GV)=""
 D SETORGV(.CCDAV)
 ; give the ability to pass in the docId as a parameter
 I $G(PARMS("docId"))'="" S CCDAV("docNumber")=PARMS("docId")
 I $G(PARMS("error"))'="" D  Q  ;
 . S @CCDACTRL@("PARMS","error")=$G(PARMS("error"))
 ;
 ; gpl astro
 ;
 N VARS2 ; for second mapping
 S VARS2("suffix")=""
 S VARS2("tele")="<telecom nullFlavor=""UNK""></telecom>"
 ;
 
 D SETPATV(.CCDAV)
 ; import episode date and text from parms
 N C0D S C0D=$G(PARMS("date"))
 ;
 I C0D="" S C0D=$$NOW^XLFDT
 ; end gpl astro
 I C0D'="" S CCDAV("docOfDate")=$$FMDTOUTC^C0CDACU(C0D)
 S CCDAV("docCreated")=$$FMDTOUTC^C0CDACU($$NOW^XLFDT())
 S CCDAV("encompassingEncounterExtension")=$$UUID^C0CDACU() ; random
 I C0D'="" S CCDAV("encompassingEncounterEffectiveTime")=$$FMDTOUTC^C0CDACU(C0D)
 N CCDATYPE,WRK
 ; build the header
 S CCDATYPE="HEADER"
 S WRK=$NA(@CCDAWRK@(CCDATYPE))
 ; astro gpl
 I $G(PARMS("GPLTEST"))=1 B
 I $G(CCDAV("raceCode"))="UNK" D GETNMAP^C0CDACU(WRK,"THEADER3^C0CDAC2","CCDAV")
 I $G(CCDAV("raceCode"))'="UNK" D  ;
 . N RACECD2 S RACECD2=$$RACECODE2(DFN)
 . I RACECD2=1 D GETNMAP^C0CDACU(WRK,"THEADER2^C0CDAC2","CCDAV")
 . I RACECD2=0 D GETNMAP^C0CDACU(WRK,"THEADER^C0CDAC2","CCDAV")
 N WRK2
 D JUSTMAP^C0CDACU(WRK,"VARS2","WRK2")
 M @WRK=WRK2
 ;M ^gpl("JUSTMAP")=@WRK
 ;M ^gpl("WRK2")=WRK2
 ; end astro gpl
 D QUEUE^MXMLTMPL(CCDABLD,WRK,1,@WRK@(0))
 ;N LAST1
 ;S LAST1(1)="</structuredBody>"
 ;S LAST1(2)="</component>"
 ;S LAST1(3)="</ClinicalDocument>" ; do this after all the rest
 ;S LAST1(0)=3 ; count
 ; build the author
 S CCDATYPE="AUTHOR"
 S WRK=$NA(@CCDAWRK@(CCDATYPE))
 D GETNMAP^C0CDACU(WRK,"TAUTHOR2^C0CDAC2","CCDAV")
 D QUEUE^MXMLTMPL(CCDABLD,WRK,1,@WRK@(0))
 ; build the documentationOf
 S CCDATYPE="DOCOF"
 S WRK=$NA(@CCDAWRK@(CCDATYPE))
 D GETNMAP^C0CDACU(WRK,"TDOCOF^C0CDAC2","CCDAV")
 D QUEUE^MXMLTMPL(CCDABLD,WRK,1,@WRK@(0))
 ; build the componentOf
 S CCDATYPE="COMPOF"
 S WRK=$NA(@CCDAWRK@(CCDATYPE))
 D GETNMAP^C0CDACU(WRK,"TCOMPOF^C0CDAC2","CCDAV")
 D QUEUE^MXMLTMPL(CCDABLD,WRK,1,@WRK@(0))
 ; build the last lines - MOVED TO C0
 ;S CCDATYPE="LAST"
 ;S WRK=$NA(@CCDAWRK@(CCDATYPE))
 ;M @WRK=LAST1
 ;D QUEUE^MXMLTMPL(CCDABLD,WRK,1,@WRK@(0))
 ;
 Q
 ;
RACECODE2(DFN) ; returns 1 if health factor for secondary race code
 ; is present - astro gpl
 N C0CHF
 D GETPAT^C0CDACE(.C0CHF,DFN,"health-factors")
 ;ZWR C0CHF
 N ZI,ZR S ZI=0 S ZR=0
 F  S ZI=$O(C0CHF("results","healthFactors",ZI)) Q:((+ZI=0)!(ZR=1))  D  ;
 . I $G(C0CHF("results","healthFactors",ZI,"factor","name@value"))="EUROPEAN" S ZR=1
 Q ZR
 ;
TEST ;
 N GBLD
 S GBLD=$NA(^TMP("CCDA",$J,"BLDLIST"))
 S CCDAWORK=$NA(^TMP("CCDA",$J))
 S DFN=2
 D HEADER(GBLD,DFN,CCDAWORK)
 ; try building the document
 N CCDA S CCDA=$NA(@CCDAWORK@("XML"))
 D BUILD^MXMLTMPL(GBLD,CCDA)
 K @CCDA@(0)
 N GF S GF=$$FMDTOUTC^C0CDACU($$NOW^XLFDT)_"-HEADER-"_DFN_".xml"
 W $$GTF^%ZISH($na(@CCDA@(1)),4,$$TESTDIR^C0CDACZ(),GF)
 Q
 ;
SETORGV(ARY,ADUZ,ADUZ2) ; sets organization variables based on the DUZ
 ; ARY is passed by reference
 ; optional pass in the DUZ to use. otherwise the current DUZ is used
 ; ADUZ is the person to use ADUZ2 is the institution in DUZ(2) to use
 ;
 ;S ARY("orgOID")="2.16.840.1.113883.5.83" ; WORLDVISTA HL7 OID -
 S ARY("orgOID")=$$ORGOID^C0CDACU() ; look up the oid
 ; REPLACE WITH OROVILLE OID
 S ARY("docNumber")="10C3FBF4-D8EC-11E2-92F7-1708D1228400" ; make random
 S ARY("docNumber")=$$UUID^C0CDACU() ; random
 N UDUZ,UDUZ2
 I $G(ADUZ)="" D  ;
 . S UDUZ=DUZ ; use current DUZ values
 . S UDUZ2=$G(DUZ(2))
 E  D  ;
 . S UDUZ=$G(ADUZ)
 . S UDUZ2=$G(ADUZ2)
 I UDUZ2="" D  Q  ;
 . S PARMS("error")=$G(DUZ(2))_" INSTITUTION NOT KNOWN - EXITING"
 . W:$G(DEBUG) !,$G(DUZ(2))," INSTITUTION NOT KNOWN - EXITING"
 S ARY("orgName")=$$GET1^DIQ(4,UDUZ2_",",.01) ; org name from Institution file
 S ARY("orgState")=$$GET1^DIQ(4,UDUZ2_",",.02) ; 
 S ARY("orgCity")=$$GET1^DIQ(4,UDUZ2_",",1.03) ; 
 S ARY("orgZip")=$$GET1^DIQ(4,UDUZ2_",",1.04) ; 
 S ARY("orgAddr")=$$GET1^DIQ(4,UDUZ2_",",1.01) ; 
 S ARY("orgShortName")=$$GET1^DIQ(4,UDUZ2_",",.05) ; 
 S ARY("orgNPI")=$$GET1^DIQ(4,UDUZ2_",",41.99) ;
 I $G(ARY("orgNPI"))="" S ARY("orgNPI")="UNK" 
 S ARY("healthCareFacilityExtension")=UDUZ2_"^"_ARY("orgShortName")
 ; gpl astro
 N C0CTEL S C0CTEL=$$GET1^DIQ(4.03,"1,"_UDUZ2_",",.03)
 ;S ARY("orgTelephone")="tel:"_$$GET1^DIQ(4.03,"1,"_UDUZ2_",",.03)
 S ARY("orgTelephone")=$S(C0CTEL="":"",1:"tel:"_C0CTEL)
 ; end gpl astro
 N NAME S NAME=$P(^VA(200,UDUZ,0),U)
 D NAMECOMP^XLFNAME(.NAME)
 S ARY("assignedPersonGivenName")=NAME("GIVEN")
 S ARY("assignedPersonFamilyName")=NAME("FAMILY")
 S ARY("assignedPersonSuffix")=""
 I $G(NAME("SUFFIX"))'="" S ARY("assignedPersonSuffix")="<suffix>"_NAME("SUFFIX")_"</suffix>"
 S ARY("authorTime")=$$FMDTOUTC^C0CDACU($$NOW^XLFDT,"DT")
 Q
 ;
SETPATV(ARY) ; set patient variables
 ;
 ; this is the method that the extract uses for demographics
 ; we need to pull out the display text which is not included in
 ; the extract
 ;
 N VADM,VA,VAERR,X
 S X=+$$GETICN^MPIF001(DFN)
 D DEM^VADPT
 ;
 N VPRDEM,VPRDEM1
 D GETPAT^C0CDACE(.VPRDEM1,DFN,"demographics") ; to get codes
 S VPRDEM=$NA(VPRDEM1("results","demographics","patient"))
 ;
 I '$D(ARY("icn@value")) S ARY("icn@value")="UNK"
 S ARY("birthTime")=$$FMDTOUTC^C0CDACU(ARY("dob@value"))
 ; gpl astro
 N GNAME S GNAME=$G(@VPRDEM@("givenNames@value"))
 ;I GNAME[" " D  ; there is a middle name
 D  ;
 . S ARY("given1")=""
 . S ARY("given2")=""
 . S ARY("given1")=$P(GNAME," ",1)
 . S ARY("given2")=$P(GNAME," ",2)
 . ;S ARY("suffix")=""
 . I $E(GNAME,$L(GNAME)-1,$L(GNAME))="JR" S VARS2("suffix")="<suffix>JR</suffix>"
 . I $E(GNAME,$L(GNAME)-1,$L(GNAME))="SR" S VARS2("suffix")="<suffix>SR</suffix>"
 . ;
 . ; previous name
 . S VARS2("previousName")=""
 . I $D(@VPRDEM@("aliases")) D  ;
 . . N PREVFAM,PREVGIVN
 . . S PREVFAM=$G(@VPRDEM@("aliases","alias@familyName"))
 . . S PREVGIVN=$G(@VPRDEM@("aliases","alias@givenNames"))
 . . S VARS2("previousName")="<name><given qualifier=""BR"">"_PREVGIVN_"</given><family qualifier=""BR"">"_PREVFAM_"</family></name>"
 . ; <name> <given qualifier="BR">Alicia</given> <given>Jones</given> <family qualifier="BR">Newman</family></name>
 . ;
 . N TELE S TELE=$G(@VPRDEM@("telecomList","telecom@value"))
 . I TELE'="" D  ;
 . . S VARS2("tele")=""
 . . N TELEN S TELEN=$G(@VPRDEM@("telecomList","telecom@value"))
 . . N TELEU S TELEU=$G(@VPRDEM@("telecomList","telecom@usageType"))
 . . I TELEU'="" S VARS2("tele")=VARS2("tele")_"<telecom use="""_TELEU_""" value=""tel:+1-"_TELEN_"""/>"
 . . E  S VARS2("tele")=VARS2("tele")_"<telecom value=""tel:+1-"_TELEN_"""/>"
 . I TELE="" D  ;
 . . S TELE=$G(@VPRDEM@("telecomList",1,"telecom@value"))
 . . I TELE="" Q  ;
 . . S VARS2("tele")=""
 . . N TELEI S TELEI=0
 . . F  S TELEI=$O(@VPRDEM@("telecomList",TELEI)) Q:+TELEI=0  D  ;
 . . . N TELEN S TELEN=$G(@VPRDEM@("telecomList",TELEI,"telecom@value"))
 . . . N TELEU S TELEU=$G(@VPRDEM@("telecomList",TELEI,"telecom@usageType"))
 . . . I TELEU'="" S VARS2("tele")=VARS2("tele")_"<telecom use="""_TELEU_""" value=""tel:+1-"_TELEN_"""/>"
 . . . E  S VARS2("tele")=VARS2("tele")_"<telecom value=""tel:+1-"_TELEN_"""/>"
 . . . ;M ^gpl("TELEN")=TELEN
 . . . ;M ^gpl("TELEU")=TELEU
 . ;M ^gpl("TELE")=TELE
 . ;M ^gpl("VARS2")=VARS2
 . ;M ^gpl("DEM")=@VPRDEM
 ; end gpl astro
 ;S ARY("maritalCode")=$P(VADM(10),U,1)
 N MARCD
 S MARCD=$G(@VPRDEM@("maritalStatus@value"))
 I MARCD="S" S MARCD="L" ; legally separated
 I MARCD="N" S MARCD="S" ; never married
 ;
 ; Here is the value set 2.16.840.1.113883.1.11.12212 for marital status
 ;
 ;  A   Annulled
 ;  D   Divorced
 ;  T   Domestic partner
 ;  I   Interlocutory   
 ;  L   Legally Separated
 ;  M   Married 
 ;  S   Never Married
 ;  P   Polygamous      
 ;  W   Widowed
 ;
 S ARY("maritalCode")=MARCD
 S ARY("maritalText")=$P(VADM(10),U,2)
 S ARY("religionCode")=$P(VADM(9),U,1)
 S ARY("religionName")=$P(VADM(9),U,2)
 ;S ARY("raceCode")=$P($G(VADM(12,1)),U,1)
 S ARY("raceCode")=$G(@VPRDEM@("races","race@value"))
 ; astro gpl
 I ARY("raceCode")="" D  ;
 . NEW tmprace
 . S tmprace=$G(@VPRDEM@("races",1,"race@value"))
 . IF $l($$MAP^KBAIQLDM(tmprace,"race"))>3 S ARY("raceCode")=tmprace quit  ;
 . S tmprace=$G(@VPRDEM@("races",2,"race@value"))
 . IF $l($$MAP^KBAIQLDM(tmprace,"race"))>3 S ARY("raceCode")=tmprace quit  ;
 I $P($G(VADM(12,1)),U,2)="WHITE, NOT OF HISPANIC ORIGIN" S ARY("raceCode")="2106-3" ; this code was left out of the Race file on most systems
 I ARY("raceCode")="" S ARY("raceName")="UNK"
 E  S ARY("raceName")=$P($G(VADM(12,1)),U,2)_" ("_$P($G(VADM(12,1,1)),U,2)_")"
 ;S ARY("ethnicCode")=$P($G(VADM(11,1)),U,1)
 S ARY("ethnicCode")=$G(@VPRDEM@("ethnicities","ethnicity@value"))
 I ARY("ethnicCode")="" S ARY("ethnicName")="UNK"
 E  D  ;
 . N ETHHOW S ETHHOW=$G(VADM(11,1,1))
 . I ETHHOW="" S ARY("ethnicName")=$P(VADM(11,1),U,2)
 . E  S ARY("ethnicName")=$P(VADM(11,1),U,2)_" ("_$P(ETHHOW,U,2)_")"
 N LANG S LANG=$$GET1^DIQ(2,DFN_",",256000) ; name of language
 N LPRM ; language lookup parameters
 N LCDE,LRTN ; 
 S LPRM("table")="Primary Language"
 S LPRM("name")=LANG
 D LOOKUP^C0CDACU(.LRTN,.LPRM)
 S LCDE=$G(LRTN("code"))
 I LCDE="" S LCDE="en-US"
 S ARY("languageCode")=LCDE
 ;S ARY("languageCode")="eng" ; used to be hardcoded to english
 ;S ARY("encompassingEncounterEffectiveTime")=$$FMDTOUTC^C0CDACU(ARY("facilities.facility@latestDate"))
 N C2I S C2I=""
 F  S C2I=$O(ARY(C2I)) Q:C2I=""  D  ;
 . I C2I="assignedPersonSuffix" Q  
 . I ARY(C2I)="" S ARY(C2I)="UNK"
 Q
 ;
 ;;<religiousAffiliationCode code="@@religionCode@@" displayName="@@religionName@@" codeSystem="2.16.840.1.113883.5.1076" codeSystemName="ReligiousAffiliation"/>
THEADER ;
 ;;<?xml version="1.0" encoding="utf-8" ?>
 ;;<?xml-stylesheet type="text/xsl" href="CDA.xsl"?>
 ;;<ClinicalDocument classCode="DOCCLIN" moodCode="EVN" xmlns="urn:hl7-org:v3" xmlns:sdtc="urn:hl7-org:sdtc" xmlns:voc="urn:hl7-org:v3/voc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="urn:hl7-org:v3 CDASchemas\cda\Schemas\CDA.xsd">
 ;;<realmCode code="US"></realmCode>
 ;;<typeId extension="POCD_HD000040" root="2.16.840.1.113883.1.3"></typeId>
 ;;<!-- US Realm Header -->
 ;;    <templateId root="2.16.840.1.113883.10.20.22.1.1" extension="2015-08-01"/>
 ;;    <templateId root="2.16.840.1.113883.10.20.22.1.1"/>
 ;;    <!-- CCD -->
 ;;    <templateId root="2.16.840.1.113883.10.20.22.1.2" extension="2015-08-01"/>
 ;;    <templateId root="2.16.840.1.113883.10.20.22.1.2"/>
 ;;<id extension="@@docNumber@@" root="@@orgOID@@"></id>
 ;;<code code="34133-9" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Summarization of Episode Note"></code>
 ;;<title>Test Clinic Summarization of Episode Note</title>
 ;;<effectiveTime value="@@docCreated@@"></effectiveTime>
 ;;<confidentialityCode code="N" codeSystem="2.16.840.1.113883.5.25" codeSystemName="Confidentiality" displayName="Normal"></confidentialityCode>
 ;;<languageCode code="en-US"></languageCode>
 ;;<recordTarget contextControlCode="OP" typeCode="RCT">
 ;;<patientRole classCode="PAT">
 ;;<id extension="@@icn@value@@" root="@@orgOID@@"></id>
 ;;<id extension="@@id@value@@" root="@@orgOID@@.2.2"></id>
 ;;<addr>
 ;;<country>US</country>
 ;;<state>@@address@stateProvince@@</state>
 ;;<city>@@address@city@@</city>
 ;;<postalCode>@@address@postalCode@@</postalCode>
 ;;<streetAddressLine>@@address@streetLine1@@</streetAddressLine>
 ;;</addr>
 ;;@@tele@@
 ;;<patient classCode="PSN" determinerCode="INSTANCE">
 ;;<name>
 ;;<family>@@familyName@value@@</family>
 ;;<given>@@given1@@</given>
 ;;<given>@@given2@@</given>
 ;;</name>
 ;;@@previousName@@
 ;;<administrativeGenderCode code="@@gender@value@@" codeSystem="2.16.840.1.113883.5.1" codeSystemName="AdministrativeGender" displayName="@@gender@value@@"></administrativeGenderCode>
 ;;<birthTime value="@@birthTime@@"/>
 ;;<maritalStatusCode code="@@maritalCode@@" displayName="@@maritalText@@" codeSystem="2.16.840.1.113883.5.2" codeSystemName="MaritalStatus"/>
 ;;<religiousAffiliationCode nullFlavor="UNK" />
 ;;<raceCode code="@@raceCode@@" displayName="@@raceName@@" codeSystem="2.16.840.1.113883.6.238" codeSystemName="OMB Standards for Race and Ethnicity"/>
 ;;<sdtc:raceCode code="2108-9" codeSystem="2.16.840.1.113883.6.238" displayName="White European" codeSystemName="OMB Standards for Race and Ethnicity"/>
 ;;<ethnicGroupCode code="@@ethnicCode@@" displayName="@@ethnicName@@" codeSystem="2.16.840.1.113883.6.238" codeSystemName="OMB Standards for Race and Ethnicity"/>
 ;;<languageCommunication>
 ;;<!-- CONF 5407: LanguageCode Code System 2.16.840.1.113883.1.11.11526 -->
 ;;<languageCode code="@@languageCode@@"/>
 ;;<modeCode code="ESP" displayName="Expressed spoken" codeSystem="2.16.840.1.113883.5.60" codeSystemName="LanguageAbilityMode"/>
 ;;</languageCommunication>
 ;;</patient>
 ;;</patientRole>
 ;;</recordTarget>
 Q
 ;
THEADER2 ; astro gpl - added second raceCode - need to generalize
 ;;<?xml version="1.0" encoding="utf-8" ?>
 ;;<?xml-stylesheet type="text/xsl" href="CDA.xsl"?>
 ;;<ClinicalDocument classCode="DOCCLIN" moodCode="EVN" xmlns="urn:hl7-org:v3" xmlns:sdtc="urn:hl7-org:sdtc" xmlns:voc="urn:hl7-org:v3/voc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="urn:hl7-org:v3 CDASchemas\cda\Schemas\CDA.xsd">
 ;;<realmCode code="US"></realmCode>
 ;;<typeId extension="POCD_HD000040" root="2.16.840.1.113883.1.3"></typeId>
 ;;<!-- US Realm Header -->
 ;;    <templateId root="2.16.840.1.113883.10.20.22.1.1" extension="2015-08-01"/>
 ;;    <templateId root="2.16.840.1.113883.10.20.22.1.1"/>
 ;;    <!-- CCD -->
 ;;    <templateId root="2.16.840.1.113883.10.20.22.1.2" extension="2015-08-01"/>
 ;;    <templateId root="2.16.840.1.113883.10.20.22.1.2"/>
 ;;<id extension="@@docNumber@@" root="@@orgOID@@"></id>
 ;;<code code="34133-9" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Summarization of Episode Note"></code>
 ;;<title>Test Clinic Summarization of Episode Note</title>
 ;;<effectiveTime value="@@docCreated@@"></effectiveTime>
 ;;<confidentialityCode code="N" codeSystem="2.16.840.1.113883.5.25" codeSystemName="Confidentiality" displayName="Normal"></confidentialityCode>
 ;;<languageCode code="en-US"></languageCode>
 ;;<recordTarget contextControlCode="OP" typeCode="RCT">
 ;;<patientRole classCode="PAT">
 ;;<id extension="@@icn@value@@" root="@@orgOID@@"></id>
 ;;<id extension="@@id@value@@" root="@@orgOID@@.2.2"></id>
 ;;<addr>
 ;;<country>US</country>
 ;;<state>@@address@stateProvince@@</state>
 ;;<city>@@address@city@@</city>
 ;;<postalCode>@@address@postalCode@@</postalCode>
 ;;<streetAddressLine>@@address@streetLine1@@</streetAddressLine>
 ;;</addr>
 ;;@@tele@@
 ;;<patient classCode="PSN" determinerCode="INSTANCE">
 ;;<family>@@familyName@value@@</family>
 ;;<given>@@given1@@</given>
 ;;<given>@@given2@@</given>
 ;;</name>
 ;;@@previousName@@
 ;;<administrativeGenderCode code="@@gender@value@@" codeSystem="2.16.840.1.113883.5.1" codeSystemName="AdministrativeGender" displayName="@@gender@value@@"></administrativeGenderCode>
 ;;<birthTime value="@@birthTime@@"/>
 ;;<maritalStatusCode code="@@maritalCode@@" displayName="@@maritalText@@" codeSystem="2.16.840.1.113883.5.2" codeSystemName="MaritalStatus"/>
 ;;<religiousAffiliationCode nullFlavor="UNK" />
 ;;<raceCode code="@@raceCode@@" displayName="@@raceName@@" codeSystem="2.16.840.1.113883.6.238" codeSystemName="OMB Standards for Race and Ethnicity"/>
 ;;<sdtc:raceCode code="2108-9" codeSystem="2.16.840.1.113883.6.238" displayName="White European" codeSystemName="OMB Standards for Race and Ethnicity"/>
 ;;<ethnicGroupCode code="@@ethnicCode@@" displayName="@@ethnicName@@" codeSystem="2.16.840.1.113883.6.238" codeSystemName="OMB Standards for Race and Ethnicity"/>
 ;;<languageCommunication>
 ;;<!-- CONF 5407: LanguageCode Code System 2.16.840.1.113883.1.11.11526 -->
 ;;<languageCode code="@@languageCode@@"/>
 ;;<modeCode code="ESP" displayName="Expressed spoken" codeSystem="2.16.840.1.113883.5.60" codeSystemName="LanguageAbilityMode"/>
 ;;</languageCommunication>
 ;;</patient>
 ;;</patientRole>
 ;;</recordTarget>
 Q
 ;
THEADER3 ; for patients with unknown race and ethnicity codes
 ;;<?xml version="1.0" encoding="utf-8" ?>
 ;;<?xml-stylesheet type="text/xsl" href="CDA.xsl"?>
 ;;<ClinicalDocument classCode="DOCCLIN" moodCode="EVN" xmlns="urn:hl7-org:v3" xmlns:sdtc="urn:hl7-org:sdtc" xmlns:voc="urn:hl7-org:v3/voc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="urn:hl7-org:v3 CDASchemas\cda\Schemas\CDA.xsd">
 ;;<realmCode code="US"></realmCode>
 ;;<typeId extension="POCD_HD000040" root="2.16.840.1.113883.1.3"></typeId>
 ;;<!-- US Realm Header -->
 ;;    <templateId root="2.16.840.1.113883.10.20.22.1.1" extension="2015-08-01"/>
 ;;    <templateId root="2.16.840.1.113883.10.20.22.1.1"/>
 ;;    <!-- CCD -->
 ;;    <templateId root="2.16.840.1.113883.10.20.22.1.2" extension="2015-08-01"/>
 ;;    <templateId root="2.16.840.1.113883.10.20.22.1.2"/>
 ;;<id extension="@@docNumber@@" root="@@orgOID@@"></id>
 ;;<code code="34133-9" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Summarization of Episode Note"></code>
 ;;<title>Test Clinic Summarization of Episode Note</title>
 ;;<effectiveTime value="@@docCreated@@"></effectiveTime>
 ;;<confidentialityCode code="N" codeSystem="2.16.840.1.113883.5.25" codeSystemName="Confidentiality" displayName="Normal"></confidentialityCode>
 ;;<languageCode code="en-US"></languageCode>
 ;;<recordTarget contextControlCode="OP" typeCode="RCT">
 ;;<patientRole classCode="PAT">
 ;;<id extension="@@icn@value@@" root="@@orgOID@@"></id>
 ;;<id extension="@@id@value@@" root="@@orgOID@@.2.2"></id>
 ;;<addr>
 ;;<country>US</country>
 ;;<state>@@address@stateProvince@@</state>
 ;;<city>@@address@city@@</city>
 ;;<postalCode>@@address@postalCode@@</postalCode>
 ;;<streetAddressLine>@@address@streetLine1@@</streetAddressLine>
 ;;</addr>
 ;;@@tele@@
 ;;<patient classCode="PSN" determinerCode="INSTANCE">
 ;;<name>
 ;;<family>@@familyName@value@@</family>
 ;;<given>@@given1@@</given>
 ;;<given>@@given2@@</given>
 ;;@@suffix@@
 ;;</name>
 ;;@@previousName@@
 ;;<administrativeGenderCode code="@@gender@value@@" codeSystem="2.16.840.1.113883.5.1" codeSystemName="AdministrativeGender" displayName="@@gender@value@@"></administrativeGenderCode>
 ;;<birthTime value="@@birthTime@@"/>
 ;;<maritalStatusCode code="@@maritalCode@@" displayName="@@maritalText@@" codeSystem="2.16.840.1.113883.5.2" codeSystemName="MaritalStatus"/>
 ;;<religiousAffiliationCode nullFlavor="UNK" />
 ;;<raceCode nullFlavor="UNK" />
 ;;<ethnicGroupCode nullFlavor="UNK" />
 ;;<languageCommunication>
 ;;<!-- CONF 5407: LanguageCode Code System 2.16.840.1.113883.1.11.11526 -->
 ;;<languageCode code="@@languageCode@@"/>
 ;;<modeCode code="ESP" displayName="Expressed spoken" codeSystem="2.16.840.1.113883.5.60" codeSystemName="LanguageAbilityMode"/>
 ;;</languageCommunication>
 ;;</patient>
 ;;</patientRole>
 ;;</recordTarget>
 Q
 ;
 ; removed
 ;;<religiousAffiliationCode code="@@religionCode@@" displayName="@@religionName@@" codeSystem="2.16.840.1.113883.5.1076" codeSystemName="ReligiousAffiliation"/>
 ;
TAUTHOR ;
 ;;<author>
 ;;<time value='@@authorTime@@'></time>
 ;;<assignedAuthor classCode="ASSIGNED">
 ;;<id nullFlavor="NI"/>
 ;;<addr nullFlavor="NI"/>
 ;;<telecom nullFlavor="NI"/>
 ;;<assignedAuthoringDevice>
 ;;<manufacturerModelName>WorldVistA</manufacturerModelName>
 ;;<softwareName>Opensource CDA Documents Generator</softwareName>
 ;;</assignedAuthoringDevice>
 ;;<representedOrganization>
 ;;<id extension="3" root="1.3.6.1.4.1.22812.11.99930.3"/>
 ;;<name>Local Community Hospital</name>
 ;;<telecom value="tel:+1-(555)555-1014"/>
 ;;<addr>
 ;;<streetAddressLine>4444 Hospital Way</streetAddressLine>
 ;;<city>Portland</city>
 ;;<state>OR</state>
 ;;<postalCode>97005</postalCode>
 ;;<country>US</country>
 ;;</addr>
 ;;</representedOrganization>
 ;;</assignedAuthor>
 ;;</author>
 ;;<custodian>
 ;;<assignedCustodian classCode="ASSIGNED">
 ;;<representedCustodianOrganization classCode="ORG" determinerCode="INSTANCE">
 ;;<id extension="CDA" root="@@orgOID@@"></id>
 ;;<name>@@orgName@@</name>
 ;;<telecom use="WP" value="@@orgTelephone@@"></telecom>
 ;;<addr>
 ;;<state>@@orgState@@</state>
 ;;<city>@@orgCity@@</city>
 ;;<postalCode>@@orgZip@@</postalCode>
 ;;<streetAddressLine>@@orgAddr@@</streetAddressLine>
 ;;</addr>
 ;;</representedCustodianOrganization>
 ;;</assignedCustodian>
 ;;</custodian>
 Q
 ;
TAUTHOR2 ; putting addresses and phone numbers in all 3 author slots
 ;;<author>
 ;;<time value='@@authorTime@@'></time>
 ;;<assignedAuthor classCode="ASSIGNED">
 ;;<id nullFlavor="NI"/>
 ;;<addr>
 ;;<state>@@orgState@@</state>
 ;;<city>@@orgCity@@</city>
 ;;<postalCode>@@orgZip@@</postalCode>
 ;;<streetAddressLine>@@orgAddr@@</streetAddressLine>
 ;;</addr>
 ;;<telecom use="WP" value="@@orgTelephone@@"></telecom>
 ;;<assignedAuthoringDevice>
 ;;<manufacturerModelName>WorldVistA</manufacturerModelName>
 ;;<softwareName>Opensource CDA Documents Generator</softwareName>
 ;;</assignedAuthoringDevice>
 ;;<representedOrganization>
 ;;<id extension="3" root="1.3.6.1.4.1.22812.11.99930.3"/>
 ;;<name>@@orgName@@</name>
 ;;<telecom use="WP" value="@@orgTelephone@@"></telecom>
 ;;<addr>
 ;;<state>@@orgState@@</state>
 ;;<city>@@orgCity@@</city>
 ;;<postalCode>@@orgZip@@</postalCode>
 ;;<streetAddressLine>@@orgAddr@@</streetAddressLine>
 ;;</addr>
 ;;</representedOrganization>
 ;;</assignedAuthor>
 ;;</author>
 ;;<custodian>
 ;;<assignedCustodian classCode="ASSIGNED">
 ;;<representedCustodianOrganization classCode="ORG" determinerCode="INSTANCE">
 ;;<id extension="CDA" root="@@orgOID@@"></id>
 ;;<name>@@orgName@@</name>
 ;;<telecom use="WP" value="@@orgTelephone@@"></telecom>
 ;;<addr>
 ;;<state>@@orgState@@</state>
 ;;<city>@@orgCity@@</city>
 ;;<postalCode>@@orgZip@@</postalCode>
 ;;<streetAddressLine>@@orgAddr@@</streetAddressLine>
 ;;</addr>
 ;;</representedCustodianOrganization>
 ;;</assignedCustodian>
 ;;</custodian>
 Q
 ;
TDOCOF ;
 ;;<documentationOf>
 ;;<serviceEvent classCode="PCPR" moodCode="EVN">
 ;;<effectiveTime>
 ;;<low nullFlavor="UNK"></low>
 ;;<high value="@@docOfDate@@"></high>
 ;;</effectiveTime>
 ;;<performer typeCode="PRF">
 ;;<assignedEntity>
 ;;<id extension="@@orgNPI@@" root="2.16.840.1.113883.4.6"></id>
 ;;<addr>
 ;;<state>@@orgState@@</state>
 ;;<city>@@orgCity@@</city>
 ;;<postalCode>@@orgZip@@</postalCode>
 ;;<streetAddressLine>@@orgAddr@@</streetAddressLine>
 ;;</addr>
 ;;<telecom use="WP" value="@@orgTelephone@@"></telecom>
 ;;<assignedPerson>
 ;;<name>
 ;;<family>@@assignedPersonFamilyName@@</family>
 ;;<given>@@assignedPersonGivenName@@</given>
 ;;@@assignedPersonSuffix@@
 ;;</name>
 ;;</assignedPerson>
 ;;</assignedEntity>
 ;;</performer>
 ;;</serviceEvent>
 ;;</documentationOf>
 Q
 ;
TCOMPOF ;
 ;;<componentOf>
 ;;<encompassingEncounter>
 ;;<id extension="@@encompassingEncounterExtension@@" root="@@orgOID@@"></id>
 ;;<effectiveTime value="@@encompassingEncounterEffectiveTime@@"></effectiveTime>
 ;;<responsibleParty>
 ;;<assignedEntity>
 ;;<id nullFlavor="UNK"></id>
 ;;<addr>
 ;;<state>@@orgState@@</state>
 ;;<city>@@orgCity@@</city>
 ;;<postalCode>@@orgZip@@</postalCode>
 ;;<streetAddressLine>@@orgAddr@@</streetAddressLine>
 ;;</addr>
 ;;<telecom use="WP" value="@@orgTelephone@@"></telecom>
 ;;<assignedPerson>
 ;;<name>
 ;;<family>@@assignedPersonFamilyName@@</family>
 ;;<given>@@assignedPersonGivenName@@</given>
 ;;@@assignedPersonSuffix@@
 ;;</name>
 ;;</assignedPerson>
 ;;</assignedEntity>
 ;;</responsibleParty>
 ;;<location>
 ;;<healthCareFacility>
 ;;<id extension="@@healthCareFacilityExtension@@" root="@@orgOID@@"></id>
 ;;<location>
 ;;<name>@@orgName@@</name>
 ;;<addr>
 ;;<state>@@orgState@@</state>
 ;;<city>@@orgCity@@</city>
 ;;<postalCode>@@orgCity@@</postalCode>
 ;;<streetAddressLine>@@orgAddr@@</streetAddressLine>
 ;;</addr>
 ;;</location>
 ;;</healthCareFacility>
 ;;</location>
 ;;</encompassingEncounter>
 ;;</componentOf>
 ;;<component>
 ;;<structuredBody>
 Q
 ;
TLAST1 ;
 ;;</structuredBody>
 ;;</component>
 ;;</ClinicalDocument>
 Q
 ;
