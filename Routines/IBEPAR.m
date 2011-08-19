IBEPAR ;ALB/AAS - MCCR SITE PARAMETER ENTER/EDIT ;26-MAR-92
 ;;2.0;INTEGRATED BILLING;**133,51,153,210**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% ;
 S IBPAR=1,IBV1="00000",IBSR="PAR",IBSR1="" F I=0,1,2 S IBEPAR(I)=$S($D(^IBE(350.9,1,I)):^(I),1:"")
 D ^IBCSCU
 S L="",$P(L,"=",80)=""
 I $D(IBPAR) S X="MEDICAL CARE COST RECOVERY PARAMETER ENTER/EDIT" W @IOF,?17,IBVI,X,IBVO,!,L
 ;
1 S Z=1,IBW=1 X IBWW W " Medical Center Name: "_$P($G(^DIC(4,+$P(IBEPAR(0),"^",2),0)),"^"),?47,"Federal Tax #",?66,": ",$S($P(IBEPAR(1),"^",5)]"":$P(IBEPAR(1),"^",5),1:IBU)
 W !?4,"Default BC/BS #",?23,": ",$S($P(IBEPAR(1),"^",6)]"":$P(IBEPAR(1),"^",6),1:IBU)
 W ?47,"Medicare Number",?66,": ",$S($P(IBEPAR(1),"^",21)]"":$P(IBEPAR(1),"^",21),1:IBU)
 W !?4,"MAS Service Pointer",?23,": ",$E($S($P(IBEPAR(1),"^",14)]""&($D(^DIC(49,+$P(IBEPAR(1),"^",14),0))):$P(^(0),"^",1),1:IBU),1,20)
 W ?47,"Default Division",?66,": ",$E($S($P(IBEPAR(1),"^",25)]"":$P($G(^DG(40.8,+$P(IBEPAR(1),"^",25),0)),"^"),1:IBU),1,12),!
 ;
2 S Z=2,IBW=1 X IBWW W " Bill Signer Name   : "_$S($P(IBEPAR(1),"^",1)]"":$P(IBEPAR(1),"^",1),1:IBU)
 W ?47,"Title: ",$S($P(IBEPAR(1),"^",2)]"":$P(IBEPAR(1),"^",2),1:IBU)
 W !?4,"Billing Supervisor",?23,": " S IBSUP=$S($P(IBEPAR(1),"^",8)]"":$P(IBEPAR(1),"^",8),1:IBU) I IBSUP'=IBU S IBSUP=$P(^VA(200,IBSUP,0),"^",1)
 W:IBSUP'=IBU $P(IBSUP,",",2)," ",$P(IBSUP,",",1),! W:IBSUP=IBU IBU,!
 ;
