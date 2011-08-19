PRCSD122 ;WISC/SAW-CONTROL POINT ACT. 2237 TERM. DISP. CON'T ;4/21/93  08:46
V ;;5.1;IFCAP;**107**;Oct 20, 2000;Build 13
 ;Per VHA Directive 2004-038, this routine should not be modified.
 I IOSL-$Y<5 D NEWP^PRCSD121 Q:Z1=U
 W !,"JUSTIFICATION OF NEED OR TURN-IN"
 I '$D(^PRCS(410,DA,8,0)) G SIG
 S DIWL=1,DIWR=80,DIWF="" K ^UTILITY($J,"W") S X1=0 F I=1:1 S X1=$O(^PRCS(410,DA,8,X1)) Q:X1=""  S X=^(X1,0) D DIWP^PRCUTL($G(DA))
 S Z=^UTILITY($J,"W",DIWL) F K=1:1:Z D:IOSL-$Y<2 NEWP^PRCSD121 Q:Z1=U  W !,^UTILITY($J,"W",DIWL,K,0)
SIG ;PRINT SIGNATURE BLOCKS
 I IOSL-$Y<5 D NEWP^PRCSD121 Q:Z1=U
 W !,L
 W !,"Originator of Request: " S XNAME=$P($G(^PRCS(410,DA,14)),"^") I XNAME'="" W $P($G(^VA(200,XNAME,0)),"^")
 W !,"Signature of Initiator",?37,"Signature of Approving Official Date"
 I '$D(^PRCS(410,DA,7)) W ! G SIG1
 W !,?37 K P1 S:$P(^PRCS(410,DA,7),U,3)'="" (P,P1)=$P(^(7),U,3) I $D(P1),$P(^(7),U,6)'="" W "/ES/",$$DECODE^PRCSC1(DA)
 N PRSHLB S PRSHLB=^DD(410,40,0) W ?69,! I $P(^PRCS(410,DA,7),U)'="" S (P,P2)=$P(^(7),U) I $P(PRSHLB,"^",2)[200,$D(^VA(200,P,20)),$P(^(20),U,2)]"" W $E($P(^(20),U,2),1,28)
 I $D(P2),$P(PRSHLB,"^",2)[200,$D(^VA(200,+P2,.13)),$L($P(^(.13),U,2))'>5 W " (",$P(^(.13),U,2),")"
 N PRSHLC S PRSHLC=^DD(410,42,0) K P2 W ?37 I $D(P1),$P(PRSHLC,"^",2)[200,$D(^VA(200,P1,20)),$P(^(20),U,2)]"" W $E($P(^(20),U,2),1,30)
 W ?69,! W:$P(^PRCS(410,DA,7),U,2)'="" $P(^(7),U,2) W ?37 W:$P(^(7),U,4)'="" $P(^(7),U,4) W ?69 I $P(^(7),U,5)'="" S Y=$P(^(7),U,5) D DD^%DT W Y
SIG1 W !,$E(L,1,36)
 W " ",$E(L,38,68)
 W "------------" I IOSL-$Y<5 D NEWP^PRCSD121 Q:Z1=U
 W !,"Appropriation and Accounting Symbols"
 S P=$P(^PRCS(410,DA,0),U,5) I $D(^(3)) S X=^(3) S:$P(X,U,2)'="" P=P_"-"_$P(X,U,2) S:$P(X,U)'="" P=P_"-"_$P($P(X,U)," ") S:$P(X,U,3)'="" P=P_"-"_$P($P(X,U,3)," ")
 S:$D(PRCS("SUB")) P=P_"-"_PRCS("SUB")
 I $D(^PRCS(410,DA,4)),$P(^(4),U,5)'="" S P=P_"-"_$P(^(4),U,5)
 S FPROJ=$P($G(^PRCS(410,DA,3)),"^",12) S P=P_" "_FPROJ
 W !,P,!,L
 Q
