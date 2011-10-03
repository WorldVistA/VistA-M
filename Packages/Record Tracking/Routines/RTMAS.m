RTMAS ;MJK/TROY ISC;MAS Specific Setup Menu; ; 5/26/87  3:04 PM ;
 ;;v 2.0;Record Tracking;;10/22/91 
 D DT^DICRW S X=$T(+1),DIK="^DOPT("""_$P(X," ;",1)_""","
 G:$D(^DOPT($P(X," ;"),3)) A S ^DOPT($P(X," ;"),0)=$P(X,";",3)_"^1N^" F I=1:1 S Y=$T(@I) Q:Y=""  S ^DOPT($P(X," ;"),I,0)=$P(Y,";",3,99)
 D IXALL^DIK
A S X="MAS" D ^RTPSET Q:$D(XQUIT)
 W !! S DIC="^DOPT("""_$P($T(+1)," ;")_""",",DIC(0)="IQEAM" D ^DIC Q:Y<0  D @+Y G A
 ;
1 ;;Admitting Area Set-up
L1 D AA^RTSM I Y>0 D BOR^RTSYS G L1
 G Q2
 ;
2 ;;Fill Next Clinic Request
 S RTPGM="PT^RTMAS" D MAS^RTPSET1 Q
 ;
3 ;;Admitting Area Chart Request
 W ! S DIC="^DPT(",DIC(0)="AEMQ" D ^DIC K DIC G Q2:Y<0 S DFN=+Y,DGFC="^" D ADM^RTQ3 K DFN,DGFC G 3
 ;
PT D PT^RTUTL3 G Q2:Y<0
21 S RTSEL="S",RTQDC("S")="I $P($P(^(0),U,4),""."")=DT,$P(^(0),U,6)=""r""!($P(^(0),U,6)=""n""),$D(^RTV(195.9,+$P(^(0),U,5),0)),$P(^(0),U)[""SC("",$D(^SC(+^(0),0)),$P(^(0),U,3)=""C""" D ^RTUTL4 G PT:'$D(RTY)
 ;;;F I=0:0 S I=$O(RTY(I)) Q:'I  I $D(^RTV(190.1,+RTY(I),0)),$D(^RT(+^(0),0)) S V=+$P(^(0),"^",7) D CHK G 21:'$D(R)
 F I=0:0 S I=$O(RTY(I)) Q:'I  I $D(^RTV(190.1,+RTY(I),0)),$D(^RT(+^(0),0)) S V=+^RTV(190.1,+RTY(I),0) K RTJFL D CHK G 21:$D(RTJFL)
 W !!,"Will now fill request"_$S(RTC>1:"s",1:"")_" selected..."
 F RTN=0:0 S RTN=$O(RTY(RTN)) Q:'RTN  S RTQ=+RTY(RTN) D RTQ^RTQ4 K RTY
 G PT
Q2 K RTY,RTC,RTJR,V,RTSEL,RTS,RTE,DFN,RTQDC,RTN,RTQ,RTJFL
 K POP,X1,A,N,Y,%,%H,%I,DIE,DA,D0,DR
 K RT,DUOUT Q
CHK I $D(RTJR(V)) W !!?3,*7,"You are only allowed to fill one request per volume.",! H 2 S RTJFL="" Q
 S RTJR(V)="" Q
 ;
