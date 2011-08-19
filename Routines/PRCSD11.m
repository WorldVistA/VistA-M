PRCSD11 ;WISC/SAW-CONTROL POINT ACTIVITY 1358 DISPLAY ;4/21/93  08:36
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 U IO W @IOF S U="^",PRCSP=1 D NOW^%DTC S Y=% D DD^%DT W !,$P(^PRCS(410,DA,0),U),?34,Y,?73,"PAGE ",PRCSP S L="",$P(L,"_",IOM)="_" W !,L
 D NEWP1 W !,"Requestor:",?34,"|Date Requested:",?62,"|Obligation No.:"
 W ?34,"|" I $D(^PRCS(410,DA,1)) S Y=$P(^(1),U) I Y D DD^%DT W Y
 W ?62,"|" I $D(^PRCS(410,DA,4)),$P(^(4),U,5)'="" S PRCSPO=$P(^(4),U,5) W ?65,PRC("SITE")_"-"_PRCSPO
 W !,L W !,"Vendor:",?34,"|Contract Number:"
 W ! I $D(^PRCS(410,DA,2)) S X=$P(^(2),U) I X]"" W $E(X,1,31)
 W ?34,"|" K PRCSG I $D(^PRCS(410,DA,3)) S PRCSG=^(3) I $P(PRCSG,U,10)]"" W $P(PRCSG,U,10)
 W !,L W !,"Name and Title Approving Off.:",?34,"|Signature:",?62,"|Date Signed:"
 N PRSHLA S PRSHLA=^DD(410,42,0) K P W ! I $D(P1),$P(PRSHLA,"^",2)[200 S P=$P(P1,U,3) S X=$S($D(^VA(200,+P,20)):$P(^(20),U,2),1:"") W $E(X,1,30)
 W ?34,"|" I $D(P),P,$P(P1,U,6)'="" W "/ES/"_$$DECODE^PRCSC1(DA)
 W ?62,"|" I $D(P1) S Y=$S($P(P1,U,7):$P(P1,U,7),1:$P(P1,U,5)) I Y D DD^%DT W Y K Y
 W ! I $D(P1) W $P(P1,U,4)
 W ?34,"|",?62,"|" W !,L W !,"FUND CERTIFICATION:  The supplies and services listed on this request are"
 W !,"properly chargeable to the following allotments, the available balances of"
 W !,"which are sufficient to cover the cost thereof, and funds have been obligated."
 W !,L,!,"Appropriation & Acct. Symbols:",?34,"|Obligated By: ",?62,"|Date Obligated:"
 S DIWL=0,DIWR=80,DIWF="" K ^UTILITY($J)
 I $D(^PRCS(410,DA,8,0)) S X1=0 F I=1:1 S X1=$O(^PRCS(410,DA,8,X1)) Q:X1=""  S X=^(X1,0) D DIWP^PRCUTL($G(DA))
 S P=PRC("SITE") I $D(PRCSG) S:$P(PRCSG,U,2)]"" P=P_"-"_$P(PRCSG,U,2) S P=P_"-"_$P(PRC("CP")," ") S:$P(PRCSG,U,3)]"" P=P_"-"_$P($P(PRCSG,U,3)," ") S:$P(PRCSG,U,6)]"" P=P_"-"_+$P(PRCSG,U,6)
 W !,P,?34,"|" K PRCSG I $D(^PRCS(410,DA,4)) S PRCSG=^(4) I $P(PRCSG,U,9),$P(PRCSG,U,10)'="" W "/ES/"_$$DECODE^PRCSC2(DA)
 W ?62,"|" I $D(PRCSG) S Y=$P(PRCSG,U,4) I Y D DD^%DT W Y
 W !,L D HOLD G EXIT:Z3=U D NEWP
 W !,"Purpose:" I $D(^UTILITY($J,"W",DIWL)) S Z=^UTILITY($J,"W",DIWL) F I=1:1:Z W !,^UTILITY($J,"W",DIWL,I,0) I IOSL-$Y<3 W !,L D HOLD Q:Z3=U  D NEWP
 G EXIT:Z3=U W !,L I IOSL-$Y<6 D HOLD G EXIT:Z3=U D NEWP
 D ^PRCSD111 I Z3'=U D HOLD
EXIT K %DT,CT,UT,P1,P,PRCSP,PRCSA,PRCSG,PRCSPO,X,X1,Y,DIWL,DIWR,DIWF,Z,Z1,Z2,Z3,DA,I,L,^UTILITY($J) D:$D(ZTSK) KILL^%ZTLOAD Q
NEWP ;PRINT HEADER FOR NEW PAGE
 W @IOF S PRCSP=PRCSP+1 W !,$P(^PRCS(410,DA,0),U) W:$D(PRCSPO) ?35,PRC("SITE")_"-"_PRCSPO W ?73,"PAGE ",PRCSP W !,L
NEWP1 W !,?11,"ESTIMATED MISCELLANEOUS OBLIGATION OR CHANGE IN OBLIGATION" W !,L
 Q
HOLD S Z3="" W !,"Press return to continue, ""^"" to exit: " R Z3:DTIME S:'$T Z3=U Q
