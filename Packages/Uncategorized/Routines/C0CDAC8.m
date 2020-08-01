C0CDAC8 ; GPL - Patient Portal - CCDA Routines ;09/17/13  17:05
 ;;0.1;JJOHPP;nopatch;noreleasedate;Build 1
 ;
 ; License AGPL v3.0
 ; 
 ; This software was funded in part by Oroville Hospital, and was
 ; created with help from Oroville's doctors and staff.
 Q
 ;
ALLERGY(BLIST,DFN,CCDAWRK,CCDARPT,CCDACTRL) ;
 ;
 N CCDAV,CCDAV1
 S @CCDARPT@("STATUS")="EXTRACTING"
 S @CCDARPT@("EXTRACT-BEGIN")=$$NOW^XLFDT
 D GETPAT^C0CDACE(.CCDAV1,DFN,"allergies")
 I '$D(CCDAV1) Q  ;
 I CCDAV1("results","reactions@total")=0 Q  ;
 I $G(CCDAV1("results","reactions","allergy","assessment@value"))="not done" Q  ;
 I CCDAV1("results","reactions@total")=1 D  ;
 . M CCDAV(1)=CCDAV1("results","reactions")
 E  M CCDAV=CCDAV1("results","reactions")
 S @CCDARPT@("EXTRACT-ENDS")=$$NOW^XLFDT
 ;
 ; allergy section html
 ;
 N C0HTML,C0ARY,NKA
 S NKA=0 ; no known allergy flag
 S C0ARY("TITLE")="Allergies"
 S C0ARY("HEADER",1)="Date"
 S C0ARY("HEADER",2)="Allergies"
 S C0ARY("HEADER",3)="Reaction"
 S C0ARY("HEADER",4)="Severity"
 ;S C0ARY("HEADER",5)="Status"
 S C0ARY("HEADER",6)="Comments"
 S C0ARY("HEADER",7)="Source"
 ;
 I $G(CCDAV1("results","reactions","allergy","assessment@value"))="nka" D  ;
 . S NKA=1
 . S C0ARY(1,1)=""
 . S C0ARY(1,2)="No Know Allergies"
 . S C0ARY(1,3)=""
 . S C0ARY(1,4)=""
 . ;S C0ARY(1,5)=""
 . S C0ARY(1,6)=""
 . S C0ARY(1,7)=$G(CCDAV1("results","reactions","allergy","facility@name"))
 . S CCDAV(1,"allergy","uri")="noallergies"
 E  D  ;
 . N C0N S C0N=0
 . N C0I S C0I=0
 . F  S C0I=$O(CCDAV(C0I)) Q:+C0I=0  D  ;
 . . N C0DATE S C0DATE=$G(CCDAV(C0I,"allergy","entered@value"))
 . . S CCDAV(C0I,"allergy","uri")="uri_120_8-"_$G(CCDAV(C0I,"allergy","id@value"))
 . . Q:$$REDACT^C0CDACV(CCDAV(C0I,"allergy","uri"),.PARMS)
 . . S C0ARY(C0N,1,"uri")=$G(CCDAV(C0I,"allergy","uri"))
 . . S C0N=C0N+1
 . . I C0DATE'="" S C0ARY(C0N,1)=$$HTMLDT^C0CDACU(C0DATE) ; allergy entered date
 . . E  S C0ARY(C0N,1)=""
 . . S C0ARY(C0N,1,"ID")=$G(CCDAV(C0I,"allergy","uri"))
 . . S C0ARY(C0N,2)=$G(CCDAV(C0I,"allergy","name@value")) ; allergy
 . . N VUID,RXN
 . . S VUID=$G(CCDAV(C0I,"allergy","vuid@value"))
 . . I VUID'="" D  ;
 . . . S RXN=$$RXNORM^C0CDAC4(VUID)
 . . . N RXNMAP S RXNMAP=$$MAP^KBAIQLDM(+RXN)
 . . . I RXNMAP'="" S RXN=RXNMAP
 . . . I +RXN'=0 S C0ARY(C0N,2)=C0ARY(C0N,2)_" (Rxnorm: "_+RXN_")"
 . . D REACT(.CCDAV,C0I) ; process multiline reactions
 . . S C0ARY(C0N,3)=$G(CCDAV(C0I,"allergy","reactions","reactionSummary")) ; 
 . . S C0ARY(C0N,4)=$G(CCDAV(C0I,"allergy","severity@value")) ; severity
 . . ;S C0ARY(C0N,5)="" ; CCDAV(C0I,"allergy","facility@name") ; status tbd
 . . D COMMENT(.CCDAV,C0I) ; process multiline comments - set source
 . . S C0ARY(C0N,6)=$G(CCDAV(C0I,"allergy","comments","commentSummary")) ; 
 . . S C0ARY(C0N,7)=$G(CCDAV(C0I,"allergy","comments","commentSource")) ; source
 ;
 ;I +$O(C0ARY("AAAAAA"),-1)=0 D  Q  ; all allergies have been redacted
 I $G(CCDAV1("results","reactions","allergy","assessment@value"))="nka" D  Q  ;
 . N ASECT S ASECT=$NA(@CCDAWRK@("ALGYSECT"))
 . D GET^C0CDACU(ASECT,"TALGYV5^C0CDAC8")
 . D QUEUE^MXMLTMPL(BLIST,ASECT,1,@ASECT@(0))
 ;
 ; the allergy section component
 ;
 N ASECT S ASECT=$NA(@CCDAWRK@("ALGYSECT"))
 D GET^C0CDACU(ASECT,"TALGYSEC^C0CDAC8")
 D QUEUE^MXMLTMPL(BLIST,ASECT,1,@ASECT@(0))
 ;
 ; allergy html digest generation
 ;
 N AHTML S AHTML=$NA(@CCDAWRK@("ALGYHTML"))
 D GENHTML^C0CDACU(AHTML,"C0ARY")
 D QUEUE^MXMLTMPL(BLIST,AHTML,1,@AHTML@(0))
 ;
 ; allergy xml generation
 ;
 N WRK
 I NKA=1 D  Q  ;
 . S C0ARY("allergyGuid")=$$UUID^C0CDACU() ; random
 . S C0ARY("allergyGuid2")=$$UUID^C0CDACU() ; random
 . N C0DATE S C0DATE=$G(CCDAV(C0I,"allergy","entered@value"))
 . I C0DATE'="" S C0ARY("effectiveDate")=$$FMDTOUTC^C0CDACU(C0DATE) ; allergy entered date
 . E  S C0ARY("effectiveDate")=$$FMDTOUTC^C0CDACU($G(PARM("date")))
 . S WRK=$NA(@CCDAWRK@("ALGYV4",1))
 . D GETNMAP^C0CDACU(WRK,"TALGYV4^C0CDAC8","C0ARY")
 . D QUEUE^MXMLTMPL(BLIST,WRK,1,@WRK@(0))
 . N ALGYEND S ALGYEND=$NA(@CCDAWRK@("ALGYEND"))
 . D GET^C0CDACU(ALGYEND,"TALGYEND^C0CDAC8")
 . D QUEUE^MXMLTMPL(BLIST,ALGYEND,1,@ALGYEND@(0))
 N C0I S C0I=0
 F  S C0I=$O(CCDAV(C0I)) Q:+C0I=0  D  ;
 . N C0DATE S C0DATE=$G(CCDAV(C0I,"allergy","entered@value"))
 . I C0DATE'="" S C0ARY("effectiveDate")=$$FMDTOUTC^C0CDACU(C0DATE) ; allergy entered date
 . E  S C0ARY("effectiveDate")="UNK"
 . I $$REDACT^C0CDACV($G(CCDAV(C0I,"allergy","uri")),.PARMS) D  Q  ;
 . S C0ARY("uri")=$G(CCDAV(C0I,"allergy","uri"))
 . S C0ARY("allerginName")=$G(CCDAV(C0I,"allergy","name@value")) ; allergy
 . S C0ARY("severityName")=$G(CCDAV(C0I,"allergy","severity@value")) ; severity
 . N C0SEV S C0SEV=""
 . I C0ARY("severityName")="MILD" S C0SEV=255604002
 . I C0ARY("severityName")="MODERATE" S C0SEV=6736007
 . I C0ARY("severityName")="SEVERE" S C0SEV=24484000
 . I C0SEV="" S C0SEV="UNK"
 . S C0ARY("severityCode")=C0SEV ; severity snomed code
 . S C0ARY("status")="" ; CCDAV(C0I,"allergy","facility@name") ; status tbd
 . D COMMENT(.CCDAV,C0I) ; process multiline comments - set source
 . S C0ARY("allergyComment")=$G(CCDAV(C0I,"allergy","comments","commentSummary")) ; 
 . S C0ARY("allergySource")=$G(CCDAV(C0I,"allergy","comments","commentSource")) ; source
 . I C0ARY("allergySource")="" D  ;
 . . S C0ARY("allergySource")=$G(CCDAV(C0I,"allergy","facility@name"))
 . S C0ARY("allergyGuid")=$$UUID^C0CDACU() ; random
 . S C0ARY("orgOID")=$$ORGOID^C0CDACU() ; fetch organization OID
 . S C0ARY("VUID")=$G(CCDAV(C0I,"allergy","vuid@value"))
 . I C0ARY("VUID")="" S C0ARY("VUID")=$G(CCDAV(C0I,"allergy","drugIngredients","drugIngredient@vuid"))
 . S C0ARY("TYPE")=$G(CCDAV(C0I,"allergy","type@name"))
 . ;
 . ; beginning of allergy
 . S WRK=$NA(@CCDAWRK@("ALGY",C0I))
 . D GETNMAP^C0CDACU(WRK,"TALGY^C0CDAC8","C0ARY")
 . D QUEUE^MXMLTMPL(BLIST,WRK,1,@WRK@(0))
 . ;
 . ; allergy to substance or to drug
 . I C0ARY("TYPE")'="DRUG" D  ; no VUID no drug
 . . S C0ARY("allerginCode")="UNK"
 . . S C0ARY("allerginCodeSystemOID")=$$VAOID()
 . . S C0ARY("allerginCodeSystemName")="VANDF"
 . . S WRK=$NA(@CCDAWRK@("ALGYV2",C0I))
 . . D GETNMAP^C0CDACU(WRK,"TALGYV2^C0CDAC8","C0ARY")
 . . D QUEUE^MXMLTMPL(BLIST,WRK,1,@WRK@(0))
 . I C0ARY("TYPE")="DRUG" D  ; drug allergy
 . . N RXN S RXN=$$RXNORM^C0CDAC4(C0ARY("VUID"))
 . . N RXNMAP S RXNMAP=$$MAP^KBAIQLDM(+RXN)
 . . I RXNMAP'="" S RXN=RXNMAP
 . . I RXN'="" D  ;
 . . . S C0ARY("allerginCode")=+RXN
 . . . S C0ARY("allerginCodeSystemOID")=$$RXNOID()
 . . . S C0ARY("allerginCodeSystemName")="RxNorm"
 . . I RXN="" D  ;
 . . . S C0ARY("allerginCode")=C0ARY("VUID")
 . . . S C0ARY("allerginCodeSystemOID")=$$VAOID()
 . . . S C0ARY("allerginCodeSystemName")="VANDF"
 . . S WRK=$NA(@CCDAWRK@("ALGYV1",C0I))
 . . D GETNMAP^C0CDACU(WRK,"TALGYV1^C0CDAC8","C0ARY")
 . . D QUEUE^MXMLTMPL(BLIST,WRK,1,@WRK@(0))
 . ;
 . ; reaction
 . ;I $G(CCDAV(C0I,"allergy","reactions","reaction@name"))'="" D  ; make it look like a mult
 . ;. N ZZ M ZZ=CCDAV(C0I,"allergy","reactions")
 . ;. M CCDAV(C0I,"allergy","reactions",1)=ZZ
 . I $D(CCDAV(C0I,"allergy","reactions")) D  ;
 . . N ZR S ZR=$NA(CCDAV(C0I,"allergy","reactions"))
 . . I $D(CCDAV(C0I,"allergy","reactions",1)) S ZR=$NA(@ZR@(1))
 . . N ZRN S ZRN=$G(@ZR@("reaction@name"))
 . . I ZRN="" S ZRN="UNKNOWN"
 . . N OK,ZRM
 . . S OK=$$GETMAP^C0CDACM(.ZRM,"reaction",ZRN)
 . . I 'OK S OK=$$GETMAP^C0CDACM(.ZRM,"reaction","UNKNOWN") ; don't know the Snomed
 . . ;I $G(DEBUG) I $D(ZRM) ZWR ZRM ;B
 . . S C0ARY("reactionName")=$G(ZRM("snomedText"))
 . . I C0ARY("reactionName")="" S C0ARY("reactionName")=ZRN
 . . S C0ARY("reactionCode")=$G(ZRM("snomedCode"))
 . . I C0ARY("reactionCode")="" D  ;
 . . . S C0ARY("reactionCode")=261665006 ; means unknown
 . . . S C0ARY("reactionName")="Unknown"
 . . S WRK=$NA(@CCDAWRK@("ALGYR1",C0I))
 . . D GETNMAP^C0CDACU(WRK,"TALGYR^C0CDAC8","C0ARY")
 . . D QUEUE^MXMLTMPL(BLIST,WRK,1,@WRK@(0))
 . ;
 . ; severity
 . I C0ARY("severityName")'="" D  ;
 . . S WRK=$NA(@CCDAWRK@("ALGYS",C0I))
 . . D GETNMAP^C0CDACU(WRK,"TALGYS^C0CDAC8","C0ARY")
 . . D QUEUE^MXMLTMPL(BLIST,WRK,1,@WRK@(0))
 . ;
 . ; comments
 . I C0ARY("allergyComment")'="" D  ;
 . . S WRK=$NA(@CCDAWRK@("ALGYC",C0I))
 . . D GETNMAP^C0CDACU(WRK,"TALGYC^C0CDAC8","C0ARY")
 . . D QUEUE^MXMLTMPL(BLIST,WRK,1,@WRK@(0))
 . ;
 . ; source
 . I C0ARY("allergySource")'="" D  ;
 . . S WRK=$NA(@CCDAWRK@("ALGYSRC",C0I))
 . . D GETNMAP^C0CDACU(WRK,"TALGYSRC^C0CDAC8","C0ARY")
 . . D QUEUE^MXMLTMPL(BLIST,WRK,1,@WRK@(0))
 . ;
 . ; end of allergy
 . S WRK=$NA(@CCDAWRK@("ALGYE",C0I))
 . D GETNMAP^C0CDACU(WRK,"TALGYE^C0CDAC8","C0ARY")
 . D QUEUE^MXMLTMPL(BLIST,WRK,1,@WRK@(0))
 ; 
 ; allergy section ending
 ;
 N ALGYEND S ALGYEND=$NA(@CCDAWRK@("ALGYEND"))
 D GET^C0CDACU(ALGYEND,"TALGYEND^C0CDAC8")
 D QUEUE^MXMLTMPL(BLIST,ALGYEND,1,@ALGYEND@(0))
 ;
 Q
 ;
