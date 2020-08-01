C0CDACP ; GPL - Patient Portal - CCDA Routines ;09/17/13  17:05
 ;;0.1;JJOHPP;nopatch;noreleasedate;Build 1
 ;
 ; License AGPL v3.0
 ; 
 ; This software was funded in part by Oroville Hospital, and was
 ; created with help from Oroville's doctors and staff.
 Q
 ;
PROC(BLIST,DFN,CCDAWRK,CCDARPT,CCDACTRL) ;
 ;
 N CCDAV,CCDAV1
 S @CCDARPT@("STATUS")="EXTRACTING"
 S @CCDARPT@("EXTRACT-BEGIN")=$$NOW^XLFDT
 I $G(C0TEST) D TESTPAT(.CCDAV1) ; use a unit test patient for now
 E  D GETPAT^C0CDACE(.CCDAV1,DFN,"procedures")
 D HASCPTPROC(.CCDAV1,DFN)
 D HFPROC(.CCDAV1,DFN)
 I '$D(CCDAV1) Q  ;
 I +$G(CCDAV1("results","procedures@total"))=0 Q  ;
 I CCDAV1("results","procedures@total")=1 D  ;
 . M CCDAV(1)=CCDAV1("results","procedures")
 E  M CCDAV=CCDAV1("results","procedures")
 S @CCDARPT@("EXTRACT-ENDS")=$$NOW^XLFDT
 ;
 ; procedures section html
 ;
 N C0HTML,C0ARY
 S C0ARY("TITLE")="Procedure"
 S C0ARY("HEADER",1)="Date"
 S C0ARY("HEADER",2)="Procedure"
 ;S C0ARY("HEADER",3)="Location"
 ;S C0ARY("HEADER",4)="Status"
 ;
 D  ;
 . N C0N S C0N=0
 . N C0I S C0I=0
 . F  S C0I=$O(CCDAV(C0I)) Q:+C0I=0  D  ;
 . . N C0DATE S C0DATE=$G(CCDAV(C0I,"procedure","dateTime@value"))
 . . N ZURI
 . . I $D(CCDAV(C0I,"procedure","id@value")) D  ;
 . . . S ZURI=$TR(CCDAV(C0I,"procedure","id@value"),".","_")
 . . . S ZURI="uri_"_$G(CCDAV(C0I,"procedure","category@value"))_"_"_ZURI
 . . S CCDAV(C0I,"procedure","uri")=$G(ZURI)
 . . Q:$$REDACT^C0CDACV(CCDAV(C0I,"procedure","uri"),.PARMS)
 . . S C0ARY(C0N,1,"uri")=$G(CCDAV(C0I,"procedure","uri"))
 . . S C0N=C0N+1
 . . I C0DATE'="" S C0ARY(C0N,1)=$$HTMLDT^C0CDACU(C0DATE) ; procedure date
 . . E  S C0ARY(C0N,1)=""
 . . S C0ARY(C0N,1,"ID")=$G(CCDAV(C0I,"procedure","uri"))
 . . N UNAME,UCODE ; useName, useCode
 . . S (UNAME,UCODE)=""
 . . N PNAME,PCODE
 . . S PNAME=$G(CCDAV(C0I,"procedure","name@value"))
 . . S PCODE=$G(CCDAV(C0I,"procedure","order@code"))
 . . N TCODE,TNAME
 . . S TCODE=$G(CCDAV(C0I,"procedure","type@code"))
 . . S TNAME=$G(CCDAV(C0I,"procedure","type@name"))
 . . I PNAME="Unknown" S PNAME=""
 . . I TNAME'="" S UNAME=TNAME S UCODE=TCODE
 . . I UNAME="" S UNAME=PNAME S UCODE=PCODE
 . . I UNAME="" D  ;
 . . . S UNAME=$G(CCDAV(C0I,"procedure","imagingType@name")) ; procedure name
 . . . S UCODE=$G(CCDAV(C0I,"procedure","imagingType@code")) ; procedure code
 . . S UNAME=$$CHARCHK^MXMLBLD(UNAME)
 . . S PNAME=$$CHARCHK^MXMLBLD(PNAME)
 . . S CCDAV(C0I,"procedure","cptCode")=UCODE
 . . S CCDAV(C0I,"procedure","cptName")=UNAME
 . . S C0ARY(C0N,2)=UNAME
 . . S C0ARY(C0N,2)=C0ARY(C0N,2)_" (CODE: "_UCODE_") "_PNAME
 . . ;S C0ARY(C0N,3)=$G(CCDAV(C0I,"procedure","location@name")) ; 
 . . ;S C0ARY(C0N,4)=$G(CCDAV(C0I,"procedure","status@value"))
 ;
 I +$O(C0ARY("AAAAA"),-1)=0 Q  ; all procedures have been redacted
 ;
 ; the procedure section component
 ;
 N PSECT S PSECT=$NA(@CCDAWRK@("PROCSECT"))
 D GET^C0CDACU(PSECT,"TPROCSEC^C0CDACP")
 D QUEUE^MXMLTMPL(BLIST,PSECT,1,@PSECT@(0))
 ;
 ; procedure html digest generation
 ;
 N PHTML S PHTML=$NA(@CCDAWRK@("PROCHTML"))
 D GENHTML^C0CDACU(PHTML,"C0ARY")
 D QUEUE^MXMLTMPL(BLIST,PHTML,1,@PHTML@(0))
 ;
 ; procedure xml generation
 ;
 N WRK
 N C0I S C0I=0
 F  S C0I=$O(CCDAV(C0I)) Q:+C0I=0  D  ;
 . N C0DATE S C0DATE=$G(CCDAV(C0I,"procedure","dateTime@value"))
 . I C0DATE'="" S C0ARY("procedureDate")=$$FMDTOUTC^C0CDACU(C0DATE) ; procedure date
 . E  S C0ARY("procedureDate")="UNK"
 . I $$REDACT^C0CDACV(CCDAV(C0I,"procedure","uri"),.PARMS) D  Q  ;
 . S C0ARY("uri")=$G(CCDAV(C0I,"procedure","uri"))
 . S C0ARY("cptName")=$G(CCDAV(C0I,"procedure","cptName"))
 . S C0ARY("cptCode")=$G(CCDAV(C0I,"procedure","cptCode"))
 . S C0ARY("immuLocation")=$G(CCDAV(C0I,"procedure","facility@name"))
 . S C0ARY("guid")=$$UUID^C0CDACU() ; random
 . D SETORGV^C0CDAC2(.C0ARY)
 . ;
 . ; procedure
 . S WRK=$NA(@CCDAWRK@("PROC",C0I))
 . ;
 . N TEMPLATE S TEMPLATE="TPROCPT4^C0CDACP"
 . I C0ARY("cptCode")=175135009 S TEMPLATE="TPROCPACE^C0CDACP"
 . I C0ARY("cptCode")=90660004 S TEMPLATE="TPROCBURN^C0CDACP"
 . I C0ARY("cptCode")=56251003 S TEMPLATE="TPROCNEB^C0CDACP"
 . I C0ARY("cptCode")=10847001 S TEMPLATE="TPROCBRON^C0CDACP"
 . I C0ARY("cptCode")=168731009 S TEMPLATE="TPROCCHST^C0CDACP"
 . D GETNMAP^C0CDACU(WRK,TEMPLATE,"C0ARY")
 . D QUEUE^MXMLTMPL(BLIST,WRK,1,@WRK@(0))
 ; 
 ; procedure section ending
 ;
 N PROCEND S PROCEND=$NA(@CCDAWRK@("PROCEND"))
 D GET^C0CDACU(PROCEND,"TPROCEND^C0CDACP")
 D QUEUE^MXMLTMPL(BLIST,PROCEND,1,@PROCEND@(0))
 ;
 Q
 ;
 ; astro gpl
