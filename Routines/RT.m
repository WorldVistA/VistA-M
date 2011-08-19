RT ;MJK/TROY ISC;Record Tracking Main Options; ; 2/2/87  8:50 AM ;
 ;;v 2.0;Record Tracking;;10/22/91 
 D DT^DICRW S X=$T(+1),DIK="^DOPT("""_$P(X," ;",1)_""","
 G:$D(^DOPT($P(X," ;"),8)) A S ^DOPT($P(X," ;"),0)=$P(X,";",3)_"^1N^" F I=1:1 S Y=$T(@I) Q:Y=""  S ^DOPT($P(X," ;"),I,0)=$P(Y,";",3,99)
 D IXALL^DIK
A D OVERALL^RTPSET Q:$D(XQUIT)
 W !! S DIC="^DOPT("""_$P($T(+1)," ;")_""",",DIC(0)="IQEAM" D ^DIC Q:Y<0  D @+Y G A
 ;
1 ;;Record Transaction Menu
 G ^RTT
 ;
2 ;;Request Record Menu
 G ^RTQ
 ;
3 ;;System Definition Menu
 G ^RTSYS
 ;
4 ;;Pull List Menu
 G ^RTP
 ;
5 ;;Record Inquiry Menu
 G ^RTNQ
 ;
6 ;;Computer Site Manager's Menu
 G ^RTSM
 ;
7 ;;Management Reports Menu
 G ^RTRPT
 ;
8 ;;MAS Specific Setup Menu
 G ^RTMAS
 ;
