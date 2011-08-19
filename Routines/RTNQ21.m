RTNQ21 ;TROY ISC/MJK-Record Inquiry Routine ; 5/4/87  10:00 AM ; 1/30/03 8:36am
 ;;2.0;Record Tracking;**32,33,36**;10/22/91 
 S RTFL="RTQ",RTUTL=0,RTPCE=9 D WINDOW^RTRPT K RTPCE,S,D,^TMP($J,"RTNQ"),RTL
 W:$E(IOST,1,2)="C-" !!?3,"...will now compile record request data"
 F RT=0:0 S RT=$O(RT(RT)) Q:'RT  S RT0=RT(RT) F RTDT=0:0 S RTDT=$O(^RTV(190.1,"AC",RT,RTDT)) Q:'RTDT  F RTQ=0:0 S RTQ=$O(^RTV(190.1,"AC",RT,RTDT,RTQ)) Q:'RTQ  D RTQ
 I '$D(^TMP($J,"RTNQ")) W !!,"No requests on file.",$S($E(IOST,1,2)="C-":" Press RETURN to continue.",1:"") R:$E(IOST,1,2)="C-" X:DTIME G Q
 K S,RTDT F S=0:0 S S=$O(RTL(S)) Q:'S  D @($S(($Y+8)>IOSL:"HD",'$D(RTDT):"HD1",1:"HD2")) G Q:RTESC="^" F RTDT=0:0 S RTDT=$O(RTL(S,RTDT)) Q:'RTDT  F I=0:0 S I=$O(RTL(S,RTDT,I)) Q:'I  D WRITE G Q:RTESC="^"
 ;
Q G Q^RTNQ2
 ;
HD D HD^RTNQ2 Q:RTESC="^"
HD1 W !?25,"**** RECORD REQUEST PROFILE ****",!,"Type",?6,"Requestor",?27,"Date Needed",?46,"Phone#",?55,"Requesting User",?72,"Req#",!,"----",?6,"---------",?27,"-----------",?46,"------",?55,"---------------",?72,"----"
HD2 W !,"[",$S(S=1:"Pending",S=2:"Filled",1:"Cancelled or Never Filled"),"]"
 I $D(S),$D(RTDT),RTDT W " ...continued"
 Q
 ;
RTQ Q:'$D(^RTV(190.1,RTQ,0))  S Y=^(0),T=+$P(RT0,"^",3),V=+$P(RT0,"^",7)
 S U1="" I $D(^VA(200,+$P(Y,"^",3),0)) S U1=$P(^(0),"^")
 S S=$P(Y,"^",6),S=$S(S="x":3,S="c":2,'$D(RTWND(T)):1,RTWND(T)'>$P(Y,"^",4):1,1:3)
 S D=$P(Y,"^",4),N=D_".00000",N=$TR($$FMTE^XLFDT($E(N,1,12),"5F")," /","0-")
 S (B,B("P"))="" I $D(^RTV(195.9,+$P(Y,"^",5),0)) S Y=^(0),B("P")=$P(Y,"^",8),Y=$P(Y,"^") D NAME^RTB S B=Y
 S (B1,B1("P"))="" I $D(^RTV(195.9,+$P(^RTV(190.1,RTQ,0),"^",14),0)) S Y=^(0),B1("P")=$S($P(Y,"^",8)'="":"("_$P(Y,"^",8)_")",1:""),Y=$P(Y,"^") D NAME^RTB S B1=$S(Y'="":"("_Y_")",1:"")
 S RTUTL=RTUTL+1 F I=1:1 I '$D(RTL(S,D,I)) S RTL(S,D,I)=RTUTL,^TMP($J,"RTNQ",RTUTL)=T_"^"_V_"^"_B_"^"_N_"^"_B("P")_"^"_U1_"^"_RTQ_"^"_B1_"^"_B1("P") Q
 K D,T,V,U1,B,B1,N,I,S,V Q
 ;
WRITE D HD:($Y+6)>IOSL Q:RTESC="^"  S Y=^TMP($J,"RTNQ",RTL(S,RTDT,I))
 W !,$P(RTO(+Y),"^",3),+$P(Y,"^",2),?6,$E($P(Y,"^",3),1,20),?27,$P(Y,"^",4),?46,$P(Y,"^",5),?55,$E($P(Y,"^",6),1,15),?72,+$P(Y,"^",7) I $P(Y,"^",8)'="" W !?6,$P(Y,"^",8),?46,$P(Y,"^",9)
 Q
 ;