HASCPTPROC(RTN,DFN) ; retrieve CPT codes that are missed by the VPR extract
 ; that are really valid procedures
 I '$D(^ICPT) Q  ;
 N TBL
 S TBL("G8427","DOC CUR MEDS BY PROV")="" ; documentation of current meds procedure
 N ZI S ZI=""
 F  S ZI=$O(TBL(ZI)) Q:ZI=""  D  ;
 . NEW CPTNAME S CPTNAME=$O(TBL(ZI,""))
 . NEW CPTCODE S CPTCODE=ZI
 . NEW CPTIEN
 . S CPTIEN=$ORDER(^ICPT("B",ZI,""))
 . Q:CPTIEN=""
 . NEW PXRMLOC S PXRMLOC=$NA(^PXRMINDX(9000010.18,"PPI",DFN,"U",CPTIEN))
 . NEW DESTLOC S DESTLOC=$NA(RTN("results","procedures"))
 . NEW DESTIEN
 . IF $G(RTN("results","procedures@total"))=1 D  ;
 . . N PRTMP 
 . . M PRTMP=@DESTLOC@("procedure")
 . . K @DESTLOC@("procedure")
 . . M @DESTLOC@(1,"procedure")=PRTMP
 . IF $G(RTN("results","procedures@total"))=0 D  ;
 . . S DESTIEN=1
 . . S DESTLOC=$NA(@DESTLOC@("procedure"))
 . ELSE  D  ;
 . . S DESTIEN=$O(@DESTLOC@(""),-1)+1
 . . S DESTLOC=$NA(@DESTLOC@(DESTIEN,"procedure"))
 . IF $D(@PXRMLOC) D  ; patient has the CPT code
 . . N DATETIME S DATETIME=$O(@PXRMLOC@(""))
 . . S @DESTLOC@("dateTime@value")=DATETIME
 . . S @DESTLOC@("id@value")="CPT."_$O(@PXRMLOC@(DATETIME,""))
 . . S @DESTLOC@("name@value")=CPTNAME
 . . S @DESTLOC@("order@code")=CPTCODE
 . . S @DESTLOC@("cptName")=CPTNAME
 . . S @DESTLOC@("cptCode")=ZI
 . . S @DESTLOC@("category@value")="CPT"
 . . S RTN("results","procedures@total")=DESTIEN
 Q
 ;
