RCDPR215 ;WISC/RFJ-receipt processing sf215 report ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,173,211,220**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
DQ ;  queued report starts here, input RECEIPDA
 ;  RCTYPE="D"etail or "A"ccrual
 N %I,AMOUNT,BILL,BILLDA,COMMENTS,COUNT,DA,DATA,DEPOSIT,DETAIL,FMSDOCNO,FUND,NOW,PAGE,PIECE,PRINTOTL,RCSTFLAG,RCYLINE,RECEIPT,SCREEN,TOTAL,TOTLAMT,UNAPPLY,X,Y,TOT,%,REPRODT,EFTFUND
 ;
 ;  calculate report
 ;  input receipda (ien of receipt)
 K ^TMP($J,"RCFMSCR"),^TMP($J,"RCDPR215")
 S EFTFUND=$S(DT<$$ADDPTEDT^PRCAACC():"5287.4/8NZZ",1:"528704/8NZZ")
 S REPRODT=$P($P($G(^RCY(344,RECEIPDA,0)),"^",8),".")
 D FMSLINES^RCXFMSC1(RECEIPDA)
 I $$EDILB^RCDPEU(RECEIPDA)=1 D  ; EFT deposit receipt
 . S TOT=0
 . S Z=0 F  S Z=$O(^RCY(344,RECEIPDA,1,Z)) Q:'Z  S TOT=TOT+$P($G(^(Z,0)),U,4)
 . S ^TMP($J,"RCFMSCR",EFTFUND)=TOT
 ;
 ;  print report
 S DATA=$G(^RCY(344,RECEIPDA,0))
 S RECEIPT=$P(DATA,"^")
 S DEPOSIT=$P($G(^RCY(344.1,+$P(DATA,"^",6),0)),"^")
 S FMSDOCNO=$P($G(^RCY(344.1,+$P(DATA,"^",6),2)),"^")
 ;
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y
 S PAGE=0,RCYLINE="",$P(RCYLINE,"-",81)=""
 S SCREEN=0 I '$D(ZTQUEUED),IO=IO(0),$E(IOST)="C" S SCREEN=1
 U IO D H
 ;
 S TOTAL=""  ;  stores printotal^inttotal^admintotal^marshtotal^cctotal
 S FUND="" F  S FUND=$O(^TMP($J,"RCFMSCR",FUND)) Q:'FUND!($G(RCSTFLAG))  D
 .   I $Y>(IOSL-6) D:SCREEN PAUSE Q:$G(RCSTFLAG)  D H
 .   W !!?5,"Appropriation: ",FUND
 .   I RCTYPE="D" W !
 .   ;
 .   S PRINTOTL=0
 .   S COUNT=0
 .   I FUND=EFTFUND S PRINTOTL=PRINTOTL+$G(^TMP($J,"RCFMSCR",FUND))
 .   S BILLDA=0 F  S BILLDA=$O(^TMP($J,"RCFMSCR",FUND,BILLDA)) Q:'BILLDA!($G(RCSTFLAG))  D
 .   .   I $Y>(IOSL-5) D:SCREEN PAUSE Q:$G(RCSTFLAG)  D H
 .   .   S COUNT=COUNT+1
 .   .   S BILL=$P($G(^PRCA(430,BILLDA,0)),"^")
 .   .   S DATA=^TMP($J,"RCFMSCR",FUND,BILLDA)
 .   .   S PRINTOTL=PRINTOTL+$P(DATA,"^")
 .   .   F PIECE=1:1:5 S $P(TOTAL,"^",PIECE)=$P(TOTAL,"^",PIECE)+$P(DATA,"^",PIECE)
 .   .   ;  if accrued report, do not show detail
 .   .   I RCTYPE="A" Q
 .   .   ;
 .   .   W !?5,COUNT,")",?10,BILL,?30,$J($P(DATA,"^"),10,2),?45,"DEBTOR: ",$E($$DEBTOR(BILLDA),1,25)
 .   .   W !?15,"INT:",$J($P(DATA,"^",2),10,2)," ADMIN:",$J($P(DATA,"^",3),10,2)," MARS: ",$J($P(DATA,"^",4),10,2)," CC: ",$J($P(DATA,"^",5),10,2)
 .   ;
 .   I $G(RCSTFLAG) Q
 .   I RCTYPE="D" W !?30,"----------",!?5,"TOTAL for ",FUND
 .   W ?30,$J(PRINTOTL,10,2)
 .   I FUND="0160a1" W ?45,"0160a1 sub-totals Champva receipts",!?45,"not sent to FMS on the CR document."
 ;
 I $G(RCSTFLAG) D Q Q
 I $Y>(IOSL-6) D:SCREEN PAUSE I '$G(RCSTFLAG) D H
 I $G(RCSTFLAG) D Q Q
 ;
 ;  show int, admin, etc totals
 W !
 W !?5,"INTEREST : (APP: 1435)",?30,$J($P(TOTAL,"^",2),10,2)
 W !?5,"ADMIN    : (APP: 3220)",?30,$J($P(TOTAL,"^",3),10,2)
 W !?5,"MARSHALL : (APP: 0869)",?30,$J($P(TOTAL,"^",4),10,2)
 W !?5,"COURTCOST: (APP: 0869)",?30,$J($P(TOTAL,"^",5),10,2)
 W !?30,"----------"
 W !?30,$J($P(TOTAL,"^",2)+$P(TOTAL,"^",3)+$P(TOTAL,"^",4)+$P(TOTAL,"^",5),10,2)
 ;
 I $Y>(IOSL-8) D:SCREEN PAUSE I '$G(RCSTFLAG) D H
 I $G(RCSTFLAG) D Q Q
 ;
 I $G(^TMP($J,"RCFMSCR",EFTFUND)) S $P(TOTAL,U)=$P(TOTAL,U)+^TMP($J,"RCFMSCR",EFTFUND)
 ;  compile unapplied amounts that went to suspense
 S DA=0 F  S DA=$O(^RCY(344,RECEIPDA,1,DA)) Q:'DA  D
 .   S AMOUNT=$P($G(^RCY(344,RECEIPDA,1,DA,0)),"^",4) I 'AMOUNT Q
 .   S UNAPPLY=$P($G(^RCY(344,RECEIPDA,1,DA,2)),"^",5) I UNAPPLY="" Q
 .   ;  if amount has not been processed, show it in suspense
 .   I '$P(^RCY(344,RECEIPDA,1,DA,0),"^",5) S ^TMP($J,"RCDPR215",DA)=UNAPPLY_"^"_AMOUNT_"^"_$P($G(^RCY(344,RECEIPDA,1,DA,1)),"^",2)
 ;
 ;  print unapplied amounts that went to suspense
 I $O(^TMP($J,"RCDPR215",0)) D
 .   W !!?5,"Appropriation: 3875"
 .   I RCTYPE="D" W !
 .   ;
 .   S COUNT=0,PRINTOTL=0
 .   S DA=0 F  S DA=$O(^TMP($J,"RCDPR215",DA)) Q:'DA!($G(RCSTFLAG))  D
 .   .   I $Y>(IOSL-6) D:SCREEN PAUSE Q:$G(RCSTFLAG)  D H
 .   .   ;
 .   .   S UNAPPLY=$P(^TMP($J,"RCDPR215",DA),"^"),AMOUNT=$P(^(DA),"^",2),COMMENTS=$P(^(DA),"^",3)
 .   .   S PRINTOTL=PRINTOTL+AMOUNT
 .   .   S $P(TOTAL,"^")=$P(TOTAL,"^")+AMOUNT
 .   .   ;  if accrued report, do not show detail
 .   .   I RCTYPE="A" Q
 .   .   ;
 .   .   S COUNT=COUNT+1
 .   .   W !?5,COUNT,")",?10,UNAPPLY,?30,$J(AMOUNT,10,2),?45,"COMMENTS: ",$E(COMMENTS,1,25)
 .   .   I $TR($E(COMMENTS,26,80)," ")'="" W !?25,$E(COMMENTS,26,80)
 .   ;
 .   I $G(RCSTFLAG) Q
 .   I RCTYPE="D" W !?30,"----------",!?5,"TOTAL for 3875"
 .   W ?30,$J(PRINTOTL,10,2)
 I $G(RCSTFLAG) D Q Q
 ;
 S TOTLAMT=0 F PIECE=1:1:5 S TOTLAMT=TOTLAMT+$P(TOTAL,"^",PIECE)
 W !!,"TOTALS: "
 W !?5,"TOTAL AMOUNT POSTED:",?30,$J(TOTLAMT,10,2)
 ;
 I SCREEN W !,"Press RETURN to continue: " R X:DTIME
