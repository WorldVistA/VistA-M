KMPDTP5 ;OAK/RAK/JML - CP Timing Threshold Alert ;9/1/2015
 ;;3.0;Capacity Management Tools;**3**;Jan 15, 2013;Build 42
 ;
EN ;-- entry point
 ;
 N I,KMPDATE,KMPDSRCH,KMPDTSEC,KMPDTTL,POP,X,Y
 N ZTDESC,ZTRTN,ZTRSAVE,ZTSK,%ZIS
 N KMPDLBG,KMPDLFG,KMPDDTSS
 ;
 S KMPDTTL=" Coversheet Time-to-Load (TTL) Alert Report "
 D HDR^KMPDUTL4(KMPDTTL)
 W !
 W !?7,"This alerting report shows the particular coversheet loads"
 W !?7,"that had excessive time-to-load values. This report will"
 W !?7,"search for a particular person, a particular client name or"
 W !?7,"IP address."
 W !?7,"Foreground and background times are combined."
 W !
 ;
 ; if no data
 I '$O(^KMPD(8973.2,0)) D  Q
 .W !!?7,"*** There is currently no data in file #8973.2 (CP TIMING) ***"
 ;
 ; date & hour(s) - first determine which subscript to use in API due to addition of foreground processing
 S KMPDLFG=$O(^KMPD(8973.2,"ASSDTTM","ORWCV-FT","A"),-1)
 S KMPDLBG=$O(^KMPD(8973.2,"ASSDTTM","ORWCV","A"),-1)
 S KMPDDTSS=$S(KMPDLFG=KMPDLBG:"ORWCV-FT",KMPDLFG>KMPDLBG:"ORWCV-FT",KMPDLFG<KMPDLBG:"ORWCV",1:"UNKNOWN")
 D DTTMRNG^KMPDTU10(KMPDDTSS,1,.KMPDATE,8)
 Q:$G(KMPDATE(0))=""
 Q:$G(KMPDATE(1))=""
 ;
 ; time-to-load threshold seconds
 S KMPDTSEC=$$TTLSEC^KMPDTU10
 Q:'KMPDTSEC
 ;
 ; search by
 D SRCHBY^KMPDTU10(.KMPDSRCH,"ORWCV")
 Q:'KMPDSRCH
 ;
 ; select output device.
 S %ZIS="Q",%ZIS("A")="Device: ",%ZIS("B")="HOME"
 W ! D ^%ZIS I POP W !,"No action taken." Q
 ; if queued.
 I $D(IO("Q")) K IO("Q") D  Q
 .S ZTDESC=KMPDTTL
 .S ZTRTN="EN1^KMPDTP5"
 .F I="KMPDATE(","KMPDSRCH(","KMPDTSEC","KMPDTTL" S ZTSAVE(I)=""
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
 I '$D(KMPDATE) D EXIT Q
 I '$D(KMPDSRCH) D EXIT Q
 I '$G(KMPDTSEC) D EXIT Q
 I $G(KMPDTTL)="" D EXIT Q
 ;
 K ^TMP($J)
 U IO
 D DATA,PRINT,EXIT
 K ^TMP($J)
 Q
 ;
