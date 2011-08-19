PRCE58P2 ;WISC/SAW,LDB-CONTROL POINT ACTIVITY 1358 PRINTOUT ;07/07/93
V ;;5.1;IFCAP;**148**;Oct 20, 2000;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
 G P
QUE I $D(ZTQUEUED) S DA=D0
 S DA=D0,PRCSOB=1
P U IO W:$Y>0 @IOF S U="^",PRCSP=1,L="",$P(L,"-",80)="-" D NOW^%DTC S Y=% D DD^%DT
 D NODE^PRCS58OB(DA,.TRNODE) S PRCSTN=$P($G(TRNODE(0)),U),PRC("SITE")=+PRCSTN W !,PRCSTN,?36,Y,?72,"PAGE ",PRCSP D UL
 D NEWP1 W !,"Originator of Request: " I $D(TRNODE(14)),TRNODE(14)'="" W $P($G(^VA(200,TRNODE(14),0)),"^"),!
 W !,"Requestor:",?41,"|Date Requested:",?62,"|Obligation No.:"
 W ! K P1 I $D(TRNODE(7)) S P1=TRNODE(7) I +P1 S X=$P($G(^VA(200,+P1,0)),U) W X
 W ?41,"|" I $D(TRNODE(1)) S Y=$P(TRNODE(1),U) I Y D DD^%DT W Y
 W ?62,"|" I $D(TRNODE(4)),$P(TRNODE(4),U,5)'="" S PRCSPO=$P(TRNODE(4),U,5) W ?65,PRC("SITE")_"-"_PRCSPO
 D UL W !,"Vendor:",?41,"|Contract Number:"
 W ! I $D(TRNODE(2)) W $P(TRNODE(2),U)
 W ?41,"|" K PRCSG I $D(TRNODE(3)) S PRCSG=TRNODE(3) I $P(PRCSG,U,10)]"" W $P(PRCSG,U,10)
 W ! I $D(TRNODE(2)),TRNODE(2)]"" W $P(TRNODE(2),U,2),?41,"|",!,$P(TRNODE(2),U,6)_", " W $S($D(^DIC(5,+$P(TRNODE(2),U,7),0)):$P(^(0),U,2),1:"  ")_"  "_$P(TRNODE(2),U,8)
 W ?41,"|" D UL W !,"Name and Title Approving Official:",?41,"|Signature/Date Signed:"
 K P W ! I $D(P1) S P=$P(P1,U,3) I P S X=$S($D(^VA(200,P,20)):$P(^(20),U,2),1:"") W $E(X,1,30)
 K P W ! I $D(P1) S P=$P(P1,U,3) I P S X=$S($G(^VA(200,P,20)):$P(^(20),U,2),1:"") W $E(X,1,30)
 W ?41,"|" I $D(P),P,$P(P1,U,6)'="" S X=$$DECODE^PRCSC1(DA) W "/ES/"_$E(X,1,28)
 W ?62,"/" I $D(P1) S Y=$S($P(P1,U,7):$P(P1,U,7),1:$P(P1,U,5)) I Y D DD^%DT W Y K Y
 W ! I $D(P1) W $P(P1,U,4)
 W ?41,"|" D UL W !,"FUND CERTIFICATION:",!,"The supplies and services listed on this request are properly chargeable"
 W !,"to the following allotments, the available balances of which are"
 W !,"sufficient to cover the cost thereof, and funds have been obligated."
 D UL W !,"Appropriation and Accounting Symbols:",?41,"|Obligated By: ",?62,"|Date Obligated:"
 S DIWL=0,DIWR=80,DIWF="" K ^UTILITY($J)
 I $D(TRNODE(8)) S X1=0 F I=1:1 S X1=$O(TRNODE(8,X1)) Q:X1=""  S X=TRNODE(8,X1),PRCSDAA=DA D DIWP^PRCUTL($G(DA)) S DA=PRCSDAA K PRCSDAA
 S P=PRC("SITE") I $D(PRCSG) S:$P(PRCSG,U,2)]"" P=P_"-"_$P(PRCSG,U,2) S P=P_"-"_$P(PRCSTN,"-",4) S:$P(PRCSG,U,3)]"" P=P_"-"_$P($P(PRCSG,U,3)," ") S:$P(PRCSG,U,6) P=P_"-"_+$P(PRCSG,U,6)
 I $D(TRNODE(3)),$P($G(TRNODE(3)),"^",12)'="" S PROJ=$P(TRNODE(3),"^",12),P=P_" "_PROJ
 W !,P,?41,"|" K PRCSG I $D(TRNODE(4)) S PRCSG=TRNODE(4) I $P(PRCSG,U,9),$P(PRCSG,U,10)'="" S X=$$DECODE^PRCSC2(DA) W "/ES/"_$E(X,1,28)
 W ?62,"|" I $D(PRCSG) S Y=$P(PRCSG,U,4) I Y D DD^%DT W Y
 D UL
 W !,"AUTHORITY: " I $P($G(TRNODE(11)),U,4) W $P($G(^PRCS(410.9,$P(TRNODE(11),U,4),0)),U)," ",$P($G(^(0)),U,2)
 W:$P($G(TRNODE(11)),U,5) !,"SUB: ",$P($G(^PRCS(410.9,$P(TRNODE(11),U,5),0)),U)," ",$P($G(^(0)),U,2)
 D UL W !,"Purpose:       SERVICE START DATE: ",$$FMTE^XLFDT($P($G(TRNODE(1)),U,6),"2DZ"),"     SERVICE END DATE: ",$$FMTE^XLFDT($P($G(TRNODE(1)),U,7),"2DZ")
 I $D(^UTILITY($J,"W",DIWL)) S Z=^UTILITY($J,"W",DIWL) F I=1:1:Z W !,^UTILITY($J,"W",DIWL,I,0) I IOSL-$Y<3 D UL,NEWP
 I IOSL-$Y<10 D NEWP
 D ^PRCE58P3
 K %DT,CT,UT,P1,P,PRCSP,PRCSA,PRCSG,PRCSOB,PRCSPO,PRCSTN,X,X1,Y,DIWL,DIWR,DIWF,Z,DA,I,L,^UTILITY($J) D:$D(ZTQUEUED) KILL^%ZTLOAD Q
UL W ! N I F I=1:1:80 W @IOBS
 W L Q
NEWP ;PRINT HEADER FOR NEW PAGE
 W !!,"VA FORM 4-1358a-ADP (NOV 1987)" W:$Y>0 @IOF
 S PRCSP=PRCSP+1 W !,$P(TRNODE(0),U) W:$D(PRCSPO) ?40,PRC("SITE")_"-"_PRCSPO W ?72,"PAGE ",PRCSP D UL
NEWP1 I '$D(PRCSOB) W !,?14,"ESTIMATED MISCELLANEOUS OBLIGATION OR CHANGE IN OBLIGATION" D UL
 E  W !,?26,"REQUEST FOR 1358 OBLIGATION/ADJUSTMENT" D UL
 Q
