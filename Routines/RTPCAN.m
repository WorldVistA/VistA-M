RTPCAN ;RPW/BUF,PKE/TROY-Cancel All pull lists for a clinic ; 9-17-87
 ;;v 2.0;Record Tracking;**25**;10/22/91 
ALL D:'$D(DT) DT^DICRW
 S DIC=44,DIC(0)="AEQMZ",DIC("A")="Select Clinic: ",DIC("S")="I $P(^(0),U,3)=""C""" D ^DIC K DIC("A"),DIC("S") G Q4:Y<0 S RTCLNAM=$P(Y,U,2)
 W !!,*7,"Are you sure you want to DELETE ALL Pull lists for the " S DIR("A")="          "_RTCLNAM_" clinic: ",DIR(0)="YA",DIR("B")="NO" D ^DIR G:Y'=1 Q4
 ;
 S RTPNAM=RTCLNAM_" [",N=0
 F RTN=0:0 S RTPNAM=$O(^RTV(194.2,"B",RTPNAM)) Q:(RTPNAM="")!($P(RTPNAM," [")]RTCLNAM)!($P(RTPNAM," [")'=RTCLNAM)  S RTPULL=$O(^(RTPNAM,0)) D CHK G Q4:$E(X)="^"
 W !,?3,N," Pull lists were cancelled"
Q4 K N,RTPULL,RTSTAT,RTPNAM,RTCLNAM,%
 K DIC,DIR,Y,X Q
 ;
CHK Q:'$D(^RTV(194.2,RTPULL,0))  Q:$P(^(0),U,2)'>DT  Q:$P(^(0),U,6)'="r"
 S RTSTAT="x"
 ;
CAN F RTQ=0:0 S RTQ=$O(^RTV(190.1,"AP",RTPULL,RTQ)) Q:'RTQ  I $D(^RTV(190.1,RTQ,0)),$P(^(0),"^",6)="r"!($P(^(0),"^",6)="n") S DA=RTQ,DIE="^RTV(190.1,",DR="[RT CHANGE REQUEST STATUS]" D ^DIE K DE,DQ
 K RTQ D STAT W !!?3,RTPNAM,"...pull list has been cancelled" S N=N+1 Q
 Q
STAT S DA=RTPULL,DR="[RT CHANGE PULL LIST STATUS]",DIE="^RTV(194.2," D ^DIE K DE,DQ Q
