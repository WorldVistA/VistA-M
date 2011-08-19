RTM ;PKE/ISC-ALBANY;Record Maintenance Option ; ; 9/10/90  14:24 ;
 ;;v 2.0;Record Tracking;;10/22/91 
 D DT^DICRW S X=$T(+1),DIK="^DOPT("""_$P(X," ;",1)_"""," G:$D(^DOPT($P(X," ;"),10)) A S ^DOPT($P(X," ;"),0)=$P(X,";",3)_"^1N^" F I=1:1 S Y=$T(@I) Q:Y=""  S ^DOPT($P(X," ;"),I,0)=$P(Y,";",3,99)
 D IXALL^DIK
A D OVERALL^RTPSET Q:$D(XQUIT)  W !! S DIC="^DOPT("""_$P($T(+1)," ;")_""",",DIC(0)="IQEAMZ" D ^DIC Q:Y<0  D @+Y G A
 ;
1 ;;Generate Record Retirement Pull lists
 G ^RTSM8
 ;
2 ;;Print Record Retirement Pull Lists
 S RTIRE="" D ^RTP3 K RTIRE Q
 ;
3 ;;Designate Non-fillables
 G 5^RTP1
 ;
4 ;;Delete a Record
 G ^RTDEL
 ;
5 ;;Create a Perpetual Record/Volume
 G ^RTDPA1
 ;
6 ;;Charge out/transfer Record Retirement lists
 S RTIRE="" D ^RTP4 K RTIRE Q
 ;
7 ;;[not used]
 ;
