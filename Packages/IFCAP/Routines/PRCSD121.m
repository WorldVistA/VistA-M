PRCSD121 ;WISC/SAW/BMM-CONTROL POINT ACTIVITY 2237 DISPLAY CON'T ; 3/30/05 9:59am
 ;;5.1;IFCAP;**70,81**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;PRINT ITEMS
 ;
 ;BMM PRC*5.1*81 edit PRCARD to also display new fields DM Doc ID 
 ;(410.02, 17) and Date Needed By (410.02, 18) for 2237s originating
 ;from DynaMed requisitions
 ;
 I $D(^PRCS(410,DA,1)),$P(^(1),U,5)'="" S P=$P(^(1),U,5),P=$P($G(^PRCS(410.2,P,0)),U) W !,?13,P,":"
 S DIWL=13,DIWR=51,DIWF="",P(1)=0
 F I=1:1 K ^UTILITY($J,"W") S P(1)=$O(^PRCS(410,DA,"IT",P(1))) G VENDOR:P(1)'?1N.E D ITEM1
ITEM1 Q:'$D(^PRCS(410,DA,"IT",P(1),0))  S Z=^(0)
 D:IOSL-$Y<3 NEWP Q:Z1=U
 S P(4)=$P(Z,U,6) I $L(P(4))>12 W !,$E(P(4),1,13),!,$E(P(4),13,24)
 I $L(P(4))<13 W !,P(4)
 ;The variable Z is equal to ^PRCS(410,DA,"IT",P(1),0)
 S PRCS("SUB")=+$P(Z,U,4),P(3)=$P(Z,U,3) S P(3)=$S($D(^PRCD(420.5,+P(3),0)):$P(^(0),U,1),1:"")
 S P(0)=$S($P(Z,U,2)[".":$J($P(Z,U,2),9,2),1:$J($P(Z,U,2),9))_" "_$J(P(3),4)_" "_$S($P(Z,U,7)="N/C":$J("N/C",9),1:$J($P(Z,U,7),9,4))
 G PRCARD:$P(Z,U,5)
 S P(2)=0 F I=1:1 S P(2)=$O(^PRCS(410,DA,"IT",P(1),1,P(2))) Q:P(2)=""  S X=^(P(2),0) S:I=1 X=$P(^PRCS(410,DA,"IT",P(1),0),U,1)_" "_X D DIWP^PRCUTL($G(DA))
ITEM2 I '$D(^UTILITY($J,"W",DIWL)) S ^(DIWL)=1,^(DIWL,1,0)="***NO DESCRIPTION***"
 S Z=^UTILITY($J,"W",DIWL)
 I Z>1 F J=1:1:(Z-1) W ?13,^UTILITY($J,"W",DIWL,J,0) D:IOSL-$Y<2 NEWP Q:Z1=U  W !
 I Z>1 W ?13,^UTILITY($J,"W",DIWL,Z,0),?52,P(0) D:IOSL-$Y<2 NEWP Q:Z1=U  W !
 I Z<2 W ?13,^UTILITY($J,"W",DIWL,1,0),?52,P(0) D:IOSL-$Y<2 NEWP Q:Z1=U  W !
 Q
PRCARD S P("PR")=$P(^PRCS(410,DA,"IT",P(1),0),U,5) G ITEM2:'$D(^PRC(441,P("PR"),1,0))
 S P("PR1")=0,X=$P(^PRCS(410,DA,"IT",P(1),0),U)_" ITEM ID NO. "_P("PR") D DIWP^PRCUTL($G(DA)) F I=1:1 S P("PR1")=$O(^PRC(441,P("PR"),1,P("PR1"))) Q:P("PR1")=""  S X=^(P("PR1"),0) D DIWP^PRCUTL($G(DA))
 S Z="" S:$P(^PRC(441,P("PR"),0),U,5)'="" Z=Z_" (NSN: "_$P(^(0),U,5)_")" S Z1=$P(^PRCS(410,DA,3),U,4) I Z1,$D(^PRC(441,P("PR"),2,Z1,0)) S:$P(^(0),U,5)'="" Z=Z_" (NDC: "_$P(^(0),U,5)_")" S:$P(^(0),U,3) Z2=$P(^(0),U,3)
 S:$P($G(^PRC(441,P("PR"),3)),U,7)'="" Z=Z_" FOOD GROUP: "_$P(^(3),U,7)
 I Z1,$D(^PRC(441,P("PR"),2,Z1,0)) S Z=Z_" PKG: "_$P(^(0),U,8)_" per "_$S($D(^PRCD(420.5,+$P(^(0),U,7),0)):$P(^(0),U),1:"")
 I Z1,$D(Z2),$D(^PRC(440,Z1,4,Z2,0)),$P(^(0),U,1)'="" S Y=$S($P(^(0),U,2):$P(^(0),U,2),1:"") X:Y ^DD("DD") S Z=Z_" (CONTRACT # "_$P(^PRC(440,Z1,4,Z2,0),U,1)_$S(Y'="":", EXPIRATION DATE: "_Y_")",1:")") K Z2
 S X=Z D:$L(X) DIWP^PRCUTL($G(DA))
 ;PRC*5.1*81 check DynaMed switch, if DM Doc ID exists, if so then 
 ;add to display
 I $$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")=1,$P($G(^PRCS(410,DA,"IT",P(1),4)),U)]"" D
 . S X="DM Doc ID: "_$P(^PRCS(410,DA,"IT",P(1),4),U)_"    Date Needed By: "_$$FMTE^XLFDT($P(^(4),U,2)) D DIWP^PRCUTL($G(DA))
 G ITEM2
