HLOSTAT ;ALB/CJM- HLO STATISTICS- 10/4/94 1pm ;01/05/2007
 ;;1.6;HEALTH LEVEL SEVEN;**130,131,134**;Oct 13, 1995;Build 30
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
COUNT(HLCSTATE,RAP,SAP,TYPE) ;
 S:RAP="" RAP="UNKNOWN"
 S:SAP="" SAP="UNKNOWN"
 S:$L(TYPE)<2 TYPE="UNKNOWN"
 S HLCSTATE("COUNTS")=$G(HLCSTATE("COUNTS"))+1,HLCSTATE("COUNTS",SAP,RAP,TYPE)=1+$G(HLCSTATE("COUNTS",SAP,RAP,TYPE))
 Q
SAVECNTS(HLCSTATE) ;
 N TIME,DIR,RAP,SAP,TYPE,COUNT
 Q:'$G(HLCSTATE("COUNTS"))
 S TIME=$E($$NOW^XLFDT,1,10)
 S DIR=$S(+$G(HLCSTATE("SERVER")):"IN",1:"OUT")
 I $G(HLCSTATE("COUNTS","ACKS")) D
 .I $$INC^HLOSITE($NA(^HLSTATS($S(DIR="IN":"OUT",1:"IN"),"HOURLY",+TIME,"ACCEPT ACK")),HLCSTATE("COUNTS","ACKS"))
 S SAP=""
 F  S SAP=$O(HLCSTATE("COUNTS",SAP)) Q:SAP=""  D
 .S RAP=""
 .F  S RAP=$O(HLCSTATE("COUNTS",SAP,RAP)) Q:RAP=""  D
 ..S TYPE=""
 ..F  S TYPE=$O(HLCSTATE("COUNTS",SAP,RAP,TYPE)) Q:TYPE=""  D
 ...S COUNT=HLCSTATE("COUNTS",SAP,RAP,TYPE)
 ...I $$INC^HLOSITE($NA(^HLSTATS(DIR,"HOURLY",+TIME,SAP,RAP,TYPE)),COUNT)
 K HLCSTATE("COUNTS") S HLCSTATE("COUNTS")=0
 Q
 ;
TOTAL(WORK) ;totals hours into days and days into months
 ;
 N RAP,SAP,TIME,LIMIT,DIR,COUNT,MONTH,START,END
 ;
 ;start totaling the next day after last date totaled
 S START=$G(^HLSTATS("END DATE"))
 S:START START=$$FMADD^XLFDT(START,1)
 ;
 ;end totaling in the last hour of yesterday and save it so that the next run knows where to start
 S END=$$FMADD^XLFDT($$DT^XLFDT,-1)
 S ^HLSTATS("END DATE")=END
 S END=END+.24
 ;
 ;total hours into days
 S LIMIT=$$FMADD^XLFDT($$DT^XLFDT,,-48) ;save ~48 hours of hourly data
 F DIR="IN","OUT","EIN","EOUT" D
 .S TIME=0
 .F  S TIME=$O(^HLSTATS(DIR,"HOURLY",TIME)) Q:'TIME  Q:(TIME>END)  D
 ..D:'(TIME<START)
 ...S:(DIR="IN")!(DIR="OUT") ^HLSTATS(DIR,"DAILY",$P(TIME,"."),"ACCEPT ACK")=$G(^HLSTATS(DIR,"DAILY",$P(TIME,"."),"ACCEPT ACK"))+$G(^HLSTATS(DIR,"HOURLY",TIME,"ACCEPT ACK"))
 ...S SAP=""
 ...F  S SAP=$O(^HLSTATS(DIR,"HOURLY",TIME,SAP)) Q:SAP=""  D
 ....S RAP=""
 ....F  S RAP=$O(^HLSTATS(DIR,"HOURLY",TIME,SAP,RAP)) Q:RAP=""  D
 .....S TYPE=""
 .....F  S TYPE=$O(^HLSTATS(DIR,"HOURLY",TIME,SAP,RAP,TYPE)) Q:TYPE=""  D
 ......S COUNT=$G(^HLSTATS(DIR,"HOURLY",TIME,SAP,RAP,TYPE))
 ......S ^HLSTATS(DIR,"DAILY",$P(TIME,"."),SAP,RAP,TYPE)=$G(^HLSTATS(DIR,"DAILY",$P(TIME,"."),SAP,RAP,TYPE))+COUNT
 ..;get rid of old hourly stats
 ..K:(TIME<LIMIT) ^HLSTATS(DIR,"HOURLY",TIME)
 ;
 ;total days into months
 S LIMIT=$$FMADD^XLFDT($$DT^XLFDT,-30) ;save ~30 days of daily data
 F DIR="IN","OUT","EIN","EOUT" D
 .S TIME=0
 .F  S TIME=$O(^HLSTATS(DIR,"DAILY",TIME)) Q:'TIME  Q:(TIME>END)  D
 ..D:'(TIME<START)
 ...S MONTH=$E(TIME,1,5)
 ...S:(DIR="IN")!(DIR="OUT") ^HLSTATS(DIR,"MONTHLY",MONTH,"ACCEPT ACK")=$G(^HLSTATS(DIR,"MONTHLY",MONTH,"ACCEPT ACK"))+$G(^HLSTATS(DIR,"DAILY",TIME,"ACCEPT ACK"))
 ...S SAP=""
 ...F  S SAP=$O(^HLSTATS(DIR,"DAILY",TIME,SAP)) Q:SAP=""  D
 ....S RAP=""
 ....F  S RAP=$O(^HLSTATS(DIR,"DAILY",TIME,SAP,RAP)) Q:RAP=""  D
 .....S TYPE=""
 .....F  S TYPE=$O(^HLSTATS(DIR,"DAILY",TIME,SAP,RAP,TYPE)) Q:TYPE=""  D
 ......S COUNT=$G(^HLSTATS(DIR,"DAILY",TIME,SAP,RAP,TYPE))
 ......S ^HLSTATS(DIR,"MONTHLY",MONTH,SAP,RAP,TYPE)=$G(^HLSTATS(DIR,"MONTHLY",MONTH,SAP,RAP,TYPE))+COUNT
 ..K:(TIME<LIMIT) ^HLSTATS(DIR,"DAILY",TIME)
 Q
