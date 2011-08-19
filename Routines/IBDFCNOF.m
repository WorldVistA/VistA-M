IBDFCNOF ;ALB/CJM - AICS clinics with no forms ; JUL 20,1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
% ; -- list of clinics that have no encounter forms in use.
 ;
 N C,X,Y,SERV,SERVICE,CLINIC,IBHDT,IBDFIFN,IBDCNO,IBDFCNO,IBDFNODE,PAGE,IBQUIT,DIVIS,DIVNAM,VAUTD,MULTI
 W !!,"AICS List of Clinics with No Encounter Form in Use",!!
 S IBQUIT=0
 D DIVIS G:IBQUIT EXIT
 D DEVICE G:IBQUIT EXIT
 D DQ
 Q
 ;
EXIT ; -- end of report
 K ^TMP($J,"IBDCN")
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K ZTSK,ZTDESC,ZTSAVE,ZTRTN
 Q
 ;
DQ ; -- entry point from taskmanager
 K ^TMP($J,"IBDCN")
 S IBQUIT=0,PAGE=1
 S IBHDT=$$HTE^XLFDT($H,1)
 D SET,LIST G EXIT
 Q
 ;
SET ; -- build list into temporary array
 N IBDFCL,DIVIS,DIVNAM,SERVICE,CLINNAM,IBDFNODE,IBQUIT
 F IBDFIFN=0:0 S IBDFIFN=$O(^SC(IBDFIFN)) Q:'IBDFIFN  S IBDCNO=$G(^SC(IBDFIFN,0)) I $P(IBDCNO,"^",3)="C" D
 .S DIVIS=+$P(IBDCNO,"^",15) I DIVIS=0 S DIVIS=$S(MULTI=0:$P($G(^DG(43,1,"GL")),"^",3),1:"Unknown")
 .S DIVNAM=$P($G(^DG(40.8,+DIVIS,0)),"^") S:DIVNAM="" DIVNAM="Unknown"
 .S CLINNAM=$P(IBDCNO,"^")
 .S Y=$P(IBDCNO,"^",8),C=$P(^DD(44,9,0),"^",2) D Y^DIQ S SERVICE=Y S:SERVICE="" SERVICE="Unknown"
 .I $O(^SD(409.95,"B",IBDFIFN,0)) D  ; else follows
 ..S IBDFCL=$O(^SD(409.95,"B",IBDFIFN,0))
 ..S IBDFNODE=^SD(409.95,IBDFCL,0)
 ..S IBQUIT=0 F X=2:1:9 S:$P(IBDFNODE,"^",X)&("^1^2^3^4^5^6^8^9^"[X) IBQUIT=1 Q:IBQUIT
 ..I 'IBQUIT S ^TMP($J,"IBDCN",DIVIS,DIVNAM,SERVICE,CLINNAM)=IBDFIFN_"^"_$S($P(IBDFNODE,"^",7)]"":"FORM IN PROGRESS",1:"") S ^TMP($J,"IBDCN",DIVIS,0)=$G(^TMP($J,"IBDCN",DIVIS,0))+1
 .I '$O(^SD(409.95,"B",IBDFIFN,0)) S ^TMP($J,"IBDCN",DIVIS,DIVNAM,SERVICE,CLINNAM)=IBDFIFN,^TMP($J,"IBDCN",DIVIS,0)=$G(^TMP($J,"IBDCN",DIVIS,0))+1
 Q
 ;
HEADER ; -- writes the report header
 I $E(IOST,1,2)="C-",$Y>1,PAGE>1 D PAUSE Q:IBQUIT
 I PAGE>1 W @IOF
 W !,"List of Clinics Without Encounter Forms",?IOM-32,IBHDT,"   PAGE ",PAGE
 W !,"For Division: ",DIVNAM
 ;W !,"CLINICS",?27,"SERVICE",?47,"DIVISION"
 W !,"CLINICS",?27,"SERVICE",?47,"COMMENT"
 W !,$TR($J(" ",IOM)," ","-")
 S PAGE=PAGE+1
 Q
 ;
PAUSE ; -- hold crt screen
 N DIR,X,Y
 F  Q:$Y>(IOSL-2)  W !
 S DIR(0)="E" D ^DIR S IBQUIT=$S(+Y:0,1:1)
 Q
 ;
LIST ; -- lists the clinics using FORM
 N CLINIC,COUNT,DIR,NEWDIV,NAME,OLDDIV
 W:$E(IOST,1,2)="C-" @IOF
 I $D(^TMP($J,"IBDCN"))=0 W ?15,"No active clinics found without an assigned encounter form"
 S (NEWDIV,COUNT)=0,OLDDIV=""
 S DIVIS="" F  S DIVIS=$O(^TMP($J,"IBDCN",DIVIS)) Q:DIVIS=""!(IBQUIT)  D
 .I 'VAUTD,'$D(VAUTD(DIVIS)) Q
 .I 'VAUTD,'$D(^TMP($J,"IBDCN",DIVIS)) S DIVNAM=$P($G(^DG(40.8,+DIVIS,0)),"^") D HEADER W !,"No clinics found for division '",DIVNAM,"'",! Q
 .S DIVNAM=$O(^TMP($J,"IBDCN",DIVIS,0)) Q:DIVNAM=""
 .S NEWDIV=1
 .S SERV="" F  S SERV=$O(^TMP($J,"IBDCN",DIVIS,DIVNAM,SERV)) Q:SERV=""!(IBQUIT)  D
 ..S NAME="" F  S NAME=$O(^TMP($J,"IBDCN",DIVIS,DIVNAM,SERV,NAME)) Q:NAME=""!(IBQUIT)  S CLINIC=+^(NAME) D ONELINE
 I 'IBQUIT W:OLDDIV'="" !,"----------------",!,"Division Count = ",COUNT
 Q
 ;
ONELINE ; -- print line of report
 I $G(NEWDIV) D NEWDIV Q:IBQUIT
 I $Y>(IOSL-3) D HEADER Q:IBQUIT
 ;W !,$E(NAME,1,25),?27,$E(SERV,1,18),?47,$E(DIVNAM,1,15)
 W !,$E(NAME,1,25),?27,$E(SERV,1,18)
 W ?47,$P(^TMP($J,"IBDCN",DIVIS,DIVNAM,SERV,NAME),"^",2),"  "
 I '$$ACLN(CLINIC) W ?4,"(Clinic Currently Inactive)"
 S COUNT=COUNT+1
 Q
 ;
NEWDIV ; -- print division totals and start new division
 I 'IBQUIT W:OLDDIV'="" !,"----------------",!,"Division Count = ",COUNT
 S OLDDIV=DIVIS
 D HEADER Q:IBQUIT
 W !?10,"Division: ",DIVNAM,! S NEWDIV=0,COUNT=0
 Q
 ;
DEVICE ; -- select device
 I $D(ZTQUEUED) Q
 S %ZIS="MQ" D ^%ZIS I POP S IBQUIT=1 Q
 I $D(IO("Q")) S ZTRTN="DQ^IBDFCNOF",ZTDESC="IBD - Clinics with No Forms",ZTSAVE("VA*")="",ZTSAVE("MULTI")="" D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued Task="_ZTSK,1:"Request Canceled") D HOME^%ZIS S IBQUIT=1 Q
 U IO
 Q
 ;
DIVIS ; -- Select division
 N X,Y S VAUTD=1,MULTI=0
 I $P($G(^DG(43,1,"GL")),"^",2) S MULTI=1 D DIVISION^VAUTOMA S:Y=-1 IBQUIT=1
 I 'VAUTD S X="" F  S X=$O(VAUTD(X)) Q:'X  S ^TMP($J,"IBDCN",X)=""
 Q
 ;
ACLN(SC) ; function
 ; -- is clinic currently active
 ;    Input   SC := pointer to 44
 ;    Output     := 1 if currently active
 ;                  0 if currently inactive
 ;
 N FLAG,SDIN,SDRE S FLAG=1
 I $D(^SC(SC,"I")) S Y=^("I"),SDIN=+Y,SDRE=+$P(Y,U,2)
 I $G(SDIN),SDIN'>DT,SDRE,SDRE>DT S FLAG=0
 I $G(SDIN),SDIN'>DT,'SDRE S FLAG=0
ACLNQ Q FLAG
