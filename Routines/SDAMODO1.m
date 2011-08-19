SDAMODO1 ;ALB/SCK - PROVIDER DX REPORT, DISPLAY OPTIONS ; 05 Oct 98  8:42 PM
 ;;5.3;Scheduling;**159**;Aug 13, 1993
START ;
 Q
SHOW() ;  display selected report options
 N SD
 D HOME^%ZIS W @IOF,*13
 W !!,$$LINE^SDAMODO("Report Specifications")
 W !!,"Encounter Dates: ",$$FMTE^XLFDT(SDBEG,"D")," to ",$$FMTE^XLFDT(SDEND,"D")
 W !!,"Report will be sorted by Division,"
 W !,"Divisions Selected: ",$S(VAUTD:"ALL",1:"")
 S SD=0 F  S SD=$O(VAUTD(SD)) Q:'+SD  W !?5,VAUTD(SD)
 W !!,"Then sorted by ",$P($T(SORT+SORT1),";;",2),", ",$P($T(SORT+SORT2),";;",2)," and Encounter Date"
 S SVAR1=$P($T(VAR+SORT1),";;",2)
 W !!,$P($T(SORT+SORT1),";;",2)," Selected: ",$S(@SVAR1:"ALL",1:"") D
 . S SD=0 F  S SD=$O(@SVAR1@(SD)) Q:'+SD  D:($Y+5)>IOSL PAUSE^VALM1 W !?5,@SVAR1@(SD)
 S SVAR2=$P($T(VAR+SORT2),";;",2)
 W !!,$P($T(SORT+SORT2),";;",2)," Selected: ",$S(@SVAR2:"ALL",1:"") D
 . S SD=0 F  S SD=$O(@SVAR2@(SD)) Q:'+SD  D:($Y+5)>IOSL PAUSE^VALM1 W !?5,@SVAR2@(SD)
 W !,$$LINE^SDAMODO("")
 S Y=1
 K SVAR1,SVAR2,SD
 Q (Y)
SORT ;
 ;;Provider
 ;;Diagnosis
 ;;Patient
 ;;Clinic
 ;;Primary Stop Code
VAR ;
 ;;PROVDR
 ;;PDIAG
 ;;PATN
 ;;CLINIC
 ;;STOPC
