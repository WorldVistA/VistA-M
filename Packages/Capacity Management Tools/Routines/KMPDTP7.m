KMPDTP7 ;OAK/RAK/JML - Real-Time CP Timing Hourly Time-to-Load ;9/1/2015
 ;;3.0;Capacity Management Tools;**3**;Jan 15, 2013;Build 42
 ;
EN ;-- entry point
 N KMPDTTL,POP,X,Y,ZTDESC,ZTRTN,ZTRSAVE,ZTSK,%ZIS
 S KMPDTTL=" Real-Time Hourly Coversheet Time-to-Load (TTL) Report "
 D HDR^KMPDUTL4(KMPDTTL)
 W !
 W !?7,"This report displays the hourly average time-to-load value"
 W !?7,"for the coversheet at this site over 24 hours."
 W !
 ;
 ; if no data
 I ($O(^KMPTMP("KMPDT","ORWCV",""))="")&($O(^KMPTMP("KMPDT","ORWCV-FT",""))="") D  Q
 .W !!?7,"*** There is currently no data in global ^KMPTMP(""KMPDT"", ***"
 ;
 ; select output device.
 S %ZIS="Q",%ZIS("A")="Device: ",%ZIS("B")="HOME"
 W ! D ^%ZIS I POP W !,"No action taken." Q
 ; if queued.
 I $D(IO("Q")) K IO("Q") D  Q
 .S ZTDESC=KMPDTTL
 .S ZTRTN="EN1^KMPDTP7"
 .S ZTSAVE("KMPDTTL")=""
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
 K ^TMP($J)
 D DATA,PRINT,EXIT
 K ^TMP($J)
 Q
 ;
DATA ;-- compile data
 ;
 N DATA,DATA1,DATE,DATE1,DELTA,DOT,HOURS,HR,I,QUEUED,TIME
 N KMPDSS,DELTA,TOTDELT,HRDATE,COMPLETE
 ;
 S DOT=1,QUEUED=$D(ZTQUEUED),DATE=$$DT^XLFDT
 ; array with hours
 S HOURS=$$RLTMHR^KMPDTU11(1,0) Q:HOURS=""
 F I=1:1 Q:$P(HOURS,",",I)=""  S ^TMP($J,"RPT",DATE,$P(HOURS,",",I))=""
 ; collect raw data
 F KMPDSS="ORWCV","ORWCV-FT" D
 .S I=""
 .F  S I=$O(^KMPTMP("KMPDT",KMPDSS,I)) Q:I=""  S DATA=^(I) I DATA]"" D
 ..S DOT=DOT+1 W:'QUEUED&('(DOT#1000)) "."
 ..; start/end date/time in fileman format
 ..S DATE(1)=$$HTFM^XLFDT($P(DATA,U)),DATE(2)=$$HTFM^XLFDT($P(DATA,U,2))
 ..Q:'DATE(1)!('DATE(2))
 ..S ^TMP($J,"DATA",I,KMPDSS)=DATA
 ; collate raw data - combined FG and BG 
 S I=""
 F  S I=$O(^TMP($J,"DATA",I)) Q:I=""  D
 .S (KMPDSS,DATA1,HRDATE,TOTDELT)=""
 .S DELTA=0,COMPLETE=1
 .F KMPDSS="ORWCV","ORWCV-FT" D
 ..S DATA=$G(^TMP($J,"DATA",I,KMPDSS))
 ..Q:DATA=""
 ..S DATE(1)=$$HTFM^XLFDT($P(DATA,U)),DATE(2)=$$HTFM^XLFDT($P(DATA,U,2))
 ..I DATE(1)>1 S HRDATE=DATE(1)
 ..I (DATE(1)<0)!(DATE(2)<0) S COMPLETE=0 Q
 ..; get delta
 ..S DELTA=$$HDIFF^XLFDT($P(DATA,U,2),$P(DATA,U),2)
 ..; date without time
 ..S DATE1=$P(DATE(1),".") I 'DATE1 Q
 ..S TOTDELT=$G(TOTDELT)+DELTA
 .; determine hour
 .Q:TOTDELT=""
 .Q:HRDATE=""
 .S HR=+$E($P(HRDATE,".",2),1,2)
 .S HR=$S(HR="":0,HR=24:0,1:HR)
 .; calculate min/max/tot/count
 .; if delta
 .I COMPLETE D 
 ..; minimum delta
 ..I $P(^TMP($J,"RPT",DATE,HR),U,2)=""!(TOTDELT<$P(^TMP($J,"RPT",DATE,HR),U,2)) D 
 ...S $P(^TMP($J,"RPT",DATE,HR),U,2)=TOTDELT
 ..; maximum delta
 ..I TOTDELT>$P(^TMP($J,"RPT",DATE,HR),U,3) S $P(^TMP($J,"RPT",DATE,HR),U,3)=TOTDELT
 ..; total delta
 ..S $P(^TMP($J,"RPT",DATE,HR),U,4)=$P(^TMP($J,"RPT",DATE,HR),U,4)+TOTDELT
 ..; count
 ..S $P(^TMP($J,"RPT",DATE,HR),U,5)=$P(^TMP($J,"RPT",DATE,HR),U,5)+1
 .; if no delta
 .E  S $P(^TMP($J,"RPT",DATE,HR),U,6)=$P(^TMP($J,"RPT",DATE,HR),U,6)+1
 ; calculate average
 F HR=1:1 S I=$P(HOURS,",",HR) Q:I=""  I $P(^TMP($J,"RPT",DATE,I),U,5) D 
 .S $P(^TMP($J,"RPT",DATE,I),U)=$P(^TMP($J,"RPT",DATE,I),U,4)/$P(^TMP($J,"RPT",DATE,I),U,5)
 Q
 ;
