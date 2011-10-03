PRCHDAM ;WISC/DJM,ID/RSD-DISPLAY AN AMENDMENT ;2/12/98  2:38 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 N X8,X9
 S D0=$S($D(PRCHPO):PRCHPO,1:D0),D1=$S($D(PRCHAM):PRCHAM,1:D1),U="^"
 Q:'$D(^PRC(443.6,D0,6,D1))  S IOP="HOME",%ZIS="",PRCHD0=^(D1,0),PRCHD1=^(1),PRCHDP0=^PRC(443.6,D0,0),PRCHDP1=^PRC(443.6,D0,1),PRCHDAV=$S($P(PRCHD0,U,8)="Y":1,1:0),PRC("SITE")=+PRCHDP0,U="^",PRCHDUL="",$P(PRCHDUL,"_",80)=""
 D ^%ZIS W:$Y>0 @IOF G:PRCHDAV EN2 W !,"2. MOD. NO.: ",?15,"| 3. EFFECTIVE DATE: ",?46,"| 4. REQUISITION/P.O. REQ. NO.: "
 W !?6,$P(PRCHD0,U,1),?15,"|       " S Y=$P(PRCHD0,U,2) D DT
 S Y=0 I $P(PRCHDP0,U,12),$D(^PRCS(410,+$P(PRCHDP0,U,12),0)) S Y=$P(^(0),U)
 W ?46,"|  ",$S(Y:Y_"/",1:"        "),$P($P($G(^PRC(443.6,D0,0)),U,1),"-",2),!,PRCHDUL
 S X=$G(^PRC(440,+PRCHDP1,0)) W !,"8. NAME AND ADDRESS OF CONTRACTOR ",?40,"| 10A. MODIFICATION OF CONTRACT/ORDER",!?5,$P(X,U,1),?40,"|       NO."
 W ?52,$P($G(^PRC(443.6,PRCHPO,0)),U)
 D X8 S J=1 F I=2:1:5 I $P(X,U,I)]"" W !?5,$P(X,U,I),?40,"|" I J<X8 X X(J)
 W !?5,$P(X,U,6),", ",$P($G(^DIC(5,+$P(X,U,7),0)),U,2),"  ",$P(X,U,8),?40,"|" I J<X8 X X(J)
 I J<X8 W:$X>40 ! F  W ?40,"|" X X(J) Q:J>(X8-1)  W !
ACC W !,PRCHDUL,!,"12. ACCOUNTING AND APPROPRIATION DATA (If required)" S X=$P(PRCHD0,U,3) W !?5,$S('X:"",X<0:"Decrease ",1:"Increase "),$P(PRCHDP0,U,4),"-",$P($P(PRCHDP0,U,3)," ",1) W:X "  $",$J($S(X<0:-X,1:X),10,2)
 I X W ?50,"TOTAL AMOUNT: $",$J($P(PRCHDP0,U,15),10,2)
 W !,PRCHDUL S Y=$G(^PRCD(442.2,+$P(PRCHD0,U,4),0)) W !,$P(Y,U,1),".  ",$P(Y,U,2),!?3,$P(PRCHD0,U,7),!,PRCHDUL
 W !,"    IMPORTANT: Contractor is ",$S($P(PRCHD0,U,5)="Y":"",1:"not "),"required to sign this document and return"
 W !,?4,$S($P(PRCHD0,U,5)="Y":+$P(PRCHD0,U,6)_" ",1:""),"copies to the issuing office."
 W !!?8,"ENTER '^' TO HALT: " R X:DTIME G Q:X["^" W @IOF
 S PRCHLC1=6,PRCHLC2=0
 W !,"14. DESCRIPTION OF MODIFICATION (organized by UCF section heading,",!?5," including contract subject matter where feasible.)",!,PRCHDUL,!! D ITEM G:PRCHLC1["^" Q
 D:(IOSL-7-PRCHLC2)<3 PGE G:PRCHLC1["^" Q
 W !!,"Except as provided herein, all terms and conditions of the document referenced",!,"in Item 10A, as heretofore changed, remains unchanged and in full force and",!,"effect.",!,PRCHDUL
 D REASON^PRCHDAM0
CO W !,"CONTRACTING OFFICER: " S Y=+$P(PRCHD1,U,1),Y=$P($G(^VA(200,Y,0)),U,1) W ?22,$P(Y,",",2)," ",$P(Y,",",1),!!
 W ?8,"ENTER '^' TO HALT: " R X:DTIME
Q ;exit point
 K PRCHD0,PRCHD1,PRCHDP0,PRCHDP1,PRCHDAV,PRCHDUL,PRCHII,PRCHLC1,PRCHLC2,X,^UTILITY($J,"W") Q
ITEM K ^UTILITY($J,"W") S DIWL=3,DIWR=75,DIWF="" I PRCHDAV'>0,$P($G(^PRC(443.6,D0,6,D1,2,0)),U,4)'>0 D START^PRCHDAM1(D0,D1) S DIWL=1 G CONT
 S PRCHII=0 F  S PRCHII=$O(^PRC(443.6,D0,6,D1,2,PRCHII)) Q:PRCHII=""!(PRCHII'>0)  S X=^(PRCHII,0) D DIWP^PRCUTL($G(DA))
CONT K J S J=0,L=0 F I=0:0 S I=$O(^UTILITY($J,"W",DIWL,I)) S:'I J(L)=J Q:'I  S:'L L=I S J=J+1 I "          "[^(I,0) S J(L)=J,J=0,L=0
 F I=0:0 S I=$O(^UTILITY($J,"W",DIWL,I)) Q:'I  D:$D(J(I)) CHKP Q:PRCHLC1["^"  W !,^(I,0) S PRCHLC2=PRCHLC2+1
 Q
CHKP D:(IOSL-PRCHLC1-PRCHLC2-J(I))<3 PGE
 Q
PGE W !!?8,"ENTER '^' TO HALT: " R X:DTIME I X["^" S PRCHLC1="^" Q
 W:$Y>0 @IOF S PRCHLC1=3,PRCHLC2=0
 Q
DT Q:'Y  W Y\100#100,"/",Y#100\1,"/",Y\10000+1700
 Q
X8 S (CTNO,X8)=0 F X8=1:1:3 S CTNO=$O(^PRC(443.6,D0,2,"AC",CTNO)) Q:CTNO=""  D
 .S X(X8)="W ?47,""CONTRACT # ",X(X8)=X(X8)_X8,X(X8)=X(X8)_": ",X(X8)=X(X8)_CTNO,X(X8)=X(X8)_""" S J=",X9=X8+1,X(X8)=X(X8)_X9
 I $G(X(X8))]"" S X8=X8+1
 S X(X8)="S J=",X9=X8+1,X(X8)=X(X8)_X9,X(X8)=X(X8)_" F K=1:1:38 W ""_""" S X8=X8+1
 S X(X8)="W ?40,"" 10B. DATED (See Item 13)  "" S Y=$P(PRCHDP1,U,15),J=",X9=X8+1,X(X8)=X(X8)_X9,X(X8)=X(X8)_" D DT",X8=X8+1
 Q
EN2 ;ADJUSTMENT VOUCHER DISPLAY
 W !?10,"ADJUSTMENT VOUCHER   " S Y=$P(PRCHD0,U,2) D DT W !,PRCHDUL S PRCHLC1=3,PRCHLC2=0 D ITEM D:(IOSL-3-PRCHLC2)<3 PGE G CO
