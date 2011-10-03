RTT3 ;MJK/TROY ISC;Record Transaction Selection Utility; ; 5/18/87  9:44 AM ;
 ;;v 2.0;Record Tracking;;10/22/91 
 ;
SEL S DIC("S")="I $P(^(0),U,4)=+RTAPL,$S('$D(RTTY):1,$P(^RT(+Y,0),U,3)=+RTTY:1,1:0)",Y=$P(RTMV0,"^")
 S:Y["CHECK-IN" DIC("S")=DIC("S")_",$D(^DIC(195.2,""AF"","_RTB_",+$P(^RT(+Y,0),U,3)))"
 I $D(RTINACFL),'RTINACFL S DIC("S")=DIC("S")_",$S('$D(^(""I"")):0,'^(""I""):0,DT>^(""I""):1,1:0)"
 I $D(RTINACFL),RTINACFL S DIC("S")=DIC("S")_",$S('$D(^(""I"")):1,'^(""I""):1,DT'>^(""I""):1,1:0)"
 K RTESC,RTBCIFN,RTDEL R !!,"Select Record: ",X:DTIME D HELP:$E(X)="?" G SEL:'$D(X),SELQ:X=""!(X["^") S:$E(X)="-" (RTPROV,RTDEL)="",X=$E(X,2,99)
 S RTSEL="SDO",DIC(0)="IEMQ" K RTY D RT^RTDPA
 I $P(RTMV0,"^")'["RE-CHARGE",$D(RTY),RTC=1,$D(RTFR),$S('$D(RTBCIFN):1,1:RTBCIFN="n"),'$D(RTDEL) S RT=RTY(1) D BC^RTT4 G SEL:$D(RTESC)
 I $D(RTY) D ASSCO^RTDPA3:'$D(RTDEL) F RTY=0:0 S RTY=$O(RTY(RTY)) Q:'RTY  S RT=+RTY(RTY) D CHK:'$D(RTDEL) I $D(RT) S Y("M")=$P(RTMV0,"^",2),Y=RT_"^"_$S($D(RTPROV):RTPROV,1:"")_"^"_$S($D(RTBCIFN):RTBCIFN,1:"n") D ARRAY1^RTUTL1 K RTBCIFN
 K Y,RTZ,RTY,RT G SEL
SELQ I X["^",RTN S Y=$P(RTMV0,"^",2) D ASK I $E(X)'="Y" S RTJST=1 G SELQ1
 K RTN1 D QUE^RTT4:RTN>$P(RTSYS,"^",2) G SELQ1:'RTN!(RTN>$P(RTSYS,"^",2)) W !!,RTN," Selected record",$S(RTN>1:"s",1:"")," will now be ",$P(RTMV0,"^",2),"..."
 K DIC S RTN1=RTN F RTN=0:0 S RTN=$O(^TMP($J,"RT","AR",RTN)) Q:'RTN  S Y=^(RTN) D PARSE^RTT W "."
 S RTN=RTN1
SELQ1 I $D(RTN1) W !?3,RTN1," ...record",$S(RTN1>1:"s have",1:" has")," been ",$S(RTN1>$P(RTSYS,"^",2):"QUEUED to be ",1:""),$P(RTMV0,"^",2) S Y=RTB D BOR^RTB W " to '",Y,"'."
 K RTESC,RTBCIFN,RTPROVFL,RTPROV,DIC,RTN1,RTY,RTC,RTE,RT,RTDEL,RTSEL Q
 ;
HELP Q:'RTN  S X="Y",RTLC=4,RTIOSL=$S('$D(IOSL):24,'IOSL:24,1:IOSL)
 W !!,"Records selected to be ",$P(RTMV0,"^",2),":",!,"Record #",?10,"Name",?40,"Record Type",?65,"Vol",!,"--------",?10,"----",?40,"-----------",?65,"---"
 F N=0:0 S N=$O(^TMP($J,"RT","AR",N)) Q:'N  S Y=+^(N) D SHOW Q:X'="Y"
 D DEL:X="Y",MORE^RTB2:X="Y"&(RTLC>1) S X=$S($E(X)="Y":"?",1:"") K:X'="?" X K RTLC,RTIOSL,N,RT,E,T,S,V,Y Q
SHOW G SHOWQ:'$D(^RT(Y,0)) W !?3,Y S X=^(0),T=$S($D(^DIC(195.2,+$P(X,"^",3),0)):$P(^(0),"^"),1:"UNKNOWN"),V=+$P(X,"^",7),E=$P(X,"^"),S="",Y=E D NAME^RTB I $P(E,";",2)="DPT(",$D(^DPT(+E,0)) S S=$E($P(^(0),"^",9),6,10)
 W ?10,$E(Y,1,20),?31,S,?40,$E(T,1,20),?65,V S RTLC=RTLC+1
SHOWQ S X="Y" Q:RTLC'>RTIOSL  D MORE^RTB2 S RTLC=1,X=$E(X) Q
 ;
CHK S RTZ("RT")=RT D CHKIN^RTT4:$P(RTMV0,"^")["CHECK-IN",MISS1^RTQ1
 I '$D(RT),$S('$D(^DIC(195.2,+$P(^RT(RTZ("RT"),0),"^",3),0)):1,1:$P(^(0),"^",7)'="a"),'$D(^XUSEC($S($P(RTAPL,"^",8)]"":$P(RTAPL,"^",8),1:"RTZ XXX"),DUZ)) S RT=RTZ("RT") K RTZ D BULL^RTT2 K RT Q
 I '$D(RT) S RT=RTZ("RT"),RTZ1="RTB^RTMV^RTMV0" D SAVE^RTUTL1,FND^RTT2,RESTORE^RTUTL1 K:$S('$D(^RTV(195.9,+$P(^RT(RT,"CL"),"^",5),0)):0,$P(^(0),"^")="2;DIC(195.4,":1,1:0) RT Q
 G PND:'$D(^RT(RT,"CL")),PND:$P(^("CL"),"^",5)'=RTB S Y=$S($D(^DIC(195.3,+$P(^("CL"),"^",8),0)):$P(^(0),"^"),1:"") G PND:Y["FOUND RECORD"!(Y["INITIAL") S Y=$P(RTMV0,"^")
 I Y'["RE-ACTIVATE" D DEMOS^RTUTL1 W !,*7,RTD("N"),"'s ",RTD("T"),"is already charged to " K RTD S Y=+RTB D BOR^RTB W Y,"." D PND K RT Q
PND S Y=$P(RTMV0,"^") Q:Y'["CHARGE-OUT"&(Y'["CHECK-IN")  S RTSAVE="" D PND^RTT2 K RTSAVE Q
 ;
ASK S RTRD(1)="Yes^"_Y_" records",RTRD(2)="No^abort all processing",RTRD("B")=2,RTRD("A")="Do you still wish to '"_Y_"' selected records? ",RTRD(0)="S" D SET^RTRD K RTRD Q
 ;
DEL W !!?3,"Also, you can delete a selected record by entering a",!?3,"'minus' sign(-) before the record number (eg. Select Record: -342)." Q
 ;