TESTHF ;
 S DFN=13166 
 D GETPAT^C0CDACE(.CCDAV1,DFN,"procedures")
 D HASCPTPROC(.CCDAV1,DFN)
 D HFPROC(.CCDAV1,DFN)
 ZWR CCDAV1
 Q
 ; 
HFPROC(RTN,DFN) ; retrieve procedures from Health Factors
 ; 
 N TBL2 ; table of health factors we are looking for
 S TBL2("175136005","Intro-cardiac pacemaker - 175136005")="" ; use TPROCPACE
 S TBL2("56251003","Nebuliser therapy - 56251003")="" ; use TPROCNEB
 S TBL2("10847001","Bronchoscopy 10847001")="" ; use TPROCBRON
 S TBL2("168731009","Chest X-Ray 168731009")="" ; use TPROCCHST
 S TBL2("90660004","APP OF DRESSING FOR BURN 90660004")="" ; use TPROCBURN
 S TBL2("UDI","UDI PACEMAKER")="" ; included in TPROCPACE
 N ZJ S ZJ=""
 F  S ZJ=$O(TBL2(ZJ)) Q:ZJ=""  D  ; make a B index
 . N ZN S ZN=$O(TBL2(ZJ,""))
 . S TBL2("B",ZN,ZJ)=""
 ;
 N C0HF
 D GETPAT^C0CDACE(.C0HF,DFN,"health-factors")
 N HFLOC S HFLOC=$NA(C0HF("results","healthFactors"))
 I $G(C0HF("results","healthFactors@total"))=1 D  ;
 . N HFTMP M HFTMP=@HFLOC@("factor")
 . K @HFLOC@("factor")
 . M @HFLOC@(1,"factor")=HFTMP
 N ZI S ZI=0
 F  S ZI=$O(@HFLOC@(ZI)) Q:+ZI=0  D  ;
 . N HF S HF=$G(@HFLOC@(ZI,"factor","name@value"))
 . ;W !,HF
 . I $O(TBL2("B",HF,""))="" Q  ; not in table
 . ;
 . NEW SCTNAME S SCTNAME=HF
 . NEW SCTCODE S SCTCODE=$O(TBL2("B",HF,""))
 . ;
 . I SCTCODE=175136005 S SCTCODE=175135009 ; mapped for certification
 . ; 
 . I SCTCODE="UDI" Q  ; included in TPROCPACE template
 . ;
 . NEW DESTLOC S DESTLOC=$NA(RTN("results","procedures"))
 . NEW DESTIEN
 . IF $G(RTN("results","procedures@total"))=1 D  ;
 . . N PRTMP 
 . . M PRTMP=@DESTLOC@("procedure")
 . . K @DESTLOC@("procedure")
 . . M @DESTLOC@(1,"procedure")=PRTMP
 . IF $G(RTN("results","procedures@total"))=0 D  ;
 . . S DESTIEN=1
 . . S DESTLOC=$NA(@DESTLOC@("procedure"))
 . ELSE  D  ;
 . . S DESTIEN=$O(@DESTLOC@(""),-1)+1
 . . S DESTLOC=$NA(@DESTLOC@(DESTIEN,"procedure"))
 . IF $G(SCTCODE)'="" D  ; patient has a SNOMED code
 . . N DATETIME S DATETIME=$G(@HFLOC@(ZI,"factor","recorded@value"))
 . . S @DESTLOC@("dateTime@value")=DATETIME
 . . S @DESTLOC@("id@value")="SCT."_$G(@HFLOC@(ZI,"factor","id@value"))
 . . S @DESTLOC@("name@value")=SCTNAME
 . . S @DESTLOC@("order@code")=SCTCODE
 . . S @DESTLOC@("cptName")=SCTNAME
 . . S @DESTLOC@("cptCode")=ZI
 . . S @DESTLOC@("category@value")="SCT"
 . . S RTN("results","procedures@total")=DESTIEN
 Q
 ;
 ; end astro gpl
 ;
TPROCSEC ; 
 ;;<component>
 ;;<section>
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.7.1"></templateId>
 ;;<code code="47519-4" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="HISTORY OF PROCEDURES"></code>
 Q
 ;
