RTP2 ;MJK/TROY ISC;Pull List Option; ; 2/26/87  1:48 PM ;
 ;;v 2.0;Record Tracking;;10/22/91 
ADD K DICS,RTKILL S X=^RTV(194.2,RTPULL,0),RTB=$P(X,"^",5),RTQDT=$P(X,"^",2),RTSEL=$S($P(X,"^",11)]"":$P(X,"^",11)_"DO",1:"S"),RTN=0,Y=+$P(X,"^",4) I $D(RTTY),Y'=+RTTY G SELQ1
 I '$D(RTTY),$D(^DIC(195.2,Y,0)) D TYPE1^RTUTL S RTKILLP=""
 S:$P(X,"^",12) RTINST=$P(X,"^",12) K ^TMP($J,"RT")
SEL K RTDEL R !!,"Select Record: ",X:DTIME D HELP:$E(X)="?" G SEL:'$D(X),SELQ:X["^"!(X="") S:$E(X)="-" RTDEL="",X=$E(X,2,99)
 S DIC("S")="I $S('$D(RTTY):1,$P(^(0),U,3)=+RTTY:1,1:0),$P(^(0),U,4)=+RTAPL,'$D(^RTV(190.1,""AP1"",RTPULL,+Y))",DIC(0)="IEQ" K RTY D RT^RTDPA I Y=-1&('$D(RTY)) W !,*7," no record selectable" G SEL
 F I0=0:0 S I0=$O(RTY(I0)) Q:'I0  S RT=+RTY(I0) D CHK:'$D(RTDEL) I $D(RT) S Y=RT D ARRAY1^RTUTL1
 K RTBCIFN,RT,I0 G SEL
SELQ I X["^",RTN S Y="request" D ASK^RTT3 G SELQ1:$E(X)'="Y"
 K RTN1 G SELQ1:'RTN W !!,"Will now request the records selected..."
 S RTN1=RTN F RTN=0:0 S RTN=$O(^TMP($J,"RT","AR",RTN)) Q:'RTN  S RT=+^(RTN) D SET^RTQ K RT
 W:$D(RTN1) !?6,"...request",$S(RTN1>1:"s",1:"")," filed."
SELQ1 K:$D(RTKILLP) RTTY,RTKILLP K RTN1,RTB,RTQDT,RTSEL,RTINST,RTQ,RTN,^TMP($J,"RT") Q
 ;
HELP S RTLC=4,RTIOSL=$S('$D(IOSL):24,'IOSL:24,1:IOSL) G HELP1:'RTN
 W !!,"Records selected to be requested during this session:",!?8,"Name",?35,"Record Type",?55,"Volume",!?8,"----",?35,"-----------",?55,"------"
 F N=0:0 S N=$O(^TMP($J,"RT","AR",N)) Q:'N  S Y=+^(N) D SHOW Q:X'="Y"
 D DEL^RTT3:X="Y",MORE^RTB2:X="Y"&(RTLC>1) S X=$S($E(X)="Y":"?",1:"") I X'="?" K X G HELPQ
HELP1 G HELPQ:'$D(^RTV(190.1,"AP",RTPULL))
 W !!,"Requests previously made for this pull list:",!,"Req #",?8,"Name",?35,"Record Type",?55,"Volume",?65,"Status",!,"-----",?8,"----",?35,"-----------",?55,"------",?65,"------"
 F RTQ=0:0 S RTQ=$O(^RTV(190.1,"AP",RTPULL,RTQ)) Q:'RTQ  I $D(^RTV(190.1,RTQ,0)) S Y=^(0) D SHOW Q:X'="Y"
 D MORE^RTB2:X="Y"&(RTLC>1) S X=$S($E(X)="Y":"?",1:"") K:X'="?" X
HELPQ K RTIOSL,RTLC,N,RTQ,E,S1,S,V,Y Q
SHOW G SHOWQ:'$D(^RT(+Y,0)) S E=$P(^(0),"^"),V=$P(^(0),"^",7),T=$S($D(^DIC(195.2,+$P(^(0),"^",3),0)):$P(^(0),"^"),1:"Unknown"),S=$P(Y,"^",6)
 S S1="" I $P(E,";",2)="DPT(",$D(^DPT(+E,0)) S S1=$E($P(^(0),"^",9),6,10)
 W !?1,$S($D(RTQ):RTQ,1:"") S Y=E D NAME^RTB W ?8,$E(Y,1,20),?29,S1,?35,T,?58,V I $D(RTQ) S Y=S,C=$P(^DD(190.1,6,0),"^",2) D Y^DIQ W ?65,$E(Y,1,15)
 S RTLC=RTLC+1
SHOWQ S X="Y" Q:RTLC'>RTIOSL  D MORE^RTB2 S RTLC=1,X=$E(X) Q
 ;
CHK I RTSEL["L" F I1=0:0 S I1=$O(^RTV(190.1,"AP",RTPULL,I1)) Q:'I1  I $D(^RTV(190.1,I1,0)),$D(^RT(+^(0),0)),$P(^(0),"^")=$P(^RT(RT,0),"^") S Y=$P(^RT(RT,0),"^") D NAME^RTB D CHK1 K:$E(X)="N" RT Q
 D MISS^RTQ1:$D(RT) Q
CHK1 W !!,"This will mean '",Y,"' will have multiple volumes on the list."
 S RTRD(0)="S",RTRD(1)="Yes^add to list",RTRD(2)="No^do not add to list",RTRD("B")=2,RTRD("A")="Do you want multiple volumes for this patient? " D SET^RTRD K RTRD Q
 ;
