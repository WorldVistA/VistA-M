RCTRAN ;WASH-ISC@ALTOONA,PA/LDB-Transaction History Report ;1/19/95  4:33 PM
V ;;4.5;Accounts Receivable;**104,154**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 N AMT,APP,BDATE,BILL,BY,CAT,DIC,DIR,DIRUT,EDATE,FUND,LINE,LN,NODE0,NODE1,NODE2,NODE3,PG,POP,PX2,RCX,RCX1,TDAT,TYP
 N X,X1,X11,X12,X1A,X2,X3,XFND,XF1,Y,ZTDESC,ZTRTN,ZTSAVE,%ZIS
EN S X=$$DATE^RCEVUTL1("")
 Q:X<0
 S BDATE=+X,EDATE=$P(X,"^",2)
TYPE S DIC="^PRCA(430.3,",DIC(0)="QEMZ",DIC("S")="I +Y,(Y<15!(""25^29^34^35^40^41^43^45^46^47""[(""^""_+Y_""^"")))"
 S Y=0 W !,"TRANSACTION TYPE: "_$S('$O(TYP("")):"ALL// ",1:"")
 R X:DTIME I '$T!(X="^") Q
 I ((X="")!(X="ALL")),'$O(TYP("")) S (TYP,X)="ALL" G CAT
 I X="" G CAT
 I X'="ALL" D ^DIC S TYP=+Y
 I X["?" W !!,"Enter 'ALL' for all types of transactions in the AR TRANSACTION TYPE FILE",! G TYPE
 ;I $P($G(^PRCA(430.3,+Y,0)),"^",3)>100 W !!,"This is a STATUS. Enter a transaction type only.",! G TYPE
 I TYP'="ALL",(+TYP>0) S TYP(+TYP)="" G TYPE
 G:+TYP<0 TYPE
CAT K DIC S Y=0 W !,"CATEGORY OF BILL: "_$S('$O(CAT("")):"ALL// ",1:"")
 R X:DTIME I '$T!(X="^") Q
 I ((X="")!(X="ALL")),'$O(CAT("")) S (CAT,X)="ALL" G DEV
 I X="" G DEV
 I X'="ALL" S DIC="^PRCA(430.2,",DIC(0)="QEMZ" D ^DIC S CAT=+Y
 I X["?" W !!,"Enter 'ALL' for all categories of bills.",! G CAT
 I CAT'="ALL",(+CAT>0) S CAT(+CAT)="" G CAT
 G:+CAT<0 CAT
DEV W !!,"This report takes a long time to compile."
 W !,"It is recommended that it be queued to print later.",!!
 S %ZIS="AEQ" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  Q
 .S ZTSAVE("BDATE")="",ZTSAVE("EDATE")="",ZTSAVE("TYP")="",ZTSAVE("CAT")="",ZTRTN="DQ^RCTRAN",ZTDESC="Transaction History Report"
 .S:$O(TYP("")) ZTSAVE("TYP(")=""
 .S:$O(CAT("")) ZTSAVE("CAT(")=""
 .D ^%ZTLOAD,^%ZISC,EXIT K ZTSAVE,ZTRTN Q
 ;
DQ ;Call to build array of payment transactions
 ;
 U IO
 D DT^DICRW W:$E(IOST,1,2)'="P-" @IOF S PG=0,LINE="",$P(LINE,"-",79)=""
 K ^TMP($J) D TRANS^RCTRAN1
 I '$D(^TMP($J)) D HDR^RCTRAN1 W !!,"There is no activity of this type during this time period."
 I $D(^TMP($J)) D PRINT
 K ^TMP($J) D ^%ZISC
 Q
 ;
PRINT ;Print transactions of type within selected date range
 D HDR^RCTRAN1
 S (AMT("TOT"),RCX)=0
 F  S RCX1=RCX,RCX=$O(^TMP($J,RCX)) Q:$D(DIRUT)!'RCX  S X11=0 F  S X12=X11,X11=$O(^TMP($J,RCX,X11)) Q:$D(DIRUT)  Q:'X11  S XFND="" F  S XFND=$O(^TMP($J,RCX,X11,XFND)) Q:$D(DIRUT)!(XFND="")  D FCHK D
 .S AMT(X11)=0,X2=0,PX2=X2 F  S X2=$O(^TMP($J,RCX,X11,XFND,X2)) Q:$D(DIRUT)  D:'X2 SUB^RCTRAN1 Q:'X2  S X3=0 F  S AMT(X11,XFND)=0,X3=$O(^TMP($J,RCX,X11,XFND,X2,X3)) Q:'X3!$D(DIRUT)  D
 ..W:$$SLH^RCFN01(X2)'=$$SLH^RCFN01(PX2)!'LN !,$$SLH^RCFN01(X2)
 ..W:RCX'=RCX1!'LN ?12,$E($P($G(^PRCA(430.3,+RCX,0)),"^"),1,23)
 ..W ?37,$P($G(^PRCA(430.2,+X11,0)),"^",2)
 ..S BILL=$P(^TMP($J,RCX,X11,XFND,X2,X3),"^",2) W ?41,BILL
 ..W ?55,$J(X3,8)
 ..S AMT=+^TMP($J,RCX,X11,XFND,X2,X3)
 ..I ",2,8,9,10,11,14,19,47,34,35,29,"[(","_TYP_",") I AMT'<0 S AMT=-AMT
 ..I ",2,8,9,10,11,12,14,19,47,34,35,29,"'[(","_TYP_",") I AMT<0 S AMT=-AMT
 ..I +CAT=26,TYP=1 I AMT'<0 S AMT=-AMT
 ..I +CAT=26,TYP=35 I AMT'<0 S AMT=-AMT
 ..S AMT("TOT")=AMT("TOT")+AMT
 ..S AMT(X11)=AMT(X11)+AMT
 ..S AMT(X11,XFND)=AMT(X11,XFND)+AMT
 ..S:AMT<0 AMT=-AMT W ?64,$J(AMT,11,2)
 ..S BY=$P(^TMP($J,RCX,X11,XFND,X2,X3),"^",3) S:BY BY=$P($G(^VA(200,+BY,0)),"^",2)
 ..W ?76,BY
 ..I RCX=45 W !?10,$P($G(^PRCA(433,+X3,5)),"^",2),!
 ..S LN=LN+1
 ..I $O(^TMP($J,RCX))!TYP,$Y+3>IOSL D
 ...I $E(IOST,1,2)="C-" S DIR(0)="E" K DIRUT D ^DIR Q:$D(DIRUT)
 ...W @IOF D HDR^RCTRAN1
 Q:$D(DIRUT)
 I $O(^TMP($J,RCX))!TYP,($Y+10>IOSL) D
 .I $E(IOST,1,2)="C-" S DIR(0)="E" K DIRUT D ^DIR Q:$D(DIRUT)
 .W @IOF D HDR^RCTRAN1
 Q:$D(DIRUT)
 S:AMT("TOT")<0 AMT("TOT")=-AMT("TOT") W:TYP !?64,"------------",!,?57,"TOTAL:",?64,$J(AMT("TOT"),12,2)
 D KEY^RCTRAN1
 Q
 ;
FCHK ;Check fund
 W !,"FUND: ",XFND
 Q
 ;
EXIT ;Exit routine
 K ^TMP($J) D ^%ZISC Q