REPORT ;Interactive option for printing the message statistics report
 N DIR,TYPE,START,END
 W !,"Hourly, daily, and monthly statistics are maintained."
 W !,"Hourly statistics are available for approximately the last 24 hours."
 W !,"Daily statistics are available for approximately the last 30 days."
 W !,"Monthly statistics are kept indefinitely"
 S DIR(0)="S^h:HOURLY;d:DAILY;m:MONTHLY"
 S DIR("A")="Which type of statistics should be reported"
 S DIR("B")="MONTHLY"
 D ^DIR
 Q:$D(DIRUT)
 I Y'="h",Y'="d",Y'="m" Q
 S TYPE=$S(Y="h":"HOURLY",Y="d":"DAILY",1:"MONTHLY")
 S START=$S(TYPE="HOURLY":$E($$FMADD^XLFDT($$NOW^XLFDT,,-24),1,10),TYPE="DAILY":$$FMADD^XLFDT(DT,-7),1:$E($$FMADD^XLFDT(DT,-30),1,5)_"01")
 S START=$$ASKBEGIN^HLOUSR2(START)
 Q:'START
 S END=$$ASKEND^HLOUSR2(START)
 Q:'END
 S:TYPE="MONTHLY" START=$E(START,1,5)_"00"
 S:TYPE="DAILY" START=$E(START,1,7)
 S:TYPE="HOURLY" START=$E(START,1,10)
 D:$$DEVICE() PRINT(TYPE,START,END)
 Q
 ;
QUE ;entry point for queuing the message statistics report
 D PRINT($G(HLOPARMS("STATISTICS TYPE")),$G(HLOPARMS("START DT/TM")),$G(HLOPARMS("END DT/TM")))
 Q
 ;