REACT(ZARY,ZI) ; handle multiple line reactions
 ; sets CCDAV(ZI,"allergy","reactions","reactionSummary") to one text line
 N GN S GN=$NA(ZARY(ZI,"allergy","reactions"))
 I $G(@GN@(1,"reaction@name"))'="" D  Q  ;
 . ;B
 . N ZJ,ZN
 . S ZN=$O(@GN@(""),-1)
 . F ZJ=1:1:ZN D  ;
 . . I ZJ>1 S @GN@("reactionSummary")=@GN@("reactionSummary")_". "
 . . S @GN@("reactionSummary")=$G(@GN@("reactionSummary"))_@GN@(ZJ,"reaction@name")
 S @GN@("reactionSummary")=$G(@GN@("reaction@name"))
 Q
 ;
REACT2(ZARY,ZI) ; handle multiple line reactions - use <li></li> for lines
 ; sets CCDAV(ZI,"allergy","reactions","reactionSummary") to one text line
 N ZGN S ZGN=$NA(ZARY(ZI,"allergy","reactions"))
 I $G(@ZGN@(1,"reaction@name"))'="" D  Q  ;
 . N ZJ,ZN
 . S ZN=$O(@ZGN@(""),-1)
 . S @ZGN@("reactionSummary")="<ul>" ; unordered list
 . F ZJ=1:1:ZN D  ;
 . . S @ZGN@("reactionSummary")=$G(@ZGN@("reactionSummary"))_"<li>"_@ZGN@(ZJ,"reaction@name")_"</li>"
 . S @ZGN@("reactionSummary")=@ZGN@("reactionSummary")_"</ul>"
 S @ZGN@("reactionSummary")=$G(@ZGN@("reaction@name"))
 Q
 ;
