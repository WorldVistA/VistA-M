RTNQ3 ;MJK/TROY ISC;Combined Data Trace; ; 5/20/87  4:35 PM ;
 ;;v 2.0;Record Tracking;;10/22/91 
 I '$D(RTAPL) D APL2^RTPSET D NEXT:$D(RTAPL) K RTAPL,RTSYS Q
NEXT D PT^RTUTL3 G Q:Y<0
 S %DT="AEPX",%DT(0)="-NOW",%DT("B")="T-100",%DT("A")="Trace Cut-off Date: " D ^%DT K %DT G Q:Y<0 S RTDT=Y-.0001
 S RTPGM="START^RTNQ3",RTVAR="RTE^RTDT^DFN^RTAPL" D ZIS^RTUTL G Q:POP D START G NEXT
 ;
START U IO S RTESC="",RTPAGE=0 K R,^TMP($J,"RTCOMBO") S R="" I '$D(IOSL)!('$D(IOF)) S IOP="" D ^%ZIS K IOP
 S A=+RTAPL F RT=0:0 S RT=$O(^RT("AA",A,RTE,RT)) Q:'RT  I $D(^RT(RT,0)) S Y=^(0) D REC F RTH=0:0 S RTH=$O(^RTV(190.3,"B",RT,RTH)) Q:'RTH  I $D(^RTV(190.3,RTH,0)) S Y=^(0) D HIS:$P(Y,"^",6)'<RTDT
 F S=RTDT:0 S S=$O(^DPT(DFN,"S",S)) Q:'S  I $D(^(S,0)),$P(^(0),U,2)'["C" S D=9999999.9999-S,Y=$E($S($D(^SC(+^(0),0)):$P(^(0),"^"),1:"UNKNOWN"),1,19),P=2 D SET
 S RTDTI=9999999.9999-RTDT
 F A=0:0 S A=$O(^DGPM("APID",DFN,A)) Q:'A!(A>RTDTI)  S DGPMDA=+$O(^(A,0)) I $D(^DGPM(DGPMDA,0)) S Y=^(0),TT=$P(Y,"^",2) I TT,TT<4 D DIS:TT=3,MVT
 D HD I $D(R)<11,'$D(^TMP($J,"RTCOMBO")) W !!?5,"No activity for period." G Q
 K RTFL S RTFUT=1,RTG="S RTI=$O("_$S($D(R):"R(RTI)",1:"^TMP($J,""RTCOMBO"",RTI)")_")"
 S RTG1="S RTI1=$O("_$S($D(R):"R(RTI,RTI1)",1:"^TMP($J,""RTCOMBO"",RTI,RTI1)")_")"
 F RTI=0:0 X RTG Q:'RTI  F RTI1=0:0 X RTG1 Q:'RTI1  D LIST G Q:RTESC="^"
Q K RTFUT,RTPAGE,RTESC,RTE,RTFL,RTDTI,A1,A,S,RTVAR,RTPGM,RTDT,R,RT,M,P,DFN,RTG,RTH,RTI,T,V,^TMP($J,"RTCOMBO") D CLOSE^RTUTL
 K DUOUT,C,I,X,Y,RTG1,%,%H,%I,N,POP,RTI1,DGPMDA,TT Q
LIST ;
 D HD:($Y+5)>IOSL Q:RTESC="^"  S Y=$E(9999999.9999-RTI,1,12) D FUT:$P(Y,".")'>DT&(RTFUT),D^DIQ S D=Y,RTFL="",Y=$S($D(R):R(RTI,RTI1),1:^TMP($J,"RTCOMBO",RTI,RTI1)) W !,D,?20,$P(Y,"^"),?40,$P(Y,"^",2),?60,$P(Y,"^",3) Q
SET D DUMP:$S<2000 I $D(R) F I=1:1 S:'$D(R(D,I)) R(D,I)="" I $P(R(D,I),"^",P)="" S $P(R(D,I),"^",P)=Y Q
 Q:$D(R)  F I=1:1 S:'$D(^TMP($J,"RTCOMBO",D,I)) ^TMP($J,"RTCOMBO",D,I)="" I $P(^TMP($J,"RTCOMBO",D,I),"^",P)="" S $P(^TMP($J,"RTCOMBO",D,I),"^",P)=Y Q
 Q
 ;
REC S V=$S('$D(^DIC(195.2,+$P(Y,"^",3),0)):"UNKNOWN",1:$P(^(0),"^",2))_+$P(Y,"^",7) Q
 ;
HIS S D=9999999.9999-$P(Y,"^",6),Y=$P(Y,"^",5) D BOR^RTB S Y=Y_"             ",Y=$E(Y,1,14)_";"_V,P=1 D SET Q
 ;
MVT ; --  set up vars for mvt entry ; Y = 0th node of mvt
 I TT=2,$P(Y,"^",18)'=4 G MVTQ ; must be interward tfr
 S D=9999999.9999-Y
 S Y=$S($D(^DIC(42,+$P(Y,"^",6),0)):$P(^(0),"^"),1:"UNKNOWN")_"                "
 S Y=$E(Y,1,14)_";"_$P("adm^tfr^dis","^",TT),P=3 D SET
MVTQ K D Q
 ;
DIS ; -- find last ward before d/c ; Y = 0th node of mvt
 S CA=$P(Y,"^",14)
 F IDT=0:0 S IDT=$O(^DGPM("APMV",DFN,CA,IDT)) Q:'IDT  F MVT=0:0 S MVT=$O(^DGPM("APMV",DFN,CA,IDT,MVT)) Q:'MVT  I $D(^DGPM(MVT,0)),$P(^(0),"^",6) S $P(Y,"^",6)=$P(^(0),"^",6) G DISQ
DISQ K CA,MVT,IDT Q
 ;
HD S RTESC="" I RTPAGE,IOST["C-" R !!,"Press RETURN to continue or '^' to stop: ",RTESC:DTIME S:'$T RTESC="^" Q:RTESC["^"
 S RTPAGE=RTPAGE+1,X1="ADT,Scheduling and Tracking Data Trace Report ("_$P($P(RTAPL,"^"),";",2)_")" D PTHD^RTUTL2,EQUALS^RTUTL3
 S Y=RTDT+.0001 D D^DIQ W !,"[Report compiled with data on activities back to ",Y,"]"
 W !,"Date/Time",?20,"Record Location",?40,"Clinic Name",?60,"Ward;Action" D LINE^RTUTL3
 Q
 ;
DUMP F I=0:0 S I=$O(R(I)) Q:'I  F I1=0:0 S I1=$O(R(I,I1)) Q:'I1  S ^TMP($J,"RTCOMBO",I,I1)=R(I,I1)
 K R Q
 ;
FUT S RTFUT=0 Q:'$D(RTFL)  D EQUALS^RTUTL3 W !?20,"ABOVE THIS LINE ARE 'FUTURE' ACTIVITIES" D EQUALS^RTUTL3 Q
