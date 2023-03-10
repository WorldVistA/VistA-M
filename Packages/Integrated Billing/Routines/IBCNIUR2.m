IBCNIUR2 ;AITC/VAD - Interfacility Ins. Update Report - cont;3-FEB-2021
 ;;2.0;INTEGRATED BILLING;**687**; 21-MAR-94;Build 88
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;Variables:
 ;IBCNFAC(ien) = Facilities (if IBCNFAC=1, include all)
 ;IBCNIRTN = "IBCNIUR1" (routine name for queueing)
 ;IBCNIUR("BEGDT") = Begin Date
 ;IBCNIUR("ENDDT") = End Date
 ;IBCNIUR("IBOUT") = "E"xcel, "R"eport
 ;IBCNIUR("PS") = processing status: 1-With, 0-Without
 ;IBCNIUR("SD") = "S"ummary or "D"etail
 ;IBCNIUR("SORT") = "D"ate or "F"acility
 ;IBCNIUR("SR") = "S"ent or "R"eceived
 ;
 Q
 ;
PRINT ;Generate the report output (called by COMPILE^IBCNIUR1)
 N CRT,DASHES,EORMSG,HDR1,HDR1A,HDR1B,IBPGC,IBPXT,MAXCNT,NONEMSG,SORTTXT
 N TSTAMP,ZTSTOP
 ;
 S (IBPGC,IBPXT)=0
 S NONEMSG="* * * N O   D A T A   F O U N D * * *"
 S EORMSG="*** END OF REPORT ***"
 S TSTAMP=$$FMTE^XLFDT($$NOW^XLFDT,1) ; time of report
 S $P(DASHES,"-",$S(IBRPTSD="S":80,1:132))=""
 ;
 ;Set Headers
 S HDR1="Date Range: "_$$FMTE^XLFDT(IBBDT,"5Z")_" - "_$$FMTE^XLFDT(IBEDT,"5Z")
 S HDR1A=$S(IBRPTSR="S":"Sent to",1:"Received from")_" other Facilities"
 S HDR1B=""
 I IBRPTSD="D" D   ;Set up DETAIL report sub-heading
 .S HDR1A=$S($G(IBCNFAC)=1:"All",1:"Selected")_" Facilities, "_HDR1A
 .S SORTTXT=$S(IBSORT="D":"Date",IBSORT="P":"Patient Name",1:"Facility")
 .I IBSORT="F" S SORTTXT=$S(IBRPTSR="S":"Sent to ",1:"Received from ")_SORTTXT
 .S HDR1B="Primary sort: "_SORTTXT
 ;
 ;Set IO parameters
 S MAXCNT=IOSL-6,CRT=0
 S:IOST["C-" MAXCNT=IOSL-3,CRT=1
 ;
 I IBOUT="E" D EHDR I $G(ZTSTOP)!IBPXT G EXITXX     ;EXCEL Header
 I IBOUT="R" D HEADER I $G(ZTSTOP)!IBPXT G EXITXX   ;REPORT Header
 ; 
 ;If nothing exists, display No Data message
 I IBRPTSD="D",$G(^TMP($J,IBCNIRTN))=0 D  G EXITPR
 .S OFFSET=$$CENTER(NONEMSG,$S(IBRPTSD="S":80,1:132))
 .S ELINE="" D LINE(ELINE)  Q:$G(ZTSTOP)!IBPXT
 .S $E(ELINE,OFFSET,OFFSET+$L(NONEMSG))=NONEMSG
 .D LINE(ELINE)
 ;
 I IBOUT="E" D EXCEL(IBRPTSD,IBRPTSR,IBSORT) G:$G(ZTSTOP)!IBPXT EXITXX
 I IBOUT="R" D REPORT(IBRPTSD,IBRPTSR,IBSORT) G:$G(ZTSTOP)!IBPXT EXITXX
 ;
EXITPR ; print end of rpt
 N ELINE
 I IBOUT="E" W !,EORMSG S IBPGC=1
 I IBOUT="R" D  G:$G(ZTSTOP)!IBPXT EXITXX
 .S OFFSET=$$CENTER(EORMSG,$S(IBRPTSD="S":80,1:132))
 .S ELINE="" D LINE(ELINE)  Q:$G(ZTSTOP)!IBPXT
 .S $E(ELINE,OFFSET,OFFSET+$L(EORMSG))=EORMSG
 .D LINE(ELINE)  Q:$G(ZTSTOP)!IBPXT
 I CRT,IBPGC>0,'$D(ZTQUEUED) D EOL
 ;
EXITXX ; done printing
 D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
HEADER ;print header for each page (not excel version)
 N HDR,OFFSET,SRT
 I CRT,IBPGC>0,'$D(ZTQUEUED) D EOL I IBPXT Q
 I $D(ZTQUEUED),$$S^%ZTLOAD() S (ZTSTOP,IBPXT)=1 Q
 S IBPGC=IBPGC+1
 W @IOF,!,"Interfacility Ins. Update Report-",$S(IBRPTSD="S":"Summary",1:"Detail")
 S HDR=TSTAMP_"  Page: "_IBPGC,OFFSET=$S(IBRPTSD="S":80,1:132)-($L(HDR)+1)
 W ?OFFSET,HDR
 I IBRPTSD="S" W !,HDR1,?80-($L(HDR1A)+1),HDR1A
 I IBRPTSD="D" D
 .S OFFSET=$$CENTER(HDR1A,132-($L(HDR1)+$L(HDR1B)))
 .W !,HDR1,?OFFSET+$L(HDR1),HDR1A,?132-($L(HDR1B)+1),HDR1B
 .I 'IBRPTPS D
 ..W !!,?30,"Last",?93,$S(IBRPTSR="S":"Destination",1:"Originating"),?123,"Date"
 ..W !,"Patient Name",?29,"4 SSN",?36,"Insurance Company",?68,"Subscriber ID",?89,"COB",?93,"Facility",?123,$S(IBRPTSR="S":"Sent",1:"Received")
 .I +IBRPTPS D
 ..W !!,?26,"Last",?82,"Originating",?100,"Date"
 ..W !,"Patient Name",?25,"4 SSN",?31,"Insurance Company",?57,"Subscriber ID",?78,"COB",?82,"Facility",?100,"Received",?109,"Processing Status"
 W !,DASHES
 Q
 ;
EHDR ;Header for Excel
 N LINE,TREC
 W !,"Interfacility Ins. Update Report"_U_$S(IBRPTSD="S":"Summary",1:"Detail")_U_TSTAMP
 W !,HDR1_U_HDR1A
 I IBRPTSD="D" D   ;Detail version
 .S LINE="Patient Name"_U_"Last 4 SSN"_U_"Insurance Company"_U_"Subscriber ID #"
 .S LINE=LINE_U_"COB"_U_$S(IBRPTSR="S":"Destination",1:"Originating")_" Facility"
 .S LINE=LINE_U_"Date "_$S(IBRPTSR="S":"Sent",1:"Received")
 .I +IBRPTPS S LINE=LINE_U_"Processing Status"
 I IBRPTSD="S" D   ;Summary version
 .S TREC=$G(^TMP($J,IBCNIRTN))
 .S LINE="Facility (Total = "_+$P(TREC,U,2)_")"
 .S LINE=LINE_U_"# of Transmissions (Total = "_+TREC_")"
 W !,LINE
 Q
 ;
EOL ;display "end of page" message and set exit flag
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LIN
 I MAXCNT<51 F LIN=1:1:(MAXCNT-$Y) W !
 S DIR(0)="E" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) S IBPXT=1
 Q
 ;
