RTSM6 ;PKE/TROY,RAY/BED-Record Requestor; ; 5/15/87  9:01 AM ;
 ;;v 2.0;Record Tracking;**8,13,18**;10/22/91 
 ;schedule in taskman at night, initializes clinics from T to param
19 ;Dailey Clinic Request init
 S X="T",%DT="" D ^%DT K %DT S DT=Y,%DT(0)=Y D DATE^RTUTL G Q16:'$D(RTEND) S:RTEND'["." RTEND=RTEND_".9999"
 S RTDESC="Clinic Record Request Initialization Routine",RTVAR="RTBEG^RTEND",RTPGM="UP^RTSM6",(IOM,ION,IOST)="" D Q^RTUTL S IOP="" D ^%ZIS K IOP G Q16
 Q
START ;
 D NOW^%DTC S RTBEG=%,%DT="" S X="T+"_(0+$S($D(^DIC(195.4,1,0)):$S($P(^(0),"^",6):$P(^(0),"^",6),1:7),1:7)) D ^%DT S RTEND=Y_".2359" K %DT
 ;
UP S RTMASS=+^DIC(195.4,1,"MAS"),RTRAD=+^("RAD") D GET K ^TMP($J)
 D NOW^%DTC S Y=$E(%,1,12) D D^DIQ K X S X(1)=" Clinic Record Request Initialization   START DATE/TIME: "_Y D UTL
 D:$D(XRTL) T0^%ZOSV ; monitor pull list create et
 S RTMAS=RTMASS,RTBKGRD=""
 F RTSC=0:0 S RTSC=$O(^SC(RTSC)) Q:'RTSC  I $D(^SC(RTSC,0)),$P(^(0),"^",3)="C" D APP
 S RTMAS=RTMASS,RTBKGRD=""
 S:$D(XRT0) XRTN=$T(+0) D:$D(XRT0) T1^%ZOSV ; end pull list et
 D EN^RTSM61
 D NOW^%DTC S Y=$E(%,1,12) D D^DIQ K X S X(2)="                                         STOP DATE/TIME: "_Y,X(3)=" " D UTL
 S RTLN=4,RTHD="      # Requests for "
 F Z=0:0 S Z=$O(RTSCOUNT(RTMASS,Z)) D:'Z UTL Q:'Z  S RTLN=RTLN+1 S Y=Z D D^DIQ S X(RTLN)=RTHD_Y_" = "_$E(RTSCOUNT(RTMASS,Z)_"     ",1,6)_$S($D(RTSCOUNT(RTRAD,Z)):" X-ray Requests = "_RTSCOUNT(RTRAD,Z),1:"")
 ;
 S RTLN=RTLN+1,X(RTLN)="",X(RTLN+2)="     Any day that you DON'T receive this message you should run",X(RTLN+3)="     the CLINIC INITIALIZATION option before you run the Pull Lists"
 S RTLN=RTLN+4
 F RTLN=RTLN:1:RTLN+3 S X(RTLN)=" "
 D UTL
 D EN^RTSM7
 D MAIL
Q16 K RTINP,RTBKGRD,BORROW,PERSON,DIC,DIE,DR,L0,LO,L,RTA,RTB,RTQ,RTERM,RTDUZ,RTSA,RTEXCLUD,RTDTW,RTMASS,RTHD,RTLN,Z,X,Y,I,RTRAD,RTMAS,RTDESC,RTVAR,RTPGM,DFN,RTSC,RTTM,RTPL,SDSC,SDTTM,SDPL,RTSCOUNT,RTBEG,RTEND D CLOSE^RTUTL Q
 ;
APP I $D(^RTV(195.9,"ABOR",(RTSC_";SC("),RTMAS)) S X=+$O(^(RTMAS,0)) I '$O(^(X)),$D(^RTV(195.9,X,0)),$P(^(0),"^",14)'="y" Q
 F RTTM=(RTBEG-.0001):0 S RTTM=$O(^SC(RTSC,"S",RTTM)) Q:'RTTM!(RTEND<RTTM)  F RTPL=0:0 S RTPL=$O(^SC(RTSC,"S",RTTM,1,RTPL)) Q:'RTPL  I $D(^(RTPL,0)),$P(^(0),"^",9)'="C" S DFN=+^(0) D RTQ
 Q
RTQ S SDSC=RTSC,SDTTM=RTTM,SDPL=RTPL,RTBKGRD="" D CREATE^RTQ2 I $D(^SC(RTSC,"S",RTTM,1,RTPL,"RTR")) F RTMAS=RTMASS,RTRAD D CNT I '$D(ZTQUEUED) W "."
 S RTMAS=RTMASS
 Q
CNT I RTMAS=RTRAD,'$D(^SC("ARAD",RTSC,RTTM,DFN))!('$P(^DIC(195.4,1,"UP"),"^",2)) Q
 S D=$P(SDTTM,".") I $D(RTSCOUNT(RTMAS,D)) S RTSCOUNT(RTMAS,D)=RTSCOUNT(RTMAS,D)+1
 E  S RTSCOUNT(RTMAS,D)=1
 K D
 Q
MAIL S XMSUB="Record Tracking Clinic Request Initializer",XMTEXT="^TMP($J,""TX""," K XMY
 S RTMAS=+^DIC(195.4,1,"MAS"),RTRAD=+^("RAD")
 S X=$P(^DIC(195.1,RTMAS,0),"^",14) D MGRP
 S X=$P(^DIC(195.1,RTRAD,0),"^",14) D MGRP
 I '$D(XMY) S X=$O(^XMB(3.8,"B","RT CLINIC REQUESTS",0)) D MGRP
 I $D(DUZ)#2,DUZ S XMY(DUZ)=""
 E  S XMY(.5)=""
 S XMDUZ=.5 D ^XMD K XMDUZ,XMY,XMSUB,XMTEXT,XMZ K ^TMP($J,"TX") Q
 ;
MGRP I X S XMY("G."_$P($G(^XMB(3.8,X,0)),"^",1))=""
 Q
UTL F Z=0:0 S Z=$O(X(Z)) Q:'Z  S ^TMP($J,"TX",Z,0)=X(Z)
 K X Q
 ;
GET F RTMAS=RTMASS,RTRAD S RTEXCLUD(RTMAS)=U,Z=0 F N=1:1 S Z=$O(^DIC(195.1,RTMAS,"EXCLUDE","B",Z)) Q:'Z  S $P(RTEXCLUD(RTMAS),"^",N+1)=Z_U
