RTREP ;JLU/TROY ISC RPW/BUF;RT Pull List Retrieval Rates; 2-19-87
 ;;v 2.0;Record Tracking;**25**;10/22/91 
0 S RT=0,DIR(0)="S^1:Date Range;2:One Day;3:Single Pull List",DIR("?",1)="1 Date Range         A range of days",DIR("?",2)="2 One Day            A single day"
 S DIR("?",3)="3 Single Pull List   Only one pull list",DIR("?")=" ^                   Stop"
 D ^DIR K DIR G:Y=U END
 S RTX=Y,RTX1=RTX G:(RTX=1)!(RTX=2)!(RTX=3) @RTX W !,"??",*7 G 0
1 ;Date Range
 D RTDSF G:Y=U END
10 W ! S %DT="AEX",%DT("A")="From Date: " D ^%DT G:Y<0 END S RTDT1=Y,%DT("A")="  To Date: " D ^%DT G:Y<0 END S RTDT2=Y
 I RTDT2<RTDT1 W !,*7,"ENDING 'to' date is before the STARTING 'from' date" G 10
 S ZTRTN="EN1^RTREP" D RTCOM1,RTCOM G:RT=1 END
EN1 D INITS,INITS1,HDR^RTREP1:RTDSF,INITS2^RTREP1:RTDSF
 F RTDT=RTDT1-.1:0 S RTDT=$O(^RTV(194.2,"C",RTDT)) Q:RTDT'>0!(RTDT>RTDT2)  D 11
 I 'RTDSF D PRNT^RTREP1 G END
 I RTDSS="D" D DPRT^RTREP1,PRNT^RTREP1 I 1
 E  D APRT^RTREP1,PRNT^RTREP1
 G END
 ;
11 F RTPLN=0:0 S RTPLN=$O(^RTV(194.2,"C",RTDT,RTPLN)) Q:RTPLN'>0  I $P(^RTV(194.2,RTPLN,0),U,6)'="x",$P(^(0),U,15)=+RTAPL D @$S('RTDSF:"RTLP^RTREP1",RTDSS="D":"DSORT",1:"ASORT")
 Q
 ;
2 ; One Date
 D RTDSF G:Y=U END S %DT="AEX" D ^%DT G:Y<0 END S RTDT1=Y
 S ZTRTN="EN2^RTREP" D RTCOM1,RTCOM G:RT=1 END
EN2 D INITS,INITS1,HDR^RTREP1:RTDSF,INITS2^RTREP1:RTDSF
 F RTPLN=0:0 S RTPLN=$O(^RTV(194.2,"C",RTDT1,RTPLN)) Q:RTPLN'>0  I $P(^RTV(194.2,RTPLN,0),U,6)'="x",$P(^(0),U,15)=+RTAPL D @$S('RTDSF:"RTLP^RTREP1",RTDSS="D":"DSORT",1:"ASORT")
 I 'RTDSF D PRNT^RTREP1 G END
 I RTDSS="D" D DPRT^RTREP1,PRNT^RTREP1 I 1
 E  D APRT^RTREP1,PRNT^RTREP1
 G END
 ;
3 ;One Pull List
 S RTDSF=1,DIC="^RTV(194.2,",DIC(0)="AEQM" D ^DIC G:Y<0 END S RTLN=$P(Y,U,2),RTPLN=+Y
 S ZTRTN="EN3^RTREP" D RTCOM1,RTCOM G:RT=1 END
EN3 D INITS1 W @IOF D INITS,HDR^RTREP1,INITS2^RTREP1,RTLP^RTREP1
 ;
END K %DT,%ZIS,RTSF,RTDT,RTDT2,RTDTT,RTI,RTINE,RTPAGE,RTPLN,RTRTN,RTST,RTX,DIC,RTNAM,RTXP,RTLN,RTX1,RTDSF,DIC,RTDT1,Y,ZTRTN,RTRD,X1,RT,^TMP($J),RTDSS,RTX3,RTNM,RTNM1,X,DUOUT,DIRUT,RTIST,RTIST1,RTNB,RTX2,RTXP2,RTP1
 D ^%ZISC
 K IO("Q"),ZTIO
 Q
ASORT ; Alpha Sort
 S ^TMP($J,$P(^RTV(194.2,RTPLN,0),U),RTPLN)=""
 Q
DSORT ; Division Sort
 S ^TMP($J,$P(^RTV(194.2,RTPLN,0),U,12),$P(^(0),U),RTPLN)=""
 Q
 ;Input Prompt
RTDSF S DIR(0)="S^D:Detailed;S:Summary",DIR("B")="Summary",DIR("A")="Type of Report",DIR("?")="Summary - Total of all pull lists,   Detailed - Totals for each pull list." D ^DIR K DIR S RTDSF=$S(Y="D":1,1:0)
 Q:Y'="D"
RTDSS S DIR(0)="S^D:Division;A:Alphabetic",DIR("B")="Alphabetic",DIR("A")="Sorted by",DIR("?")="Division - Groups of Divisions and subtotals,  Alphabetic -  Alphabetic list." D ^DIR K DIR S RTDSS=Y
 Q
 ;Initialize Variables
INITS F RTI=0,1,2 F RTX="c","x","r","n" S RTST(RTI,RTX)=0
 S RTINE="=" F RTI=1:1:IOM-2 S RTINE=RTINE_"="
 S U="^",RTPAGE=0,%DT="" D NOW^%DTC S Y=$E(%,1,12) D D^DIQ S RTDTT=Y K ^TMP($J)
 Q
INITS1 U IO K ZTSK Q
RTCOM I $D(IO("Q")) S ZTDESC="RT Retrievability Report",RT=1,ZTSAVE("RT*")="",ZTIO=ION_";"_IOST_";"_IOM_";"_IOSL D ^%ZTLOAD K IO("Q"),ZTSK,ZTRT
 Q
RTCOM1 S %ZIS="QM",%=0 D ^%ZIS I POP S RT=1 Q
QU I (RTDSF!(RTX1=3))&(IOM=80) W !,*7,?8,"Margin for Detailed usually 132 ",!,?8,"Are you sure 80 Y,N" D YN^DICN G RTCOM1:%=2
 Q
