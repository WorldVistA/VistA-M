KMPDTP7 ;OAK/RAK - Real-Time CP Timing Hourly Time-to-Load ;6/21/05  10:15
 ;;2.0;CAPACITY MANAGEMENT TOOLS;**4**;Mar 22, 2002
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
 I $O(^KMPTMP("KMPDT","ORWCV",""))="" D  Q
 .W !!?7,"*** There is currently no data in global ^KMPTMP(""KMPDT"",""ORWCV"") ***"
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
 ;
 S DOT=1,QUEUED=$D(ZTQUEUED),DATE=$$DT^XLFDT
 ; array with hours
 S HOURS=$$RLTMHR^KMPDTU11(1,0) Q:HOURS=""
 F I=1:1 Q:$P(HOURS,",",I)=""  S ^TMP($J,DATE,$P(HOURS,",",I))=""
 S I="",TOTAL=0
 F  S I=$O(^KMPTMP("KMPDT","ORWCV",I)) Q:I=""  S DATA=^(I) I DATA]"" D 
 .S DOT=DOT+1 W:'QUEUED&('(DOT#1000)) "."
 .; start/end date/time in fileman format
 .S DATE(1)=$$HTFM^XLFDT($P(DATA,U)),DATE(2)=$$HTFM^XLFDT($P(DATA,U,2))
 .Q:'DATE(1)!('DATE(2))
 .S DELTA=$$FMDIFF^XLFDT(DATE(2),DATE(1),2)
 .S:DELTA<0 DELTA=""
 .; determine hour
 .S HR=+$E($P(DATE(1),".",2),1,2)
 .S HR=$S(HR="":0,HR=24:0,1:HR)
 .; quit if not in HOUR() array
 .;Q:'$D(HOUR(HR))
 .; hour & second
 .S TIME=$E($P(DATE(1),".",2),1,4) Q:'TIME
 .; insert colon (:) between hour & second
 .S TIME=$E(TIME,1,2)_":"_$E(TIME,3,4)
 .S:$P(TIME,":",2)="" $P(TIME,":",2)="00"
 .; date without time
 .S DATE1=$P(DATE(1),".") Q:'DATE1
 .S DATA1="^^^"_DELTA_"^"_$P(DATA,U,3)_"^"_$P(DATA,U,4)_"^^^"_$P($P(I," ",2),"-")
 .;
 .; if delta
 .I $P(DATA1,U,4)'="" D 
 ..; minimum delta
 ..I $P(^TMP($J,DATE,HR),U,2)=""!($P(DATA1,U,4)<$P(^TMP($J,DATE,HR),U,2)) D 
 ...S $P(^TMP($J,DATE,HR),U,2)=$P(DATA1,U,4)
 ..; maximum delta
 ..I $P(DATA1,U,4)>$P(^TMP($J,DATE,HR),U,3) S $P(^TMP($J,DATE,HR),U,3)=$P(DATA1,U,4)
 ..; total delta
 ..S $P(^TMP($J,DATE,HR),U,4)=$P(^TMP($J,DATE,HR),U,4)+$P(DATA1,U,4)
 ..; count
 ..S $P(^TMP($J,DATE,HR),U,5)=$P(^TMP($J,DATE,HR),U,5)+1
 .; if no delta
 .E  S $P(^TMP($J,DATE,HR),U,6)=$P(^TMP($J,DATE,HR),U,6)+1
 ;
 ; average
 F HR=1:1 S I=$P(HOURS,",",HR) Q:I=""  I $P(^TMP($J,DATE,I),U,5) D 
 .S $P(^TMP($J,DATE,I),U)=$P(^TMP($J,DATE,I),U,4)/$P(^TMP($J,DATE,I),U,5)
 ;
 Q
 ;
PRINT ;-- print data
 U IO
 D HDR
 Q:'$D(^TMP($J))
 N CONT,DATE,HR,I,TOTAL
 S DATE="",CONT=1
 F  S DATE=$O(^TMP($J,DATE)) Q:'DATE  S HR="" D  Q:'CONT
 .S TOTAL=""
 .W !,$$FMTE^XLFDT(DATE,2)
 .F  S HR=$O(^TMP($J,DATE,HR)) Q:HR=""  D  Q:'CONT
 ..; page feed
 ..I $Y>(IOSL-3) D CONTINUE^KMPDUTL4("",1,.CONT) Q:'CONT  D HDR W !
 ..W ?12," ",$S($L(HR)=1:"0",1:""),HR
 ..S DATA=^TMP($J,DATE,HR)
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
 .I $O(^TMP($J,DATE)) D CONTINUE^KMPDUTL4("",1,.CONT) Q:'CONT  D HDR W !
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
