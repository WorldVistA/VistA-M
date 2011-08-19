RTRPT2 ;MJK,JSM/TROY ISC;Records Charged by Borrower Report;21 June 1986 ; 5/4/87  10:42 AM ;
 ;;v 2.0;Record Tracking;;10/22/91 
 W ! S DIC="^RTV(195.9,",DIC(0)="IAEMQ",DIC("S")="I $P(^(0),U,3)="_+RTAPL,DIC("A")="Select Borrower: " D ^DIC K DIC G Q:Y<0
 S RTB=+Y,RTVAR="RTAPL^RTB^"_$S($D(RTTY):"^RTTY",1:"")_$S($D(RTDC("S")):"^RTDC(""S"")",1:""),RTPGM="START^RTRPT2" D ZIS^RTUTL G Q:POP D START G RTRPT2
 ;
START U IO K ^TMP($J),RTS,RTC,RTC1,RTX S RTC1=0,U="^",RTPAGE=0
 F I=0:0 S I=$O(^RT("ABOR",RTB,I)) Q:'I  I $D(^RT(I,0)),$S('$D(RTTY):1,$P(^(0),"^",3)=+RTTY:1,1:0),$P(^(0),"^",4)=+RTAPL S (RT1,Y)=I X:$D(RTDC("S")) RTDC("S") D SORT:$T!('$D(RTDC("S")))
 D HD I RTC1 D REC I $D(RTASK),X'="^" D SELECT
 W:'RTC1 !!?3,"No '",$S($D(RTTY):$P($P(RTTY,"^"),";",2),1:$P($P(RTAPL,"^"),";",2)),"' records charged to this borrower."
 I $E(IOST,1,2)="C-",'$D(RTASK),$S('RTC1:1,1:RTLC>0),($Y+5)>IOSL W !!,"Press RETURN to continue: " R X:DTIME
Q K YSAV,RTVAR,RTPGM,RTPAGE,RTP,RTP1,RTASK,RTLC,RTB,RTTPH,RTC1,D,D1,T,V,O,I,^TMP($J) D CLOSE^RTUTL
 K X1,Y,DUOUT,RTS,SSN,X,RTC,RT1,P Q
SORT Q:'$D(^RT(I,0))  S (RT0,X)=^(0),V=999-$P(X,"^",7),O=$S($D(^DIC(195.2,+$P(X,"^",3),0)):+$P(^(0),"^",4),1:0) G SORTQ:'O S RTT0=^(0)
 S RTCL=$S($D(^RT(I,"CL")):^("CL"),1:"") D OVER1^RTUTL1 S RTOVER=X S Y=$E($P(RTCL,"^",6),1,12) D D^DIQ S D=Y
 S Y=$P(RT0,"^") I Y["DPT" S SSN=$E($P(^DPT(+Y,0),"^",9),6,9)
 D NAME^RTB S ^TMP($J,O,Y,V)=I_"^"_$P(RTT0,"^")_"^"_(999-V)_"^"_SSN_"^"_Y_"^"_D_"^"_RTOVER,RTC1=RTC1+1 W:$D(RTASK) "."
SORTQ K RT0,RTT0,RTCL,RTOVER,O,V,T,D,SSN Q
 ;
REC S RTC=0 F O=0:0 S O=$O(^TMP($J,O)) Q:'O  D LINE^RTUTL3:RTC S RTP="%" F RTP1=0:0 S RTP=$O(^TMP($J,O,RTP)) Q:RTP=""  S SSN=0 D VOL G RECQ:X="^"
RECQ Q
 ;
VOL F V=0:0 S V=$O(^TMP($J,O,RTP,V)) Q:'V  S X=^(V),RTC=RTC+1 S:$D(RTASK) RTS(RTC)=+X D PRT Q:X="^"
 Q
 ;
 ;
PRT S RTLC=RTLC+1 W !,$S($D(RTASK):RTC,1:""),?1,$E($P(X,"^",2),1,16),?18,"V",$P(X,"^",3),?23,$S('SSN:$P(X,"^",4),1:""),?28,$E($P(X,"^",5),1,19),?53,$P(X,"^",6),?72,$J($P(X,"^",7),5) S RTHD="HD",SSN=1 D PRT1 K RTHD Q
 ;
PRT1 I $D(^RTV(190.2,"AM","s",+X)) D FND^RTUTL1 S RTLC=RTLC+1
 Q:IOSL>(RTLC+5)  I $D(RTASK) Q:RTC'<RTC1  D SELECT S RTLC=0 W ! Q
 S X="" I $E(IOST,1,2)="C-" W !!,"Press RETURN to continue or '^' to stop: " R X:DTIME S SSN=0 S:'$T X="^"
 D:X'="^" @RTHD Q
 ;
HD S X="**** "_$S($D(RTTY):$P($P(RTTY,"^"),";",2),1:$P($P(RTAPL,"^"),";",2)_" Folders")_" Currently Charged to Borrower ****" D HD1
 W !!?3,"Record Type",?18,"Vol",?23,$S($P(RTAPL,"^",9)["Patient":"SSN",1:""),?29,$S($P(RTAPL,"^",9)]"":$P(RTAPL,"^",9),1:"???"),?53,"Charged Since...",?72,"Overdue"
 W !?3,"-----------",?18,"---",?23,"---------------------------",?53,"-----------------",?74,"----"
 S RTLC=$Y Q
 ;
HD1 W @IOF,?(IOM-$L(X))/2,X S X="" D EQUALS^RTUTL3 S RTPAGE=RTPAGE+1,Y=RTB D BOR^RTB S P=$S($D(^RTV(195.9,RTB,0)):$P(^(0),"^",7),1:"")
 W !,"Borrower      : ",Y,?55,"Page: ",RTPAGE,!,"Phone/Location: ",P D NOW^%DTC S Y=$E(%,1,11) D D^DIQ W ?51,"Run Date: ",Y D EQUALS^RTUTL3 Q
 ;
SELECT S RTRD("A")="Choose: " S RTZ("RTC")=RTC D SEL^RTRD K RTRD I RTC S X="^" K RTZ Q
 S RTC=RTZ("RTC") K RTZ Q