Q D ^%ZISC
 K ^TMP($J,"RCFMSCR"),^TMP($J,"RCDPR215")
 Q
 ;
 ;
GETTYPE() ;  ask the type of report to print
 N DIR,X,Y
 S DIR(0)="S^A:ACCRUED;D:DETAILED",DIR("A")="ACCRUED OR DETAILED REPORT",DIR("B")="ACCRUED",DIR("?")="A DETAILED Report will list out accrued bills separately"
 S DIR("?",1)="An ACCRUED Report will list just the accrued total under each appropriation"
 D ^DIR
 I Y'="A",Y'="D" Q ""
 Q Y
 ;
 ;
DEBTOR(DA) ;  returns the debtor name for ien of bill (da) in file 430
 N D0,DEBTOR,DIC,DIQ,DR
 S DIC="^PRCA(430,",DR=9,DIQ(0)="E",DIQ="DEBTOR"
 D EN^DIQ1
 Q $G(DEBTOR(430,DA,9,"E"))
 ;
 ;
H ;  header
 N Z
 S PAGE=PAGE+1 I PAGE'=1!(SCREEN) W @IOF
 W $C(13),"Page ",PAGE,?(80-$L(NOW)),NOW
 W !,$E($TR(RCYLINE,"-","*"),1,34)," 215 REPORT ",$E($TR(RCYLINE,"-","*"),1,34)
 W !!,"RECEIPT #: ",RECEIPT,?25,"for DEPOSIT #: ",DEPOSIT
 I FMSDOCNO'="" W ?51,"FMS Document #: ",FMSDOCNO
 S Z=""
 I $P($G(^RCY(344,RECEIPDA,0)),U,18) S Z=$E(" REFERENCE ERA #: "_$P($G(^RCY(344.4,+$P($G(^RCY(344,RECEIPDA,0)),U,18),0)),U)_" ("_$P($G(^RCY(344.4,+$P($G(^RCY(344,RECEIPDA,0)),U,18),0)),U,2)_")"_$J("",51),1,51)
 I Z'="" W !,Z
 W !,RCYLINE
 Q
 ;
 ;
PAUSE ;  pause at end of page
 N X U IO(0) W !,"Press RETURN to continue, '^' to exit:" R X:DTIME S:'$T X="^" S:X["^" RCSTFLAG=1 U IO
 Q
