PRCABIL3 ;SF-ISC/YJK-APPROVE BILL ;10/7/93  2:54 PM
V ;;4.5;Accounts Receivable;;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
APPRV ;APPROVE BILL
 S DA=1 D SIG^PRCASIG Q:'$D(PRCANM)
A1 D SVC^PRCABIL G:'$D(PRCAP("S")) Q S DIC("S")="S Z0=$S($D(^PRCA(430.3,+$P(^(0),U,8),0)):$P(^(0),U,3),1:0) I Z0=205,$D(^PRCA(430,Y,100)),+$P(^(100),U,2)="_PRCAP("S")
 S PRCATIME=DTIME,DTIME=60 D BILLN^PRCAUTL S DTIME=PRCATIME G Q:'$D(PRCABN)
 L +^PRCA(430,PRCABN,0):0 I '$T W !,*7,"Another user is editing this bill" D KILLV G A1
 S PRCABT=+^PRCA(430,PRCABN,100) G Q:'PRCABT!(PRCABT>3)
YN1 S %=1 W !,"  Review Bill" D YN^DICN
 I %=0 W !,*7,"Answer 'Yes' or 'No' " G YN1
 I %<1 W !,*7,"This bill will still remain Pending Approval Bill. ",!! D KILLV G A1
 I %=1 S D0=PRCABN,IOP=0 D ^PRCABD I $P($G(^PRCA(430,PRCABN,3)),U,3) D
    .N X,X1 S X=$P($G(^(3)),U,3,7),X1=$P(X,U) ;NAKED FROM ABOVE LINE
    .W !,?28,"****AMENDED BILL INFO****"
    .W !,"Amended Date: ",$E(X1,4,5),"/",$E(X1,6,7),"/",$E(X1,2,3)
    .W ?50,"Amended Amount: ",$P(X,U,3),!
    .S X=$P(X,U,5),DIWL=10,DIWR=65,DIWF="W" D ^DIWP,^DIWW
    .Q
YN S %=2 W !," Approve this Bill" D YN^DICN
 I %=0 W !,*7,"Answer 'Yes' or 'No' " G YN
 I %=-1!(%=2) W !,*7,"This bill will still remain Pending Approval Bill.",!! D KILLV G A1
 S DA=PRCABN G:'$D(DUZ) Q S P=+DUZ,X=$S($D(^VA(200,P,20)):$P(^(20),U,2),1:"") D:X'="" EN^PRCASIG(.X,P,DA_+$P(^PRCA(430,DA,0),U,3))
 S PRCAX=+DUZ_"^"_X_"^^"_$S($D(^VA(200,+DUZ,20)):$P(^(20),U,3),1:"") D NOW^%DTC S $P(PRCAX,"^",3)=%
 S ^PRCA(430,PRCABN,104)=PRCAX,PRCA("STATUS")=$O(^PRCA(430.3,"AC",104,0)),PRCA("SDT")=DT
 I $P($G(^PRCA(430,PRCABN,9)),U,6)=$O(^PRCA(430.3,"AC",230,"")) S PRCA("STATUS")=$O(^PRCA(430.3,"AC",110,""))
 D UPSTATS^PRCAUT2 K PRCA("STATUS"),PRCA("SDT") W !,"*** This bill has been released to the AR section ***",!
 I PRCABT=3 G A1 ;Don't print 1114 form
ANW S %=1 W !,"Do you want to print a copy of this bill for your records " D YN^DICN G:(%<0)!(%=2) A1
 I %=0 W !,"The official bill will be printed by Fiscal Service. Enter 'Y' or 'YES'",!,"if you want to print a copy of the bill for your Service's records.",! G ANW
 K ZTSAVE S D0=PRCABN,PRCADFM=1,PRCARN="^PRCABP"_PRCABT,ZTSAVE("D0")="",ZTSAVE("PRCADFM")="" D OPENDV^PRCABPF D KILLV G A1
KILLV L -^PRCA(430,+$G(PRCABN),0)
 D ^%ZISC K %,%Y,A,B,C,D0,DA,DIC,DIE,DIK,DR,I,PRCABC,PRCABN,PRCABT,PRCADFM,PRCAI,PRCATIME,PRCAMT,PRCANM,PRCAKCT,PRCANQM,PRCAQ,PRCAP,PRCAT,PRCATY,PRCAX,X,Y,Z0,ZRTN,ZTSK,POP,PRCARN,PRCAK,P Q
Q D KILLV K PRCA Q
