ISIIMPU2 ;ISI GROUP/MLS -- IMPORT Utility
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
 ;      MISC(1)="ADATE|T-1@12:00"
 ;      MISC(2)="CLIN|PRIMARY CARE"
 ;      MISC(4)="PATIENT|555005555"
 ;
MISCDEF ;;+++++ DEFINITIONS OF APPT MISC PARAMETERS +++++
 ;;NAME             |TYPE       |FILE,FIELD     |DESC
 ;;-----------------------------------------------------------------------
 ;;ADATE            |FIELD      |44.001,.01     |Appointment DATE/TIME value
 ;;CDATE            |FIELD      |44.003,303     |Appointment DATE/TIME CHECKED OUT value
 ;;CLIN             |FIELD      |44,.01         |HOSPITAL LOCATION
 ;;PATIENT          |FIELD      |2,.09          |PATIENT (SSN or DFN)
 ;;PAT_SSN          |FIELD      |2,.09          |PATIENT (SSN or DFN)
 ;;PROVIDER         |FIELD      |9000010.06,.01 |PROVIDER
 Q
 ;
APPTMISC(MISC,ISIMISC) 
 ;
 ;INPUT: 
 ;  MISC - raw list values from RPC client
 ;
 ;OUTPUT:
 ;  ADATE - Appointment Date/Time
 ;  CLIN - Clinic
 ;  DFN - Patient
 ;
 N MISCDEF
 K ISIMISC
 D LOADMISC(.MISCDEF) ; Load MISC definition params
 S ISIRC=$$APPTMISC1("ISIMISC")
 Q ISIRC ;return code
 ;
APPTMISC1(DSTNODE) 
 N PARAM,VALUE,DATE,RESULT,MSG,EXIT
 S (EXIT,ISIRC)=0,(I,VALUE)=""
 F  S I=$O(MISC(I))  Q:I=""  D  Q:EXIT
 . S PARAM=$$TRIM^XLFSTR($P(MISC(I),U))  Q:PARAM=""
 . S VALUE=$$TRIM^XLFSTR($P(MISC(I),U,2))
 . I '$D(MISCDEF(PARAM)) S ISIRC="-1^Bad parameter title passed: "_PARAM,EXIT=1 Q
 . I VALUE="" S ISIRC="-1^No data provided for parameter: "_PARAM,EXIT=1 Q
 . I PARAM["DATE" D  
 . . S DATE=VALUE D DT^DILF("T",DATE,.RESULT,"",.MSG)
 . . I RESULT<0 S EXIT=1,ISIRC="-1^Invalid appointment date:"_$G(PARAM)_"="_$G(VALUE) Q
 . . I $P(RESULT,".",2)="" S $P(RESULT,".",2)="12"
 . . S VALUE=RESULT
 . . D NOW^%DTC I RESULT>% S EXIT=1,ISIRC="-1^Future appointment date not allowed."
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
VALAPPT() 
 ; Input - ADATE (Appointment date)
 ;       - SC    (HOSPITAL LOCATION #44)
 ;       - DFN   (SSN or DFN #2)
 ; Output - ISIRC [return code]
 ;
 N EXIT,IDT,RDT,PROV
 S EXIT=""
 I $G(ADATE)="" Q "-1^Missing date/time for appt (ADATE)."
 I $G(SC)="" Q "-1^Missing appt. location (#44)."
 I $G(DFN)="" Q "-1^Missing patient identifier (#2)."
 ;
 I $P(ADATE,".",2)="" Q "-1^Missing time for appt. (ADATE)."
 ; check Date/time against fileman date/time field 
 S FILE=2.98,FIELD=.001,VALUE=ADATE
 . S Y=VALUE D DD^%DT S VALUE=Y ;Convert to external
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . Q
 Q:EXIT "-1^Invalid appt date/time (ADATE)."
 ;
 S CDATE=$G(CDATE) ; pulled from ISIMISC("CDATE") 
 I CDATE D  
 . I $P(CDATE,".",2)="" S EXIT="-1^CDATE must be in datetime format" Q
 . I CDATE<ADATE S EXIT="-1^CDATE must be after ADATE" Q
 . Q
 Q:((+EXIT)<0) EXIT
 ;
 ; -- SC --
 S Y=$O(^SC("B",SC,"")) I Y="" Q "-1^Invalid Appt. location value (#44)."
 S IDT=$P($G(^SC(Y,"I")),U)
 S RDT=$P($G(^SC(Y,"I")),U,2)
 I IDT'="" I RDT="" I IDT<ADATE Q "-1^Appt. location inactive on appt. date (#44)."
 I RDT'="" I RDT>IDT I RDT>ADATE Q "-1^Appt. location inactive on appt. date (#44)."
 I RDT'="" I RDT<IDT I IDT<ADATE Q "-1^Appt. location inactive on appt. date (#44)."
 S SC=Y
 ;
 ; Check for Clinic stop code
 I $P($G(^SC(SC,0)),U,7)="" Q "-1^Appt. location missing STOP CODE NUMBER (#44,8)"
 ;
 ;overload to allow DFN or SSN
 I $O(^DPT("SSN",DFN,""))'="" S DFN=$O(^DPT("SSN",DFN,"")) ;give priority to SSN
 I '$D(^DPT(DFN,0)) S EXIT=1
 Q:EXIT "-1^No entry found for PATIENT (#2)"
 ;
 I $G(ISIMISC("PROVIDER"))'="" D  
 . S PROV=ISIMISC("PROVIDER")
 . I 'PROV S PROV=$O(^VA(200,"B",PROV,""))
 . I '$D(^VA(200,PROV,0)) S EXIT=1 Q
 . Q
 Q:EXIT "-1^Bad Provider entry (#200)"
 ;
 S ISIMISC("ADATE")=$G(ADATE)
 S ISIMISC("DFN")=$G(DFN)
 S ISIMISC("PROVIDER")=$G(PROV)
 Q 1
 ;
