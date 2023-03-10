PRCHDP2 ;ID/RSD/RHD-DISPLAY P.O. ;  [7/22/98 11:11am]
V ;;5.1;IFCAP;**38,131,221**;Oct 20, 2000;Build 14
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;PRC*5.1*221 Modify an item description display to skip '|' logic
 ;            if description contains a undefined display command
 ;            like '| IN '.
 ;
 N PRCHAMNT,PRCHAMCT S PRCHAMNT=0 I $D(^PRC(442,D0,6,0)) S PRCHAMCT=$P(^PRC(442,D0,6,0),U,3),PRCHAMNT=1    ;PRC*5.1*221
 W !?8,"ENTER '^' TO HALT: " S PRCHDQ=0 R X:DTIME S:X["^" PRCHDQ=1 G ASK2:PRCHDQ D HDR
 S (N,PRCHDI)=0 F I=0:0 S PRCHDI=$O(^PRC(442,D0,2,PRCHDI)) Q:PRCHDI'>0  S PRCHDI0=^(PRCHDI,0),PRCHDI2=$S($D(^(2)):^(2),1:""),N=+PRCHDI0 D ITEM G:PRCHDQ ASK2
 S PRCHDI=0 F I=0:0 S PRCHDI=$O(^PRC(442,D0,3,PRCHDI)) Q:PRCHDI'>0  S PRCHDI0=^(PRCHDI,0),N=N+1 W !?2,$J(N,3),?7,"LESS ",$P(PRCHDI0,U,2),$S($E($P(PRCHDI0,U,2),1)="$":"",1:" %")," FOR " D DIS
 I $P(PRCHD0,U,13)>0 W !?2,$J(N+1,3),?7,"EST. SHIPPING AND/OR HANDLING",?58,$J($P(PRCHD0,U,13),7,2)
 G:'$D(^PRC(442,D0,15,0)) COM K ^(9999999),^UTILITY($J,"W")
 F PRCHK=0:0 S PRCHK=$O(^PRC(442,D0,15,PRCHK)) Q:'PRCHK  S PRCHI=^(PRCHK,0) I $D(^PRC(442.7,+PRCHI,0)),$O(^(1,0)) S DIWL=1,DIWR=60 F PRCHJ=0:0 S PRCHJ=$O(^PRC(442.7,+PRCHI,1,PRCHJ)) Q:'PRCHJ  S X=^(PRCHJ,0) D DIWP^PRCUTL($G(DA))
 ;
 K ^TMP($J,"W") S %X="^UTILITY($J,""W"",",%Y="^TMP($J,""W""," D %XY^%RCR
 W ! F J=0:0 S J=$O(^TMP($J,"W",1,J)) Q:'J  W !?8,^(J,0) D ASK G:PRCHDQ ASK2
COM G:'$D(^PRC(442,D0,4,0)) PT K ^UTILITY($J,"W") S DIWL=1,DIWR=60,PRCHJ=0 F  S PRCHJ=$O(^PRC(442,D0,4,PRCHJ)) Q:PRCHJ=""  S X=^(PRCHJ,0) D DIWP^PRCUTL($G(DA))
 K ^TMP($J,"W") S %X="^UTILITY($J,""W"",",%Y="^TMP($J,""W""," D %XY^%RCR
 W ! S J=0 F  S J=$O(^TMP($J,"W",1,J)) Q:J=""  W !?8,^(J,0) D ASK G:PRCHDQ ASK2
PT I $O(^PRC(442,D0,13,0)) W !!?8,"V.A. TRANSACTION NUMBERS: " F PRCHI=0:0 S PRCHI=$O(^PRC(442,D0,13,PRCHI)) Q:'PRCHI  I $D(^PRCS(410,PRCHI,0)) W !?14,$P(^(0),U,1)
 D AMENDS^PRCHDP6
 I $D(^PRC(442,D0,6,0)) F PRCHI=0:0 S PRCHI=$O(^PRC(442,D0,6,PRCHI)) Q:'PRCHI  I $D(^(PRCHI,0)) W !!?3,"AMENDMENT NUMBER: ",PRCHI,?40,"EFFECTIVE DATE: " S Y=$P(^(0),U,2) D DT D AMD Q:PRCHDQ
 K ^TMP($J,"PRCHDP6")
ASK2 D:'PRCHDQ EN^PRCHDP4 G:'$O(^PRC(442,D0,11,0)) ASK1 W ! S %A="   Review a Receiving Report ",%B="",%=2 D ^PRCFYN G:%'=1 Q
PT1 K DIC S (PRCHPO,DA(1))=D0,DIC="^PRC(442,DA(1),11,",DIC(0)="NEAZ"
 ;--added for PRC*5.1*38
 S DIC("W")="D ADJCHK^PRCHDP2"
 D ^DIC G:Y<0 Q S PRCHDPT=+Y,PRCHDRD=$P(Y(0),U,1),PRCHDTP=1 D ^PRCHDP3 G PT1
ASK I $Y+5>IOSL W !?8,"ENTER '^' TO HALT: " R X:DTIME S:X["^" PRCHDQ=1 D:'PRCHDQ HDR Q
 Q
ASK1 I $G(PRCHAMNT)=2 D    ;PRC*5.1*221
 . W !!,"** An amendment updated the order during your display that affected  **"
 . W !,"** the order's first page total and any items that were amended      **"
 . W !,"** for price/quantity. If the accuracy of the displayed order is     **"
 . W !,"** critical, you should re-display the order again with the updated  **"
 . W !,"** order total and items.                                            **"
 . W !,""
 . Q
 W !,$C(7) G:PRCHDQ Q W "END OF DISPLAY--PRESS RETURN OR ENTER '^' TO HALT: " R X:DTIME G Q
HDR W:$Y>0 @IOF,!!?55,"UNIT",?70,"TOTAL",!,"ITEM",?15,"DESCRIPTION",?42,"QTY",?46,"UNIT",?55,"COST",?70,"COST",! F I=1:1:80 W "-"
 Q
ITEM S DIWL=1,DIWR=33,DIWF="",PRCHDIW=0 K ^UTILITY($J,"W")
 N PURCTYPE,PURPIPE,PRCHI,PRCHJ S:$P($G(^PRC(442,D0,23)),"^",11)="S" PURCTYPE=1   ;PRC*5.1*221  
 D PIPECK S PRCHDIW=0   ;PRC*5.1*221
 F PRCHJ=1:1 S PRCHDIW=$O(^PRC(442,D0,2,PRCHDI,1,PRCHDIW)) Q:PRCHDIW'>0  S X=$S($D(^(PRCHDIW,0)):^(0),1:"") S:PURPIPE DIWF=$G(DIWF)_"|"  D DIWP^PRCUTL($G(DA))   ;PRC*5.1*221
 K ^TMP($J,"W") S %X="^UTILITY($J,""W"",",%Y="^TMP($J,""W""," D %XY^%RCR
 S PRCHDCNT=$S($D(^TMP($J,"W",1)):^(1),1:"") W ! I $G(PURCTYPE)="" W ?2,$J(+$P(PRCHDI0,U,1),3)
 W ?7,$S($D(^(1,1,0)):^(0),1:"")
 I $G(PURCTYPE)="" W ?40,$J($P(PRCHDI0,U,2),5),?47,$S($D(^PRCD(420.5,+$P(PRCHDI0,U,3),0)):$P(^(0),U,1),1:"")
 S X=$P($P(PRCHDI0,U,9),".",2) I $G(PURCTYPE)="" W ?52,$S($L(X)>3:$J($P(PRCHDI0,U,9),5,4),$L(X)>2:$J($P(PRCHDI0,U,9),6,3),$P(PRCHDI0,U,9)="N/C":"    N/C",1:$J($P(PRCHDI0,U,9),7,2))
 W ?67,$J($P(PRCHDI2,U,1),7,2)
 I PRCHDCNT>1 S K=1 F  S K=$O(^TMP($J,"W",1,K)) Q:K=""!(K'>0)  D:$Y+5>IOSL ASK Q:PRCHDQ  W !?8,^(K,0)
 Q:PRCHDQ
 W:$P(PRCHDI0,U,6)]"" !?8,"STK#: ",$P(PRCHDI0,U,6) W:$P(PRCHDI0,U,13)]"" !,?8,"NSN:  ",$P(PRCHDI0,U,13) W:$P($G(^PRC(442,D0,2,PRCHDI,4)),U,12)]"" !,?8,"FOOD GROUP: ",$P(^(4),U,12)
 W:$P(PRCHDI2,U,8)]"" !,?8,"QTY PREV RCVD: ",$J($P(PRCHDI2,U,8),5) I $D(^PRC(442,D0,2,PRCHDI,3,"AC")) W !,?8,"PARTIAL NO.: " S X=0 F K=1:1 S X=$O(^PRC(442,D0,2,PRCHDI,3,"AC",X)) Q:X=""  W:K>1 "," W X
 N ZZ S ZZ=0 D EDISTAT^PRCHUTL(D0,PRCHDI,.ZZ) ;***** NEW CODE EDI STATUS DISPLAY *****
 I $G(PURCTYPE)="",$P(PRCHDI0,U,12) W:'ZZ ! W ?8,"Items per ",$S($D(^PRCD(420.5,+$P(PRCHDI0,U,3),0)):$P(^(0),U,1),1:""),": ",$P(PRCHDI0,U,12),!
 D ASK ;***** NEW CODE TO CORRECT PAGING PROBLEM *****
 W:$X>1 !
 W ?8,"BOC: ",$P($P(PRCHDI0,U,4)," ",1) S FMSLN=$O(^PRC(442,D0,22,"B",+$P(PRCHDI0,U,4),0))
 I FMSLN>0,'$P($G(^PRC(442,D0,23)),U,8) S FMSLN="00"_$P($G(^PRC(442,D0,22,FMSLN,0)),U,3),FMSLN=$E(FMSLN,$L(FMSLN)-2,99) W ?22,"FMS LINE: ",FMSLN
 W:$P(PRCHDI2,U,2)]"" ?40,"CONTRACT: ",$P(PRCHDI2,U,2)
 W !
 Q
