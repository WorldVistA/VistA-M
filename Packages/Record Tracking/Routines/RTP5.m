RTP5 ;MJK/TROY ISC;Clinic Pull List for Other Institution; ; 5/7/87  12:36 PM ;
 ;;v 2.0;Record Tracking;;10/22/91 
 S Y=+$O(^DIC(195.1,+RTAPL,"INST",0)) I '$O(^(Y)) W !!?5,*7,"...this application only has one institution defined." G Q
 K RTDV,RTDT S RTHD="HD^RTP5",RTPAGE=0 D DIV^RTP4 G Q:'$D(RTDV) S X=$P(^DIC(195.1,+RTAPL,"INST",RTDV,0),"^",3),RTDVS=$S(X="c":2,X="a":3,1:1)
 S RTRD(1)="Send only^list records to be 'sent' to other institutions",RTRD(2)="Receive only^list records to be 'received' from other institutions",RTRD(3)="Both^print both the 'send' and 'receive' lists",RTRD("B")=3,RTRD(0)="S"
 S RTRD("A")="Which list do you want to print? " D SET^RTRD K RTRD S X=$E(X) G Q:X="^" S:X="B" X="SR" S RTLIST=X
RTDT W ! S %DT="EAFX",%DT("A")="Select Date: " D ^%DT K %DT G Q:Y<0 I Y>0 S RTDT=Y,RTMES="SEARCHED" D SHOW^RTP41 K RTMES I 'RTC K RTDT G RTDT
 W ! S RTDESC="Clinic Pull List(other institution) ["_$P($P(RTAPL,"^"),";",2)_"]",RTVAR="RTDV^RTAPL^RTDT^RTLIST^RTPAGE",RTPGM="START^RTP5" D ZIS^RTUTL G Q:POP
 ;
START U IO K ^TMP($J) D NOW^%DTC S RTRDT=%,RTBEG=RTDT-.0001,RTSORT=""
 F RTDTE=RTBEG:0 S RTDTE=$O(^RTV(194.2,"C",RTDTE)) Q:RTDT<$P(RTDTE,".")!('RTDTE)  F RTP=0:0 S RTP=$O(^RTV(194.2,"C",RTDTE,RTP)) Q:'RTP  I $D(^RTV(194.2,RTP,0)) S X=^(0) I $P(X,"^",10)=1,$S(RTLIST="N":1,1:$P(X,"^",6)'="x") D PULL
 F RTLIST1="S","R" I RTLIST[RTLIST1 S RTAUX=$S(RTLIST1="S":"RTSEND",1:"RTRECV") D NOT:'$D(^TMP($J,RTAUX)) G Q:$D(RTESC) I $D(RTLIST1) F RTDIVZ=0:0 S RTDIVZ=$O(^TMP($J,RTAUX,RTDIVZ)) Q:'RTDIVZ  D HD,DIGIT G Q:$D(RTESC)
Q K RTSORT,RT,RT0,RTAUX,RTB,RTBEG,RTC,RTCDV,RTDESC,RTDIGIT,RTDIVZ,RTDT,RTDTE,RTDV,RTDVS,RTESC,RTHD,RTINST,RTL,RTLIST,RTLIST1,RTLNME,RTP,RTP0,RTPAGE,RTPDT,RTPDV,RTPGM,RTPNME,RTQ,RTQ0,RTQDT,RTQST,RTRDT,RTTDX,RTVAR,Y
 K RTCLOC,RTCNME,RTDEV,RTQNME,RTQTIME,RTTD,RTYPE,^TMP($J) D CLOSE^RTUTL Q
 ;
 ;
DIGIT W !!?5,"[",$S(RTLIST1="S":"SEND",1:"RECEIVE")," these records ",$S(RTLIST1="S":"to",1:"from")," '",$S($D(^DIC(4,RTDIVZ,0)):$P(^(0),"^"),1:"UNKNOWN"),"']",!
 S (RTLNME,RTCNME,RTL,RTDIGIT)="" F RTTDX=0:0 S RTDIGIT=$O(^TMP($J,RTAUX,RTDIVZ,RTDIGIT)) Q:RTDIGIT=""  D RTQ Q:$D(RTESC)
 Q
 ;
RTQ F RTQ=0:0 S RTQ=$O(^TMP($J,RTAUX,RTDIVZ,RTDIGIT,RTQ)) Q:'RTQ  S RTQ0=^(RTQ),RT=+RTQ0,RT0=^RT(RT,0) D PRT^RTP51 G RTQQ:$D(RTESC)
RTQQ Q
 ;
NOT D HD Q:$D(RTESC)  W !!?5,"...no records need to be '",$S(RTLIST1="S":"SENT TO",1:"RECEIVED FROM"),"' other institutions." Q
 ;
PULL Q:'$D(^RTV(194.2,RTP,0))  S RTP0=^(0) I $P(RTP0,"^",15)=+RTAPL S RTPDV=+$P(RTP0,"^",12),RTPDT=+$P(RTP0,"^",2),RTB=+$P(RTP0,"^",5),Y=RTB D BOR^RTB S RTPNME=Y D RTQX
 Q
 ;
RTQX F RTQ=0:0 S RTQ=$O(^RTV(190.1,"AP",RTP,RTQ)) Q:'RTQ  I $D(^RTV(190.1,RTQ,0)) S RTQ0=^(0) I $P(RTQ0,"^",5)=RTB S RTQST=$P(RTQ0,"^",6),RTQDT=+$P(RTQ0,"^",4) I $D(^RT(+RTQ0,0)) S RT=+RTQ0,RT0=^(0) D RT
 Q
 ;
RT K RTINST,RTCDV S X=$S($D(^RT(RT,"CL")):$P(^("CL"),"^",5),1:""),A=+RTAPL D INST1^RTUTL:X Q:'$D(RTINST)  S RTCDV=RTINST K RTINST
 S T=9999 I $P(RT0,"^")[";DPT(",$D(^DPT(+RT0,0)) S T=$P(^(0),"^",9),T="A"_$E(T,8,9)_$E(T,6,7)
 I RTDV'=RTPDV,RTDV=RTCDV S ^TMP($J,"RTSEND",RTPDV,T,RTQ)=RTQ0
 I RTDV=RTPDV,RTDV'=RTCDV S ^TMP($J,"RTRECV",RTCDV,T,RTQ)=RTQ0
 D BLD^RTP3 Q
 ;
HD ;
 K RTESC I RTPAGE,$E(IOST,1,2)="C-" D ESC^RTRD Q:$D(RTESC)
 S RTPAGE=RTPAGE+1,Y=RTRDT D D^DIQ
 W @IOF,!,"Special Multi-Institution Record Pull List",$S(RTLIST1="S":"  [SEND ONLY]",1:" [RECEIVE ONLY]")," - ",$P($P(RTAPL,"^"),";",2),?103,"Page    : ",RTPAGE,!,"[Institution : ",$P(^DIC(4,RTDV,0),"^"),"]",?103,"Run Date: ",Y
 W !,"[Sorted by: Terminal Digits]" S Y=RTDT D D^DIQ W ?97,"Requested Date: ",Y
 W !!?5,"Name",?27,"Type",?33,"Request#",?42,"Status",?55,"Requestor",?72,"Time",?82,"Current Location",?105,"Other Requests for Record:" D LINE^RTUTL3
 Q
 ;
