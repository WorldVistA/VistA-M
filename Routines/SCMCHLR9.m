SCMCHLR9 ;ALB/KCL - PCMM HL7 Reject Transmission Report Con't; 22-FEB-2000
 ;;5.3;Scheduling;**210,284,297**;AUG 13,1993
 ;
PRINT ; Description: Used to print report.
 ;
 ;Init variables
 N CRT,QUIT,PAGE,SUBSCRPT,SCARRAY
 K SCARRAY
 S SCARRAY="SCERRSRT"
 K ^TMP(SCARRAY,$J)
 S (QUIT,PAGE)=0
 S CRT=$S($E(IOST,1,2)="C-":1,1:0)
 ;
 ;Get PCMM HL7 Transmission Log errors
 D GET^SCMCHLR2(SCARRAY,$G(SCRP("BEGIN")),$G(SCRP("END")),$G(SCRP("EPS")),$G(SCRP("SORT")))
 ;
 U IO
 I CRT,PAGE=0 W @IOF
 S PAGE=1
 D HEADER
 D PRINTERR($G(SCRP("SORT")),$G(SCRP("EPS")))
 I CRT,'QUIT D PAUSE
 I $D(ZTQUEUED) S ZTREQ="@"
 D ^%ZISC
 ;
 K ^TMP(SCARRAY,$J)
 Q
 ;
LINE(LINE) ;
 ; Description: Prints a line. First prints header if at end of page.
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
 ;
HEADER ; Description: Prints the report header.
 ;
 N LINE,X
 I $Y>1 W @IOF
 W !,"PCMM Transmission Error Report"
 W ?33,"Run Date: "_$$FMTE^XLFDT($$NOW^XLFDT,"1P")
 W ?70,"Page ",PAGE
 S PAGE=PAGE+1
 W !
 S X=$G(SCRP("SORT"))
 W !,"Sort By: "_$S(X="N":"Patient Name",X="D":"Date Error Received",X="P":"Provider",1:"Unknown")
 I SCRP("BEGIN") D
 .W ?40,"Date Range: "_$$FMTE^XLFDT(SCRP("BEGIN"))_" to "_$$FMTE^XLFDT($G(SCRP("END")))
 E  D
 .W ?40,"Date Range: "_$$DRMSG^SCMCHLR1
 S X=$G(SCRP("EPS"))
 W !,"Error Processing Status: "_$S(X=1:"New",X=2:"Checked",X=3:"New/Checked",1:"Unknown")
 W ?40,$$MRKMSG^SCMCHLR1
 W !
 ;
 W !?2,"Patient Name",?23,"PATID",?31,"Date Rec",?42,"Provider",?63,"Type",?70,"EP Status"
 S $P(LINE,"-",80)="-"
 W !,LINE,!
 Q
 ;
 ;
