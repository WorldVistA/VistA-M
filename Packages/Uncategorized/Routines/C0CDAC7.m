C0CDAC7 ; GPL - Patient Portal - CCDA Routines ;09/17/13  17:05
 ;;0.1;JJOHPP;nopatch;noreleasedate;Build 1
 ;
 ; License AGPL v3.0
 ; 
 ; This software was funded in part by Oroville Hospital, and was
 ; created with help from Oroville's doctors and staff.
 Q
 ;
MEASURE ; see what smoking health factors are being used
 ;
 ;N GN S GN=$NA(^C0Q(301,59,1,"B")) ; list of patients with smoking status
 N GN S GN=$NA(^DPT)
 K ^KBAI("HF")
 N ZI S ZI=0
 F  S ZI=$O(@GN@(ZI)) Q:+ZI=0  D  ;
 . S DFN=ZI
 . S ZYR="MU14"
 . W !,"DFN: ",DFN
 . D SMOKING^C0QMU121
 ;ZWR ^KBAI("HF",*)
 Q
 ;
SOC(BLIST,DFN,CCDAWRK,CCDARPT,CCDACTRL) ;
 ;
 N CCDAV,CCDAV1
 S @CCDARPT@("STATUS")="EXTRACTING"
 S @CCDARPT@("EXTRACT-BEGIN")=$$NOW^XLFDT
 D GETPAT^C0CDACE(.CCDAV1,DFN,"health-factors")
 I '$D(CCDAV1) Q  ;
 D FILTER(.CCDAV,$NA(CCDAV1("results","healthFactors"))) ; find relevant
 S @CCDARPT@("EXTRACT-ENDS")=$$NOW^XLFDT
 ;
 ; social history section html
 ;
 N C0HTML,C0ARY
 S C0ARY("TITLE")="Social History"
 S C0ARY("HEADER",1)="Start Date"
 ;S C0ARY("HEADER",2)="End Date"
 S C0ARY("HEADER",3)="Type"
 S C0ARY("HEADER",4)="Comments"
 S C0ARY("HEADER",5)="Source"
 ;
 N C0I S C0I=0
 F  S C0I=$O(CCDAV(C0I)) Q:+C0I=0  D  ;
 . N C0DATE S C0DATE=$G(CCDAV(C0I,"factor","recorded@value"))
 . N GGID S GGID="uri_SCT-"_$G(CCDAV(C0I,"factor","snomed@code"))
 . S CCDAV(C0I,"uri")=GGID
 . Q:$$REDACT^C0CDACV(CCDAV(C0I,"uri"),.PARMS)
 . I C0DATE'="" S C0ARY(C0I,1)=$$HTMLDT^C0CDACU(C0DATE) ; health factor date
 . E  S C0ARY(C0I,1)=""
 . S C0ARY(C0I,1,"ID")=$G(CCDAV(C0I,"uri"))
 . ;S C0ARY(C0I,2)="" ;"not available"
 . S C0ARY(C0I,3)=CCDAV(C0I,"factor","snomed@text") ; health factor name
 . S C0ARY(C0I,4)="Snomed Code: "_CCDAV(C0I,"factor","snomed@code")
 . ;N ZDUZ S ZDUZ=CCDAV(C0I,"factor","id@value") ; source
 . S C0ARY(C0I,5)=CCDAV(C0I,"factor","facility@name")
 ;
 I +$O(C0ARY("AAAAA"),-1)=0 Q  ; all social history has been redacted
 ;
 ; the social history section component
 ;
 N SSECT S SSECT=$NA(@CCDAWRK@("SOCSECT"))
 D GET^C0CDACU(SSECT,"TSOCSEC^C0CDAC7")
 D QUEUE^MXMLTMPL(BLIST,SSECT,1,@SSECT@(0))
 ;
 ; social history html generation
 ;
 N SHTML S SHTML=$NA(@CCDAWRK@("SOCHTML"))
 D GENHTML^C0CDACU(SHTML,"C0ARY")
 D QUEUE^MXMLTMPL(BLIST,SHTML,1,@SHTML@(0))
 ;
 ; social history xml generation
 ;
 N WRK
 F  S C0I=$O(CCDAV(C0I)) Q:+C0I=0  D  ;
 . Q:$$REDACT^C0CDACV(CCDAV(C0I,"uri"),.PARMS)
 . K C0ARY
 . S C0ARY("uri")=$G(CCDAV(C0I,"uri"))
 . I C0ARY("uri")="" S C0ARY("uri")="uri-SCT-unknown"
 . M C0ARY=CCDAV(C0I,"factor")
 . S C0ARY("guid")=$$UUID^C0CDACU() ; random
 . S C0ARY("orgOID")=$$ORGOID^C0CDACU() ; fetch organization OID
 . N C0D S C0D=$G(CCDAV(C0I,"factor","recorded@value"))
 . N C0DATE
 . I C0D'="" D  ;
 . . S C0DATE=$$FMDTOUTC^C0CDACU(C0D)
 . E  S C0DATE=""
 . S C0ARY("effectiveDate")=C0DATE
 . S WRK=$NA(@CCDAWRK@("SOC",C0I))
 . D GETNMAP^C0CDACU(WRK,"TSOC^C0CDAC7","C0ARY")
 . D QUEUE^MXMLTMPL(BLIST,WRK,1,@WRK@(0))
 ;
 ; social history section ending
 ;
 N SOCEND S SOCEND=$NA(@CCDAWRK@("SOCEND"))
 D GET^C0CDACU(SOCEND,"TSOCEND^C0CDAC7")
 D QUEUE^MXMLTMPL(BLIST,SOCEND,1,@SOCEND@(0))
 ;
 Q
 ;
