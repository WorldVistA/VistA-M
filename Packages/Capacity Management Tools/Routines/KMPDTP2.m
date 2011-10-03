KMPDTP2 ;OAK/RAK - CP Timing Daily Time-to-Load Detail ;2/17/04  09:23
 ;;2.0;CAPACITY MANAGEMENT TOOLS;**4**;Mar 22, 2002
 ;
EN ;-- entry point
 N KMPDATE,KMPDPTNP,KMPDTTL,POP,X,Y,ZTDESC,ZTRTN,ZTSAVE,ZTSK,%ZIS
 S KMPDTTL=" Daily Coversheet Time-to-Load (TTL) Detailed Report "
 D HDR^KMPDUTL4(KMPDTTL)
 W !
 W !?7,"This detailed report displays daily time-to-load values for the"
 W !?7,"coversheet at this site.  The report breaks the time-to-load"
 W !?7,"metrics into ten second groupings."
 W !
 ;
 ; if no data
 I '$O(^KMPD(8973.2,0)) D  Q
 .W !!?7,"*** There is currently no data in file #8973.2 (CP TIMING) ***"
 ;
 ; select date range
 D DATERNG^KMPDTU10("ORWCV",1,.KMPDATE)
 Q:$G(KMPDATE(0))=""
 ;
 ; select time frame
 S KMPDPTNP=$$PTNPSEL^KMPDUTL4
 Q:'KMPDPTNP
 ;
 ; select output device.
 S %ZIS="Q",%ZIS("A")="Device: ",%ZIS("B")="HOME"
 W ! D ^%ZIS I POP W !,"No action taken." Q
 ; if queued.
 I $D(IO("Q")) K IO("Q") D  Q
 .S ZTDESC=KMPDTTL
 .S ZTRTN="EN1^KMPDTP2"
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
 ;
 K ^TMP($J)
 D DATA,PRINT,EXIT
 K ^TMP($J)
 ;
 Q
 ;
DATA ;-- compile data
 Q:'$D(KMPDATE)
 Q:'$G(KMPDPTNP)
 ;
 N DATA,DATE,DELTA,DOT,END,I,IEN,PTNP,QUEUED,TOTAL
 ;
 S QUEUED=$D(ZTQUEUED),DOT=1
 S DATE=$P(KMPDATE(0),U)-.1,END=$P(KMPDATE(0),U,2),PTNP=(+KMPDPTNP)
 Q:'DATE!('END)!('PTNP)
 ;
 F  S DATE=$O(^KMPD(8973.2,"ASSDTPT","ORWCV",DATE)) Q:'DATE!(DATE>END)  D
 .S (IEN,TOTAL)=0,^TMP($J,DATE)=""
 .F  S IEN=$O(^KMPD(8973.2,"ASSDTPT","ORWCV",DATE,PTNP,IEN)) Q:'IEN  D
 ..Q:'$D(^KMPD(8973.2,IEN,0))  S DATA=^(0) Q:DATA=""
 ..S DOT=DOT+1 W:'QUEUED&('(DOT#1000)) "."
 ..S DELTA=$P(DATA,U,4)
 ..;
 ..; if delta is null increment by 1 and quit
 ..I DELTA="" S $P(^TMP($J,DATE),U,50)=$P(^TMP($J,DATE),U,50)+1 Q
 ..; total
 ..S TOTAL=TOTAL+1
 ..;
 ..; loop - less than I*10 seconds
 ..F I=1:1:9 I DELTA<(I*10) S $P(^TMP($J,DATE),U,I)=$P(^TMP($J,DATE),U,I)+1 Q
 ..; 90 or greater seconds
 ..I DELTA>89 S $P(^TMP($J,DATE),U,10)=$P(^TMP($J,DATE),U,10)+1
 .;
 .; back to DATE level
 .; determine percentage
 .I TOTAL F I=1:1:10 D 
 ..S $P(^TMP($J,DATE,1),U,I)=$FN($P(^TMP($J,DATE),U,I)/TOTAL*100,"",1)
 ;
 Q
 ;
PRINT ;-- print data
 U IO
 D HDR
 Q:'$D(^TMP($J))
 ;
 N CONT,DATE,I,TOTAL
 ;
 S DATE="",CONT=1
 F  S DATE=$O(^TMP($J,DATE)) Q:'DATE  D  Q:'CONT
 .S TOTAL=""
 .S DATA=^TMP($J,DATE),DATA(1)=$G(^TMP($J,DATE,1))
 .W !,$$FMTE^XLFDT(DATE,2)
 .; if no data
 .I DATA="" W ?12,"<No Data for ",$P(KMPDPTNP,U,2),">",! Q
 .; display data
 .F I=1:1:10 D
 ..W ?12
 ..I I<10 W $J(I-1*10,2)," to <",I*10
 ..E  W "90 or greater"
 ..W ?28,$J($FN($P(DATA,U,I),",",0),10)
 ..; percentages
 ..W ?44,$J($FN($P(DATA(1),U,I),"",1),10),"%",!
 ..; totals
 ..S $P(TOTAL,U)=$P(TOTAL,U)+$P(DATA,U,I)
 ..S $P(TOTAL,U,2)=$P(TOTAL,U,2)+$P(DATA(1),U,I)
 .;
 .; back to DATE level
 .; totals
 .W ?28,"----------",?44,"----------"
 .W !?28,$J($FN($P(TOTAL,U),",",0),10)
 .W ?44,$J($FN($P(TOTAL,U,2),"",0),10),"%"
 .W !!?12,"Incomplete",?28,$J($FN($P(DATA,U,50),",",0),10)
 .; page feed if another date
 .I $O(^TMP($J,DATE)) D 
 ..D CONTINUE^KMPDUTL4("",1,.CONT) Q:'CONT
 ..D HDR
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
 S X=$P($G(KMPDPTNP),U,2)
 W !?(80-$L(X)\2),X
 S X=$G(KMPDATE(0)),X=$P(X,U,3)_" - "_$P(X,U,4)
 W !?(80-$L(X)\2),X,?61,"Printed: ",$$FMTE^XLFDT(DT,2)
 W !
 W !,"Date",?12,"TTL Seconds",?28,"# of CV Loads",?44,"CV Percent"
 W !,$$REPEAT^XLFSTR("-",IOM)
 ;
 Q
 ;
EXIT ;-- cleanup on exit
 S:$D(ZTQUEUED) ZTREQ="@"
 D ^%ZISC
 K KMPDATE,KMPDPTNP,KMPDTTL
 Q
