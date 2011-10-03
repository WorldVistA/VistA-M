RTDPA31 ;MJK/TROY ISC;Borrower File Screen Logic; ; 5/19/87  11:29 AM ;
 ;;2.0;Record Tracking;**7,10,11,21,29**;10/22/91 
DICS ;
 S Z0=^RTV(195.9,Y,0),Z=$P($P(Z0,U),";",2),Z1=$P(Z0,"^",10)
 I Z1="r"!(Z1="i") X "I 0" G DICSQ
 I $D(^RTV(195.9,Y,"KEY")),$P(^("KEY"),U)]"",'$D(^XUSEC($P(^("KEY"),U),DUZ)) X "I 0" G DICSQ
DICS1 I '$D(^DIC(195.1,+$P(Z0,"^",3),"BOR","AC",Z)) X "I 0" G DICSQ
 I Z="DIC(4,",$S('$D(^DIC(195.1,+$P(Z0,U,3),0)):1,$P(^(0),U,8)']"":1,1:'$D(^XUSEC($P(^(0),U,8),DUZ))) X "I 0" G DICSQ
 I "SC(;DIC(42,"'[Z G DICSQ
 ;inactive flags check
 ;
 ;I Z="VA(200," S Z1=$S('$P(^VA(200,+Z0,0),"^",11):1,1:DT'>$P(^(0),"^",11)) X "I Z1" G DICSQ
 I Z="SC(" S Z1=$S('$D(^SC(+Z0,"I")):1,'^("I"):1,DT<+^("I"):1,'$P(^("I"),"^",2):0,DT>+$P(^("I"),"^",2):1,1:0) X "I Z1" G DICSQ
 I Z="DIC(42," N D0,X S D0=+Z0 D WIN^DGPMDDCF X "I 'X"
 ;
DICSQ K Z,Z0,Z1 Q
 ;
RTQ S A=$S('$D(D0):0,'$D(^RTV(190.1,D0,0)):0,'$D(^RT(+^(0),0)):0,1:+$P(^(0),"^",4)) S A("RTQ")=""
REC I '$D(A("RTQ")) S A=$S('$D(D0):0,'$D(^RT(D0,0)):0,1:+$P(^(0),"^",4))
DIC S:A DIC("V")="S RTA="_A_" D DICV^RTDPA31 K RTA",DIC("DR")="3////"_A S:'A DIC("V")="I 0" K A Q
MISS S A=$S('$D(D0):0,'$D(^RTV(190.2,D0,0)):0,'$D(^RT(+^(0),0)):0,1:+$P(^(0),"^",4)) G DIC
HIS S A=$S('$D(D0):0,'$D(^RTV(190.3,D0,0)):0,'$D(^RT(+^(0),0)):0,1:+$P(^(0),"^",4)) G DIC
PULL S A=$S('$D(D0):0,'$D(^RTV(194.2,D0,0)):0,1:$P(^(0),"^",15)) G DIC
APL S A=$S('$D(D0):0,'$D(^DIC(195.1,D0,0)):0,1:D0) G DIC
BOR S A=$S('$D(D0):0,'$D(^RTV(195.9,D0,0)):0,1:+$P(^(0),"^",3)) G DIC
 ;
DICV ;entry point to set DIC("V") for dd's; RTA defined as internal number of file 195.1
 I '$D(^DIC(195.1,RTA,"BOR","B",+Y(0)))!('$D(^DIC(195.1,RTA,0))) X "I 0" Q
 ;naked ref to current application in ^DIC(195.1,rta,0)
 S P=$P(^(0),"^",8) I $S($P(Y(0),"^",4)'="I":1,P']"":0,1:$D(^XUSEC(P,DUZ)))
 Q
 ;
HOMESCR ;DIC("S") for DEFAULT HOME LOCATION field
 I $D(D0),$D(D1),$D(D2),$D(^DIC(195.2,"AF",Y,+^DIC(195.1,D0,"INST",D1,"TYPE",D2,0))),$D(^SC(+$P(^RTV(195.9,Y,0),U,2),0)),$P(^(0),U,4)=D1 D DICS
 Q
