KMPDTP1 ;OAK/RAK/JML - CP Timing Time to Load Summary ;9/1/2015
 ;;3.0;Capacity Management Tools;**3**;Jan 15, 2013;Build 42
 ;
EN ;-- entry point
 N KMPDATE,KMPDFGBG,KMPDPTNP,KMPDSTAR,KMPDSTTL,KMPDSUB,KMPDTTL,POP,X,Y,ZTDESC,ZTRTN,ZTRSAVE,%ZIS
 N KMPDLFG,KMPDLBG,KMPDDTSS
 S KMPDTTL=" Average Coversheet Time-to-Load (TTL) Report "
 D HDR^KMPDUTL4(KMPDTTL)
 W !
 W !?7,"This report displays the daily average time-to-load value for"
 W !?7,"the coversheet at this site.  Average time-to-load values are"
 W !?7,"given for either daily prime time or non-prime time periods."
 W !?7,"Foreground, background and combined values are reported."
 W !
 ;
 I '$O(^KMPD(8973.2,0)) D  Q
 .W !!?7,"*** There is currently no data in file #8973.2 (CP TIMING) ***"
 ;
 ; select date range - first determine which subscript to use in API due to addition of foreground processing
 S KMPDLFG=$O(^KMPD(8973.2,"ASSDTTM","ORWCV-FT","A"),-1)
 S KMPDLBG=$O(^KMPD(8973.2,"ASSDTTM","ORWCV","A"),-1)
 S KMPDDTSS=$S(KMPDLFG=KMPDLBG:"ORWCV-FT",KMPDLFG>KMPDLBG:"ORWCV-FT",KMPDLFG<KMPDLBG:"ORWCV",1:"UNKNOWN")
 D DATERNG^KMPDTU10(KMPDDTSS,7,.KMPDATE)
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
 F KMPDSUB="ORWCV","ORWCV-FT" D DATA(.KMPDATE,KMPDPTNP,KMPDSUB)
 D PRINT,EXIT
 K ^TMP($J)
 Q
 ;