EXCEL(IBRPTSD,IBRPTSR,IBSORT) ;Output in Excel format
 N DLINE,SORT,SORT1,SORT2,SORT3
 I IBRPTSD="S" D  Q   ;For SUMMARY format
 .S SORT1=""
 .F  S SORT1=$O(^TMP($J,IBCNIRTN,"VAMCNAME",SORT1)) Q:SORT1=""!$G(ZTSTOP)!IBPXT  D
 ..S DLINE=SORT1_U_+$G(^TMP($J,IBCNIRTN,"VAMCNAME",SORT1))
 ..D LINE(DLINE)
 ;
 ;DETAIL format
 S SORT=""
 F  S SORT=$O(^TMP($J,IBCNIRTN,SORT)) Q:SORT=""!$G(ZTSTOP)!IBPXT  D
 .S SORT1=""
 .F  S SORT1=$O(^TMP($J,IBCNIRTN,SORT,SORT1)) Q:SORT1=""!$G(ZTSTOP)!IBPXT  D
 ..S SORT2=""
 ..F  S SORT2=$O(^TMP($J,IBCNIRTN,SORT,SORT1,SORT2)) Q:SORT2=""!$G(ZTSTOP)!IBPXT  D
 ...S SORT3=""
 ...F  S SORT3=$O(^TMP($J,IBCNIRTN,SORT,SORT1,SORT2,SORT3)) Q:SORT3=""!$G(ZTSTOP)!IBPXT  D
 ... .S DLINE=^TMP($J,IBCNIRTN,SORT,SORT1,SORT2,SORT3)
 ... .D LINE(DLINE)
 Q
 ;
