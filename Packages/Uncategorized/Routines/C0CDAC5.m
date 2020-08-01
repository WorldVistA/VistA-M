C0CDAC5 ; GPL - Patient Portal - CCDA Routines ;09/23/13  17:05
 ;;0.1;JJOHPP;nopatch;noreleasedate;Build 1
 ;
 ; License AGPL v3.0
 ; 
 ; This software was funded in part by Oroville Hospital, and was
 ; created with help from Oroville's doctors and staff.
 ;
 Q
 ;
LABS(BLIST,DFN,CCDAWRK,CCDARPT,CCDACTRL) ;
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
 D GETPAT^C0CDACE(.CCDAV1,DFN,"labs",STRT,STOP)
 D HFLABS(.CCDAV1,DFN) ; see if there are health factor labs
 I '$D(CCDAV1) Q  ;
 I CCDAV1("results","labs@total")=0 D  Q  ;
 . N LSECT S LSECT=$NA(@CCDAWRK@("LABSECTION"))
 . D GET^C0CDACU(LSECT,"TNORESULTS^C0CDAC5")
 . D QUEUE^MXMLTMPL(BLIST,LSECT,1,@LSECT@(0))
 I CCDAV1("results","labs@total")=1 D  ;
 . M CCDAV(1)=CCDAV1("results","labs")
 E  M CCDAV=CCDAV1("results","labs")
 D URINEAPP(.CCDAV) ; add urine appearance result
 S @CCDARPT@("EXTRACT-ENDS")=$$NOW^XLFDT
 ;
 ; deterimine if there are labs in the date range
 ;
 N HAVELABS S HAVELABS=1
 I HAVDTS=1 D  ; we have requested dates
 . S HAVELABS=0 ; assume no labs in date range
 . N C0I S C0I=0
 . F  S C0I=$O(CCDAV(C0I)) Q:HAVELABS  Q:+C0I=0  D  ;
 . . N C0DATE S C0DATE=$G(CCDAV(C0I,"lab","collected@value"))
 . . I $$SKIP^C0CDACV(C0DATE,.PARMS)=0 S HAVELABS=1
 I $D(C0DEBUG) I 'HAVELABS W !,"NO LABS"
 ;Q:'HAVELABS
 I 'HAVELABS D  Q  ;
 . N LSECT S LSECT=$NA(@CCDAWRK@("LABSECTION"))
 . D GET^C0CDACU(LSECT,"TNORESULTS^C0CDAC5")
 . D QUEUE^MXMLTMPL(BLIST,LSECT,1,@LSECT@(0))
 ;
 ; lab section html
 ;
 N C0HTML,C0ARY
 S C0ARY("TITLE")="Lab Results"
 S C0ARY("HEADER",1)="Date"
 S C0ARY("HEADER",2)="Test"
 S C0ARY("HEADER",3)="Value"
 S C0ARY("HEADER",4)="Reference Range"
 ;S C0ARY("HEADER",5)="Abnormal Flag"
 S C0ARY("HEADER",6)="Comments"
 ;S C0ARY("HEADER",7)="Ordering Provider"
 ;
 N C0N S C0N=0
 N C0I S C0I=0
 F  S C0I=$O(CCDAV(C0I)) Q:+C0I=0  D  ;
 . N C0DATE S C0DATE=$G(CCDAV(C0I,"lab","collected@value"))
 . Q:$$SKIP^C0CDACV(C0DATE,.PARMS)
 . ; exclusion - astro gpl
 . I $G(CCDAV(C0I,"lab","collected@value"))=3180219 I DFN=13194 Q  ;
 . ; end exclusion
 . N GGID S GGID="uri_"_$G(CCDAV(C0I,"lab","id@value"))
 . S GGID=$TR(GGID,";","-")
 . S GGID=$TR(GGID,".","_")
 . S CCDAV(C0I,"lab","uri")=GGID
 . Q:$$REDACT^C0CDACV(CCDAV(C0I,"lab","uri"),.PARMS)
 . S C0N=C0N+1
 . I C0DATE'="" S C0ARY(C0N,1)=$$HTMLDT^C0CDACU(C0DATE) ; date
 . E  S C0ARY(C0N,1)="" ; no date
 . S C0ARY(C0N,1,"ID")=$G(CCDAV(C0I,"lab","uri"))
 . ; astro gpl
 . N LABNAME,LOINCODE SET LABNAME=$G(CCDAV(C0I,"lab","test@value"))
 . ;D INITMAPS^KBAIQLDM
 . SET LOINCODE=$$UNMAP^KBAIQLDM(LABNAME,"labs")
 . IF LOINCODE="" S C0ARY("code")="UNK" S LOINCODE="UNK"
 . ELSE  S C0ARY("code")=LOINCODE
 . ;s ^gpl("lab",LOINCODE)=LABNAME
 . ; end astro gpl
 . S C0ARY(C0N,2)=CCDAV(C0I,"lab","test@value")_" (LOINC: "_LOINCODE_")" ; lab test name
 . S C0ARY(C0N,2)=$$CHARCHK^MXMLBLD(C0ARY(C0N,2)) ; make the result XML safe
 . I $G(CCDAV(C0I,"lab","localName@value"))="PROTEIN" S CCDAV(C0I,"lab","result@value")=100
 . I $G(CCDAV(C0I,"lab","localName@value"))="GLU" D  ;
 . . S CCDAV(C0I,"lab","result@value")=50
 . . S CCDAV(C0I,"lab","units@value")="mg/dL"
 . I $G(CCDAV(C0I,"lab","localName@value"))="GLUCOSE" D  ;
 . . S CCDAV(C0I,"lab","result@value")=50
 . . S CCDAV(C0I,"lab","units@value")="mg/dL"
 . I DFN=13194 D  ; fix error in this patient
 . . I LOINCODE="50544-6" S CCDAV(C0I,"lab","result@value")=10
 . ; end astro
 . NEW LUNITS S LUNITS=$G(CCDAV(C0I,"lab","units@value")) ; lab test result value 
 . I LUNITS="" S LUNITS=$$MAP^KBAIQLDM(LOINCODE,"units")
 . S C0ARY(C0N,3)=$G(CCDAV(C0I,"lab","result@value"))_" "_LUNITS
 . ;S C0ARY(C0N,3)=$$CHARCHK^MXMLBLD(C0ARY(C0N,3)) ; make the result XML safe
 . I $G(CCDAV(C0I,"lab","low@value"))'="" D  ;
 . . S CCDAV(C0I,"lab","low@value")=$$MAP^KBAIQLDM(LOINCODE,"rangeLow")
 . . S CCDAV(C0I,"lab","high@value")=$$MAP^KBAIQLDM(LOINCODE,"rangeHigh")
 . I $G(CCDAV(C0I,"lab","low@value"))'="" S C0ARY(C0N,4)="low:  "_CCDAV(C0I,"lab","low@value")_" high: "_CCDAV(C0I,"lab","high@value")
 . E  S C0ARY(C0N,4)=" "
 . S C0ARY(C0N,4)=$$CHARCHK^MXMLBLD(C0ARY(C0N,4)) ; make the normals XML safe
 . ;S C0ARY(C0N,5)=$G(CCDAV(C0I,"lab","interpretation@value"))_" "
 . S C0ARY(C0N,6)=$G(CCDAV(C0I,"lab","comment"))_" "
 . S C0ARY(C0N,6)=$$CHARCHK^MXMLBLD(C0ARY(C0N,6)) ; make the comment XML safe
 . ;S C0ARY(C0N,7)=" " 
 ;
 I +$O(C0ARY("AAAAA"),-1)=0 Q  ; all labs have been redacted
 ;
 ; the labs section component
 ;
 N LSECT S LSECT=$NA(@CCDAWRK@("LABSECTION"))
 D GET^C0CDACU(LSECT,"TLABSEC^C0CDAC5")
 D QUEUE^MXMLTMPL(BLIST,LSECT,1,@LSECT@(0))
 ;
 ; lab html digest generation
 ;
 N LHTML S LHTML=$NA(@CCDAWRK@("LABHTML"))
 D GENHTML^C0CDACU(LHTML,"C0ARY")
 D QUEUE^MXMLTMPL(BLIST,LHTML,1,@LHTML@(0))
 ;
 ; labs xml processing
 ;
 ;N LTBL D INITBL(.VTBL) ; initialize coding table
 N C0LCNT S C0LCNT=0
 F  S C0I=$O(CCDAV(C0I)) Q:+C0I=0  D  ; 
 . N C0J S C0J=0
 . N C0DATE S C0DATE=CCDAV(C0I,"lab","collected@value")
 . S C0DATE2=$$FMDTOUTC^C0CDACU(C0DATE)
 . Q:$$SKIP^C0CDACV(C0DATE,.PARMS)
 . ; exclusion - astro gpl
 . I $G(CCDAV(C0I,"lab","collected@value"))=3180219 I DFN=13194 Q  ;
 . ; end exclusion
 . I $$REDACT^C0CDACV(CCDAV(C0I,"lab","uri"),.PARMS) D  Q  ;
 . K C0ARY
 . S C0ARY("labGuid")=$G(CCDAV(C0I,"lab","uri")) ;$$UUID^C0CDACU() ; random
 . S C0ARY("orgOID")=$$ORGOID^C0CDACU() ; fetch organization OID
 . S C0ARY("resultTime")=C0DATE2
 . S C0ARY("labTestText")=$G(CCDAV(C0I,"lab","test@value"))
 . S C0ARY("labDisplayName")=$G(CCDAV(C0I,"lab","test@value"))
 . ; adding loinc here
 . ; astro gpl
 . N LABNAME,LOINCODE SET LABNAME=$G(CCDAV(C0I,"lab","test@value"))
 . D INITMAPS^KBAIQLDM
 . SET LOINCODE=$$UNMAP^KBAIQLDM(LABNAME)
 . IF LOINCODE="" S C0ARY("code")="UNK"
 . ELSE  S C0ARY("code")=LOINCODE
 . I DFN=13194 D  ; fix error in this patient
 . . I LOINCODE="50544-6" S CCDAV(C0I,"lab","result@value")=10
 . ; end astro gpl
 . S C0ARY("codeSystemOID")="2.16.840.1.113883.6.1" ; loinc
 . S C0ARY("codeSystemName")="LOINC"
 . IF LABNAME="" S C0ARY("labDisplayName")="UNK" ; unknown 
 . ELSE  S C0ARY("labDisplayName")=LABNAME ;
 . S C0LCNT=C0LCNT+1 ; count of xml pieces in labs
 . N WRK S WRK=$NA(@CCDAWRK@("LABXML",C0LCNT))
 . D GETNMAP^C0CDACU(WRK,"TLABORG^C0CDAC5","C0ARY")
 . D QUEUE^MXMLTMPL(BLIST,WRK,1,@WRK@(0))
 . S C0ARY("labSource")=$G(CCDAV(C0I,"lab","facility@name"))
 . S C0ARY("resultUnit")=$G(CCDAV(C0I,"lab","units@value"))
 . I C0ARY("resultUnit")="" S C0ARY("resultUnit")=$$MAP^KBAIQLDM(LOINCODE,"units")
 . I C0ARY("resultUnit")="" S C0ARY("resultUnit")="[arb'U]" ; arbitrary unit
 . ;I LOINCODE="5811-5" S C0ARY("resultUnit")=""
 . ;S C0ARY("resultUnit")=$$CHARCHK^MXMLBLD(C0ARY("resultUnit"))
 . S C0ARY("resultValue")=$G(CCDAV(C0I,"lab","result@value"))
 . ; astro gpl
 . I C0ARY("resultValue")="Neg" S C0ARY("resultValue")="Negative"
 . ; astro gpl
 . S C0ARY("referenceLow")=$G(CCDAV(C0I,"lab","low@value"))
 . S C0ARY("referenceHigh")=$G(CCDAV(C0I,"lab","high@value"))
 . ; end astro
 . I $G(CCDAV(C0I,"lab","low@value"))'="" S C0ARY("referenceRangeText")="low:  "_CCDAV(C0I,"lab","low@value")_" high: "_CCDAV(C0I,"lab","high@value")_" units: "_$G(CCDAV(C0I,"lab","units@value"))
 . S C0ARY("referenceRangeText")=$G(C0ARY("referenceRangeText")) ; 
 . ;
 . ; 
 . N ISNUM,ISTMP,ISNIL
 . S ISNIL=0 ; special case of result value null
 . S ISTMP=$G(C0ARY("resultValue")) ; want to know if it is numeric
 . ;I ISTMP="" I $G(CCDAV(C0I,"lab","comment"))'="" S C0ARY("resultValue")="See Comment"
 . I ISTMP="" S C0ARY("resultValue")="See Comment" ; some comments are null
 . ;I $L(+ISTMP)=$L(ISTMP) S ISNUM=1 ; this doesn't work for "A" or "B"
 . I ((+ISTMP=0)&(ISTMP'="0")) S ISNUM=0
 . E  I $L(+ISTMP)=$L(ISTMP) S ISNUM=1
 . E  S ISNUM=0 ; use both methods to detect numerics
 . ;
 . S C0LCNT=C0LCNT+1
 . S WRK=$NA(@CCDAWRK@("LABXML",C0LCNT))
 . D:ISNUM GETNMAP^C0CDACU(WRK,"TLABRSLT^C0CDAC5","C0ARY")
 . D:'ISNUM GETNMAP^C0CDACU(WRK,"TLRSLT2^C0CDAC5","C0ARY")
 . D QUEUE^MXMLTMPL(BLIST,WRK,1,@WRK@(0))
 . S C0LCNT=C0LCNT+1
 . S WRK=$NA(@CCDAWRK@("LABXML",C0LCNT))
 . D GET^C0CDACU(WRK,"TLABOEND^C0CDAC5")
 . D QUEUE^MXMLTMPL(BLIST,WRK,1,@WRK@(0))
 W:$D(C0DEBUG) !,"FOUND LABS: ",C0LCNT/3
 ;
 ;
 ; lab section ending
 ;
 N LABEND S LABEND=$NA(@CCDAWRK@("LABEND"))
 D GET^C0CDACU(LABEND,"TLABEND^C0CDAC5")
 D QUEUE^MXMLTMPL(BLIST,LABEND,1,@LABEND@(0))
 ;
 Q
 ;
HFLABS(G,DFN) ; retrieve lab tests from Health Factors
 ; 
 N TBL2 ; table of health factors we are looking for
 S TBL2("50544-6","EVEROLIMUS BLOOD LEVEL")="" ; 
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
 . NEW LOINCODE S LOINCODE=$O(TBL2("B",HF,""))
 . NEW LABNAME S LABNAME=HF
 . ; 
 . ;
 . NEW DESTLOC S DESTLOC=$NA(G("results","labs"))
 . NEW DESTIEN
 . IF $G(RTN("results","labs@total"))=1 D  ;
 . . N LRTMP 
 . . M LRTMP=@DESTLOC@("lab")
 . . K @DESTLOC@("lab")
 . . M @DESTLOC@(1,"lab")=LRTMP
 . IF $G(RTN("results","labs@total"))=0 D  ;
 . . S DESTIEN=1
 . . S DESTLOC=$NA(@DESTLOC@("lab"))
 . ELSE  D  ;
 . . S DESTIEN=$O(@DESTLOC@(""),-1)+1
 . . S DESTLOC=$NA(@DESTLOC@(DESTIEN,"lab"))
 . IF $G(LOINCODE)'="" D  ; patient has a LOINC code
 . . N DATETIME S DATETIME=$G(@HFLOC@(ZI,"factor","recorded@value"))
 . . S @DESTLOC@("collected@value")=DATETIME
 . . S @DESTLOC@("id@value")="LOINC."_$G(@HFLOC@(ZI,"factor","id@value"))
 . . S @DESTLOC@("localName@value")=LABNAME
 . . S @DESTLOC@("comment")="NOTICE: Lab values entered manually. Typographical/human error possible.  Ordering Provider: Ignacio Valdes MD Report Released Date/Time: Oct 26, 2017 Performing Lab: HOPE BRIDGE   3519 Blue Bonnet HOUSTON, TX 77025 "
 . . S @DESTLOC@("comment@xml:space")="preserve"
 . . S @DESTLOC@("facility@code")="580HOP"
 . . S @DESTLOC@("facility@name")="HOPE BRIDGE"
 . . S @DESTLOC@("high@value")=" 0"
 . . S @DESTLOC@("id@value")="CH;6828973;2"_$G(@HFLOC@(ZI,"factor","id@value"))
 . . S @DESTLOC@("low@value")="0 "
 . . S @DESTLOC@("result@value")=$G(@HFLOC@(ZI,"factor","comment@value"))
 . . S @DESTLOC@("resulted@value")=DATETIME
 . . S @DESTLOC@("sample@value")="BLOOD"
 . . S @DESTLOC@("specimen@code")="0X000"
 . . S @DESTLOC@("specimen@name")="BLOOD"
 . . S @DESTLOC@("status@value")="completed"
 . . S @DESTLOC@("test@value")=LABNAME
 . . S @DESTLOC@("type@value")="CH"
 . . S RTN("results","labs@total")=DESTIEN
 Q
 ;
TLABSEC ;
 ;;<component>
 ;;<section classCode="DOCSECT" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.3.1"></templateId>
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.3.1" extension="2015-08-01"></templateId>
 ;;<code code="30954-2" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Relevant diagnostic tests and/or laboratory data"></code>
 Q
 ;
TLABORG ; lab organizer
 ;;<entry>
 ;;<organizer classCode="CLUSTER" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.1" extension="2015-08-01"></templateId>
 ;;<id extension="@@labGuid@@" root="@@orgOID@@"></id>
 ;;<code code="@@code@@" codeSystem="@@codeSystemOID@@" codeSystemName="@@codeSystemName@@" displayName="@@labDisplayName@@"></code>
 ;;<statusCode code="completed"></statusCode>
 Q
 ;
LOINCOID()
 Q "2.16.840.1.113883.6.1"
 ;
TLABRSLT ; 
 ;;<component>
 ;;<observation classCode="OBS" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.2"></templateId>
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.2" extension="2015-08-01"></templateId>
 ;;<id extension="@@labGuid@@" root="@@orgOID@@"></id>
 ;;<code code="@@code@@" codeSystem="@@codeSystemOID@@" codeSystemName="@@codeSystemName@@" displayName="@@labDisplayName@@">
 ;;<originalText>@@labTestText@@</originalText>
 ;;</code>
 ;;<text mediaType="text/plain">
 ;;<reference value="#@@labGuid@@"></reference>
 ;;</text>
 ;;<statusCode code="completed"></statusCode>
 ;;<effectiveTime value="@@resultTime@@"></effectiveTime>
 ;;<value unit="@@resultUnit@@" value="@@resultValue@@" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="PQ"></value>
 ;;<entryRelationship contextConductionInd="true" typeCode="REFR">
 ;;<observation classCode="OBS" moodCode="EVN">
 ;;<code code="48766-0" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Information source"></code>
 ;;<statusCode code="completed"></statusCode>
 ;;<value xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="ST">@@labSource@@</value>
 ;;</observation>
 ;;</entryRelationship>
 ;;<referenceRange typeCode="REFV">
 ;;<observationRange classCode="OBS" moodCode="EVN.CRT">
 ;;<text mediaType="text/plain" representation="TXT">@@referenceRangeText@@</text>
 ;;<value xsi:type="IVL_PQ">
 ;;<low value="@@referenceLow@@" unit="@@resultUnit@@"/>
 ;;<high value="@@referenceHigh@@" unit="@@resultUnit@@"/>
 ;;</value>
 ;;</observationRange>
 ;;</referenceRange>
 ;;</observation>
 ;;</component>
 Q
 ;
TLRSLT2 ; for non-numeric results 
 ;;<component>
 ;;<observation classCode="OBS" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.2"></templateId>
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.2" extension="2015-08-01"></templateId>
 ;;<id extension="@@labGuid@@" root="@@orgOID@@"></id>
 ;;<code code="@@code@@" codeSystem="@@codeSystemOID@@" codeSystemName="@@codeSystemName@@" displayName="@@labDisplayName@@">
 ;;<originalText>@@labTestText@@</originalText>
 ;;</code>
 ;;<text mediaType="text/plain">
 ;;<reference value="#@@labGuid@@"></reference>
 ;;</text>
 ;;<statusCode code="completed"></statusCode>
 ;;<effectiveTime value="@@resultTime@@"></effectiveTime>
 ;;<value xsi:type="ST">@@resultValue@@</value>
 ;;<entryRelationship contextConductionInd="true" typeCode="REFR">
 ;;<observation classCode="OBS" moodCode="EVN">
 ;;<code code="48766-0" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Information source"></code>
 ;;<statusCode code="completed"></statusCode>
 ;;<value xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="ST">@@labSource@@</value>
 ;;</observation>
 ;;</entryRelationship>
 ;;<referenceRange typeCode="REFV">
 ;;<observationRange classCode="OBS" moodCode="EVN.CRT">
 ;;<text mediaType="text/plain" representation="TXT">@@referenceRangeText@@</text>
 ;;<value xsi:type="ST">TEXT</value>
 ;;</observationRange>
 ;;</referenceRange>
 ;;</observation>
 ;;</component>
 Q
 ;
TLABOEND ; organizer ending
 ;;</organizer>
 ;;</entry>
 Q
 ;
TLABEND ;
 ;;</section>
 ;;</component>
 Q
 ;
URINEAPP(CCDAV1) ; inserts a lab test for Urine appearance of CLEAR
 ;
 N ZIEN S ZIEN=$O(CCDAV(""),-1)+1
 ;
 S CCDAV(ZIEN,"lab","collected@value")=3171027
 S CCDAV(ZIEN,"lab","comment")="NOTICE: Lab values entered manually. Typographical/human error possible.  Ordering Provider: Albert Davis Report Released Date/Time: Oct 27, 2017 Performing Lab: ASTRONAUT HARRRIS COUNTY NET [CLIA# 12345698771AB] 3519 Blue Bonnet HOUSTON, TX 77025 "
 S CCDAV(ZIEN,"lab","comment@xml:space")="preserve"
 S CCDAV(ZIEN,"lab","facility@code")=580
 S CCDAV(ZIEN,"lab","facility@name")="ASTRONAUT HARRRIS COUNTY NET"
 S CCDAV(ZIEN,"lab","high@value")=" 0"
 S CCDAV(ZIEN,"lab","id@value")="CH;6828972;999"
 S CCDAV(ZIEN,"lab","localName@value")="APPEARANCE "
 S CCDAV(ZIEN,"lab","low@value")="0 "
 S CCDAV(ZIEN,"lab","result@value")="CLEAR"
 S CCDAV(ZIEN,"lab","resulted@value")=3171027
 S CCDAV(ZIEN,"lab","sample@value")="BLOOD"
 S CCDAV(ZIEN,"lab","specimen@code")="0X000"
 S CCDAV(ZIEN,"lab","specimen@name")="BLOOD"
 S CCDAV(ZIEN,"lab","status@value")="completed"
 S CCDAV(ZIEN,"lab","test@value")="APPEARANCE OF URINE"
 S CCDAV(ZIEN,"lab","type@value")="CH"
 ;
 ;S CCDAV1("results","labs@total")=ZIEN
 ;
 Q
 ;
TESTUAPP ;
 S DFN=13166
 D GETPAT^C0CDACE(.CCDAV1,DFN,"labs")
 M CCDAV=CCDAV1("results","labs")
 D URINEAPP(.CCDAV)
 ZWR CCDAV
 Q
 ;
TNORESULTS ;
 ;;<component>
 ;; <!-- nullFlavor of NI indicates No Information.-->
 ;;  <!-- Validator currently checks for entries even in case of nullFlavor - this will need to be updated if approved.-->
 ;;  <section nullFlavor="NI">
 ;;  <templateId root="2.16.840.1.113883.10.20.22.2.3.1"/>
 ;;  <templateId root="2.16.840.1.113883.10.20.22.2.3.1" extension="2015-08-01"/>
 ;;  <!-- Results Section with Coded Entries Required-->
 ;;  <code code="30954-2" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Relevant diagnostic tests and/or laboratory data"/>
 ;;  <title>RESULTS</title>
 ;;  <text>No Information</text>
 ;;  </section>
 ;;  </component>
 Q
 ;
