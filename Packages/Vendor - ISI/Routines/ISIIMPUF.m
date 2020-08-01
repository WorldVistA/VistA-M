ISIIMPUF ;ISI GROUP/MLS -- IMPORT Utility (ADMIT)
 ;;1.0;;;Jun 26,2012;Build 93
 Q
 ;
 ; Column definitions for MISCDEF table (below):
 ; NAME =       name of parameter
 ; TYPE =       categories of values provided
 ;                      'PARAM' is internal used value 
 ;                      'FIELD' is a literal import value
 ;                      'MASK' is dynamic value w/ * wildcard
 ; DESC  =      description of value
 ;
 ; Array example: 
 ;      MISC(1)="ADATE|T-1@12:00"
 ;      MISC(2)="WARD|3E NORTH"
 ;      MISC(3)="RMBD|3E-100-5"
 ;      MISC(4)="PATIENT|555005555"
 ;
MISCDEF ;;+++++ DEFINITIONS OF ADMIT MISC PARAMETERS +++++
 ;;NAME             |TYPE       |FILE,FIELD |DESC
 ;;-----------------------------------------------------------------
 ;;PATIENT          |FIELD      |2,.02      |PATIENT SSN or IEN
 ;;PAT_SSN          |FIELD      |2,.09      |PATIENT (SSN or DFN)
 ;;ADATE            |FIELD      |           |ADMIT DATE/TIME
 ;;DDATE            |FIELD      |           |Disposition DATE/TIME
 ;;ATYPE            |FIELD      |           |Admission type 
 ;;DTYPE            |FIELD      |           |Disposition Type
 ;;ADMREG           |FIELD      |           |ADMITTING Regulations
 ;;PROVIDER         |FIELD      |           |ADMITTING PHYSICIAN
 ;;FDEXC            |FIELD      |           |Facility Dirctry Exclude
 ;;FTSPEC           |FIELD      |           |Facility Treat Spec
 ;;SHDIAG           |FIELD      |           |Brief descr of the diag
 ;;WARD             |FIELD      |           |ADMITTING WARD 
    ;;RMBD             |FIELD      |           |ADMITTING ROOM BED 
 Q
 ;
ADMMISC(MISC,ISIMISC) 
 ;
 ;INPUT: 
 ;  MISC - raw list values from RPC client
 ;
 ;OUTPUT:
 ;  ISIMISC("NAME")=VALUE
 ;
 N MISCDEF
 K ISIMISC
 D LOADMISC(.MISCDEF) ; Load MISC definition params
 S ISIRC=$$ADMMISC1("ISIMISC")
 Q ISIRC ;return code
 ;