PRINT(STATTYPE,START,END) ;
 ;
 N RAP,SAP,TIME,DIR,COUNT,PAGE,CRT,QUIT
 S QUIT=0
 S CRT=$S($E(IOST,1,2)="C-":1,1:0)
 ;
 U IO
 W:CRT @IOF
 W "HLO MESSAGING STATISTICS REPORT ",$$FMTE^XLFDT($$NOW^XLFDT),?70,"Page 1"
 D LINE($$LJ("Type:",15)_STATTYPE)
 D LINE($$LJ("Beginning:",15)_$S(STATTYPE="MONTHLY":$$FMTE^XLFDT(START),1:$$FMTE^XLFDT(START)))
 D LINE($$LJ("Ending:",15)_$$FMTE^XLFDT(END))
 S PAGE=1
 ;
 ;
 F DIR="IN","OUT" D  Q:QUIT
 .N TOTAL
 .S TOTAL=0
 .D LINE(" ")
 .S TIME=START
 .S:STATTYPE="MONTHLY" TIME=$E(TIME,1,5)
 .S TIME=TIME-.0001
 .D LINE($S(DIR="IN":"Incoming Messages:",1:"Outgoing Messages:"))
 .Q:QUIT
 .F  S TIME=$O(^HLSTATS(DIR,STATTYPE,TIME)) Q:((TIME>$G(END))&$G(END))  Q:'TIME  D  Q:QUIT
 ..N SUBTOTAL
 ..S SUBTOTAL=0
 ..D LINE(" ")
 ..Q:QUIT
 ..D LINE("     Time Period: "_$S(STATTYPE="MONTHLY":$$FMTE^XLFDT(TIME_"00"),1:$$FMTE^XLFDT(TIME)))
 ..Q:QUIT
 ..S COUNT=$G(^HLSTATS(DIR,STATTYPE,TIME,"ACCEPT ACK"))
 ..I COUNT D  Q:QUIT
 ...D LINE(" ")
 ...Q:QUIT
 ...D LINE("          Accept Acknowledgments by All Applications          Count:"_$$RJ(COUNT,10))
 ...Q:QUIT
 ...D LINE(" ")
 ..S SAP=""
 ..F  S SAP=$O(^HLSTATS(DIR,STATTYPE,TIME,SAP)) Q:SAP=""  D  Q:QUIT
 ...Q:SAP="ACCEPT ACK"
 ...D LINE("          Sending Application: "_SAP)
 ...Q:QUIT
 ...S RAP=""
 ...F  S RAP=$O(^HLSTATS(DIR,STATTYPE,TIME,SAP,RAP)) Q:RAP=""  D  Q:QUIT
 ....D LINE("               Receiving Application: "_RAP)
 ....Q:QUIT
 ....S TYPE=""
 ....F  S TYPE=$O(^HLSTATS(DIR,STATTYPE,TIME,SAP,RAP,TYPE)) Q:TYPE=""  D  Q:QUIT
 .....S COUNT=$G(^HLSTATS(DIR,STATTYPE,TIME,SAP,RAP,TYPE))
 .....S SUBTOTAL=SUBTOTAL+COUNT
 .....D LINE("                    Message Type: "_$$LJ(TYPE,25)_"   Count:"_$$RJ(COUNT,10))
 .....Q:QUIT
 ..I 'QUIT D
 ...S TOTAL=TOTAL+SUBTOTAL
 ...D LINE(" "),LINE($$RJ("**"_STATTYPE_" SUBTOTAL ** (excluding commit acks):",68)_$$RJ(SUBTOTAL,10))
 .D:'QUIT LINE(" "),LINE($$RJ("** TOTAL "_$S(DIR="IN":"INCOMING",1:"OUTGOING")_" MESSAGES ** (excluding commit acks):",68)_$$RJ(TOTAL,10))
 I CRT,'QUIT D PAUSE2
 I $D(ZTQUEUED) S ZTREQ="@"
 D ^%ZISC
 Q
 ;
DEVICE() ;
 ;Description: allows the user to select a device.
 ;Input: none
 ;
 ;Output:
 ;  Function Value - Returns 0 if the user decides not to print or to
 ;    queue the report, 1 otherwise.
 ;
 N OK,HLOPARMS
 S OK=1
 S %ZIS="MQ"
 D ^%ZIS
 S:POP OK=0
 D:OK&$D(IO("Q"))
 .S HLOPARMS("STATISTICS TYPE")=TYPE,HLOPARMS("START DT/TM")=START,HLOPARMS("END DT/TM")=END
 .S ZTRTN="QUE^HLOSTAT",ZTDESC="HLO MESSAGE STATISTICS REPORT",ZTSAVE("HLOPARMS(")=""
 .D ^%ZTLOAD
 .W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 .D HOME^%ZIS
 .S OK=0
 Q OK
 ;
PAUSE ;
 ;First scrolls to the bottome of the page, then does a screen pause.  Sets QUIT=1 if user decides to quit.
 ;
 N DIR,X,Y
 F  Q:$Y>(IOSL-3)  W !
 S DIR(0)="E"
 D ^DIR
 I ('(+Y))!$D(DIRUT) S QUIT=1
 Q
PAUSE2 ;
 ;Screen pause without scrolling.  Sets QUIT=1 if user decides to quit.
 ;
 N DIR,X,Y
 S DIR(0)="E"
 D ^DIR
 I ('(+Y))!$D(DIRUT) S QUIT=1
 Q
 ;
LINE(LINE) ;Prints a line.
 ;
 I CRT,($Y>(IOSL-4)) D
 .D PAUSE
 .Q:QUIT
 .W @IOF
 .W LINE
 ;
 E  I ('CRT),($Y>(IOSL-2)) D
 .W @IOF
 .W ?70,"Page: ",PAGE
 .S PAGE=PAGE+1
 .W LINE
 ;
 E  W !,LINE
 Q
 ;
LJ(STRING,LEN) ;
 Q $$LJ^XLFSTR($E(STRING,1,LEN),LEN)
RJ(STRING,LEN) ;
 Q $$RJ^XLFSTR($E(STRING,1,LEN),LEN)
