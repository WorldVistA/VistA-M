IBTOBI1 ;ALB/AAS - CLAIMS TRACKING BILLING INFORMATION PRINT ;27-OCT-93
 ;;2.0;INTEGRATED BILLING;**276,377**;21-MAR-94;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
% ;
 F IBTAG="INS","BI","SC","CLIN^IBTOBI4","IR^IBTOBI2","HR^IBTOBI3" D @IBTAG Q:IBQUIT
 Q
 ;
INS ; -- print ins. stuff
 N TAB,TAB2,IBALLIN,IBDT,IBINS,IBCNT,I,X,IBI,PHON,PHON2,PHON3,P,IBI
 S TAB=5,TAB2=45,IBALLIN=1
 S IBDT=$P(IBTRND,"^",6)
 I '$G(IBDT) S IBDT=DT
 W !,"  Insurance Information "
 ;
 D ALL^IBCNS1(DFN,"IBINS",1,IBDT)
 I $G(IBINS(0))<1 W !,?TAB,"No Insurance Information",!!! G INSQ
 S IBI=0,IBCNT=0 F  S IBI=$O(IBINS(IBI)) Q:'IBI!(IBQUIT)  S IBINS=IBINS(IBI,0) D  Q:IBQUIT
 .S IBCNT=IBCNT+1
 .I ($Y+8)>IOSL D HDR^IBTOBI Q:IBQUIT
 .I IBCNT>1 W !
 .W !?TAB,"     Ins. Co "_IBCNT_": ",$E($P($G(^DIC(36,+IBINS,0)),"^"),1,23)
 .S X=$G(^DIC(36,+IBINS,.13))
 .S PHON=$S($P(X,"^",3)'="":$P(X,"^",3),1:$P(X,"^"))
 .S PHON2=$S($P(X,"^",2)'="":$P(X,"^",2),1:$P(X,"^"))
 .S P=$S($P(IBETYP,"^",3)=1:5,$P(IBETYP,"^",3)=2:6,$P(IBETYP,"^",3)=3:11,1:1)
 .S PHON3=$S($P(X,"^",P)'="":$P(X,"^",P),1:$P(X,"^"))
 .W ?TAB2,"Pre-Cert Phone: ",PHON
 .W !?TAB,"        Subsc.: ",$P(IBINS,"^",17)
 .W ?TAB2,"          Type: ",$E($P($G(^IBE(355.1,+$P($G(^IBA(355.3,+$P(IBINS,"^",18),0)),"^",9),0)),"^"),1,18)
 .W !?TAB,"     Subsc. ID: ",$P(IBINS,"^",2)
 .W ?TAB2,"         Group: ",$$GRP^IBCNS($P(IBINS,"^",18))
 .W !?TAB,"     Coord Ben: ",$E($$EXPAND^IBTRE(2.312,.2,$P(IBINS,"^",20)),1,18)
 .W ?TAB2," Billing Phone: ",PHON2
 .W !,?TAB,"Filing Time Fr: ",$$EXPAND^IBTRE(36,.12,$P($G(^DIC(36,+IBINS,0)),"^",12))
 .W ?TAB2,"  Claims Phone: ",PHON3
 .S X=$P($G(IBINS(IBI,1)),"^",8) I X'="" W !,"     Policy Comment: " W:($L(X)+23)>IOM ! W " ",X
 .D COMM(+$P(IBINS,"^",18))
 .Q:IBQUIT
 .W !?30,"-----------------------------------"
 W:'IBQUIT !?4,$TR($J(" ",IOM-8)," ","-"),!
INSQ Q
 ;
BI ; -- print billing information
 Q:$D(IBCTHDR)
 I ($Y+8)>IOSL D HDR^IBTOBI Q:IBQUIT
BI1 W !,"  Billing Information "
 N IBDGCR,IBDGCRU1,IBDGCRU,IBAMNT,IBD,I,IBIFN,IBLN,IBECME
 S IBIFN=+$P(IBTRND,"^",11)
 S IBDGCR=$G(^DGCR(399,IBIFN,0)),IBDGCRU1=$G(^("U1")),IBDGCRU=$G(^("U"))
 S IBECME=$P($P($G(^DGCR(399,IBIFN,"M1")),U,8),";")
 S IBAMNT=$$BILLD^IBTRED1(IBTRN)
 S IBLN=0
 S IBLN=IBLN+1,IBD(IBLN,1)="  Initial Bill: "_$P(IBDGCR,U,1)
 I IBECME D
 . S IBD(IBLN,1)=IBD(IBLN,1)_"e"
 . S IBLN=IBLN+1,IBD(IBLN,1)="   ECME Number: "_IBECME
 S IBLN=IBLN+1,IBD(IBLN,1)="   Bill Status: "_$E($$EXPAND^IBTRE(399,.13,$P(IBDGCR,U,13)),1,14)
 S IBLN=IBLN+1,IBD(IBLN,1)=" Total Charges: $ "_$J($P(IBAMNT,"^"),8)
 S IBLN=IBLN+1,IBD(IBLN,1)="   Amount Paid: $ "_$J($P(IBAMNT,"^",2),8)
 ;
 I $P(IBTRND,U,19) D
 . S IBLN=IBLN+1,IBD(IBLN,1)="Reason Not Billable: "_$$EXPAND^IBTRE(356,.19,$P(IBTRND,U,19))
 . S IBLN=IBLN+1,IBD(IBLN,1)="Additional Comment: "_$P(IBTRND1,U,8)
 . Q
 ;
 I '$P(IBTRND,U,19),$L($P(IBTRND1,U,8))>0 S IBLN=IBLN+1,IBD(IBLN,1)="Additional Comment: "_$P(IBTRND1,U,8)
 ;
 S IBD(1,2)="Estimated Recv (Pri): $ "_$J($P(IBTRND,"^",21),8)
 S IBD(2,2)="Estimated Recv (Sec): $ "_$J($P(IBTRND,"^",22),8)
 S IBD(3,2)="Estimated Recv (ter): $ "_$J($P(IBTRND,"^",23),8)
 S IBD(4,2)="  Means Test Charges: $ "_$J($P(IBTRND,"^",28),8)
 ;
 S I=0 F  S I=$O(IBD(I)) Q:'I  W !,$G(IBD(I,1)),?39,$E($G(IBD(I,2)),1,36)
 W:'IBQUIT !,?4,$TR($J(" ",IOM-8)," ","-")
 Q
 ;
SC ; -- print SC information
 I ($Y+7)>IOSL D HDR^IBTOBI Q:IBQUIT
 N VAEL,TAB,IBTRCSC
 D ELIG^VADPT
 W !!,"  Eligibility Information"
 W !,"       Primary Eligibility: "_$P(VAEL(1),"^",2)
 W !,"         Means Test Status: "_$P(VAEL(9),"^",2)
 W !," Service Connected Percent: "_$S(+VAEL(3):+$P(VAEL(3),"^",2)_"%",1:"")
 I 'VAEL(3) W "Patient Not Service Connected",!! G SCQ
 S TAB=5,IBTRCSC=1 D SC^IBTOAT2
SCQ W:'IBQUIT !?4,$TR($J(" ",IOM-8)," ","-"),!
 Q
 ;
COMM(DA) ; -- print comments from GROUP plans.
 Q:IBQUIT
 W !,"Group Plan Comments: "
 Q:'$D(^IBA(355.3,DA,11))
 K ^UTILITY($J,"W")
 S DIWL=10,DIWR=IOM-12,DIWF="W"
 S IBJ=0 F  S IBJ=$O(^IBA(355.3,DA,11,IBJ)) Q:'IBJ  S X=^(IBJ,0) D ^DIWP I IOSL<($Y+3) Q:IBQUIT  D HDR^IBTOBI
 Q:IBQUIT
 D ^DIWW
 K ^UTILITY($J,"W")
 Q
