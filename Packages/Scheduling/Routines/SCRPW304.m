SCRPW304 ; BPFO/JRC - Performance Monitors National Summary Report; 30 Jul 2003 ; 2/5/04 7:13am
 ;;5.3;SCHEDULING;**292,335,337**;AUG 13, 1993
 ;
EN ;Main Entry Point
 ;Declare variable(s) and arrays
 N SCRNARR,SORTARR
 S SCRNARR="^TMP(""SCRPW"",$J,""SCRNARR"")"
 S SORTARR="^TMP(""SCRPW"",$J,""SORTARR"")"
 K @SCRNARR,@SORTARR
 ;Set national screen/sort
 D ROLLUP^SCRPW303(SCRNARR,SORTARR)
 ;Get date frame
 I $$DATE^SCRPW302("","",SCRNARR)=0 D EX1 Q
 ;Queue report
 W !!
 N ZTDESC,ZTIO,ZTSAVE,TMP
 S ZTIO=""
 S ZTDESC="Performance Monitor National Summary Report"
 S ZTSAVE("SCRNARR")=""
 S TMP=$$OREF^DILF(SCRNARR)
 S ZTSAVE(TMP)=""
 I $D(@SCRNARR)#2 S ZTSAVE(SCRNARR)=""
 S ZTSAVE("SORTARR")=""
 S TMP=$$OREF^DILF(SORTARR)
 S ZTSAVE(TMP)=""
 I $D(@SORTARR)#2 S ZTSAVE(SORTARR)=""
 D EN^XUTMDEVQ("EN1^SCRPW304",ZTDESC,.ZTSAVE)
 D EX1
 Q
 ;
EN1 ;Tasked entry point
 ;Input  : SCRNARR - Screen array
 ;         SORTARR - Sort array
 ;Output : None
 ;
 N OUTARR,STOP,PAGENUM,STOP,SUMNODE,PINODE,DIV
 S OUTARR="^TMP(""SCRPW"",$J,""OUTARR"")"
 S STOP=0
 K @OUTARR
 S PAGENUM=1
 ;Get data
 D GETDATA^SDPMUT1(SCRNARR,SORTARR,OUTARR)
 ;Print summary for facility
 S DIV=""
 D PRTHEAD
 S SUMNODE=$G(@OUTARR@("SUMMARY"))
 S PINODE=$G(@OUTARR@("SUMMARY","PI"))
 I '$$S^%ZTLOAD() D PRTSUMS
 D WAIT^SCRPW301 I STOP D EXIT Q
 ;Print divisional summaries
 S DIV="" F  S DIV=$O(@OUTARR@("SUBTOTAL",DIV)) Q:DIV=""  D  Q:STOP
 .D PRTHEAD
 .S SUMNODE=$G(@OUTARR@("SUBTOTAL",DIV))
 .S PINODE=$G(@OUTARR@("SUBTOTAL",DIV,"PI"))
 .D PRTSUMS
 .D WAIT^SCRPW301 I STOP Q
 ;Cleanup and quit
 D EXIT
 Q
 ;
PRTHEAD ;Page Header
 ;Input  : OUTARR - Data array
 ;         SCRNARR - Screen array
 ;         PAGENUM - Page number
 ;         DIV - Division Name ^ Division Number
 ;             - NULL if facility name/number should be used
 ;Output : None
 ;         PAGENUM is incremented by 1
 ;
 N TMP,LINE,VISN
 W @IOF
 W !,"Performance Monitor National Summary Report",?70,"Page: ",PAGENUM
 S LINE="Division: "_$P(DIV,U,1)_" ("_$P(DIV,U,2)_")"
 I DIV="" D
 .S TMP=$$SITE^VASITE()
 .D PARENT^XUAF4("VISN","`"_$P(TMP,U,1))  ; SD*5.3*337
 .S VISN="",VISN=$O(VISN("P",VISN)) Q:VISN=""  ; SD*5.3*337
 .S LINE="Facility: "_$P(TMP,U,2)_" ("_$P(TMP,U,3)_")"_" "_$P($G(VISN("P",VISN)),U,1)
 W !!,LINE
 W !,"Run Date: ",$$HTE^XLFDT($H)
 W !,"Encounter Date Range: ",$$FMTE^XLFDT($P(@SCRNARR@("RANGE"),U,1))
 W " to ",$$FMTE^XLFDT($P(@SCRNARR@("RANGE"),U,2))
 I DIV="" S LINE=+$G(@OUTARR@("SUMMARY"))
 I DIV'="" S LINE=+$G(@OUTARR@("SUBTOTAL",DIV))
 W !,"Total number of encounters (denominator): ",LINE
 W !!,"Total number of encounters in the denominator are those included in the"
 W !,"Performance Monitor cohort"
 S PAGENUM=PAGENUM+1
 Q
 ;
