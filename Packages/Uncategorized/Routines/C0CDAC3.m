C0CDAC3 ; GPL - Patient Portal - CCDA Routines ;09/17/13  17:05
 ;;0.1;C0CDA;nopatch;noreleasedate;Build 1
 ;
 ; License AGPL v3.0
 ; 
 ; This software was funded in part by Oroville Hospital, and was
 ; created with help from Oroville's doctors and staff.
 Q
 ;
PROBLEMS(BLIST,DFN,CCDAWRK,CCDARPT,CCDACTRL) ;
 ;
 N CCDAV
 S @CCDARPT@("STATUS")="EXTRACTING"
 S @CCDARPT@("EXTRACT-BEGIN")=$$NOW^XLFDT
 D GETPAT^C0CDACD(.CCDAV,DFN,"problems")
 I '$D(CCDAV) D  Q  ;
 . N PSECT S PSECT=$NA(@CCDAWRK@("PSECTION"))
 . D GET^C0CDACU(PSECT,"TNOPROB^C0CDAC3")
 . D QUEUE^MXMLTMPL(BLIST,PSECT,1,@PSECT@(0))
 ;
 S @CCDARPT@("EXTRACT-ENDS")=$$NOW^XLFDT
 ;
 ; the problem section component - moved to after computations in case all problems 
 ;   are redacted
 ;
 ;N PSECT S PSECT=$NA(@CCDAWRK@("PSECTION"))
 ;D GET^C0CDACU(PSECT,"TPROBSEC^C0CDAC3")
 ;D QUEUE^MXMLTMPL(BLIST,PSECT,1,@PSECT@(0))
 ;
 ; problem section html
 ;
 N C0HTML,C0ARY
 S C0ARY("TITLE")="Problems"
 S C0ARY("HEADER",1)="Date"
 S C0ARY("HEADER",2)="Problems"
 S C0ARY("HEADER",3)="Status"
 ;S C0ARY("HEADER",4)="Comments"
 S C0ARY("HEADER",5)="Source"
 ;
 N C0N S C0N=0
 N C0I S C0I=0
 F  S C0I=$O(CCDAV("problem",C0I)) Q:+C0I=0  D  ;
 . N C0DATE S C0DATE=CCDAV("problem",C0I,"entered@value")
 . S CCDAV("problem",C0I,"uri")="uri_9000011-"_$G(CCDAV("problem",C0I,"id@value"))
 . Q:$$REDACT^C0CDACV(CCDAV("problem",C0I,"uri"),.PARMS)
 . ; astro gpl
 . ;
 . N PROB S PROB=$G(CCDAV("problem",C0I,"name@value"))
 . I PROB["449868002" Q  ;
 . I PROB["102513008" Q  ;
 . I PROB["211896002" Q  ;
 . N ICDVALUE S ICDVALUE=$G(CCDAV("problem",C0I,"icd@value"))
 . I ICDVALUE["Z71.1" Q  ;
 . ; end astro
 . ;
 . S C0N=C0N+1
 . S C0ARY(C0N,1)=$$HTMLDT^C0CDACU(C0DATE) ; problem date
 . S C0ARY(C0N,1,"ID")=$G(CCDAV("problem",C0I,"uri"))
 . N PROBNAM S PROBNAM=CCDAV("problem",C0I,"name@value")
 . S PROBNAM=$$CHARCHK^MXMLBLD(PROBNAM) ; make it xml safe
 . S CCDAV("problem",C0I,"name@value")=PROBNAM ; correct in the array
 . S C0ARY(C0N,2)=CCDAV("problem",C0I,"name@value") ; problem name
 . S C0ARY(C0N,3)=CCDAV("problem",C0I,"status@name") ; problem status
 . ;S C0ARY(C0N,4)=$G(CCDAV("problem",C0I,"comments.comment@commentText"))
 . S C0ARY(C0N,5)=CCDAV("problem",C0I,"provider@name") ; problem source
 ;
 I +$O(C0ARY("AAAAA"),-1)=0 D  Q  ; all problems have been redacted
 . N PSECT S PSECT=$NA(@CCDAWRK@("PSECTION"))
 . D GET^C0CDACU(PSECT,"TNOPROB^C0CDAC3")
 . D QUEUE^MXMLTMPL(BLIST,PSECT,1,@PSECT@(0))
 ;
 ; the problem section component
 ;
 N PSECT S PSECT=$NA(@CCDAWRK@("PSECTION"))
 D GET^C0CDACU(PSECT,"TPROBSEC^C0CDAC3")
 D QUEUE^MXMLTMPL(BLIST,PSECT,1,@PSECT@(0))
 ;
 ;  problem html digest
 ;
 N PHTML S PHTML=$NA(@CCDAWRK@("PROBHTML"))
 D GENHTML^C0CDACU(PHTML,"C0ARY")
 D QUEUE^MXMLTMPL(BLIST,PHTML,1,@PHTML@(0))
 ;
 ; problem xml generation
 ;
 N WRK
 F  S C0I=$O(CCDAV("problem",C0I)) Q:+C0I=0  D  ;
 . K C0ARY
 . M C0ARY=CCDAV("problem",C0I)
 . Q:$$REDACT^C0CDACV(CCDAV("problem",C0I,"uri"),.PARMS)
 . S C0ARY("uri")=$G(CCDAV("problem",C0I,"uri"))
 . S C0ARY("code@value")=$G(C0ARY("icd@value")) ; default to icd9 code
 . S C0ARY("codeSystem")=$P($$ICD9(),"^",1) ; default to icd9 codes
 . S C0ARY("codeSystemName")=$P($$ICD9(),"^",2) 
 . S C0ARY("code@name")=$G(C0ARY("name@value"))
 . N CODE S CODE=$G(C0ARY("icd@value")) ; icd9 code
 . I CODE'="" D  ; 
 . . N CNAME,SCODE S CNAME=C0ARY("code@name")
 . . S SCODE=""
 . . I CNAME["(SCT" D  ; snomed code is provided
 . . . S SCODE=$P($P(CNAME,"(SCT ",2),")",1)
 . . I SCODE="" Q  ;
 . . ;N SCODE S SCODE=$O(^JJOHPP(201,"I2S",CODE,"")) ; look up snomed cod
 . . N LEXS
 . . D EN^LEXCODE(SCODE)
 . . I $D(LEXS("SCT",1)) D  ; found in the lexicon
 . . . ;ZWR LEXS
 . . . D:C0LOG OUTLOG^C0CDACU("LEXS(0)="_LEXS(0))
 . . . D:C0LOG OUTLOG^C0CDACU("LEXS(""SCT"",0)="_LEXS("SCT",0))
 . . . D:C0LOG OUTLOG^C0CDACU("LEXS(""SCT"",1)="_LEXS("SCT",1))
 . . . S C0ARY("code@name")=$P(LEXS("SCT",1),"^",2) ; snomed display name from Lexicon
 . . E  S SCODE=""
 . . I SCODE'="" D  ;
 . . . S C0ARY("code@value")=SCODE
 . . . S C0ARY("codeSystem")=$P($$SNOMED(),"^",1) ; snomed system oid
 . . . S C0ARY("codeSystemName")=$P($$SNOMED(),"^",2) ; snomed system name 
 . S C0ARY("problemReference")="#"_$G(C0ARY("uri"))
 . S C0ARY("guid1")=$$UUID^C0CDACU() ; random guid for observation tmplate
 . S C0ARY("guid2")=$$UUID^C0CDACU() ; random guid for problem tmplate
 . I CCDAV("problem",C0I,"status@code")="A" D  ;
 . . S C0ARY("statusCode")="55561003"
 . . S C0ARY("statusName")="Active"
 . I CCDAV("problem",C0I,"status@code")="I" D  ;
 . . S C0ARY("statusCode")="413322009"
 . . S C0ARY("statusName")="Resolved"
 . N C0DATE S C0DATE=CCDAV("problem",C0I,"entered@value")
 . S C0ARY("effectiveDate")=$$FMDTOUTC^C0CDACU(C0DATE) ; problem date
 . S WRK=$NA(@CCDAWRK@("PROB",C0I))
 . D GETNMAP^C0CDACU(WRK,"TPROB^C0CDAC3","C0ARY")
 . D QUEUE^MXMLTMPL(BLIST,WRK,1,@WRK@(0))
 ;
 ; problem section ending
 ;
 N PROBEND S PROBEND=$NA(@CCDAWRK@("PROBEND"))
 D GET^C0CDACU(PROBEND,"TPROBEND^C0CDAC3")
 D QUEUE^MXMLTMPL(BLIST,PROBEND,1,@PROBEND@(0))
 ;
 Q
 ;
ICD9() ; ICD-9-CM OID
 Q "2.16.840.1.113883.6.103^ICD-9-CM"
SNOMED() ; SNOMED-CT
 Q "2.16.840.1.113883.6.96^SNOMED-CT"
 ;
TPROBSEC ;
 ;;<component>
 ;;<section classCode="DOCSECT" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.5.1"></templateId>
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.5.1" extension="2015-08-01"></templateId>
 ;;<code code="11450-4" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Problem List"></code>
 Q
 ;
TPROB ;
 ;;<entry>
 ;;<act classCode="ACT" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.3"/>
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.3" extension="2015-08-01"/>
 ;;<id root="@@guid1@@"></id>
 ;;<code code="CONC" codeSystem="2.16.840.1.113883.5.6"></code>
 ;;<statusCode code="completed"></statusCode>
 ;;<effectiveTime>
 ;;<low value="@@effectiveDate@@"></low>
 ;;</effectiveTime>
 ;;<entryRelationship contextConductionInd="true" inversionInd="false" typeCode="SUBJ">
 ;;<observation classCode="OBS" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.4"></templateId>
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.4" extension="2015-08-01"></templateId>
 ;;<id root="@@guid2@@"></id>
 ;;<code code="55607006" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT" displayName="Problem">
 ;;<translation code="75326-9" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Problem"/>
 ;;</code>
 ;;<text mediaType="text/plain">
 ;;<reference value="@@problemReference@@"/>
 ;;</text>
 ;;<statusCode code="completed"></statusCode>
 ;;<effectiveTime>
 ;;<low value="@@effectiveDate@@"></low>
 ;;</effectiveTime>
 ;;<value code="@@code@value@@" codeSystem="@@codeSystem@@" codeSystemName="@@codeSystemName@@" displayName="@@code@name@@" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="CD">
 ;;<originalText>@@name@value@@</originalText>
 ;;</value>
 ;;<entryRelationship contextConductionInd="true" typeCode="REFR">
 ;;<observation classCode="OBS" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.6"></templateId>
 ;;<code code="33999-4" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Status" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="CE"></code>
 ;;<statusCode code="completed"></statusCode>
 ;;<value code="@@statusCode@@" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT" displayName="@@statusName@@" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="CD"></value>
 ;;</observation>
 ;;</entryRelationship>
 ;;<entryRelationship contextConductionInd="true" typeCode="REFR">
 ;;<observation classCode="OBS" moodCode="EVN">
 ;;<code code="48766-0" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Information source"></code>
 ;;<statusCode code="completed"></statusCode>
 ;;<value xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="ST">TEST,VIEW,M.D.</value>
 ;;</observation>
 ;;</entryRelationship>
 ;;</observation>
 ;;</entryRelationship>
 ;;</act>
 ;;</entry>
 Q
 ;
TPROBHB ; problem HTML
 ;;<title>Problems</title>
 ;;<text>
 ;;<table border="1" width="100%">
 ;;<thead>
 ;;<tr>
 ;;<th>Date</th>
 ;;<th>Problems</th>
 ;;<th>Status</th>
 ;;<th>Comments</th>
 ;;<th>Source</th>
 ;;</tr>
 ;;</thead>
 ;;<tbody>
 Q
 ;
TPROBHM ; sample html middle
 ;;<tr>
 ;;<td>02/22/2013</td>
 ;;<td ID="Problem-2862900">Community acquired pneumonia</td>
 ;;<td>Active</td>
 ;;<td></td>
 ;;<td>TEST,VIEW,M.D.</td>
 ;;</tr>
 ;;<tr>
 ;;<td>02/22/2013</td>
 ;;<td ID="Problem-2862901">Asthma</td>
 ;;<td>Active</td>
 ;;<td></td>
 ;;<td>TEST,VIEW,M.D.</td>
 ;;</tr>
 ;;<tr>
 ;;<td>02/22/2013</td>
 ;;<td ID="Problem-2862902">Hypoxemia</td>
 ;;<td>Active</td>
 ;;<td></td>
 ;;<td>TEST,VIEW,M.D.</td>
 ;;</tr>
TPROBHE ; html ending
 ;;</tbody>
 ;;</table>
 ;;</text>
 Q
 ;
 ;;<entry contextConductionInd="true" typeCode="DRIV">
 ;;<act classCode="ACT" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.3"></templateId>
 ;;<id extension="2862900" root="1.3.6.1.4.1.16517"></id>
 ;;<code code="CONC" codeSystem="2.16.840.1.113883.5.6"></code>
 ;;<statusCode code="active"></statusCode>
 ;;<effectiveTime>
 ;;<low value="20130222"></low>
 ;;</effectiveTime>
 ;;</act>
 ;;</entry>
TPROBEND ;
 ;;</section>
 ;;</component>
 Q
 ;
TNOPROB ;
 ;;<!-- Problem Section -->
 ;;<component>
 ;;  <section>
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.5.1"></templateId>
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.5.1" extension="2015-08-01"></templateId>
 ;;    <code code="11450-4" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Problem List"/>
 ;;    <title>PROBLEMS</title>
 ;;    <text>
 ;;      <content ID="Concern_1">Problem Concern:
 ;;      Concern Tracker Start Date: 06/07/2013 16:05:06
 ;;      Concern Tracker End Date: 
 ;;      Concern Status: Active
 ;;      <content ID="problems1">No known <content ID="problemType1">problems.</content></content>
 ;;      </content>
 ;;    </text>
 ;;    <entry typeCode="DRIV">
 ;;      <!-- Problem Concern Act -->   
 ;;      <act classCode="ACT" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.3"/>
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.3" extension="2015-08-01"/>
 ;;             <id root="36e3e930-7b14-11db-9fe1-0800200c9a66"/>
 ;;             <!-- SDWG supports 48765-2 or CONC in the code element -->
 ;;             <code code="CONC" codeSystem="2.16.840.1.113883.5.6"/>
 ;;             <text><reference value="#Concern_1"></reference></text>
 ;;             <statusCode code="active"/> <!-- The concern is not active, in terms of there being an active condition to be managed.-->
 ;;             <effectiveTime>
 ;;               <low value="20130607160506"/> <!-- Time at which THIS “concern” began being tracked.-->
 ;;               <high/>
 ;;             </effectiveTime>
 ;;             <author>
 ;;               <time value="20130607160506"/>
 ;;               <assignedAuthor>
 ;;                 <id extension="66666" root="2.16.840.1.113883.4.6"/>
 ;;                 <code code="207RC0000X" codeSystem="2.16.840.1.113883.6.101" codeSystemName="NUCC"
 ;;                       displayName="Cardiovascular Disease"/>
 ;;                 <addr>
 ;;                   <streetAddressLine>6666 StreetName St.</streetAddressLine>
 ;;                   <city>Silver Spring</city><state>MD</state><postalCode>20901</postalCode>
 ;;                   <country>US</country>
 ;;                 </addr>
 ;;                 <telecom value="tel:+1(301)666-6666" use="WP"/>
 ;;                 <assignedPerson>
 ;;                   <name>
 ;;                     <given>Heartly</given>
 ;;                     <family>Sixer</family>
 ;;                     <suffix>MD</suffix>
 ;;                   </name>
 ;;                 </assignedPerson>
 ;;               </assignedAuthor>
 ;;             </author>
 ;;             <entryRelationship typeCode="SUBJ">
 ;;               <observation classCode="OBS" moodCode="EVN" negationInd="true">
 ;;                 <!-- Model of Meaning for No Problems -->
 ;;                 <!-- This is more consistent with how we did no known allergies. -->
 ;;                 <!-- The use of negationInd corresponds with the newer Observation.ValueNegationInd -->
 ;;                 <!-- The negationInd = true negates the value element. --> 
 ;;                 <!-- problem observation template -->
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.4"></templateId>
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.4" extension="2015-08-01"></templateId>
 ;;                 <id root="4adc1021-7b14-11db-9fe1-0800200c9a67"/>
 ;;<code code="55607006" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT" displayName="Problem">
 ;;<translation code="75326-9" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Problem"/>
 ;;</code>
 ;;                 <text><reference value="#problems1"></reference></text>
 ;;                 <statusCode code="completed"/>
 ;;                 <effectiveTime>
 ;;                   <low value="20130607160506"/>
 ;;                 </effectiveTime>
 ;;                 <!-- The time when this was biologically relevant ie True for the patient. -->
 ;;                 <!-- As a minimum time interval over which this is true, populate the effectiveTime/low with the current time. -->
 ;;                 <!-- It would be equally valid to have a longer range of time over which this statement was represented as being true. -->
 ;;                 <!-- As a maximum, you would never indicate an effectiveTime/high that was greater than the current point in time. -->
 ;;                 
 ;;                 <!-- This idea assumes that the value element could come from the Problem value set, or-->
 ;;                 <!-- when negationInd was true, is could also come from the ProblemType value set (and code would be ASSERTION). -->
 ;;                 <value xsi:type="CD" code="55607006"
 ;;                        displayName="Problem"
 ;;                        codeSystem="2.16.840.1.113883.6.96"
 ;;                        codeSystemName="SNOMED CT">
 ;;                   <originalText><reference value="#problemType1"></reference></originalText>
 ;;<translation code="75326-9" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Problem"/>
 ;;                 </value>
 ;;                 <author>
 ;;                   <time value="20130607160506"/>
 ;;                   <assignedAuthor>
 ;;                     <id extension="66666" root="2.16.840.1.113883.4.6"/>
 ;;                     <code code="207RC0000X" codeSystem="2.16.840.1.113883.6.101" codeSystemName="NUCC"
 ;;                           displayName="Cardiovascular Disease"/>
 ;;                     <addr>
 ;;                       <streetAddressLine>6666 StreetName St.</streetAddressLine>
 ;;                       <city>Silver Spring</city><state>MD</state><postalCode>20901</postalCode>
 ;;                       <country>US</country>
 ;;                     </addr>
 ;;                     <telecom value="tel:+1(301)666-6666" use="WP"/>
 ;;                     <assignedPerson>
 ;;                       <name>
 ;;                         <given>Heartly</given>
 ;;                         <family>Sixer</family>
 ;;                         <suffix>MD</suffix>
 ;;                       </name>
 ;;                     </assignedPerson>
 ;;                   </assignedAuthor>
 ;;                 </author>
 ;;       </observation>
 ;;             </entryRelationship>
 ;;      </act>
 ;;    </entry>
 ;;  </section>
 ;;</component>
 Q
 ;
