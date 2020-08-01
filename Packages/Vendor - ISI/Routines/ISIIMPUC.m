ISIIMPUC ;;ISI GROUP/MLS -- RAD ORDERS IMPORT Utility
 ;;1.0;;;Jun 26,2012;Build 93
 Q  
MISCDEF ;;+++++ DEFINITIONS OF RAD ORDERS MISC PARAMETERS +++++
 ;;NAME             |TYPE       |FILE,FIELD |DESC
 ;;-----------------------------------------------------------------------
 ;;PAT_SSN          |FIELD      |2,.09      |Patient SSN
 ;;RAPROC           |FIELD      |71,.01     |Radiology Procedure
 ;;MAGLOC           |FIELD      |79.1,.01   |Imaging Location
 ;;PROV             |FIELD      |200,.01    |Provider (#200)  (if not provided use logon user)
 ;;RADTE            |FIELD      |70.02,     |Exam Date/Time
 ;;EXAMCAT          |FIELD      |75.1,4     |Radiology Exam Category (I,O,C,S,E,R)
 ;;REQLOC           |FIELD      |44,.01     |Request Location (#44)
 ;;REASON           |FIELD      |75.1,1.1   |Rad exam reason (free text)
 ;;HISTORY          |FIELD      |75.1,400   |Clinical History for exam (free text)
 ;;TECH             |FIELD      |70.12,.01  |Technologist (needed for Examined)
 ;;TECHCOMM         |FIELD      |70.07.,4   |Tech Comments
 ;;EXAM_STATUS      |PARAM      |           |How far to advance order (O,R,E,C)
 Q
 ;
RADMISC(MISC,ISIMISC)
 ;INPUT: 
 ;  MISC(0)=PARAM^VALUE - raw list of values from RPC client
 ;
 ;OUTPUT:
 ;  ISIMISC(PARAM)=VALUE
 ;
 N MISCDEF
 K ISIMISC
 D LOADMISC(.MISCDEF) ; Load MISC definition params
 S ISIRC=$$RADMISC1("ISIMISC")
 Q ISIRC ;return code
 ;
RADMISC1(DSTNODE)
 N PARAM,VALUE,DATE,RESULT,MSG,EXIT
 S (EXIT,ISIRC)=0,(I,VALUE)=""
 F  S I=$O(MISC(I))  Q:I=""  D  Q:EXIT
 . S PARAM=$$TRIM^XLFSTR($P(MISC(I),U))  Q:PARAM=""
 . S VALUE=$$TRIM^XLFSTR($P(MISC(I),U,2))
 . I '$D(MISCDEF(PARAM)) S ISIRC="-1^Bad parameter title passed: "_PARAM,EXIT=1 Q
 . I VALUE="" S ISIRC="-1^No data provided for parameter: "_PARAM,EXIT=1 Q
 . I PARAM="RADTE" D  
 . . S DATE=VALUE D DT^DILF("T",DATE,.RESULT,"",.MSG)
 . . I RESULT<0 S EXIT=1,ISIRC="-1^Invalid RADTE (Exam Date/Time)" Q
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
VALRADO(ISIMISC)
 ; Entry point to validate content of Radiology Order create array
 ; 
 ; Input - ISIMISC(ARRAY)
 ; Format:  ISIMISC(PARAM)=VALUE
 ;     eg:  ISIMISC("RADPROC")="CHEST 2 VIEWS" 
 ;
 ; Output - ISIRC [return code]
 N FILE,FIELD,FLAG,DFN,VALUE,RESULT,MSG,MISCDEF,EXIT,Y,RESULT,I,TDY,IDT,RDT
 N MAGTYP
 S EXIT=0,RESULT="" D NOW^%DTC S TDY=X
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
 ; -- RAPROC --
 I '$D(ISIMISC("RAPROC")) Q "-1^Missing RAPROC (#71,.01)"
 I $D(ISIMISC("RAPROC")) D  
 . S VALUE=$G(ISIMISC("RAPROC")) I VALUE="" S EXIT=1 Q
 . I '$D(^RAMIS(71,"B",VALUE)) S EXIT=1 Q
 . S Y=$O(^RAMIS(71,"B",VALUE,"")) I 'Y S EXIT=1 Q
 . S I=$P($G(^RAMIS(71,Y,"I")),U) I I I I<TDY S EXIT=1 Q ;Inactive
 . S ISIMISC("RAPROC")=Y
 . Q
 Q:EXIT "-1^Invalid RAPROC (#71,.01)"
 ;
 ; -- MAGLOC --
 I '$D(ISIMISC("MAGLOC")) Q "-1^Missing MAGLOC (IMAGING LOCATIONS #79.1)."
 I $D(ISIMISC("MAGLOC")) D  
 . S VALUE=$G(ISIMISC("MAGLOC")) I VALUE="" S EXIT=1 Q
 . S Y=$O(^SC("B",VALUE,"")) I Y="" S EXIT=1 Q ;#44 ien
 . S Y=$O(^RA(79.1,"B",Y,"")) I Y="" S EXIT=1 Q ;#79.1 ien
 . S I=$P($G(^RA(79.1,Y,0)),U,19) I I I I<TDY S EXIT=1 Q ;inactive
 . S ISIMISC("MAGLOC")=Y
 . Q
 Q:EXIT "-1^Invalid MAGLOC (IMAGING LOCATIONS #79.1)"
 ;
 ; -- Check Imaging Location (MAGLOC) and Procedure TYPE of IMAGING match
 S MAGTYP=$P($G(^RAMIS(71,ISIMISC("RAPROC"),0)),"^",12)
 I $P($G(^RA(79.1,ISIMISC("MAGLOC"),0)),U,6)'=MAGTYP Q "-1^TYPE OF IMAGING (#79.2) and IMAGING LOCATION (#79.1) don't match."
 ;
 ; -- PROV -- 
 I '$D(ISIMISC("PROV")) Q "-1^Missing PROV."
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
 ; -- TECH -- 
 ; I '$D(ISIMISC("TECH")) Q "-1^Missing TECH."
 I $D(ISIMISC("TECH")) D  
 . S VALUE=$G(ISIMISC("TECH")) I VALUE="" S EXIT=1 Q
 . S Y="" F  S Y=$O(^VA(200,"B",VALUE,Y)) Q:Y=""  D  Q:EXIT=1
 . . I '$D(^VA(200,Y,"RAC")) Q ;no rad classification
 . . S EXIT=1 Q
 . . Q
 . I Y'="" S EXIT=0,ISIMISC("TECH")=Y
 . Q
 Q:EXIT "-1^Invalid TECH value (#200, .01)."
 ;
 I '$D(ISIMISC("EXAM_STATUS")) S ISIMISC("EXAM_STATUS")="O"
 I $D(ISIMISC("EXAM_STATUS")) D  
 . S X=$E(ISIMISC("EXAM_STATUS")) S X=$S(X="O":X,X="R":X,X="E":X,X="C":X,1:"O")
 . Q
 ;
 ; -- Check to see if Provider has RAD/NUC LOCATION ACCESS to Imaging Location (#200,74)
 ;S X="",EXIT=1 F  S X=$O(^VA(200,ISIMISC("PROV"),"RAL",X)) Q:X=""  D  
 ;. I $P($G(^VA(200,ISIMISC("PROV"),"RAL",X,0)),U)'=ISIMISC("MAGLOC") Q
 ;. S EXIT=0
 ;. Q
 ;Q:EXIT "-1^Provider does not have RAD/NUC LOCATION ACCESS (#200,.074) to Imaging Location." 
 ;
 ; -- RADTE --
 I $G(ISIMISC("RADTE"))="" Q "-1^Missing RADTE."
 
 ; -- EXAMCAT -- 
 I '$D(ISIMISC("EXAMCAT")) S ISIMISC("EXAMCAT")="O" ;Outpatient default
 I $D(ISIMISC("EXAMCAT")) D  
 . S VALUE=$G(ISIMISC("EXAMCAT")) I VALUE'?1A S EXIT=1 Q
 . S EXIT=$S(VALUE="I":0,VALUE="O":0,VALUE="C":0,VALUE="S":0,VALUE="E":0,VALUE="R":0,1:1)
 Q:EXIT "-1^Invalid EXAMCAT (Radiology Exam Category #75.1,4)"
 ;
 ; -- REQLOC --
 I '$D(ISIMISC("REQLOC")) Q "-1^Missing REQLOC (HOSPITAL LOCATION #44)."
 I $D(ISIMISC("REQLOC")) D  
 . S VALUE=$G(ISIMISC("REQLOC")) I VALUE="" S EXIT=1 Q
 . S Y=$O(^SC("B",VALUE,"")) I Y="" S EXIT=1 Q
 . S IDT=$P($G(^SC(Y,"I")),U)
 . S RDT=$P($G(^SC(Y,"I")),U,2)
 . I IDT'="" I RDT="" I IDT<TDY S EXIT=1 Q
 . I RDT'="" I RDT>IDT I RDT>TDY S EXIT=1 Q
 . I RDT'="" I RDT<IDT I IDT<TDY S EXIT=1 Q
 . S ISIMISC("REQLOC")=Y
 . Q
 Q:EXIT "-1^Invalid REQLOC value (HOSPITAL LOCATION #44,.01)."
 ;
 ; --REASON--
 I $G(ISIMISC("REASON"))="" Q "-1^Missing REASON."
 ;
 ; --HISTORY--
 I $G(ISIMISC("HISTORY"))="" Q "-1^Missing HISTORY."
 ;
 Q 1
