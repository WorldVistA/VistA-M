ISIIMPU8 ;;ISI GROUP/MLS -- NOTE IMPORT Utility
 ;;1.0;;;Jun 26,2012;Build 93
 Q  
MISCDEF ;;+++++ DEFINITIONS OF NOTE MISC PARAMETERS +++++
 ;;NAME             |TYPE       |FILE,FIELD |DESC
 ;;-----------------------------------------------------------------------
 ;;PAT_SSN          |FIELD      |2          |Patient SSN
 ;;TIU_NAME         |FIELD      |8925.1     |TIU Document Definition (#8925.1)
 ;;VDT              |FIELD      |           |Date(/Time) of Visit
 ;;VLOC             |FIELD      |44         |Visit Location (HOSPITAL LOCATION)
 ;;PROV             |FIELD      |200        |Provider (#200)
 ;;TEXT             |           |           |TIU Text
 Q
 ;
NOTMISC(MISC,ISIMISC)
 ;INPUT: 
 ;  MISC(0)=PARAM^VALUE - raw list ovalues from RPC client
 ;
 ;OUTPUT:
 ;  ISIMISC(PARAM)=VALUE
 ;
 N MISCDEF
 K ISIMISC
 D LOADMISC(.MISCDEF) ; Load MISC definition params
 S ISIRC=$$NOTMISC1("ISIMISC")
 Q ISIRC ;return code
 ;
NOTMISC1(DSTNODE)
 N PARAM,VALUE,DATE,RESULT,MSG,EXIT
 S (EXIT,ISIRC)=0,(I,VALUE)=""
 F  S I=$O(MISC(I))  Q:I=""  D  Q:EXIT
 . S PARAM=$$TRIM^XLFSTR($P(MISC(I),U))  Q:PARAM=""
 . S VALUE=$$TRIM^XLFSTR($P(MISC(I),U,2))
 . I '$D(MISCDEF(PARAM)) S ISIRC="-1^Bad parameter title passed: "_PARAM,EXIT=1 Q
 . I VALUE="" S ISIRC="-1^No data provided for parameter: "_PARAM,EXIT=1 Q
 . I PARAM="VDT" D  
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
VALNOTE(ISIMISC)
 ; Entry point to validate content of Notes create/array
 ; 
 ; Input - ISIMISC(ARRAY)
 ; Format:  ISIMISC(PARAM)=VALUE
 ;     eg:  ISIMISC("VLOC")="PRIMARY CARE" 
 ;
 ; Output - ISIRC [return code]
 N FILE,FIELD,FLAG,DFN,VALUE,RESULT,MSG,MISCDEF,EXIT,Y,RESULT,IDT,RDT
 S EXIT=0
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
 ; -- TIU_NAME --
 ; TIU DEFINITION NAME (8925.1)
 I '$D(ISIMISC("TIU_NAME")) Q "-1^Missing TIU_NAME."
 I $D(ISIMISC("TIU_NAME")) D  
 . S VALUE=$G(ISIMISC("TIU_NAME")) I VALUE="" S EXIT=1 Q
 . S VALUE=$O(^TIU(8925.1,"B",VALUE,"")) I VALUE="" S EXIT=1 Q
 . N ZREC S ZREC=$G(^TIU(8925.1,VALUE,0)) I ZREC="" S EXIT=1 Q
 . I $P(ZREC,U,4)'="DOC" S EXIT=1 Q  ; TIU Type of DOC
 . I $P(ZREC,U,7)'=11 S EXIT=1 Q ;TIU status of Active
 . N RESULT D ISCNSLT^TIUCNSLT(.RESULT,VALUE) I RESULT'=0 S EXIT=1 Q ;No CONSULT types
 . S ISIMISC("TIU")=VALUE
 Q:EXIT "-1^Invalid TIU_NAME (#8925.1)."
 ;
 ; -- VDT --
 I '$D(ISIMISC("VDT")) Q "-1^Missing value for VDT (Visit Date/time)."
 S VALUE=$G(ISIMISC("VDT")) Q:VALUE="" "-1^Missing value for VDT (Visit Date/Time)."  
 ;
 ; -- VLOC --
 I '$D(ISIMISC("VLOC")) Q "-1^Missing VLOC (Hospital Location #44)."
 I $D(ISIMISC("VLOC")) D  
 . S VALUE=$G(ISIMISC("VLOC")) I VALUE="" S EXIT=1 Q
 . S Y=$O(^SC("B",VALUE,"")) I Y="" S EXIT=1 Q
 . S IDT=$P($G(^SC(Y,"I")),U)
 . S RDT=$P($G(^SC(Y,"I")),U,2)
 . I IDT'="" I RDT="" I IDT<DT S EXIT=1 Q
 . I RDT'="" I RDT>IDT I RDT>DT S EXIT=1 Q
 . I RDT'="" I RDT<IDT I IDT<DT S EXIT=1 Q
 . S ISIMISC("VLOC")=Y
 . Q
 Q:EXIT "-1^Invalid LOCATION (VLOC) value (#44,.01)."
 ;
 ; -- PROV -- 
 ; Provider entering/signing note
 I '$D(ISIMISC("PROV")) Q "-1^Missing PROV (#200,.01)"
 I $D(ISIMISC("PROV")) D  
 . S VALUE=$G(ISIMISC("PROV")) I VALUE="" S EXIT=1 Q
 . S Y="" F  S Y=$O(^VA(200,"B",VALUE,Y)) Q:Y=""  D  Q:EXIT=1
 . . I +$G(^VA(200,Y,"PS"))=1 S EXIT=1 Q
 . . Q
 . I Y'="" S EXIT=0,ISIMISC("PROV")=Y
 . Q
 Q:EXIT "-1^Invalid PROV value (#200,.01)."
 ;
 ;TEXT
 I '$D(ISIMISC("TEXT")) Q "-1^Missing note text."
 I $D(ISIMISC("TEXT")) S VALUE=ISIMISC("TEXT") I VALUE="" Q "-1^Missing note text."
 ;
 ; -- ES --
 S ISIMISC("ES")=$P($G(^VA(200,ISIMISC("PROV"),20)),U,4)
 Q:$G(ISIMISC("ES"))="" "-1^PROVIDER (#200) missing Electronic Signature." 
 ;
 ;One time only doc
 N VISIT
 S VISIT=ISIMISC("VLOC")_";"_ISIMISC("VDT")_";A",ISIMISC("VISIT")=VISIT
 D TIUVISIT^TIUSRVA(.RESULT,ISIMISC("TIU"),ISIMISC("DFN"),VISIT)
 Q:RESULT=1 "-1^Visit will not allow additional attached notes."
 ;
 ;Requires co-signature
 D REQCOS^TIUSRVA(.RESULT,ISIMISC("TIU"),0,ISIMISC("PROV"),ISIMISC("VDT"))
 Q:RESULT>0 "-1^Note requires co-signature."
 ;
 Q 1
