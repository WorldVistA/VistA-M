HLOESTAT ;ALB/CJM- HLO ERROR STATISTICS- 10/4/94 1pm ;03/12/2007
 ;;1.6;HEALTH LEVEL SEVEN;**134**;Oct 13, 1995;Build 30
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
COUNT(DIR,RAP,SAP,MSGTYPE,EVENT) ;
 ;DIR="IN" or "OUT", the "E" appended to diferentiate error stats
 N TYPE
 S:RAP="" RAP="UNKNOWN"
 S:SAP="" SAP="UNKNOWN"
 S TYPE=$G(MSGTYPE)
 I $L($G(EVENT)) S TYPE=TYPE_"~"_$G(EVENT)
 S:$L(TYPE)<2 TYPE="UNKNOWN"
 I $$INC^HLOSITE($NA(^HLSTATS("E"_DIR,"HOURLY",+$E($$NOW^XLFDT,1,10),SAP,RAP,TYPE)))
 Q
 ;
REPORT ;Interactive option for printing the message error statistics report
 N DIR,TYPE,START,END
 W !,"Hourly, daily, and monthly error statistics are maintained."
 W !,"Hourly statistics are available for approximately the last 24 hours."
 W !,"Daily statistics are available for approximately the last 30 days."
 W !,"Monthly statistics are kept indefinitely"
 S DIR(0)="S^h:HOURLY;d:DAILY;m:MONTHLY"
 S DIR("A")="Which type of error statistics should be reported"
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
 W "HLO MESSAGE ERROR STATISTICS REPORT ",$$FMTE^XLFDT($$NOW^XLFDT),?70,"Page 1"
 D LINE($$LJ("Type:",15)_STATTYPE)
 D LINE($$LJ("Beginning:",15)_$S(STATTYPE="MONTHLY":$$FMTE^XLFDT(START),1:$$FMTE^XLFDT(START)))
 D LINE($$LJ("Ending:",15)_$$FMTE^XLFDT(END))
 S PAGE=1
 ;
 ;
 F DIR="EIN","EOUT" D  Q:QUIT
 .N TOTAL
 .S TOTAL=0
 .D LINE(" ")
 .S TIME=START
 .S:STATTYPE="MONTHLY" TIME=$E(TIME,1,5)
 .S TIME=TIME-.0001
 .D LINE($S(DIR="EIN":"INCOMING MESSAGES:",1:"OUTGOING MESSAGES:"))
 .Q:QUIT
 .F  S TIME=$O(^HLSTATS(DIR,STATTYPE,TIME)) Q:((TIME>$G(END))&$G(END))  Q:'TIME  D  Q:QUIT
 ..N SUBTOTAL
 ..S SUBTOTAL=0
 ..D LINE(" ")
 ..Q:QUIT
 ..D LINE("     Time Period: "_$S(STATTYPE="MONTHLY":$$FMTE^XLFDT(TIME_"00"),1:$$FMTE^XLFDT(TIME)))
 ..Q:QUIT
 ..S SAP=""
 ..F  S SAP=$O(^HLSTATS(DIR,STATTYPE,TIME,SAP)) Q:SAP=""  D  Q:QUIT
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
 ...D LINE(" "),LINE($$RJ("**"_STATTYPE_" SUBTOTAL: ",68)_$$RJ(SUBTOTAL,10))
 .D:'QUIT LINE(" "),LINE($$RJ("** TOTAL "_$S(DIR="EIN":"INCOMING",1:"OUTGOING")_" MESSAGE ERRORS: ",68)_$$RJ(TOTAL,10))
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
 .S ZTRTN="QUE^HLOESTAT",ZTDESC="HLO ERROR STATISTICS REPORT",ZTSAVE("HLOPARMS(")=""
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
