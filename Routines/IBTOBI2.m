IBTOBI2 ;ALB/AAS - CLAIMS TRACKING BILLING INFORMATION PRINT ;27-OCT-93
 ;;2.0;INTEGRATED BILLING;**210**;21-MAR-94
 ;
IR ; -- print insurance review information
 Q:'$O(^IBT(356.2,"C",+IBTRN,0))  ; -no reivews
 I ($Y+11)>IOSL D HDR^IBTOBI Q:IBQUIT
 W !,"  Insurance Review Information "
 N I,J,IBII,IBTRC,IBTRCD,IBACTION,TCODE
 S IBII="" F  S IBII=$O(^IBT(356.2,"ATIDT",IBTRN,IBII)) Q:'IBII!(IBQUIT)  S IBTRC=0 F  S IBTRC=$O(^IBT(356.2,"ATIDT",IBTRN,IBII,IBTRC)) Q:'IBTRC!(IBQUIT)  D
 .N IBJ,IBD
 .D IR1
 .D IR2
 .S IBJ=0 F  S IBJ=$O(IBD(IBJ)) Q:'IBJ  W !,$E($G(IBD(IBJ,1)),1,39),?40,$E($G(IBD(IBJ,2)),1,39)
 .D COMM2(IBTRC) Q:IBQUIT
 .W !?30,"-----------------------------------"
 .I ($Y+11)>IOSL D HDR^IBTOBI Q:IBQUIT
 W:'IBQUIT !?4,$TR($J(" ",IOM-8)," ","-"),!
 Q
 ;
IR1 ; -- print one review
 S IBTRCD=$G(^IBT(356.2,+IBTRC,0)),IBTRCD1=$G(^(1))
 S IBD(1,1)="    Type Review: "_$$EXPAND^IBTRE(356.2,.04,$P(IBTRCD,"^",4))
 S TCODE=$$TCODE^IBTRC(IBTRC) I TCODE D @TCODE
 Q
10 ; -- pre-cert contact
15 ; -- admission review
20 ; -- urgent/emergent ins. contact
30 ; -- continued stay contact
 S IBD(2,1)="         Action: "_$$EXPAND^IBTRE(356.2,.11,$P(IBTRCD,"^",11))
 S IBACTION=$P($G(^IBE(356.7,+$P(IBTRCD,"^",11),0)),"^",3)
 S IBACTION=IBACTION+100 D @IBACTION
 Q
 ;
40 ; -- Discharge contact
100 ; -- No type of action
 Q
50 ; -- outpatient treatment
 S IBD(2,1)="  Opt Treatment: "_$$EXPAND^IBTRE(356.2,.26,$P(IBTRCD,"^",26))
 S IBD(3,1)="         Action: "_$$EXPAND^IBTRE(356.2,.11,$P(IBTRCD,"^",11))
 S IBD(4,1)="   Auth. Number: "_$P(IBTRCD,"^",28)
 Q
60 ; -- Appeal
65 ; -- Nth appeal
 S IBD(2,1)="    Appeal Type: "_$$EXPAND^IBTRE(356.2,.23,$P(IBTRCD,"^",23))
 S IBD(3,1)="    Case Status: "_$$EXPAND^IBTRE(356.2,.1,$P(IBTRCD,"^",10))
 S IBD(4,1)="No Days Pending: "_$$EXPAND^IBTRE(356.2,.25,$P(IBTRCD,"^",25))
 S IBD(5,1)="  Final Outcome: "_$$EXPAND^IBTRE(356.2,.29,$P(IBTRCD,"^",29))
 Q
70 ; -- Patient
80 ; -- Other
85 ; -- Insurance verification
90 ;
 Q
 ;
110 ; -- approval actions
 S IBD(3,1)="Authorized From: "_$S($P(IBTRCD1,"^",8):"ENTIRE VISIT",1:$$DAT1^IBOUTL($P(IBTRCD,"^",12)))
 S IBD(4,1)="  Authorized To: "_$S($P(IBTRCD1,"^",8):"ENTIRE VISIT",1:$$DAT1^IBOUTL($P(IBTRCD,"^",13)))
 S IBD(5,1)="Authorized Diag: "_$$DIAG^IBTRE6($P(IBTRCD,"^",14),1,$$TRNDATE^IBACSV($G(IBTRN)))
 S IBD(6,1)="   Auth. Number: "_$P(IBTRCD,"^",28)
 Q