TPROCPT4 ;
 ;;<entry>
 ;;<procedure classCode="PROC" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.14"></templateId>
 ;;<id root="@@guid@@"></id>
 ;;<code code="@@cptCode@@" codeSystem="2.16.840.1.113883.6.12" codeSystemName="CPT4" displayName="@@cptName@@" xsi:type="CE">
 ;;<originalText>
 ;;<reference value="#@@uri@@"></reference>
 ;;</originalText>
 ;;</code>
 ;;<statusCode code="completed"></statusCode>
 ;;<effectiveTime>
 ;;<center value="@@procedureDate@@"></center>
 ;;</effectiveTime>
 ;;<performer typeCode="PRF">
 ;;<assignedEntity>
 ;;<id root="@@orgOID@@"></id>
 ;;<addr>
 ;;<streetAddressLine>@@orgAddr@@</streetAddressLine>
 ;;<city>@@orgCity@@</city>
 ;;<state>@@orgState@@</state>
 ;;<postalCode>@@orgZip@@</postalCode>
 ;;</addr>
 ;;<telecom use="WP" value="@@orgTelephone@@"></telecom>
 ;;<representedOrganization>
 ;;<id root="@@orgOID@@"></id>
 ;;<name>@@orgName@@</name>
 ;;<telecom use="WP" value="@@orgTelephone@@"></telecom>
 ;;<addr>
 ;;<streetAddressLine>@@orgAddr@@</streetAddressLine>
 ;;<city>@@orgCity@@</city>
 ;;<state>@@orgState@@</state>
 ;;<postalCode>@@orgZip@@</postalCode>
 ;;</addr>
 ;;</representedOrganization>
 ;;</assignedEntity>
 ;;</performer>
 ;;</procedure>
 ;;</entry>
 Q
 ;
TPROCNEB ;
 ;;<entry typeCode="DRIV">
 ;;  <procedure classCode="PROC" moodCode="EVN">
 ;;    <templateId root="2.16.840.1.113883.10.20.22.4.14" extension="2014-06-09" />
 ;;    <templateId root="2.16.840.1.113883.10.20.22.4.14" />
 ;;    <id root="d68b7e32-7810-4f5b-9cc2-acd54b0fd85d" />
 ;;    <code code="56251003" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED-CT" displayName="Nebulizer Therapy" />
 ;;    <statusCode code="completed" />
 ;;    <effectiveTime>
 ;;      <low value="20150622" />
 ;;      <high value="20150622" />
 ;;    </effectiveTime>
 ;;    <methodCode nullFlavor="UNK" />
 ;;    <targetSiteCode code="82094008" displayName="Lower Respiratory Tract Structure" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED-CT" />
 ;;  </procedure>
 ;;</entry>
 Q
 ;
TPROCBURN ;
 ;;<entry typeCode="DRIV">
 ;;  <procedure classCode="PROC" moodCode="EVN">
 ;;    <templateId root="2.16.840.1.113883.10.20.22.4.14" extension="2014-06-09" />
 ;;    <templateId root="2.16.840.1.113883.10.20.22.4.14" />
 ;;    <id root="d68b7e32-7810-4f5b-9cc2-acd54b0fd85d" />
 ;;    <code code="90660004" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED-CT" displayName="Application of Dressing for burn" />
 ;;    <statusCode code="completed" />
 ;;    <effectiveTime>
 ;;      <low value="20150622" />
 ;;      <high value="20150622" />
 ;;    </effectiveTime>
 ;;    <methodCode nullFlavor="UNK" />
 ;;    <targetSiteCode code="281737009" displayName="Skin of part of forearm" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED-CT" />
 ;;  </procedure>
 ;;</entry>
 Q
 ;
TPROCBRON ;
 ;;<entry typeCode="DRIV">
 ;;  <procedure classCode="PROC" moodCode="EVN">
 ;;    <templateId root="2.16.840.1.113883.10.20.22.4.14" extension="2014-06-09" />
 ;;    <templateId root="2.16.840.1.113883.10.20.22.4.14" />
 ;;    <id root="d68b7e32-7810-4f5b-9cc2-acd54b0fd85d" />
 ;;    <code code="10847001" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED-CT" displayName="Bronchoscopy" />
 ;;    <statusCode code="completed" />
 ;;    <effectiveTime>
 ;;      <low value="20150622" />
 ;;      <high value="20150622" />
 ;;    </effectiveTime>
 ;;    <methodCode nullFlavor="UNK" />
 ;;    <targetSiteCode code="91724006" displayName="Tracheobronchial structure (body structure)" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED-CT" />
 ;;  </procedure>
 ;;</entry>
 Q
 ;
TPROCCHST ;
 ;;<entry typeCode="DRIV">
 ;;  <procedure classCode="PROC" moodCode="EVN">
 ;;    <templateId root="2.16.840.1.113883.10.20.22.4.14" extension="2014-06-09" />
 ;;    <templateId root="2.16.840.1.113883.10.20.22.4.14" />
 ;;    <id root="d68b7e32-7810-4f5b-9cc2-acd54b0fd85d" />
 ;;    <code code="168731009" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED-CT" displayName="Chest X-Ray" />
 ;;    <statusCode code="completed" />
 ;;    <effectiveTime>
 ;;      <low value="20150622" />
 ;;      <high value="20150622" />
 ;;    </effectiveTime>
 ;;    <methodCode nullFlavor="UNK" />
 ;;    <targetSiteCode code="82094008" displayName="Lower Respiratory Tract Structure" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED-CT" />
 ;;  </procedure>
 ;;</entry>
 Q
 ;
