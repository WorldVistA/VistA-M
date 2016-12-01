KMPDTP4 ;OAK/RAK/JML - CP Timing Hourly Time-to-Load ;9/1/2015
 ;;3.0;Capacity Management Tools;**3**;Jan 15, 2013;Build 42
 ;
EN ;-- entry point
 ;
 N KMPDATE,KMPDTTL,POP,X,Y,ZTDESC,ZTRTN,ZTRSAVE,ZTSK,%ZIS
 N KMPDLBG,KMPDLFG,KMPDDTSS
 ;
 S KMPDTTL=" Hourly Coversheet Time-to-Load (TTL) Detail Report "
 D HDR^KMPDUTL4(KMPDTTL)
 W !
 W !?7,"This detail report displays the hourly time-to-load values"
 W !?7,"for the coversheet at this site.  The report breaks the"
 W !?7,"time-to-load metrics into ten second groupings."
 W !
 ;
 ; if no data
 I '$O(^KMPD(8973.2,0)) D  Q
 .W !!?7,"*** There is currently no data in file #8973.2 (CP TIMING) ***"
 ;
 ; select date range - first determine which subscript to use in API due to addition of foreground processing
 S KMPDLFG=$O(^KMPD(8973.2,"ASSDTTM","ORWCV-FT","A"),-1)
 S KMPDLBG=$O(^KMPD(8973.2,"ASSDTTM","ORWCV","A"),-1)
 S KMPDDTSS=$S(KMPDLFG=KMPDLBG:"ORWCV-FT",KMPDLFG>KMPDLBG:"ORWCV-FT",KMPDLFG<KMPDLBG:"ORWCV",1:"UNKNOWN")
 D DTTMRNG^KMPDTU10(KMPDDTSS,1,.KMPDATE,8)
 Q:$G(KMPDATE(0))=""
 Q:$G(KMPDATE(1))=""
 ;
 ; select output device.
 S %ZIS="Q",%ZIS("A")="Device: ",%ZIS("B")="HOME"
 W ! D ^%ZIS I POP W !,"No action taken." Q
 ; if queued.
 I $D(IO("Q")) K IO("Q") D  Q
 .S ZTDESC=KMPDTTL
 .S ZTRTN="EN1^KMPDTP4"
 .S ZTSAVE("KMPDATE(")="",ZTSAVE("KMPDTTL")=""
 .D ^%ZTLOAD W:$G(ZTSK) !,"Task #",ZTSK
 .D EXIT
 ;
 ; if output to terminal display message.
 W:$E(IOST,1,2)="C-" !,"Compiling timing stats..."
 D EN1
 ;
 Q
 ;
EN1 ;-- entry point from taskman
 Q:'$D(KMPDATE)
 N KMPDTOT,KMPDFG,KMPDBG
 K ^TMP($J)
 D DATA,PRINT,EXIT
 K ^TMP($J)
 Q
 ;
