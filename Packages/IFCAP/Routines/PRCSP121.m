PRCSP121 ;WISC/SAW/BMM-CONTROL POINT ACTIVITY 2237 PRINTOUT CON'T ; 3/29/05 1:50pm
 ;;5.1;IFCAP;**81**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;PRINT ITEMS  ;  REW fixed next line for Archiving "just in case"
 ;
 ;PRC*5.1*81 BMM edit PRCARD to add DM Doc ID (410.02, 17) and Date 
 ;Needed By (410.02, 18) fields to printout
 ;
 I $D(^PRCS(410,DA,1)),$P(^(1),U,5)'="" S P=$P(^(1),U,5),P=$P($G(^PRCS(410.2,P,0),">>>  PRCS(410.2,"_P_",0) is not defined but referenced in PRCSP121 for record: "_DA_" <<<"),U) W !,?12,"|",P,":",?38,"|",?48,"|",?53,"|",?63,"|",?73,"|",?84,"|"
 S DIWL=19,DIWR=35,DIWF="",P(1)=0
 F I=1:1 K ^UTILITY($J,"W") S P(1)=$O(^PRCS(410,DA,"IT",P(1))) G VENDOR:P(1)'>0 D ITEM1
ITEM1 Q:'$D(^PRCS(410,DA,"IT",P(1),0))  S Z=^(0),P(4)=$P(Z,U,6)
 S PRCS("SUB")=+$P(Z,U,4),P(3)=$P(Z,U,3) S P(3)=$S($D(^PRCD(420.5,+P(3),0)):$P(^(0),U),1:"")
 S P(0)="|"_$S($P(Z,U,2)[".":$J($P(Z,U,2),9,2),1:$J($P(Z,U,2),9))_"|"_$J(P(3),4)_"|"_$S($P(Z,U,7)="N/C":$J("N/C",9),1:$J($P(Z,U,7),9,4))_"|"
 G PRCARD:$P(Z,U,5)
 S P(2)=0 F I=1:1 S P(2)=$O(^PRCS(410,DA,"IT",P(1),1,P(2))) Q:P(2)=""  S X=^(P(2),0) S:I=1 X=$P(^PRCS(410,DA,"IT",P(1),0),U)_" "_X D DIWP^PRCUTL($G(DA))
ITEM2 I '$D(^UTILITY($J,"W",DIWL)) S ^(DIWL)=1,^(DIWL,1,0)="***NO DESCRIPTION***"
 S Z=^UTILITY($J,"W",DIWL)
 I $L(P(4))>12 W !,$E(P(4),1,12),"|",?38,"|",?48,"|",?53,"|",?63,"|",?73,"|",?84,"|",!,$E(P(4),13,24)
 I $L(P(4))<13 W !,P(4)
 I Z>1 F J=1:1:(Z-1) W ?12,"|",^UTILITY($J,"W",DIWL,J,0),?38,"|",?48,"|",?53,"|",?63,"|",?73,"|",?84,"|" D:$Y>61 NEWP W !
 I Z>1 W ?12,"|",^UTILITY($J,"W",DIWL,Z,0),?38,P(0),?73,"|",?84,"|" D:$Y>61 NEWP W !,?12,"|",?38,"|",?48,"|",?53,"|",?63,"|",?73,"|",?84,"|"
 I Z<2 W ?12,"|",^UTILITY($J,"W",DIWL,1,0),?38,P(0),?73,"|",?84,"|" D:$Y>61 NEWP W !,?12,"|",?38,"|",?48,"|",?53,"|",?63,"|",?73,"|",?84,"|"
 Q
PRCARD S P("PR")=$P(^PRCS(410,DA,"IT",P(1),0),U,5) G ITEM2:'$D(^PRC(441,P("PR"),1,0))
 S P("PR1")=0,X=$P(^PRCS(410,DA,"IT",P(1),0),U)_" ITEM ID NO. "_P("PR") D DIWP^PRCUTL($G(DA)) F I=1:1 S P("PR1")=$O(^PRC(441,P("PR"),1,P("PR1"))) Q:P("PR1")=""  S X=^(P("PR1"),0) D DIWP^PRCUTL($G(DA))
 S Z="" S:$P(^PRC(441,P("PR"),0),U,5)'="" Z=Z_" (NSN: "_$P(^(0),U,5)_")" S Z1=$P(^PRCS(410,DA,3),U,4) I Z1,$D(^PRC(441,P("PR"),2,Z1,0)) S:$P(^(0),U,5)'="" Z=Z_" (NDC: "_$P(^(0),U,5)_")" S:$P(^(0),U,3) Z2=$P(^(0),U,3)
 S:$P($G(^PRC(441,P("PR"),3)),U,7)'="" Z=Z_" FOOD GROUP: "_$P(^(3),U,7)
 I Z1,$D(^PRC(441,P("PR"),2,Z1,0)) S Z=Z_" PKG: "_$P(^(0),U,8)_" per "_$S($D(^PRCD(420.5,+$P(^(0),U,7),0)):$P(^(0),U),1:"")
 I $D(Z2),$D(^PRC(440,+Z1,4,+Z2,0)),$P(^(0),U)'="" S Y=$S($P(^(0),U,2):$P(^(0),U,2),1:"") X:Y ^DD("DD") S Z=Z_" (CONTRACT # "_$P(^PRC(440,Z1,4,Z2,0),U)_$S(Y'="":", EXPIRATION DATE: "_Y_")",1:")") K Z2
 S X=Z D:$L(X) DIWP^PRCUTL($G(DA))
 ;PRC*5.1*81 add DM Doc ID and Date Needed By fields to ^UTILITY
 I $$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")=1,$P($G(^PRCS(410,DA,"IT",P(1),4)),U)]"" D
 . S X="DM Doc ID: "_$P(^PRCS(410,DA,"IT",P(1),4),U)_"    Date Needed By: "_$$FMTE^XLFDT($P(^(4),U,2)) D DIWP^PRCUTL($G(DA))
 G ITEM2
