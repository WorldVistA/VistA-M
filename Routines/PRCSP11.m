PRCSP11 ;WISC/SAW-CONTROL POINT ACTIVITY 1358 PRINTOUT ;4/21/93  08:49
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 G P
QUE I $D(ZTQUEUED) S DA=D0
 S DA=D0,PRCSOB=1
P U IO W:$Y>0 @IOF S U="^",PRCSP=1,L="",$P(L,"-",80)="-" D NOW^%DTC S Y=% D DD^%DT S PRCSTN=$P(^PRCS(410,DA,0),U),PRC("SITE")=+PRCSTN W !,PRCSTN,?36,Y,?72,"PAGE ",PRCSP D UL
 D NEWP1 W !,"Requestor:",?41,"|Date Requested:",?62,"|Obligation No.:"
 W ! K P1 I $D(^PRCS(410,DA,7)) S P1=^(7) I +P1 S X=$S($D(^VA(200,+P1,0)):$P(^(0),U),1:"") W X
 W ?41,"|" I $D(^PRCS(410,DA,1)) S Y=$P(^(1),U) I Y D DD^%DT W Y
 W ?62,"|" I $D(^PRCS(410,DA,4)),$P(^(4),U,5)'="" S PRCSPO=$P(^(4),U,5) W ?65,PRC("SITE")_"-"_PRCSPO
 D UL W !,"Vendor:",?41,"|Contract Number:"
 W ! I $D(^PRCS(410,DA,2)) W $P(^(2),U) ;S X=$P(^(2),U) I X]"" W X
 W ?41,"|" K PRCSG I $D(^PRCS(410,DA,3)) S PRCSG=^(3) I $P(PRCSG,U,10)]"" W $P(PRCSG,U,10)
 W ! I $D(^PRCS(410,DA,2)) W $P(^(2),U,2),?41,"|",!,$P(^(2),U,6)_", " W $S($D(^DIC(5,+$P(^PRCS(410,DA,2),U,7),0)):$P(^(0),U,2),1:"  ")_"  "_$P(^PRCS(410,DA,2),U,8)
 W ?41,"|" D UL W !,"Name and Title Approving Official:",?41,"|Signature/Date Signed:"
 N PRSHLD S PRSHLD=^DD(410,42,0) K P W ! I $D(P1),$P(PRSHLD,"^",2)[200 S P=$P(P1,U,3) I P S X=$S($D(^VA(200,P,20)):$P(^(20),U,2),1:"") W $E(X,1,30)
 W ?41,"|" I $D(P),P,$P(P1,U,6)'="" W "/ES/"_$$DECODE^PRCSC1(DA)
 W ?62,"/" I $D(P1) S Y=$S($P(P1,U,7):$P(P1,U,7),1:$P(P1,U,5)) I Y D DD^%DT W Y K Y
 W ! I $D(P1) W $P(P1,U,4)
 W ?41,"|" D UL W !,"FUND CERTIFICATION:",!,"The supplies and services listed on this request are properly chargeable"
 W !,"to the following allotments, the available balances of which are"
 W !,"sufficient to cover the cost thereof, and funds have been obligated."
 D UL W !,"Appropriation and Accounting Symbols:",?41,"|Obligated By: ",?62,"|Date Obligated:"
 S DIWL=0,DIWR=80,DIWF="" K ^UTILITY($J)
 I $D(^PRCS(410,DA,8,0)) S X1=0 F I=1:1 S X1=$O(^PRCS(410,DA,8,X1)) Q:X1=""  S X=^(X1,0) D DIWP^PRCUTL($G(DA))
 S P=PRC("SITE") I $D(PRCSG) S:$P(PRCSG,U,2)]"" P=P_"-"_$P(PRCSG,U,2) S P=P_"-"_$P(PRCSTN,"-",4) S:$P(PRCSG,U,3)]"" P=P_"-"_$P($P(PRCSG,U,3)," ") S:$P(PRCSG,U,6) P=P_"-"_+$P(PRCSG,U,6)
 W !,P,?41,"|" K PRCSG I $D(^PRCS(410,DA,4)) S PRCSG=^(4) I $P(PRCSG,U,9),$P(PRCSG,U,10)'="" W "/ES/"_$$DECODE^PRCSC2(DA)
 W ?62,"|" I $D(PRCSG) S Y=$P(PRCSG,U,4) I Y D DD^%DT W Y
 D UL W !,"Purpose:" I $D(^UTILITY($J,"W",DIWL)) S Z=^UTILITY($J,"W",DIWL) F I=1:1:Z W !,^UTILITY($J,"W",DIWL,I,0) I IOSL-$Y<3 D UL,NEWP
 I IOSL-$Y<10 D NEWP
 D ^PRCSP111
 W @IOF K %DT,CT,UT,P1,P,PRCSP,PRCSA,PRCSG,PRCSOB,PRCSPO,PRCSTN,X,X1,Y,DIWL,DIWR,DIWF,Z,DA,I,L,^UTILITY($J) D:$D(ZTSK) KILL^%ZTLOAD Q
UL W ! F I=1:1:80 W @IOBS
 W L Q
NEWP ;PRINT HEADER FOR NEW PAGE
 W !!,"VA FORM 4-1358a-ADP (NOV 1987)" W:$Y>0 @IOF
 S PRCSP=PRCSP+1 W !,$P(^PRCS(410,DA,0),U) W:$D(PRCSPO) ?40,PRC("SITE")_"-"_PRCSPO W ?72,"PAGE ",PRCSP D UL
NEWP1 I '$D(PRCSOB) W !,?14,"ESTIMATED MISCELLANEOUS OBLIGATION OR CHANGE IN OBLIGATION" D UL
 E  W !,?26,"REQUEST FOR 1358 OBLIGATION/ADJUSTMENT" D UL
 Q