DATA(KMPDATE,KMPDPTNP,KMPDSUB) ;-- compile data
 Q:'$D(KMPDATE)
 Q:'$G(KMPDPTNP)
 N DATA,DATE,DOT,END,IEN,PTNP,QUEUED
 S PTNP=(+KMPDPTNP)
 S DOT=1,QUEUED=$D(ZTQUEUED)
 S DATE=$P(KMPDATE(0),U)-.1,END=$P(KMPDATE(0),U,2)
 Q:'DATE!('END)!('PTNP)
 F  S DATE=$O(^KMPD(8973.2,"ASSDTPT",KMPDSUB,DATE)) Q:'DATE!(DATE>END)  D 
 .S IEN=0,^TMP($J,KMPDSUB,DATE)=""
 .F  S IEN=$O(^KMPD(8973.2,"ASSDTPT",KMPDSUB,DATE,PTNP,IEN)) Q:'IEN  D 
 ..Q:'$D(^KMPD(8973.2,IEN,0))  S DATA=^(0) Q:DATA=""
 ..I 'QUEUED S DOT=DOT+1 W:'(DOT#1000) "."
 ..; if delta
 ..I $P(DATA,U,4)'="" D 
 ...; minimum delta
 ...I $P(^TMP($J,KMPDSUB,DATE),U,2)=""!($P(DATA,U,4)<$P(^TMP($J,KMPDSUB,DATE),U,2)) D 
 ....S $P(^TMP($J,KMPDSUB,DATE),U,2)=$P(DATA,U,4)
 ...; maximum delta
 ...I $P(DATA,U,4)>$P(^TMP($J,KMPDSUB,DATE),U,3) S $P(^TMP($J,KMPDSUB,DATE),U,3)=$P(DATA,U,4)
 ...; total delta
 ...S $P(^TMP($J,KMPDSUB,DATE),U,4)=$P(^TMP($J,KMPDSUB,DATE),U,4)+$P(DATA,U,4)
 ...; count
 ...S $P(^TMP($J,KMPDSUB,DATE),U,5)=$P(^TMP($J,KMPDSUB,DATE),U,5)+1
 ..; if no delta
 ..E  S $P(^TMP($J,KMPDSUB,DATE),U,6)=$P(^TMP($J,KMPDSUB,DATE),U,6)+1
 ..;
 .; back to DATE level
 .; average
 .S:$P(^TMP($J,KMPDSUB,DATE),U,5) $P(^TMP($J,KMPDSUB,DATE),U)=$P(^TMP($J,KMPDSUB,DATE),U,4)/$P(^TMP($J,KMPDSUB,DATE),U,5)
 ;
 ;
 Q
 ;
PRINT ;-- print data
 U IO
 S KMPDFGBG=0
 I $D(^TMP($J,"ORWCV")) S KMPDFGBG=1
 I $D(^TMP($J,"ORWCV-FT")) S KMPDFGBG=KMPDFGBG+2
 I KMPDFGBG=1 D PRINTONE("ORWCV","Background")
 I KMPDFGBG=2 D PRINTONE("ORWCV-FT","Foreground")
 I KMPDFGBG=3 D PRNTBOTH
 Q
 ;
PRINTONE(KMPDSUB,KMPDSTTL) ;
 D HDR(KMPDSTTL)
 Q:'$D(^TMP($J,KMPDSUB))
 N DATE,TOTAL S (DATE,TOTAL)=""
 S (DATE,TOTAL,KMPDSTAR)=""
 F  S DATE=$O(^TMP($J,KMPDSUB,DATE)) Q:'DATE  S DATA=^TMP($J,KMPDSUB,DATE) D 
 .W !,$$FMTE^XLFDT(DATE,2)
 .W ?12,$J($FN($P(DATA,U),",",0),10)
 .W ?26,$J($FN($P(DATA,U,2),",",0),10)
 .W ?40,$J($FN($P(DATA,U,3),",",0),10)
 .W ?54,$J($FN($P(DATA,U,5),",",0),10)
 .I $P(DATA,U,5)["*" W "*" S KMPDSTAR=1
 .; total incompletes
 .S TOTAL=TOTAL+$P(DATA,U,6)
 ;
 W !!?12,"Incomplete: ",$J($FN(TOTAL,",",0),$L(TOTAL)+2)
 ; legend
 W !!?2,"CV  = Coversheet" I KMPDSTAR=1 W ?35,"* = BG/FG Load Counts not equal."
 W !?2,"TTL = Time-to-Load" I KMPDSTAR=1 W ?35,"Listing FOREGROUND Load Count"
 ; pause if output to terminal
 D CONTINUE^KMPDUTL4("Press RETURN to continue",4)
 Q
 ;
PRNTBOTH ;
 ; AVG ^ MIN ^ MAX ^ TOTAL DELTA ^ COUNT
 N DATE,TOTDATA,BGDATA,FGDATA,BGMIN,BGMAX,FGMIN,FGMAX,BGTOT,FGTOT
 S DATE=""
 F  S DATE=$O(^TMP($J,"ORWCV-FT",DATE)) Q:'DATE  D
 .S TOTDATA=""
 .S FGDATA=$G(^TMP($J,"ORWCV-FT",DATE))
 .S BGDATA=$G(^TMP($J,"ORWCV",DATE))
 .S $P(TOTDATA,U,1)=$P(BGDATA,U)+$P(FGDATA,U)
 .S BGMIN=$P(BGDATA,U,2),FGMIN=$P(FGDATA,U,2)
 .S $P(TOTDATA,U,2)=$S(FGMIN<BGMIN:FGMIN,1:BGMIN)
 .S BGMAX=$P(BGDATA,U,3),FGMAX=$P(FGDATA,U,3)
 .S $P(TOTDATA,U,3)=$S(BGMAX>FGMAX:BGMAX,1:FGMAX)
 .S $P(TOTDATA,U,4)=$P(BGDATA,U,4)+$P(FGDATA,U,4)
 .S BGTOT=$P(BGDATA,U,5),FGTOT=$P(FGDATA,U,5)
 .S $P(TOTDATA,U,5)=$S(FGTOT=BGTOT:FGTOT,1:FGTOT_"*")
 .S $P(TOTDATA,U,6)=$P(BGDATA,U,6)+$P(FGDATA,U,6)
 .S ^TMP($J,"ORWCV-BOTH",DATE)=TOTDATA
 D PRINTONE("ORWCV","BACKGROUND")
 D PRINTONE("ORWCV-FT","FOREGROUND")
 D PRINTONE("ORWCV-BOTH","Combined FOREGROUND and BACKGROUND")
 ;
HDR(KMPDSTTL) ;-- print header
 W @IOF
 N HDR,I
 D HDR1(.HDR,KMPDSTTL)
 F I=0:0 S I=$O(HDR(I)) Q:'I  W !,HDR(I)
 Q
 ;
HDR1(KMPDHDR,KMPDSTTL) ;- set up header array
 K KMPDHDR
 N X
 S X=$G(KMPDTTL)
 S KMPDHDR(1)=$J(" ",(80-$L(X)\2))_X
 S X=$P($G(KMPDPTNP),U,2)_" - "_KMPDSTTL
 S KMPDHDR(2)=$J(" ",(80-$L(X)\2))_X
 S X=$G(KMPDATE(0)),X=$P(X,U,3)_" - "_$P(X,U,4)
 S KMPDHDR(3)=$J(" ",(80-$L(X)\2))_X
 S KMPDHDR(3)=KMPDHDR(3)_$J(" ",61-$L(KMPDHDR(3)))_"Printed: "_$$FMTE^XLFDT(DT,2)
 S KMPDHDR(4)=""
 S KMPDHDR(6)=$J("",12)_"|---------------Seconds---------------|"
 S KMPDHDR(7)="Date"_$J(" ",8)_"Average TTL"_$J(" ",3)_"Minimum TTL"_$J(" ",3)_"Maximum TTL"_$J(" ",3)_"# of CV Loads"
 S KMPDHDR(8)=$$REPEAT^XLFSTR("-",80)
 ;
 Q
 ;
EXIT ;-- cleanup on exit
 S:$D(ZTQUEUED) ZTREQ="@"
 D ^%ZISC
 K KMPDATE,KMPDPTNP,KMPDTTL
 Q