120 ; -- denial actions
 S IBD(3,1)="    Denied From: "_$S($P(IBTRCD1,"^",7):"ENTIRE VISIT",1:$$DAT1^IBOUTL($P(IBTRCD,"^",15)))
 S IBD(4,1)="      Denied To: "_$S($P(IBTRCD1,"^",7):"ENTIRE VISIT",1:$$DAT1^IBOUTL($P(IBTRCD,"^",16)))
 S IBI=0,IBD=4 F  S IBI=$O(^IBT(356.2,IBTRC,12,IBI)) Q:'IBI  D
 .S IBD=IBD+1
 .S IBD(IBD,1)=" Denial Reasons: "_$$EXPAND^IBTRE(356.212,.01,+$G(^IBT(356.2,IBTRC,12,IBI,0)))
 Q
130 ; -- penalty
 S IBI=0,IBD=2 F  S IBI=$O(^IBT(356.2,IBTRC,13,IBI)) Q:'IBI  D
 .S IBD=IBD+1
 .S IBD(IBD,1)="        Penalty: "_$$EXPAND^IBTRE(356.213,.01,+$G(^IBT(356.2,IBTRC,13,IBI,0)))
 Q
140 ; -- case pending
 S IBD(3,1)="   Case Pending: "_$$EXPAND^IBTRE(356.2,.2,$P(IBTRCD,"^",20))
 Q
150 ; -- no coverage
 S IBD(3,1)="    No Coverage: "_$$EXPAND^IBTRE(356.2,.21,$P(IBTRCD,"^",21))
 Q
 ;
IR2 ; -- contact information
 ;N IBCDFN,IBCPOL
 ;S IBCDFN=$P(IBTRCD1,"^",5),IBCPOL=$P(^DPT(DFN,.312,IBCDFN,0),"^",18)
 S IBD(1,2)="     Review Date: "_$E($$DAT1^IBOUTL(+IBTRCD,"2P"),1,20)
 S IBD(2,2)="   Insurance Co.: "_$E($P($G(^DIC(36,+$G(^DPT(DFN,.312,+$P(IBTRCD1,"^",5),0)),0)),"^"),1,20)
 S IBD(3,2)="Person Contacted: "_$E($P(IBTRCD,"^",6),1,20)
 S IBD(4,2)="  Contact Method: "_$E($$EXPAND^IBTRE(356.2,.17,$P(IBTRCD,"^",17)),1,20)
 S IBD(5,2)="Call Ref. Number: "_$E($P(IBTRCD,"^",9),1,20)
 S IBD(6,2)="          Status: "_$E($$EXPAND^IBTRE(356.2,.19,$P(IBTRCD,"^",19)),1,20)
 S IBD(7,2)="  Last Edited By: "_$E($$EXPAND^IBTRE(356.2,1.04,$P($G(^IBT(356.2,+$G(IBTRC),1)),"^",4)),1,20)
 I '$P(IBTRCD,"^",2) S IBD(2,2)="Patient Contacted: "_$E($P($G(^DPT(+$P(IBTRCD,"^",5),0)),"^"),1,20)
 Q
 ;
COMM2(DA) ; -- print comments from ins. reviews.
 W !,"Comment: "
 Q:'$D(^IBT(356.2,DA,11))
 K ^UTILITY($J,"W")
 S DIWL=10,DIWR=IOM-12,DIWF="W"
 S IBJ=0 F  S IBJ=$O(^IBT(356.2,DA,11,IBJ)) Q:'IBJ  S X=^(IBJ,0) D ^DIWP I IOSL<($Y+4) Q:IBQUIT  D HDR^IBTOBI
 Q:IBQUIT
 D ^DIWW
 K ^UTILITY($J,"W")
 Q
