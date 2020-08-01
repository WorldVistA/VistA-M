ISIIMPU4 ;ISI GROUP/MLS -- PROBLEM IMPORT Utility
 ;;1.0;;;Jun 26,2012;Build 93
 Q
 ;
 ; Column definitions for MISCDEF table (below):
 ; NAME=        name of parameter
 ; TYPE =       categories of values provided
 ;                      'PARAM' is internal used value 
 ;                      'FIELD' is a literal import value
 ;                      'MASK' is dynamic value w/ * wildcard
 ; DESC  =      description of value
 ;
 ; Array example: 
 ;      MISC(1)="PROBLEM|DIABETES"
 ;      MISC(2)="PROVIDER|ONE,DOCTOR"
 ;      MISC(4)="PAT_SSN|555005555"
 ;
MISCDEF ;;+++++ DEFINITIONS OF PROBLEM MISC PARAMETERS +++++
 ;;NAME             |TYPE       |FILE,FIELD    |DESC
 ;;-----------------------------------------------------------------------
 ;;PROBLEM          |FIELD      |#757.01,.01   |PROBLEM Description
 ;;PROVIDER         |FIELD      |#9000011,1.04 |PROVIDER NAME
 ;;PAT_SSN          |FIELD      |#2,.09        |PATIENT SSN
 ;;STATUS           |FIELD      |#9000011,.12  |'A'ctive or 'I'active
 ;;ENTERED          |FIELD      |#9000011,.8   |.8 (DATE ENTERED) and if not supplied 1.09 (DATE RECORDED)
 ;;ONSET            |FIELD      |#9000011,.13  |Onset DATE
 ;;RESOLVED         |FIELD      |#9000011,1.07 |Date Resolved
 ;;LOCATION         |FIELD      |#9000011,1.08 |CLINIC LOCATION
 ;;RECORDED         |FIELD      |#9000011,1.09 |DATE RECORDED
 ;;TYPE             |FIELD      |#9000011,1.14 |PRIORITY ('A'ccute or 'C'hronic)
 ;;VPOV             |PARAM      |              |(Y/N) Try to create V POV entry
 Q
 ;
PROBMISC(MISC,ISIMISC) 
 ;
 ;INPUT: 
 ;  MISC(0)=PARAM^VALUE - raw list values from RPC client
 ;
 ;OUTPUT:
 ;  ISIMISC(PARAM)=VALUE
 ;
 N MISCDEF
 K ISIMISC
 D LOADMISC(.MISCDEF) ; Load MISC definition params
 S ISIRC=$$PROBMISC1("ISIMISC")
 Q ISIRC ;return code
 ;
PROBMISC1(DSTNODE) 
 N PARAM,VALUE,DATE,RESULT,MSG,EXIT
 S (EXIT,ISIRC)=0,(I,VALUE)=""
 F  S I=$O(MISC(I))  Q:I=""  D  Q:EXIT
 . S PARAM=$$TRIM^XLFSTR($P(MISC(I),U))  Q:PARAM=""
 . S VALUE=$$TRIM^XLFSTR($P(MISC(I),U,2))
 . I '$D(MISCDEF(PARAM)) S ISIRC="-1^Bad parameter title passed: "_PARAM,EXIT=1 Q
 . I VALUE="" S ISIRC="-1^No data provided for parameter: "_PARAM,EXIT=1 Q
 . I (PARAM="ONSET"!((PARAM="ENTERED")!(PARAM="RESOLVED"))) D  
 . . S DATE=VALUE D DT^DILF("T",DATE,.RESULT,"",.MSG)
 . . I RESULT<0 S EXIT=1,ISIRC="-1^Invalid ONSET, ENTERED, or RESOLVED date." Q
 . . S VALUE=RESULT
 . I EXIT Q
 . S @DSTNODE@(PARAM)=VALUE
 . Q
 Q ISIRC ;return code
 ;
