RTT2 ;MJK/TROY ISC;Record Transaction Option; ; 5/26/87  4:24 PM ;
 ;;v 2.0;Record Tracking;**18,21**;10/22/91 
PND D MISS1^RTQ1 Q:'$D(RT)  S RTZ0=^RT(RT,0),Y=+$P(RTZ0,"^",3) Q:'$D(RTWND(Y))
 D ^RTT21
 F RTCHKDT=RTCHKDT:0 S RTCHKDT=$O(^RTV(190.1,"AC",RT,RTCHKDT)) Q:'RTCHKDT!($P(RTCHKDT,".")>RTDT)  D PND1 I $D(RTFL) D SEL Q
 K RTZ0,RTFL,RTCHKDT,RTDT Q
 ;
PND1 F I=0:0 S I=$O(^RTV(190.1,"AC",RT,RTCHKDT,I)) Q:'I  I $D(^RTV(190.1,I,0)),($P(^(0),"^",6)="r"!($P(^(0),"^",6)="n")),$S($P(RTMV0,"^")'["CHARGE-OUT":1,$P(^(0),"^",5)=RTB:1,1:0) D MES Q:$D(RTFL)
 Q
 ;
SEL S RTRD(1)="Yes^fill requests",RTRD(2)="No^not fill request",RTRD(0)="S",RTRD("B")=2,RTRD("A")="Do you want to fill a pending request? " D SET^RTRD K RTRD Q:$E(X)'="Y"
 I $D(RTSAVE) S RTMVX=RTMV,RTMV0X=RTMV0,RTBX=RTB,RTYX=RTY F I=1:1 Q:'$D(RTY(I))  S RTYX(I)=RTY(I)
 S RTSEL="",RTQDC("S")="S Z=^(0) I $P(Z,U,6)=""r""!($P(Z,U,6)=""n"") D SCRN2^RTQ" D RT^RTUTL4 K RTSEL
 I $D(RTY) S RTQ=+RTY(1) D FILL^RTQ4 I '$D(Y) W !?3,"...request filled" K RT
 K RTY I $D(RTSAVE) S RTMV=RTMVX,RTMV0=RTMV0X,RTB=RTBX,RTY=RTYX F I=1:1 Q:'$D(RTYX(I))  S RTY(I)=RTYX(I)
 K RTIX,RTQDC,RTYX,RTQ,RTMVX,RTMV0X,RTBX Q
 ;
