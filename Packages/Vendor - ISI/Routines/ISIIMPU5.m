ISIIMPU5 ;ISI GROUP/MLS -- IMPORT Vitals Utility
 ;;1.0;;;Jun 26,2012;Build 93
 Q  
MISCDEF ;;+++++ DEFINITIONS OF VITALS MISC PARAMETERS +++++
 ;;NAME             |TYPE       |FILE,FIELD |DESC
 ;;-----------------------------------------------------------------------
 ;;DT_TAKEN         |FIELD      |120.5,.01  |DATE/TIME vital measurement taken
 ;;PAT_SSN          |FIELD      |           |PATIENT (#2)
 ;;VITAL_TYPE       |FIELD      |120.5,.03  |GMVR VITAL TYPE(#120.51)
 ;;RATE             |FIELD      |120.5,1.2  |Rate/value for vital
 ;;LOCATION         |FIELD      |120.5,.05  |HOSPITAL LOCATION (#44)
 ;;ENTERED_BY       |FIELD      |120.5,.06  |PERSON (#200)
 Q
 ;
VITMISC(MISC,ISIMISC)
 ;INPUT: 
 ;  MISC(0)=PARAM^VALUE - raw list values from RPC client
 ;
 ;OUTPUT:
 ;  ISIMISC(PARAM)=VALUE
 ;
 N MISCDEF
 K ISIMISC
 D LOADMISC(.MISCDEF) ; Load MISC definition params
 S ISIRC=$$VITMISC1("ISIMISC")
 Q ISIRC ;return code
 ;
VITMISC1(DSTNODE)
 N PARAM,VALUE,DATE,RESULT,MSG,EXIT
 S (EXIT,ISIRC)=0,(I,VALUE)=""
 F  S I=$O(MISC(I))  Q:I=""  D  Q:EXIT
 . S PARAM=$$TRIM^XLFSTR($P(MISC(I),U))  Q:PARAM=""
 . S VALUE=$$TRIM^XLFSTR($P(MISC(I),U,2))
 . I '$D(MISCDEF(PARAM)) S ISIRC="-1^Bad parameter title passed: "_PARAM,EXIT=1 Q
 . I VALUE="" S ISIRC="-1^No data provided for parameter: "_PARAM,EXIT=1 Q
 . I PARAM="DT_TAKEN" D  
 . . S DATE=VALUE D DT^DILF("T",DATE,.RESULT,"",.MSG)
 . . I RESULT<0 S EXIT=1,ISIRC="-1^Invalid DT_TAKEN date/time." Q
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
VALVITAL(ISIMISC)
 ; Entry point to validate content of Vitals create/array
 ; 
 ; Input - ISIMISC(ARRAY)
 ; Format:  ISIMISC(PARAM)=VALUE
 ;     eg:  ISIMISC("VITAL_TYPE")="PULSE" 
 ;
 ; Output - ISIRC [return code]
 N FILE,FIELD,FLAG,VALUE,RESULT,MSG,MISCDEF,EXIT,OUT,Y,IDT,RDT
 S EXIT=0
 D LOADMISC(.MISCDEF) ; Load MISC definition params
 ;
 ; -- DT_TAKEN --
 I $G(ISIMISC("DT_TAKEN"))="" Q "-1^Missing DT_TAKEN entry."
 S FIELD=$P(MISCDEF("DT_TAKEN"),"|",2),FILE=$P(FIELD,",")
 S FIELD=$P(FIELD,",",2),FLAG="",VALUE=ISIMISC("DT_TAKEN")
 S Y=VALUE D DD^%DT S VALUE=Y ;Convert to external
 D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG)
 Q:'(+RESULT) "-1^Invalid DT_TAKEN (#120.5,.01)."
 ;
 ;-- PAT_SSN (required) --
 I '$D(ISIMISC("PAT_SSN")) Q "-1^Missing Patient SSN."
 I $D(ISIMISC("PAT_SSN")) D  
 . S VALUE=ISIMISC("PAT_SSN") I VALUE="" S EXIT=1 Q
 . I '$D(^DPT("SSN",VALUE)) S EXIT=1 Q
 . S DFN=$O(^DPT("SSN",VALUE,"")) I DFN="" S EXIT=1 Q
 . S ISIMISC("DFN")=DFN
 . Q
 Q:EXIT=1 "-1^Invalid PAT_SSN (#2,.09)."
 ;
 ; -- VITAL_TYPE --
 I $G(ISIMISC("VITAL_TYPE"))="" Q "-1^Missing VITAL_TYPE entry."
 S FIELD=$P(MISCDEF("VITAL_TYPE"),"|",2),FILE=$P(FIELD,",")
 S FIELD=$P(FIELD,",",2),FLAG="",VALUE=ISIMISC("VITAL_TYPE")
 D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG)
 Q:'(+RESULT) "-1^Invalid VITAL_TYPE (#120.5,.03)."
 ; Transform to internal value
 S Y=$O(^GMRD(120.51,"B",VALUE,"")) I Y="" D  
 . S Y=$O(^GMRD(120.51,"C",VALUE,""))
 I Y="" Q "-1^Unable to find internal value for VITAL_TYPE (#120.5,.03)."
 S ISIMISC("VITAL_TYPE")=Y
 ;
 ; -- RATE --
 I $G(ISIMISC("RATE"))="" Q "-1^Missing RATE entry."
 S Y=$$GET1^DIQ(120.51,$G(ISIMISC("VITAL_TYPE"))_",","RATE","I")
 I Y'=1 Q "-1^VITAL_TYPE does not accept RATE entries."
 S Y=$$GET1^DIQ(120.51,$G(ISIMISC("VITAL_TYPE"))_",","RATE INPUT TRANSFORM")
 S X=ISIMISC("RATE") X Y I $G(X)="" Q "-1^Invalid RATE value for VITAL_TYPE."
 ;
 ; -- ENTERED_BY --
 I $G(ISIMISC("ENTERED_BY"))="" Q "-1^Missing ENTERED_BY entry."
 S FIELD=$P(MISCDEF("ENTERED_BY"),"|",2),FILE=$P(FIELD,",")
 S FIELD=$P(FIELD,",",2),FLAG="",VALUE=ISIMISC("ENTERED_BY")
 D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG)
 Q:'(+RESULT) "-1^Invalid ENTERED_BY (#120.5,.06)."
 S Y=$O(^VA(200,"B",ISIMISC("ENTERED_BY"),"")),ISIMISC("ENTERED_BY")=Y
 ;
 ; -- LOCATION --
 I $G(ISIMISC("LOCATION"))="" Q "-1^Missing LOCATION entry."
 ;
 S Y=$O(^SC("B",ISIMISC("LOCATION"),"")) I Y'="" I $P($G(^SC(Y,0)),U,3)="Z" Q "-1^LOCATION, TYPE field (#44,2) cannot equal 'Z' [OTHER]." 
 ;
 S FIELD=$P(MISCDEF("LOCATION"),"|",2),FILE=$P(FIELD,",")
 S FIELD=$P(FIELD,",",2),FLAG="",VALUE=ISIMISC("LOCATION")
 D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG)
 Q:'(+RESULT) "-1^Invalid LOCATION (#120.5,.05)."
 S Y=$O(^SC("B",ISIMISC("LOCATION"),"")),ISIMISC("LOCATION")=Y
 ;
 ; Check to see if HOSP LOC is active when Vital measurement was taken
 S IDT=$P($G(^SC(Y,"I")),U)
 S RDT=$P($G(^SC(Y,"I")),U,2)
 I IDT'="" I RDT="" I IDT<ISIMISC("DT_TAKEN") Q "-1^Location inactive on date vital taken (#44)."
 I RDT'="" I RDT>IDT I RDT>ISIMISC("DT_TAKEN") Q "-1^Location inactive on date vital taken (#44)."
 I RDT'="" I RDT<IDT I IDT<ISIMISC("DT_TAKEN") Q "-1^Location inactive on date vital taken (#44)."
 ;
 Q 1
 ;
