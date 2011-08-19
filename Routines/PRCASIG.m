PRCASIG ;WASH-ISC@ALTOONA,PA/CMS-AR ELEC SIGNATURE CODE ;11/6/92  2:19 PM
V ;;4.5;Accounts Receivable;;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EN(X,X1,X2) ;Enter Electronic Signature Code.
 I '$D(X)!('$D(X1))!('$D(X2)) Q
 D EN^XUSHSHP
 Q
DE(X,X1,X2) ;Display Electronic Signature Code.
 I '$D(X)!('$D(X1))!('$D(X2)) Q
 D DE^XUSHSHP
 Q
SIG ;ask Electronic Signature Code and verify.
 K PRCANM Q:'DUZ!('$D(DA))  I $D(^VA(200,DUZ,20)),$P(^(20),U,4)]"" S PRCAKCT=0,PRCANM=$P(^(20),U,4) G SIG1
 W !?5,"Your Electronic Signature Code is undefined." K PRCAKCT Q
SIG1 W !,"Enter Electronic Signature Code: " X ^%ZOSF("EOFF") R X:DTIME X ^%ZOSF("EON") G:$E(X)="^"!(X="")!('$T) SIGQ I X["?",$L(X)<6 D SIGH G SIG1
 S PRCAKCT=PRCAKCT+1 D HASH^XUSHSHP I X'=PRCANM G SIG1:PRCAKCT<3,SIGQ
 K PRCAKCT S P=DUZ,X=$S($D(^VA(200,P,20)):$P(^(20),U,2),1:"") G:X="" SIGQ
 D EN(.X,P,DA_$S($P($G(^PRCA(430,DA,0)),U,2)=$O(^PRCA(430.2,"AC",33,0)):+$P(^PRCA(430,DA,7),U,18),$P($G(^PRCA(430,DA,0)),U,3)>0:+$P(^PRCA(430,DA,0),U,3),1:"")) I X="" K PRCANM,P Q
 S PRCANM=X W "    <Signature verified>" Q
SIGQ W " <Signature Failed> ",*7 K PRCANM,PRCAKCT Q
SIGH W !!,"Enter in your Electronic Signature Code, 6 to 20 characters.",! Q