COMMENT(ZARY,ZI) ; handle multiline comments and set allergy source
 ; sets CCDAV(ZI,"allergy","comments","commentSummary") to one text line
 ; sets CCDAV(ZI,"allergy","comments","commentSource") to comment source
 N ZGN S ZGN=$NA(ZARY(ZI,"allergy","comments"))
 S @ZGN@("commentSource")=$G(@ZGN@("comment@enteredBy"))
 I $G(@ZGN@(1,"commentText"))'="" D  Q  ;
 . ;B
 . N ZJ,ZN
 . S ZN=$O(@ZGN@(""),-1)
 . F ZJ=1:1:ZN D  ;
 . . I ZJ>1 S @ZGN@("commentSummary")=@ZGN@("commentSummary")_". "
 . . S @ZGN@("commentSummary")=$G(@ZGN@("commentSummary"))_@ZGN@(ZJ,"comment@commentText")
 S @ZGN@("commentSummary")=$G(@ZGN@("comment@commentText"))
 ;
 Q
 ;
VAOID() ; Oid for VA coding system
 Q "2.16.840.1.113883.6.229"
 ;
RXNOID() ; RxNorm OID
 Q "2.16.840.1.113883.6.88"
 ;
 ;;<section classCode="DOCSECT" moodCode="EVN">
 ;