ADMMISC1(DSTNODE) 
 N PARAM,VALUE,DATE,RESULT,MSG,EXIT
 S (EXIT,ISIRC)=0,(I,VALUE)=""
 F  S I=$O(MISC(I))  Q:I=""  D  Q:EXIT
 . S PARAM=$$TRIM^XLFSTR($P(MISC(I),U))  Q:PARAM=""
 . S VALUE=$$TRIM^XLFSTR($P(MISC(I),U,2))
 . I '$D(MISCDEF(PARAM)) S ISIRC="-1^Bad parameter title passed: "_PARAM,EXIT=1 Q
 . I VALUE="" S ISIRC="-1^No data provided for parameter: "_PARAM,EXIT=1 Q
 . I PARAM["DATE" D  
 . . S DATE=VALUE D DT^DILF("T",DATE,.RESULT,"",.MSG)
 . . I RESULT<0 S EXIT=1,ISIRC="-1^Invalid date." Q
 . . I $P(RESULT,".",2)="" S $P(RESULT,".",2)="12"
 . . S VALUE=RESULT
 . . Q
 . I EXIT Q
 . S PARAM=$S(PARAM="PAT_SSN":"PATIENT",1:PARAM)
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
VALADMIT(ISIMISC)
 ;
 N EXIT S EXIT=""
 ;
 ;overload to allow DFN or SSN
 S DFN=$G(ISIMISC("PATIENT"))
 I $O(^DPT("SSN",DFN,0)) S DFN=$O(^DPT("SSN",DFN,0)) ;give priority to SSN
 I '$D(^DPT(DFN,0)) Q "-1^No entry found for PATIENT (#2)"
 S ISIMISC("PATIENT")=DFN
 ;
 S ADATE=$G(ISIMISC("ADATE")) I $P(ADATE,".",2)="" Q "-1^Missing/invalid time for admit."
 ;
 ; facility
 S ISIFAC=+$$SITE^VASITE()
    I 'ISIFAC S ISIFAC=$G(ISIMISC("ISIFAC"))
    I 'ISIFAC Q "-1^Cannot determine FACILITY IEN (Admit)."
 ;
 ; -- WARD --
 S ISIWARD=$G(ISIMISC("WARD"))
 I ISIWARD,$D(^DIC(42,ISIWARD,0)) S ISIWARD=$P($G(^DIC(42,ISIWARD,0)),U)
 S Y=$O(^DIC(42,"B",ISIWARD,0)) I 'Y Q "-1^Invalid WARD (#42)."
 S (ISIWARDIEN,ISIMISC("WARD"))=Y
 ;
 N ISC,IDT,RDT S ISC=$$GET1^DIQ(42,Y,44,"I")
 S IDT=$P($G(^SC(ISC,"I")),U)
 S RDT=$P($G(^SC(ISC,"I")),U,2)
 I IDT'="" I RDT="" I IDT<DATE Q "-1^WARD location inactive on admit date (#42)."
 I RDT'="" I RDT>IDT I RDT>DATE Q "-1^WARD location inactive on admit date (#42)."
 I RDT'="" I RDT<IDT I IDT<DATE Q "-1^WARD location inactive on admit date (#42)."
 ;
 ; -- ROOM-BED --
 S ISIRMBD=$G(ISIMISC("RMBD"))
 I ISIRMBD,$D(^DG(405.4,ISIRMBD)) S ISIRMBD=$P($G(^DG(405.4,ISIRMBD,0)),U)
 S Y=$O(^DG(405.4,"B",ISIRMBD,0)) 
 I 'Y Q "-1^Invalid ROOM-BED (#405.4)."
 S (ISIRMBDIEN,ISIMISC("RMBD"))=Y
 ;
 S ISITYPE=$G(ISIMISC("ATYPE"))
 I ISITYPE="" S ISITYPE="NON-VETERAN"
 S ISITYPEIEN=$O(^DG(405.1,"B",ISITYPE,0)) ; FACILITY MOVEMENT TYPE
 I 'ISITYPEIEN Q "-1^Cannot determine Admission Type (#405.1)"
 S ISIMISC("ATYPE")=ISITYPEIEN
 ; 
 S ISIFTS=$G(ISIMISC("FTSPEC")) I $L(ISIFTS)=0 S ISIFTS="MEDICAL"
 S ISIFTSIEN=$O(^DIC(45.7,"B",ISIFTS,"")) ; 
 I 'ISIFTSIEN S ISIFTS=$O(^DIC(45.7,"B",ISIFTS)),ISIFTSIEN=$O(^DIC(45.7,"B",ISIFTS,0))
 I 'ISIFTSIEN Q "-1^Cannot determine Facility treating specialty."
 S ISIMISC("FTSPEC")=ISIFTSIEN
 ;
 S ISIMAS="REGULAR"
    S ISIMASIEN=$O(^DG(405.2,"B",ISIMAS,"")) ; MAS MOVEMENT TYPE
    I 'ISIMASIEN Q "-1^Cannot determine MAS MOVEMENT TYPE"
 ;
 S ISIPROV=$G(ISIMISC("PROVIDER"))
 S ISIPROV=$O(^VA(200,"B",ISIPROV,0))
 I 'ISIPROV Q "-1^Input Error: no match on PROVIDER" 
 S ISIMISC("PROVIDER")=ISIPROV
 ;
 S ISIREG=$G(ISIMISC("ADMREG"))
 I $L(ISIREG)=0 S ISIREG="OBSERVATION & EXAMINATION"
 S ISIREGI=$O(^DIC(43.4,"B",ISIREG,0))
 I 'ISIREGI S ISIREG=$O(^DIC(43.4,"B","AD")),ISIREGI=$O(^DIC(43.4,"B",ISIREG,0))
 I 'ISIREGI Q "-1^Cannot determine Admission Regulation (#43.4)"
 S ISIMISC("ADMREG")=ISIREGI
 ;
 N ISIFDEXC S ISIFDEXC=+$G(ISIMISC("FDEXC"))
 S ISIFDEXC=$S(ISIFDEXC:1,1:0)
 S ISIMISC("FDEXC")=ISIFDEXC
 Q 1
 ;
VALDSCHG(ISIMISC)
 ;
 ;S ADMITIEN=$G(ISIRESUL) ;#405
 ;I 'ADMITIEN Q 0
 ;
 S DDATE=$G(ISIMISC("DDATE")) ;Discharge date-time
 I 'DDATE Q 0
 ;
 S DTYPE=$G(ISIMISC("DTYPE")) ;#405.1
 I $L(DTYPE)=0 S DTYPE="REGULAR"
 ;S DTYPE=$O(^DG(405.1,"B",DTYPE,0))
 ;I 'DTYPE Q 0
 ;S ISIMISC("ADMIFN")=ADMITIEN
 ;
 S Y=ADATE X ^DD("DD") S ISIMISC("admitDate")=Y
  S Y=ISIMISC("DDATE") X ^DD("DD") S ISIMISC("dischargeDateTime")=Y  ;
  S ISIMISC("typeOfMovement")=DTYPE
  S ISIMISC("masMovementType")="REGULAR"
 Q 1