FILTER(RTN,ZARY) ; filter health factors for Smoking factors
 ; add Snomed codes and text to results
 ; RTN passed by reference. ZARY passed by name
 ;
 ; - sort not needed, the health factor are already sorted reverse data order
 ;
 N SMOTBL D SNOTBL("SMOTBL") ; initialize lookup table
 N DONE S DONE=0
 N ZI S ZI=""
 F  S ZI=$O(@ZARY@(ZI)) Q:DONE  Q:ZI=""  D  ;
 . N HF S HF=$G(@ZARY@(ZI,"factor","name@value")) ; name of the health factor
 . I '$D(SMOTBL(HF)) Q  ;
 . N SNO S SNO=$O(SMOTBL(HF,""))
 . S RTN(1,"factor","snomed@code")=SNO
 . S RTN(1,"factor","snomed@text")=$O(SMOTBL(HF,SNO,""))
 . S RTN(1,"factor","recorded@value")=$G(@ZARY@(ZI,"factor","recorded@value"))
 . S RTN(1,"factor","facility@name")=$G(@ZARY@(ZI,"factor","facility@name"))
 . S DONE=1
 I 'DONE D  ; no smoking health factors found
 . S RTN(1,"factor","snomed@code")=266927001
 . S RTN(1,"factor","snomed@text")="Unknown if ever smoked."
 . S RTN(1,"factor","recorded@value")=$$NOW^XLFDT ; we found out now
 . ;N C0FAC S C0FAC=$G(@ZARY@(ZI,"factor","facility@name"))
 . N C0FAC S C0FAC=$G(@ZARY@(1,"factor","facility@name"))
 . I C0FAC="" D  ;
 . . N C0ORG D SETORGV^C0CDAC2(.C0ORG,DUZ,$G(DUZ(2)))
 . . S C0FAC=C0ORG("orgName")
 . S RTN(1,"factor","facility@name")=C0FAC
 Q
 ;
