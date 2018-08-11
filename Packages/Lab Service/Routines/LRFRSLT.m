LRFRSLT ;AITC/CR - LAB DATA FUNCTION API WRAPPER ; 10/25/17 3:46pm
 ;;5.2;LAB SERVICE;**476**;Sep 27, 1994;Build 11
 ; This routine is used by the FileMan function LRRESULT to generate a
 ; report of verified lab tests for multiple patients over a given
 ; date range
 ;
GETLAB(MDAYS,TEST,SPEC,DFN) ; Custom lab lookup API for results
 ; MDAYS = # of days to look back for verified lab test results
 ; TEST  = IEN for a given lab test, file #60
 ; SPEC  = IEN for a given specimen, file #61
 ; DFN   = IEN for patient, file #2
 ;
 N LRBGDT,RESULT,LDATE,UNITS
 N X,X1,X2
 Q:'+$G(TEST) ""
 Q:'+$G(DFN) ""
 S MDAYS=$G(MDAYS,365)
 S X1=DT,X2=-$G(MDAYS) D C^%DTC
 S LRBGDT=$S(X<DT:X,1:0)
 D RR^LR7OR1(DFN,,LRBGDT,DT,,TEST,,1,$G(SPEC))
 D FORMAT
 I $G(RESULT)']"" Q "NONE FOUND IN LAST "_+$S(+MDAYS:MDAYS,1:365)_" DAYS"
 Q RESULT_" "_UNITS_";"_$$FMTE^XLFDT(LDATE,2)
 ;
FORMAT N IDT,LOC,NODE
 S IDT=0 F  S IDT=$O(^TMP("LRRR",$J,DFN,"CH",IDT)) Q:'+IDT  D
 . S LOC=0 F  S LOC=$O(^TMP("LRRR",$J,DFN,"CH",IDT,LOC)) Q:'+LOC  D
 .. S NODE=$G(^TMP("LRRR",$J,DFN,"CH",IDT,LOC))
 .. S RESULT=$P(NODE,U,2)
 .. S UNITS=$P(NODE,U,4)
 .. S LDATE=9999999-IDT
 Q