DATA ;-- compile data
 ;
 Q:'$D(KMPDATE)
 Q:'$G(KMPDSRCH)
 Q:'$G(KMPDTSEC)
 ;
 N DATA,DATE,DATE1,DELTA,DOT,END,GBL,GBLREF,HOUR,HR,I,IEN,QUEUED,TIME,XREF
 N KMPDBIDX,KMPDTOT,KMPDSS,KMPDLUSS
 ;
 S GBLREF=$$GLOBAL(.KMPDSRCH) Q:GBLREF=""
 S XREF=$P(GBLREF,U),KMPDLUSS=$P(GBLREF,U,2)
 ;
 S DOT=1,QUEUED=$D(ZTQUEUED)
 ; set up HOUR() array
 F I=1:1:24 S:$P(KMPDATE(1),",",I)'="" HOUR(+$P(KMPDATE(1),",",I))=""
 Q:'$D(HOUR)
 S DATE=$P(KMPDATE(0),U)-.1,END=$P(KMPDATE(0),U,2)+.9
 Q:'DATE!('END)
 ;
 K ^TMP($J)
 F KMPDSS="ORWCV","ORWCV-FT" D
 .; reset date and end for each pass
 .S DATE=$P(KMPDATE(0),U)-.1,END=$P(KMPDATE(0),U,2)+.9
 .S KMPDTOT(KMPDSS)=0
 .I KMPDLUSS="" S GBL=$NA(^KMPD(8973.2,XREF,KMPDSS))
 .I KMPDLUSS'="" S GBL=$NA(^KMPD(8973.2,XREF,KMPDSS,KMPDLUSS))
 .F  S DATE=$O(@GBL@(DATE)) Q:'DATE!(DATE>END)  D
 ..; determine hour
 ..S HR=+$E($P(DATE,".",2),1,2)
 ..S HR=$S(HR="":0,HR=24:0,1:HR)
 ..; quit if not in HOUR() array
 ..Q:'$D(HOUR(HR))
 ..; hour & second
 ..S TIME=$E($P(DATE,".",2),1,6) Q:'TIME
 ..; insert colon (:) between hour & second
 ..S TIME=$E(TIME,1,2)_":"_$E(TIME,3,4)_":"_$E(TIME,5,6)
 ..; date without time
 ..S DATE1=$P(DATE,".")
 ..S IEN=0
 ..F  S IEN=$O(@GBL@(DATE,IEN)) Q:'IEN  D 
 ...Q:'$D(^KMPD(8973.2,IEN,0))  S DATA=^(0) Q:DATA=""
 ...S DOT=DOT+1 W:'QUEUED&('(DOT#1000)) "."
 ...S KMPDBIDX=$P(DATA,U)
 ...S ^TMP($J,"DATA",DATE,TIME,KMPDBIDX,KMPDSS)=DATA
 ...S $P(^TMP($J,"DATA",DATE,TIME,KMPDBIDX,KMPDSS),U,5)=$P($G(^VA(200,+$P(DATA,U,5),0)),U)
 ...S KMPDTOT(KMPDSS)=KMPDTOT(KMPDSS)+1
 ;
 Q
 ;
PRINT ;-- print data
 ;
 U IO
 N KMPDCNAM,KMPDUNAM,KMPDIP,KMPDSET,KMPDPDT,KMPDTOTD
 D HDR
 Q:'$D(^TMP($J))
 N CONT,DATE,I,TOTAL
 S DATE="",CONT=1,TOTAL=0
 F  S DATE=$O(^TMP($J,"DATA",DATE)) Q:'DATE  D  Q:'CONT
 .S HR=""
 .F  S HR=$O(^TMP($J,"DATA",DATE,HR)) Q:HR=""  D  Q:'CONT
 ..I $Y>(IOSL-4) D  Q:'CONT
 ...D CONTINUE^KMPDUTL4("",1,.CONT) Q:'CONT
 ...D HDR ;W !,$$FMTE^XLFDT(DATE,2)
 ..S KMPDBIDX=""
 ..F  S KMPDBIDX=$O(^TMP($J,"DATA",DATE,HR,KMPDBIDX)) Q:KMPDBIDX=""  D
 ...S KMPDSS="",KMPDSET=1,KMPDTOTD=0
 ...F  S KMPDSS=$O(^TMP($J,"DATA",DATE,HR,KMPDBIDX,KMPDSS)) Q:KMPDSS=""  D
 ....S DATA=$G(^TMP($J,"DATA",DATE,HR,KMPDBIDX,KMPDSS))
 ....I KMPDSET D
 .....S KMPDUNAM=$S($P(DATA,U,5)]"":$E($P(DATA,U,5),1,23),1:"N/A")
 .....S KMPDCNAM=$S($P(DATA,U,6)]"":$E($P(DATA,U,6),1,23),1:"N/A")
 .....S KMPDIP=$S($P(DATA,U,9)]"":$P(DATA,U,9),1:"N/A")
 .....S KMPDSET=0
 ....S KMPDTOTD=KMPDTOTD+$P(DATA,U,4)
 ...; W COMBINED DATA
 ...Q:KMPDTOTD<KMPDTSEC
 ...S TOTAL=TOTAL+1
 ...S KMPDPDT=$$FMTE^XLFDT(DATE,2)
 ...W !,$P(KMPDPDT,"@",2),?10,KMPDUNAM,?35,KMPDCNAM,?60,KMPDIP,?76,KMPDTOTD
 K ^TMP($J)
 ;
 I TOTAL W !!?3,"Total Count: ",$J($FN(TOTAL,",",0),$L(TOTAL)+1)
 ;
 ; pause if output to terminal
 I CONT D CONTINUE^KMPDUTL4("Press RETURN to continue",1)
 ;
 Q
 ;
HDR ;-- print header
 W @IOF
 N HRS
 S X=$G(KMPDTTL)
 W !?(80-$L(X)\2),X
 S HRS=$E(KMPDATE(1),1,$L(KMPDATE(1))-1)
 S X=$G(KMPDATE(0)),X=$P(X,U,3)_" - Hours: "_HRS
 W !?(80-$L(X)\2),X,?61,"Printed: ",$$FMTE^XLFDT(DT,2)
 I +KMPDSRCH<4 D
 .S X=$P($G(KMPDSRCH),U,2)_": "
 .S X=X_$P($G(KMPDSRCH(1)),U,$S((+$G(KMPDSRCH))=1:2,1:1))
 .W !?(80-$L(X)\2),X
 S X="Threshold: "_$G(KMPDTSEC)_" seconds"
 W !?(80-$L(X)\2),X
 W !
 W !,"Time",?10,"User Name",?35,"Client Name",?60,"IP Address",?76,"TTL"
 W !,$$REPEAT^XLFSTR("-",IOM)
 ;
 Q
 ;
EXIT ;-- cleanup on exit
 S:$D(ZTQUEUED) ZTREQ="@"
 D ^%ZISC
 K KMPDATE,KMPDSRCH,KMPDTSEC,KMPDTTL
 Q
 ;
GLOBAL(KMPDSRCH) ;-- extrinsic function
 ;-----------------------------------------------------------------------
 ; KMPDSRCH... see above
 ;-----------------------------------------------------------------------
 Q:'$G(KMPDSRCH) ""
 N RETURN,TYPE
 S RETURN=""
 S TYPE=+$G(KMPDSRCH),KMPDSRCH(1)=$G(KMPDSRCH(1))
 Q:'TYPE ""
 I TYPE<4 Q:KMPDSRCH(1)="" ""
 ; any occurrence
 I TYPE=4 S RETURN="ASSDTTM^"
 ; username
 I TYPE=1 S RETURN="ASSNPDTTM^"_+$P(KMPDSRCH(1),U)
 ; client name
 I TYPE=2 S RETURN="ASSCLDTTM^"_KMPDSRCH(1)
 ; ip address
 I TYPE=3 S RETURN="ASSIPDTTM^"_KMPDSRCH(1)
 Q RETURN
 ;