DIS W $S($P(PRCHDI0,U,1)="Q":"QUANTITY DISCOUNT",1:"ITEMS: "_$P(PRCHDI0,U,1)),?57,$J($P(PRCHDI0,U,3),8,2),! Q
 Q
AMD D:$D(^PRC(442,D0,6,PRCHI,3))  Q:PRCHDQ
 .K ^TMP($J,"W") D START^PRCHDP5(D0,PRCHI)
 .W ! F J=0:0 S J=$O(^TMP($J,"W",1,J)) Q:'J  W !?8,^(J,0) D ASK Q:PRCHDQ
 .Q
 D:$D(^PRC(442,D0,6,PRCHI,2))
 .K ^UTILITY($J,"W") S DIWL=1,DIWR=60 F PRCHJ=0:0 S PRCHJ=$O(^PRC(442,D0,6,PRCHI,2,PRCHJ)) Q:'PRCHJ  S X=^(PRCHJ,0) D DIWP^PRCUTL($G(DA))
 .K ^TMP($J,"W") S %X="^UTILITY($J,""W"",",%Y="^TMP($J,""W""," D %XY^%RCR
 .W ! F J=0:0 S J=$O(^TMP($J,"W",1,J)) Q:'J  W !?8,^(J,0) D ASK Q:PRCHDQ
 .Q
 Q
