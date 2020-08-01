C0CDAPCE ; GPL - encounter handling routines ;8/29/13  17:05
 ;;0.1;C0CDA;nopatch;noreleasedate;Build 1
 ;
 ; License AGPL v3.0
 ; 
 Q
 ;
PCE2DATA(RTN,FILTER) ; retrieve a patient's encounters
 ; includes results from VISIT, V CPT, V STANDARD CODES, V HEALTH FACTORS, AND V POV
 ; options are specifies in the filter
 ; FILTER("dfn") or FILTER("patientId") are the dfn of the patient
 ; FILTER("format") is:
 ;    mumps (default)
 ;    xml
 ;    json  - json version of Fileman fields
 ;    json-vpr - json version of vpr field names
 ;    json-camel - json version of Fileman field names converted to camel case
 ;    json-fhir - json FHIR resources
 ;    data2pce - format which could be direcly used by DATA2PCE
 ; FILTER("ien") is the ien of the Visit - optional 
 ; FILTER("startDate") beginning of the search for visits - optional
 ; FILTER("endDate") end of the search for visits - optional
 ; if no ien or startDate is provided, all visits will be returned
 ; if endDate is not provided, NOW will be used.
 ; FILTER("cqm")="CMSXXXvY" only returns elements used by the CMS quality measure - eg. CMS128v5
 ;
 ;
 N DFN,C0CDAI,C0CDAJ,WORK,START,STOPT
 ;
 S DFN=$G(FILTER("dfn"))
 I DFN="" S DFN=$G(FILTER("patientId"))
 I DFN="" D  Q  ;
 . S RTN="-1^No patient specified"
 ;
 S START=$G(FILTER("startDate"))
 S STOP=$G(FILTER("endDate"))
 ;
 ;D GET^VPRD(.RTNTMP,DFN,"visit",START,STOP)
 D GET^HMPDJ(.RTNTMP,DFN,"visit",START,STOP)
 ;K ^TMP("MXMLDOM",$J,1)
 N C0CDADID
 S C0CDADID=$$PARSE(RTNTMP,DFN_"-visits")
 N ZDOM S ZDOM=$NA(^TMP("MXMLDOM",$J,C0CDADID))
 d domo3^C0CDACE("WORK",,,ZDOM)
 N FORMAT S FORMAT=$G(FILTER("format"))
 I FORMAT="" S FORMAT="mumps"
 I FORMAT["mumps" D  Q  ;
 . S RTN=$NA(^TMP("C0CDAPCE",$J))
 . K @RTN
 . M @RTN@("visits")=WORK("results","visits")
 Q
 ;
PARSE(INXML,INDOC) ;CALL THE MXML PARSER ON INXML, PASSED BY NAME
 ; INDOC IS PASSED AS THE DOCUMENT NAME - DON'T KNOW WHERE TO STORE THIS NOW
 ; EXTRINSIC WHICH RETURNS THE DOCID ASSIGNED BY MXML
 ;Q $$EN^MXMLDOM(INXML)
 Q $$EN^MXMLDOM(INXML,"W")
 ;
 
