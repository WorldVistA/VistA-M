DGENRPA2 ;ALB/CJM/CKN - Enrolled Veterans Report Cont.; JUL 9,1997 ; 11/15/01 8:47am ; 07/22/02
 ;;5.3;Registration;**121,147,232,306,417,456**;Aug 13,1993
 ;
PRINT ;
 N STATS,CRT,QUIT,PAGE1
 S QUIT=0
 S PAGE1=1
 S CRT=$S($E(IOST,1,2)="C-":1,1:0)
 ;
 D GETSTATS
 U IO
 I CRT,PAGE1 W @IOF S PAGE1=0
 D HEADER
 D PART1
 ;D:'QUIT PART2
 ;I 'QUIT,CRT D PAUSE
 I $D(ZTQUEUED) S ZTREQ="@"
 D ^%ZISC
 Q
LINE(LINE) ;
 ;Description: prints a line. First prints header if at end of page.
 ;
 I CRT,($Y>(IOSL-4)) D
 .D PAUSE
 .Q:QUIT
 .W @IOF
 .D HEADER
 .W LINE
 ;
 E  I ('CRT),($Y>(IOSL-2)) D
 .W @IOF
 .D HEADER
 .W LINE
 ;
 E  W !,LINE
 Q
 ;
GETSTATS ;
 ;Description: Gathers the statistics for the report
 ;
 ;*** note *** - part II of report removed, lines commented out were
 ;for that reason 
 ;
 N DFN,PRIORITY,STATUS,I,ENRSBGRP
 S STATUS=""
 F  S STATUS=$O(^DPT("AENRC",STATUS)) Q:STATUS=""  D
 .S DFN=0
 .F  S DFN=$O(^DPT("AENRC",STATUS,DFN)) Q:'DFN  D
 ..S ENRSBGRP=""
 ..S PRIORITY=+$$PRIORITY^DGENA(DFN)
 ..S:((PRIORITY=7)!(PRIORITY=8)) ENRSBGRP=$$EXT^DGENU("SUBGRP",$$ENRSBGRP^DGENA4(DFN))
 ..S CATEGORY=$$CATEGORY^DGENA4(DFN)
 ..S STATS("PRI",PRIORITY_ENRSBGRP)=1+$G(STATS("PRI",PRIORITY_ENRSBGRP))
 ..S STATS("PRI",PRIORITY_ENRSBGRP,"CAT",CATEGORY)=1+$G(STATS("PRI",PRIORITY_ENRSBGRP,"CAT",CATEGORY))
 ..S STATS("STATUS",STATUS)=1+$G(STATS("STATUS",STATUS))
 ;.E  I $$VET^DGENPTA(DFN),'$$DEATH^DGENPTA(DFN),$$ACTIVE^DGENPTA(DFN,$G(INDATE)) D
 ;..S STATUS=+$$STATUS^DGENA(DFN)
 ;..S STATS("NOT ENROLLED","STATUS",STATUS)=1+$G(STATS("NOT ENROLLED","STATUS",STATUS))
 Q
 ;
HEADER ;
 ;Description: Prints the report header.
 ;
 W !,?((IOM-24)\2),"Enrolled Veterans Report"
 W !,?((IOM-12)\2),$$FMTE^XLFDT(DT,"D")
 W !!
 Q
 ;
PAUSE ;
 ;Description: Screen pause.  Sets QUIT=1 if user decides to quit.
 ;
 N DIR,X,Y
 F  Q:$Y>(IOSL-3)  W !
 S DIR(0)="E" D ^DIR
 I '(+Y) S QUIT=1
 Q
 ;
PART1 ;
 ;Description: Prints statistics for enrolled veterans.
 ;
 N AMOUNT,TOTAL,STATUS,PRIORITY,CATEGORY,TOTCAT
 W !!,"CURRENTLY ENROLLED VETERANS AND VETERANS WITH PENDING APPLICATIONS",!!
 W ?59,"Enrolled",?75,"Not Enrolled",?97,"In Process",!
 S TOTAL=0
 S PRIORITY=""
 F  S PRIORITY=$O(STATS("PRI",PRIORITY)) Q:PRIORITY=""  D  Q:QUIT
 .S AMOUNT=+$G(STATS("PRI",PRIORITY))
 .D:PRIORITY=0 LINE("    NO Priority Group: "_"      "_$$F(AMOUNT))
 .D:PRIORITY'=0 LINE("    Priority Group "_$S($L(PRIORITY)=1:PRIORITY_" :       ",1:$E(PRIORITY)_$E(PRIORITY,2)_" :      ")_$$F(AMOUNT))
 .D CATEGORY(1)
 .S TOTAL=TOTAL+AMOUNT
 Q:QUIT
 D LINE("    =====================================")
 Q:QUIT
 D LINE("    Total:                   "_$$F(TOTAL))
 D CATEGORY(0)
 Q:QUIT
 W !!
 S (TOTAL,STATUS)=0
 F  S STATUS=$O(STATS("STATUS",STATUS)) Q:STATUS=""  D  Q:QUIT
 .S AMOUNT=+STATS("STATUS",STATUS)
 .D LINE($$LJ^XLFSTR("    "_$E($$STATUS(STATUS),1,45)_" Status:",54)_$$F(AMOUNT))
 .S TOTAL=TOTAL+(AMOUNT)
 Q:QUIT
 D LINE("    ==============================================================")
 Q:QUIT
 D LINE($$LJ^XLFSTR("    Total:",54)_$$F(TOTAL))
 Q
 ;
PART2 ;
 ;Description: Prints statistics for veterans not enrolled.
 ;
 N AMOUNT,STATUS,PRIORITY,TOTAL
 D LINE(" ")
 D LINE(" ")
 D LINE("VETERANS NOT ENROLLED WITH INPATIENT OR OUTPATIENT ACTIVITY SINCE "_$$FMTE^XLFDT(INDATE,"D"))
 D LINE(" ")
 S TOTAL=0
 F STATUS=3:1:9 D  Q:QUIT
 .S AMOUNT=$G(STATS("NOT ENROLLED","STATUS",STATUS))
 .D LINE($$LJ^XLFSTR("    "_$$STATUS(STATUS)_" Status:",40)_$$F(AMOUNT))
 .S TOTAL=TOTAL+(AMOUNT)
 Q:QUIT
 D LINE("    ================================================")
 Q:QUIT
 D LINE($$LJ^XLFSTR("    Total:",40)_$$F(TOTAL))
 Q
 ;
F(X) ;
 ;Description: Formats X, a number, used as standard format for report.
 ;
 Q $J($FN(X,","),12)
 ;
STATUS(STATUS) ;
 ;Description: Returns status name.
 ;
 Q $$LOWER^VALM1($$EXT^DGENU("STATUS",STATUS))
 ;
CATEGORY(FLG) ;
 ;Displays category totals for each priority
 ; Input:
 ;   FLG - 0 Displays category totals for each priority
 ;         1 Displays total categorys 
 ;
 N CATEGORY
 F CATEGORY="E","N","P" D
 .W ?$S(CATEGORY="E":55,CATEGORY="N":75,1:95)
 .I FLG D  Q
 ..Q:+$G(STATS("PRI",PRIORITY,"CAT",CATEGORY))=0
 ..W $$F(STATS("PRI",PRIORITY,"CAT",CATEGORY))
 ..S TOTCAT(CATEGORY)=$G(TOTCAT(CATEGORY))+STATS("PRI",PRIORITY,"CAT",CATEGORY)
 .Q:+$G(TOTCAT(CATEGORY))=0
 .W $$F(TOTCAT(CATEGORY))
 Q