TPROCPACE ;
 ;;<entry typeCode="DRIV"> 
 ;;  <procedure classCode="PROC" moodCode="EVN">
 ;;    <templateId root="2.16.840.1.113883.10.20.22.4.14" extension="2014-06-09" />
 ;;    <templateId root="2.16.840.1.113883.10.20.22.4.14" />
 ;;    <id root="d68b7e32-7810-4f5b-9cc2-acd54b0fd85e" />
 ;;    <code code="175135009" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED-CT" displayName="Introduction of cardiac pacemaker system via vein" />
 ;;    <statusCode code="completed" />
 ;;    <effectiveTime>
 ;;      <low value="20111005" />
 ;;      <high value="20111005" />
 ;;    </effectiveTime>
 ;;    <methodCode nullFlavor="UNK" />
 ;;    <targetSiteCode code="9454009" displayName="Structure of subclavian vein" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED-CT" />
 ;;<participant typeCode="DEV">
 ;;<participantRole classCode="MANU">
 ;;<!-- ** Product instance ** -->
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.37"/>
 ;;<!-- UDI -db -->
 ;;<!-- this UDI provided by the test data is not valid as per CDA schema -db -->
 ;;<!-- <id root="00643169007222"/> -->
 ;;<!-- <id root="d68b7e32-7810-4f5b-9cc2-acd54b0fd85e" extension="00643169007222"/> -->
 ;;<!-- root is FDA OID, extension is the UDI id -->
 ;;<id root="2.16.840.1.113883.3.3719" extension="(01)00643169007222(17)160128(21)BLC200461H"/>
 ;;<playingDevice>
 ;;<!-- the actual UDI device -db -->
 ;;<code code="704708004" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED-CT" displayName="Cardiac resynchronization therapy implantable pacemaker">
 ;;</code>
 ;;</playingDevice>
 ;;<!-- FDA Scoping Entity OID for UDI-db -->
 ;;<scopingEntity>
 ;;<id root="2.16.840.1.113883.3.3719"/>
 ;;</scopingEntity>
 ;;</participantRole>
 ;;</participant>
 ;;  </procedure>
 ;;</entry>
 Q
 ;
TPROCEND ; end of section
 ;;</section>
 ;;</component>
 Q
 ;
