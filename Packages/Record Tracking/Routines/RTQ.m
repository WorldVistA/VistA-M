RTQ ;MJK/TROY ISC;Record Request Option; ; 5/5/87  8:41 AM ;
 ;;v 2.0;Record Tracking;**8,23,26**;10/22/91 
 D DT^DICRW S X=$T(+1),DIK="^DOPT("""_$P(X," ;",1)_""","
 G:$D(^DOPT($P(X," ;"),5)) A S ^DOPT($P(X," ;"),0)=$P(X,";",3)_"^1N^" F I=1:1 S Y=$T(@I) Q:Y=""  S ^DOPT($P(X," ;"),I,0)=$P(Y,";",3,99)
 D IXALL^DIK
A D OVERALL^RTPSET Q:$D(XQUIT)
 W !! S DIC="^DOPT("""_$P($T(+1)," ;")_""",",DIC(0)="IQEAM" D ^DIC Q:Y<0  D @+Y G A
 ;
1 ;;Request a Record
 I '$D(RTAPL) D APL2^RTPSET D NEXT1:$D(RTAPL) K RTAPL,RTSYS Q
NEXT1 D PND^RTRPT I '$D(RTDIV) D DIV1^RTPSET I '$D(RTDIV) D MES^RTP4 G Q1
L1 K RTY S RTSEL="DSO",DIC(0)="IAEMQ",DIC("S")="I $P(^(0),U,4)=+RTAPL,$S('$D(RTTY):1,$P(^RT(+Y,0),U,3)=+RTTY:1,1:0),$D(^DIC(195.2,+$P(^RT(+Y,0),U,3),0)),$P(^(0),U,14)'=""n"""
 D RT^RTDPA K RTBCIFN,RTC,RTSEL,DIC G Q1:'$D(RTY)
 S RTQDC("S")="S Z=^(0) I $P(Z,U,6)=""r""!($P(Z,U,6)=""n"") D SCRN1^RTQ" S RTSHOW=""
 F RTY=0:0 S RTY=$O(RTY(RTY)) Q:'RTY  S RT=+RTY(RTY) I $D(^RT(RT,0)) S RTE=$P(^(0),"^") D RT^RTUTL4 K RTS,RTC D MISS^RTQ1 I $D(RT) D SET Q:'$D(RTQ)  K RTQ W !?3,"...request filed"
 K RTIX,RTQDT,RTINST,RTB,RTSEL,RTQDC,RTY,RT,RTSHOW,RTE G L1
Q1 K RTWND,RTESC,J,I,RTDUZ,Y
 K DA,D0,DIE,DR,A,N,P,RTX,X1,X,Y Q
2 ;;Edit Request
 G 2^RTQ4
 ;
3 ;;Cancel a Request
 G 3^RTQ41
 ;
4 ;;Fill a Request
 G 4^RTQ4
 ;
5 ;;Re-Print a Request Notice
 G 5^RTQ41
 ;
6 ;;Display a Request
 W ! S DIC="^RTV(190.1,",DIC(0)="AEMQ",DIC("A")="Select Request: "
 D ^DIC I Y'<0 S DA=+Y D EN^DIQ G 6
 K DIC,X,Y,DA Q
SET ;Entry pt with RT defined/optionally RTB,RTPUL,RTPAR,RTSHOW and RTQDT defined
 D NOW^%DTC S RTNOW=%,I=$P(^RTV(190.1,0),"^",3)
