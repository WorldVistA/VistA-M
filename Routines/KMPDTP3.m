KMPDTP3 ;OAK/RAK - CP Timing Hourly Time-to-Load ;6/21/05  10:14
 ;;2.0;CAPACITY MANAGEMENT TOOLS;**4**;Mar 22, 2002
 ;
EN ;-- entry point
 N KMPDATE,KMPDTTL,POP,X,Y,ZTDESC,ZTRTN,ZTRSAVE,%ZIS
 S KMPDTTL=" Hourly Coversheet Time-to-Load (TTL) Report "
 D HDR^KMPDUTL4(KMPDTTL)
 W !
 W !?7,"This report displays the hourly average time-to-load value"
 W !?7,"for the coversheet at this site over 24 hours."
 W !
 ;
 ; if no data
 I '$O(^KMPD(8973.2,0)) D  Q
 .W !!?7,"*** There is currently no data in file #8973.2 (CP TIMING) ***"
 ;
 D DATERNG^KMPDTU10("ORWCV",1,.KMPDATE)
 Q:$G(KMPDATE(0))=""
 ; select output device.
 S %ZIS="Q",%ZIS("A")="Device: ",%ZIS("B")="HOME"
 W ! D ^%ZIS I POP W !,"No action taken." Q
 ; if queued.
 I $D(IO("Q")) K IO("Q") D  Q
 .S ZTDESC=KMPDTTL
 .S ZTRTN="EN1^KMPDTP3"
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
 K ^TMP($J)
 D DATA,PRINT,EXIT
 K ^TMP($J)
 Q
 ;
DATA ;-- compile data
 Q:'$D(KMPDATE)
 N DATA,DATE,DELTA,DOT,END,HR,I,IEN,PTNP,QUEUED,TOTAL
 S DATE=$P(KMPDATE(0),U)-.1,END=$P(KMPDATE(0),U,2)
 Q:'DATE!('END)
 S DOT=1,QUEUED=$D(ZTQUEUED)
 F  S DATE=$O(^KMPD(8973.2,"ASVDTSS","ORWCV",DATE)) Q:'DATE!(DATE>END)  D 
 .S (IEN,TOTAL)=0
 .; array with hours
 .F I=0:1:23 S ^TMP($J,DATE,I)=""
 .F  S IEN=$O(^KMPD(8973.2,"ASVDTSS","ORWCV",DATE,IEN)) Q:'IEN  D 
 ..Q:'$D(^KMPD(8973.2,IEN,0))  S DATA=^(0) Q:DATA=""
 ..S DOT=DOT+1 W:'QUEUED&('(DOT#1000)) "."
 ..; get delta and hour
 ..S DELTA=$P(DATA,U,4),HR=+$E($P($P(DATA,U,3),".",2),1,2)
 ..S HR=$S(HR="":0,HR=24:0,1:HR)
 ..; if delta
 ..I $P(DATA,U,4)'="" D 
 ...; minimum delta
 ...I $P(^TMP($J,DATE,HR),U,2)=""!($P(DATA,U,4)<$P(^TMP($J,DATE,HR),U,2)) D 
 ....S $P(^TMP($J,DATE,HR),U,2)=$P(DATA,U,4)
 ...; maximum delta
 ...I $P(DATA,U,4)>$P(^TMP($J,DATE,HR),U,3) S $P(^TMP($J,DATE,HR),U,3)=$P(DATA,U,4)
 ...; total delta
 ...S $P(^TMP($J,DATE,HR),U,4)=$P(^TMP($J,DATE,HR),U,4)+$P(DATA,U,4)
 ...; count
 ...S $P(^TMP($J,DATE,HR),U,5)=$P(^TMP($J,DATE,HR),U,5)+1
 ..; if no delta
 ..E  S $P(^TMP($J,DATE,HR),U,6)=$P(^TMP($J,DATE,HR),U,6)+1
 .;
 .; back to DATE level
 .; average
 .F I=0:1:23 I $P(^TMP($J,DATE,I),U,5) D 
 ..S $P(^TMP($J,DATE,I),U)=$P(^TMP($J,DATE,I),U,4)/$P(^TMP($J,DATE,I),U,5)
 ;
 Q
 ;
PRINT ;-- print data
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
 S X=$G(KMPDATE(0)),X=$P(X,U,3)_" - "_$P(X,U,4)
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
 K KMPDATE,KMPDTTL
 Q
