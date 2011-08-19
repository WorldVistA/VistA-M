KMPDTM ;OAK/RAK - CM Tools Timing Monitor ;6/21/05  10:14
 ;;2.0;CAPACITY MANAGEMENT TOOLS;**1,4**;Mar 22, 2002
 ;
EN ;-- entry point
 ;
 N DIR,X,Y
 ;
 D HDR^KMPDUTL4(" Timing Data Monitor ")
 ;
 ; if no data
 I $O(^KMPTMP("KMPDT","ORWCV",""))="" D  Q
 .W !!?7,"*** There is currently no data in global ^KMPTMP(""KMPDT"",""ORWCV"") ***"
 ;
 W !
 W !?7,"This option displays CPRS Coversheet time-to-load data, as a"
 W !?7,"bar graph, for the current day.  This option can be left"
 W !?7,"running on a terminal (if desired).  The monitor is updated"
 W !?7,"every 10 minutes (site configurable through the [KMPD PARAM"
 W !?7,"EDIT] Edit CP Parameters File option), and displays current"
 W !?7,"average time-to-load data starting at midnight.  An alarm"
 W !?7,"message is displayed if the average time-to-load exceeds 30"
 W !?7,"seconds (site configurable through the [KMPD PARAM EDIT] Edit"
 W !?7,"CP Parameters File option)."
 W !
 S DIR(0)="YO",DIR("A")="Continue",DIR("B")="YES"
 W ! D ^DIR Q:Y'=1
 ;
 ;
 W !!,"Compiling timing stats..."
 D EN1
 ;
 Q
 ;
EN1 ;-- main loop
 ;
 N KMPUALRT,KMPUTIME,KMPUTMP,OUT
 ;
 S KMPUALRT=0,KMPUTIME=$$NOW^XLFDT
 S OUT=0
 F  D  Q:OUT
 .D DATA
 .D GRAPH
 .S OUT=$$FTR Q:OUT
 .D EXIT
 Q
 ;
DATA ;-- compile data
 ;
 N DATA,DATA1,DATE,DELTA,DOT,HOURS,HR,I
 ;
 K KMPUTMP
 S DOT=1,DATE=$$DT^XLFDT
 ; array with hours
 S HOURS=$$RLTMHR^KMPDTU11(1,0) Q:HOURS=""
 F HR=1:1 Q:$P(HOURS,",",HR)=""  S KMPUTMP(HR,0)=""
 S I=""
 F  S I=$O(^KMPTMP("KMPDT","ORWCV",I)) Q:I=""  S DATA=^(I) I DATA]"" D 
 .S DOT=DOT+1 W:('(DOT#1000)) "."
 .; start/end date/time in fileman format
 .S DATE(1)=$$HTFM^XLFDT($P(DATA,U)),DATE(2)=$$HTFM^XLFDT($P(DATA,U,2))
 .Q:'DATE(1)!('DATE(2))
 .; quit if not today (DATE)
 .Q:$P(DATE(1),".")'=DATE
 .S DELTA=$$FMDIFF^XLFDT(DATE(2),DATE(1),2)
 .S:DELTA<0 DELTA=""
 .; determine hour
 .S HR=+$E($P(DATE(1),".",2),1,2) Q:HR=""  ;HR="0"
 .;Q:'HR
 .; quit if not in HOUR() array
 .;Q:'$D(HOUR(HR))
 .S DATA1="^^^"_DELTA_"^"_$P(DATA,U,3)_"^"_$P(DATA,U,4)_"^^^"_$P($P(I," ",2),"-")
 .;
 .; quit if no delta
 .Q:$P(DATA1,U,4)=""
 .; hour
 .S $P(KMPUTMP(HR,0),U)=HR
 .; total delta
 .S $P(KMPUTMP(HR,0),U,2)=$P(KMPUTMP(HR,0),U,2)+$P(DATA1,U,4)
 .; count
 .S $P(KMPUTMP(HR,0),U,3)=$P(KMPUTMP(HR,0),U,3)+1
 ;
 ; average
 F HR=1:1 S I=$P(HOURS,",",HR) Q:I=""  I $P($G(KMPUTMP(I,0)),U,2) D 
 .S $P(KMPUTMP(I,0),U,2)=$FN($P(KMPUTMP(I,0),U,2)/$P(KMPUTMP(I,0),U,3),"",1)
 ;
 Q
 ;
FTR() ;-- extrinsic function - footer
 N OUT,PROMPT,UTIME,X
 ; update time - how often graph will refress itself
 S UTIME=$P($G(^KMPD(8973,1,19)),U)
 ; value is in minutes and is converted to seconds for timed read
 S UTIME=$S(UTIME:UTIME,1:10)*60
 S PROMPT="[Q]uit, [U]pdate: "
 S OUT=0
 F  D  Q:OUT
 .S DX=(IOM-$L(PROMPT)\2),DY=(IOSL-1) X IOXY
 .W PROMPT R X:UTIME
 .S X=$$UP^XLFSTR(X)
 .I X="Q"!(X="^")!(X="U")!('$T) S OUT=1
 .E  W $C(7) S DY=(IOSL-1) F DX=1:1:IOM W " " X IOXY
 W $S(X="Q":"uit",X="^":"Quit",X="U":"pdate",1:"Update")
 Q $S(X="Q"!(X="^"):1,1:0)
 ;
GRAPH ;-- display graph
 Q:'$D(KMPUTMP)
 N ALERT,DATA,LOADTM,NOW,TITLE,TXT,UPDATE
 ; alert time in seconds - if average time-to-load is not less than this
 ;                         value an alert will appear on screen
 S NOW=$$NOW^XLFDT
 S DATA=$G(^KMPD(8973,1,19))
 ; if no ALERT set default to 30 seconds
 S ALERT=$S($P(DATA,U,2):$P(DATA,U,2),1:30)
 ; if not UPDATE default to 10 minutes
 S UPDATE=$S($P(DATA,U):$P(DATA,U),1:10)
 ; current hour
 S HR=+$E($P(NOW,".",2),1,2)
 ; current time-to-load value
 S:HR&($D(KMPUTMP(HR))) LOADTM=$P(KMPUTMP(HR,0),U,2)
 ; determine if is now an alert condition
 S KMPUALRT=$S(LOADTM>ALERT:1,1:0)
 ;
 ; if load time is greater than alert time
 I KMPUALRT S TXT(1,0)=$C(7)_"ALERT!!! - Current Average Time-To-Load exceeds '"_ALERT_" seconds'"
 ; else
 E  S TXT(1,0)=""
 ;
 S TXT(2,0)=""
 S TXT(3,0)="Last Updated: "_$P($$FMTE^XLFDT(NOW),"@",2)_"  > "
 S TXT(3,0)=TXT(3,0)_"Monitor will be updated every "_UPDATE_" min."
 I $G(KMPUTIME) D 
 .S TXT(4,0)="Running Time: "_$$FMDIFF^XLFDT(NOW,KMPUTIME,3)_"  > "
 .S TXT(4,0)=TXT(4,0)_"ALERT will display if Load Time exceeds "_ALERT_" sec."
 S TITLE="Timing Data Monitor^CPRS Coversheet^Load Time (Sec)^Hour"
 ;
 D EN^KMPDUG("KMPUTMP",TITLE,"DV","","TXT",1,40)
 ;
 Q
 ;
EXIT ;-- cleanup on exit
 D ^%ZISC
 Q
