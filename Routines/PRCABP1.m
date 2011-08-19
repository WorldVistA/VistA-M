PRCABP1 ;SF-ISC/RSD-PRINT 1081 BILL ;4/6/94  3:13 PM
V ;;4.5;Accounts Receivable;**104,112**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 NEW STATE
 S PRCA0=$S($D(^PRCA(430,D0,0)):^(0),1:""),PRCA10=$S($D(^(100)):^(100),1:""),PRCA14=$S($D(^(104)):^(104),1:""),PRCA7=$S($D(^(7)):^(7),1:"")
 S $P(PRCAUL,"_",97)="",U="^",CNT=0,PRCADFM=$S($D(PRCADFM):PRCADFM,1:0) S:IOBS="" IOBS="$C(8)"
ST W @IOF W !,"Standard Form 1081 (9-82)" W:$D(PRCAMEND) ?39,"AMENDED BILL" W ?77,"Bill No. ",$P(PRCA0,U,1),!?3,"Dept. of the Treasury",?35,"VOUCHER AND SCHEDULE",?68,"Transaction Date: " S Y=$P(PRCA0,U,10) D DT
 W !?3,"I TFRM 2-2500",?31,"OF WITHDRAWALS AND CREDITS",?73,"Document No. ",$P(PRCA10,U,8)
 W !!,"Charge and credit will be reported on customer agency",!,"statement of transactions for account period ending _______________",!,PRCAUL,!,?17,"CUSTOMER AGENCY",?47,"|",?65,"BILLING AGENCY"
 W !,"Location Code (ALC)",?23,"|",?28,"Voucher No.",?47,"| Location Code (ALC)",?71,"|",?76,"Voucher No."
 W !?23,"|",?47,"|  ",$S($P(PRCA10,U,3)]"":$P(PRCA10,U,3),1:""),?71,"|  ",$S($P(PRCA10,U,4)]"":$P(PRCA10,U,4),1:""),!?23,"|",?47,"|",?71,"|",?96 F I=1:1:97 W @IOBS
 W PRCAUL,!,"Department Bureau Address",?47,"|",?50,"Department Bureau Address",!?47,"|"
 S Y=+$P(PRCA0,U,9),X=$S($D(^RCD(340,Y,0)):$P(^(0),U,1),1:""),X(1)="" S:X]"" X(1)=$S($D(@("^"_$P(X,";",2)_+X_",0)")):$P(^(0),U,1),1:"")
 S PRCADB=$S($D(^RCD(340,+Y,0)):$P(^(0),"^"),1:"") S X=$$DADD^RCAMADD(PRCADB) K PRCADB S J=2,II=0 D ADD
 S Y=+$P(PRCA10,U,7),X=$P($G(^RC(342.1,+Y,0)),"^")_"^"_$S($D(^RC(342.1,Y,1)):^(1),1:"")
 S STATE=$P(X,U,6) S:STATE $P(X,U,6)=$P($G(^DIC(5,STATE,0)),U,2)
 S PRCAT=$P(X,U,8),J=6,II=1 D ADD F I=1:1:5 W !?1 W:$D(X(I)) X(I) W ?47,"| " W:$D(X(I+5)) X(I+5)
 W !,PRCAUL,!?20,"SUMMARY",?47,"|",?68,"SUMMARY",!,"Appro., Fund, or Receipt Symbol  |",?36,"Amount",?47,"|Appro., Fund, or Receipt Symbol  |",?85,"Amount",?96 F I=1:1:97 W @IOBS
 W PRCAUL D LF F I=0:0 S I=$O(^PRCA(430,D0,2,I)) Q:'I  I $D(^(I,0)) S X=^(0) W !?32,"| ",$J($P(X,U,2),12,2),?47,"|",?55,$P(X,U,4),?81,"| ",$J($P(X,U,2),12,2) D LF
 D LF W !,"(Must agree with Billing",?32,"|",$E(PRCAUL,1,14),"| (Must agree with Customer",?81,"|",$E(PRCAUL,1,14)
 W !?6,"Agency total)",?26,"TOTAL  ",$J($P(PRCA0,U,3),12,2),?47,"|",?54,"Agency total)",?75,"TOTAL  ",$J($P(PRCA0,U,3),12,2)
 D HDR S PRCAI=0,CNT=45
DES S PRCAI=$O(^PRCA(430,D0,101,PRCAI)) G:'PRCAI ST2 S PRCAI0=^(PRCAI,0),PRCAD=0,DIWL=1,DIWR=85,DIWF="" K ^UTILITY($J,"W")
 F I=0:0 S PRCAD=$O(^PRCA(430,D0,101,PRCAI,1,PRCAD)) Q:'PRCAD  S X=$S($D(^(PRCAD,0)):^(0),1:"") D ^DIWP
 S J=$S($D(^UTILITY($J,"W",DIWL)):^(DIWL),1:0)
 F PRCAKK=1:1:J W ?6,^UTILITY($J,"W",DIWL,PRCAKK,0),! S CNT=CNT-1 D:CNT-5<0 NEWP,HDR
 G DES
ST2 S CNT=CNT-5,Y=$P(PRCA7,U,6) W !,"BILLING AGENCY CONTACT:",?48,"Approved By: " W:Y="" $E(PRCAUL,1,30) I Y]"",$D(^VA(200,Y,20)),$P(^(20),U,2)]"" W $P(^(20),U,2)
 W !,"Prepared By: " S X=$P(PRCA14,U,2) W:X="" $E(PRCAUL,1,30) I X]"" S DA=D0,P=+PRCA14 D DE^PRCASIG(.X,P,DA_+$P(PRCA0,U,3)) W:X]"" "/ES/ " W X
 W ?48,"Telephone No. ",PRCAT,!
 S CNT=CNT-8 D:CNT<0 NEWP W PRCAUL,!
 W ?30,"CERTIFICATION OF CUSTOMER OFFICE",!!?5,"I certify that the items listed herein are correct and proper for payment from and to",!,"the appropriation(s) designated.",!!
 W $E(PRCAUL,1,30),?46,$E(PRCAUL,1,50),!,?12,"(Date)",?46,"(Authorized administrative or certifying officer)",!!,$E(PRCAUL,1,30),!?8,"(Telephone No.)",!,PRCAUL,!!
Q K CNT,D0,DA,DIWF,DIWL,DIWR,I,II,J,PRCAKK,P,PRCA0,PRCA7,PRCA10,PRCA14,PRCAD,PRCADFM,PRCAI,PRCAI0,PRCAT,PRCAUL,X,Y D:$D(ZTSK) KILL^%ZTLOAD K ZTSK Q
DT Q:Y=""  W $$SLH^RCFN01(Y,"/") Q
HDR W !,PRCAUL,!,"Details of charges or reference to attached supporting documents",!! S CNT=CNT-2 Q
LF W !,?32,"|",?47,"|",?81,"|" Q
ADD F I=1:1:4 S:I<4&($P(X,U,I)]"") X(J)=$P(X,U,I),J=J+1 S:I=4 X(J)=$P(X,U,4+II)_", "_$P(X,U,5+II)_" "_$P(X,U,6+II)
 Q
NEWP W ?21,"CONTINUED ON NEXT PAGE",!,PRCAUL,@IOF,!!?5,"(CONTINUATION OF BILL)",?75,"Bill No. ",$P(PRCA0,U,1),!! S CNT=60 Q
