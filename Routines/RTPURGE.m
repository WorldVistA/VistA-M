RTPURGE ;PKE/ISC-ALBANY-Purge Data Routine; ; 5/27/87  11:45 AM ;
 ;;v 2.0;Record Tracking;;10/22/91 
 D DIP W !!,"Record Type Purge Parameters:",!,"-----------------------------"
DIE S DIC("A")="Select RECORD TYPE: ",DIC="^DIC(195.2,",DIC(0)="AEMQ" D ^DIC K DIC G Q:X="^" I Y>0 S DA=+Y,DR="[RT PURGE PROFILE]",DIE="^DIC(195.2," D ^DIE K DE,DQ W ! G DIE
 W !!,"Overall Purge Parameters:",!,"-------------------------" S DA=1,DR="10;8;12",DIE="^DIC(195.4," D ^DIE K DE,DQ G Q:$D(Y)
 S X=^DIC(195.4,1,0) I $P(X,"^",10)'="y",$P(X,"^",8)'="y",$P(X,"^",12)'="y" W !!?5,*7,"No data will be purged!" G Q
 S RTRD(1)="Yes^indicate it is ok to run the purge option",RTRD(2)="No^stop the purge process",RTRD("B")=2,RTRD(0)="S",RTRD("A")="Is it ok to continue? " D SET^RTRD K RTRD G Q:$E(X)'="Y"
 S RTPGM="START^RTPURGE",RTDESC="Record Tracking Purge Routine",RTVAR="",(IOM,IOST,ION)="" D Q^RTUTL S IOP="" D ^%ZIS K IOP G Q
 ;
