RTRPT1 ;MJK/TROY ISC;Borrower Request Report; ; 5/5/87  8:31 AM ;
 ;;v 2.0;Record Tracking;;10/22/91 
 W ! S DIC="^RTV(195.9,",DIC(0)="IAEMQ",DIC("S")="I $P(^(0),U,3)="_+RTAPL,DIC("A")="Select Borrower: " D ^DIC K DIC G Q:Y<0
 S RTB=+Y,RTVAR="RTAPL^RTB"_$S($D(RTTY):"^RTTY",1:"")_$S($D(RTQDC("S")):"^RTQDC(""S"")",1:""),RTPGM="START^RTRPT1" D ZIS^RTUTL G Q:POP D START G RTRPT1
 ;
START U IO K ^TMP($J),RTS,RTC,RTC1,RTX S RTC1=0,U="^",RTPAGE=0,RTPCE=9 D WINDOW^RTRPT K RTPCE
 F I=0:0 S I=$O(^RTV(190.1,"ABOR",RTB,I)) Q:'I  I $D(^RTV(190.1,I,0)),$D(^RT(+^(0),0)),$S('$D(RTTY):1,$P(^(0),"^",3)=+RTTY:1,1:0),$P(^(0),"^",4)=+RTAPL S I1=+^RTV(190.1,I,0) D SORT
 D HD I RTC1 D REC I $D(RTASK),X'="^" D SELECT^RTRPT2
 W:'RTC1 !!?3,"No '",$S($D(RTTY):$P($P(RTTY,"^"),";",2),1:$P($P(RTAPL,"^"),";",2)),"' requests pending for this borrower."
 I $E(IOST,1,2)="C-",'$D(RTASK),$S('RTC1:1,1:RTLC>0),($Y+5)>IOSL W !!,"Press RETURN to continue: " R X:DTIME
Q K RTPGM,RTVAR,RTPAGE,B1,RTP,RTP1,RTASK,RTLC,RTB,RTTPH,RTC1,D,D1,T,V,O,I,^TMP($J) D CLOSE^RTUTL Q
 ;
SORT I $D(RTQDC("S")) S Y=I,X=^RTV(190.1,I,0) X RTQDC("S") Q:'$T
 Q:'$D(^RT(I1,0))  S V=999-$P(^(0),"^",7),O=$S($D(^DIC(195.2,+$P(^(0),"^",3),0)):+$P(^(0),"^",4),1:0) Q:'O  S RT=I1 D DEMOS^RTUTL1 K RT
 S B1="" I $D(^RTV(195.9,+$P(X,"^",14),0)) S Y=$P(^(0),"^") D NAME^RTB S B1=Y
 S ^TMP($J,O,RTD("N"),V,+$P(X,"^",4))=I_"^"_$P(RTD("T")," (V",1)_"^"_(999-V)_"^"_RTD("N")_"^"_$S($P(X,"^",10):"*",1:"")_"^"_B1
 S RTC1=RTC1+1 W:$D(RTASK) "." K RTD Q
 ;
REC S RTC=0 F O=0:0 S O=$O(^TMP($J,O)) Q:'O  D LINE^RTUTL3:RTC S RTP="%" F RTP1=0:0 S RTP=$O(^TMP($J,O,RTP)) Q:RTP=""  D VOL G RECQ:X="^"
RECQ Q
 ;
VOL F V=0:0 S V=$O(^TMP($J,O,RTP,V)) Q:'V  F D=0:0 S D=$O(^TMP($J,O,RTP,V,D)) Q:'D  S X=^(D),RTC=RTC+1,RTS(RTC)=+X D PRT Q:X="^"
 Q
 ;
PRT S RTLC=RTLC+1 W !,RTC,?3,$E($P(X,"^",2),1,19),?21,"V",$P(X,"^",3),?26,$E($P(X,"^",4),1,18),?44,$P(X,"^",5) S Y=D D D^DIQ W ?45,Y,?65,$E($P(X,"^",6),1,15)
 I $D(^RTV(190.1,+X,"COMMENT")) S RTLC=RTLC+1 W !?3,"(Comment: ",^("COMMENT"),")"
 S X=^RT(+^RTV(190.1,+X,0),0),RTHD="HD^RTRPT1" D PRT1^RTRPT2 K RTHD Q
 ;
HD S X="**** "_$S($D(RTTY):$P($P(RTTY,"^"),";",2),1:$P($P(RTAPL,"^"),";",2))_" Requests Pending for Borrower ****" D HD1^RTRPT2
 W !,"* - indicates request is part of a pull list"
 W !!?3,"Record Type",?21,"Vol",?26,$S($P(RTAPL,"^",9)]"":$P(RTAPL,"^",9),1:"???"),?45,"Date/Time Needed",?65,"Associated Reqr"
 W !?3,"-----------",?21,"---",?26,"------------------",?45,"-------------------",?65,"---------------"
 S RTLC=$Y Q
 ;
PEND ;Entry point for pending request only
 S RTQDC("S")="S Z=^(0) I $P(Z,U,6)=""r""!($P(Z,U,6)=""n""),$D(^RT(+Z,0)),$D(RTWND(+$P(^(0),U,3))),RTWND(+$P(^(0),U,3))'>$P(Z,U,4)" D RTRPT1 K RTQDC,RTWND
 K N,P,RTC,RTS,IO("Q"),SSN,X,Y,I1,DUOUT Q