TESTPAT(G) ; test procedures G is passed by reference
 S G("results","procedures",1,"procedure","case@value")=7667
 S G("results","procedures",1,"procedure","category@value")="RA"
 S G("results","procedures",1,"procedure","dateTime@value")=3121130.1117
 S G("results","procedures",1,"procedure","facility@code")=195966
 S G("results","procedures",1,"procedure","facility@name")=" HOSPITAL"
 S G("results","procedures",1,"procedure","hasImages@value")=0
 S G("results","procedures",1,"procedure","id@value")="6878869.8882-1"
 S G("results","procedures",1,"procedure","imagingType@code")="US"
 S G("results","procedures",1,"procedure","imagingType@name")="ULTRASOUND"
 S G("results","procedures",1,"procedure","location@code")=143
 S G("results","procedures",1,"procedure","location@name")=" HOSP US"
 S G("results","procedures",1,"procedure","name@value")=" EXTREMITY VEINS-UNILAT"
 S G("results","procedures",1,"procedure","order@code")=2746341
 S G("results","procedures",1,"procedure","order@name")=" EXTREMITY VEINS-UNILAT"
 S G("results","procedures",1,"procedure","status@value")="WAITING FOR EXAM"
 S G("results","procedures",1,"procedure","type@code")=93971
 S G("results","procedures",1,"procedure","type@name")="DUPLEX SCAN OF EXTREMITY VEINS INCLUDING RESPONSES TO COMPRESSION AND OTHER MANEUVERS; UNILATERALOR LIMITED STUDY"
 S G("results","procedures",2,"procedure","case@value")=7509
 S G("results","procedures",2,"procedure","category@value")="RA"
 S G("results","procedures",2,"procedure","dateTime@value")=3121129.1532
 S G("results","procedures",2,"procedure","facility@code")=195966
 S G("results","procedures",2,"procedure","facility@name")=" HOSPITAL"
 S G("results","procedures",2,"procedure","hasImages@value")=0
 S G("results","procedures",2,"procedure","id@value")="6878870.8467-1"
 S G("results","procedures",2,"procedure","imagingType@code")="RAD"
 S G("results","procedures",2,"procedure","imagingType@name")="GENERAL RADIOLOGY"
 S G("results","procedures",2,"procedure","location@code")=128
 S G("results","procedures",2,"procedure","location@name")=" HOSP RADIOLOGY"
 S G("results","procedures",2,"procedure","name@value")=" CHEST 2V AP/LAT"
 S G("results","procedures",2,"procedure","order@code")=2742586
 S G("results","procedures",2,"procedure","order@name")=" CHEST 2V AP/LAT"
 S G("results","procedures",2,"procedure","status@value")="WAITING FOR EXAM"
 S G("results","procedures",2,"procedure","type@code")=71020
 S G("results","procedures",2,"procedure","type@name")="RADIOLOGIC EXAMINATION, CHEST, 2 VIEWS, FRONTAL AND LATERAL;"
 S G("results","procedures",3,"procedure","case@value")=7508
 S G("results","procedures",3,"procedure","category@value")="RA"
 S G("results","procedures",3,"procedure","dateTime@value")=3121129.1529
 S G("results","procedures",3,"procedure","facility@code")=195966
 S G("results","procedures",3,"procedure","facility@name")=" HOSPITAL"
 S G("results","procedures",3,"procedure","hasImages@value")=0
 S G("results","procedures",3,"procedure","id@value")="6878870.847-1"
 S G("results","procedures",3,"procedure","imagingType@code")="RAD"
 S G("results","procedures",3,"procedure","imagingType@name")="GENERAL RADIOLOGY"
 S G("results","procedures",3,"procedure","location@code")=128
 S G("results","procedures",3,"procedure","location@name")=" HOSP RADIOLOGY"
 S G("results","procedures",3,"procedure","name@value")=" CHEST 2V AP/LAT"
 S G("results","procedures",3,"procedure","order@code")=2742534
 S G("results","procedures",3,"procedure","order@name")=" CHEST 2V AP/LAT"
 S G("results","procedures",3,"procedure","status@value")="WAITING FOR EXAM"
 S G("results","procedures",3,"procedure","type@code")=71020
 S G("results","procedures",3,"procedure","type@name")="RADIOLOGIC EXAMINATION, CHEST, 2 VIEWS, FRONTAL AND LATERAL;"
 S G("results","procedures",4,"procedure","case@value")=7353
 S G("results","procedures",4,"procedure","category@value")="RA"
 S G("results","procedures",4,"procedure","dateTime@value")=3121129.0937
 S G("results","procedures",4,"procedure","facility@code")=195966
 S G("results","procedures",4,"procedure","facility@name")=" HOSPITAL"
 S G("results","procedures",4,"procedure","hasImages@value")=0
 S G("results","procedures",4,"procedure","id@value")="6878870.9062-1"
 S G("results","procedures",4,"procedure","imagingType@code")="CT"
 S G("results","procedures",4,"procedure","imagingType@name")="CT SCAN"
 S G("results","procedures",4,"procedure","location@code")=137
 S G("results","procedures",4,"procedure","location@name")=" HOSP CT"
 S G("results","procedures",4,"procedure","name@value")=" CT ABD/PELVIS W/CONTRAST"
 S G("results","procedures",4,"procedure","order@code")=2739412
 S G("results","procedures",4,"procedure","order@name")=" CT ABD/PELVIS W/CONTRAST"
 S G("results","procedures",4,"procedure","status@value")="WAITING FOR EXAM"
 S G("results","procedures",4,"procedure","type@code")=74177
 S G("results","procedures",4,"procedure","type@name")="COMPUTED TOMOGRAPHY, ABDOMEN AND PELVIS; WITH CONTRAST MATERIAL(S)"
 S G("results","procedures",5,"procedure","case@value")=7183
 S G("results","procedures",5,"procedure","category@value")="RA"
 S G("results","procedures",5,"procedure","dateTime@value")=3121128.1319
 S G("results","procedures",5,"procedure","facility@code")=195966
 S G("results","procedures",5,"procedure","facility@name")=" HOSPITAL"
 S G("results","procedures",5,"procedure","hasImages@value")=0
 S G("results","procedures",5,"procedure","id@value")="6878871.868-1"
 S G("results","procedures",5,"procedure","imagingType@code")="CT"
 S G("results","procedures",5,"procedure","imagingType@name")="CT SCAN"
 S G("results","procedures",5,"procedure","location@code")=137
 S G("results","procedures",5,"procedure","location@name")=" HOSP CT"
 S G("results","procedures",5,"procedure","name@value")=" CT ABD/PELVIS W/CONTRAST"
 S G("results","procedures",5,"procedure","order@code")=2734102
 S G("results","procedures",5,"procedure","order@name")=" CT ABD/PELVIS W/CONTRAST"
 S G("results","procedures",5,"procedure","status@value")="WAITING FOR EXAM"
 S G("results","procedures",5,"procedure","type@code")=74177
 S G("results","procedures",5,"procedure","type@name")="COMPUTED TOMOGRAPHY, ABDOMEN AND PELVIS; WITH CONTRAST MATERIAL(S)"
 S G("results","procedures",6,"procedure","case@value")=2901
 S G("results","procedures",6,"procedure","category@value")="RA"
 S G("results","procedures",6,"procedure","dateTime@value")=3121106.1048
 S G("results","procedures",6,"procedure","facility@code")=195966
 S G("results","procedures",6,"procedure","facility@name")=" HOSPITAL"
 S G("results","procedures",6,"procedure","hasImages@value")=0
 S G("results","procedures",6,"procedure","id@value")="6878893.8951-1"
 S G("results","procedures",6,"procedure","imagingType@code")="RAD"
 S G("results","procedures",6,"procedure","imagingType@name")="GENERAL RADIOLOGY"
 S G("results","procedures",6,"procedure","location@code")=128
 S G("results","procedures",6,"procedure","location@name")=" HOSP RADIOLOGY"
 S G("results","procedures",6,"procedure","name@value")=" KNEE 1 OR 2V RT"
 S G("results","procedures",6,"procedure","order@code")=2611620
 S G("results","procedures",6,"procedure","order@name")=" KNEE 1 OR 2V RT"
 S G("results","procedures",6,"procedure","status@value")="WAITING FOR EXAM"
 S G("results","procedures",6,"procedure","type@code")=73560
 S G("results","procedures",6,"procedure","type@name")="RADIOLOGIC EXAMINATION, KNEE; 1 OR 2 VIEWS"
 S G("results","procedures",7,"procedure","case@value")=2899
 S G("results","procedures",7,"procedure","category@value")="RA"
 S G("results","procedures",7,"procedure","dateTime@value")=3121106.1044
 S G("results","procedures",7,"procedure","facility@code")=195966
 S G("results","procedures",7,"procedure","facility@name")=" HOSPITAL"
 S G("results","procedures",7,"procedure","hasImages@value")=0
 S G("results","procedures",7,"procedure","id@value")="6878893.8955-1"
 S G("results","procedures",7,"procedure","imagingType@code")="RAD"
 S G("results","procedures",7,"procedure","imagingType@name")="GENERAL RADIOLOGY"
 S G("results","procedures",7,"procedure","location@code")=128
 S G("results","procedures",7,"procedure","location@name")=" HOSP RADIOLOGY"
 S G("results","procedures",7,"procedure","name@value")=" FEMUR 2V LT"
 S G("results","procedures",7,"procedure","order@code")=2611579
 S G("results","procedures",7,"procedure","order@name")=" FEMUR 2V LT"
 S G("results","procedures",7,"procedure","status@value")="WAITING FOR EXAM"
 S G("results","procedures",7,"procedure","type@code")=73550
 S G("results","procedures",7,"procedure","type@name")="RADIOLOGIC EXAMINATION, FEMUR, 2 VIEWS"
 S G("results","procedures",8,"procedure","case@value")=2896
 S G("results","procedures",8,"procedure","category@value")="RA"
 S G("results","procedures",8,"procedure","dateTime@value")=3121106.1034
 S G("results","procedures",8,"procedure","facility@code")=195966
 S G("results","procedures",8,"procedure","facility@name")=" HOSPITAL"
 S G("results","procedures",8,"procedure","hasImages@value")=0
 S G("results","procedures",8,"procedure","id@value")="6878893.8965-1"
 S G("results","procedures",8,"procedure","imagingType@code")="RAD"
 S G("results","procedures",8,"procedure","imagingType@name")="GENERAL RADIOLOGY"
 S G("results","procedures",8,"procedure","location@code")=128
 S G("results","procedures",8,"procedure","location@name")=" HOSP RADIOLOGY"
 S G("results","procedures",8,"procedure","name@value")=" L-S SPINE 2 OR 3V"
 S G("results","procedures",8,"procedure","order@code")=2611463
 S G("results","procedures",8,"procedure","order@name")=" L-S SPINE 2 OR 3V"
 S G("results","procedures",8,"procedure","status@value")="WAITING FOR EXAM"
 S G("results","procedures",8,"procedure","type@code")=72100
 S G("results","procedures",8,"procedure","type@name")="RADIOLOGIC EXAMINATION, SPINE, LUMBOSACRAL; 2 OR 3 VIEWS"
 S G("results","procedures@total")=8
 S G("results@timeZone")="-0800"
 S G("results@version")=1.1
 Q
 ;
