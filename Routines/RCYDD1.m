RCYDD1 ;WASH-ISC@ALTOONA,PA/RGY-DD CALL UTILITIES ;8/27/96  5:35 PM
V ;;4.5;Accounts Receivable;**9,48,128**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
PN ;Called by the input transform in field 344.01,.09
 N RCY,RCY1,RCY2,Y
 I $L(X)>20!($L(X)<1) K X Q
 S RCY=X,X=$S($O(^PRCA(430,"B",X,0)):$O(^(0))_";PRCA(430,",$O(^PRCA(430,"D",X,0)):$O(^(0))_";PRCA(430,",1:X) I X[";PRCA(430," D DIS
 I X=RCY S DIC="^DPT(",DIC(0)="EM" D ^DIC S X=+Y_";DPT("
 I +$G(Y)<0,(RCYTYP=4) D
 .S (X,Y)=$$REC^IBRFN(RCY),X=X_";PRCA(430,"
 .I Y>0 D
 ..N DIR,DIRUT
 ..S DIR("A")="Is this TRICARE reference number - "_RCY,DIR("B")="No",DIR("A",1)=" "
 ..S RCY=X
 ..S DIR(0)="Y^O" D ^DIR S:'Y Y=-1
 ..I Y>0 S X=RCY W !!,$P($G(^PRCA(430,+X,0)),"^")," " D DIS
 I +$G(Y)<0 K X Q
 S RCY=X I RCY[";DPT(" D CHK(+RCY) G Q2
 I $$IB^IBRUTL(+RCY) W *7," ... This bill appears to have other patient bills on 'hold'."
 S X=$P($G(^RCD(340,+$P(^PRCA(430,+RCY,0),"^",9),0)),"^") I X[";DPT(" D CHK(+X)
Q2 S X=RCY Q
DIS ;DISPLAY BILL INFO
 NEW RCY
 S RCY=$P(^PRCA(430,+X,0),"^",9) W:RCY "  ",$$NAM^RCFN01(RCY)
 S RCY=$P(^PRCA(430,+X,0),"^",8) I RCY W "   ",$P(^PRCA(430.3,RCY,0),"^") I $P(^(0),"^",3)'=102,$P($G(^RCD(340,+$P(^PRCA(430,+X,0),"^",9),0)),"^")'[";DPT(" W *7,!,"This bill is not in 'active' status."
 S RCY=$G(^PRCA(430,+X,7)) W "   $",$J($P(RCY,"^")+$P(RCY,"^",2)+$P(RCY,"^",3)+$P(RCY,"^",4)+$P(RCY,"^",5),1,2)
 Q
PAY ;Called by the input transform of field 344.01,.04
 NEW Y,I,AMT,PROC
 S Y=$P($G(^RCY(344,DA(1),1,DA,0)),"^",3),AMT=0
 S PROC=$P($G(^RCY(344,DA(1),0)),"^",11)
 G:Y'[";PRCA(430," Q1
 G:$P($G(^RCD(340,+$P($G(^PRCA(430,+Y,0)),"^",9),0)),"^")[";DPT(" Q1
 S Y(1)=Y,Y=$G(^PRCA(430,+Y,7)) F I=1:1:5 S AMT=AMT+$P(Y,"^",I)
 I X>AMT W *7,"  Payment amount greater than amount of bill!",*7
 S AMT(1)=$$EOB^IBCNSBL2(+Y(1),+$P($G(^PRCA(430,+Y(1),0)),"^",3),$$PAID^PRCAFN1(+Y(1)))
 I AMT(1) D
 .W !!,$P(AMT(1),"^",2)," may also be billable.",*7,!
Q1 Q
DEF(DEB) ;Get default for payment amount (used in input templates for payments)
 NEW X
 S X=0 G:'$G(DEB) Q3
 I DEB[";DPT(" S X=$$BAL^PRCAFN(DEB) G Q3
 I DEB[";PRCA(430,",",112,107,102,"[(","_$P($G(^PRCA(430.3,+$P($G(^PRCA(430,+DEB,0)),"^",8),0)),"^",3)_",") S X=$G(^PRCA(430,+DEB,7)),X=$P(X,"^")+$P(X,"^",2)+$P(X,"^",3)+$P(X,"^",4)+$P(X,"^",5) G Q3
Q3 Q "<"_$J(X,1,2)_">"
DOP ;Make sure date of payment not in future or more than one month ago
 NEW DATE
 S DATE=X,X2=DT,X1=X D ^%DTC
 I X<-31!(X>0) K X G Q4
 S X=DATE
Q4 Q
CHK(DFN) ;Check copay exemption status and RX potential charges
 S X="IBARXEU" X ^%ZOSF("TEST") I $T S X=$$RXST^IBARXEU(DFN,DT) I X W *7,!?2,"* Patient is exempt from RX Copay: ",$P(X,"^",4)," *"
 S X="PSOCOPAY" X ^%ZOSF("TEST") I $T S X=$$POT^PSOCOPAY(DFN) I X W *7,!?2,"* This patient has ",X,"-30 day RX's totaling $",(X*2),".00 that are potentially *"
 I  W !,"* billable.  This represents any Window Rx's issued today. *"
 Q
REC ;Called by the 344,.01 input transform.  Make sure duplicate receipts cannot be created.
 I $O(^RCY(344,"B",X,""))!$O(^PRCA(433,"AF",X,"")) K X W !,"Receipt already in use, please use another receipt number!" K X
 Q
STAT(RCYC) ;Called by the 344,100 field to return status of receipt
 NEW X,Y
 D NOW^%DTC
 S Y=$G(^RCY(344,RCYC,0)) S X="N/A" S:$P(Y,"^",2)]"" X="OPEN" S:$P(Y,"^",7)]"" X="APPROVED" S:$P(Y,"^",9)]"" X="POSTING"
 I $P(Y,"^",10)]"" S X="POSTED" S:'$O(^RCY(344,RCYC,1,0)) X="VOIDED"
 S:$P(Y,"^",5)>% X="QUEUED"
 I $P(Y,"^",9)]"",$P(Y,"^",10)="" L +^RCY(344,RCYC,0):1 I $T L -^RCY(344,RCYC,0) S X="ERRORED"
 Q X
NOT(REC) ;Called to calculate the number of transaction for a receipt (344,101)
 NEW Y,TOT
 S TOT=0
 F Y=0:0 S Y=$O(^RCY(344,+$G(REC),1,Y)) Q:'Y  S TOT=TOT+1
 Q TOT
