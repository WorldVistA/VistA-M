PRCARPS1 ;SF-ISC/YJK-REPAYMENT PAYMENT STATEMENT ;5/21/93  10:02 PM
V ;;4.5;Accounts Receivable;**190**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;PRINT THE PAYMENT STATEMENT FOR REPAYMENT PLAN,CALLED BY ^PRCARPS.
HEADER NEW ADD
 S ADD=$$DADD^RCAMADD(PRCA("DEBTOR"),1) ;confidential address if applicable
 W:$D(IOF) @IOF W !,?PRCALN(0),"STATEMENT OF ACCOUNTS RECEIVABLE",!
 I $D(DT) S Y=DT X ^DD("DD") W !!!,?PRCALN,Y
 W !!,?PRCALN,$$NAM^RCFN01(PRCA("DEBTOR")),!,?PRCALN,$P(ADD,"^"),!
 W ?PRCALN,$P(ADD,"^",4),", ",$P(ADD,"^",5),"  ",$P(ADD,"^",6),!! Q
WRST D HEADER,LINE W ?PRCALN,"|",?PRCALN(0),"DISTRIBUTION OF PAYMENT",?PRCALL(11),"|" D LINE
 W ?PRCALN,"| FILE NO./SSN",?PRCALL(1),"|",?PRCALL(2),"NAME OF PERSON ENTITLED",?PRCALN(1),"|",?PRCALN(2),"PAYMENT",?PRCALN(3),"|",?PRCALN(4),"DATE OF",?PRCALL(11),"|"
 W !,?PRCALN,"| ",PRCA("BILLN"),?PRCALL(1),"|",?PRCALN(1),"|",?PRCALN(2),"AMOUNT",?PRCALN(3),"|",?PRCALN(4),"PAYMENT",?PRCALL(11),"|"
 W !,?PRCALN,"| ",$$SSN^RCFN01(PRCA("DEBTOR")),?PRCALL(1),"|",?PRCALL(2),$$NAM^RCFN01(PRCA("DEBTOR")),?PRCALN(1),"|",?PRCALN(2),"$",$J(PRCAMT,0,2),?PRCALN(3),"|",?PRCALN(4),PRCADT,?PRCALL(11),"|" D LINE
 W ?PRCALN,"|",?PRCALL(1),"|",?PRCALL(3),"|",?PRCALL(5),"|",?PRCALL(6),"ADMIN.",?PRCALL(7),"|",?PRCALL(9),"|",?PRCALL(11),"|"
 W !,?PRCALN,"|",?PRCALL(1),"|",?PRCALL(3),"|",?PRCALL(5),"|",?PRCALL(6),"COLLECT.",?PRCALL(7),"|",?PRCALL(8),"COURT",?PRCALL(9),"|",?PRCALL(10),"MARSHAL",?PRCALL(11),"|"
 W !,?PRCALN,"|",?PRCALL(1),"|",?PRCALL(2),"PRINCIPAL",?PRCALL(3),"|",?PRCALL(4),"INTEREST",?PRCALL(5),"|",?PRCALL(6),"COSTS",?PRCALL(7),"|",?PRCALL(8),"COSTS",?PRCALL(9),"|",?PRCALL(10),"FEES",?PRCALL(11),"|" D LINE
 W ?PRCALN,"| DISTRIBUTION",?PRCALL(1),"|",?PRCALL(3),"|",?PRCALL(5),"|",?PRCALL(7),"|",?PRCALL(9),"|",?PRCALL(11),"|"
 W !,?PRCALN,"| OF PAYMENT",?PRCALL(1),"|",?PRCALL(2),"$",$J(PRCAPP(1),0,2),?PRCALL(3)
 W "|",?PRCALL(4),"$",$J(PRCAPP(2),0,2),?PRCALL(5),"|",?PRCALL(6),"$",$J(PRCAPP(3),0,2),?PRCALL(7)
 W "|",?PRCALL(8),"$",$J(PRCAPP(5),0,2),?PRCALL(9),"|",?PRCALL(10),"$",$J(PRCAPP(4),0,2),?PRCALL(11),"|" D LINE
 W ?PRCALN,"| BALANCE DUE",?PRCALL(1),"|",?PRCALL(3),"|",?PRCALL(5),"|",?PRCALL(7),"|",?PRCALL(9),"|",?PRCALL(11),"|"
 W !,?PRCALN,"| AFTER PAYMENT",?PRCALL(1),"|",?PRCALL(2),"$",$J(PRCAPB(1),0,2),?PRCALL(3),"|",?PRCALL(4),"$",$J(PRCAPB(2),0,2),?PRCALL(5),"|",?PRCALL(6),"$",$J(PRCAPB(3),0,2),?PRCALL(7),"|"
 W ?PRCALL(8),"$",$J(PRCAPB(5),0,2),?PRCALL(9),"|",?PRCALL(10),"$",$J(PRCAPB(4),0,2),?PRCALL(11),"|" D LINE
 D WORD1,WORD2,WORD3,REMIT,EXIT Q
