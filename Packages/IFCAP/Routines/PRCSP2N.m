PRCSP2N ;WISC/SAW-CONTROL POINT ACTIVITY 2237 PRINTOUT (PRE-PRINTED 8-1/2X11) ;4/21/93  10:02
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 U IO S U="^",P(1)=0,PRCS("P")=1,F=0 D NOW^%DTC S Y=% D DD^%DT
 S P(5)=$S($D(^PRCS(410,DA,1)):$P(^(1),U,3),1:""),P(5)=$S(P(5)="EM":"***EMERGENCY***",P(5)="SP":"*SPECIAL*",1:"STANDARD")
H I F,$D(^DIC(6910,1,0)),$P(^(0),"^",3)="N" S PRCS("P")=PRCS("P")+1 W ! U IO(0) W !,$C(7) R "PRESS RETURN WHEN READY TO PRINT NEXT PAGE: ",X:DTIME U IO
 I F,$D(^DIC(6910,1,0)),$P(^(0),"^",3)="P" W !,@IOF S PRCS("P")=PRCS("P")+1
 W ?36,"PRIORITY: ",P(5),! W:PRCS("P")=1 ?3,Y W ?36,$P(^PRCS(410,DA,0),U),?80,"PAGE ",PRCS("P")
 W !!!!,?24 S P=$P(^PRCS(410,DA,0),U,5),P1=$S($D(^(3)):+$P(^(3),U),1:"") I P,P1 S P=$S($D(^PRC(420,P,1,P1,0)):$P(^(0),U,10),1:"") I P,$D(^DIC(49,P,0)) W $P(^(0),U) W:$P(^(0),U,8)]"" " ("_$P(^(0),U,8)_")"
 W !!,?4,"X" I $D(^PRCS(410,DA,1)),$P(^(1),U)'="" S Y=$P(^(1),U) D DD^%DT W ?24,Y I $P(^PRCS(410,DA,1),U,4)'="" S Y=$P(^(1),U,4) D DD^%DT W ?49,Y
 I F W !!! S L=10 Q
 W !!! I $D(^PRCS(410,DA,1)),$P(^(1),U,5)'="" S P=$P(^(1),U,5) I $D(^PRCS(410.2,P,0)),$P(^(0),U)'="" S P=$P(^(0),U) W ?18,P,":" W $C(13),?18 S I="",$P(I,"_",$L(P))="" W I S I=""
 ;PRINT ITEMS
 W ! S DIWL=18,DIWR=54,DIWF="",P(1)=0,L=11
 F I=1:1 K ^UTILITY($J,"W") S P(1)=$O(^PRCS(410,DA,"IT",P(1))) G VENDOR:P(1)'>0 D ITEM1
ITEM1 Q:'$D(^PRCS(410,DA,"IT",P(1),0))  S Z=^(0)
 S P(4)=$P(Z,U,6) I $L(P(4))>15 S:L>29 F=1 D:F H S F=0 W !,?2,$E(P(4),1,15),!,?2,$E(P(4),16,24) S L=L+2
 I $L(P(4))<16 S:L>30 F=1 D:F H S F=0 W !,?2,P(4) S L=L+1
 S PRCS("SUB")=+$P(Z,U,4),P(3)=$P(Z,U,3) S:P(3) P(3)=$P(^PRCD(420.5,P(3),0),U)
 S P(0)=$S($P(Z,U,2)[".":$J($P(Z,U,2),5,2),1:$J($P(Z,U,2),5))_$J(P(3),3)_$S($P(Z,U,7)="N/C":$J("N/C",8),1:$J($P(Z,U,7),8,2))
 G PRCARD:$P(Z,U,5)
 S P(2)=0 F I=1:1 S P(2)=$O(^PRCS(410,DA,"IT",P(1),1,P(2))) Q:P(2)=""  S X=^(P(2),0) S:I=1 X=$P(^PRCS(410,DA,"IT",P(1),0),U)_" "_X D DIWP^PRCUTL($G(DA))
ITEM2 I '$D(^UTILITY($J,"W",DIWL)) W ! S L=L+1 Q
 S Z=^UTILITY($J,"W",DIWL)
 I Z>1 F J=1:1:(Z-1) W ?18,^UTILITY($J,"W",DIWL,J,0),! S L=L+1 S:L>30 F=1 D:F H S F=0
 I Z>1 W ?18,^UTILITY($J,"W",DIWL,Z,0),?56,P(0),! S L=L+1 S:L>30 F=1 D:F H S F=0
 I Z<2 W ?18,^UTILITY($J,"W",DIWL,1,0),?56,P(0),! S L=L+1 S:L>30 F=1 D:F H S F=0
 Q
PRCARD S P("PR")=$P(^PRCS(410,DA,"IT",P(1),0),U,5) Q:'$D(^PRC(441,P("PR"),1,0))
 S Z="" S:$P(^PRC(441,P("PR"),0),U,5)'="" Z=Z_" (NSN: "_$P(^(0),U,5)_")" S Z1=$P(^PRCS(410,DA,3),U,4) I Z1,$D(^PRC(441,P("PR"),2,Z1,0)) S:$P(^(0),U,5)'="" Z=Z_" (NDC: "_$P(^(0),U,5)_")"
 S P("PR1")=0 F I=1:1 S P("PR1")=$O(^PRC(441,P("PR"),1,P("PR1"))) Q:P("PR1")=""  S X=^(P("PR1"),0) S:I=1 X=$P(^PRCS(410,DA,"IT",P(1),0),U)_" "_"ITEM ID NO. "_P("PR")_","_Z_", "_X D DIWP^PRCUTL($G(DA))
 G ITEM2
VENDOR ;PRINT VENDOR AND REQ MESSAGES
 I L>29 S F=1 D H S F=0
 I $D(^PRCS(410,DA,4)),$P(^(4),U)'="" W !,?18,"TOTAL COST: ","$"_$J($P(^(4),U),0,2),!! S L=L+3
 G RM:'$D(^PRCS(410,DA,2))
 I $P(^PRCS(410,DA,2),U)="" G RM
 I L>24 S F=1 D H S F=0
 S P1=^PRCS(410,DA,2)
 W ?11,"VENDOR: " W $P(P1,U) W:$P(P1,U,9)'="" ?56,"CONTACT: ",$P(P1,U,9)
 W:$P(P1,U,2)'="" !,?18,$P(P1,U,2) W:$P(P1,U,10)'=""&($P(P1,U,2)="") ! W:$P(P1,U,10)'="" ?57,"PHONE: ",$P(P1,U,10) S:$P(P1,U,2)'=""!($P(P1,U,10)'="") L=L+1
 I $P(P1,U,3)'="" W !,?18,$P(P1,U,3) S L=L+1
 I $P(P1,U,4)'="" W !,?18,$P(P1,U,4) S L=L+1
 I $P(P1,U,5)'="" W !,?18,$P(P1,U,5) S L=L+1
 W !,?18 S L=L+1 W:$P(P1,U,6)'="" $P(P1,U,6) W:$P(P1,U,7)'="" ",",$P(^DIC(5,$P(P1,U,7),0),U,2) W:$P(P1,U,8)'="" " ",$P(P1,U,8)
RM W ! S L=L+1 D ^PRCSP21N
 W @IOF K %DT,F,P,P1,X,X1,Y,Z,Z1,DA,DIWL,DIWR,DIWF,I,J,K,PRCS,^UTILITY($J,"W") W @IOF D:$D(ZTSK) KILL^%ZTLOAD Q
