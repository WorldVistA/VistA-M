RTUTL4 ;MJK/TROY ISC;Select a Request Utility Routine; ; 5/8/87  10:35 AM ;
 ;;v 2.0;Record Tracking;;10/22/91 
 K R S X="AA",A=+RTAPL,E=RTE S:$D(RTTY) X="AT",V=+RTTY
 F R=0:0 S R=$O(^RT(X,A,E,R)) Q:'R  S R(R)=""
REC ;entry point to display requests for a record; R(R) and RTE defined
 S IOP="" D ^%ZIS K RTESC,IOP,RTL,Q D HD,TYPE^RTNQ2
 F R=0:0 S R=$O(R(R)) Q:'R  F Q=0:0 S Q=$O(^RTV(190.1,"B",R,Q)) Q:'Q  S Q(Q)=""
 I $D(Q)<11 W !?5,"No requests" G Q
 F Q=0:0 S Q=$O(Q(Q)) Q:'Q  I $D(^RTV(190.1,Q,0)) S Q0=^(0),Y=Q X:$D(RTQDC("S")) RTQDC("S") I $T!('$D(RTQDC("S"))),$D(^RT(+Q0,0)) S Y=^(0),V=+$P(Y,"^",7),O=+RTO(+$P(Y,"^",3)),RTL(O,999-V,Q)=$P(RTO(+$P(Y,"^",3)),"^",3)_V_"^"_Q0
 I $D(RTL)<10 W !?5,"No requests meet current criteria" G Q
 S (RTC,RTC0)=0 K RTFL,RTS F O=0:0 S O=$O(RTL(O)) Q:'O  F V=0:0 S V=$O(RTL(O,V)) Q:'V  F Q=0:0 S Q=$O(RTL(O,V,Q)) Q:'Q  S Q0=RTL(O,V,Q),RTC=RTC+1,RTS(RTC)=Q D PRT G Q:$D(RTESC)
 I $D(RTSEL),RTC>RTC0 D SEL1
Q K RTS,RTESC,RTLC,RTC0,RTFL,RTL,O,V,Q,Q0,O,E,T,RTO,R Q
 ;
PRT S S="",R1=$P(Q0,"^"),Q0=$P(Q0,"^",2,99) S:$P(Q0,"^",10) RTFL="",S="*" S Y=+$P(Q0,"^",4) D D^DIQ S D=Y S Y=Q0 D DEMOS3^RTUTL1
 W !,RTC,?4,R1,?12,$E(RTD("B"),1,17),?30,D,?50,RTD("P1"),?72,$J(Q,7),S S RTLC=RTLC+1
 I $D(RTD("PROV")) W !?12,"(",RTD("PROV"),")",?50,$E("("_RTD("PROVP")_"/"_RTD("PROVL"),1,19),")" S RTLC=RTLC+1
 I $D(^RTV(190.1,Q,"COMMENT")) S RTLC=RTLC+1 W !?3,"(Comment: ",^("COMMENT"),")" S RTLC=RTLC+1
 K S,R1,RTD,D D SEL Q
 ;
HD I $O(R(0)),'$O(R($O(R(0)))) S RT=$O(R(0)) I $D(^RT(RT,0)) S X1="**** Request Profile for "_$S($D(^DIC(195.2,+$P(^(0),"^",3),0)):$P(^(0),"^"),1:"")_" Vol: "_+$P(^RT(RT,0),"^",7)_" ****" D RECHD^RTUTL2 S RTLC=5 G HD1
 S X1="Request Profile for "_$P($P(RTAPL,"^",1),";",2)_" Records" D PTHD^RTUTL2,EQUALS^RTUTL3 S RTLC=5
HD1 W !?59,"[* pull list request]",!?4,"Record",?12,"Requestor",?30,"Date Needed",?50,"Phone/Room#",?72,"Request#" D LINE^RTUTL3 S RTLC=RTLC+2
 Q
 ;
SEL I $D(RTSEL),(RTLC+4)>20 S RTLC=0,RTZ("RTC")=RTC D SEL1 W ! S:$D(RTESC) RTC=RTZ("RTC"),RTC0=RTC K RTZ Q
 I (RTLC+4)>20,IOST["C-" S RTLC=0 K RTESC D ESC^RTRD
 Q
 ;
SEL1 S RTRD("A")=$S($D(RTSEL("A")):RTSEL("A"),1:"Choose Request")_$S(RTSEL["S"&(RTC>1):"s",1:"")_" from List: " D SEL^RTRD K RTRD,RTESC
 S:$D(RTY)!(X="^") RTESC="" S:RTC ^DISV($S($D(DUZ)'[0:DUZ,1:0),"^RTV(190.1,")=+RTY(RTC) Q
 ;
RT Q:'$D(RT)  S R(RT)="" G REC
