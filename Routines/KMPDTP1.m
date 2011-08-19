KMPDTP1 ;OAK/RAK - CP Timing Time to Load Summary ;2/17/04  09:22
 ;;2.0;CAPACITY MANAGEMENT TOOLS;**4**;Mar 22, 2002
 ;
EN ;-- entry point
 N KMPDATE,KMPDPTNP,KMPDTTL,POP,X,Y,ZTDESC,ZTRTN,ZTRSAVE,%ZIS
 S KMPDTTL=" Average Coversheet Time-to-Load (TTL) Report "
 D HDR^KMPDUTL4(KMPDTTL)
 W !
 W !?7,"This report displays the daily average time-to-load value for"
 W !?7,"the coversheet at this site.  Average time-to-load values are"
 W !?7,"given for either daily prime time or non-prime time periods."
 W !
 ;
 I '$O(^KMPD(8973.2,0)) D  Q
 .W !!?7,"*** There is currently no data in file #8973.2 (CP TIMING) ***"
 ;
 D DATERNG^KMPDTU10("ORWCV",7,.KMPDATE)
 Q:$G(KMPDATE(0))=""
 S KMPDPTNP=$$PTNPSEL^KMPDUTL4
 Q:'KMPDPTNP
 ; select output device.
 S %ZIS="Q",%ZIS("A")="Device: ",%ZIS("B")="HOME"
 W ! D ^%ZIS I POP W !,"No action taken." Q
 ; if queued.
 I $D(IO("Q")) K IO("Q") D  Q
 .S ZTDESC=KMPDTTL
 .S ZTRTN="EN1^KMPDTP1"
 .S ZTSAVE("KMPDATE(")="",ZTSAVE("KMPDPTNP")="",ZTSAVE("KMPDTTL")=""
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
 Q:'$G(KMPDPTNP)
 K ^TMP($J)
 D DATA,PRINT,EXIT
 K ^TMP($J)
 Q
 ;
DATA ;-- compile data
 Q:'$D(KMPDATE)
 Q:'$G(KMPDPTNP)
 N DATA,DATE,DOT,END,IEN,PTNP,QUEUED
 S DATE=$P(KMPDATE(0),U)-.1,END=$P(KMPDATE(0),U,2),PTNP=(+KMPDPTNP)
 Q:'DATE!('END)!('PTNP)
 S DOT=1,QUEUED=$D(ZTQUEUED)
 F  S DATE=$O(^KMPD(8973.2,"ASSDTPT","ORWCV",DATE)) Q:'DATE!(DATE>END)  D 
 .S IEN=0,^TMP($J,DATE)=""
 .F  S IEN=$O(^KMPD(8973.2,"ASSDTPT","ORWCV",DATE,PTNP,IEN)) Q:'IEN  D 
 ..Q:'$D(^KMPD(8973.2,IEN,0))  S DATA=^(0) Q:DATA=""
 ..I 'QUEUED S DOT=DOT+1 W:'(DOT#1000) "."
 ..; if delta
 ..I $P(DATA,U,4)'="" D 
 ...; minimum delta
 ...I $P(^TMP($J,DATE),U,2)=""!($P(DATA,U,4)<$P(^TMP($J,DATE),U,2)) D 
 ....S $P(^TMP($J,DATE),U,2)=$P(DATA,U,4)
 ...; maximum delta
 ...I $P(DATA,U,4)>$P(^TMP($J,DATE),U,3) S $P(^TMP($J,DATE),U,3)=$P(DATA,U,4)
 ...; total delta
 ...S $P(^TMP($J,DATE),U,4)=$P(^TMP($J,DATE),U,4)+$P(DATA,U,4)
 ...; count
 ...S $P(^TMP($J,DATE),U,5)=$P(^TMP($J,DATE),U,5)+1
 ..; if no delta
 ..E  S $P(^TMP($J,DATE),U,6)=$P(^TMP($J,DATE),U,6)+1
 .;
 .; back to DATE level
 .; average
 .S:$P(^TMP($J,DATE),U,5) $P(^TMP($J,DATE),U)=$P(^TMP($J,DATE),U,4)/$P(^TMP($J,DATE),U,5)
 ;
 Q
 ;
PRINT ;-- print data
 U IO
 D HDR
 Q:'$D(^TMP($J))
 N DATE,TOTAL S (DATE,TOTAL)=""
 F  S DATE=$O(^TMP($J,DATE)) Q:'DATE  S DATA=^TMP($J,DATE) D 
 .W !,$$FMTE^XLFDT(DATE,2)
 .W ?12,$J($FN($P(DATA,U),",",0),10)
 .W ?26,$J($FN($P(DATA,U,2),",",0),10)
 .W ?40,$J($FN($P(DATA,U,3),",",0),10)
 .W ?54,$J($FN($P(DATA,U,5),",",0),10)
 .; total incompletes
 .S TOTAL=TOTAL+$P(DATA,U,6)
 ;
 W !!?12,"Incomplete: ",$J($FN(TOTAL,",",0),$L(TOTAL)+2)
 ; legend
 W !!?2,"CV  = Coversheet",!?2,"TTL = Time-to-Load"
 ; pause if output to terminal
 D CONTINUE^KMPDUTL4("Press RETURN to continue",4)
 Q
 ;
HDR ;-- print header
 W @IOF
 S X=$G(KMPDTTL)
 W !?(80-$L(X)\2),X
 S X=$P($G(KMPDPTNP),U,2)
 W !?(80-$L(X)\2),X
 S X=$G(KMPDATE(0)),X=$P(X,U,3)_" - "_$P(X,U,4)
 W !?(80-$L(X)\2),X,?61,"Printed: ",$$FMTE^XLFDT(DT,2)
 W !
 W !?12,"|---------------Seconds---------------|"
 W !,"Date",?12,"Average TTL",?26,"Minimum TTL",?40,"Maximum TTL",?54,"# of CV Loads"
 W !,$$REPEAT^XLFSTR("-",IOM)
 ;
 Q
 ;
EXIT ;-- cleanup on exit
 S:$D(ZTQUEUED) ZTREQ="@"
 D ^%ZISC
 K KMPDATE,KMPDPTNP,KMPDTTL
 Q