PRTSUMS ;Print summaries
 ;Input  : SUMNODE - Summary node from OUTARR
 ;         PINODE - PI node from OUTARR
 ;Output : None
 ;
 I (SUMNODE="")&(PINODE="") D  Q
 .W !
 .W !,"***********************************************"
 .W !,"*  NOTHING TO REPORT FOR SELECTED DATE FRAME  *"
 .W !,"***********************************************"
 N VAL,DASH6,TOTENC,CMPENC,PRCNT,TMP,SCANNED,NPN
 S $P(DASH6,"-",6)="-"
 S $P(PRCNT,U,11)=""
 ;Get general totals
 S TOTENC=+$P(SUMNODE,U,1)
 S CMPENC=+$P(SUMNODE,U,2)
 S SCANNED=+$P(SUMNODE,U,7)
 S NPN=+$P(SUMNODE,U,9)
 ;Calculate compliance percentages
 I TOTENC S VAL=0 F TMP=1:1:11 D
 .I (TOTENC-SCANNED)>0 S VAL=100*($P(PINODE,U,TMP)/(TOTENC-SCANNED))
 .S $P(PRCNT,U,TMP)=$TR($J(VAL,3,0)," ")_"%"
 ;Part 1
 W !!,"Signed",?21,"Elapsed Time (Days)"
 W !,"within",?14,"0-1",?22,">1-2",?31,">2-3",?39,">3-4",?47,">4-5"
 W ?55,">5-6",?63,">6-7",?71,">7-8"
 W !,?13,DASH6,?21,DASH6,?30,DASH6,?38,DASH6,?46,DASH6,?54,DASH6
 W ?62,DASH6,?70,DASH6
 W !,"Encounters",?13,+$P(PINODE,U,1),?21,+$P(PINODE,U,2)
 W ?30,+$P(PINODE,U,3),?38,+$P(PINODE,U,4),?46,+$P(PINODE,U,5)
 W ?54,+$P(PINODE,U,6),?62,+$P(PINODE,U,7),?70,+$P(PINODE,U,8)
 W !,"Percentage",?13,$P(PRCNT,U,1),?21,$P(PRCNT,U,2)
 W ?30,$P(PRCNT,U,3),?38,$P(PRCNT,U,4),?46,$P(PRCNT,U,5)
 W ?54,$P(PRCNT,U,6),?62,$P(PRCNT,U,7),?70,$P(PRCNT,U,8)
 ;Part 2
 W !!,"Signed",?21,"Elapsed Time (Days)",?45,"Pending",?60,"Scanned"
 W !,"within",?14,">8-9",?22,">9-10",?32,">10",?38,"Signatures"
 W ?50,"Notes",?59,"Note Only"
 W !,?13,DASH6,?21,DASH6,?30,DASH6,?38,DASH6_"----"
 W ?50,DASH6,?59,DASH6_"---"
 W !,"Encounters",?13,+$P(PINODE,U,9),?21,+$P(PINODE,U,10)
 W ?30,+$P(PINODE,U,11),?38,TOTENC-CMPENC-NPN-SCANNED-(+$P(PINODE,U,11))
 W ?50,NPN,?59,SCANNED
 W !,"Percentage",?13,$P(PRCNT,U,9),?21,$P(PRCNT,U,10)
 W ?30,$P(PRCNT,U,11)
 S (VAL,NPNVAL)=0
 I (TOTENC-SCANNED)>0 S NPNVAL=100*(NPN/(TOTENC-SCANNED))
 S NPNVAL=$TR($J(NPNVAL,3,0)," ")_"%"
 I (TOTENC-SCANNED)>0 S VAL=100*((TOTENC-SCANNED-CMPENC-NPN-(+$P(PINODE,U,11)))/TOTENC)
 S VAL=$TR($J(VAL,3,0)," ")_"%"
 W ?38,VAL,?50,NPNVAL,?59,"N/A"
 Q
 ;
EXIT ;Kill temporary arrays
 K @OUTARR
EX1 K @SORTARR,@SCRNARR
 Q
