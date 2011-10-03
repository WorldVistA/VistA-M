IBESTAT ;ALB/AAS - INTEGRATED BILLING - FILER STATUS ; 27-FEB-91
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
% ;
 ;***
 ;S XRTL=$ZU(0),XRTN="IBESTAT-1" D T0^%ZOSV ;start rt clock
 ;
 D HOME^%ZIS
 ;
 W @IOF,"Integrated Billing Status"
 S X="" S $P(X,"=",IOM)="" W !,X
 S X=$S($D(^IBE(350.9,1,0)):^(0),1:"")
SITE ;
 W !,"IB Facility Name ........................ ",$S($D(^DIC(4,+$P(X,"^",2),0)):$P(^(0),"^"),1:"")
 W !,"IB Facility Number ...................... ",$S($D(^DIC(4,+$P(X,"^",2),99)):$P(^(99),"^"),1:"")
 W !
PARAM W !,"File in Background ...................... ",$S($P(X,"^",3):"YES",1:"NO")
 W !,"Filer UCI,VOL ........................... ",$P(X,"^",7)
 W !,"Filer Hang Time ......................... ",$P(X,"^",8)_" Seconds"
 W !,"Background Error Mail Group ............. ",$S($D(^XMB(3.8,+$P(X,"^",9),0)):$P(^(0),"^"),1:"")
 ;
 W !
FILER I +$P(X,"^",4) W !,"Filer Appears to be Running!",!
 E  W !,"Filer does not Appear to be Running!",!
 W !,"Filer currently queued to run ........... ",$S($P(X,"^",10):"YES",1:"NO")
 S C=0 F I=0:0 S I=$O(^IB("APOST",I)) Q:'I  S C=C+1
 W !,"Number Transactions in Queue ............ ",C
 W !,"Filer Started on ........................ " S Y=$P(X,"^",4) D DT^DIQ
 W !,"Filer Stopped on ........................ " S Y=$P(X,"^",5) D DT^DIQ
 W !,"Filer last processed transaction on ..... " S Y=$P(X,"^",6) D DT^DIQ
 W !
 S C=0 F I=DT:0 S I=$O(^IB("D",I)) Q:'I!(I>(DT+.24))  F J=0:0 S J=$O(^IB("D",I,J)) Q:'J  S C=C+1
 W !,"Transactions filed since midnight ....... ",C
 ;
 D MENU^IBECK
 F I=$Y:1:(IOSL-4) W !
 S DIR(0)="E" D ^DIR
 ;
END K %H,C,I,J,X,Y,DIR
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBESTAT" D T1^%ZOSV ;stop rt clock
 Q
