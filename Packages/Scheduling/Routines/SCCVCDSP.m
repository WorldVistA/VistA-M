SCCVCDSP ; ALB/TMP - SCHEDULING VISITS CST LIST SCREEN ; 25-NOV-97
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
EN ; Main entry point
 K XQORS,VALMEVL,SCFASTXT
 D EN^VALM("SCCV CONV MAIN MENU")
 K SCFASTXT
 Q
 ;
INIT ; -- set up initial variables
 D FNL
 S U="^",VALMCNT=0,VALMBG=1
 I $P($G(^SD(404.91,1,"CNV")),U,4) S SCCVDONE=1
 D BLD^SCCVDSP("CST")
 Q
 ;
HDR ;
 S VALMHDR(1)="Conversion Specification Templates [CST]"
 S VALMHDR(2)="Full Conversion Date Range: "_$$FMTE^XLFDT($S(+$G(^SD(404.91,1,"CNV")):+^("CNV"),1:2801001))_" - "_$$FMTE^XLFDT($$ENDDATE^SCCVU())
 Q
 ;
FNL ; Clean up
 D FNL^SCCVDSP("CST")
 Q
 ;
REFRESH ; -- refresh display
 D BLD^SCCVDSP("CST")
 S VALMBCK="R"
 Q
