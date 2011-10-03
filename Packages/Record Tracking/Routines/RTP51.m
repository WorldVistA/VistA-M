RTP51 ;MJK/TROY ISC;Clinic Pull List; ; 5/7/87  12:22 PM ;
 ;;v 2.0;Record Tracking;;10/22/91 
 ;
PRT D:($Y+3+^TMP($J,"RT",RT))>IOSL @RTHD Q:$D(RTESC)
 S Y=$P(RT0,"^") D NAME^RTB S RTCNME=Y,(RTTD,RTWARD)="" I $P(RT0,"^")[";DPT(" S:$D(^DPT(+RT0,.1)) RTWARD=$E($P(^(.1),"^"),1,20) S:$D(^(0)) X=$P(^(0),"^",9),RTTD=$E(X,6,10)
 S RTYPE=$S($D(^DIC(195.2,+$P(RT0,"^",3),0)):$P(^(0),"^",2),1:"???")_$P(RT0,"^",7)
 S Y=$S($D(^RT(RT,"CL")):+$P(^("CL"),"^",5),1:0) D BOR^RTB S RTCLOC=Y
 S Y=+$P(RTQ0,"^",5) D BOR^RTB S RTQNME=Y,Y=$P($P(RTQ0,"^",4),".",2)_"0000",RTQTIME=$E(Y,1,2)_":"_$E(Y,3,4),Y=$P(RTQ0,"^",6),C=$P(^DD(190.1,6,0),"^",2) D Y^DIQ S RTQST=Y
 I RTLNME'="",RTLNME'=RTCNME D LINE^RTUTL3
 W ! W:RTLNME'=RTCNME RTTD,?5,$E(RTCNME,1,20) W:RTL'=RT ?27,RTYPE W ?33,$J(RTQ,8),?42,$E(RTQST,1,12),?55,$E(RTQNME,1,15),?72,RTQTIME,?82,$E(RTCLOC,1,18)
 S RTC=0 I RTL'=RT F RTQDT=0:0 S RTQDT=$O(^TMP($J,"RT",RT,RTQDT)) Q:'RTQDT  F Q=0:0 S Q=$O(^TMP($J,"RT",RT,RTQDT,Q)) Q:'Q  I RTQ'=Q S Q0=^(Q) W:RTC ! D PRTCHK:RTC=1 S RTC=RTC+1 D PRT0
 D PRTCHK:'RTC I "CT"[RTSORT,RTLIST="A" S $P(^RTV(190.1,RTQ,0),"^",13)=RTRDT
 S RTL=RT,RTLNME=RTCNME K RTWARD,Q,Q0,RTQDT Q
 ;
PRT0 S Y=$P(Q0,"^",5) D BOR^RTB S X=$P($P(Q0,"^",4),".",2)_"0000" W ?105,$E(Y,1,20),?127,$E(X,1,2)_":"_$E(X,3,4) Q
 ;
PRTCHK I RTWARD']"",$P(RTQ0,"^",6)'="x" Q
 W:'RTC ! W $S($P(RTQ0,"^",6)="x":"[*** CANCELLED ***]",1:""),?67,$S(RTWARD]"":"[Current Ward: "_RTWARD_"]",1:"") Q
 ;
HD ;
 K RTESC I RTPAGE,$E(IOST,1,2)="C-" D ESC^RTRD Q:$D(RTESC)
 S RTPAGE=RTPAGE+1,Y=RTRDT D D^DIQ
 W @IOF,!,"Record Pull List",$S(RTLIST="U":" [UPDATE ONLY]",RTLIST="N":" [NOT FILLABLE REQUESTS]",1:"")," - ",$P($P(RTAPL,"^"),";",2),?103,"Page    : ",RTPAGE,!,"[Institution : ",$P(^DIC(4,RTDV,0),"^"),"]",?103,"Run Date: ",Y
 W !,"[Sorted by: ",$S(RTSORT="C":"Clinic and Terminal Digits",RTSORT="A":"Clinic and Appointment Time",$D(RTTDFL):"Terminal Digits",1:"Name"),"]" S Y=RTDT D D^DIQ W ?97,"Requested Date: ",Y
 W !!?5,"Name",?27,"Type",?33,"Request#",?42,"Status",?55,"Requestor",?72,"Time",?82,"Current Location",?105,"Other Requests for Record:" D LINE^RTUTL3
 Q
HDPULL ;
 Q:RTPNME="TDIGITS"  W !?5,"[Record Request Pull List for ",RTPNME,$S(RTLIST="U":" *** UPDATE ONLY ***",RTLIST="N":" *** REQUESTS NOT FILLABLE ONLY ***",1:""),"]"
 I $D(^TMP($J,"RTNEED",RTPNME)),^(RTPNME)]"" S Y=$P(^(RTPNME),"^",6),C=$P(^DD(194.2,6,0),"^",2) D Y^DIQ W "     [Pull List Status: ",Y,"]"
 W ! Q:'$D(RTPULL)  Q:'$D(^RTV(194.2,+RTPULL,1))  W !!?5,"COMMENT: "
 S DIWL=15,DIWF="WC120",RTC=0 F RTC1=0:0 S RTC1=$O(^RTV(194.2,RTPULL,1,RTC1)) Q:'RTC1  I $D(^(RTC1,0)) S X=^(0),RTC=1 D ^DIWP
 D ^DIWW:RTC K RTC,RTC1 Q
 ;