PAUSE ; Description: Screen pause.  Sets QUIT=1 if user decides to quit.
 ;
 N DIR,X,Y
 F  Q:$Y>(IOSL-3)  W !
 S DIR(0)="E"
 D ^DIR
 I ('(+Y))!$D(DIRUT) S QUIT=1
 Q
 ;
 ;
PRINTERR(SCSORTBY,SCEPS) ; Description: Print list of errors.
 ;
 ;  Input:
 ;   SCSORTBY - Sort by criteria
 ;               N -> Patient Name
 ;               D -> Date/Time Ack Received
 ;               P -> Provider
 ;      SCEPS -  Error processing status
 ;
 ; Output: None
 ;
 N DFN,SCSUB,SCLINE,SCTXT,SCTLIEN,SCERIEN,SCTLOG,SCPROV,SCTYPE
 ;
 ;Loop thru sort array by pat name, OR date ack rec'd, OR provider
 S SCSUB=$S(SCSORTBY="N":"",SCSORTBY="P":"",1:0)
 F  S SCSUB=$O(^TMP("SCERRSRT",$J,SCSORTBY,SCSUB)) Q:SCSUB=""  D  Q:QUIT
 .;loop through PCMM HL7 Transmission Log ien(s)
 .S SCTLIEN=0
 .F  S SCTLIEN=$O(^TMP("SCERRSRT",$J,SCSORTBY,SCSUB,SCTLIEN)) Q:'SCTLIEN  D  Q:QUIT
 ..;loop through Error Code subfile ien(s)
 ..S SCERIEN=0
 ..F  S SCERIEN=$O(^TMP("SCERRSRT",$J,SCSORTBY,SCSUB,SCTLIEN,SCERIEN)) Q:'SCERIEN  D  Q:QUIT
 ...;
 ...;get data for PCMM HL7 Trans Log entry
 ...I $$GETLOG^SCMCHLA(SCTLIEN,SCERIEN,.SCTLOG) D
 ....;
 ....;set retransmit flag in line
 ....S SCLINE=$S($G(SCTLOG("STATUS"))="M":"*",1:" ")
 ....;
 ....;set patient name in line
 ....S SCTXT=$$LOWER^VALM1($S($G(SCTLOG("WORK")):"WORKLOAD",$G(SCTLOG("DFN")):$P($G(^DPT(SCTLOG("DFN"),0)),"^",1),1:"UNKNOWN"))
 ....S SCLINE=SCLINE_" "_$$LJ(SCTXT,18)
 ....;
 ....;set patient id in line
 ....S DFN=+SCTLOG("DFN") D PID^VADPT
 ....;D SET(SCARY,SCLINE,VA("BID"),SCCOL("PATID"),SCWID("PATID"),SCNUM,,,,.SCCNT)
 ....S SCLINE=SCLINE_"   "_$$LJ(VA("BID"),5)
 ....;
 ....;set date ack received in line
 ....S SCTXT=$$LOWER^VALM1($S($G(SCTLOG("ACK DT/TM")):$E($$FDATE^VALM1(SCTLOG("ACK DT/TM")),1,8),1:"UNKNOWN"))
 ....S SCLINE=SCLINE_"   "_$$LJ(SCTXT,8)
 ....;
 ....;set provider in display in line
 ....K SCHL
 ....S SCPROV=""
 ....;only get provider if ZPC segment error
 ....I $G(SCTLOG("WORK")) S SCPROV=$P($G(^SCPT(404.471,SCTLIEN,0)),U,8)
 ....I $G(SCTLOG("ERR","SEG"))="ZPC" D
 .....I $$GETHL7ID^SCMCHLA2($G(SCTLOG("ERR","ZPCID")),.SCHL)
 .....S SCPTR=$P($G(SCHL("HL7ID")),"-",2)
 .....I '$G(SCTLOG("WORK")) S SCPROV=$P($G(^SCTM(404.52,+$G(SCPTR),0)),"^",3)
 ....S SCTXT=$$LOWER^VALM1($S($G(SCPROV)'="":$$EXTERNAL^DILFD(404.52,.03,,SCPROV),1:"N/A"))
 ....S SCLINE=SCLINE_"   "_$$LJ(SCTXT,18)
 ....;
 ....;set provider type in line
 ....S SCTYPE=$P($G(SCHL("HL7ID")),"-",4)
 ....S SCTXT=$S(SCTYPE'="":SCTYPE,1:"N/A")
 ....S SCLINE=SCLINE_"   "_$$LJ(SCTXT,4)
 ....;
 ....;set error processing status in line
 ....S SCTXT=$$LOWER^VALM1($S($G(SCTLOG("ERR","EPS")):$$EXTERNAL^DILFD(404.47142,.06,,SCTLOG("ERR","EPS")),1:"UNKNOWN"))
 ....S SCLINE=SCLINE_"   "_$$LJ(SCTXT,7)
 ....;
 ....D LINE(SCLINE) Q:QUIT
 ....;
 ....;set error code/desc in line
 ....I $$GETEC^SCMCHLA2($G(SCTLOG("ERR","CODE")),.SCERR)
 ....S SCTXT="     Error: "_$S($G(SCERR("CODE"))'="":SCERR("CODE")_"-"_$G(SCERR("SHORT")),1:$$LOWER^VALM1("UNKNOWN"))
 ....S SCLINE=$$LJ(SCTXT,80)
 ....D LINE(SCLINE) Q:QUIT
 ;
 Q
 ;
 ;
LJ(STRING,LENGTH) ;
 ;
 Q $$LJ^XLFSTR($E(STRING,1,LENGTH),LENGTH)