SNOTBL(ZA) ; initializes smoking health factor snomed lookup table
 S @ZA@("Smokeless Tobacco User",77176002,"Smoker, current status unknown")=""
 S @ZA@("Current Smoker - Yes",77176002,"Smoker, current status unknown")=""
 S @ZA@("Smoking Cessation (OPH)",77176002,"Smoker, current status unknown")=""
 S @ZA@("Former Smoker",8517006,"Former smoker.")=""
 S @ZA@("Smoking (PMH)",8517006,"Former smoker.")=""
 S @ZA@("Quit Smokeless Tobacco <1 Yr Ago",8517006,"Former smoker.")=""
 S @ZA@("Quit Smokeless Tobacco > 20 Yrs Ago",8517006,"Former smoker.")=""
 S @ZA@("Quit Smokeless Tobacco: 1-5 Yrs Ago",8517006,"Former smoker.")=""
 S @ZA@("Quit Smoking",8517006,"Former smoker.")=""
 S @ZA@("Quit Smoking < 1 Yr Ago",8517006,"Former smoker.")=""
 S @ZA@("Quit Smoking > 20 Yrs Ago",8517006,"Former smoker.")=""
 S @ZA@("Quit Smoking: 1-5 Yrs Ago",8517006,"Former smoker.")=""
 S @ZA@("Quit Smoking: 10-20 Yrs Ago",8517006,"Former smoker.")=""
 S @ZA@("Quit Smoking: 5-10 Yrs Ago",8517006,"Former smoker.")=""
 S @ZA@("Non-Smoker",266919005,"Never smoker.")=""
 S @ZA@("Non-Tobacco User",266919005,"Never smoker.")=""
 S @ZA@("Current Smoker - No",266919005,"Never smoker.")=""
 S @ZA@("STATUS-CURRENT EVERY DAY SMOKER (001)",449868002,"Current every day smoker.")=""
 S @ZA@("STATUS-CURRENT SOME DAY SMOKER (002)",428041000124106,"Current some day smoker.")=""
 S @ZA@("STATUS-FORMER SMOKER (003)",8517006,"Former smoker.")=""
 S @ZA@("STATUS-NEVER SMOKER (004)",266919005,"Never smoker.")=""
 S @ZA@("STATUS-SMOKER, CURRENT STATUS UNK (005)",77176002,"Smoker, current status unknown.")=""
 S @ZA@("STATUS-UNKNOWN IF EVER SMOKED (009)",266927001,"Unknown if ever smoked.")=""
 ; gpl astro
 S @ZA@("TMG TOBACCO EVERYDAY USER",449868002,"Smokes tobacco daily (finding)")=""
 Q
 ;
SORTBD(ZOUT,ZIN) ; sort health factors to reverse date order
 N ZZI,ZZJ,ZTMP
 S ZZI=""
 F  S ZZI=$O(@ZIN@(ZZI)) Q:ZZI=""  D  ;
 . N ZDT S ZDT=$G(@ZIN@(ZZI,"factor","recorded@value"))
 . I ZDT="" Q  ;
 . S ZTMP(ZDT,ZZI)=""
 S ZZI=""
 S ZCNT=0
 F  S ZZI=$O(ZTMP(ZZI),-1) Q:ZZI=""  D  ;
 . S ZCNT=ZCNT+1
 . M @ZOUT@(ZCNT)=@ZIN@($O(ZTMP(ZZI,"")))
 Q
 ;
ICD9() ; ICD-9-CM OID
 Q "2.16.840.1.113883.6.103^ICD-9-CM"
SNOMED() ; SNOMED-CT
 Q "2.16.840.1.113883.6.96^SNOMED-CT"
 ;
TSOCSEC ;
 ;;<component>
 ;;<section classCode="DOCSECT" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.17"></templateId>
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.17" extension="2015-08-01"></templateId>
 ;;<code code="29762-2" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Social History"></code>
 Q
 ;
TSOC ;
 ;;<entry>
 ;;<observation classCode="OBS" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.78"></templateId>
 ;;<id extension="@@guid@@" root="@@orgOID@@"></id>
 ;;<code code="ASSERTION" codeSystem="2.16.840.1.113883.5.4"></code>
 ;;<text>
 ;;<reference value="#@@uri@@"></reference>
 ;;</text>
 ;;<statusCode code="completed"></statusCode>
 ;;<effectiveTime>
 ;;<low value="@@effectiveDate@@"></low>
 ;;</effectiveTime>
 ;;<value code="@@snomed@code@@" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED" displayName="@@snomed@text@@" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="CD"></value>
 ;;<entryRelationship contextConductionInd="true" typeCode="REFR">
 ;;<observation classCode="OBS" moodCode="EVN">
 ;;<code code="48766-0" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Information source"></code>
 ;;<statusCode code="completed"></statusCode>
 ;;<value xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="ST">@@facility@name@@</value>
 ;;</observation>
 ;;</entryRelationship>
 ;;</observation>
 ;;</entry>
 Q
 ;
TSOCEND ;
 ;;</section>
 ;;</component>
 Q
 ;
