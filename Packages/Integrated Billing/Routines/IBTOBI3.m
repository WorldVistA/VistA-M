IBTOBI3 ;ALB/AAS - CLAIMS TRACKING BILLING INFORMATION PRINT ; 27-OCT-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**40,56**; 21-MAR-94
 ;
HR ; -- print hospital review information
 Q:'$O(^IBT(356.1,"C",+IBTRN,0))  ; -no reivews
 I ($Y+11)>IOSL D HDR^IBTOBI Q:IBQUIT
 W !,"  Hospital Review Information "
 N I,J,IBII,IBTRV,IBTRVD
 S IBII="" F  S IBII=$O(^IBT(356.1,"ATIDT",IBTRN,IBII)) Q:'IBII!(IBQUIT)  S IBTRV=0 F  S IBTRV=$O(^IBT(356.1,"ATIDT",IBTRN,IBII,IBTRV)) Q:'IBTRV!(IBQUIT)  D
 .N IBD
 .D HR1
 .D HR2
 .; Patch #40
 .D UNIT
 .S IBJ=0 F  S IBJ=$O(IBD(IBJ)) Q:'IBJ  W !,$E($G(IBD(IBJ,1)),1,40),?40,$E($G(IBD(IBJ,2)),1,39)
 .D COMM1(IBTRV) Q:IBQUIT
 .W !?30,"-----------------------------------"
 .I ($Y+11)>IOSL D HDR^IBTOBI Q:IBQUIT
 W:'IBQUIT !?4,$TR($J(" ",IOM-8)," ","-"),!
 Q
 ;
HR1 ; -- print one review
 S IBTRVD=$G(^IBT(356.1,+IBTRV,0))
 S IBTRTP=$P($G(^IBE(356.11,+$P($G(^IBT(356.1,IBTRV,0)),"^",22),0)),"^",2)
 D @IBTRTP
 Q
10 ; -- precert review
15 ; -- admission review
20 ; -- urgent adm. review
 S IBD(1,2)=" Severity of Ill: "_$$SI^IBTRVD0($P(IBTRVD,"^",4))
 S IBD(2,2)="Intensity of Svc: "_$$SI^IBTRVD0($P(IBTRVD,"^",5))
 S IBD(3,2)="    Criteria Met: "_$$EXPAND^IBTRE(356.1,.06,$P(IBTRVD,"^",6))
 S IBD(4,2)=" Prov. Intervwed: "_$$EXPAND^IBTRE(356.1,.1,$P(IBTRVD,"^",10))
 S IBD(5,2)=" Dec. Influenced: "_$$EXPAND^IBTRE(356.1,.11,$P(IBTRVD,"^",11))
 S IBD=5
 S IBNAR=0 F  S IBNAR=+$O(^IBT(356.1,+IBTRV,12,IBNAR)) Q:'IBNAR  D
 .S IBNARD=$G(^IBT(356.1,+IBTRV,12,IBNAR,0))
 .S IBD=IBD+1
 .S IBD(IBD,2)="Non-Acute Reason: "_$P($G(^IBE(356.4,+IBNARD,0)),"^",2)_" - "_$P(^(0),"^")
 Q
30 ; -- concurrent review
 S IBD(1,2)="   Day of Review: "_$J($P(IBTRVD,"^",3),2)
 S IBD(2,2)=" Severity of Ill: "_$$SI^IBTRVD0($P(IBTRVD,"^",4))
 S IBD(3,2)="Intensity of Svc: "_$$SI^IBTRVD0($P(IBTRVD,"^",5))
 S IBD(4,2)="Dschg Screen Met: "_$$EXPAND^IBTRE(356.1,.12,$P(IBTRVD,"^",12))
 S IBD(5,2)="Acute Care Dschg: "_$$EXPAND^IBTRE(356.1,1.17,$P($G(^IBT(356.1,+IBTRV,1)),"^",17))
 S IBD=5
 S IBNAR=0 F  S IBNAR=+$O(^IBT(356.1,+IBTRV,13,IBNAR)) Q:'IBNAR  D
 .S IBNARD=$G(^IBT(356.1,+IBTRV,13,IBNAR,0))
 .S IBD=IBD+1
 .S IBD(IBD,2)="Non-Acute Reason: "_$P($G(^IBE(356.4,+IBNARD,0)),"^",2)_" - "_$P(^(0),"^")
 Q
40 ; -- discharge review
 S IBD(1,2)="Discharge Screen: "_$$SI^IBTRVD0($P(IBTRVD,"^",12))
 S IBD=1
 Q
 ;
50 ;
60 ;
70 ;
80 ;
85 ;
90 ;
 S IBD=0
 Q
 ;
UNIT ; -- Special unit information
 I '$D(IBD) S IBD=0
 I IBTRTP=40 S IBD(IBD+1,2)="  D/C Screen Met: "_$$SI^IBTRVD0($P(IBTRVD,"^",13)) Q
 ; Patch #40
 S IBD(IBD+1,2)=" Special Unit SI: "_$$SI^IBTRVD0($P(IBTRVD,"^",8))
 S IBD(IBD+2,2)=" Special Unit IS: "_$$SI^IBTRVD0($P(IBTRVD,"^",9))
 Q
 ;
HR2 ; -- contact information
 S IBD(1,1)="     Review Date: "_$$DAT1^IBOUTL(+IBTRVD,"2P")
 S IBD(2,1)="     Review Type: "_$P($G(^IBE(356.11,+$P(IBTRVD,"^",22),0)),"^",1)
 S IBD(3,1)="       Specialty: "_$P($G(^DIC(45.7,+$P(IBTRVD,"^",7),0)),"^")
 S IBD(4,1)="     Methodology: "_$$EXPAND^IBTRE(356.1,.23,$P(IBTRVD,"^",23))
 S IBD(5,1)="          Status: "_$$EXPAND^IBTRE(356.1,.21,$P(IBTRVD,"^",21))
 S IBD(6,1)="  Last Edited By: "_$E($$EXPAND^IBTRE(356.1,1.04,$P($G(^IBT(356.1,+$G(IBTRV),1)),"^",4)),1,20)
 S IBD(7,1)="Next Review Date: "_$$DAT1^IBOUTL($P(IBTRVD,"^",20))
 Q
 ;
COMM1(DA) ; -- print comments from ins. reviews.
 W !,"Comment: "
 K ^UTILITY($J,"W")
 S DIWL=10,DIWR=IOM-12,DIWF="W"
 S IBJ=0 F  S IBJ=$O(^IBT(356.1,DA,11,IBJ)) Q:'IBJ  S X=^(IBJ,0) D ^DIWP  I IOSL<($Y+4) Q:IBQUIT  D HDR^IBTOBI
 Q:IBQUIT
 D ^DIWW
 Q
