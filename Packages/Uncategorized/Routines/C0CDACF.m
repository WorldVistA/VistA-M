C0CDACF ; GPL - CCDA Routines ;09/17/13  17:05
 ;;0.1;C0CDA;nopatch;noreleasedate;Build 1
 ;
 ; License AGPL v3.0
 ; 
 ; This software was funded in part by Oroville Hospital, and was
 ; created with help from Oroville's doctors and staff.
 Q
 ;
FUNCSTAT(BLIST,DFN,CCDAWRK,CCDARPT,CCDACTRL) ;
 ;
 ; initial implementation is for PHQ9 tests records as a health factor
 ;
 N CCDAV,CCDAV1
 S @CCDARPT@("STATUS")="EXTRACTING"
 S @CCDARPT@("EXTRACT-BEGIN")=$$NOW^XLFDT
 ;I $G(C0TEST) D TESTPAT(.CCDAV1) ; use a unit test patient for now
 E  D GETPAT^C0CDACE(.CCDAV1,DFN,"healthfactors")
 I '$D(CCDAV1) Q  ;
 I +$G(CCDAV1("results","healthFactors@total"))=0 Q  ;
 I CCDAV1("results","healthFactors@total")=1 D  ;
 . M CCDAV(1)=CCDAV1("results","healthFactors")
 E  M CCDAV=CCDAV1("results","healthFactors")
 S @CCDARPT@("EXTRACT-ENDS")=$$NOW^XLFDT
 ;
 ; functional status section html
 ;
 N C0HTML,C0ARY
 S C0ARY("TITLE")="Functional and Congnitive Status"
 S C0ARY("HEADER",1)="Date"
 S C0ARY("HEADER",2)="Description"
 S C0ARY("HEADER",3)="Codes"
 S C0ARY("HEADER",4)="Status"
 S C0ARY("HEADER",5)="Results"
 S C0ARY("HEADER",6)="Comments"
 ;
 D  ;
 . N C0N S C0N=0
 . N C0I S C0I=0
 . F  S C0I=$O(CCDAV(C0I)) Q:+C0I=0  D  ;
 . . I $G(CCDAV(C0I,"factor","name@value"))'["LOINC" Q  ; not LOINC code here
 . . N LOINC S LOINC=""
 . . I CCDAV(C0I,"factor","name@value")["44261-6" D  ; we have a PQH9 test
 . . . S CCDAV("LOINC","44261-6",C0I)=""
 . . . S CCDAV(C0I,"factor","code")="LOINC: 44261-6"
 . . E  Q  ; no PHQ9 test here
 . . N C0DATE S C0DATE=$G(CCDAV(C0I,"factor","recorded@value"))
 . . N ZURI
 . . I $D(CCDAV(C0I,"factor","id@value")) D  ;
 . . . S ZURI="PHQ9-LOINC-44261-6-"_CCDAV(C0I,"factor","id@value")
 . . . S ZURI="uri"_ZURI
 . . S CCDAV(C0I,"factor","uri")=ZURI
 . . Q:$$REDACT^C0CDACV(CCDAV(C0I,"factor","uri"),.PARMS)
 . . S C0ARY(C0N,1,"uri")=$G(CCDAV(C0I,"factor","uri"))
 . . S C0N=C0N+1
 . . I C0DATE'="" S C0ARY(C0N,1)=$$HTMLDT^C0CDACU(C0DATE) ; test date
 . . E  S C0ARY(C0N,1)=""
 . . S C0ARY(C0N,1,"ID")=$G(CCDAV(C0I,"factor","uri"))
 . . N UNAME,UCODE ; useName, useCode
 . . S (UNAME,UCODE)=""
 . . N PNAME,PCODE
 . . S PNAME="PATIENT HEALTH QUESTIONNAIRE 9 ITEM TOTAL SCORE"
 . . S PCODE=$G(CCDAV(C0I,"factor","code"))
 . . ;N TCODE,TNAME
 . . ;S TCODE=$G(CCDAV(C0I,"procedure","type@code"))
 . . ;S TNAME=$G(CCDAV(C0I,"procedure","type@name"))
 . . ;I PNAME="Unknown" S PNAME=""
 . . ;I TNAME'="" S UNAME=TNAME S UCODE=TCODE
 . . ;I UNAME="" S UNAME=PNAME S UCODE=PCODE
 . . ;I UNAME="" D  ;
 . . ;. S UNAME=$G(CCDAV(C0I,"procedure","imagingType@name")) ; procedure name
 . . ;. S UCODE=$G(CCDAV(C0I,"procedure","imagingType@code")) ; procedure code
 . . ;S UNAME=$$CHARCHK^MXMLBLD(UNAME)
 . . ;S PNAME=$$CHARCHK^MXMLBLD(PNAME)
 . . ;S CCDAV(C0I,"procedure","cptCode")=UCODE
 . . ;S CCDAV(C0I,"procedure","cptName")=UNAME
 . . S C0ARY(C0N,2)=PNAME
 . . S C0ARY(C0N,3)=$G(CCDAV(C0I,"factor","code"))
 . . S C0ARY(C0N,4)="" ; don't know status
 . . S C0ARY(C0N,5)="" ; initialize the score
 . . S C0ARY(C0N,6)="" ; no comments or fields
 . . D  ; get the score
 . . . N HFX ; health factor xtract
 . . . N HFID ; health factor record ien
 . . . S HFID=CCDAV(C0I,"factor","id@value")
 . . . Q:+HFID=0
 . . . D FMX^KBAIWEB("HFX",9000010.23,HFID) ; get the record
 . . . S C0ARY(C0N,5)=$G(HFX("V_HEALTH_FACTORS",HFID,"COMMENTS"))
 . . . S CCDAV(C0I,"factor","score")=$G(HFX("V_HEALTH_FACTORS",HFID,"COMMENTS"))
 . . ;S C0ARY(C0N,2)=C0ARY(C0N,2)_" (CPT: "_+UCODE_") "_PNAME
 . . ;S C0ARY(C0N,3)=$G(CCDAV(C0I,"procedure","location@name")) ; 
 . . ;S C0ARY(C0N,4)=$G(CCDAV(C0I,"procedure","status@value"))
 ;
 I +$O(C0ARY("AAAAA"),-1)=0 Q  ; all factors have been redacted
 ;
 ; the funcitonal and congnitive status section component
 ;
 N FSECT S FSECT=$NA(@CCDAWRK@("FUNCSECT"))
 D GET^C0CDACU(FSECT,"TFUNCSEC^C0CDACF")
 D QUEUE^MXMLTMPL(BLIST,FSECT,1,@FSECT@(0))
 ;
 ; procedure html digest generation
 ;
 N FHTML S FHTML=$NA(@CCDAWRK@("FUNCHTML"))
 D GENHTML^C0CDACU(FHTML,"C0ARY")
 D QUEUE^MXMLTMPL(BLIST,FHTML,1,@FHTML@(0))
 ;
 ; procedure xml generation
 ;
 N WRK
 N C0I S C0I=0
 F  S C0I=$O(CCDAV(C0I)) Q:+C0I=0  D  ;
 . N C0DATE S C0DATE=$G(CCDAV(C0I,"factor","recorded@value"))
 . I C0DATE'="" S C0ARY("recordedDate")=$$FMDTOUTC^C0CDACU(C0DATE) ; test date
 . E  S C0ARY("recordedDate")="UNK"
 . I $$REDACT^C0CDACV($G(CCDAV(C0I,"factor","uri")),.PARMS) D  Q  ;
 . S C0ARY("uri")=$G(CCDAV(C0I,"factor","uri"))
 . S C0ARY("guid")=$$UUID^C0CDACU() ; random
 . S C0ARY("score")=$G(CCDAV(C0I,"factor","score"))
 . I C0ARY("score")="" Q  ; no score, no entry
 . D SETORGV^C0CDAC2(.C0ARY)
 . ;
 . ; factor
 . S WRK=$NA(@CCDAWRK@("FUNC",C0I))
 . D GETNMAP^C0CDACU(WRK,"TPHQ9^C0CDACF","C0ARY")
 . D QUEUE^MXMLTMPL(BLIST,WRK,1,@WRK@(0))
 ; 
 ; functional status section ending
 ;
 N FUNCEND S FUNCEND=$NA(@CCDAWRK@("FUNCEND"))
 D GET^C0CDACU(FUNCEND,"TFUNCEND^C0CDACF")
 D QUEUE^MXMLTMPL(BLIST,FUNCEND,1,@FUNCEND@(0))
 ;
 Q
 ;
TFUNCSEC ;
 ;;<component>
 ;;<section>
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.14"/>
 ;;<code code="47420-5" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Functional Status"/>
 Q
 ;
TPHQ9 ;
 ;;<entry>
 ;;<observation classCode="OBS" moodCode="EVN" >
 ;;<!-- Consolidation Assessment Scale Observation templateId -->
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.69"/>
 ;;<!-- Risk Category Assessment -->
 ;;<templateId root="2.16.840.1.113883.10.20.24.3.69" extension="2016-02-01"/>
 ;;<id root="1.3.6.1.4.1.115" extension="@@guid@@"/>
 ;;<code code="44261-6" codeSystem="2.16.840.1.113883.6.1" sdtc:valueSet="2.16.840.1.113883.3.67.1.101.11.723">
 ;;<originalText>Risk Category Assessment: PHQ-9 Tool</originalText></code>
 ;;<text>Risk Category Assessment: PHQ-9 Tool</text>
 ;;<statusCode code="completed"/>
 ;;<effectiveTime>
 ;;<low value='@@recordedDate@@'/>
 ;;<high value='@@recordedDate@@'/>
 ;;</effectiveTime>
 ;;<value xsi:type="PQ" value="@@score@@" unit="1"/>
 ;;</observation>
 ;;</entry>
 Q
 ;
TFUNCEND ; end of section
 ;;</section>
 ;;</component>
 Q
 ;
