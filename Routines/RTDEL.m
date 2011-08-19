RTDEL ;TROY ISC/MJK-Delete a Record; ; 5/7/87  10:08 AM ;
 ;;v 2.0;Record Tracking;;10/22/91 
DEL W ! S RTINACFL="",DIC(0)="AZEMQ",RTSEL="" D ^RTDPA K RTINACFL,DIC,RTESC,RTY,RTC G DELQ:Y<0 S RT=+Y,RT0=Y(0),V=+$P(RT0,"^",7),P=$S(V=1:RT,1:+$P(RT0,"^",5)),T=+$P(RT0,"^",3) G DEL:'P
 S V1=0,RTTOV1=0 F I=0:0 S I=$O(^RT("P",P,I)) Q:'I  I $D(^RT(I,0)),$P(^(0),"^",7)>V1 S V1=+$P(^(0),"^",7),RTTOV1=I
 I V1>V W !!?5,*7,"This record is volume '",V,"' of a '",V1,"' record set.",!?12,"...no deletion is allowed." G DEL
 S V1=0,RTTO=RTTOV1 F I=0:0 S I=$O(^RT("P",P,I)) Q:'I  I RTTOV1'=I,$D(^RT(I,0)),$P(^(0),"^",7)>V1 S V1=+$P(^(0),"^",7),RTTO=I
 I RTTO=RTTOV1 S RTTO=P
 I V>1,RTTO I $D(^RT(+RTTO,0)) S RTVOL=$P(^(0),"^",7)
 E  W !!?5,"There is no record/volume to transfer requests to .." S RTTO=0
 I RTTO S Y=T D TYPE1^RTUTL I '$D(RTTY) W !!?5,"Unknown Record type" K RTVOL S RTTO=0
 I RTTO S RTPAR=P,RTFROM=RT,RT=RTTO D RTDEL1 S RT=RTFROM K RTFROM I $D(RTESC) K RTESC,RT G DEL
 S Y=$P(RT0,"^") D NAME^RTB W !!,"Record Chosen: ",Y,"'s ",$S($D(^DIC(195.2,+$P(RT0,"^",3),0)):$P(^(0),"^"),1:"UNKNOWN")," [Volume: ",+$P(RT0,"^",7),"]"
 W !!,"Deletion of this record will also cause the following to be deleted:",!?10,"- any requests for the record",!?10,"- any missing record log entries",!?10,"- all movement history log entries"
 S RTRD(1)="Yes^delete record",RTRD(2)="No^stop the deletion process",RTRD("B")=2,RTRD(0)="S",RTRD("A")="Are you sure you want to delete this record? " D SET^RTRD K RTRD G DEL:$E(X)'="Y"
 W !,"Deletion process beginning..."
 F RTQ=0:0 S RTQ=$O(^RTV(190.1,"B",RT,RTQ)) Q:'RTQ  D RTQ S DA=RTQ,DIK="^RTV(190.1," D ^DIK W "."
 F RTDIK=190.2,190.3 F RTI=0:0 S RTI=$O(^RTV(RTDIK,"B",RT,RTI)) Q:'RTI  S DA=RTI,DIK="^RTV("_RTDIK_"," D ^DIK W "."
 S XMB="RT RECORD DELETION",Y=$P(RT0,"^") D NAME^RTB S XMB(1)=Y,XMB(2)=$S($D(^DIC(195.2,+$P(RT0,"^",3),0)):$P(^(0),"^"),1:"UNKNOWN"),XMB(3)=+$P(RT0,"^",7),XMB(4)=RT,XMB(5)=$S($D(^VA(200,DUZ,0)):$P(^(0),"^"),1:"UNKNOWN")
 D NOW^%DTC S Y=$E(%,1,12) D D^DIQ S XMB(6)=Y D SEND^RTT2 K XMB
 S DA=RT,DIK="^RT(" D ^DIK W !?10,"...deletion complete"
