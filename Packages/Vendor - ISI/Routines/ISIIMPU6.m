ISIIMPU6 ;;ISI GROUP/MLS -- IMPORT Utility
 ;;1.0;;;Jun 26,2012;Build 93
 Q  
MISCDEF ;;+++++ DEFINITIONS OF ALLERGIES MISC PARAMETERS +++++
 ;;NAME             |TYPE       |FILE,FIELD |DESC
 ;;-----------------------------------------------------------------------
 ;;ALLERGEN         |FIELD      |120.82,.01 |
 ;;SYMPTOM          |MULTIPLE   |120.83,.01 |Multiple,"|" (bar) delimited, working off #120.83
 ;;PAT_SSN          |FIELD      |120.86,.01 |PATIENT (#2, .09) pointer
 ;;ORIG_DATE        |FIELD      |120.8,4    |
 ;;ORIGINTR         |FIELD      |120.8,5    |PERSON (#200)
 ;;HISTORIC         |BOOLEEN    |           |1=HISTORICAL, 0=OBSERVED
 ;;OBSRV_DT         |FIELD      |           |Observation Date (if HISTORIC=0)
 Q
 ;
ALGMISC(MISC,ISIMISC)
 ;INPUT: 
 ;  MISC(0)=PARAM^VALUE - raw list values from RPC client
 ;
 ;OUTPUT:
 ;  ISIMISC(PARAM)=VALUE
 ;
 N MISCDEF
 K ISIMISC
 D LOADMISC(.MISCDEF) ; Load MISC definition params
 S ISIRC=$$ALGMISC1("ISIMISC")
 Q ISIRC ;return code
 ;
ALGMISC1(DSTNODE)
 N PARAM,VALUE,DATE,RESULT,MSG,EXIT
 S (EXIT,ISIRC)=0,(I,VALUE)=""
 F  S I=$O(MISC(I))  Q:I=""  D  Q:EXIT
 . S PARAM=$$TRIM^XLFSTR($P(MISC(I),U))  Q:PARAM=""
 . S VALUE=$$TRIM^XLFSTR($P(MISC(I),U,2))
 . I '$D(MISCDEF(PARAM)) S ISIRC="-1^Bad parameter title passed: "_PARAM,EXIT=1 Q
 . I VALUE="" S ISIRC="-1^No data provided for parameter: "_PARAM,EXIT=1 Q
 . I PARAM="ORIG_DATE"!(PARAM="OBSRV_DT") D  
 . . S DATE=VALUE D DT^DILF("T",DATE,.RESULT,"",.MSG)
 . . I RESULT<0 S EXIT=1,ISIRC="-1^Invalid "_PARAM_" date/time." Q
 . . S VALUE=RESULT
 . . I $P(VALUE,".",2)="" S VALUE=VALUE_".1200"
 . . Q
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
VALALG(ISIMISC)
 ; Entry point to validate content of ALLERGY create/array
 ; 
 ; Input - ISIMISC(ARRAY)
 ; Format:  ISIMISC(PARAM)=VALUE
 ;     eg:  ISIMISC("ALLERGEN")="POLLEN" 
 ;
 ; Output - ISIRC [return code]
 N FILE,FIELD,FLAG,VALUE,RESULT,MSG,MISCDEF,EXIT,TEMP,Y,Z
 S EXIT=0
 D LOADMISC(.MISCDEF) ; Load MISC definition params
 ;
 ; -- ALLERGEN --
 ; Using GRMD(120.82
 I '$D(ISIMISC("ALLERGEN")) Q "-1^Missing ALLERGEN."
 I $D(ISIMISC("ALLERGEN")) D  
 . I '$D(^GMRD(120.82,"B",ISIMISC("ALLERGEN"))) S EXIT=1 Q
 . S Y=$O(^GMRD(120.82,"B",ISIMISC("ALLERGEN"),"")) I Y="" S EXIT=1 Q
 . S ISIMISC("GMRAGNT")=ISIMISC("ALLERGEN")_"^"_Y_";GMRD(120.82,"
 . S Z=$$GET1^DIQ(120.82,Y_",",1),X=$$GET1^DIQ(120.82,Y_",",1,"I")
 . S ISIMISC("GMRATYPE")=X_U_Z
 . S ISIMISC("GMRANATR")="A"_U_"Allergy" ; default
 . Q
 I EXIT=1 Q "-1^Invalid ALLERGEN (#120.82)."
 ;
 ; -- SYMPTOM --
 ; Multiple,"|" (bar) delimited, working off #120.83
 ; eg "ANXIETY^DIARRHEA"
 I '$D(ISIMISC("SYMPTOM")) Q "-1^Missing SYMPTOM."
 F X=1:1 S Y=$P(ISIMISC("SYMPTOM"),"|",X) Q:Y=""  D  I EXIT=1 Q
 . I '$D(^GMRD(120.83,"B",Y)) S EXIT=1 Q
 . S Z=$O(^GMRD(120.83,"B",Y,"")) I Z="" S EXIT=1 Q
 . S ISIMISC("GMRASYMP",0)=X
 . S TEMP=Z_U_Y_U_U_U S ISIMISC("GMRASYMP",X)=TEMP
 . Q
 I EXIT=1 Q "-1^Invalid SYMPTOM (#120.83)."
 ; 
 ; -- PAT_SSN --
 I '$D(ISIMISC("PAT_SSN")) Q "-1^Missing Patient SSN."
 I $D(ISIMISC("PAT_SSN")) D  
 . S VALUE=ISIMISC("PAT_SSN") I VALUE="" S EXIT=1 Q
 . I '$D(^DPT("SSN",VALUE)) S EXIT=1 Q
 . S DFN=$O(^DPT("SSN",VALUE,"")) I DFN="" S EXIT=1 Q
 . S ISIMISC("DFN")=DFN
 . Q
 Q:EXIT=1 "-1^Invalid PAT_SSN (#2,.09)."
 ;
 ; -- ORIGINTR --
 I $G(ISIMISC("ORIGINTR"))="" Q "-1^Missing ORIGINTRY entry."
 S FIELD=$P(MISCDEF("ORIGINTR"),"|",2),FILE=$P(FIELD,",")
 S FIELD=$P(FIELD,",",2),FLAG="",VALUE=ISIMISC("ORIGINTR")
 D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG)
 Q:'(+RESULT) "-1^Invalid ORIGINTR (#120.8,5)."
 S Y=$O(^VA(200,"B",ISIMISC("ORIGINTR"),"")),ISIMISC("GMRAORIG")=Y
 ;
 ; -- ORIG_DATE --
 I $G(ISIMISC("ORIG_DATE"))="" Q "-1^Missing ORIG_DATE entry."
 S FIELD=$P(MISCDEF("ORIG_DATE"),"|",2),FILE=$P(FIELD,",")
 S FIELD=$P(FIELD,",",2),FLAG="",VALUE=ISIMISC("ORIG_DATE")
 S Y=VALUE D DD^%DT S VALUE=Y ;Convert to external
 D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG)
 Q:'(+RESULT) "-1^Invalid ORIG_DATE (#120.8,4)."
 S ISIMISC("GMRAORDT")=ISIMISC("ORIG_DATE")
 ;
 ; -- HISTORIC --
 I $G(ISIMISC("HISTORIC"))="" Q "-1^Missing HISTORIC entry."
 S Y=ISIMISC("HISTORIC") I Y'?1N!((Y>1)!(Y<0)) Q "-1^Invalid HISTORIC value (0/1)."
 I Y=1 S ISIMISC("GMRAOBHX")="h^HISTORICAL"
 I Y=0 S ISIMISC("GMRAOBHX")="o^OBSERVED"
 ;
 S ISIMISC("GMRASEVR")=2
 ;
 ; -- OBSRV_DT --
 I ISIMISC("HISTORIC")=0,$G(ISIMISC("OBSRV_DT"))="" Q "-1^Missing OBSRV_DT entry."
 I ISIMISC("HISTORIC")=0 D  
 . S FIELD=$P(MISCDEF("ORIG_DATE"),"|",2),FILE=$P(FIELD,",") ; OBSERV_DT is multiple entry
 . S FIELD=$P(FIELD,",",2),FLAG="",VALUE=ISIMISC("OBSRV_DT")
 . S Y=VALUE D DD^%DT S VALUE=Y ;Convert to external
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG)
 . I '(+RESULT) S EXIT=1 Q
 . S ISIMISC("GMRARDT")=ISIMISC("OBSRV_DT")
 . Q
 S ISIMISC("GMRACHT",0)=1
 D NOW^%DTC S ISIMISC("GMRACHT",1)=%
 Q:EXIT=1 "-1^Invalid OBSRV_DT."
 ;
 Q 1
