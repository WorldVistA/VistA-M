VIABU ;AITC/BWF - General Utilites for Windows Calls;2/12/16  15:15
 ;;1.0;VISTA INTEGRATION ADAPTER;**5**;06-FEB-2014;Build 8
 ;
EXTNAME(VAL,IEN,FN) ; return external form of pointer
 ; IEN=internal number, FN=file number
 N REF S REF=$G(^DIC(FN,0,"GL")),VAL=""
 I $L(REF),+IEN S VAL=$P($G(@(REF_IEN_",0)")),U)
 Q
