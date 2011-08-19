YSD4E020 ;DALISC/MJD - DSM CONVERSION ERROR REPORT ;  [ 04/08/94  11:11 AM ]
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
 QUIT
 ;
PROC ;
 ;  Called by YSD4E010
 ;
 S (YSD4EP,YSD4EABT)=0,YSD4ERD=$H
 D HDR ;                    Write Report Header
 D DHDR ;                   Write detail Header
 D WD I YSD4EABT=1 QUIT  ;  Write error detail
 D TOTALS ;                 Write totals to end of report
 D KILLALL^YSD4UT01 ;       Kill all variables
 QUIT
 ;
HDR ;Report header
 S YSD4EP=YSD4EP+1,YSD4EL=6
 W @IOF,!,"DSM Conversion Error Report",?(IOM-45),$J($$INITSITE^YSD4E010,45),!
 W $$HTE^XLFDT(YSD4ERD),?(IOM-10),"Page:  ",$J(YSD4EP,3),!,$$REPEAT^XLFSTR("=",IOM),!
 QUIT
 ;
DHDR ;Detail header
 W "File#",?9,"Entry#",?16,"Node",?22,"Mult#",?30,"Error Text",?74,"Code#",!,$$REPEAT^XLFSTR("=",IOM),!
 I $$S^%ZTLOAD D  QUIT
 .  S (ZTSTOP,YSD4EABT)=1
 .  W !!,"You have requested job# ",ZTSK," to be stopped!!!",!
 QUIT
 ;
WD ;
 S YSD4ESME=0,YSD4ECON=1
 F  S YSD4ESME=$O(^YSD(627.99,"AS","TE",YSD4ESME)) Q:YSD4ESME'>0!('YSD4ECON)!(YSD4EABT=1)  D
 .  D PGBRK Q:YSD4EABT=1!('YSD4ECON)
 .  S YSD4ESMD=$G(^YSD(627.99,"AS","TE",YSD4ESME))
 .  W !,$P(YSD4ESMD,U,3),?9,$J($P(YSD4ESMD,U,5),5),?17,$P(YSD4ESMD,U,4)
 .  W ?22,$J($P(YSD4ESMD,U,6),5),?30,$P(YSD4ESMD,U,2)
 .  W ?74,$P(YSD4ESMD,U,7)
 .  S YSD4EL=YSD4EL+1
 QUIT
 ;
PGBRK ;
 N DIR
 I (YSD4EL+4)>IOSL&(IOST'["C-") D HDR,DHDR QUIT
 I (YSD4EL+4)>IOSL&(IOST["C-") D
 .   W !!
 .   S DIR(0)="EA",DIR("A")="Hit RETURN to continue, or '^' to continue... "
 .   D ^DIR
 .   I X[U S YSD4ECON=0 ;STOP....User exit
 .   I YSD4ECON&(YSD4ESME>0) D HDR,DHDR
 QUIT
 ;
TOTALS ;Summary of total errors written to end of error report
 S YSD4EP=YSD4EP+1
 W @IOF,!,"DSM Conversion Error Totals",?(IOM-45),$J($$INITSITE^YSD4E010,45),!
 W $$HTE^XLFDT(YSD4ERD),?(IOM-10),"Page:  ",$J(YSD4EP,3),!,$$REPEAT^XLFSTR("=",IOM),!
 D SD^YSD4E010
 QUIT
 ;
STATS ; Called from REPORT^YSD4DSM
 ; This controls the printing of the Conversion summary
 D SHDR ;Summary Header
 D STOT ;Summary totals
 QUIT
 ;
SHDR ;Report header
 S YSD4ERD=$H
 W @IOF,!,"DSM Conversion Summary Report",?(IOM-45),$J($$INITSITE^YSD4E010,45),!
 W $$HTE^XLFDT(YSD4ERD),?(IOM-10),!,$$REPEAT^XLFSTR("=",IOM),!
 QUIT
 ;
STOT ;
 W "Medical Record # of records:",?(IOM-30),$J($P($G(^MR(0)),U,4),10),!
 W "Medical Record # of records converted:",?(IOM-30),$J($G(^YSD(627.99,"AS","MR NUMBER CONVERTED")),10),!
 W "Generic Progress Notes # of records:",?(IOM-30),$J($P($G(^GMR(121,0)),U,4),10),!
 W "Generic Progress Notes # of records converted:",?(IOM-30),$J($G(^YSD(627.99,"AS","GPN NUMBER CONVERTED")),10),!
 W "Diagnostic Results # of records:",?(IOM-30),$J($P($G(^YSD(627.8,0)),U,4),10),!
 W "Diagnostic Results # of records converted:",?(IOM-30),$J($G(^YSD(627.99,"AS","DR NUMBER CONVERTED")),10),!
 W $$REPEAT^XLFSTR("-",IOM),!
 S YSD4STR=($P($G(^MR(0)),U,4))+($P($G(^GMR(121,0)),U,4))+($P($G(^YSD(627.8,0)),U,4))
 W "Total number of records:",?(IOM-30),$J(YSD4STR,10),!
 S YSD4SCR=($G(^YSD(627.99,"AS","MR NUMBER CONVERTED")))+($G(^YSD(627.99,"AS","GPN NUMBER CONVERTED")))+($G(^YSD(627.99,"AS","DR NUMBER CONVERTED")))
 W "Total number of records converted:",?(IOM-30),$J(YSD4SCR,10),!
 QUIT
 ;
EOR ;YSD4E020 - DSM CONVERSION ERROR REPORT ;3/22/94
