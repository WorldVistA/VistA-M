RTT ;MJK/TROY ISC;Record Transaction Option; ; 5/19/87  9:58 AM ;
 ;;v 2.0;Record Tracking;;10/22/91 
 D DT^DICRW S X=$T(+1),DIK="^DOPT("""_$P(X," ;",1)_""","
 G:$D(^DOPT($P(X," ;"),10)) A S ^DOPT($P(X," ;"),0)=$P(X,";",3)_"^1N^" F I=1:1 S Y=$T(@I) Q:Y=""  S ^DOPT($P(X," ;"),I,0)=$P(Y,";",3,99)
 D IXALL^DIK
A D OVERALL^RTPSET Q:$D(XQUIT)
 W !! S DIC="^DOPT("""_$P($T(+1)," ;")_""",",DIC(0)="IQEAM" D ^DIC Q:Y<0  D @+Y G A
 ;
1 ;;Create a Label/Record/Volume
 G ^RTDPA1
 ;
2 ;;Delete a Record
 G ^RTDEL
 ;
3 ;;Charge-Out Records
 K RTB S X="CHARGE-OUT" D TYPE G Q:'$D(RTMV) D CO G 3:'$D(RTFIN) K RTFIN G Q
 ;
CO I '$D(RTDIV) D DIV1^RTPSET I '$D(RTDIV) D MES^RTP4 S RTFIN="" G Q
 I RTMV0["TRANSFER TO" D DAT^RTTR G Q:'$D(RTPAST)
 I RTMV0'["CHECK-IN" D PND^RTRPT IF 1
 E  D CPND^RTRPT
 K RTFIN I $S('$D(RTB):1,'$D(^RTV(195.9,+RTB,0)):1,1:0) W ! K RTB D BOR^RTDPA32 I '$D(RTB) S RTFIN="" G Q
 S:'$D(RTPROVFL) RTPROVFL=0 S RTN=0 K ^TMP($J,"RT") D SEL^RTT3
Q K RTC,X1,RTESC,%DT,POP,RTA,I1,RTWND,RTMV,RTMV0,RTN,RTESC,RTPROVFL,Z0
 I '$D(RTKEY) K ^TMP($J,"RT"),RTPAST,RTB
 K SSN,N,X,Y,JL,RTAR,Y,I,DIE,DA,DR,RTJST,DR,P
 Q
 ;
4 ;;Re-charge a Record
RC K RTB S X="RE-CHARGE" D TYPE G Q:'$D(RTMV) D CO G 4:'$D(RTFIN) K RTFIN G Q
 ;
5 ;;Check-In Records
 S X="CHECK-IN" D TYPE G Q:'$D(RTMV)
CI S Y=$S($D(RTFR):+RTFR,1:"")
 I 'Y S DIC(0)="IAMEQ",DIC="^RTV(195.9,",DIC("A")="Select Check-In File Room: ",DIC("S")="I $P(^(0),U,3)=+RTAPL,$P(^(0),U,13)=""F"" D DICS^RTDPA31",DIC("V")="I $P(Y(0),U,4)=""L""" D ^DIC K DIC Q:Y<0
 S RTB=+Y D CO K RTFIN Q
 ;
6 ;;Transfer Menu
 G ^RTTR
 ;
7 ;;Flag Record as Missing
 G 7^RTT1
 ;
8 ;;Record Charge-out to Patient
 G 8^RTT4
 ;
9 ;;Update Record's Attributes
UP S RTSEL="S",DIC(0)="IAEMQ" D ^RTDPA K RTBCIFN,RTSEL G Q:'$D(RTY) S RTDR="13//NO;6;11//OK TO RETIRE^Update Record's Attributes: " D DR K RTDR G UP
 ;
10 ;;Inactivate/Re-activate Records
 W ! S DIC="^DIC(195.3,",DIC(0)="IAEMQZ",DIC("A")="Select Movement Type: ",DIC("S")="I $P(^(0),U,3)=+RTAPL,$P(^(0),U)[""ACTIVATE""" D ^DIC K DIC G Q:Y<0 S RTMV=+Y,RTMV0=Y(0),RTINACFL=$P(Y(0),"^")["INACTIVATE"
 K RTB D CO:RTINACFL,CI:'RTINACFL K RTFIN,RTINACFL,RTB G Q
 ;
11 ;;Multiple volume creation
 G 11^RTT11
 ;
12 ;;Move Requests to last volume
 G 12^RTT11
 ;
PARSE ;entry point to charge record with 'Y', RTB, RTMV and RTMV0 defined; optionally RTQ defined
 ;Y=<record IFN>^<associated borrower>^<barcode input[y/n]>
 S RT=+Y,RTPROV=$P(Y,"^",2),RTBCIFN=$P(Y,"^",3)
CHG ;Entry pt with RT, RTB, RTMV and RTMV0 defined; optionally RTQ, RTPROV defined
 S Y=$P(RTMV0,"^") I $S(Y["FOUND":1,Y["MISSING":1,$D(^RTV(190.2,"AM","m",RT)):0,1:1) S DA=RT,DIE="^RT(",DR="[RT CHARGE]" D ^DIE K DE,DQ D MOVE^RTUTL1:'$D(Y)
 Q
 ;
TYPE K RTMV,RTMV0 S Y=+$O(^DIC(195.3,"AA",+RTAPL,X,0)) I 'Y!($O(^DIC(195.3,"AA",+RTAPL,X,Y)))!('$D(^DIC(195.3,Y,0))) W:'$D(ZTSK) !!,*7,"   '",X,"'  Please check Movement Type file." Q
 S RTMV=Y,RTMV0=^DIC(195.3,Y,0)
 Q
 ;
DR F RTI=1:1 Q:'$D(RTY(RTI))  S RT=RTY(RTI) I $D(^RT(RT,0)) S RTE=$P(^(0),"^"),X1=$P(RTDR,"^",2)_$S($D(^DIC(195.2,+$P(^(0),"^",3),0)):$P(^(0),"^"),1:"")_" Vol: "_+$P(^RT(RT,0),"^",7) D DR1
 K RT,RTY,RTI Q
 ;
DR1 D RECHD^RTUTL2 S RT0=^RT(RT,0),DA=RT,DIE="^RT(",DR=$P(RTDR,"^")_$S($D(^DIC(195.2,+$P(RT0,"^",3),0)):$S($P(^(0),"^",16)="y":";12",1:""),1:"") D ^DIE G DR1Q:$D(Y)
 S X=^RT(RT,0) G DR1Q:'$D(^RTV(195.9,+$P(X,"^",6),0))!($P(X,"^",6)=$P(RT0,"^",6)) I $D(^RT(RT,"CL")),$P(^("CL"),"^",5)=$P(X,"^",6) G DR1Q
 S RTRD(1)="Yes^check in record to new 'home' file room",RTRD(2)="No^not check it in",RTRD("B")=2,RTRD(0)="S",RTRD("A")="Do you want to check in the record to the new home file room? " D SET^RTRD K RTRD G DR1Q:$E(X)'="Y"
 S RTB=+$P(^RT(RT,0),"^",6) S X="CHECK-IN" D TYPE G DR1Q:'$D(RTMV) D CHG W:'$D(Y) !?5,"...record has been checked in"
DR1Q K RT0,RTB,RTMV,RTMV0,X Q
 ;
