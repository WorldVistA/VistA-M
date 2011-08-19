RTNQ ;MJK/TROY ISC;Inquiry Utility Option; ; 3/20/87  11:09 AM ;
 ;;v 2.0;Record Tracking;;10/22/91 
 D DT^DICRW S X=$T(+1),DIK="^DOPT("""_$P(X," ;",1)_""","
 G:$D(^DOPT($P(X," ;"),4)) A S ^DOPT($P(X," ;"),0)=$P(X,";",3)_"^1N^" F I=1:1 S Y=$T(@I) Q:Y=""  S ^DOPT($P(X," ;"),I,0)=$P(Y,";",3,99)
 D IXALL^DIK
A D OVERALL^RTPSET Q:$D(XQUIT)
 W !! S DIC="^DOPT("""_$P($T(+1)," ;")_""",",DIC(0)="IQEAM" D ^DIC Q:Y<0  D @+Y G A
 ;
1 ;;Record Inquiry
 G ^RTNQ2
 ;
2 ;;Short Inquiry
 I '$D(RTAPL) D APL2^RTPSET D NEXT2:$D(RTAPL) K RTAPL,RTSYS Q
NEXT2 S RTA=+RTAPL D ASK^RTB K RTA I '$D(RTESC) G NEXT2:Y<0 S RTE=X D SHORT G NEXT2
 K RTE,RTESC,C,I,Y
 K %H,%I,DIC,DIY,N,POP,X,X1 Q
SHORT S RTINACFL="",RTDC("S")="I $P(^(0),U,4)="_+RTAPL D ^RTUTL2 K RTINACFL,RT1,RTC,RTDC Q
 ;
3 ;;Trace Movement History of Record
 G ^RTNQ1
 ;
4 ;;Combination Data Trace
 G ^RTNQ3
 ;
5 ;;Expanded Inquiry
 G ^RTNQ4
