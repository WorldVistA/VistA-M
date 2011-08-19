PRCABP2 ;SF-ISC/YJK-PRINT 1080 BILL ;9/10/93  9:47 AM
V ;;4.5;Accounts Receivable;**104,112**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 S PRCA0=$S($D(^PRCA(430,D0,0)):^(0),1:""),PRCA10=$S($D(^(100)):^(100),1:""),PRCA14=$S($D(^(104)):^(104),1:"")
 S PRCABN=D0,PRCA("DEBTNM")="",$P(PRCAUL,"_",97)="",U="^",CNT=0,PRCADFM=$S($D(PRCADFM):PRCADFM,1:0) S:IOBS="" IOBS="$C(8)"
ST W @IOF W !,"Standard Form 1080 (5-70)" W:$D(PRCAMEND) ?40,"AMENDED BILL" W ?75,"Voucher No. ",$S($P(PRCA10,U,4)]"":$P(PRCA10,U,4),1:"_________"),!?3,"2 Treasury FRM 2500",?35,"VOUCHER FOR TRANSFERS"
 W !?3,"1080-108",?27,"BETWEEN APPROPRIATIONS AND/OR FUNDS",?75,"Schedule No.________"
 W !,"Department or Establishment, Bureau or Office Billing: ",?75,"Bill No. ",$P(PRCA0,U,1) S Y=+$P(PRCA10,U,7) I '$D(^RC(342.1,Y,1)) W !! G ST1
 S Y=$P($G(^RC(342.1,Y,0)),"^")_"^"_^RC(342.1,Y,1) W !?9,$P(Y,U,1) W:$P(Y,U,2)]"" !?9,$P(Y,U,2)
 W:$P(Y,U,3)]"" !?9,$P(Y,U,3) W:$P(Y,U,4)]"" !?9,$P(Y,U,4)
 W !?9,$P(Y,U,5),", ",$S($D(^DIC(5,+$P(Y,U,6),0)):$P(^(0),U,2),1:"")," ",$P(Y,U,7),!
ST1 W !,"Department or Establishment, Bureau or Office Billed: ",?75,"PAID BY:" D DEBTOR^PRCAUTL W !?12,PRCA("DEBTNM") I '$D(PRCA("DEBTOR")) W !!!
 E  W !?12,PRCAST1 W:PRCAST2]"" !?12,PRCAST2 W !?12,PRCACT,", ",PRCAST," ",PRCAKP,!
 W ! D HDR S PRCAI=0,CNT=45
DES S PRCAI=$O(^PRCA(430,PRCABN,101,PRCAI)) G:'PRCAI ST2 S PRCAI0=^(PRCAI,0),PRCAD=0,DIWL=1,DIWR=40,DIWF="" K ^UTILITY($J,"W")
 F I=0:0 S PRCAD=$O(^PRCA(430,PRCABN,101,PRCAI,1,PRCAD)) Q:'PRCAD  S X=$S($D(^(PRCAD,0)):^(0),1:"") D ^DIWP
 S J=$S($D(^UTILITY($J,"W",DIWL)):^(DIWL),1:0),CNT=CNT-1 D:CNT-6<0 NEWP,HDR
 S Y=$P(PRCAI0,U,1) W $P(PRCAI0,U,7),?9,"|" D DT S PRCAKTM=""
 I J F PRCAKK=1:1:(J-1) W:PRCAKK>1 ?9,"|" W ?18,"| ",^UTILITY($J,"W",DIWL,PRCAKK,0),?60,"|",?68,"|",?77,"|",?83,"|",! K PRCAKTM S CNT=CNT-1 D:CNT-6<0 NEWP,HDR
 W:'$D(PRCAKTM) ?9,"|" W ?18,"|" W:$D(^UTILITY($J,"W",DIWL,J,0)) ^(0) W ?60,"|",$J($P(PRCAI0,U,3),7,$L($P($P(PRCAI0,U,3),".",2)))
 W ?68,"|",$J($P(PRCAI0,U,4),8,$S($L($P($P(PRCAI0,U,4),".",2))>2:4,1:2))
 W ?77,"| ",$S($D(^PRCD(420.5,+$P(PRCAI0,U,5),0)):$P(^(0),U,1),1:""),?83,"|",$J($P(PRCAI0,U,6),12,2)
 K PRCAKTM D LF S CNT=CNT-2 G DES