TALGYSEC ; 
 ;;<component>
 ;;<section>
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.6.1"></templateId>
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.6.1" extension="2015-08-01"></templateId>
 ;;<code code="48765-2" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Allergies, adverse reactions, alert"></code>
 Q
 ;
TALGY ;
 ;;<entry>
 ;;<act classCode="ACT" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.30"></templateId>
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.30" extension="2015-08-01"></templateId>
 ;;<id root="@@allergyGuid@@"></id>
 ;;<code code="48765-2" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Allergies, adverse reactions, alerts"></code>
 ;;<statusCode code="active"></statusCode>
 ;;<effectiveTime>
 ;;<low value="@@effectiveDate@@"></low>
 ;;</effectiveTime>
 ;;<entryRelationship typeCode="SUBJ">
 ;;<observation classCode="OBS" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.7"></templateId>
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.7" extension="2014-06-09"></templateId>
 ;;<id extension="3355135" root="1.3.6.1.4.1.16517"></id>
 ;;<code code="ASSERTION" codeSystem="2.16.840.1.113883.5.4" codeSystemName="ActCode"></code>
 ;;<statusCode code="completed"></statusCode>
 ;;<effectiveTime>
 ;;<low value="@@effectiveDate@@"></low>
 ;;</effectiveTime>
 Q
 ;
