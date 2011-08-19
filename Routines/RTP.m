RTP ;MJK/TROY ISC;Pull List Option; ; 5/7/87  12:37 PM ;
 ;;v 2.0;Record Tracking;;10/22/91 
 D DT^DICRW S X=$T(+1),DIK="^DOPT("""_$P(X," ;",1)_""","
 G:$D(^DOPT($P(X," ;"),11)) A S ^DOPT($P(X," ;"),0)=$P(X,";",3)_"^1N^" F I=1:1 S Y=$T(@I) Q:Y=""  S ^DOPT($P(X," ;"),I,0)=$P(Y,";",3,99)
 D IXALL^DIK
A D OVERALL^RTPSET Q:$D(XQUIT)
 W !! S DIC="^DOPT("""_$P($T(+1)," ;")_""",",DIC(0)="IQEAM" D ^DIC Q:Y<0  D @+Y G A
 ;
1 ;;Create Pull List
CREATE I '$D(RTDIV) D DIV1^RTPSET I '$D(RTDIV) D MES^RTP4 Q
 W ! S DIC("A")="Enter NEW PULL LIST NAME: ",DIC(0)="IAELQ",DIC("S")="I 0",DIC("DR")="15////"_+RTAPL,DIC="^RTV(194.2,",DLAYGO=194.2 D ^DIC K DIC G Q:Y<0
 K RTQDT,RTB,RTINST,RTSEL S RTPLTY=2,RTSHOW="",DIE("NO^")="OUTOK",(DA,RTPULL)=+Y,DR="[RT PULL LIST]",DIE="^RTV(194.2," D ^DIE K RTSHOW,RTINST,RTPLTY,DIE,DE,DQ
 I $D(Y) W !?3,*7,"...entry is incomplete" S DIK="^RTV(194.2," D ^DIK K DIK W "...pull list has been deleted." S Y=""
 D ADD^RTP2:'$D(Y) K DLAYGO,DIC,RTESC,RTPULL
Q K X1,A,DA,D0,DR,DIE,P,POP,RTC,RTY,%,%I,%H
 K DIC,X,Y,J,I Q
 ;
2 ;;Change Pull List Date
 W ! S DIC("S")="I $P(^(0),U,6)=""r"",'$P(^(0),U,13),$P(^(0),U,15)=+RTAPL",DIC(0)="IAEMQ",DIC="^RTV(194.2," D ^DIC K DIC Q:Y<0  S RTPULL=+Y
 S %DT="ATEFX",%DT("A")="Enter NEW Date: ",%DT(0)="NOW" D ^%DT K %DT G Q2:Y<0 S RTQDT=Y
 S RTRD(1)="Yes^change the date",RTRD(2)="No^do not change the date",RTRD(0)="S",RTRD("B")=2,RTRD("A")="Are you sure you want to change the date the records are needed? " D SET^RTRD K RTRD G Q2:$E(X)'="Y"
 F RTQ=0:0 S RTQ=$O(^RTV(190.1,"AP",RTPULL,RTQ)) Q:'RTQ  I $D(^RTV(190.1,RTQ,0)),$P(^(0),"^",6)="r" W "." S DA=RTQ,DR="4////"_RTQDT S DIE="^RTV(190.1," D ^DIE K DE,DQ
 S DA=RTPULL,DR="2////"_RTQDT,DIE="^RTV(194.2," D ^DIE
Q2 K DE,DQ,RTPULL,RTQDT,RTQ G Q
 ;
3 ;;Add Records Request to List
 I '$D(RTDIV) D DIV1^RTPSET I '$D(RTDIV) D MES^RTP4 Q
 D LIST G Q:Y<0 D ADD^RTP2 K DIC,RTESC,RTPULL G Q
 ;
4 ;;Cancel an Entire Pull List
 D LIST G Q4:Y<0 S Y="cancel" D ASK G Q4:$E(X)'="Y" S RTSTAT="x"
CAN F RTQ=0:0 S RTQ=$O(^RTV(190.1,"AP",RTPULL,RTQ)) Q:'RTQ  I $D(^RTV(190.1,RTQ,0)),$P(^(0),"^",6)="r"!($P(^(0),"^",6)="n") S DA=RTQ,DIE="^RTV(190.1,",DR="[RT CHANGE REQUEST STATUS]" D ^DIE K DE,DQ
 K RTQ D STAT W !!?3,"...pull list has been cancelled"
Q4 K RTPULL,RTSTAT
 K DUOUT,X,Y,DIC,J G Q
 ;
5 ;;Designate Requests as Not Fillable
 G 5^RTP1
 ;
6 ;;Charge Out Pull List
 G ^RTP4
 ;
7 ;;Flag Pull List as PULLED/NOT CHARGED
 ;D LIST Q:Y<0  S RTSTAT="p" G CAN
 Q
 ;
8 ;;Cancel Individual Requests from Pull List
 G 8^RTP1
 ;
9 ;;Modify Pull List Comments
 G 9^RTP1
 ;
10 ;;Pull List Print
 G ^RTP3
 ;
11 ;;Special Multi-Institution Prints
 G ^RTP5
 ;
12 ;;Cancel an Entire Pull list for all future dates
 G ALL^RTPCAN
 ;
LIST W ! S DIC("S")="I $P(^(0),U,2)'<DT,$P(^(0),U,6)=""r"",$P(^(0),U,15)=+RTAPL",DIC(0)="IAEMQ",DIC="^RTV(194.2," D ^DIC K DIC Q:Y<0  S RTPULL=+Y Q
 ;
STAT S DA=RTPULL,DR="[RT CHANGE PULL LIST STATUS]",DIE="^RTV(194.2," D ^DIE K DE,DQ Q
 ;
ASK ;
 S RTRD(1)="Yes^"_Y_" entire pull list",RTRD(2)="No^not "_Y_" pull list",RTRD("B")=2,RTRD("A")="Are you sure you want to "_Y_" this pull list? ",RTRD(0)="S" D SET^RTRD K RTRD Q
 ;