ST2 S CNT=CNT-6 W PRCAUL,!,"Remittance in payment hereof should be sent to: ",?75,"TOTAL, $",$J($P(PRCA0,U,3),12,2),! S Y=$$SADD^RCFN01(1) I Y="" W !! G ST3
 W !?8,"c/o Agent Cashier" W:$P(Y,U)]"" !?9,$P(Y,U) W:$P(Y,U,2)]"" !?9,$P(Y,U,2) W !?9,$P(Y,U,3),", ",$P(Y,U,4)," ",$P(Y,U,5)," ",$P(Y,U,6),!
ST3 S CNT=CNT-8 D:CNT<0 NEWP W PRCAUL,!
 W ?30,"ACCOUNTING CLASSIFICATION - Billing Office",!,PRCAUL,! S I=0 F J=0:1 S I=$O(^PRCA(430,PRCABN,2,I)) Q:'I  I $D(^(I,0)) S Y=^(0) W:$P(Y,U,4)]"" ?5,"APPROPRIATION: ",$P(Y,U,4),"     $ ",$J($P(Y,U,2),12,2),!
 F J=J:1:5 W ! I J=5,$P(PRCA14,U,2)]"",PRCADFM S DA=D0,P=+PRCA14,X=$P(PRCA14,U,2) D DE^PRCASIG(.X,P,DA_+$P(PRCA0,U,3)) W:X]"" "Approving Officer: /ES/ ",X,"     Date: " S Y=$P(PRCA14,U,3) D DT W !
 S CNT=CNT-15 D:CNT<0 NEWP W PRCAUL,!?30,"CERTIFICATE OF OFFICE BILLED",!!,?5,"I certify that the above articles were received and accepted or the services performed as",!
 W "stated and should be charged to the appropriation(s) and/or fund(s) as indicated below; or that,",!,"the advance payments requested is approved and should be paid as indicated.",!!
 W $E(PRCAUL,1,30),?45,$E(PRCAUL,1,50),!,?12,"(Date)",?46,"(Authorized administrative or certifying officer)",!!,?45,$E(PRCAUL,1,50),!,?66,"(Title)",!,PRCAUL,!
 W ?30,"ACCOUNTING CLASSIFICATION - Office Billed",!,PRCAUL,!!!!!,"Paid by Check No.: ",!
Q K CNT,D0,DA,PRCA,DIWF,DIWL,DIWR,I,J,PRCAKK,P,PRCA0,PRCA10,PRCA14,PRCABN,PRCACT,PRCAD,PRCADFM,PRCAI,PRCAI0,PRCAST,PRCAST1,PRCAST2,PRCAUL,PRCAKP,X,Y D:$D(ZTSK) KILL^%ZTLOAD K ZTSK Q
DT Q:Y=""  W $$SLH^RCFN01(Y,"/") Q
HDR W !,PRCAUL,!,?9,"|",?18,"|",?60,"|",?68,"|  Unit   Price|",!,"ORDER NO.|",?11,"Date   |",?28,"DESCRIPTION",?60,"|  Qty  |  Cost  | Per |   Amount",?96 F I=1:1:97 W @IOBS
 W PRCAUL S CNT=CNT-4
LF W !,?9,"|",?18,"|",?60,"|",?68,"|",?77,"|",?83,"|",! Q
NEWP W ?21,"CONTINUED ON NEXT PAGE",!,PRCAUL,@IOF,!!?5,"(CONTINUATION OF BILL)",?75,"Bill No. ",$P(PRCA0,U,1),!! S CNT=60 Q