TALGYV1 ; drug allergy
 ;;<value code="416098002" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT" displayName="drug allergy" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="CD"></value>
 ;;<participant typeCode="CSM">
 ;;<participantRole classCode="MANU">
 ;;<playingEntity classCode="MMAT">
 ;;<code code="@@allerginCode@@" codeSystem="@@allerginCodeSystemOID@@" codeSystemName="@@allerginCodeSystemName@@" displayName="@@allerginName@@">
 ;;<originalText>
 ;;<reference value="#@@uri@@"></reference>
 ;;</originalText>
 ;;<translation code="@@allerginCode@@" codeSystem="@@allerginCodeSystemOID@@" codeSystemName="@@allerginCodeSystemName@@" displayName="@@allerginName@@"></translation>
 ;;</code>
 ;;<name>@@allerginName@@</name>
 ;;</playingEntity>
 ;;</participantRole>
 ;;</participant>
 ;;<entryRelationship inversionInd="true" typeCode="SUBJ">
 ;;<observation classCode="OBS" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.28"></templateId>
 ;;<code code="33999-4" codeSystem="2.16.840.1.113883.6.1"></code>
 ;;<statusCode code="completed"></statusCode>
 ;;<value code="55561003" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED" displayName="Active" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="CE"></value>
 ;;</observation>
 ;;</entryRelationship>
 Q
 ;