DT I Y W Y\100#100,"/",Y#100\1,"/",Y\10000+1700
 Q
ADJCHK ;Check for any Adjustment on PO. If any show the adjuster. PRC*5.1*38
 Q:'$D(^PRC(442,PRCHPO,6,0))
 N CHKADJ,ISADJ,ADJDT,ADJDATA,ADJNUM
 S CHKADJ="",ISADJ=0,ADJDT=""
 S CHKADJ=$P($G(^PRC(442,PRCHPO,11,Y,0)),U,21)
 I CHKADJ="" Q
 S ADJDATA=$G(^PRC(442,PRCHPO,6,CHKADJ,0))
 N Y
 S Y=$P($G(ADJDATA),"^",2)
 Q:'Y
 D DD^%DT
 W ?30,"(Adjustment date: ",Y,")"
 Q
Q ;W @IOF  ;REMOVE IF PROBLEM WITH KERNEL V6.5
 K I,J,K,N,DIC,DIWF,DIWL,DIWR,IOP,PRCHDI,PRCHD0,PRCHD1,PRCHFTYP,PRCHDSIT,PRCHDHSP,PRCHDSHP,PRCHDST,PRCHDS,PRCHDV,PRCHDQ,PRCHDI0,PRCHDI2,PRCHDIW,PRCHDCNT,PRCHI,PRCHJ,PRCHK,S,V,^TMP($J,"W"),^UTILITY($J,"W"),KK,JJ Q
PIPECK ;check for invalid pipe '|IN ' command in item description   ;PRC*5.1*221
 S PURPIPE=0,PRCH=0
 F PRCHI=1:1 S PRCH=$O(^PRC(442,D0,2,PRCH)),PRCHDIW=0 Q:'PRCH  D  Q:PURPIPE
 . F PRCHJ=1:1 S PRCHDIW=$O(^PRC(442,D0,2,PRCH,1,PRCHDIW)) Q:PRCHDIW'>0  S X=$S($D(^(PRCHDIW,0)):^(0),1:"") D  Q:PURPIPE
 . . I X["| IN " S PURPIPE=1
 . . Q
 Q