DATA ;-- compile data
 ;
 Q:'$D(KMPDATE)
 ;
 N DATA,DATE,DATE1,DELTA,DOT,END,HOUR,HR,I,IEN,PTNP,QUEUED,TOTAL
 N KMPDSUB,KMPDBIDX
 ;
 S DOT=1,QUEUED=$D(ZTQUEUED)
 ; set up HOUR() array
 F I=1:1:24 S:$P(KMPDATE(1),",",I)'="" HOUR(+$P(KMPDATE(1),",",I))=""
 Q:'$D(HOUR)
 S DATE=$P(KMPDATE(0),U)-.1,END=$P(KMPDATE(0),U,2)+.9
 Q:'DATE!('END)
 ; Loop data - combine Foreground and Background timings
 F KMPDSUB="ORWCV","ORWCV-FT" D
 .S KMPDTOT(KMPDSUB)=0
 .S DATE=$P(KMPDATE(0),U)-.1,END=$P(KMPDATE(0),U,2)+.9
 .F  S DATE=$O(^KMPD(8973.2,"ASSDTTM",KMPDSUB,DATE)) Q:'DATE!(DATE>END)  D
 ..S HR=+$E($P(DATE,".",2),1,2) S:HR="" HR="0"
 ..Q:'$D(HOUR(HR))
 ..S (IEN,TOTAL)=0,TOTAL(KMPDSUB)=0
 ..F  S IEN=$O(^KMPD(8973.2,"ASSDTTM",KMPDSUB,DATE,IEN)) Q:'IEN  D
 ...S DATA=$G(^KMPD(8973.2,IEN,0))
 ...Q:DATA=""
 ...S KMPDBIDX=$P(DATA,U)
 ...S ^TMP($J,"DATA",DATE,KMPDBIDX,KMPDSUB)=$P(DATA,U,4)
 ...S KMPDTOT(KMPDSUB)=KMPDTOT(KMPDSUB)+1
 ;
 ; Calculate percentages
 S DATE=""
 F  S DATE=$O(^TMP($J,"DATA",DATE)) Q:DATE=""  D
 .; date without time
 .S DATE1=$P(DATE,".")
 .; set up HOUR() array
 .M:'$D(^TMP($J,"RPT",DATE1)) ^TMP($J,"RPT",DATE1)=HOUR
 .; set up TOTAL() array
 .M:'$D(TOTAL(DATE1)) TOTAL(DATE1)=HOUR
 .S KMPDBIDX=""
 .F  S KMPDBIDX=$O(^TMP($J,"DATA",DATE,KMPDBIDX)) Q:KMPDBIDX=""  D
 ..S (DELTA,KMPDSUB)=""
 ..F  S KMPDSUB=$O(^TMP($J,"DATA",DATE,KMPDBIDX,KMPDSUB)) Q:KMPDSUB=""  D
 ...S DELTA=DELTA+$G(^TMP($J,"DATA",DATE,KMPDBIDX,KMPDSUB))
 ..S DOT=DOT+1 W:'QUEUED&('(DOT#1000)) "."
 ..S HR=+$E($P(DATE,".",2),1,2) S:HR="" HR="0"
 ..; if delta is null increment by 1 and quit
 ..I DELTA="" S $P(^TMP($J,"RPT",DATE1,HR),U,50)=$P(^TMP($J,"RPT",DATE1,HR),U,50)+1 Q
 ..; loop - less than I*10 seconds
 ..F I=1:1:9 I DELTA<(I*10) S $P(^TMP($J,"RPT",DATE1,HR),U,I)=$P(^TMP($J,"RPT",DATE1,HR),U,I)+1 Q
 ..; 90 or greater seconds
 ..I DELTA>89 S $P(^TMP($J,"RPT",DATE1,HR),U,10)=$P(^TMP($J,"RPT",DATE1,HR),U,10)+1
 ..; total
 ..S TOTAL(DATE1,HR)=TOTAL(DATE1,HR)+1
 ; determine percentage
 S DATE1=0
 F  S DATE1=$O(TOTAL(DATE1)) Q:'DATE1  S HR="" D 
 .F  S HR=$O(TOTAL(DATE1,HR)) Q:HR=""  I TOTAL(DATE1,HR) F I=1:1:10 D 
 ..S $P(^TMP($J,"RPT",DATE1,HR,1),U,I)=$FN($P(^TMP($J,"RPT",DATE1,HR),U,I)/TOTAL(DATE1,HR)*100,"",1)
 Q
 ;
PRINT ;-- print data
 ;
 U IO
 D HDR
 Q:'$D(^TMP($J))
 N CONT,DATE,I,TOTAL,KMPDFGBG,KMPDMESS
 S (KMPDFG,KMPDBG)=0
 S DATE="",CONT=1
 F  S DATE=$O(^TMP($J,"RPT",DATE)) Q:'DATE  D  Q:'CONT
 .W !,$$FMTE^XLFDT(DATE,2) S HR=""
 .F  S HR=$O(^TMP($J,"RPT",DATE,HR)) Q:HR=""  D  Q:'CONT
 ..I $Y>(IOSL-9) D  Q:'CONT
 ...D CONTINUE^KMPDUTL4("",1,.CONT) Q:'CONT
 ...D HDR W !,$$FMTE^XLFDT(DATE,2)
 ..W ?12,HR
 ..S TOTAL="",DATA=^TMP($J,"RPT",DATE,HR),DATA(1)=$G(^TMP($J,"RPT",DATE,HR,1))
 ..; if no data
 ..I DATA="" W ?12,"  <No Data>",! Q
 ..; display data
 ..F I=1:1:9 D 
 ...W ?16,I-1*10," to <",I*10
 ...W ?32,$J($FN($P(DATA,U,I),",",0),10)
 ...; percentages
 ...W ?48,$J($FN($P(DATA(1),U,I),"",1),10),"%"
 ...W !
 ...; totals
 ...S $P(TOTAL,U)=$P(TOTAL,U)+$P(DATA,U,I)
 ...S $P(TOTAL,U,2)=$P(TOTAL,U,2)+$P(DATA(1),U,I)
 ..; greater than 90
 ..W ?16,"90 or greater",?32,$J($FN($P(DATA,U,10),",",0),10)
 ..W ?48,$J($FN($P(DATA(1),U,10),"",1),10),"%"
 ..S $P(TOTAL,U)=$P(TOTAL,U)+$P(DATA,U,10)
 ..S $P(TOTAL,U,2)=$P(TOTAL,U,2)+$P(DATA(1),U,10)
 ..; totals
 ..W !?32,"----------",?48,"----------"
 ..W !?32,$J($FN($P(TOTAL,U),",",0),10)
 ..W ?48,$J($FN($P(TOTAL,U,2),"",0),10),"%"
 ..W !?16,"Incomplete",?32,$J($FN($P(DATA,U,50),",",0),10),!
 ..; page feed if another date
 ..I $O(^TMP($J,DATE)) D 
 ...D CONTINUE^KMPDUTL4("",1,.CONT) Q:'CONT
 ...D HDR
 ..W !
 ;
 I CONT D 
 .; legend
 .S KMPDFGBG=0
 .I $G(KMPDTOT("ORWCV"))>0 S KMPDFGBG=KMPDFGBG+1
 .I $G(KMPDTOT("ORWCV-FT"))>0 S KMPDFGBG=KMPDFGBG+2
 .W !!?2,"CV  = Coversheet",?30,"Coversheet sections run in:"
 .W !?2,"TTL = Time-to-Load"
 .W ?30,$S(KMPDFGBG=1:"Background Only",KMPDFGBG=2:"Foreground Only",KMPDFGBG=3:"Both Foreground and Background",1:"Unknown")
 .; pause if output to terminal
 .D CONTINUE^KMPDUTL4("Press RETURN to continue",1)
 ;
 Q
 ;
HDR ;-- print header
 W @IOF
 S X=$G(KMPDTTL)
 W !?(80-$L(X)\2),X
 S X=$G(KMPDATE(0)),X=$P(X,U,3)_" - "_$P(X,U,4)
 W !?(80-$L(X)\2),X,?61,"Printed: ",$$FMTE^XLFDT(DT,2)
 W !
 W !,"Date",?12,"Hr",?16,"TTL Seconds",?32,"# CV Loads",?48,"CV Percent"
 W !,$$REPEAT^XLFSTR("-",IOM)
 ;
 Q
 ;
EXIT ;-- cleanup on exit
 S:$D(ZTQUEUED) ZTREQ="@"
 D ^%ZISC
 K KMPDATE,KMPDTTL
 Q
