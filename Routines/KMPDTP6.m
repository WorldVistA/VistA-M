KMPDTP6 ;OAK/RAK - CP Timing Real-Time Threshold Alert ;6/21/05  10:15
 ;;2.0;CAPACITY MANAGEMENT TOOLS;**4**;Mar 22, 2002
 ;
EN ;-- entry point
 ;
 N I,KMPDHOUR,KMPDSRCH,KMPDTSEC,KMPDTTL,POP,X,Y
 N ZTDESC,ZTRTN,ZTRSAVE,ZTSK,%ZIS
 ;
 S KMPDTTL=" Coversheet Time-to-Load Alert Report > Real-Time "
 D HDR^KMPDUTL4(KMPDTTL)
 W !
 W !?7,"This alerting report shows the particular coversheet loads"
 W !?7,"that have excessive time-to-load values for TODAY (Real-Time)."
 W !?7,"This report will search for a particular person, a particular"
 W !?7,"client name or IP address."
 W !
 ;
 ; if no data
 I $O(^KMPTMP("KMPDT","ORWCV",""))="" D  Q
 .W !!?7,"*** There is currently no data in global ^KMPTMP(""KMPDT"",""ORWCV"") ***"
 ;
 ; hours
 S KMPDHOUR=$$RLTMHR^KMPDTU11(0,1,1)
 Q:KMPDHOUR=""
 ;
 ; time-to-load threshold seconds
 S KMPDTSEC=$$TTLSEC^KMPDTU10
 Q:'KMPDTSEC
 ;
 ; search by
 D SRCHBY^KMPDTU10(.KMPDSRCH,"ORWCV",1)
 Q:'KMPDSRCH
 ;
 ; select output device.
 S %ZIS="Q",%ZIS("A")="Device: ",%ZIS("B")="HOME"
 W ! D ^%ZIS I POP W !,"No action taken." Q
 ; if queued.
 I $D(IO("Q")) K IO("Q") D  Q
 .S ZTDESC=KMPDTTL
 .S ZTRTN="EN1^KMPDTP6"
 .F I="KMPDHOUR","KMPDSRCH","KMPDTSEC","KMPDTTL" S ZTSAVE(I)=""
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
 Q:'$D(KMPDHOUR)
 Q:'$D(KMPDSRCH)
 Q:'$G(KMPDTSEC)
 Q:$G(KMPDTTL)=""
 ;
 K ^TMP($J)
 D DATA,PRINT,EXIT
 K ^TMP($J)
 Q
 ;
DATA ;-- compile data
 ;
 Q:'$D(KMPDHOUR)
 Q:'$G(KMPDSRCH)
 Q:'$G(KMPDTSEC)
 ;
 N DATA,DATA1,DATE,DATE1,DELTA,DOT,HOUR,HR,I,QUEUED,TIME
 ;
 S DOT=1,QUEUED=$D(ZTQUEUED)
 ; set up HOUR() array
 F I=1:1:24 S:$P(KMPDHOUR,",",I)'="" HOUR(+$P(KMPDHOUR,",",I))=""
 Q:'$D(HOUR)
 S I=""
 F  S I=$O(^KMPTMP("KMPDT","ORWCV",I)) Q:I=""  S DATA=^(I) I DATA]"" D 
 .S DOT=DOT+1 W:'QUEUED&('(DOT#1000)) "."
 .; start/end date/time in fileman format
 .S DATE(1)=$$HTFM^XLFDT($P(DATA,U)),DATE(2)=$$HTFM^XLFDT($P(DATA,U,2))
 .S DELTA=$$HDIFF^XLFDT($P(DATA,U,2),$P(DATA,U),2)
 .Q:DELTA<KMPDTSEC
 .Q:'DATE(1)!('DATE(2))
 .; determine hour
 .S HR=+$E($P(DATE(1),".",2),1,2)
 .S HR=$S(HR="":0,HR=24:0,1:HR)
 .; quit if not in HOUR() array
 .Q:'$D(HOUR(HR))
 .; hour & second
 .S TIME=$E($P(DATE(1),".",2),1,4) Q:'TIME
 .; insert colon (:) between hour & second
 .S TIME=$E(TIME,1,2)_":"_$E(TIME,3,4)
 .S:$P(TIME,":",2)="" $P(TIME,":",2)="00"
 .; date without time
 .S DATE1=$P(DATE(1),".") Q:'DATE1
 .S DATA1="^^^"_DELTA_"^"_$P(DATA,U,3)_"^"_$P(DATA,U,4)_"^^^"_$P($P(I," ",2),"-")
 .; quit if no match
 .Q:'$$MATCH
 .S ^TMP($J,DATE1,TIME)=DATA1
 .; new person - external format
 .S $P(^TMP($J,DATE1,TIME),U,5)=$P($G(^VA(200,+$P(DATA,U,3),0)),U)
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
 I CONT&(TOTAL) W !!?3,"Total Count: ",$J($FN(TOTAL,",",0),$L(TOTAL)+1)
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
 S X="Hour(s): "_$G(KMPDHOUR)
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
 K KMPDHOUR,KMPDSRCH,KMPDTSEC,KMPDTTL
 Q
 ;
MATCH() ;-- extrinsic function - check for matches
 ;-----------------------------------------------------------------------
 ; Return: 1 - match found
 ;         0 - no match found
 ;-----------------------------------------------------------------------
 Q:'$G(KMPDSRCH) 0
 ; any occurrence
 Q:(+KMPDSRCH)=4 1
 ; if not 'any occurrence' then must have kmpdsrch(1) node
 Q:'$D(KMPDSRCH(1)) 0
 ; if not 'any occurrence' must have DATA1 to determine match
 Q:$G(DATA1)=""
 ; user name
 Q:(+KMPDSRCH)=1&($P(DATA1,U,5)'=$P(KMPDSRCH(1),U)) 0
 ; client name
 Q:(+KMPDSRCH)=2&($P(DATA1,U,6)'=$P(KMPDSRCH(1),U)) 0
 ; ip address
 Q:(+KMPDSRCH)=3&($P(DATA1,U,9)'=$P(KMPDSRCH(1),U)) 0
 Q 1
