RCTOPU ;WASH IRMFO@ALTOONA,PA/TJK-TOP TRANSMISSION ;2/22/00  12:39 PM
V ;;4.5;Accounts Receivable;**141**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified
 ;
REPORT ;print top report
 N DIC,DIS,L,BY,FR,TO,FLDS,PG,PRINTOT,DIOEND
 W !!,"TOP REFERRAL REPORT",!!
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Include Debtors At TOP With '0' Balance"
 S DIR("?")="Answering Yes will include those debtors referred whose current TOP balance is '0'."
 D ^DIR Q:(Y="")!(Y="^")
 S L=0,(FR,TO)="",DIC=340,BY=.01,FLDS="[RCTOP REPORT]",PRINTOT=0
 S DIS(0)="I $P($G(^RCD(340,D0,6)),U)"
 S:'Y DIS(0)=DIS(0)_",$P(^(4),U,3)"
 S DIOEND="D PRNTOT^RCTOPU"
PRINT D EN1^DIP
REPORTQ Q
 ;
PRNTOT ;place total amount on report
 N DASH
 S DASH="",$P(DASH,"-",81)=""
 W !!,DASH
 W !,?6,"TOTAL AMOUNT CURRENTLY REFERRED:",?50,"$"_$J(PRINTOT,15,2)
 I $E(IOST,1,2)="C-" R !!,"END OF REPORT...PRESS RETURN TO CONTINUE",X:DTIME W @IOF
PRNTOTQ Q
 ;
BILLREP ;prints individual bills and amounts that make up a TOP account
 N DIC,DEBTOR,ZTSAVE,ZTDESC,ZTRTN
 S DIC=340,DIC(0)="AEQM",DIC("S")="I $D(^RCD(340,""TOP"",+Y))" D ^DIC
 Q:Y<1  S DEBTOR=+Y
 S %ZIS="AEQ" D ^%ZIS G:POP BILLREPQ
 I $D(IO("Q")) D  G BILLREPQ
    .S ZTSAVE("DEBTOR")=""
    .S ZTRTN="BILLREPP^RCTOPU",ZTDESC="TOP BILL REPORT"
    .D ^%ZTLOAD,^%ZISC
    .Q
 ;
