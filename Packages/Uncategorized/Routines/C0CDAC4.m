C0CDAC4 ; GPL - Patient Portal - CCDA Routines ;09/23/13  17:05
 ;;0.1;C0CDA;nopatch;noreleasedate;Build 1
 ;
 ; License AGPL v3.0
 ; 
 ; This software was funded in part by Oroville Hospital, and was
 ; created with help from Oroville's doctors and staff.
 ;
 Q
 ;
MEDS(BLIST,DFN,CCDAWRK,CCDARPT,CCDACTRL) ;
 ;
 N CCDAV,CCDAV1,PARMS,HAVDTS,MEDMODE
 I $D(@CCDACTRL@("PARMS")) M PARMS=@CCDACTRL@("PARMS")
 S MEDMODE=$G(PARMS("MEDS")) ; ALL, ACTIVE, or FILTER1
 ; FILTER1 shows all active meds and all inactive in the time range
 ; astro gpl
 I MEDMODE="" D  ;
 . S MEDMODE="ACTIVE"
 . S PARMS("MEDS")="ACTIVE"
 ; end astro
 S HAVDTS=0
 I $D(PARMS("startDateTime")) S HAVDTS=1
 S @CCDARPT@("STATUS")="EXTRACTING"
 S @CCDARPT@("EXTRACT-BEGIN")=$$NOW^XLFDT
 D GETPAT^C0CDACE(.CCDAV1,DFN,"meds")
 ;M CCDAV=CCDAV1("results","meds")
 I '$D(CCDAV1) Q  ;
 I CCDAV1("results","meds@total")=0 D  Q  ;
 . N MSECT S MSECT=$NA(@CCDAWRK@("MEDSECTION"))
 . D GET^C0CDACU(MSECT,"TNOMEDS^C0CDAC4")
 . D QUEUE^MXMLTMPL(BLIST,MSECT,1,@MSECT@(0))
 I CCDAV1("results","meds@total")=1 D  ;
 . M CCDAV(1)=CCDAV1("results","meds")
 E  M CCDAV=CCDAV1("results","meds")
 ;b
 S @CCDARPT@("EXTRACT-ENDS")=$$NOW^XLFDT
 ;
 ; medication section html
 ;
 N C0HTML,C0ARY
 S C0ARY("TITLE")="Medications"
 S C0ARY("HEADER",1)="Date"
 S C0ARY("HEADER",2)="Medication"
 ;S C0ARY("HEADER",3)="Dose"
 ;S C0ARY("HEADER",4)="Form"
 ;S C0ARY("HEADER",5)="Route"
 ;S C0ARY("HEADER",6)="Frequency"
 S C0ARY("HEADER",7)="Directions"
 ;S C0ARY("HEADER",8)="Comments"
 S C0ARY("HEADER",8)="Status"
 S C0ARY("HEADER",9)="Source"
 ;
 N C0IURIS S C0IURIS="" ; array to hold URIs to avoid duplicates
 N C0I S C0I="AAAAA"
 N C0N S C0N=0
 F  S C0I=$O(CCDAV(C0I),-1) Q:+C0I=0  D  ;
 . N C0DATE S C0DATE=$G(CCDAV(C0I,"med","start@value"))
 . I C0DATE="" S C0DATE=$G(CCDAV(C0I,"med","ordered@value"))
 . N GGID S GGID="uri_55-"_DFN_"_"_$G(CCDAV(C0I,"med","medID@value"))
 . S GGID=$TR(GGID,";","-")
 . I $D(C0IURIS(GGID)) D  ; duplicate URI detected
 . . S GGID=GGID_"-"_$G(CCDAV(C0I,"med","id@value"))
 . S C0IURIS(GGID)="" ; put the URI in the array
 . S CCDAV(C0I,"med","uri")=GGID
 . Q:$$REDACT^C0CDACV(CCDAV(C0I,"med","uri"),.PARMS)
 . Q:$$MEDSKIP(.PARMS,C0DATE,$NA(CCDAV(C0I)))
 . S C0N=C0N+1
 . I C0DATE'="" S C0ARY(C0N,1)=$$HTMLDT^C0CDACU(C0DATE) ; start date
 . E  S C0ARY(C0N,1)="" ; no start date
 . S C0ARY(C0N,1,"ID")=$G(CCDAV(C0I,"med","uri"))
 . N VUID
 . S VUID=$G(CCDAV(C0I,"med","products","product","vaProduct@vuid"))
 . I VUID="" S VUID=$G(CCDAV(C0I,"med","products",1,"product","vaProduct@vuid"))
 . ; find Rxnorm code here
 . I '$D(CCDAV(C0I,"med","RxNormCode@value")) D  ;
 . . S CCDAV(C0I,"med","RxNormCode@value")=$P($$RXNORM(VUID),"^",1)
 . . I CCDAV(C0I,"med","RxNormCode@value")="" S CCDAV(C0I,"med","RxNormCode@value")="UNK"
 . I +CCDAV(C0I,"med","RxNormCode@value")'=0 D  ; if we have an RxNorm number, map it
 . . N RXNMAP S RXNMAP=$$MAP^KBAIQLDM(+CCDAV(C0I,"med","RxNormCode@value"),"preferedRxnorm")
 . . I RXNMAP'="" S CCDAV(C0I,"med","RxNormCode@value")=RXNMAP
 . I CCDAV(C0I,"med","vaType@value")="N" D  ; non-VA med
 . . I CCDAV(C0I,"med","sig")["|" D  ;
 . . . S CCDAV(C0I,"med","name@value")=$P(CCDAV(C0I,"med","sig"),"|",1) ;eRx
 . . . S CCDAV(C0I,"med","name@value")=$$SYMENC^MXMLUTL(CCDAV(C0I,"med","name@value")) ; xml safe
 . . . S CCDAV(C0I,"med","sig")=$$SYMENC^MXMLUTL($P(CCDAV(C0I,"med","sig"),"|",2)) ;eRx
 . . I $G(CCDAV(C0I,"med","doses","dose@units"))["|" D  ; eRx doses
 . . . S CCDAV(C0I,"med","doses","dose@dose")=$P(CCDAV(C0I,"med","doses","dose@units"),"|",2)
 . S C0ARY(C0N,2)=$$SYMENC^MXMLUTL(CCDAV(C0I,"med","name@value")) ; med name
 . I $G(CCDAV(C0I,"med","RxNormCode@value"))'="" D  ;
 . . S C0ARY(C0N,2)=C0ARY(C0N,2)_" (RxNorm: "_CCDAV(C0I,"med","RxNormCode@value")_")"
 . ;S C0ARY(C0N,3)=$G(CCDAV(C0I,"med","doses","dose@dose"))_" "_$G(CCDAV(C0I,"med","doses","dose@units")) ; dose
 . ;I C0ARY(C0N,3)'="" S C0ARY(C0N,3)=$$SYMENC^MXMLUTL(C0ARY(C0N,3))
 . ;I C0ARY(C0N,3)=0 S C0ARY(C0N,3)="" ; surpress zero dose
 . ;I C0ARY(C0N,3)="0 " S C0ARY(C0N,3)="" ; surpress zero dose
 . ;S C0ARY(C0N,4)=$G(CCDAV(C0I,"med","form@value")) ; form
 . ;I CCDAV(C0I,"med","vaType@value")="V" D  ; IV 
 . . ;S C0ARY(C0N,3)=$G(CCDAV(C0I,"med","rate@value")) ; dose
 . . ;S C0ARY(C0N,4)="IV" ; form
 . ;S C0ARY(C0N,5)=$G(CCDAV(C0I,"med","doses","dose@route")) ; route
 . ;S C0ARY(C0N,6)=$G(CCDAV(C0I,"med","doses","dose@schedule")) ; frequency
 . S C0ARY(C0N,7)=$$SYMENC^MXMLUTL($G(CCDAV(C0I,"med","sig"))) ; directions
 . ;S C0ARY(C0N,8)=" " ; comments
 . S C0ARY(C0N,8)=CCDAV(C0I,"med","status@value") ; med status
 . S C0ARY(C0N,9)=$G(CCDAV(C0I,"med","currentProvider@name")) ; med source
 . I C0ARY(C0N,9)="" S C0ARY(C0N,9)=$G(CCDAV(C0I,"med","orderingProvider@name"))
 . I C0ARY(C0N,9)="" D  ;
 . . N ZDUZ S ZDUZ=$G(CCDAV(C0I,"med","orderingProvider@value"))
 . . I ZDUZ'="" S C0ARY(C0N,9)=$P($G(^VA(200,ZDUZ,0)),U,1)
 ;
 I +$O(C0ARY("AAAAA"),-1)=0 D  Q  ; all meds have been redacted
 . N MSECT S MSECT=$NA(@CCDAWRK@("MEDSECTION"))
 . D GET^C0CDACU(MSECT,"TNOMEDS^C0CDAC4")
 . D QUEUE^MXMLTMPL(BLIST,MSECT,1,@MSECT@(0))
 ;
 ; the medication section component
 ;
 N MSECT S MSECT=$NA(@CCDAWRK@("MEDSECTION"))
 D GET^C0CDACU(MSECT,"TMEDSEC^C0CDAC4")
 D QUEUE^MXMLTMPL(BLIST,MSECT,1,@MSECT@(0))
 ;
 ; generate the html
 ;
 N MHTML S MHTML=$NA(@CCDAWRK@("MEDHTML"))
 D GENHTML^C0CDACU(MHTML,"C0ARY")
 D QUEUE^MXMLTMPL(BLIST,MHTML,1,@MHTML@(0))
 ;
 ; medication xml generation
 ;
 N WRK
 S C0I="AAAA"
 F  S C0I=$O(CCDAV(C0I),-1) Q:+C0I=0  D  ;
 . K C0ARY
 . M C0ARY=CCDAV(C0I,"med")
 . I $$REDACT^C0CDACV(CCDAV(C0I,"med","uri"),.PARMS) Q  ;
 . S C0ARY("medName")=CCDAV(C0I,"med","name@value")
 . S C0ARY("medID")="#"_$G(CCDAV(C0I,"med","uri"))
 . S C0ARY("guid")=$$UUID^C0CDACU() ; random guid
 . I $G(CCDAV(C0I,"med","status@value"))="active" D  ;
 . . S C0ARY("statusCode")="55561003"
 . . S C0ARY("statusName")="Active"
 . I $G(CCDAV(C0I,"med","vaStatus@value"))="PENDING" D  ;
 . . S C0ARY("statusCode")="421139008"
 . . S C0ARY("statusName")="On Hold"
 . I $G(CCDAV(C0I,"med","vaStatus@value"))="historical" D  ;
 . . S C0ARY("statusCode")="392521001"
 . . S C0ARY("statusName")="Prior History"
 . I $G(C0ARY("statusCode"))=""  D  ; 
 . . ; includes $G(CCDAV(C0I,"med","status@value"))="not active" D  ;
 . . S C0ARY("statusCode")="73425007"
 . . S C0ARY("statusName")="Not Active"
 . N C0DATE S C0DATE=$G(CCDAV(C0I,"med","start@value"))
 . I C0DATE="" S C0DATE=$G(CCDAV(C0I,"med","ordered@value"))
 . Q:$$MEDSKIP(.PARMS,C0DATE,$NA(CCDAV(C0I)))
 . S C0ARY("RxNormCode@value")=$G(CCDAV(C0I,"med","RxNormCode@value"))
 . S C0ARY("timeLow")=$$FMDTOUTC^C0CDACU(C0DATE) ; med date
 . S C0ARY("medProvider")=$G(CCDAV(C0I,"med","orderingProvider@name"),"UNK")
 . S WRK=$NA(@CCDAWRK@("MED",C0I))
 . I $G(CCDAV(C0I,"med","vaType@value"))="V" D  ; 
 . . D GETNMAP^C0CDACU(WRK,"TMEDIV^C0CDAC4","C0ARY")
 . D GETNMAP^C0CDACU(WRK,"TMED^C0CDAC4","C0ARY")
 . D QUEUE^MXMLTMPL(BLIST,WRK,1,@WRK@(0))
 ;
 ; medication section ending
 ;
 N MEDEND S MEDEND=$NA(@CCDAWRK@("MEDEND"))
 D GET^C0CDACU(MEDEND,"TMEDEND^C0CDAC4")
 D QUEUE^MXMLTMPL(BLIST,MEDEND,1,@MEDEND@(0))
 ;
 Q
 ;
RXNORM(C0VUID) ; extrinsic returns the RxNorm code ^ RxNorm version
 N VUID,RXNIEN,RXNORM,SRCIEN,RXNNAME,RXNVER
 ; 
 ; begin changes for systems that have eRx installed
 ; RxNorm is found in the ^C0P("RXN") global - gpl
 ; It has moved to ^C0CRXN
 ;
 N ZC,ZCD,ZCDS,ZCDSV ; CODE,CODE SYSTEM,CODE VERSION
 S (ZC,ZCD,ZCDS,ZCDSV)="" ; INITIALIZE
 S (RXNORM,RXNNAME,RXNVER)="" ;INITIALIZE
 ;I $D(^C0CRXN) D  Q RXNORM
 ;. ;S RXNORM=$$VUI2RXN^C0CRXNLK(C0VUID,"CD")
 ;. S RXNORM=$$VUI2RXN^C0CRXNLK(C0VUID) ; gpl 9/23/2017 use the older interface here
 ;Q RXNORM
 ;
 I $D(^C0P("RXN")) D  ; 
 . ;S VUID=$$GET1^DIQ(50.68,VAPROD,99.99)
 . S VUID=C0VUID
 . S ZC=$$CODE^C0CUTIL(VUID)
 . S ZCD=$P(ZC,"^",1) ; CODE TO USE
 . S ZCDS=$P(ZC,"^",2) ; CODING SYSTEM - RXNORM OR VUID
 . S ZCDSV=$P(ZC,"^",3) ; CODING SYSTEM VERSION
 . S RXNORM=ZCD ; THE CODE
 . S RXNNAME=ZCDS ; THE CODING SYSTEM
 . S RXNVER=ZCDSV ; THE CODING SYSTEM VERSION
 . ;N ZGMED S ZGMED=@MAP@("MEDPRODUCTNAMETEXT")
 . ;S @MAP@("MEDPRODUCTNAMETEXT")=ZGMED_" "_ZCDS_": "_ZCD
 E  I $D(^C0CRXN) D  ; $Data is for Systems that don't have our RxNorm file yet
 . ;S VUID=$$GET1^DIQ(50.68,VAPROD,99.99)
 . S VUID=C0VUID
 . S RXNIEN=$$FIND1^DIC(176.001,,,VUID,"VUID")
 . S RXNORM=$$GET1^DIQ(176.001,RXNIEN,.01)
 . S SRCIEN=$$FIND1^DIC(176.003,,"B","RXNORM")
 . S RXNNAME=$$GET1^DIQ(176.003,SRCIEN,6)
 . S RXNVER=$$GET1^DIQ(176.003,SRCIEN,7)
 Q RXNORM_"^"_RXNVER_"^"_RXNNAME
 ;
MEDSKIP(PRMS,DTE,CDAV) ; extrinsic which filters meds
 ;B
 I $G(PRMS("MEDS"))="" Q 0 ; no fiters, don't skip
 I @CDAV@("med","status@value")="active" Q 0 ; always show active meds
 I PRMS("MEDS")="ALL" Q 0 ; show all inactive meds
 I PRMS("MEDS")="ACTIVE" Q 1 ; skip inactive meds 
 Q $$SKIP^C0CDACV(DTE,.PRMS) ; filters inactive according to date - FILTER1
 ;
TMEDSEC ;
 ;;<component>
 ;;<section classCode="DOCSECT" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.1.1"></templateId>
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.1.1" extension="2014-06-09"></templateId>
 ;;<code code="10160-0" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="History of medication use"></code>
 Q
 ;
TMED ;
 ;;<entry>
 ;;<substanceAdministration classCode="SBADM" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.16"></templateId>
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.16" extension="2014-06-09"></templateId>
 ;;<id extension="4671088" root="1.3.6.1.4.1.16517"></id>
 ;;<text>
 ;;<reference value="@@medID@@"></reference>
 ;;</text>
 ;;<statusCode code="completed"></statusCode>
 ;;<effectiveTime xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="IVL_TS">
 ;;<low value="@@timeLow@@"></low>
 ;;<high nullFlavor="UNK"></high>
 ;;</effectiveTime>
 ;;<doseQuantity nullFlavor="UNK" />
 ;;<consumable typeCode="CSM">
 ;;<manufacturedProduct classCode="MANU">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.23"></templateId>
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.23" extension="2014-06-09"></templateId>
 ;;<manufacturedMaterial classCode="MMAT" determinerCode="KIND">
 ;;<code code="@@RxNormCode@value@@" codeSystem="2.16.840.1.113883.6.88" displayName="@@medName@@">
 ;;<originalText>
 ;;<reference value="@@medID@@"></reference>
 ;;</originalText>
 ;;</code>
 ;;</manufacturedMaterial>
 ;;</manufacturedProduct>
 ;;</consumable>
 ;;<entryRelationship typeCode="REFR">
 ;;<observation classCode="OBS" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.1.47"></templateId>
 ;;<code code="33999-4" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Status"></code>
 ;;<statusCode code="completed"></statusCode>
 ;;<value code="@@statusCode@@" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED" displayName="@@statusName@@" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="CD"></value>
 ;;</observation>
 ;;</entryRelationship>
 ;;<entryRelationship contextConductionInd="true" typeCode="REFR">
 ;;<observation classCode="OBS" moodCode="EVN">
 ;;<code code="48766-0" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Information source"></code>
 ;;<statusCode code="completed"></statusCode>
 ;;<value xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="ST">@@medProvider@@</value>
 ;;</observation>
 ;;</entryRelationship>
 ;;</substanceAdministration>
 ;;</entry>
 Q
 ;
TMEDIV ; template for IV meds - only one medication
 ;;<entry>
 ;;<substanceAdministration classCode="SBADM" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.16"></templateId>
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.16" extension="2014-06-09"></templateId>
 ;;<id root="@@guid@@"></id>
 ;;<text>
 ;;<reference value="@@medID@@"></reference>
 ;;</text>
 ;;<statusCode code="active"></statusCode>
 ;;<effectiveTime xsi:type="IVL_TS">
 ;;<low value="@@timeLow@@"></low>
 ;;<high value="@@timeHigh@@"></high>
 ;;</effectiveTime>
 ;;<effectiveTime operator="A" xsi:type="EIVL_TS">
 ;;<event code="HS"></event>
 ;;</effectiveTime>
 ;;<routeCode code="C38299" codeSystem="2.16.840.1.113883.3.26.1.1" codeSystemName="NCI Thesaurus" displayName="SUBCUTANEOUS"></routeCode>
 ;;<doseQuantity unit="@@doseUnit@@" value="@@doseQuantity@@"></doseQuantity>
 ;;<administrationUnitCode code="C42945" codeSystem="2.16.840.1.113883.3.26.1.1" codeSystemName="NCI Thesaurus" displayName="INJECTION, SOLUTION"></administrationUnitCode>
 ;;<consumable>
 ;;<manufacturedProduct classCode="MANU">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.23"></templateId>
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.23" extension="2014-06-09"></templateId>
 ;;<manufacturedMaterial>
 ;;<code code="@@RxNormCode@value@@" codeSystem="2.16.840.1.113883.6.88" codeSystemName="RxNorm" displayName="@@medName@@">
 ;;<originalText>
 ;;<reference value="@@medID@@"></reference>
 ;;</originalText>
 ;;</code>
 ;;</manufacturedMaterial>
 ;;</manufacturedProduct>
 ;;</consumable>
 ;;</substanceAdministration>
 ;;</entry>
 Q
 ;
TMEDEND ;
 ;;</section>
 ;;</component>
 Q
 ;
TNOMEDS ;
 ;;<component>
 ;;  <section>
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.1.1"></templateId>
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.1.1" extension="2014-06-09"></templateId>
 ;;    <code code="10160-0" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="History of Medication Use"/>
 ;;    <title>MEDICATIONS</title>
 ;;    <text><content ID="meds1">No Information About Medications</content></text>
 ;;    <entry typeCode="DRIV">
 ;;      <substanceAdministration moodCode="EVN" classCode="SBADM" nullFlavor="NI">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.16"></templateId>
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.16" extension="2014-06-09"></templateId>
 ;;     <id root="2.16.840.1.113883.3.3208.101.10" extension="20130607111500-MedicationActivity"/>
 ;;     <text><reference value="#meds1"/></text>
 ;;     <statusCode code="completed"/>
 ;;     <effectiveTime xsi:type="IVL_TS"><low nullFlavor="NI"/><high nullFlavor="NI"/></effectiveTime>
 ;;     <effectiveTime xsi:type="PIVL_TS" operator="A" nullFlavor="NI"/> <!-- Added to meet the "SHOULD" and avoid the warning from the validator -->
 ;;     <doseQuantity nullFlavor="NI"/> <!-- Added to meet the "SHOULD" and avoid the warning from the validator -->
 ;;     <consumable>
 ;;       <manufacturedProduct classCode="MANU">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.23"></templateId>
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.23" extension="2014-06-09"></templateId>
 ;;         <manufacturedMaterial>
 ;;           <code nullFlavor="NI">
 ;;             <originalText><reference value="#meds1"/></originalText> <!-- I don't this this should need to be present unless you are populating a table with NI-->
 ;;           </code>
 ;;         </manufacturedMaterial>
 ;;       </manufacturedProduct>
 ;;     </consumable>
 ;;      </substanceAdministration>
 ;;    </entry>
 ;;  </section>
 ;;</component>
 Q
 ;