TALGYV2 ; substance allergy
 ;;<value code="419199007" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT" displayName="allergy to substance" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="CD"></value>
 ;;<participant typeCode="CSM">
 ;;<participantRole classCode="MANU">
 ;;<playingEntity classCode="MMAT">
 ;;<code nullFlavor="OTH">
 ;;<originalText>
 ;;<reference value="#@@uri@@"></reference>
 ;;</originalText>
 ;;<translation code="@@allerginCode@@" codeSystem="@@allerginCodeSystemOID@@" codeSystemName="@@allerginCodeSystemName@@" displayName="@@allerginName@@"></translation>
 ;;</code>
 ;;<name>@@allerginName@@</name>
 ;;</playingEntity>
 ;;</participantRole>
 ;;</participant>
 ;;<entryRelationship inversionInd="true" typeCode="SUBJ">
 ;;<observation classCode="OBS" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.28"></templateId>
 ;;<code code="33999-4" codeSystem="2.16.840.1.113883.6.1"></code>
 ;;<statusCode code="completed"></statusCode>
 ;;<value code="55561003" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED" displayName="Active" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="CE"></value>
 ;;</observation>
 ;;</entryRelationship>
 Q
 ;
TALGYV3 ; no Known Allergy case
 ;;<entry typeCode="DRIV">
 ;;<act classCode="ACT" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.30"></templateId>
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.30" extension="2015-08-01"></templateId>
 ;;<id root="@@allergyGuid@@"/>
 ;;<code nullFlavor="NA"/>
 ;;<statusCode code="active"/>                                          
 ;;<effectiveTime>
 ;;<low nullFlavor="NA"/>
 ;;</effectiveTime>                                                     
 ;;<entryRelationship typeCode="SUBJ" inversionInd="false">
 ;;<observation classCode="OBS" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.7"></templateId>
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.7" extension="2014-06-09"></templateId>
 ;;<id root="2b37be6b-9b1c-4069-bbca-1caf5fe1937d"/>
 ;;<code code="420134006" codeSystem="2.16.840.1.113883.6.96" displayName="Propensity to adverse reactions (disorder)"
 ;;codeSystemName="SNOMED CT"/>
 ;;<statusCode code="completed"/>
 ;;<effectiveTime>
 ;;<low nullFlavor="UNK"/>
 ;;</effectiveTime>
 ;;<value xsi:type="CD" code="160244002" codeSystem="2.16.840.1.113883.6.96" displayName="No Known allergies" codeSystemName="SNOMED CT">
 ;;<originalText>
 ;;<reference value="#noallergies"/>
 ;;</originalText>
 ;;</value>
 ;;</observation>
 ;;</entryRelationship>
 ;;</act>
 ;;</entry>
 Q
 ;
