KMPDTP5 ;OAK/RAK - CP Timing Threshold Alert ;6/21/05  10:15
 ;;2.0;CAPACITY MANAGEMENT TOOLS;**4**;Mar 22, 2002
 ;
EN ;-- entry point
 ;
 N I,KMPDATE,KMPDSRCH,KMPDTSEC,KMPDTTL,POP,X,Y
 N ZTDESC,ZTRTN,ZTRSAVE,ZTSK,%ZIS
 ;
 S KMPDTTL=" Coversheet Time-to-Load (TTL) Alert Report "
 D HDR^KMPDUTL4(KMPDTTL)
 W !
 W !?7,"This alerting report shows the particular coversheet loads"
 W !?7,"that had excessive time-to-load values. This report will"
 W !?7,"search for a particular person, a particular client name or"
 W !?7,"IP address."
 W !
 ;
 ; if no data
 I '$O(^KMPD(8973.2,0)) D  Q
 .W !!?7,"*** There is currently no data in file #8973.2 (CP TIMING) ***"
 ;
 ; date & hour(s)
 D DTTMRNG^KMPDTU10("ORWCV",1,.KMPDATE,8)
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
 N DATA,DATE,DATE1,DELTA,DOT,END,GBL,HOUR,HR,I,IEN,QUEUED,TIME,XREF
 ;
 S DOT=1,QUEUED=$D(ZTQUEUED)
 ; set up HOUR() array
 F I=1:1:24 S:$P(KMPDATE(1),",",I)'="" HOUR(+$P(KMPDATE(1),",",I))=""
 Q:'$D(HOUR)
 S DATE=$P(KMPDATE(0),U)-.1,END=$P(KMPDATE(0),U,2)+.9
 Q:'DATE!('END)
 S GBL=$$GLOBAL(.KMPDSRCH) Q:GBL=""
 F  S DATE=$O(@GBL@(DATE)) Q:'DATE!(DATE>END)  D 
 .; determine hour
 .S HR=+$E($P(DATE,".",2),1,2)
 .S HR=$S(HR="":0,HR=24:0,1:HR)
 .; quit if not in HOUR() array
 .Q:'$D(HOUR(HR))
 .; hour & second
 .S TIME=$E($P(DATE,".",2),1,4) Q:'TIME
 .; insert colon (:) between hour & second
 .S TIME=$E(TIME,1,2)_":"_$E(TIME,3,4)
 .; date without time
 .S DATE1=$P(DATE,".")
 .S IEN=0
 .F  S IEN=$O(@GBL@(DATE,IEN)) Q:'IEN  D 
 ..Q:'$D(^KMPD(8973.2,IEN,0))  S DATA=^(0) Q:DATA=""
 ..S DOT=DOT+1 W:'QUEUED&('(DOT#1000)) "."
 ..S DELTA=$P(DATA,U,4)
 ..; quit if delta is less than threshold
 ..Q:DELTA<KMPDTSEC
 ..S ^TMP($J,DATE1,TIME)=DATA
 ..; new person - external format
 ..S $P(^TMP($J,DATE1,TIME),U,5)=$P($G(^VA(200,+$P(DATA,U,5),0)),U)
 ;
 Q
 ;
PRINT ;-- print data
 ;
 U IO
 D HDR
 Q:'$D(^TMP($J))
 N CONT,DATE,I,TOTAL
 S DATE="",CONT=1,TOTAL=0
 F  S DATE=$O(^TMP($J,DATE)) Q:'DATE  D  Q:'CONT
 .W !,$$FMTE^XLFDT(DATE,2) S HR=""
 .F  S HR=$O(^TMP($J,DATE,HR)) Q:HR=""  D  Q:'CONT
 ..I $Y>(IOSL-4) D  Q:'CONT
 ...D CONTINUE^KMPDUTL4("",1,.CONT) Q:'CONT
 ...D HDR W !,$$FMTE^XLFDT(DATE,2)
 ..W ?10,HR
 ..S DATA=^TMP($J,DATE,HR),TOTAL=TOTAL+1
 ..; user name
 ..W ?16,$S($P(DATA,U,5)]"":$E($P(DATA,U,5),1,15),1:"N/A")
 ..; client name
 ..W ?33,$S($P(DATA,U,6)]"":$E($P(DATA,U,6),1,15),1:"N/A")
 ..; ip address
 ..W ?50,$S($P(DATA,U,9)]"":$P(DATA,U,9),1:"N/A")
 ..; server delta
 ..W ?67,$J($P(DATA,U,4),8)
 ..W ! W:$E($O(^TMP($J,DATE,HR)),1,2)'=$E(HR,1,2) !
 ;
 ;I TOTAL W !!?3,"Total Count: ",$J($FN(TOTAL,",",0),$L(TOTAL)+1)
 ;
 ; pause if output to terminal
 I CONT D CONTINUE^KMPDUTL4("Press RETURN to continue",1)
 ;
 Q
 ;
HDR ;-- print header
 W @IOF
 S X=$G(KMPDTTL)
 W !?(80-$L(X)\2),X
 S X=$G(KMPDATE(0)),X=$P(X,U,3)_" - "_$P(X,U,4)
 W !?(80-$L(X)\2),X,?61,"Printed: ",$$FMTE^XLFDT(DT,2)
 S X=$P($G(KMPDSRCH),U,2)_": "
 S X=X_$P($G(KMPDSRCH(1)),U,$S((+$G(KMPDSRCH))=1:2,1:1))
 W !?(80-$L(X)\2),X
 S X="Threshold: "_$G(KMPDTSEC)_" seconds"
 W !?(80-$L(X)\2),X
 W !
 W !,"Date",?10,"Time",?16,"User Name",?33,"Client Name",?50,"IP Address",?67,"Time-to-Load"
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
 N GLOBAL,TYPE
 S GLOBAL=""
 S TYPE=+$G(KMPDSRCH)
 Q:'TYPE ""
 ; username
 I TYPE=1 S GLOBAL=$NA(^KMPD(8973.2,"ASSNPDTTM","ORWCV",$P(KMPDSRCH(1),U)))
 ; client name
 I TYPE=2 S GLOBAL=$NA(^KMPD(8973.2,"ASSCLDTTM","ORWCV",KMPDSRCH(1)))
 ; ip address
 I TYPE=3 S GLOBAL=$NA(^KMPD(8973.2,"ASSIPDTTM","ORWCV",KMPDSRCH(1)))
 ; any occurrence
 I TYPE=4 S GLOBAL=$NA(^KMPD(8973.2,"ASSDTTM","ORWCV"))
 Q GLOBAL