BILLREPP      ;Call to build array of bills referred
 U IO
 N BILL,B14,B7,D4,FND,BAMT,TAMT,DIRUT,TNM,TID,TDT,DASH,CSTAT
 S DASH="",$P(DASH,"-",81)="",D4=$G(^RCD(340,DEBTOR,4))
 S TID=$S($P(D4,U,4)'="":$P(D4,U,4),1:$P(D4,U,1))
 S TNM=$S($P(D4,U,5)'="":$P(D4,U,5),1:$P(D4,U,2))
 S Y=$P(^RCD(340,DEBTOR,6),U,1) X ^DD("DD") S TDT=Y
 S TAMT=$P(D4,U,3) D BILLREPH
 S (FND,BILL)=0 F  S BILL=$O(^PRCA(430,"C",DEBTOR,BILL)) Q:('BILL)!($D(DIRUT))  D
    .Q:'+$G(^PRCA(430,BILL,14))
    .S FND=1 W !,$P(^PRCA(430,BILL,0),U) S CSTAT=$P(^(0),U,8),B7=$G(^(7))
    .W ?14,$P(^PRCA(430.3,CSTAT,0),U,2)
    .S BAMT=0 F I=1:1:5 S BAMT=BAMT+$P(B7,U,I)
    .W ?20,$J(BAMT,10,2)
    .F I=1:1:5 W $J($P(B7,U,I),10,2)
    .;check for end of page here, if necessary form feed and print header
    .I $Y+3>IOSL D
        ..I $E(IOST,1,2)="C-" S DIR(0)="E" K DIRUT D ^DIR Q:$D(DIRUT)
        ..D BILLREPH
    .Q
 I $E(IOST,1,2)="C-" R !!,"END OF REPORT...PRESS RETURN TO CONTINUE",X:DTIME W @IOF
 D ^%ZISC
BILLREPQ Q
 ;
BILLREPH ;header for TOP bill report
 W @IOF
 W !,"DEBTOR: "_TNM
 W !,"TIN: "_TID,"  REFERRED TO TOP: "_TDT_" CURRENT TOP AMT: "_$J(TAMT,13,2)
 W !,DASH
 W !!,"BILL NO.",?14,"STAT",?27,"AMT",?36,"PRIN",?47,"INT",?55,"ADMIN",?65,"COURT",?72,"MARSHALL"
 W !,"---- ---",?14,"----",?27,"---",?36,"----",?47,"---",?55,"-----",?65,"-----",?72,"--------"
 Q
 ;
STOP ;Stop TOP Referral on a Debtor
 N DIC,DIE,DA,DIR,Y,DEBTOR,REASON,COMMENT,EFFDT
 S DIC=340,DIC(0)="AEQM" D ^DIC Q:Y<0
 S DEBTOR=+Y
 I $P($G(^RCD(340,DEBTOR,6)),U,2) G DELSTOP
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Are You Sure You Want To Stop TOP Referral For This Debtor" D ^DIR
 I 'Y W !,*7,"No Action Taken" Q
 ;
REASON ;ask referral reason
 K DIR S DIR(0)="340,6.04" D ^DIR
 Q:(Y="")!(Y=U)
 S REASON=Y I REASON="O" D  Q:COMMENT=U  G REASON:COMMENT=""
    .S COMMENT="",DIR(0)="340,6.05" D ^DIR S COMMENT=Y
    .I COMMENT="" W !,"A Reason Of Other requires a comment to be entered"
    .Q
 I REASON'="0",$P($G(^RCD(340,DEBTOR,6)),U,5)'="" S $P(^(6),U,5)=""
 ;
 I (REASON="N")!(REASON="R") D  G STOPFILE
    .S $P(^RCD(340,DEBTOR,6),U)=""
    .K ^RCD(340,"TOP",DEBTOR)
    .S (EFFDT,REASON,COMMENT)=""
    .Q
 ;
 ;ask effective date (for 'waiver','banruptcy','other')
 ;
 S DIR(0)="340,6.03",DIR("A")="Enter Effective Date" D ^DIR S EFFDT=Y
 ;
STOPFILE ;set stop referral data in file 340
 S $P(^RCD(340,DEBTOR,6),U,2,5)="1^"_EFFDT_U_REASON_U_$G(COMMENT)
 ;
 W !,"Stop TOP Referral Complete"
 G STOPQ
 ;
DELSTOP ;Allows TOP Referral to be re-instituted for debtor
 W !!,*7,"Referral to TOP has already been stopped for this debtor"
 S DIR(0)="Y",DIR("A")="Do You Wish To Re-Institute TOP Referral for this Debtor",DIR("B")="NO" D ^DIR G EDSTOP:'Y
 ;
 ;reset file to allow top referral to be re-started
 F I=2:1:5 S $P(^RCD(340,DEBTOR,6),U,I)=""
 W !!,"Debtor Is Now Eligible To Be Referred To TOP" G STOPQ
 ;
EDSTOP S DIR(0)="Y",DIR("A")="Do You Wish To Edit The Stop Referral Data For This Debtor",DIR("B")="NO" D ^DIR G REASON:Y
STOPQ Q
 ;
REVERSE ;Refund Reversal
 N DEBTOR,DIC,DIE,DR,BILL,TRACE,REFYR
 W !!,"Refund Reversal Of TOP Refund"
 S DIC=430,DIC(0)="AEQLMZ",DIC("S")="I $D(^PRCA(430,""TREF"",2,+Y))"
 S DIC("A")="Enter Refund Bill To Be Reversed:" D ^DIC Q:Y<0
 S DEBTOR=$P(Y(0),U,9),BILL=+Y
 I 'DEBTOR W !!,*7,"No Debtor Attached To This Bill." Q
 S TRACE=$P($G(^RCD(340,DEBTOR,6)),U,7),REFYR=$P($G(^PRCA(430,BILL,14)),U,4)
 I 'TRACE W !!,*7,"There is no current TOP Trace Number for this debtor",!,"This should have been entered with the most recent TOP payment" Q
 I 'REFYR W !!,*7,"There is no TOP Refund Year Entered for this bill",!,"This should have been entered when the refund was approved." Q
 S DIR(0)="Y",DIR("A")="Are You Sure You Wish To Reverse This Refund"
 S DIR("B")="NO" D ^DIR I 'Y W !!,"No Action Taken" Q
 S DIE="^PRCA(430,",DA=BILL,DR="142///3;143///^S X=TRACE" D ^DIE
 W !,"Reversal Will Be Transmitted With Next TOP Transmission"
REVERSEQ Q
 ;
UPDCODE ;Update Refund/Reversal Codes in File 348.2
 W !,"TOP Refund/Refund Reversal Code Entry"
 S DIC=348.2,DIC(0)="AEQML" D ^DIC
UPDCODEQ Q