TALGYV4 ; no known allergy case
 ;;<!-- No Known Allergies -->
 ;;<entry typeCode="DRIV">
 ;;<!-- Allergy Concern Act -->
 ;;<act classCode="ACT" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.30"/>
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.30" extension="2015-08-01"></templateId>
 ;;<id root="@@allergyGuid@@"/>
 ;;<code code="48765-2" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Allergies, adverse reactions, alerts"/>
 ;;<!--currently tracked concerns are active concerns-->
 ;;<statusCode code="active"/>         
 ;;<effectiveTime>
 ;;<!--show time when the concern first began being tracked-->
 ;;<low value="@@effectiveDate@@"/>         
 ;;</effectiveTime>
 ;;<entryRelationship typeCode="SUBJ">
 ;;<!-- No Known Allergies -->
 ;;<observation classCode="OBS" moodCode="EVN" negationInd="true">
 ;;<!-- allergy - intolerance observation template -->
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.7"/>
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.7" extension="2014-06-09" /> 
 ;;<id root="@@allergyGuid@@"/>
 ;;<code code="ASSERTION" codeSystem="2.16.840.1.113883.5.4"/>
 ;;<statusCode code="completed"/>
 ;;<!-- date/time the patient made the assertion -->
 ;;<effectiveTime>
 ;;<high value="@@effectiveDate@@"/>
 ;;</effectiveTime>
 ;;<value xsi:type="CD" code="419199007" displayName="Allergy to substance (disorder)" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT">
 ;;<originalText>
 ;;<reference value="#noallergies"/>
 ;;</originalText>
 ;;</value>
 ;;</observation>
 ;;</entryRelationship>
 ;;</act>
 ;;</entry>
 Q
 ;
TALGYV5 ; no known allergies astro gpl
 ;;<!-- Allergies Section -->
 ;;<component>
 ;;  <section>
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.6.1"></templateId>
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.6.1" extension="2015-08-01"></templateId>
 ;;    <code code="48765-2" codeSystem="2.16.840.1.113883.6.1" displayName="Allergies, adverse reactions, alerts" codeSystemName="LOINC"/>
 ;;    <title>ALLERGIES</title>
 ;;    <text>
 ;;      <content ID="Alg_Concern_1">Allergy Concern:
 ;;      Concern Tracker Start Date: 01/03/2014
 ;;      Concern Tracker End Date:
 ;;      Concern Tracker Status: Completed
 ;;    <content ID="allergy1">No known <content ID="adverseEvent1">allergies.</content></content></content></text>
 ;;    <entry typeCode="DRIV">
 ;;      <!-- Allergy Concern Act -->
 ;;      <act classCode="ACT" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.30"></templateId>
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.30" extension="2015-08-01"></templateId>
 ;;             <id root="36e3e930-7b14-11db-9fe1-0800200c9a66"/>
 ;;             <!-- SDWG supports 48765-2 or CONC in the code element -->
 ;;             <!--<code code="CONC" codeSystem="2.16.840.1.113883.5.6"/>-->
 ;;             <code code="48765-2" codeSystem="2.16.840.1.113883.6.1" displayName="Allergies, adverse reactions, alerts" codeSystemName="LOINC"/>
 ;;             <text><reference value="#Alg_Concern_1"></reference></text>
 ;;             <statusCode code="completed"/> <!-- The concern is not active, in terms of there being an active condition to be managed.-->
 ;;             <effectiveTime>
 ;;               <low value="20100103"/> <!--show time when the concern about allergies was assessed and completed. -->
 ;;               <high/>
 ;;             </effectiveTime>
 ;;             <entryRelationship typeCode="SUBJ">
 ;;               <!-- No Known Allergies -->
 ;;               <!-- The use of negationInd corresponds with the newer Observation.valueNegationInd -->
 ;;               <!-- The negationInd = true negates the observation/value -->
 ;;               <observation classCode="OBS" moodCode="EVN" negationInd="true">
 ;;                 <!-- allergy - intolerance observation template -->
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.7"></templateId>
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.7" extension="2014-06-09"></templateId>
 ;;                 <id root="4adc1020-7b14-11db-9fe1-0800200c9a66"/>
 ;;                 <code code="ASSERTION" codeSystem="2.16.840.1.113883.5.4"/>
 ;;                 <statusCode code="completed"/>
 ;;                 <!-- N/A - author/time records when this assertion was made -->
 ;;                 <effectiveTime>
 ;;                   <low value="20100103"/>
 ;;                 </effectiveTime>
 ;;                 <!-- The time when this was biologically relevant ie True for the patient. -->
 ;;                 <!-- As a minimum time interval over which this is true, populate the effectiveTime/low with the current time. -->
 ;;                 <!-- It would be equally valid to have a longer range of time over which this statement was represented as being true. -->
 ;;                 <!-- As a maximum, you would never indicate an effectiveTime/high that was greater than the current point in time. -->
 ;;                 <value xsi:type="CD" code="419199007"
 ;;                        displayName="Allergy to substance (disorder)"
 ;;                        codeSystem="2.16.840.1.113883.6.96"
 ;;                        codeSystemName="SNOMED CT"/>
 ;;                 <author>
 ;;                   <time value="20100103"/>
 ;;                   <assignedAuthor>
 ;;                     <id extension="99999999" root="2.16.840.1.113883.4.6"/>
 ;;                     <code code="200000000X" codeSystem="2.16.840.1.113883.6.101"
 ;;                           displayName="Allopathic &amp; Osteopathic Physicians"/>
 ;;                     <telecom use="WP" value="tel:555-555-1002"/>
 ;;                     <assignedPerson>
 ;;                       <name>
 ;;                         <given>Henry</given>
 ;;                         <family>Seven</family>
 ;;                       </name>
 ;;                     </assignedPerson>
 ;;                   </assignedAuthor>
 ;;                 </author>
 ;;                  <participant typeCode="CSM">
 ;;                       <participantRole classCode="MANU">
 ;;                           <playingEntity classCode="MMAT">
 ;;                               <code nullFlavor="NA"/>
 ;;                           </playingEntity>
 ;;                       </participantRole>
 ;;                   </participant>
 ;;               </observation>
 ;;             </entryRelationship>
 ;;      </act>
 ;;    </entry>
 ;;  </section>
 ;;</component>
 Q
 ;
