DGENRPB2 ;ALB/CJM - Pending Applications for Enrollment Report Cont.; May 4, 1998
 ;;5.3;Registration;**147,232**;Aug 13,1993
 ;
PRINT ;
 N STATS,CRT,QUIT,PAGE1
 K ^TMP($J)
 S QUIT=0
 S PAGE1=1
 S CRT=$S($E(IOST,1,2)="C-":1,1:0)
 ;
 D GETPAT
 U IO
 I CRT,PAGE1 W @IOF S PAGE1=0
 D HEADER
 ;
 D PRNTPATS
 I CRT,'QUIT D PAUSE
 I $D(ZTQUEUED) S ZTREQ="@"
 D ^%ZISC
 K ^TMP($J)
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
GETPAT ;
 ;Description: Gets patients to include in the report
 ;for that reason 
 ;
 N DFN,STATUS,I,DGENRIEN,DGENR,EFFDATE
 S STATUS=""
 F  S STATUS=$O(^DPT("AENRC",STATUS)) Q:STATUS=""  D
 .S DFN=0
 .F  S DFN=$O(^DPT("AENRC",STATUS,DFN)) Q:'DFN  D
 ..S DGENRIEN=$$FINDCUR^DGENA(DFN)
 ..Q:'$$GET^DGENA(DGENRIEN,.DGENR)
 ..I $$CATEGORY^DGENA4(DFN)="P" D
 ...;
 ...N PREFAC,DGPFH,DGINST
 ...S PREFAC=$$PREF^DGENPTA(DFN)
 ...I PREFAC S DGPFH("PREFAC")=PREFAC,DGPFH("EFFDATE")=""
 ...I PREFAC,'$$GETINST^DGENU($G(DGPFH("PREFAC")),.DGINST) S PREFAC=""
 ...I (DGENINST("ALL")!$D(DGENINST(+PREFAC))),(DGENR("APP")>(DGENBEG-1)),(DGENR("APP")<(DGENEND+1)) D
 ....S ^TMP($J,$$LJ($G(DGINST("STANUM")),10)_$$LJ($G(DGINST("NAME")),45),DGENR("STATUS"),DGENR("APP"),DGENRIEN)=$G(DGPFH("EFFDATE"))
 Q
 ;
HEADER ;
 ;Description: Prints the report header.
 ;
 N LINE
 W !,"Pending Applications For Enrollment - Enrollment Category is ""In Process"""
 W !,"Date Range: "_$$FMTE^XLFDT(DGENBEG)_" to "_$$FMTE^XLFDT(DGENEND)
 W ?50," Run Date: "_$$FMTE^XLFDT(DT)
 W !
 W !,"AppDt",?17,"Name",?64,"PatientID",?81,"DOB"
 S $P(LINE,"-",132)="-"
 W !,LINE
 Q
 ;
PAUSE ;
 ;Description: Screen pause.  Sets QUIT=1 if user decides to quit.
 ;
 N DIR,X,Y
 F  Q:$Y>(IOSL-3)  W !
 S DIR(0)="E" D ^DIR
 I ('(+Y))!$D(DIRUT) S QUIT=1
 Q
 ;
PRNTPATS ;
 ;Description: Prints list of patients
 ;
 N PREFAC,APP,DGENRIEN,DGENR,DGPAT,LINE,STATUS
 S PREFAC=""
 F  S PREFAC=$O(^TMP($J,PREFAC)) Q:PREFAC=""  D  Q:QUIT
 .D LINE("  ") Q:QUIT
 .D LINE("PREFERRED FACILITY: "_$S('(+PREFAC):"none",1:PREFAC)_"  "_$G(^TMP($J,PREFAC))) Q:QUIT
 .S STATUS=""
 .F  S STATUS=$O(^TMP($J,PREFAC,STATUS)) Q:STATUS=""  D
 ..D LINE("  ") Q:QUIT
 ..D LINE("  ENROLLMENT STATUS: "_$$STATUS(STATUS)) Q:QUIT
 ..S APP=""
 ..F  S APP=$O(^TMP($J,PREFAC,STATUS,APP)) Q:'APP  D  Q:QUIT
 ...S DGENRIEN=0
 ...F  S DGENRIEN=$O(^TMP($J,PREFAC,STATUS,APP,DGENRIEN)) Q:'DGENRIEN  D  Q:QUIT
 ....Q:'$$GET^DGENA(DGENRIEN,.DGENR)
 ....Q:'$$GET^DGENPTA(DGENR("DFN"),.DGPAT)
 ....S LINE=$$LJ($$DATE(APP),12)_"     "_$$LJ(DGPAT("NAME"),45)_"  "
 ....S LINE=LINE_$$LJ(DGPAT("PID"),15)_"  "_$$LJ($$DATE(DGPAT("DOB")),12)
 ....D LINE(LINE)
 Q
 ;
STATUS(STATUS) ;
 ;Description: Returns status name.
 ;
 Q $$LOWER^VALM1($$EXT^DGENU("STATUS",STATUS))
 ;
DATE(DATE) ;
 Q $$FMTE^XLFDT(DATE,"1")
 ;
LJ(STRING,LENGTH) ;
 Q $$LJ^XLFSTR($E(STRING,1,LENGTH),LENGTH)
