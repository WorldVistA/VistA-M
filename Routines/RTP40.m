RTP40 ;MJK/TROY ISC;Charge Out Pull List to Holding Area; ; 5/19/87  11:25 AM ;
 ;;v 2.0;Record Tracking;**21**;10/22/91 
 K RTQ,RTPROV S X="CHARGE-OUT" D TYPE^RTT Q:'$D(RTMV)  S Y=RTB D BOR^RTB S RTBNME=Y
 W @IOF,"PULL LIST HOLDING AREA CHARGE-OUT LOG" D NOW^%DTC S Y=$E(%,1,12) D D^DIQ W ?51,"RUN DATE: ",Y D LINE^RTUTL3 S RTAG="HOLD^RTP40" D CHK^RTP4
 K RTBNME,RTAG,RTMV,RTMV0 Q
 ;
HOLD S RTCOMR="Pull List: "_$P(RTP0,"^") F RTQX=0:0 S RTQX=$O(^RTV(190.1,"AP",RTPULL,RTQX)) Q:'RTQX  I $D(^RTV(190.1,RTQX,0)),$P(^(0),"^",6)="r" S RT=+^(0) D CHG^RTT
 S DA=RTPULL,DIE="^RTV(194.2,",DR="16////"_RTB D ^DIE I '$D(Y) W !!?3,"...'",$P(RTP0,"^"),"' pull list has been charged out to '",RTBNME,"'."
 K RTCOMR,RTQX,RT Q
 ;
BOR K RTESC,RTB S RTRD(1)="Yes^charge out records to a holding area",RTRD(2)="No^charge out pull lists directly",RTRD("B")=2,RTRD(0)="S",RTRD("A")="Do you want to charge out records to a holding area? " D SET^RTRD K RTRD
 S:$E(X)="^" RTESC="" Q:$E(X)'="Y"
 S DIC="^RTV(195.9,",DIC(0)="IDAEMLQ",DIC("DR")="3////"_+RTAPL,DIC("S")="I $P(^(0),U,3)="_+RTAPL_" D DICS^RTDPA31",DIC("V")="S RTA="_+RTAPL_" D DICV^RTDPA31 K RTA",DIC("A")="Select HOLDING AREA: " W ! D ^DIC K DIC
 S:Y<0 RTESC="" S:Y>0 RTB=+Y Q
