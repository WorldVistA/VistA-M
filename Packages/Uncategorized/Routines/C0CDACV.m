C0CDACV ; GPL - Patient Portal - CCDA Routines ;09/17/13  17:05
 ;;0.1;C0CDA;nopatch;noreleasedate;Build 1
 ;
 ; License AGPL v3.0
 ; 
 ; This software was funded in part by Oroville Hospital, and was
 ; created with help from Oroville's doctors and staff.
 Q
 ;
ENC(BLIST,DFN,CCDAWRK,CCDARPT,CCDACTRL) ;
 ;
 N CCDAV,CCDAV1,PARMS,HAVDTS
 I $D(@CCDACTRL@("PARMS")) M PARMS=@CCDACTRL@("PARMS")
 S HAVDTS=0
 I $D(PARMS("startDateTime")) S HAVDTS=1
 N STRT,STOP
 S STRT=$G(PARMS("startDateTime"))
 S STOP=$G(PARMS("endDateTime"))
 S @CCDARPT@("STATUS")="EXTRACTING"
 S @CCDARPT@("EXTRACT-BEGIN")=$$NOW^XLFDT
 D GETPAT^C0CDACE(.CCDAV1,DFN,"visits",STRT,STOP)
 I '$D(CCDAV1) Q  ;
 I CCDAV1("results","visits@total")=0 Q  ;
 I CCDAV1("results","visits@total")=1 D  ;
 . M CCDAV(1)=CCDAV1("results","visits")
 E  M CCDAV=CCDAV1("results","visits")
 S @CCDARPT@("EXTRACT-ENDS")=$$NOW^XLFDT
 ;
 ; encounters section html
 ;
 N C0HTML,C0ARY
 S C0ARY("TITLE")="Encounters"
 S C0ARY("HEADER",1)="Encounter"
 S C0ARY("HEADER",2)="Performer"
 S C0ARY("HEADER",3)="Location"
 S C0ARY("HEADER",4)="Date"
 ;
 N C0N S C0N=0 ; output array counter
 N C0I S C0I=0
 F  S C0I=$O(CCDAV(C0I)) Q:+C0I=0  D  ;
 . N C0DATE S C0DATE=$G(CCDAV(C0I,"visit","dateTime@value"))
 . Q:$$SKIP(C0DATE,.PARMS)
 . Q:$G(CCDAV(C0I,"visit","providers","provider@name"))=""
 . S CCDAV(C0I,"visit","uri")="uri_9000010-"_$G(CCDAV(C0I,"visit","id@value"))
 . N ENCURI S ENCURI=$G(PARMS("ENCOUNTER"))
 . I ENCURI'="" I CCDAV(C0I,"visit","uri")'=ENCURI Q  ;
 . Q:$$REDACT(CCDAV(C0I,"visit","uri"),.PARMS)
 . ; exclusion section - astro gpl
 . I $G(CCDAV(C0I,"visit","reason@narrative"))="Tobacco use" Q  ;
 . I $G(CCDAV(C0I,"visit","type@code"))=99238 Q  ;
 . I $G(CCDAV(C0I,"visit","reason@narrative"))="Chronic" Q  ;
 . ; end exclusions
 . S C0N=C0N+1
 . I C0DATE'="" S C0ARY(C0N,4)=$$HTMLDT^C0CDACU(C0DATE) ; visit date
 . E  S C0ARY(C0N,4)=""
 . ; astro gpl
 . N REASON,REASONCD
 . I $G(CCDAV(C0I,"visit","reason@narrative"))'="" D  ; possible encounter diagnosis
 . . S REASON=$G(CCDAV(C0I,"visit","reason@narrative"))
 . . S REASONCD=""
 . . I REASON["SCT" D  ;
 . . . S REASONCD=$P($P(REASON,"SCT ",2),")",1)
 . . . S CCDAV(C0I,"visit","reason@code")=REASONCD
 . S C0ARY(C0N,1)=$G(CCDAV(C0I,"visit","reason@narrative"))_" "_$G(CCDAV(C0I,"visit","reason@code")) ; reason for visit
 . I C0ARY(C0N,1)=" " S C0ARY(C0N,1)=$G(CCDAV(C0I,"visit","type@name"))_" "_$G(CCDAV(C0I,"visit","type@code"))
 . N VISITXT S VISITXT=$$CHARCHK^MXMLBLD(C0ARY(C0N,1))
 . S C0ARY(C0N,1)=VISITXT
 . S C0ARY(C0N,1,"ID")=$G(CCDAV(C0I,"visit","uri"))
 . S C0ARY(C0N,2)=$G(CCDAV(C0I,"visit","providers","provider@name"))
 . I C0ARY(C0N,2)="" S C0ARY(C0N,2)=$G(CCDAV(C0I,"visit","providers",1,"provider@name"))
 . S C0ARY(C0N,3)=$G(CCDAV(C0I,"visit","location@value"))_" "_$G(CCDAV(C0I,"visit","facility@name"))
 ;
 I +$O(C0ARY("AAAAA"),-1)=0 Q  ; all encounters have been redacted
 ;
 ;
 ; the encounters section component
 ;
 N ESECT S ESECT=$NA(@CCDAWRK@("ENCSECT"))
 D GET^C0CDACU(ESECT,"TENCSEC^C0CDACV")
 D QUEUE^MXMLTMPL(BLIST,ESECT,1,@ESECT@(0))
 ;
 ; encounters html digest generation
 ;
 N EHTML S EHTML=$NA(@CCDAWRK@("ENCHTML"))
 D GENHTML^C0CDACU(EHTML,"C0ARY")
 ;B
 D QUEUE^MXMLTMPL(BLIST,EHTML,1,@EHTML@(0))
 ;
 ; encounter xml generation
 ;
 N WRK
 S C0N=0
 N C0I S C0I=0
 F  S C0I=$O(CCDAV(C0I)) Q:+C0I=0  D  ;
 . K C0ARY
 . M C0ARY=CCDAV(C0I,"visit")
 . Q:$G(CCDAV(C0I,"visit","providers","provider@name"))=""
 . ; exclusion section - astro gpl
 . I $G(CCDAV(C0I,"visit","reason@narrative"))="Tobacco use" Q  ;
 . I $G(CCDAV(C0I,"visit","type@code"))=99238 Q  ;
 . I $G(CCDAV(C0I,"visit","reason@narrative"))="Chronic" Q  ;
 . ; end exclusions
 . S C0ARY("encounterGuid")=$$UUID^C0CDACU() ; random
 . N C0DATE S C0DATE=$G(CCDAV(C0I,"visit","dateTime@value"))
 . I C0DATE'="" S C0ARY("effectiveTime")=$$FMDTOUTC^C0CDACU(C0DATE) ; date
 . E  S C0ARY("effectiveTime")="UNK"
 . N OK,G2 S OK=$$GETMAP^C0CDACM(.G2,"getLocationCode",$G(C0ARY("patientClass@value")))
 . I 'OK D  ;
 . . S C0ARY("locationLoincCode")="1141-1"
 . . S C0ARY("locationLoincName")="Provider's office"
 . E  D  ;
 . . S C0ARY("locationLoincCode")=$G(G2("code"))
 . . S C0ARY("locationLoincName")=$G(G2("text"))
 . N ENCURI S ENCURI=$G(PARMS("ENCOUNTER"))
 . I ENCURI'="" I CCDAV(C0I,"visit","uri")'=ENCURI Q  ;
 . Q:$$SKIP(C0DATE,.PARMS)
 . I $$REDACT(CCDAV(C0I,"visit","uri"),.PARMS) D  Q  ;
 . . W !,"REDACTING ",$G(CCDAV(C0I,"visit","uri"))
 . S C0ARY("uri")=$G(CCDAV(C0I,"visit","uri"))
 . S C0N=C0N+1
 . D SETORGV^C0CDAC2(.C0ARY) ; set organization variables
 . ;
 . ; beginning of encounter
 . S WRK=$NA(@CCDAWRK@("ENC",C0N))
 . D GETNMAP^C0CDACU(WRK,"TENC^C0CDACV","C0ARY")
 . D QUEUE^MXMLTMPL(BLIST,WRK,1,@WRK@(0))
 . ;
 . ;
 . ; add findings and diagnosis here
 . ;
 . ; begin encounter diagnosis
 . ;
 . I $G(CCDAV(C0I,"visit","reason@code"))'="" D  ;
 . . S C0ARY("reasonCode")=CCDAV(C0I,"visit","reason@code")
 . . S C0ARY("reasonName")=$G(CCDAV(C0I,"visit","reason@narrative"))
 . . S WRK=$NA(@CCDAWRK@("ENCDIAG",C0N))
 . . D GETNMAP^C0CDACU(WRK,"TENCDIAG^C0CDACV","C0ARY")
 . . D QUEUE^MXMLTMPL(BLIST,WRK,1,@WRK@(0))
 . N REASON S REASON=$G(CCDAV(C0I,"visit","reason@narrative"))
 . I REASON["SNOMED" D  ;
 . . S C0ARY("reasonCode")=$P($P(REASON,"SNOMED CT ",2),")",1)
 . . S C0ARY("reasonName")=REASON
 . . S WRK=$NA(@CCDAWRK@("ENCDIAG",C0N))
 . . D GETNMAP^C0CDACU(WRK,"TENCDIAG^C0CDACV","C0ARY")
 . . D QUEUE^MXMLTMPL(BLIST,WRK,1,@WRK@(0))
 . ;
 . ; end encounter diagnosis
 . ;
 . ; end of encounter
 . S WRK=$NA(@CCDAWRK@("ENCEND",C0N))
 . D GETNMAP^C0CDACU(WRK,"TENCEND^C0CDACV","C0ARY")
 . D QUEUE^MXMLTMPL(BLIST,WRK,1,@WRK@(0))
 ; 
 ; encounter section ending
 ;
 N ENCEND S ENCEND=$NA(@CCDAWRK@("ENCEND"))
 D GET^C0CDACU(ENCEND,"TENCSEND^C0CDACV")
 D QUEUE^MXMLTMPL(BLIST,ENCEND,1,@ENCEND@(0))
 ;
 S @CCDARPT@("STATUS")="COMPLETE"
 Q
 ;
VAOID() ; Oid for VA coding system
 Q "2.16.840.1.113883.6.229"
 ;
RXNOID() ; RxNorm OID
 Q "2.16.840.1.113883.6.88"
 ;
REDACT(URI,PARMS) ; extrinsic returns true if the parms say to skip this URI
 I URI="" Q 0
 N X,Y S X=URI
 X ^%ZOSF("UPPERCASE")
 I $G(PARMS("REDACT",Y)) D  Q 1
 . D:C0LOG OUTLOG^C0CDACU("REDACTING "_URI)
 . W:$G(C0DEBUG) !,"REDACTING"_URI
 I $D(PARMS("redact",URI)) D  Q 1
 . D:C0LOG OUTLOG^C0CDACU("REDACTING "_URI)
 . W:$G(C0DEBUG) !,"REDACTING"_URI
 Q 0
 ;
SKIP(DATE,PARMS) ; extrinsic returns true if the parms say to skip this entry
 N SKIP S SKIP=0
 I $G(PARMS("startDateTime"))="" Q SKIP
 I DATE<PARMS("startDateTime") S SKIP=1 D OUTLOG^C0CDACU(DATE_" < "_PARMS("startDateTime"))
 ;I DATE>=PARMS("endDateTime") S SKIP=1 D OUTLOG^C0CDACU(DATE_" >= "_PARMS("endDateTime"))
 I DATE>PARMS("endDateTime") S SKIP=1 D OUTLOG^C0CDACU(DATE_" > "_PARMS("endDateTime"))
 I SKIP=0 D OUTLOG^C0CDACU(DATE_" in range")
 Q SKIP
 ;
TENCSEC ;
 ;;<component>
 ;;<section>
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.22.1"/>
 ;;<!-- Encounters Section - required entries -->
 ;;<code code="46240-8" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="History of encounters"/>
 Q
 ;
VISITS(RTN,DFN) ; returns an array of encounters
 K RTN
 N CCDAV,CCDAV1
 D GETPAT^C0CDACE(.CCDAV1,DFN,"visits;cpt")
 I '$D(CCDAV1) Q  ;
 I CCDAV1("results","visits@total")=0 Q  ;
 I CCDAV1("results","visits@total")=1 D  ;
 . M CCDAV(1)=CCDAV1("results","visits")
 E  M CCDAV=CCDAV1("results","visits")
 D ADDSTDC(.CCDAV,DFN)
 M RTN=CCDAV
 Q
 N C0I S C0I=0
 F  S C0I=$O(CCDAV(C0I)) Q:+C0I=0  D  ;
 . S RTN(C0I,"uri")="uri_9000010-"_$G(CCDAV(C0I,"visit","id@value"))
 . S RTN("URI",RTN(C0I,"uri"),C0I)=""
 . S RTN(C0I,"date")=$G(CCDAV(C0I,"visit","dateTime@value"))
 . S RTN(C0I,"arrivalDate")=$G(CCDAV(C0I,"visit","arrivalDateTime@value"))
 . N DEPDATE ; departure date
 . S DEPDATE=$G(CCDAV(C0I,"visit","departureDateTime@value"))
 . S RTN(C0I,"departureDate")=DEPDATE
 . S RTN(C0I,"startDateTime")=RTN(C0I,"date")
 . S RTN("DATE",RTN(C0I,"date"),C0I)=""
 . I DEPDATE'="" D  ;
 . . S RTN(C0I,"endDateTime")=DEPDATE
 . E  D  ;
 . . I C0I=1 S RTN(C0I,"endDateTime")=$$NOW^XLFDT Q  ; 
 . . S RTN(C0I,"endDateTime")=RTN(C0I-1,"date")
 . S RTN(C0I,"typeCode")=$G(CCDAV(C0I,"visit","type@code"))
 . S RTN(C0I,"typeName")=$G(CCDAV(C0I,"visit","type@name"))
 . N VTYPE
 . S VTYPE=$G(CCDAV(C0I,"visit","patientClass@value"))
 . I VTYPE="" S VTYPE=$G(CCDAV(C0I,"visit","serviceCategory@code"))
 . I VTYPE="" S VTYPE=$G(CCDAV(C0I,"visit","type@name"))
 . S RTN(C0I,"visitType")=$S(VTYPE="A":"outpatient",VTYPE="I":"inpatient",VTYPE="H":"inpatient",VTYPE="AMB":"outpatient",VTYPE="IMP":"inpatient",VTYPE="HOSPITALIZATION":"inpatient",1:"outpatient")
 . S RTN(C0I,"location")=$G(CCDAV(C0I,"visit","location@value"))
 . S RTN(C0I,"reasonCode")=$G(CCDAV(C0I,"visit","reason@code"))
 . S RTN(C0I,"reasonName")=$G(CCDAV(C0I,"visit","reason@name"))
 Q
 ;
VIEWV(DFN,IN) ;
 N G
 I $D(IN) M G=IN
 E  D VISITS(.G,DFN)
 N GCNT S GCNT=$O(G("AAAAA"),-1)
 N GI S GI=0
 W !,"DATE  ","TYPE    ","    LOCATION","   REASON"
 F  S GI=$O(G(GI)) Q:+GI=0  D  ;
 . N GARR,GDIS
 . S GARR=$G(G(GI,"arrivalDate")) I GARR'="" S GARR=$E($$HTMLDT^C0CDACU(GARR),1,11)
 . S GDIS=$G(G(GI,"departureDate")) I GDIS'="" S GDIS=$E($$HTMLDT^C0CDACU(GDIS),1,11)
 . W !,GI," ",$$HTMLDT^C0CDACU(G(GI,"date"))," ",GARR," ",GDIS," ",$G(G(GI,"typeCode"))," ",G(GI,"typeName"),"  ",G(GI,"visitType")," "
 .  ;W !,GI," ",$$HTMLDT^C0CDACU(G(GI,"date"))," ",$G(G(GI,"typeCode")),"  ",G(GI,"visitType")," "
 .  W $G(G(GI,"location")),"  ",G(GI,"reasonCode")
 K DIR
 S DIR(0)="N^1:"_GCNT
 S DIR("B")=1
 S DIR("L")="Please select encounter"
 D ^DIR
 Q:$G(Y)=""
 M IN("PARMS")=G(Y)
 I $G(IN("PARMS","visitType"))="inpatient" D  ;
 . N PTMP M PTMP=IN("PARMS")
 . D EXTENDIP^C0CDAC0(.G,.PTMP,Y)
 . M IN("PARMS")=PTMP 
 W !
 ZWR IN("PARMS",*)
 ;ZWR G(Y,*)
 Q
 ;
VISITIEN(DFN,ADATE) ; extrinsic returns the ien in ^AUPNVSIT for the visit
 N ZRD
 S ZRD=$$RDATE(ADATE)
 Q $O(^AUPNVSIT("AA",DFN,ZRD,""))
 ;
GETVISIT(ZRTN,DFN,ADATE)
 N VIEN
 S VIEN=$$VISITIEN(DFN,ADATE)
 Q:VIEN=""
 D FMX^KBAIQLD4(ZRTN,9000010,VIEN)
 Q
 ;
VCPTIEN(DFN,ADATE) ; extrinsic returns the ien of the V CPT record
 N VIEN
 S VIEN=$$VISITIEN(DFN,ADATE)
 Q:VIEN="" VIEN
 Q $O(^AUPNVCPT("AD",VIEN,""))
 ;
GETVCPT(ZRTN,DFN,ADATE) ; get the FMX external format of the V CPT record for a visit
 N VCPTIEN
 S VCPTIEN=$$VCPTIEN(DFN,ADATE)
 Q:VCPTIEN=""
 D FMX^KBAIQLD4(ZRTN,9000010.18,VCPTIEN)
 Q
 ;
STDCIEN(DFN,ADATE,VIEN) ; extrinsic returns ien in V STANDARD CODES file for visit at DFN,ADATE
 I '$D(VIEN) S VIEN=$$VISITIEN(DFN,ADATE)
 Q:VIEN="" VIEN
 Q $O(^AUPNVSC("AD",VIEN,""))
 Q
GETSTDC(ZRTN,DFN,ADATE,VIEN) ; returns the FMX array of the V STANDARD CODES file for visit at DFN,ADATE
 N SCIEN
 S SCIEN=$$STDCIEN(DFN,$G(ADATE),$G(VIEN))
 Q:SCIEN=""
 D FMX^KBAIQLD4(ZRTN,9000010.71,SCIEN)
 Q
 ;
ADDSTDC(ZARY,DFN) ; ZARY is passed by reference. stanard codes if any are added to the visit array
 I '$D(^AUPNVSC) Q  ; standard codes file not installed
 I '$D(ZARY) Q  ; nothing in the array
 N C0CVST S C0CVST=0
 F  S C0CVST=$O(ZARY(C0CVST)) Q:+C0CVST=0  D  ; for each visit
 . N C0CVDT,C0CSCARY,C0CVIEN
 . S C0CVIEN=$G(ZARY(C0CVST,"visit","id@value")) ; ien of the visit
 . ;S C0CVDT=$G(ZARY(C0CVST,"visit","dataTime@value"))
 . ;Q:'C0CVDT
 . D GETSTDC("C0CSCARY",DFN,,C0CVIEN)
 . Q:'$D(C0CSCARY)
 . M ZARY(C0CVST,"visit","stdc")=C0CSCARY("V_STANDARD_CODES")
 Q
 ;
RDATE(ADATE) ; extrinsic which returns the reverse index value for a data in FM format
 N Z1,Z2,Z3
 S Z1=$P(ADATE,".",1)
 S Z2=$P(ADATE,".",2)
 S Z3=9999999-Z1
 S Z3=Z3_"."_Z2 ; date lookup value
 Q Z3
 ;
TESTONE ; 
 S DFN=$$PAT^C0CDAC0()
 N GARY
 ; FILTER1 shows all active meds and all inactive meds in the encounter time window
 D VISITS^C0CDACV(.GARY,DFN)
 S GARY("PARMS","MEDS")="FILTER1" ; options are ALL ACTIVE and FILTER1
 S GARY("PARMS","INCLUDEPREVIOUSERVISIT")=1 ; trying this for a default
 D VIEWV^C0CDACV(DFN,.GARY)
 ;S GARY("PARMS","meds")="FILTER1" ; options are ALL ACTIVE and FILTER1
 ;S GARY("PARMS","INCLUDEPREVIOUSERVISIT")=1 ; trying this for a default
 N PRMS
 M PRMS=GARY("PARMS")
 D CCDARPC^C0CDAC0(.CCDA,DFN,.PRMS)
 N ZTYPE S ZTYPE=PRMS("visitType")
 ;D BROWSE^DDBR(CCDA,"N","PATIENT "_DFN_" "_ZTYPE)
 W $$OUTCCDA^C0CDAC0(CCDA)
 N GN S GN=""
 K @GN,^TMP("MXMLDOM",$J),^TMP("VPR",$J),^TMP("CCDA",$J),GN
 Q
 ;
TENC ; beginning of encounter
 ;;<entry typeCode="DRIV">
 ;;<encounter classCode="ENC" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.49"/>
 ;;<!-- Encounter Activities -->
 ;;<!--********Encounteractivitytemplate********-->
 ;;<id root="@@encounterGuid@@"/>
 ;;<code code="@@type@code@@" displayName="@@type@name@@" codeSystemName="CPT" codeSystem="2.16.140.1.113883.6.12" codeSystemVersion="4">
 ;;<originalText>@@type@name@@<reference value="#@@uri@@"/>
 ;;</originalText>
 ;;</code>
 ;;<effectiveTime value="@@effectiveTime@@"/>
 ;;<performer>
 ;;<assignedEntity>
 ;;<id root="@@encounterGuid@@"/>
 ;;<code code="59058001" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT" displayName="General Physician"/>
 ;;</assignedEntity>
 ;;</performer>
 ;;<participant typeCode="LOC">
 ;;<participantRole classCode="SDLOC">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.32"/>
 ;;<!-- Service Delivery Location template -->
 ;;<code code="@@locationLoincCode@@" codeSystem="2.16.840.1.113883.6.259" codeSystemName="HealthcareServiceLocation" displayName="@@locationLoincName@@"/>
 ;;<addr>
 ;;<streetAddressLine>@@orgAddr@@</streetAddressLine>
 ;;<city>@@orgCity@@</city>
 ;;<state>@@orgState@@</state>
 ;;<postalCode>@@orgZip@@</postalCode>
 ;;<country>US</country>
 ;;</addr>
 ;;<telecom use="WP" value="@@orgTelephone@@"></telecom>
 ;;<playingEntity classCode="PLC">
 ;;<name>@@orgName@@</name>
 ;;</playingEntity>
 ;;</participantRole>
 ;;</participant>
 Q
 ;
TENCFND ; encounter finding
 ;;<entryRelationship typeCode="RSON">
 ;;<observation classCode="OBS" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.19"/>
 ;;<id root="db734647-fc99-424c-a864-7e3cda82e703" extension="45665"/>
 ;;<code code="404684003" displayName="Finding" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT"/>
 ;;<statusCode code="completed"/>
 ;;<effectiveTime>
 ;;<low value="20120806"/>
 ;;</effectiveTime>
 ;;<value xsi:type="CD" code="233604007" displayName="Pneumonia" codeSystem="2.16.840.1.113883.6.96"/>
 ;;</observation>
 ;;</entryRelationship>
 Q
 ;
TENCDIAG ; encounter diagnosis
 ;;<entryRelationship typeCode="SUBJ" inversionInd="false">
 ;;<act classCode="ACT" moodCode="EVN">
 ;;<!--Encounter diagnosis act -->
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.80"/>
 ;;<id root="5a784260-6856-4f38-9638-80c751aff2fb"/>
 ;;<code xsi:type="CE" code="29308-4" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="ENCOUNTER DIAGNOSIS"/>
 ;;<statusCode code="active"/>
 ;;<effectiveTime>
 ;;<low value="@@effectiveTime@@"/>
 ;;</effectiveTime>
 ;;<entryRelationship typeCode="SUBJ" inversionInd="false">
 ;;<observation classCode="OBS" moodCode="EVN" negationInd="false">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.4"/>
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.4" extension="2015-08-01"/>
 ;;<!-- Problem Observation -->
 ;;<id root="ab1791b0-5c71-11db-b0de-0800200c9a66"/>
 ;;<code code="409586006" codeSystem="2.16.840.1.113883.6.96" displayName="Complaint">
 ;;<translation code="75326-9" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Problem"/>
 ;;</code>
 ;;<statusCode code="completed"/>
 ;;<effectiveTime>
 ;;<low value="@@effectiveTime@@"/>
 ;;</effectiveTime>
 ;;<value xsi:type="CD" code="@@reasonCode@@" codeSystem="2.16.840.1.113883.6.96" displayName="@@reasonName@@"/>
 ;;</observation>
 ;;</entryRelationship>
 ;;</act>
 ;;</entryRelationship>
 Q
 ;
TENCEND ; end of one encounter
 ;;</encounter>
 ;;</entry>
 Q
 ;
TENCSEND ; end of section
 ;;</section>
 ;;</component>
 Q
 ;
