PRCECAL ;WISC/LDB/BGJ-RECALCULATE AUTHORIZATION BALANCES ; 03 Feb 93  10:29 AM 
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
FISCAL ;Entry point for any obligation's authorizations
 D EXIT S PRCF("X")="AS" D ^PRCFSITE
 I '$D(PRC("SITE")) D EXIT Q
 D OBLK^PRCH58OB(.PODA)
 I '$G(PODA) D EXIT Q
 I (+PODA(1)'=PRC("SITE")) D EXIT Q
 G:'$P(PODA(0),U,12) EXIT  S PO=$P(PODA(0),U,12) D NODE^PRCS58OB(PO,.TRNODE) G:$P($G(TRNODE(0)),U,4)'=1 EXIT  S PO=PODA(1)
 Q:'$D(^PRC(424,"AF",PO))
 D RECALC
 Q
 ;
FCP ;Entry point for Fund Control Point for obligations within the FCP
 D EXIT,EN3^PRCSUT I '$D(PRC("CP"))!'$D(PRC("SITE")) D EXIT Q
 D OBLK^PRCH58OB(.PODA)
 I '$G(PODA) D EXIT Q
 I (+PODA(0)'=PRC("SITE"))!(+PODA(2)'=+PRC("CP"))!('$P(PODA(0),U,12)) D EXIT Q
 S PO=$P(PODA(0),U,12) D NODE^PRCS58OB(PO,.TRNODE)
 S PO=PODA(1) I '$D(^PRC(424,"AF",PO)) D EXIT Q
 ;
RECALC ;Recalculate totals in file 424
 ;Update obligation estimated balance
 S AUDA="",FCPAMT=0 F  S AUDA=$O(^PRC(424,"AF",PO,AUDA)) Q:'AUDA  I $D(^PRC(424,AUDA,0)) S (AUAMT,AUBAL)=0 D
 .S FCPAMT=$P(^PRC(424,AUDA,0),U,6)+FCPAMT
 D BALOB^PRCH58(PODA,FCPAMT)
 ;Update obligation Fiscal liquidation balance
 S AUDA="",LQAMT=0 F  S AUDA=$O(^PRC(424,"AG",PO,AUDA)) Q:'AUDA  I $D(^PRC(424,AUDA,0)) D
 .S LQAMT=$P(^PRC(424,AUDA,0),U,4)+LQAMT
 D BAL1^PRCH58OB(PODA,LQAMT)
 ;S AMT=+$G(BAL)-LQAMT D BAL1^PRCH58OB(PODA,AMT)
 ;Update authorizations balances
 S (DRAMT,AUDA,DRAUMT)=0 F  S AUDA=$O(^PRC(424,"AD",PO,AUDA)) Q:'AUDA  I $D(^PRC(424,AUDA,0)),$P(^(0),U,3)="AU" S DRAUMT=$P(^(0),U,12) D
 . S (DRPAMT,DA)=0 F  S DA=$O(^PRC(424.1,"C",AUDA,DA)) Q:'DA  I $D(^PRC(424.1,DA,0)) D
 ..S:$P(^PRC(424.1,DA,0),U,11)="P" DRPAMT=$P(^PRC(424.1,DA,0),U,3)+DRPAMT ;S:$P(^(0),U,11)["A" DRAUMT=DRAUMT+$P(^(0),U,3)
 . S $P(^PRC(424,AUDA,0),U,12)=$S((+$G(DRAUMT)'<0):DRAUMT,(+$G(DRAMT)'<0):DRAMT,1:+$P($G(^PRC(424,AUDA,0)),U,13))
 . S $P(^PRC(424,AUDA,0),U,5)=$P(^PRC(424,AUDA,0),U,12)+$G(DRPAMT),AUAMT(AUDA)=$P(^(0),U)_"^"_$P(^(0),U,12)_"^"_$P(^(0),U,5)_"^"_-DRPAMT,AUAMT=AUAMT+DRAMT,AUBAL=AUBAL+$P(^(0),U,5)
 ;Update obligation balance
 S (AMT,AUDA)=0 F  S AUDA=$O(^PRC(424,"AD",PO,AUDA)) Q:'AUDA  I $D(^PRC(424,AUDA,0)) D
 . S AMT=$P(^(0),U,12)+AMT
 ;Print obligation, liquidation and authorization balances
 S BAL1=AMT D BALAU^PRCH58(PODA,BAL1)
 S BAL=$$BAL^PRCH58(PODA)
 W @IOF,!,?25,PO," ","OBLIGATION BALANCES"
 W !!,"  OBLIGATION AMOUNT: $",$$LBF1^PRCFU($FN(+BAL,",P",2),14)
 W ?37,"   SERVICE BALANCE: $",$$LBF1^PRCFU($FN(+BAL-$P(BAL,U,3),",P",2),14)
 W !,"LIQUIDATION BALANCE: $",$$LBF1^PRCFU($FN($P(BAL,U)-$P(BAL,U,2),",P",2),14)
 W ?37,"TOTAL LIQUIDATIONS: $",$$LBF1^PRCFU($FN($P(BAL,U,2),",P",2),14)
 W !!,"AUTHORIZATION BALANCE(S): " S AUDA=0
 W !!,"AUTHORIZATION #",?21,"AMOUNT",?37,"BALANCE",?54,"PAYMENT"
 F  S AUDA=$O(AUAMT(AUDA)) Q:'AUDA  D  Q:X="^"
 .S DIR(0)="E" I ((IOSL-$Y)<4) D ^DIR Q:X="^"  W @IOF
 .W !,$P(AUAMT(AUDA),U)
 .W ?17,"$",$$LBF1^PRCFU($FN($P(AUAMT(AUDA),U,2),",P",2),14)
 .W ?34,"$",$$LBF1^PRCFU($FN($P(AUAMT(AUDA),U,3),",P",2),14)
 .W ?51,"$",$$LBF1^PRCFU($FN($P(AUAMT(AUDA),U,4),",P",2),14)
 G:X="^" EXIT I $Y+4>IOSL D ^DIR Q:X="^"   W @IOF
 W !,?17,"______________",?34,"______________",?51,"______________" W !?17,"$",$$LBF1^PRCFU($FN(AMT,",P",2),14),?34,"$",$$LBF1^PRCFU($FN(AUBAL,",P",2),14),?51,"$",$$LBF1^PRCFU($FN(AMT-AUBAL,",P",2),14)
EXIT K AMT,AUAMT,AUBAL,AUDA,BAL,BAL1,DA,DIC,DIR,DRAMT,DRAUMT,FCPAMT,LQAMT,PO,PODA,PRC,PRCF,X,Y,TRNODE,PRCF
 Q