VENDOR ;PRINT VENDOR AND REQ MESSAGES
 N Z0
 I $Y>60 D NEWP
 I $D(^PRCS(410,DA,4)),$P(^(4),U)'="" W !,?12,"|TOTAL COST: ","$"_$J($P(^(4),U),0,2),?38,"|",?48,"|",?53,"|",?63,"|",?73,"|",?84,"|"
 W !,$E(L,1,12),"|",$E(L,1,25),"|",$E(L,1,9),"|",$E(L,1,4),"|",$E(L,1,9),"|",$E(L,1,9),"|",$E(L,1,10),"|",$E(L,1,5) I $Y>60 D NEWP
 G RM:'$D(^PRCS(410,DA,2))
 I $D(^PRCS(410,DA,2)),$P(^(2),U)="" G RM
 I $Y>56 D NEWP
 S (X,Z0)=$P(^PRCS(410,DA,3),U,4),X=$S(X:"VENDOR INFORMATION:    NO. "_X,1:"NEW VENDOR INFORMATION:") W !,X
 I Z0,$D(^PRC(440,Z0,3)),$P(^(3),U,2)="Y" W ?38,"EDI"
 I Z0,$D(^PRC(440,Z0,10)),$P(^(10),U,6)'="" W ?46,"FAX: "_$P(^(10),U,6)
 S X=^PRCS(410,DA,2) W !,"VENDOR: ",$P(X,U) W:$P(X,U,9)'="" ?42,"CONTACT: ",$P(X,U,9)
 W:$P(X,U,2)'="" !,?8,$P(X,U,2) W:$P(X,U,10)'="" ?44,"PHONE: ",$P(X,U,10)
 W:$P(X,U,3)'="" !,?8,$P(X,U,3) S Z1=$P(^PRCS(410,DA,3),U,4) I Z1,$D(^PRC(440,Z1,2)),$P(^(2),U)'="" W ?42,"ACCT. #: ",$P(^(2),U)
 W:$P(X,U,4)'="" !,?8,$P(X,U,4) W:$P(X,U,5)'="" !,?8,$P(X,U,5)
 I $P(X,U,6)'="" W !,?8,$P(X,U,6) W:+$P(X,U,7)'=0 ",",$P($G(^DIC(5,$P(X,U,7),0)),U,2) W:$P(X,U,8)'="" " ",$P(X,U,8)
 W !,L W !,"Ref. Voucher Number: ",! W:$P($G(^PRCS(410,DA,445)),"^")'="" $P(^(445),"^"),!
RM I $Y>68 D NEWP
 Q
NEWP ;PRINT HEADER FOR NEW PAGE
 W !,"VA FORM 90-2237-ADP MAR 1985" W:$Y>0 @IOF
 S PRCS("P")=PRCS("P")+1 W !,?36,$P(^PRCS(410,DA,0),U),?83,"PAGE ",PRCS("P"),!,L
 W !,?16,"REQUEST, TURN-IN, AND RECEIPT FOR PROPERTY OR SERVICES",! I $D(ZTDESC("NOPRINT")) W ?37,"**REPRINT**",!
 W !,L
 Q