PRINT ;-- print data
 U IO
 D HDR
 Q:'$D(^TMP($J))
 N CONT,DATE,HR,I,TOTAL
 S DATE="",CONT=1
 F  S DATE=$O(^TMP($J,"RPT",DATE)) Q:'DATE  S HR="" D  Q:'CONT
 .S TOTAL=""
 .W !,$$FMTE^XLFDT(DATE,2)
 .F  S HR=$O(^TMP($J,"RPT",DATE,HR)) Q:HR=""  D  Q:'CONT
 ..; page feed
 ..I $Y>(IOSL-3) D CONTINUE^KMPDUTL4("",1,.CONT) Q:'CONT  D HDR W !
 ..W ?12," ",$S($L(HR)=1:"0",1:""),HR
 ..S DATA=^TMP($J,"RPT",DATE,HR)
 ..W ?20,$J($FN($P(DATA,U),",",0),10)
 ..W ?34,$J($FN($P(DATA,U,2),",",0),10)
 ..W ?48,$J($FN($P(DATA,U,3),",",0),10)
 ..W ?62,$J($FN($P(DATA,U,5),",",0),10)
 ..W !
 ..S $P(TOTAL,U)=$P(TOTAL,U)+$P(DATA,U,5)
 ..S $P(TOTAL,U,2)=$P(TOTAL,U,2)+$P(DATA,U,6)
 .;
 .; back to DATE level
 .; totals
 .W ?62,"----------",!?62,$J($FN(TOTAL,",",0),10),!
 .W !?12,"Incomplete: ",$J($FN($P(TOTAL,U,2),",",0),$L($P(TOTAL,U,2))+2),!
 .; if another date
 .I $O(^TMP($J,"RPT",DATE)) D CONTINUE^KMPDUTL4("",1,.CONT) Q:'CONT  D HDR W !
 ;
 I CONT D 
 .; legend
 .W !!?2,"CV  = Coversheet",!?2,"TTL = Time-to-Load"
 .; pause if output to terminal
 .D CONTINUE^KMPDUTL4("Press RETURN to continue",1)
 ;
 Q
 ;
HDR ;-- print header
 W @IOF
 S X=$G(KMPDTTL)
 W !?(80-$L(X)\2),X
 S X=$$FMTE^XLFDT($$DT^XLFDT)
 W !?(80-$L(X)\2),X,?61,"Printed: ",$$FMTE^XLFDT(DT,2)
 W !
 W !?20,"|---------------Seconds---------------|"
 W !,"Date",?12,"Hour",?20,"TTL Average",?34,"TTL Minimum",?48,"TTL Maximum",?62,"# of CV Loads"
 W !,$$REPEAT^XLFSTR("-",IOM)
 ;
 Q
 ;
EXIT ;-- cleanup on exit
 S:$D(ZTQUEUED) ZTREQ="@"
 D ^%ZISC
 K KMPDTTL
 Q
