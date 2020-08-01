ISIIMPUB ;;ISI GROUP/MLS -- CONSULTS IMPORT Utility
 ;;1.0;;;Jun 26,2012;Build 93
 Q  
MISCDEF ;;+++++ DEFINITIONS OF CONSULT MISC PARAMETERS +++++
 ;;NAME             |TYPE       |FILE,FIELD |DESC
 ;;-----------------------------------------------------------------------
 ;;PAT_SSN          |FIELD      |2          |Patient SSN
 ;;CONSULT          |FIELD      |123.5,.01  |Consult Name
 ;;LOC              |FIELD      |44,.01     |Visit Location (HOSPITAL LOCATION)
 ;;PROV             |FIELD      |200        |Provider (#200)  (if not provided use logon user)
 ;;TEXT             |           |           |Consult text
 Q
 ;
CONMISC(MISC,ISIMISC)
 ;INPUT: 
 ;  MISC(0)=PARAM^VALUE - raw list ovalues from RPC client
 ;
 ;OUTPUT:
 ;  ISIMISC(PARAM)=VALUE
 ;
 N MISCDEF
 K ISIMISC
 D LOADMISC(.MISCDEF) ; Load MISC definition params
 S ISIRC=$$CONMISC1("ISIMISC")
 Q ISIRC ;return code
 ;
CONMISC1(DSTNODE)
 N PARAM,VALUE,DATE,RESULT,MSG,EXIT
 S (EXIT,ISIRC)=0,(I,VALUE)=""
 F  S I=$O(MISC(I))  Q:I=""  D  Q:EXIT
 . S PARAM=$$TRIM^XLFSTR($P(MISC(I),U))  Q:PARAM=""
 . S VALUE=$$TRIM^XLFSTR($P(MISC(I),U,2))
 . I '$D(MISCDEF(PARAM)) S ISIRC="-1^Bad parameter title passed: "_PARAM,EXIT=1 Q
 . I VALUE="" S ISIRC="-1^No data provided for parameter: "_PARAM,EXIT=1 Q
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
VALCONS(ISIMISC)
 ; Entry point to validate content of CONSULT create array
 ; 
 ; Input - ISIMISC(ARRAY)
 ; Format:  ISIMISC(PARAM)=VALUE
 ;     eg:  ISIMISC("LOC")="PRIMARY CARE" 
 ;
 ; Output - ISIRC [return code]
 N FILE,FIELD,FLAG,DFN,VALUE,RESULT,MSG,MISCDEF,EXIT,Y,RESULT,DFN
 N ARRAY,IDT,RDT
 S EXIT=0,RESULT=""
 D LOADMISC(.MISCDEF) ; Load MISC definition params
 ;
 ; -- PAT_SSN --
 I '$D(ISIMISC("PAT_SSN")) Q "-1^Missing Patient SSN."
 I $D(ISIMISC("PAT_SSN")) D  
 . S VALUE=$G(ISIMISC("PAT_SSN")) I VALUE="" S EXIT=1 Q
 . I '$D(^DPT("SSN",VALUE)) S EXIT=1 Q
 . S DFN=$O(^DPT("SSN",VALUE,"")) I DFN="" S EXIT=1 Q
 . S ISIMISC("DFN")=DFN
 . Q
 Q:EXIT "-1^Invalid PAT_SSN (#2,.09)."
 ;
 ; -- CONSULT --
 ;
 I '$D(ISIMISC("CONSULT")) Q "-1^Missing CONSULT (#123.5)."
 I $D(ISIMISC("CONSULT")) D  
 . S VALUE=$G(ISIMISC("CONSULT")) I VALUE="" S EXIT=1 Q
 . D SVCSYN^ORQQCN2(.RESULT,1,1,1)
 . K ARRAY M ARRAY=@RESULT
 . S X="" F  S X=$O(ARRAY(X)) Q:'X  S Y=ARRAY(X) I $P(Y,U,2)'="" S ARRAY("B",$P(Y,U,2))=X ;
 . I '$D(ARRAY("B",VALUE)) S EXIT=1 Q
 . S Y=ARRAY("B",VALUE),Y=ARRAY(Y),ISIMISC("ORDERITEM")=$P(Y,U,6)
 . I $G(ISIMISC("ORDERITEM"))="" S EXIT=1 Q
 . Q
 K ARRAY
 Q:EXIT "-1^Invalid CONSULT (#123.5)."
 ;
 ; -- LOC --
 I '$D(ISIMISC("LOC")) Q "-1^Missing LOC (Hospital Location #44)."
 I $D(ISIMISC("LOC")) D  
 . S VALUE=$G(ISIMISC("LOC")) I VALUE="" S EXIT=1 Q
 . S Y=$O(^SC("B",VALUE,"")) I Y="" S EXIT=1 Q
 . S IDT=$P($G(^SC(Y,"I")),U)
 . S RDT=$P($G(^SC(Y,"I")),U,2)
 . I IDT'="" I RDT="" I IDT<DT S EXIT=1 Q
 . I RDT'="" I RDT>IDT I RDT>DT S EXIT=1 Q
 . I RDT'="" I RDT<IDT I IDT<DT S EXIT=1 Q
 . S ISIMISC("LOC")=Y
 . Q
 Q:EXIT "-1^Invalid LOCATION value (#44,.01)."
 ;
 ; -- PROV -- 
 ; Provider entering/signing note
 I '$D(ISIMISC("PROV")) D  ;Q "-1^Missing PROV."
 . S ISIMISC("PROV")=$P($G(^VA(200,DUZ,0)),U)
 . Q
 ;
 I $D(ISIMISC("PROV")) D  
 . S VALUE=$G(ISIMISC("PROV")) I VALUE="" S EXIT=1 Q
 . S Y="" F  S Y=$O(^VA(200,"B",VALUE,Y)) Q:Y=""  D  Q:EXIT=1
 . . I +$G(^VA(200,Y,"PS"))=1 S EXIT=1 Q
 . . I '$D(^VA(200,"AK.PROVIDER",$P(^VA(200,Y,0),U))) S EXIT=1 Q
 . . Q
 . I Y'="" S EXIT=0,ISIMISC("PROV")=Y
 . Q
 Q:EXIT "-1^Invalid PROV value (#200, .01)."
 ;
 ;TEXT
 I '$D(ISIMISC("TEXT")) S ISIMISC("TEXT")="Consult order."
 ;
 ; -- ES --
 S ISIMISC("ES")=$P($G(^VA(200,ISIMISC("PROV"),20)),U,4)
 Q:$G(ISIMISC("ES"))="" "-1^PROVIDER missing Electronic Signature (#200,20.4)." 
 ;
 Q 1