DELQ K RTDIK,RTI,RT,V,V1
 K T,RTBCIFN,RTSEL,RTTOV1,RT0,RTFROM,%,%H,%Y,%YV,DA,DIC1,DIK,DIY,DIYS,N,POP
 K X,Y,RTTO,RTQ Q
RTQ K RTQ1 G SC:'$D(^RTV(190.1,"APAR",RTQ)) S RTQ1=+$O(^(RTQ,0)) S DA=RTQ1,DR="11///@",DIE="^RTV(190.1," D ^DIE K DE,DQ
 F RTQ2=0:0 S RTQ2=$O(^RTV(190.1,"APAR",RTQ,RTQ2)) Q:'RTQ2  S DA=RTQ2,DR="11////"_RTQ1,DIE="^RTV(190.1," D ^DIE K DE,DQ
SC Q:'$D(^RTV(190.1,RTQ,0))  S X=^(0) Q:'$D(^RTV(195.9,+$P(X,"^",5),0))  S X1=^(0) Q:'$D(^SC(+$P(X1,"^",2),0))  S SDTTM=+$P(X,"^",4),SDSC=+$P(X1,"^",2)
 F SDPL=0:0 S SDPL=$O(^SC(SDSC,"S",SDTTM,1,SDPL)) Q:'SDPL  I $D(^(SDPL,"RTR")),+^("RTR")=RTQ S ^("RTR")=$S($D(RTQ1):RTQ1,1:"") Q
 K SDSC,SDTTM,SDPL,RTQ1,RTQ2,DR,DIE,X1,X Q
 ;
RTDEL1 D EN K X,P,Z,RDT,RTV0,RTWND
 K RTTO,RTPAR,RTVOL,RTTY,RTSEL Q
EN S RTRD(1)="Yes^transfer Requests to Record/Volume "_RTVOL
 S RTRD(2)="No^not change the Record/Volume(s)  Requested."
 S RTRD("A")="Pending Requests can be transferred to Record/Volume ,"_RTVOL_$C(13,10)_"        Transfer Requests to Volume '"_RTVOL_"' ? "
 ;
 S RTRD(0)="S",RTRD("B")=2 D SET^RTRD K RTRD S X=$E(X) S:X["^" RTESC="" I X'="Y" Q
 ;get pend cut
 Q:'$D(RTTY)  D PND^RTRPT Q:'$D(RTWND(+RTTY))
 ;get requests
GET S RTV0=RTFROM
 ;z=da
FIND F Z=0:0 S Z=$O(^RTV(190.1,"B",RTV0,Z)) Q:'Z  D REC L -^RTV(190.1,Z)
 QUIT
 ;
REC I $D(^RTV(190.1,Z,0)),$D(^RT(+^RTV(190.1,Z,0))) L +^RTV(190.1,Z):1 I '$T G REC
 I '$D(^RTV(190.1,Z,0))!('$D(^RT(+^RTV(190.1,Z,0)))) Q
 ;only requests,pending
 S RDT=+$P(^RTV(190.1,Z,0),"^",4) Q:'RDT  I $P(RDT,".")<RTWND(+RTTY) Q
 I $P(^RTV(190.1,Z,0),"^",6)'="r" Q
 S $P(^RTV(190.1,Z,0),"^",1)=RT,^RTV(190.1,"B",RT,Z)="" K ^RTV(190.1,"B",RTV0,Z) W " ." R X:0
 ;date/time needed
DAT I RDT,$D(^RTV(190.1,"AC",RTV0,$P(RDT,"."),Z)) S ^RTV(190.1,"AC",RT,$P(RDT,"."),Z)="" K ^RTV(190.1,"AC",RTV0,$P(RDT,"."),Z)
 ;
 ;pull list
PUL S P=+$P(^RTV(190.1,Z,0),"^",10)
 I P,$D(^RTV(190.1,"AP1",P,RTV0,Z)) S ^RTV(190.1,"AP1",P,RT,Z)="" K ^RTV(190.1,"AP1",P,RTV0,Z)
 Q