TALGYR ; reaction
 ;;<entryRelationship inversionInd="true" typeCode="MFST">
 ;;<observation classCode="OBS" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.9"></templateId>
 ;;<id nullFlavor="UNK"></id>
 ;;<code code="ASSERTION" codeSystem="2.16.840.1.113883.5.4"></code>
 ;;<statusCode code="completed"></statusCode>
 ;;<value code="@@reactionCode@@" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED" displayName="@@reactionName@@" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="CD"></value>
 ;;</observation>
 ;;</entryRelationship>
 Q
 ;
 ;;<reference value="#@@severityUri@@"></reference>
TALGYS ; severity
 ;;<entryRelationship inversionInd="true" typeCode="SUBJ">
 ;;<observation classCode="OBS" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.8"></templateId>
 ;;<code code="SEV" codeSystem="2.16.840.1.113883.5.4" codeSystemName="ActCode" displayName="Severity Observation"></code>
 ;;<text>
 ;;</text>
 ;;<statusCode code="completed"></statusCode>
 ;;<value code="@@severityCode@@" codeSystem="2.16.840.1.113883.6.96" displayName="@@severityName@@" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="CD"></value>
 ;;</observation>
 ;;</entryRelationship>
 Q
 ;
TALGYC ; comment
 ;;<entryRelationship inversionInd="true" typeCode="SUBJ">
 ;;<act classCode="ACT" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.1.40"></templateId>
 ;;<templateId root="2.16.840.1.113883.3.88.11.83.11"></templateId>
 ;;<templateId root="1.3.6.1.4.1.19376.1.5.3.1.4.2"></templateId>
 ;;<code code="48767-8" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Annotation Comment"></code>
 ;;<text>@@allergyComment@@
 ;;<reference value="#allergyComment-@@allergyGuid@@"></reference>
 ;;</text>
 ;;<statusCode code="completed"></statusCode>
 ;;</act>
 ;;</entryRelationship>
 Q
 ;
TALGYSRC ; source
 ;;<entryRelationship contextConductionInd="true" typeCode="REFR">
 ;;<observation classCode="OBS" moodCode="EVN">
 ;;<code code="48766-0" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Information source"></code>
 ;;<statusCode code="completed"></statusCode>
 ;;<value xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="ST">@@allergySource@@</value>
 ;;</observation>
 ;;</entryRelationship>
 ;;</observation>
 Q
 ;
TALGYE ; end of allergy
 ;;</entryRelationship>
 ;;</act>
 ;;</entry>
 Q
 ;
TALGYEND ; end of section
 ;;</section>
 ;;</component>
 Q
 ;
