PRCE58P0 ;WISC/SAW/LDB-DISPLAY 1358 FORM CONT. 19-FEB-92 ;6/7/11  16:26
V ;;5.1;IFCAP;**148,158,161**;Oct 20, 2000;Build 19
 ;Per VHA Directive 2004-038, this routine should not be modified.
PRCSD11 ;Entry for print
 U IO W @IOF S U="^",PRCSP=1 D NOW^%DTC S Y=% D DD^%DT W !,$P(TRNODE(0),U),?34,Y,?73,"PAGE ",PRCSP S L="",$P(L,"_",IOM)="_" W !,L
 D NEWP1 W !,"Originator of Request: " I $G(TRNODE(14)),TRNODE(14)'="" W $P($G(^VA(200,+TRNODE(14),0)),"^"),!
 W !,"Requestor:",?34,"|Date Requested:",?62,"|Obligation No.:"
 W ! K P1 I $D(TRNODE(7)) S P1=TRNODE(7) I +P1 S X=$P($G(^VA(200,+P1,0)),U) W X
 W ?34,"|" I $D(TRNODE(1)) S Y=$P(TRNODE(1),U) I Y D DD^%DT W Y
 W ?62,"|" I $D(TRNODE(4)),$P(TRNODE(4),U,5)'="" S PRCSPO=$P(TRNODE(4),U,5) W ?65,PRC("SITE")_"-"_PRCSPO
 W !,L W !,"Vendor:",?34,"|Contract Number:"
 W ! I $D(TRNODE(2)) S X=$P(TRNODE(2),U) I X]"" W $E(X,1,31)
 W ?34,"|" K PRCSG I $D(TRNODE(3)) S PRCSG=TRNODE(3) I $P(PRCSG,U,10)]"" W $P(PRCSG,U,10)
 W !,L W !,"Name and Title Approving Off.:",?41,"|Signature:",?62,"|Date Signed:"
 K P W ! I $D(P1) S P=$P(P1,U,3) S X=$S($D(^VA(200,+P,20)):$P(^(20),U,2),1:"") W $E(X,1,30)
 W ?41,"|" I $D(P),P,$P(P1,U,6)'="" S X=$$DECODE^PRCSC1(DA) W "/ES/"_$E(X,1,23)
 W ?62,"|" I $D(P1) S Y=$S($P(P1,U,7):$P(P1,U,7),1:$P(P1,U,5)) I Y D DD^%DT W Y K Y
 W ! I $D(P1) W $P(P1,U,4)
 W ?41,"|",?62,"|" W !,L W !,"FUND CERTIFICATION:  The supplies and services listed on this request are"
 W !,"properly chargeable to the following allotments, the available balances of"
 W !,"which are sufficient to cover the cost thereof, and funds have been obligated."
 W !,L D HOLD G EXIT:Z3=U D NEWP
 W !,"Appropriation & Acct. Symbols:",?41,"|Obligated By: ",?62,"|Date Obligated:"
TST S DIWL=0,DIWR=80,DIWF="" K ^UTILITY($J)
 I $D(TRNODE(8)) S X1=0 F I=1:1 S X1=$O(TRNODE(8,X1)) Q:X1=""  S X=TRNODE(8,X1),PRCSDAA=DA D DIWP^PRCUTL($G(DA)) S DA=PRCSDAA K PRCSDAA
 ;PRC*5.1*161 get control point from PRCSG as PRC("CP") will not exist from obligating print call
 S P=PRC("SITE") I $D(PRCSG) S:$P(PRCSG,U,2)]"" P=P_"-"_$P(PRCSG,U,2) S P=P_"-"_+$P(PRCSG,U) S:$P(PRCSG,U,3)]"" P=P_"-"_$P($P(PRCSG,U,3)," ") S:$P(PRCSG,U,6)]"" P=P_"-"_+$P(PRCSG,U,6)
 N PROJ I $D(TRNODE(3)),$P($G(TRNODE(3)),"^",12)'="" S PROJ=$P(TRNODE(3),"^",12),P=P_" "_PROJ
 W !,P,?41,"|" K PRCSG I $D(TRNODE(4)) S PRCSG=TRNODE(4) I $P(PRCSG,U,9),$P(PRCSG,U,10)'="" S X=$$DECODE^PRCSC2(DA) W "/ES/"_$E(X,1,27)
 W ?62,"|" I $D(PRCSG) S Y=$P(PRCSG,U,4) I Y D DD^%DT W Y
 W !,L
 W !,"AUTHORITY: " I $P($G(TRNODE(11)),U,4) W $P($G(^PRCS(410.9,$P(TRNODE(11),U,4),0)),U)
 W:$P($G(TRNODE(11)),U,5) ?40,"SUB: ",$P($G(^PRCS(410.9,$P(TRNODE(11),U,5),0)),U)
 W !,"SERVICE START DATE: ",$$FMTE^XLFDT($P($G(TRNODE(1)),U,6),"2DZ"),?40,"SERVICE END DATE: ",$$FMTE^XLFDT($P($G(TRNODE(1)),U,7),"2DZ")
 W !,L,!,"Purpose: "
 I $D(^UTILITY($J,"W",DIWL)) S Z=^UTILITY($J,"W",DIWL) F I=1:1:Z W !,^UTILITY($J,"W",DIWL,I,0) I IOSL-$Y<3 W !,L D HOLD Q:Z3=U  D NEWP
 G EXIT:Z3=U W !,L I IOSL-$Y<14 D HOLD G EXIT:Z3=U D NEWP
 D ^PRCE58P1 I Z3'=U D HOLD
EXIT K %DT,CT,UT,P1,P,PRCSP,PRCSA,PRCSA1,PRCSA2,PRCSG,PRCSPO,PRCSY,TRNODE,X,X1,Y,DIWL,DIWR,DIWF,Z,Z1,Z2,Z3,DA,I,L,^UTILITY($J) D:$D(ZTQUEUED) KILL^%ZTLOAD Q
NEWP ;PRINT HEADER FOR NEW PAGE
 W @IOF S PRCSP=PRCSP+1 W !,$P(TRNODE(0),U) W:$D(PRCSPO) ?35,PRC("SITE")_"-"_PRCSPO W ?73,"PAGE ",PRCSP W !,L
NEWP1 N PRCX S PRCX=$$AUTHR^PRCEMOA($P($G(TRNODE(11)),U,4,5))
 W !,"1358 OBLIGATION OR CHANGE" W:$P(PRCX,U)]"" ":",$P(PRCX,U)
 W:$P(PRCX,U,2)]"" !,?5,$P(PRCX,U,2) W !,L
 Q
HOLD R !,"Press return to continue, ""^"" to exit: ",Z3:DTIME S:'$T Z3=U Q
W2 W !!,"Enter information for another report or an uparrow to return to the menu.",! Q
W1 W !!,"You are not an authorized control point user.",!,"Contact your control point official." R X:5 G EXIT
W I $E(IOST,1)="C" W !!,"Press return to continue:  " R X:DTIME
 I IO'=IO(0) D ^%ZISC