3 S Z=3,IBW=1 X IBWW W " Multiple Form Types: "_$S($P(IBEPAR(1),"^",22)=1:"YES",$P(IBEPAR(1),"^",11)=0:"NO",1:IBU)
 W ?47,"Initiator Authorize: ",$S($P(IBEPAR(1),"^",23)=1:"YES",$P(IBEPAR(1),"^",3)=0:"NO",1:IBU) W !?4,"Use Non-PTF Codes?",?23,": ",$S($P(IBEPAR(1),"^",15)=1:"YES",$P(IBEPAR(1),"^",15)=0:"NO",1:IBU)
 W ?47,"Ask HINQ in MCCR?  : ",$S($P(IBEPAR(1),"^",16)=1:"YES",$P(IBEPAR(1),"^",16)=0:"NO",1:IBU),!
 W ?4,"Use OP CPT screen? : ",$S($P(IBEPAR(1),"^",17):"YES",'$P(IBEPAR(1),"^",17):"NO",1:IBU)
 W ?47,"Default ASC Rev. Cd: " S X=$G(^DGCR(399.2,+$P(IBEPAR(1),"^",18),0)) W $S($P(X,"^")]"":$P(X,"^"),1:IBU),!
 W ?4,"Xfer Proc to Sched?: "_$S($P(IBEPAR(1),"^",19)=1:"YES",$P(IBEPAR(1),"^",19)=0:"NO",1:IBU)
 W ?47,"Per Diem Start Date: " S Y=$P(IBEPAR(0),"^",12) D D^DIQ W Y,!
 W ?4,"Default RX Rev. Cd : " S X=$G(^DGCR(399.2,+$P(IBEPAR(1),"^",28),0)) W $S($P(X,"^")]"":$P(X,"^"),1:IBU)
 W ?42,"Suppress MT Ins Bulletin: ",$S($P(IBEPAR(0),"^",15)=1:"YES",$P(IBEPAR(0),"^",15)=0:"NO",1:IBU),!
 W ?4,"Default RX Dx Cd   : " S X=$$ICD9^IBACSV(+$P(IBEPAR(1),"^",29)) W $S(X'="":$P(X,U),1:IBU)
 W ?47,"Default RX CPT Cd  : " S X=$$CPT^IBACSV(+$P(IBEPAR(1),"^",30)) W $S(X'="":$P(X,U),1:IBU),!
 ;
4 S Z=4,IBW=1 X IBWW W " '001' for Total?   : "_$S($P(IBEPAR(1),"^",10)=1:"YES",$P(IBEPAR(1),"^",10)=0:"NO",1:IBU)
 W ?47,"Hold MT Bills W/Ins: ",$S($P(IBEPAR(1),"^",20)=1:"YES",$P(IBEPAR(1),"^",20)=0:"NO",1:IBU)
 W !?4,"Remark on each bill",?23,": ",$S($P(IBEPAR(1),"^",4)]"":$E($P(IBEPAR(1),"^",4),1,21),1:IBU)
 W ?47,"UB-92 Address Col  : " W $S($P(IBEPAR(1),U,31)]"":$P(IBEPAR(1),"^",31),1:IBU)
 W !?4,"Cancellation Remark",?23,": ",$S($P(IBEPAR(2),"^",7)]"":$E($P(IBEPAR(2),"^",7),1,21),1:IBU)
 W ?47,"HCFA 1500 Addr Col : " W $S($P(IBEPAR(1),U,27)]"":$P(IBEPAR(1),"^",27),1:IBU)
 ;
 W !?4,"Cancelled Mailgroup",?23,": ",$S($P(IBEPAR(1),"^",7):$P($G(^XMB(3.8,+$P(IBEPAR(1),"^",7),0)),"^",1),1:IBU)
 ;
 W ?47,"Disap. Mailgroup   : ",$S($P(IBEPAR(1),"^",9):$P($G(^XMB(3.8,+$P(IBEPAR(1),"^",9),0)),"^"),1:IBU),!
 W ?4,"Copay Mailgroup",?23,": ",$S($P(IBEPAR(0),"^",9):$P($G(^XMB(3.8,+$P(IBEPAR(0),"^",9),0)),"^"),1:IBU)
 W ?42,"Means Test Mailgroup    : ",$S($P(IBEPAR(0),"^",11):$P($G(^XMB(3.8,+$P(IBEPAR(0),"^",11),0)),"^"),1:IBU)
 ;
5 ;
 S Z=5,IBW=1 X IBWW W " Agent Cashier",?23,": ",$P(IBEPAR(2),"^",1)
 W ", ",$P(IBEPAR(2),"^",3),", "
 W $S($P(IBEPAR(2),"^",4):$P(^DIC(5,$P(IBEPAR(2),"^",4),0),"^",2),1:"")
 W "  ",$P(IBEPAR(2),"^",5)
 W !?4,"Phone",?23,": ",$S($P(IBEPAR(2),"^",6)]"":$P(IBEPAR(2),"^",6),1:IBU)
 W ?47,"Default Form Type  : " S X=$G(^IBE(353,+$P(IBEPAR(1),"^",26),0)) W $S($P(X,"^")]"":$P(X,"^"),1:IBU)
 W !?4,"Fac Billing Name",?23,": ",$P(IBEPAR(2),"^",10)
 W !?4,"Other Facility is Billing Facility: ",$$EXPAND^IBTRE(350.9,2.12,$P(IBEPAR(2),U,12))
CH D ^IBEPAR1 I $D(IBSCA) G IBEPAR
Q K IBEPAR,IBSCPP,IBSUP,IBSR,IBPAR,IBU,IBUN,IBV1,IBVI,IBVV,IBVO,IBW,IBWW,DIK,I,X,Y Q
 ;IBEPAR
