PRCSP122 ;WISC/SAW-CONTROL POINT ACTIVITY 2237 PRINTOUT CON'T ;4/21/93  08:53
V ;;5.1;IFCAP;**95,107**;Oct 20, 2000;Build 13
 ;Per VHA Directive 2004-038, this routine should not be modified.
 I '$D(^PRCS(410,DA,"RM",0)) G DEL
 I $D(^PRCS(410,DA,"RM",0)) W ! S P(1)=0,DIWL=6,DIWR=96,DIWF="" K ^UTILITY($J,"W") S X="SPECIAL REMARKS:" D DIWP^PRCUTL($G(DA)) F J=1:1 S P(1)=$O(^PRCS(410,DA,"RM",P(1))) Q:P(1)=""  S X=^(P(1),0) D DIWP^PRCUTL($G(DA))
 S Z=^UTILITY($J,"W",DIWL) F K=1:1:Z D:$Y>62 NEWP^PRCSP121 W !,^UTILITY($J,"W",DIWL,K,0)
DEL I $D(^PRCS(410,DA,9)),$P(^(9),U)'="" W !,"DELIVER TO: ",$P(^(9),U)
 W !,L,!,"FOB",?24,"|TERMS",?48,"|DELIVERY DATE",?63,"|QUOTE DATE",?77,"|BY(Initials)",!,?24,"|",?48,"|",?63,"|",?77,"|"
 W !,$E(L,1,24),"|",$E(L,1,23),"|",$E(L,1,14),"|",$E(L,1,13),"|",$E(L,1,12)
 I $Y>58 D NEWP^PRCSP121
 W !,"JUSTIFICATION OF NEED OR TURN-IN (If recurring need, indicate 30-day estimate. If turn-in,",!,"do not use this form if circumstances require use of VA Form 90-1217, Report of Survey)"
 I '$D(^PRCS(410,DA,8,0)) G SIG
 S (MYTEMP,BFLAG)=0
 F I=1:1 S MYTEMP=$O(^PRCS(410,DA,8,MYTEMP)) Q:MYTEMP=""  S BFLAG=1
 I BFLAG=0  G SIG
 S DIWL=6,DIWR=96,DIWF="" K ^UTILITY($J,"W") S X1=0 F I=1:1 S X1=$O(^PRCS(410,DA,8,X1)) Q:X1=""  S X=^(X1,0) D DIWP^PRCUTL($G(DA))
 S Z=^UTILITY($J,"W",DIWL) F K=1:1:Z D:$Y>62 NEWP^PRCSP121 W !,^UTILITY($J,"W",DIWL,K,0)
SIG ;PRINT SIGNATURE BLOCKS
 I $Y>58 D NEWP^PRCSP121
 W !,L
 W !,"Originator of Request: " S XNAME=$P($G(^PRCS(410,DA,14)),"^") I XNAME'="" W $P($G(^VA(200,XNAME,0)),"^")
 W !,"Signature of Initiator",?39,"|Signature of Approving Official |Date"
 I '$D(^PRCS(410,DA,7)) W !,?39,"|",?72,"|",!,?39,"|",?72,"|" G SIG1
 K P1 W !,?39,"|" S:$P(^PRCS(410,DA,7),U,3)'="" (P,P1)=$P(^(7),U,3) I $D(P1) W "/ES/",$$DECODE^PRCSC1(DA)
 N PRSHLE S PRSHLE=^DD(410,40,0) W ?72,"|",! I $P(^PRCS(410,DA,7),U)'="" S (P,P2)=$P(^(7),U) I $P(PRSHLE,"^",2)[200,$D(^VA(200,P,20)),$P(^(20),U,2)]"" W $E($P(^(20),U,2),1,31)
 I $D(P2),$P(^DD(410,40,0),"^",2)[200,$D(^VA(200,+P2,.13)),$L($P(^(.13),U,2))'>5 W " (",$P(^(.13),U,2),")"
 K P2 W ?39,"|" I $D(P1),$P(^DD(410,42,0),"^",2)[200,$D(^VA(200,P1,20)),$P(^(20),U,2)]"" W $E($P(^(20),U,2),1,33)
 W ?72,"|",! W:$P(^PRCS(410,DA,7),U,2)'="" $P(^(7),U,2) W ?39,"|" W:$P(^(7),U,4)'="" $P(^(7),U,4) W ?72,"|" S Y=$S($P(^(7),U,7):$P(^(7),U,7),1:$P(^(7),U,5)) I Y D DD^%DT W Y
SIG1 W !,$E(L,1,39)
 W "|",$E(L,1,32)
 W "|",$E(L,1,17) Q:PRNTALL=0  I $Y>41 D NEWP^PRCSP121
 Q