REPORT(IBRPTSD,IBRPTSR,IBSORT) ;REPORT format (not Excel version)
 N DATA,DLINE,SORT1,SORT2,SORT3,TREC
 I IBRPTSD="S" D  Q:$G(ZTSTOP)!IBPXT  ;SUMMARY format
 .S TREC=$G(^TMP($J,IBCNIRTN))
 .W !!,"Total Number of Transmissions "_$S(IBRPTSR="S":"Sent",1:"Received"),?54,$J(+TREC,6)
 .W !,"Total Facilities ",?54,$J(+$P(TREC,U,2),6)
 .S SORT1=""
 .F  S SORT1=$O(^TMP($J,IBCNIRTN,"VAMCNAME",SORT1)) Q:SORT1=""!$G(ZTSTOP)!IBPXT  D
 ..S DATA=^TMP($J,IBCNIRTN,"VAMCNAME",SORT1)
 ..S DLINE=""
 ..S $E(DLINE,3,35)=SORT1
 ..S $E(DLINE,40,46)=$J($P(DATA,U,1),6)
 ..D LINE(DLINE)
 ..Q
 ;
 ;DETAIL format
 S SORT=""
 F  S SORT=$O(^TMP($J,IBCNIRTN,SORT)) Q:SORT=""  D  Q:$G(ZTSTOP)!IBPXT
 .S SORT1=""
 .F  S SORT1=$O(^TMP($J,IBCNIRTN,SORT,SORT1)) Q:SORT1=""  D  Q:$G(ZTSTOP)!IBPXT
 ..S SORT2=""
 ..F  S SORT2=$O(^TMP($J,IBCNIRTN,SORT,SORT1,SORT2)) Q:SORT2=""  D  Q:$G(ZTSTOP)!IBPXT
 ...S SORT3=""
 ...F  S SORT3=$O(^TMP($J,IBCNIRTN,SORT,SORT1,SORT2,SORT3)) Q:SORT3=""  D  Q:$G(ZTSTOP)!IBPXT
 ... .S DATA=$G(^TMP($J,IBCNIRTN,SORT,SORT1,SORT2,SORT3))
 ... .S DLINE=""
 ... .I 'IBRPTPS D  ;Set output W/O Processing Status
 ... ..S $E(DLINE,1,28)=$E($P(DATA,U),1,28)     ;Patient Name
 ... ..S $E(DLINE,30,34)=$P(DATA,U,2)           ;Last 4 of SSN
 ... ..S $E(DLINE,37,66)=$E($P(DATA,U,3),1,30)  ;Insurance Company Name
 ... ..S $E(DLINE,69,88)=$E($P(DATA,U,4),1,20)  ;Subscriber ID
 ... ..S $E(DLINE,91,91)=$P(DATA,U,5)           ;COB
 ... ..S $E(DLINE,94,121)=$E($P(DATA,U,6),1,28) ;Facility Name
 ... ..S $E(DLINE,124,131)=$P(DATA,U,7)         ;Date (received or sent)
 ... ..D LINE(DLINE)
 ... .;
 ... .I +IBRPTPS D    ;Set output W/ Processing Status
 ... ..S $E(DLINE,1,25)=$E($P(DATA,U),1,25)    ;Patient Name
 ... ..S $E(DLINE,26,30)=$P(DATA,U,2)          ;Last 4 of SSN
 ... ..S $E(DLINE,32,56)=$E($P(DATA,U,3),1,25) ;Insurance Company Name
 ... ..S $E(DLINE,58,77)=$E($P(DATA,U,4),1,20) ;Subscriber ID
 ... ..S $E(DLINE,80,80)=$P(DATA,U,5)          ;COB
 ... ..S $E(DLINE,83,99)=$E($P(DATA,U,6),1,17) ;Facility Name
 ... ..S $E(DLINE,101,108)=$P(DATA,U,7)        ;Received Date
 ... ..S $E(DLINE,110,132)=$E($P(DATA,U,8),1,23) ;Processing Status/Receiver Status
 ... ..D LINE(DLINE)
 Q
 ;
LINE(LINE) ;Print detail line
 I $Y+1>MAXCNT D HEADER I $G(ZTSTOP)!IBPXT Q
 W !,LINE
 Q
 ;
CENTER(LINE,XWIDTH) ;return length of a centered line
 N LENGTH,OFFSET
 S LENGTH=$L(LINE),OFFSET=XWIDTH-$L(LINE)\2
 Q OFFSET
 ;