LOADMISC(MISCDEF) ;
 N BUF,FIELD,I,NAME,TYPE
 K MISCDEF
 F I=3:1  S BUF=$P($T(MISCDEF+I),";;",2)  Q:BUF=""  D
 . S NAME=$$TRIM^XLFSTR($P(BUF,"|"))  Q:NAME=""
 . S TYPE=$$TRIM^XLFSTR($P(BUF,"|",2))
 . S FIELD=$$TRIM^XLFSTR($P(BUF,"|",3))
 . S MISCDEF(NAME)=TYPE_"|"_FIELD
 Q
 ;
VALPROB(ISIMISC)
 ; Entry point to validate content of PROBLEM create/array
 ; 
 ; Input - ISIMISC(ARRAY)
 ; Format:  ISIMISC(PARAM)=VALUE
 ;     eg:  ISIMISC("PROBLEM")="DIABETES" 
 ;
 ; Output - ISIRC [return code]
 ; 
 N FILE,FIELD,FLAG,VALUE,RESULT,MSG,MISCDEF,EXIT,OUT,Y
 N MAJCON,CODE,ICD,ICDIEN,EXPIEN,DFN,EXPNM
 S (OUT,EXIT)=0,(MAJCON,CODE,ICD,ICDIEN,EXPIEN,DFN,EXPNM)=""
 ;
 ;-- PROBLEM (required) --
 I '$D(ISIMISC("PROBLEM")) Q "-1^Missing PROBLEM param."
 I $G(ISIMISC("PROBLEM"))="" Q "-1^Missing value for PROBLEM."
 S VALUE=ISIMISC("PROBLEM")
 S (OUT,EXPIEN)=""
 ;
 N ISISNOMD S ISISNOMD=0
 I $D(^LEX(757.02,"ACODE",VALUE_" ")) D  
 . S X=VALUE I $S(X?.1A2.3N1".".2N:1,X?.1A2.3N1"+":1,1:0) Q  ;no ICD9 Lookup, only snomed
 . S ISISNOMD=$O(^LEX(757.02,"ACODE",VALUE_" ",0))
 . N LST D LEX^ORQQPL4(.LST,VALUE,"PLS",0)
 . Q:'$D(@LST)
 . N STRNG S STRNG=@LST@(1) Q:'(+STRNG)
 . S ICD=$P(STRNG,U,3),ICDIEN=$P(STRNG,U,4)
 . S EXPIEN=+STRNG,EXPNM=$P(STRNG,U,2)
 . Q
 ;
 I ISISNOMD,'ICD D  
 . S X=$G(^LEX(757.02,ISISNOMD,0)),EXPIEN=$P(X,U),MAJCON=$P(X,U,4)
 . S ICD="799.9" ;hard coded for Oroville
 . S EXPNM=$G(^LEX(757.01,EXPIEN,0))
 . Q
 ;
 I '$G(EXPIEN),$S(VALUE?.1A2.3N1".".2N:1,VALUE?.1A2.3N1"+":1,1:0) D  
 . I $D(^LEX(757.01,"B",VALUE)) Q
 . S ICDIEN=+$$CODEN^ICDCODE(VALUE,"80")
 . S Y=$$ICD^VPRDVSIT(ICDIEN)
 . S VALUE=$P(Y,U,2)
 . Q
 ;
 I '$G(EXPIEN) D  
 . F  S EXPIEN=$O(^LEX(757.01,"B",VALUE,EXPIEN)) Q:'EXPIEN  D  Q:OUT=1
 . . S EXPNM=$G(^LEX(757.01,EXPIEN,0)) Q:EXPNM=""
 . . S MAJCON=$P($G(^LEX(757.01,EXPIEN,1)),"^") Q:MAJCON=""
 . . S CODE="" F  S CODE=$O(^LEX(757.02,"AMC",MAJCON,CODE)) Q:'CODE  D  Q:OUT=1
 . . . S ICD=$P($G(^LEX(757.02,CODE,0)),"^",2) Q:ICD=""
 . . . S Y=$P($G(^LEX(757.03,$P($G(^LEX(757.02,CODE,0)),"^",3),0)),"^")
 . . . I Y="ICD9" S OUT=1 Q
 . . . Q
 . . Q
 . Q
 ;
 I EXPNM="" S EXIT=1
 I 'EXPIEN S EXIT=1
 I ICD="" S EXIT=1
 I 'ICDIEN S ICDIEN=$O(^ICD9("AB",ICD_" ","")) I ICDIEN="" S EXIT=1
 I EXIT Q "-1^Invalid data for PROBLEM."
 S ISIMISC("EXPIEN")=EXPIEN,ISIMISC("ICD")=ICD
 S ISIMISC("ICDIEN")=ICDIEN,ISIMISC("EXPNM")=EXPNM
 I ISISNOMD S ISIMISC("SNOMED")=ISIMISC("PROBLEM")
 ;
 ;-- PROVIDER (required)-- 
 I $D(ISIMISC("PROVIDER")) D  
 . S VALUE=$G(ISIMISC("PROVIDER")) I VALUE="" S EXIT=1 Q
 . I '$D(^VA(200,"AK.PROVIDER",VALUE)) S EXIT=1 Q
 . S ISIMISC("PROVIDER")=$O(^VA(200,"AK.PROVIDER",VALUE,""))
 . Q
 I EXIT Q "-1^Invalid data for PROVIDER."
 ;
 I '$D(ISIMISC("PROVIDER")) Q "-1^Missing PROVIDER (#2,.01)"  
 ;
 ;-- PAT_SSN (required) --
 I '$D(ISIMISC("PAT_SSN")) Q "-1^Missing Patient SSN (#2,.09)."
 I $D(ISIMISC("PAT_SSN")) D  
 . S VALUE=ISIMISC("PAT_SSN") I VALUE="" S EXIT=1 Q
 . I '$D(^DPT("SSN",VALUE)) S EXIT=1 Q
 . S DFN=$O(^DPT("SSN",VALUE,"")) I DFN="" S EXIT=1 Q
 . S ISIMISC("DFN")=DFN
 . Q
 I EXIT=1 Q "-1^Invalid PAT_SSN (#2,.09)."
 ;
 ;-- STATUS (not required, if none, use 'A'ctive)--
 I $G(ISIMISC("STATUS"))="" S ISIMISC("STATUS")="A"
 S ISIMISC("STATUS")=$TR(ISIMISC("STATUS"),"ai","AI")
 I "AI"'[ISIMISC("STATUS") S ISIMISC("STATUS")="A"
 ;
 ;-- ONSET (not required) --
 I $G(ISIMISC("ONSET")) S ISIMISC("ONSET")=$P(ISIMISC("ONSET"),".")  
 ;. S FILE=9000011,FIELD=.13,FLAG="",VALUE=ISIMISC("ONSET")
 ;. S Y=VALUE D DD^%DT S VALUE=Y ;Convert to external
 ;. D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 ;I EXIT=1 Q "-1^Invalid ONSET date."
 ;
 I $G(ISMISC("ENTERED")) S ISIMISC("ENTERED")=$P(ISIMISC("ENTERED"),".")
 I '$G(ISIMISC("ENTERED")) S ISIMISC("ENTERED")=DT
 ;
 I $G(ISIMISC("RECORDED")) S ISIMISC("RECORDED")=$P(ISIMISC("RECORDED"),".")
 I '$G(ISIMISC("RECORDED")) S ISIMISC("RECORDED")=ISIMISC("ENTERED")
 ;
 ;-- TYPE (not required, if none use 'A'ccute) --
 I $G(ISIMISC("TYPE"))="" S ISIMISC("TYPE")="A"
 S ISIMISC("TYPE")=$TR(ISIMISC("TYPE"),"ac","AC")
 I "AC"'[ISIMISC("TYPE") S ISIMISC("TYPE")="A" ;default
 ;
 ; -- LOCATION
 I $G(ISIMISC("LOCATION"))'="" D  
 . N ISC S ISC=ISIMISC("LOCATION") I $D(^SC(ISC,0)) Q
 . S (ISC,EXIT)=0 F  S ISC=$O(^SC("B",ISIMISC("LOCATION"),ISC)) Q:'ISC!EXIT  I $P($G(^SC(ISC,0)),U,3)="C" S EXIT=ISC Q
 . I EXIT S ISIMISC("LOCATION")=EXIT,EXIT=0
 ;
 Q 1
 ;