START K RTFLAGS,RTT S (RTLSTQ,RTLSTP)=0 F I=10,8,12 S $P(RTFLAGS,"^",I)=$P(^DIC(195.4,1,0),"^",I)="y"
 ;
 F RTYPE=0:0 S RTYPE=$O(^DIC(195.2,RTYPE)) Q:'RTYPE  I $D(^(RTYPE,0)) S RTYPE0=^(0) D SET:$P(RTYPE0,"^",18)="y"
 I $P(RTFLAGS,"^",10) F RTDT=0:0 S RTDT=$O(^RTV(194.2,"C",RTDT)) Q:RTDT>RTLSTP!('RTDT)  F RTP=0:0 S RTP=$O(^RTV(194.2,"C",RTDT,RTP)) Q:'RTP  D RTP
 ;pull list
 I $P(RTFLAGS,"^",8) F RTDT=0:0 S RTDT=$O(^RTV(190.1,"C",RTDT)) Q:RTDT>RTLSTQ!('RTDT)  F RTQ=0:0 S RTQ=$O(^RTV(190.1,"C",RTDT,RTQ)) Q:'RTQ  I $D(^RTV(190.1,RTQ,0)) S RTQ0=^(0) D RTQ0
 ;requests
 I $P(RTFLAGS,"^",12) F RT=0:0 S RT=$O(^RT(RT)) Q:'RT  I $D(^RT(RT,0)) S T=+$P(^(0),"^",3),RTHCL=$S($D(^("CL")):+$P(^("CL"),"^",2),1:0) D COUNT I $D(RTT(T)),X>+$P(RTT(T),"^",12) D RTH
 ;movements
 ;Re-set last entry accessed
 ;
 D RESET
Q K U2,Z,Z1,Z2,Z3,I,RTHCL,RTVAR,RT,RT0,RTC,RTC1,RTDT,RTFLAGS,RTH,RTI,RTLSTP,RTLSTQ,RTP,RTQ,RTQ0,RTRD,RTT,RTYPE,TYPE0 D CLOSE^RTUTL
 K DA,D0,DR,DIE Q
SET S X1=DT,X2=-$S($P(RTYPE0,"^",10):$P(RTYPE0,"^",10),1:365) D C^%DTC S $P(RTT(RTYPE),"^",10)=X S:RTLSTP'>X RTLSTP=X
 S X1=DT,X2=-$S($P(RTYPE0,"^",8):$P(RTYPE0,"^",8),1:365) D C^%DTC S $P(RTT(RTYPE),"^",8)=X S:RTLSTQ'>X RTLSTQ=X
 S $P(RTT(RTYPE),"^",12)=$S($P(RTYPE0,"^",12):$P(RTYPE0,"^",12),1:50) K X1,X2 Q
 ;
RTP F RTQ=0:0 S RTQ=$O(^RTV(190.1,"AP",RTP,RTQ)) Q:'RTQ  I $D(^RTV(190.1,RTQ,0)) S RTQ0=^(0) I $D(^RT(+RTQ0,0)) S T=+$P(^(0),"^",3) I $D(RTT(T)),$P(RTT(T),"^",10)>$P(RTQ0,"^",4) D RTQ^RTDEL,RTQ
 I '$D(^RTV(190.1,"AP",RTP)) S DA=RTP,DIK="^RTV(194.2," D ^DIK K DIK
 ;pull list 194.2
 Q
 ;
RTQ0 Q:$S($P(RTQ0,"^",10):1,'$D(^RT(+RTQ0,0)):0,'$D(RTT(+$P(^(0),"^",3))):1,1:+$P(RTT(+$P(^(0),"^",3)),"^",8)'>$P(RTQ0,"^",4))
RTQ I $D(^RT(+RTQ0,"CL")),RTQ=+^("CL") S DA=+RTQ0,DR="101///@",DIE="^RT(" D ^DIE K DE,DQ
 S DA=RTQ,DIK="^RTV(190.1," D ^DIK K DIK
 ;
 Q
 ;
RTH S RTC=0 F RTH=0:0 S RTH=$O(^RTV(190.3,"B",RT,RTH)) Q:'RTH  I $D(^RTV(190.3,RTH,0)) S X=+$P(^(0),"^",6) F I=1:1 I '$D(RTH(I,X)) S RTH(I,X)=RTH,RTC=RTC+1 Q
 S RTC=RTC-$P(RTT(T),"^",12)
 I RTC>0 S RTC1=0 F RTI=0:0 S RTI=$O(RTH(RTI)) Q:'RTI  F RTDT=0:0 S RTDT=$O(RTH(RTI,RTDT)) Q:'RTDT  S DA=+RTH(RTI,RTDT),DIK="^RTV(190.3," D ^DIK:DA'=RTHCL S RTC1=RTC1+1 G RTHQ:RTC'>RTC1
RTHQ K RTH,RTC,RTC1,RTI,RTDT,DIK,DA Q
 ;
COUNT S X=0 F RTH=0:0 S RTH=$O(^RTV(190.3,"B",RT,RTH)) Q:'RTH  S X=X+1
 K RTH Q
 ;
DIP W !!?5,"...compiling purge profile" S IOP="",DIC="^DIC(195.2,",(BY,FLDS)="[RT PURGE PROFILE]",L=0 K DTOUT D EN1^DIP K DIC,FLDS,BY,L,TO,FR,IOP Q
 Q
RESET S U2="^"
 I $P(RTFLAGS,U2,10) F I=1:1 I '$D(^RTV(194.2,I,0)) L +^RTV(194.2,0) S $P(^RTV(194.2,0),"^",3)=$S(I-1:I-1,1:"") L -^RTV(194.2,0) Q
 I $P(RTFLAGS,"^",8) F I=1:1 I '$D(^RTV(190.1,I,0)) L +^RTV(190.1,0) S $P(^RTV(190.1,0),"^",3)=$S(I-1:I-1,1:"") L -^RTV(190.1,0) Q
 ;
 I $P(RTFLAGS,"^",12) D GAP
 Q
GAP ;stops when 1/3 of z not consecutive
 S (Z,Z1,Z2,Z3,I)=10000
 F I=I:1 S:I#1000=0 Z3=Z2,Z2=Z S Z1=Z,Z=$O(^RTV(190.3,Z)) Q:'Z  IF I#1000=0,Z2-Z3>1333 L +^RTV(190.3,0) Q
 I Z S $P(^RTV(190.3,0),"^",3)=Z1 L -^RTV(190.3,0) Q
 E  L +^RTV(190.3,0) S $P(^RTV(190.3,0),"^",3)=Z1 L -^RTV(190.3,0)
 Q
