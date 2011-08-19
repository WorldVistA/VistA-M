RCDPE215 ;ALB/TMK- SF215 EDI Lockbox Summary Report ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,173,220**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
SUMM215 ;  summary 215
 D FULL^VALM1
 S VALMBCK="R"
 ;
 N %,%ZIS,POP,RCDEPTDA,RCTYPE,DIC,X,Y,ZTSAVE,ZTDESC,ZTSK,ZTRTN
 ;
 S DIC(0)="AEMQ",DIC="^RCY(344.1,",DIC("A")="Select DEPOSIT: "
 D ^DIC K DIC
 I Y'>0 Q
 S RCDEPTDA=+Y
 S RCTYPE=$$GETTYPE^RCDPR215
 I RCTYPE="" Q
 ;
 ; device
 W ! S %ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK D ^%ZISC Q
 .   S ZTDESC="Print Summary 215 Report",ZTRTN="DQ^RCDPE215"
 .   S ZTSAVE("RCDEPTDA")="",ZTSAVE("RCTYPE")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
 D DQ
 Q
 ;
DQ ;  queued report entrypoint
 ;  RCDEPTDA = ien of the deposit to summarize
 ;  RCTYPE="D"etail or "A"ccrual
 N %I,AMOUNT,BILL,BILLDA,COMMENTS,COUNT,DA,DATA,DEPOSIT,FMSDOCNO,FUND,NOW,PAGE,PIECE,PRINTOTL,RCSTFLAG,RCYLINE,RECEIPT,SCREEN,TOTAL,TOTLAMT,UNAPPLY,X,Y,RCDETAIL,PCT,RECEIPDA,TOT,EDITOT,DETAIL,Z,EFTFUND
 ;
 ;  calculate report
 K ^TMP($J,"RCFMSCR"),^TMP($J,"RCFMSCR_SUM"),^TMP($J,"RCDPR215"),^TMP($J,"RCDET")
 S EFTFUND=$S(DT<$$ADDPTEDT^PRCAACC():"5287.4/8NZZ",1:"528704/8NZZ")
 S DEPOSIT=$P($G(^RCY(344.1,RCDEPTDA,0)),U)
 S RECEIPDA=0 F  S RECEIPDA=$O(^RCY(344,"AD",RCDEPTDA,RECEIPDA)) Q:'RECEIPDA  D
 . D FMSLINES^RCXFMSC1(RECEIPDA)
 . ; sort by Receipt #
 . S ^TMP($J,"RCFMSCR_SUM",RECEIPDA)=""
 . M ^TMP($J,"RCFMSCR_SUM",RECEIPDA)=^TMP($J,"RCFMSCR")
 . K ^TMP($J,"RCFMSCR")
 . I $$EDILB^RCDPEU(RECEIPDA)=1 D  ; EFT dep receipt
 .. S TOT=0
 .. S Z=0 F  S Z=$O(^RCY(344,RECEIPDA,1,Z)) Q:'Z  S TOT=TOT+$P($G(^(Z,0)),U,4)
 .. S (^TMP($J,"RCFMSCR_SUM",RECEIPDA,EFTFUND),^TMP($J,"RCTOT","EDILBOX"))=TOT
 ;
 ;  summary rep for a deposit
 S PAGE=0,RCYLINE="",$P(RCYLINE,"-",81)=""
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y
 S SCREEN=0 I '$D(ZTQUEUED),IO=IO(0),$E(IOST)="C" S SCREEN=1
 U IO
 K ^TMP($J,"RCTOT")
 S RCDETAIL=1,PCT=0,EDITOT=0
 S RECEIPDA=0 F  S RECEIPDA=$O(^TMP($J,"RCFMSCR_SUM",RECEIPDA)) Q:'RECEIPDA  D
 . S DATA=$G(^RCY(344,RECEIPDA,0))
 . S RECEIPT=$P(DATA,"^")
 . S FMSDOCNO=$P($G(^RCY(344.1,+$P(DATA,"^",6),2)),"^")
 . D SET("<NP>",RECEIPT_"@"_FMSDOCNO_"@"_RECEIPDA,.PCT)
 . ;
 . S TOTAL=""  ;  stores printotal^inttotal^admintotal^marshtotal^cctotal
 . ;
 . S FUND="" F  S FUND=$O(^TMP($J,"RCFMSCR_SUM",RECEIPDA,FUND)) Q:'FUND  D
 ..   D SET("!!?5","Appropriation: "_FUND,.PCT)
 ..   I RCTYPE="D" D SET("!","",.PCT)
 ..   ;
 ..   S PRINTOTL=0
 ..   S COUNT=0
 ..   I FUND=EFTFUND S PRINTOTL=PRINTOTL+$G(^TMP($J,"RCFMSCR_SUM",RECEIPDA,FUND)),EDITOT=EDITOT+$G(^TMP($J,"RCFMSCR_SUM",RECEIPDA,FUND))
 ..   S BILLDA=0 F  S BILLDA=$O(^TMP($J,"RCFMSCR_SUM",RECEIPDA,FUND,BILLDA)) Q:'BILLDA  D
 ...   S COUNT=COUNT+1
 ...   S BILL=$P($G(^PRCA(430,BILLDA,0)),"^")
 ...   S DATA=^TMP($J,"RCFMSCR_SUM",RECEIPDA,FUND,BILLDA)
 ...   S PRINTOTL=PRINTOTL+$P(DATA,"^")
 ...   F PIECE=1:1:5 S $P(TOTAL,"^",PIECE)=$P(TOTAL,"^",PIECE)+$P(DATA,"^",PIECE),$P(^TMP($J,"RCTOT","TOTAL"),"^",PIECE)=$P($G(^TMP($J,"RCTOT","TOTAL")),"^",PIECE)+$P(DATA,"^",PIECE)
 ...   ;  if accrued report,no detail
 ...   I RCTYPE="A" Q
 ...   ;
 ...   D SET("!?5",COUNT_")",.PCT),SET("?10",BILL,.PCT),SET("?30",$J($P(DATA,"^"),10,2),.PCT),SET("?45","DEBTOR: "_$E($$DEBTOR^RCDPR215(BILLDA),1,25),.PCT)
 ...   D SET("!?15","INT:"_$J($P(DATA,"^",2),10,2)_" ADMIN:"_$J($P(DATA,"^",3),10,2)_" MARS: "_$J($P(DATA,"^",4),10,2)_" CC: "_$J($P(DATA,"^",5),10,2),.PCT,1)
 ..   ;
 ..   I RCTYPE="D" D SET("!?30","----------",.PCT),SET("!?5","TOTAL for "_FUND,.PCT)
 ..   D SET("?30",$J(PRINTOTL,10,2),.PCT)
 ..   I FUND="0160a1" D SET("?45","0160a1 sub-totals Champva receipts",.PCT),SET("!?45","not sent to FMS on the CR document.",.PCT)
 ..   S ^TMP($J,"RCTOT","PRINTOTL",FUND)=$G(^TMP($J,"RCTOT","PRINTOTL",FUND))+PRINTOTL
 ..   I FUND=EFTFUND S $P(^TMP($J,"RCTOT","TOTAL"),U)=$P($G(^TMP($J,"RCTOT","TOTAL")),U)+PRINTOTL
 . ;
 . ;  show int, admin, etc receipt totals
 . D SET("!","",.PCT)
 . D SET("!?5","INTEREST : (APP: 1435)",.PCT),SET("?30",$J($P(TOTAL,"^",2),10,2),.PCT)
 . D SET("!?5","ADMIN    : (APP: 3220)",.PCT),SET("?30",$J($P(TOTAL,"^",3),10,2),.PCT)
 . D SET("!?5","MARSHALL : (APP: 0869)",.PCT),SET("?30",$J($P(TOTAL,"^",4),10,2),.PCT)
 . D SET("!?5","COURTCOST: (APP: 0869)",.PCT),SET("?30",$J($P(TOTAL,"^",5),10,2),.PCT)
 . D SET("!?30","----------",.PCT)
 . D SET("!?30",$J($P(TOTAL,"^",2)+$P(TOTAL,"^",3)+$P(TOTAL,"^",4)+$P(TOTAL,"^",5),10,2),.PCT)
 . ;
 . I $G(^TMP($J,"RCFMSCR_SUM",RECEIPDA,EFTFUND)) S $P(TOTAL,U)=$P(TOTAL,U)+^TMP($J,"RCFMSCR_SUM",RECEIPDA,EFTFUND)
 . D SUSP(RECEIPDA,RCTYPE,.TOTAL,.PCT)
 . ;
 . S TOTLAMT=0 F PIECE=1:1:5 S TOTLAMT=TOTLAMT+$P(TOTAL,"^",PIECE)
 . D SET("!!","TOTALS: ",.PCT)
 . D SET("!?5","TOTAL AMT POSTED FOR RECEIPT:",.PCT),SET("?30",$J(TOTLAMT,10,2),.PCT,1)
 ;
 D H
 W !!,"**** GRAND TOTALS FOR DEPOSIT: "_$P($G(^RCY(344.1,+RCDEPTDA,0)),U)
 S TOT=0
 S FUND="" F  S FUND=$O(^TMP($J,"RCTOT","PRINTOTL",FUND)) Q:FUND=""  D
 . W !!?5,"Appropriation: ",FUND,": ",?35,$J($G(^TMP($J,"RCTOT","PRINTOTL",FUND)),10,2)
 . S TOT=TOT+$G(^TMP($J,"RCTOT","PRINTOTL",FUND))
 W !,?35,"=============",!,"Total Appropriation: ",?35,$J(+TOT,10,2)
 I FUND="0160a1" W ?47,"0160a1 sub-totals Champva receipts",!?47,"not sent to FMS on the CR doc."
 ;
 S TOTAL=$G(^TMP($J,"RCTOT","TOTAL"))
 W !
 W !?5,"INTEREST : (APP: 1435)",?35,$J($P(TOTAL,"^",2),10,2)
 W !?5,"ADMIN    : (APP: 3220)",?35,$J($P(TOTAL,"^",3),10,2)
 W !?5,"MARSHALL : (APP: 0869)",?35,$J($P(TOTAL,"^",4),10,2)
 W !?5,"COURTCOST: (APP: 0869)",?35,$J($P(TOTAL,"^",5),10,2)
 W !?35,"----------"
 W !?35,$J($P(TOTAL,"^",2)+$P(TOTAL,"^",3)+$P(TOTAL,"^",4)+$P(TOTAL,"^",5),10,2)
 I $G(^TMP($J,"RCTOT","SUSPENSE")) W !!?5,"Total Appropriation: 3875",?35,$J(^TMP($J,"RCTOT","SUSPENSE"),10,2)
 ;
 S TOTLAMT=0 F PIECE=1:1:5 S TOTLAMT=TOTLAMT+$P(TOTAL,"^",PIECE)
 I $G(^TMP($J,"RCTOT","EDILBOX")) S TOTLAMT=TOTLAMT+^TMP($J,"RCTOT","EDILBOX")
 W !!,"TOTALS: "
 W !?5,"TOT AMT POSTED FOR DEPOSIT: ",?35,$J(+TOTLAMT,10,2)
 I SCREEN D PAUSE G:$G(RCSTFLAG) Q
 N Q,W,T,NS
 S W=""
 S PCT=0 F  S PCT=$O(^TMP($J,"RCDET",PCT)) Q:'PCT  D  G:$G(RCSTFLAG) Q
 . S Q=$P($G(^TMP($J,"RCDET",PCT)),U),T=$P($G(^(PCT)),U,2),NS=$P($G(^(PCT)),U,3)
 . I Q="<NP>" D  Q
 .. I W'="" W @W S W="" D:SCREEN PAUSE Q:$G(RCSTFLAG)
 .. S RECEIPT=$P(T,"@"),FMSDOCNO=$P(T,"@",2),RECEIPDA=$P(T,"@",3)
 .. D H,H1(0)
 . I $E(Q)="!" W:W'="" @W S W=""
 . S W=W_$S(W="":"",1:",")_Q_$S(Q'="":",",1:"")_""""_T_""""
 . I 'NS,$Y>(IOSL-6) D:SCREEN PAUSE I '$G(RCSTFLAG) D H,H1(1)
 I W'="" W @W S W=""
 I SCREEN W !,"Press RETURN to continue: " R X:DTIME
 ;
Q D ^%ZISC
 K ^TMP($J,"RCFMSCR"),^TMP($J,"RCDPR215"),^TMP($J,"RCTOT"),^TMP($J,"RCFMSCR_SUM"),^TMP($J,"RCDET")
 Q
 ;
 ;
SUSP(RECEIPDA,RCTYPE,TOTAL,PCT) ;  unapplied amts for suspense
 ; RCTYPE = see explanation at DQ above
 ; Returns PCT,TOTAL if passed by reference
 ;
 N DA,AMOUNT,UNAPPLY,COUNT,PRINTOTL,COMMENTS
 K ^TMP($J,"RCDPR215")
 S DA=0 F  S DA=$O(^RCY(344,RECEIPDA,1,DA)) Q:'DA  D
 .   S AMOUNT=$P($G(^RCY(344,RECEIPDA,1,DA,0)),"^",4) I 'AMOUNT Q
 .   S UNAPPLY=$P($G(^RCY(344,RECEIPDA,1,DA,2)),"^",5) I UNAPPLY="" Q
 .   ;  if amount has not been processed, show it in suspense
 .   I '$P(^RCY(344,RECEIPDA,1,DA,0),"^",5) S ^TMP($J,"RCDPR215",DA)=UNAPPLY_"^"_AMOUNT_"^"_$P($G(^RCY(344,RECEIPDA,1,DA,1)),"^",2)
 ;
 I $O(^TMP($J,"RCDPR215",0)) D
 .   D SET("!!?5","Appropriation: 3875",.PCT)
 .   I RCTYPE="D" D SET("!","",.PCT)
 .   ;
 .   S COUNT=0,PRINTOTL=0
 .   S DA=0 F  S DA=$O(^TMP($J,"RCDPR215",DA)) Q:'DA!($G(RCSTFLAG))  D
 .   .   ;
 .   .   S UNAPPLY=$P(^TMP($J,"RCDPR215",DA),"^"),AMOUNT=$P(^(DA),"^",2),COMMENTS=$P(^(DA),"^",3)
 .   .   S PRINTOTL=PRINTOTL+AMOUNT
 .   .   S $P(TOTAL,"^")=$P(TOTAL,"^")+AMOUNT
 .   .   ;  no detail if accrued report
 .   .   I RCTYPE="A" Q
 .   .   ;
 .   .   S COUNT=COUNT+1
 .   .   D SET("!?5",COUNT_")",.PCT),SET("?10",UNAPPLY,.PCT),SET("?30",$J(AMOUNT,10,2),.PCT),SET("?45","COMMENTS: "_$E(COMMENTS,1,25),.PCT)
 .   .   I $TR($E(COMMENTS,26,80)," ")'="" D SET("!?25",$E(COMMENTS,26,80),.PCT)
 .   ;
 .   S $P(^TMP($J,"RCTOT","TOTAL"),U)=($P($G(^TMP($J,"RCTOT","TOTAL")),U)+PRINTOTL)
 .   I RCTYPE="D" D SET("!?30","----------",.PCT),SET("!?5","TOTAL for 3875",.PCT)
 .   D SET("?30",$J(PRINTOTL,10,2),.PCT)
 .   S ^TMP($J,"RCTOT","SUSPENSE")=$G(^TMP($J,"RCTOT","SUSPENSE"))+PRINTOTL
 Q
 ;
 ;
GETTYPE() ;  ask type of report to print
 N DIR,X,Y
 S DIR(0)="S^A:ACCRUED;D:DETAILED",DIR("A")="ACCRUED OR DETAILED REPORT",DIR("B")="ACCRUED",DIR("?")="A DETAILED Report will list out accrued bills separately"
 S DIR("?",1)="An ACCRUED Report will list just the accrued total under each appropriation"
 D ^DIR
 I Y'="A",Y'="D" Q ""
 Q Y
 ;
 ;
H ;  Deposit hdr
 N Z
 S PAGE=PAGE+1 I PAGE'=1!(SCREEN) W @IOF
 W $C(13),"Page ",PAGE,?(80-$L(NOW)),NOW
 W !,$E($TR(RCYLINE,"-","*"),1,26)," 215 DEPOSIT SUMMARY REPORT ",$E($TR(RCYLINE,"-","*"),1,26)
 W !!,"DEPOSIT #: ",DEPOSIT
 W !,RCYLINE
 Q
 ;
H1(CONT) ; Receipt Hdr
 ; CONT = 1 if continuation from previous page
 ;
 N Z
 W !!,"RECEIPT #: "_RECEIPT_$S($G(CONT):" (continued)",1:"")
 I FMSDOCNO'="" W ?51,"FMS Document #: ",FMSDOCNO
 S Z="",$P(Z,"-",$L(RECEIPT)+1)=""
 W !,?11,Z
 S Z=""
 I $P($G(^RCY(344,RECEIPDA,0)),U,18) S Z=$E(" REFERENCE ERA #: "_$P($G(^RCY(344.4,+$P($G(^RCY(344,RECEIPDA,0)),U,18),0)),U)_" ("_$P($G(^RCY(344.4,+$P($G(^RCY(344,RECEIPDA,0)),U,18),0)),U,2)_")"_$J("",51),1,51)
 I Z'="" W !,Z
 W !
 Q
 ;
 ;
PAUSE ;
 D PAUSE^RCDPR215
 Q
 ;
SET(CTRL,TXT,PCT,NOSP) ; Sets print array for detail
 ;PCT = count of lines
 ;CTRL = Control characters
 ;TXT = text to print
 ;NOSP = 1 if line should always print with the previous line
 S PCT=PCT+1,^TMP($J,"RCDET",PCT)=CTRL_U_TXT_U_+$G(NOSP)
 Q
 ;