VENDOR ;PRINT VENDOR AND REQ MESSAGES
 N Z0
 Q:Z1=U  I IOSL-$Y<3 D NEWP Q:Z1=U
 I $D(^PRCS(410,DA,4)),$P(^(4),U,1)'="" W !,?13,"TOTAL COST: ","$"_$J($P(^(4),U,1),0,2)
 W !,L I IOSL-$Y<2 D NEWP Q:Z1=U
 G RM:'$D(^PRCS(410,DA,2))
 I $D(^PRCS(410,DA,2)),$P(^(2),U,1)="" G RM
 I IOSL-$Y<7 D NEWP Q:Z1=U
 S (X,Z0)=$P(^PRCS(410,DA,3),"^",4),X=$S(X:"VENDOR INFORMATION:    NO: "_X,1:"NEW VENDOR INFORMATION: ") W !,X
 I Z0,$D(^PRC(440,Z0,3)),$P(^(3),U,2)="Y" W ?38,"EDI"
 I Z0,$D(^PRC(440,Z0,10)),$P(^(10),U,6)'="" W ?46,"FAX: "_$P(^(10),U,6)
 W !,"VENDOR: ",$P(^PRCS(410,DA,2),U,1) W:$P(^(2),U,9)'="" ?42,"CONTACT: ",$P(^(2),U,9)
 W:$P(^PRCS(410,DA,2),U,2)'="" !,?8,$P(^(2),U,2) W:$P(^(2),U,10)'="" ?44,"PHONE: ",$P(^(2),U,10)
 S Z(1)=$Y W:$P(^PRCS(410,DA,2),U,3)'="" !,?8,$P(^(2),U,3) S Z1=$P(^(3),U,4) I Z1,$D(^PRC(440,Z1,2)),$P(^(2),U,1)'="" W:Z(1)=$Y ! W ?42,"ACCT. #: ",$P(^(2),U,1)
 W:$P(^PRCS(410,DA,2),U,4)'="" !,?8,$P(^(2),U,4) W:$P(^(2),U,5)'="" !,?8,$P(^(2),U,5)
 I $P(^PRCS(410,DA,2),U,6)'="" W !,?8,$P(^(2),U,6) W:+$P(^(2),U,7)'=0 ",",$P($G(^DIC(5,$P(^(2),U,7),0)),U,2) W:$P(^PRCS(410,DA,2),U,8)'="" " ",$P(^(2),U,8)
 W !,L W !,"Ref. Voucher Number: ",! I $P($G(^PRCS(410,DA,445)),"^")'="" W $P(^(445),"^"),!
RM I IOSL-$Y<4 D NEWP Q:Z1=U
 I '$D(^PRCS(410,DA,"RM",0)) G DEL
 I $D(^PRCS(410,DA,"RM",0)) W ! S P(1)=0,DIWL=1,DIWR=80,DIWF="" K ^UTILITY($J,"W") S X="SPECIAL REMARKS:" D DIWP^PRCUTL($G(DA)) F J=1:1 S P(1)=$O(^PRCS(410,DA,"RM",P(1))) Q:P(1)=""  S X=^(P(1),0) D DIWP^PRCUTL($G(DA))
 S Z=^UTILITY($J,"W",DIWL) F K=1:1:Z D:$Y>62 NEWP^PRCSD121 W !,^UTILITY($J,"W",DIWL,K,0)
DEL I $D(^PRCS(410,DA,9)),$P(^(9),U,1)'="" W !,?6,"DELIVER TO: ",$P(^(9),U,1)
 W !,L Q
NEWP ;PRINT HEADER FOR NEW PAGE
 S Z1="" W !,"Press return to continue, uparrow (^) to exit: " R Z1:DTIME S:'$T Z1=U W @IOF Q:Z1=U
 W !,?31,$P(^PRCS(410,DA,0),U,1) W !,L
 W !,?16,"REQUEST, TURN-IN, AND RECEIPT FOR PROPERTY OR SERVICES" W !,L
 Q