LOCK S I=I+1 S:$L(I)=4 I=10000 L +^RTV(190.1,I):1 I '$T!$D(^RTV(190.1,I)) L -^RTV(190.1,I) G LOCK
 S ^RTV(190.1,I,0)=RT,^RTV(190.1,"B",RT,I)="",^(0)=$P(^RTV(190.1,0),"^",1,2)_"^"_I_"^"_($P(^(0),"^",4)+1),^DISV($S($D(DUZ)'[0:DUZ,1:0),"^RTV(190.1,")=I L -^RTV(190.1,I)
 ;S RTQ=I,W="REQ"_RTQ D CHAR^RTDPA S ^RTV(190.1,"BAR",W_C,RTQ)="" K W,C L
 S (DA,RTQ)=I,DR="[RT REQUEST]",DIE="^RTV(190.1," D ^DIE K DQ,DE,RTNOW
 I $D(Y),$D(^RTV(190.1,DA,0)) W:$D(RTSHOW) !?3,"...request not completed therefore it must be deleted" S DIK="^RTV(190.1," D ^DIK W:$D(RTSHOW) !?6,"...deletion complete." K DIK,DA,RTQ,RTFL Q
 ;
 ;R=requestor institution
 ;C=current location institution
 ;RTC1=current location
 ;RTC2=central file room(both for R and C)
 Q:'$D(^DIC(195.4,1,0))  Q:$P(^(0),"^",4)="e"  S X=^RTV(190.1,RTQ,0) Q:$P($P(X,"^",4),".")'=DT  S R=+$P(X,"^",12),C=0,A=+$P(^RT(+X,0),"^",4)
 ;naked reference to records ^RT(n,"CL") node
 I $D(^("CL")) S X=^("CL") S C=$S('$D(^RTV(190.1,+X,0)):0,'$D(^DIC(4,+$P(^(0),"^",12),0)):0,1:+$P(^RTV(190.1,+X,0),"^",12)) I 'C S X=$P(X,"^",5) D INST1^RTUTL I $D(RTINST) S C=RTINST K RTINST
 K RTQL S RTC1=$S('$D(^RT(+^RTV(190.1,RTQ,0),"CL")):0,1:+$P(^("CL"),"^",5))
 ;
 I C,R=C G LOCKQ:'$D(^DIC(195.1,+RTAPL,"INST",C,0)) I $P(^(0),"^",4)="n",$D(^RTV(195.9,RTC1,0)),$P(^(0),"^",13)="F",$P(^(0),"^",5)]"" S Y=RTC1 D RTL1 G LOCKQ
 F I=R,C I $D(^DIC(195.1,+RTAPL,"INST",I,0)) S RTC2=+$P(^(0),"^",2) S:RTC1=RTC2 RTC1=0 S Y=RTC2 D RTL1 Q:R=C
 S Y=RTC1 D RTL1
LOCKQ K RTQL,C,RTC1,RTC2,R Q
 ;
RTL1 Q:'$D(^RTV(195.9,Y,0))  S RTION=$P(^(0),"^",5) D RTQ^RTL1:$S(RTION']"":0,1:'$D(RTQL(RTION))) S:RTION]"" RTQL(RTION)="" K RTION Q
 ;
D W !!,"Request No. ",DA,":",! K I S $P(I,"-",(14+$L(DA)))="" W I K I Q
 ;
SCRN ;naked ref to the zero node of the request file entry ^rtv(190.1,,0)=z
 I $S(DUZ=$P(^(0),U,3):1,$P(RTAPL,U,8)']"":0,1:$D(^XUSEC($P(RTAPL,U,8),DUZ))),$D(^RT(+Z,0)),$P(^(0),U,4)=+RTAPL,$D(RTWND(+$P(^(0),U,3))),RTWND(+$P(^(0),U,3))'>$P(Z,U,4) Q
 I $S(DUZ=$P(Z,U,3):1,$P(RTAPL,U,7)']"":1,1:$D(^XUSEC($P(RTAPL,U,7),DUZ))),$D(^RT(+Z,0)),$P(^(0),U,4)=+RTAPL,$D(RTWND(+$P(^(0),U,3))),RTWND(+$P(^(0),U,3))'>$P(Z,U,4) Q
 Q
SCRN1 ;
 I $D(^RT(+Z,0)),$P(^(0),U,4)=+RTAPL,$D(RTWND(+$P(^(0),U,3))),RTWND(+$P(^(0),U,3))'>$P(Z,U,4) Q
 Q
SCRN2 I $S(DUZ=$P(^(0),U,3):1,$P(RTAPL,U,7,8)=U:1,1:$D(^XUSEC($S($P(RTAPL,U,7)]"":$P(RTAPL,U,7),1:$P(RTAPL,U,8)),DUZ))),$D(^RT(+Z,0)),$P(^(0),U,4)=+RTAPL Q
 Q