WORD1 Q:+PRCADUE'>0  S Y=PRCADUE X ^DD("DD") S PRCADUE=Y
 W !,?PRCALN(5),"BALANCE DUE SHOULD BE PAID IN FULL BY ",PRCADUE,!,?PRCALN(5),"TO AVOID ADDITIONAL CHARGES.",!! Q
WORD2 S Z0=0
 F Z1=0:0 S Z0=$O(^RC(343,31,1,Z0)) Q:Z0=""  W !,?PRCALN,^(Z0,0)
 W ! K Z0,Z1 Q
WORD3 S PRCAGL5=$$SADD^RCFN01(1) Q:PRCAGL5=""
 W !,?PRCALN,"* Detach and return with your next payment to:",!,?PRCALN(6),"VA MEDICAL CENTER"
 W !,?PRCALN(6),"c/o Agent Cashier",!,?PRCALN(6),$P(PRCAGL5,U) W:$P(PRCAGL5,"^",2)]"" !?PRCALN(6),$P(PRCAGL5,"^",2) W:$P(PRCAGL5,"^",3)]"" !?PRCALN(6),$P(PRCAGL5,"^",3)
 W !?PRCALN(6),$P(PRCAGL5,U,4),", ",$P(PRCAGL5,U,5),"  ",$P(PRCAGL5,U,6),!
 K PRCAGL5,Z0 Q
REMIT ;
 W !," FOR PROPER CREDIT TO YOUR ACCOUNT, PLEASE DETACH AND RETURN WITH YOUR PAYMENT"
 W !," ============================================================================="
 W !," |                          PAYMENT REMITTANCE                               |"
 W !," |---------------------------------------------------------------------------|"
 W !," | *FILE NO/SSAN | NAME OF DEBTOR               | AMOUNT ENCLOSED   |TEL.NO  |"
 W !,?PRCALN," | ",PRCA("BILLN"),?17+PRCALN,"|",?48+PRCALN,"|",?68+PRCALN,"|(   )",?77+PRCALN,"|"
 W !,?PRCALN," | ",$$SSN^RCFN01(PRCA("DEBTOR")),?17+PRCALN,"|",?20+PRCALN,$$NAM^RCFN01(PRCA("DEBTOR")),?48+PRCALN,"|",?68+PRCALN,"|",?77+PRCALN,"|"
 W !," |---------------------------------------------------------------------------|"
 W !," | ENTER YOUR CURRENT ADDRESS BELOW ONLY IF THE ONE ABOVE IS INCORRECT.      |"
 W !," | PLEASE INCLUDE YOUR ZIP CODE.                                             |"
 W !," |                                                                           |"
 W !," |                                                                           |"
 W !," |                                                                           |"
 W !," |                                                                           |"
 W !," |---------------------------------------------------------------------------|"
 W !," | *PLEASE INCLUDE THIS NUMBER ON YOUR CHECK OR MONEY ORDER                  |"
 W !," |===========================================================================|"
 K % Q
LINE W !,?PRCALN,"|" F I=1:1:77 W "-"
 W "|",! K I Q
EXIT K PRCAN1,PRCA("DEBTNAM"),PRCALL,PRCALN,PRCADT,PRCADUE,PRCAMT,PRCAPP Q