TESTPAT2(G) ; test procedures G is passed by reference
 S G("results","procedures",1,"procedure","case@value")=7178
 S G("results","procedures",1,"procedure","category@value")="RA"
 S G("results","procedures",1,"procedure","dateTime@value")=3121128.1314
 S G("results","procedures",1,"procedure","facility@code")=195966
 S G("results","procedures",1,"procedure","facility@name")=" HOSPITAL"
 S G("results","procedures",1,"procedure","hasImages@value")=0
 S G("results","procedures",1,"procedure","id@value")="6878871.8685-1"
 S G("results","procedures",1,"procedure","imagingType@code")="CT"
 S G("results","procedures",1,"procedure","imagingType@name")="CT SCAN"
 S G("results","procedures",1,"procedure","location@code")=137
 S G("results","procedures",1,"procedure","location@name")=" HOSP CT"
 S G("results","procedures",1,"procedure","name@value")="Unknown"
 S G("results","procedures",2,"procedure","case@value")=7177
 S G("results","procedures",2,"procedure","category@value")="RA"
 S G("results","procedures",2,"procedure","dateTime@value")=3121128.1313
 S G("results","procedures",2,"procedure","facility@code")=195966
 S G("results","procedures",2,"procedure","facility@name")=" HOSPITAL"
 S G("results","procedures",2,"procedure","hasImages@value")=0
 S G("results","procedures",2,"procedure","id@value")="6878871.8686-1"
 S G("results","procedures",2,"procedure","imagingType@code")="CT"
 S G("results","procedures",2,"procedure","imagingType@name")="CT SCAN"
 S G("results","procedures",2,"procedure","location@code")=137
 S G("results","procedures",2,"procedure","location@name")=" HOSP CT"
 S G("results","procedures",2,"procedure","name@value")="Unknown"
 S G("results","procedures",3,"procedure","case@value")=7176
 S G("results","procedures",3,"procedure","category@value")="RA"
 S G("results","procedures",3,"procedure","dateTime@value")=3121128.1312
 S G("results","procedures",3,"procedure","facility@code")=195966
 S G("results","procedures",3,"procedure","facility@name")=" HOSPITAL"
 S G("results","procedures",3,"procedure","hasImages@value")=0
 S G("results","procedures",3,"procedure","id@value")="6878871.8687-1"
 S G("results","procedures",3,"procedure","imagingType@code")="CT"
 S G("results","procedures",3,"procedure","imagingType@name")="CT SCAN"
 S G("results","procedures",3,"procedure","location@code")=137
 S G("results","procedures",3,"procedure","location@name")=" HOSP CT"
 S G("results","procedures",3,"procedure","name@value")="Unknown"
 S G("results","procedures",4,"procedure","case@value")=7173
 S G("results","procedures",4,"procedure","category@value")="RA"
 S G("results","procedures",4,"procedure","dateTime@value")=3121128.131
 S G("results","procedures",4,"procedure","facility@code")=195966
 S G("results","procedures",4,"procedure","facility@name")=" HOSPITAL"
 S G("results","procedures",4,"procedure","hasImages@value")=0
 S G("results","procedures",4,"procedure","id@value")="6878871.8689-1"
 S G("results","procedures",4,"procedure","imagingType@code")="CT"
 S G("results","procedures",4,"procedure","imagingType@name")="CT SCAN"
 S G("results","procedures",4,"procedure","location@code")=137
 S G("results","procedures",4,"procedure","location@name")=" HOSP CT"
 S G("results","procedures",4,"procedure","name@value")="Unknown"
 S G("results","procedures",5,"procedure","case@value")=1127
 S G("results","procedures",5,"procedure","category@value")="RA"
 S G("results","procedures",5,"procedure","dateTime@value")=3121019.1215
 S G("results","procedures",5,"procedure","facility@code")=195966
 S G("results","procedures",5,"procedure","facility@name")=" HOSPITAL"
 S G("results","procedures",5,"procedure","hasImages@value")=0
 S G("results","procedures",5,"procedure","id@value")="6878980.8784-1"
 S G("results","procedures",5,"procedure","imagingType@code")="RAD"
 S G("results","procedures",5,"procedure","imagingType@name")="GENERAL RADIOLOGY"
 S G("results","procedures",5,"procedure","location@code")=128
 S G("results","procedures",5,"procedure","location@name")=" HOSP RADIOLOGY"
 S G("results","procedures",5,"procedure","name@value")="VMI ABD 2V"
 S G("results","procedures",5,"procedure","order@code")=2435673
 S G("results","procedures",5,"procedure","order@name")="VMI ABD 2V"
 S G("results","procedures",5,"procedure","status@value")="WAITING FOR EXAM"
 S G("results","procedures",5,"procedure","type@code")=74020
 S G("results","procedures",5,"procedure","type@name")="RADIOLOGIC EXAMINATION, ABDOMEN; COMPLETE, INCLUDING DECUBITUS AND/OR ERECT VIEWS"
 S G("results","procedures",6,"procedure","case@value")=3
 S G("results","procedures",6,"procedure","category@value")="RA"
 S G("results","procedures",6,"procedure","dateTime@value")=3121001.1336
 S G("results","procedures",6,"procedure","facility@code")=195966
 S G("results","procedures",6,"procedure","facility@name")=" HOSPITAL"
 S G("results","procedures",6,"procedure","hasImages@value")=0
 S G("results","procedures",6,"procedure","id@value")="6878998.8663-1"
 S G("results","procedures",6,"procedure","imagingType@code")="RAD"
 S G("results","procedures",6,"procedure","imagingType@name")="GENERAL RADIOLOGY"
 S G("results","procedures",6,"procedure","location@code")=128
 S G("results","procedures",6,"procedure","location@name")=" HOSP RADIOLOGY"
 S G("results","procedures",6,"procedure","name@value")="Unknown"
 S G("results","procedures",7,"procedure","case@value")=2
 S G("results","procedures",7,"procedure","category@value")="RA"
 S G("results","procedures",7,"procedure","dateTime@value")=3121001.0815
 S G("results","procedures",7,"procedure","facility@code")=195966
 S G("results","procedures",7,"procedure","facility@name")=" HOSPITAL"
 S G("results","procedures",7,"procedure","hasImages@value")=0
 S G("results","procedures",7,"procedure","id@value")="6878998.9184-1"
 S G("results","procedures",7,"procedure","imagingType@code")="RAD"
 S G("results","procedures",7,"procedure","imagingType@name")="GENERAL RADIOLOGY"
 S G("results","procedures",7,"procedure","location@code")=128
 S G("results","procedures",7,"procedure","location@name")=" HOSP RADIOLOGY"
 S G("results","procedures",7,"procedure","name@value")="Unknown"
 S G("results","procedures@total")=7
 S G("results@timeZone")="-0800"
 S G("results@version")=1.1
 Q
 ;
