PRCSP132 ;SF-ISC/LJP-CPA PRINTS CON'T-TRANSACTION STATUS REPORT ;4/21/93  08:59
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
IT I IO=IO(0),$E(IOST)="C",'$D(ZTQUEUED) W !!,"Would you like to review the item information for this request" S %=2 D YN^DICN G IT:%=0 Q:%=2!(%<0)
 D HDR S DIWL=13,DIWR=51,DIWF="",P(1)=0
 F I=1:1 K ^UTILITY($J,"W") S P(1)=$O(^PRCS(410,DA,"IT",P(1))) Q:(P(1)'>0)!(PRCSEX["^")  D ITEM1
 Q
ITEM1 Q:'$D(^PRCS(410,DA,"IT",P(1),0))  S Z=^(0)
 D:PRCSDY>PRCSS S^PRCSP13 Q:PRCSEX[U
 S P(4)=$P(Z,U,6) I $L(P(4))>12 W !,$E(P(4),1,12),"|",?52,"|",?62,"|",?67,"|",!,$E(P(4),13,24)
 I $L(P(4))<13 W !,P(4)
 S PRCS("SUB")=+$P(Z,U,4),P(3)=$P(Z,U,3) S:P(3) P(3)=$P(^PRCD(420.5,P(3),0),U)
 S P(0)="|"_$S($P(Z,U,2)[".":$J($P(Z,U,2),9,2),1:$J($P(Z,U,2),9))_"|"_$J(P(3),4)_"|"_$S($P(Z,U,7)="N/C":$J("N/C",9),1:$J($P(Z,U,7),9,2))
 G PRCARD:$P(Z,U,5)
 S P(2)=0 F I=1:1 S P(2)=$O(^PRCS(410,DA,"IT",P(1),1,P(2))) Q:P(2)=""  S X=^(P(2),0) S:I=1 X=$P(^PRCS(410,DA,"IT",P(1),0),U)_" "_X D DIWP^PRCUTL($G(DA))
ITEM2 I '$D(^UTILITY($J,"W",DIWL)) S ^(DIWL)=1,^(DIWL,1,0)="***NO DESCRIPTION***"
 S Z=^UTILITY($J,"W",DIWL)
 Q:PRCSEX[U
 I Z>1 F J=1:1:(Z-1) W ?12,"|",^UTILITY($J,"W",DIWL,J,0),?52,"|",?62,"|",?67,"|" D:PRCSDY>PRCSS S^PRCSP13 Q:PRCSEX[U  W ! S PRCSDY=PRCSDY+1
 I Z>1 W ?12,"|",^UTILITY($J,"W",DIWL,Z,0),?52,P(0) D:PRCSDY>PRCSS S^PRCSP13 Q:PRCSEX[U  W !,?12,"|",?52,"|",?62,"|",?67,"|" S PRCSDY=PRCSDY+1
 I Z<2 W ?12,"|",^UTILITY($J,"W",DIWL,1,0),?52,P(0) D:PRCSDY>PRCSS S^PRCSP13 Q:PRCSEX[U  W !,?12,"|",?52,"|",?62,"|",?67,"|" S PRCSDY=PRCSDY+1
 Q
PRCARD S P("PR")=$P(^PRCS(410,DA,"IT",P(1),0),U,5) Q:'$D(^PRC(441,P("PR"),1,0))
 S Z="" S:$P(^PRC(441,P("PR"),0),U,5)'="" Z=Z_" (NSN: "_$P(^(0),U,5)_")" S Z1=$P(^PRCS(410,DA,3),U,4) I Z1,$D(^PRC(441,P("PR"),2,Z1,0)) S:$P(^(0),U,5)'="" Z=Z_" (NDC: "_$P(^(0),U,5)_")" S:$P(^(0),U,3) Z2=$P(^(0),U,3)
 I Z1,$D(^PRC(440,Z1,2)),$P(^(2),U)'="" S Z=Z_" (VENDOR ACCT. # "_$P(^(2),U)_")"
 I $D(Z2),$D(^PRC(440,Z1,4,Z2,0)),$P(^(0),U)'="" S Z=Z_" (CONTRACT # "_$P(^(0),U)_")" K Z2
 S P("PR1")=0,X=$P(^PRCS(410,DA,"IT",P(1),0),U)_" ITEM ID NO. "_P("PR") D DIWP^PRCUTL($G(DA)) F I=1:1 S P("PR1")=$O(^PRC(441,P("PR"),1,P("PR1"))) Q:P("PR1")=""  S X=^(P("PR1"),0) D DIWP^PRCUTL($G(DA))
 G ITEM2
HDR W:$Y>0 @IOF W ?10,"OBLIGATION TRANSACTION STATUS DISPLAY - ITEM INFORMATION"
 W !!,"Transaction Number: ",$P(PRCS0,"^"),?41,"Transaction Type: ",PRCSTP,! S I="",$P(I,"-",IOM)="" W I
 W !,"STOCK NUMBER",?15,"ITEM DESCRIPTION",?53,"QUANTITY",?63,"U/I",?68,"UNIT COST",! W I
 S PRCSDY=5,I="" Q
SUBC S I=0
 F J=1:1 S I=$O(^PRCS(410,DA,12,I)) Q:'I  S PRCSX=^(I,0) D:PRCSDY>PRCSS S^PRCSP13 Q:PRCSEX["^"  D SUBCW
 K PRCSX Q
SUBCW W ! W:J=1 "Sub-Control Point:" W ?20,$S($D(^PRCS(410.4,+PRCSX,0)):$E($P(^(0),U),1,23),1:""),?41,"$ Amount: $",$J($P(PRCSX,U,2),0,2) S PRCSDY=PRCSDY+1 Q
RTS D:PRCSDY>PRCSS S^PRCSP13 Q:PRCSEX[U  W ! K ^UTILITY($J,"W") S DIWL=1,DIWR=68,DIWF="",PRCSDY=PRCSDY+1,PRCSI=0
 F PRCSJ=1:1 S PRCSI=$O(^PRCS(410,DA,13,PRCSI)) Q:'PRCSI  S X=^(PRCSI,0) D DIWP^PRCUTL($G(DA))
 S I=$S($D(^UTILITY($J,"W",DIWL)):+^(DIWL),1:0)
 I I F J=1:1:1 D:PRCSDY>PRCSS S^PRCSP13 Q:PRCSEX[U  W ! W:J=1 "Return to Service Comments:",! W ?10,^UTILITY($J,"W",DIWL,J,0) S PRCSDY=PRCSDY+1
 Q