MES S Y=$P(RTZ0,"^") D NAME^RTB S Y=Y_"'s "_$S('$D(^DIC(195.2,+$P(RTZ0,"^",3),0)):"UNKNOWN",1:$P(^(0),"^"))_" V"_+$P(RTZ0,"^",7)_"." K RTZ0
 I $P(RTMV0,"^")["CHARGE-OUT" W !!,*7,"This borrower has a pending request for " W:($X+$L(Y))>80 ! W Y
 I $P(RTMV0,"^")'["CHARGE-OUT" W !!,*7,"There is at least one request pending for " W:($X+$L(Y))>80 ! W Y
 S RTFL="" Q
 ;
FND Q:'$D(^RTV(190.2,"AM","m",RT))  K XMY,XMB S RTMIS=+$O(^(RT,0)) G FNDQ:'$D(^RTV(190.2,RTMIS,0)) I '$D(^RT(RT,"CL")) L +^RT(RT,"CL") S ^("CL")="" L -^RT(RT,"CL")
 S RTRD(1)="Yes^indicate record was found",RTRD(2)="No^keep record flagged as missing",RTRD("B")=2,RTRD(0)="S",RTRD("A")="Do you want to remove the 'missing' flag on this record? " D SET^RTRD K RTRD G FNDQ:$E(X)'="Y"
RTB W ! S DIC="^RTV(195.9,",DIC(0)="IAEMLQ",DIC("DR")="3////"_+RTAPL,DIC("S")="I $P(^(0),U,3)="_+RTAPL_" D DICS^RTDPA31",DIC("V")="S RTA="_+RTAPL_" D DICV^RTDPA31 K RTA",DIC("A")="Where was the record found? " D ^DIC K DIC G FNDQ:Y<0
 S RTB=+Y,X="FOUND RECORD" D TYPE^RTT G FNDQ:'$D(RTMV) D CHG^RTT I $D(^RTV(195.9,+$P(^RT(RT,"CL"),"^",5),0)),$P(^(0),"^")="2;DIC(195.4," K RTMV,RTMV0 G FNDQ
FND1 S DIE("NO^")="",DA=RTMIS,DR="[RT FOUND]",DIE="^RTV(190.2," D ^DIE K DIE,DE,DQ G FNDQ:$D(Y)
 S XMB="RT RECORD FOUND",RTMIS0=^RTV(190.2,RTMIS,0) D DEMOS^RTUTL1 S XMB(1)=RTD("N"),XMB(2)=RTD("T"),XMB(10)=$P(RTD("T")," ("),XMB(9)=$S($D(RTD("SSN")):"("_RTD("SSN")_") ",1:""),Y=$P(RTMIS0,"^",6) D D^DIQ S XMB(3)=Y K RTD
 S Y=$P(RTMIS0,"^",4),C=$P(^DD(190.2,4,0),U,2) D Y^DIQ S XMB(4)=Y,Y=+$P(RTMIS0,"^",5) D BOR^RTB S XMB(5)=Y,XMB(6)=$S($D(^VA(200,+$P(RTMIS0,"^",8),0)):$P(^(0),"^"),1:"UNKNOWN")
 S XMB(7)=$S($D(^RTV(195.9,+$P(RTMIS0,"^",5),0)):$P(^(0),"^",7),1:""),XMB(8)=$S($D(RTZ("RTMV0")):$P(RTZ("RTMV0"),"^"),$D(RTMV0):$P(RTMV0,"^"),1:"") D SEND
 I $D(^RTV(190.2,"AM","s",RT)) W !!?3,"...record has been designated as 'found pending file room supervisor review'",!?6,"...thank you for finding the record",! G FNDQ
 W !!?3,"...missing flag has been removed",!
FNDQ D BULL:'$D(XMB) K RTMV,RTMV0,RTESC,RTB,RTMIS,XMB,RTQ,RTMIS0,Y Q
 ;
BULL Q:$S($P(RTAPL,"^",8)']"":1,1:$D(^XUSEC($P(RTAPL,"^",8),DUZ))'[0)
 K XMY S XMB="RT ATTEMPT-ON-MISSING-REC" D DEMOS^RTUTL1 S XMB(1)=RTD("N"),XMB(2)=RTD("T"),XMB(7)=$S($D(RTD("SSN")):"("_RTD("SSN")_") ",1:"") D NOW^%DTC S Y=$E(%,1,12) D D^DIQ S XMB(3)=Y K RTD
 S XMB(4)=$S($D(RTZ("RTMV0")):$P(RTZ("RTMV0"),"^"),$D(RTMV0):$P(RTMV0,"^"),1:"")
 S IOP="" D ^%ZIS K IOP S XMB(5)=$P(^%ZIS(1,IOS,0),"^"),XMB(6)=$S($D(^VA(200,DUZ,0)):$P(^(0),"^"),1:"UNKNOWN") X ^%ZOSF("UCI") S XMB(8)=Y
 S X=$P(RTAPL,"^",8) I X]"" F I=0:0 S I=$O(^XUSEC(X,I)) Q:'I  S XMY(I)=""
 D XMB K XMB Q
 ;
SEND K XMY S X=+$P(RTAPL,"^",12) S XMY("G."_$P($G(^XMB(3.8,X,0)),"^",1))="" ;PASS MAILGROUP
XMB I $D(XMY),$D(DUZ) S XMY(DUZ)=DUZ,XMDUZ=DUZ N DIC D ^XMB K XMDUZ,XMY Q
