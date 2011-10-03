RCRJRDEP ;WISC/RFJ-Deposit Reconciliation Report ; 9/7/10 8:19am
 ;;4.5;Accounts Receivable;**101,114,203,220,273**;Mar 20, 1995;Build 3
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 W !!,"This option will print the Deposit Reconciliation Report.  The report will"
 W !,"display the data on the code sheets sent to FMS on the CR document.  Only"
 W !,"deposits processed after patch PRCA*4.5*90 was installed can be displayed."
 W !,"Select the starting and ending FMS Document Number without the station"
 W !,"number, example: K8A0346."
 ;
 N DEFAULT,RCRJEND,RCRJFXIT,RCRJSTRT,RCRJSUMM,X
 ;
 F  D  Q:$G(RCRJFXIT)
 . R !!,"START WITH CR DOCUMENT: FIRST// ",X:DTIME
 . I X["^" S RCRJFXIT=2 Q
 . I $L(X),$L(X)'=7 W !?5,"The CR DOCUMENT should be 7 characters in length (example: K8A0804)." Q
 . S RCRJSTRT=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 . ;
 . S DEFAULT=$S(RCRJSTRT="":" LAST",1:RCRJSTRT)
 . W !,"  END WITH CR DOCUMENT: ",DEFAULT,"// " R X:DTIME
 . I X["^" S RCRJFXIT=2 Q
 . S RCRJEND=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 . I X="LAST" S (RCRJEND,X)="zzzzzzz"
 . I $L(X),$L(X)'=7 W !?5,"The CR DOCUMENT should be 7 characters in length (example: K8A0804)." Q
 . I X="" S RCRJEND=$S(DEFAULT=" LAST":"zzzzzzz",1:DEFAULT)
 . I RCRJEND'=RCRJSTRT,RCRJEND']RCRJSTRT W !?5,"The END CR DOCUMENT should be after (in sequence) the start document." Q
 . S RCRJFXIT=1
 I RCRJFXIT=2 Q
 ;
 S RCRJSUMM=$$SUMMARY^RCRJRTRA I 'RCRJSUMM Q
 ;
 ;  select device
 W ! S %ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 . S ZTDESC="Deposit Reconciliation Report",ZTRTN="DQ^RCRJRDEP"
 . S ZTSAVE("RCRJ*")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
 ;
DQ ;  report (queue) starts here
 N %,%H,%I,CHAMPVA,DA,DEPOSDA,DIQ2,DOCTOTAL,FMSDOCID,FUND,FUNDTOTL,GECSDATA,LINEDA,LINEDATA,NOW,PAGE,RCDATA,RCRJLAST,RCRJLINE,RCRJFLAG,RECEIPDA,RSC,RSCTOTL,SCREEN,SITE,TOTAL,X,Y
 K ^TMP($J,"RCRJRDEP")
 ;
 ;  build list of fms documents
 S SITE=$$SITE^RCMSITE
 S RCRJLAST="CR-"_SITE_RCRJEND_" "
 ;
 ;  the fms document was previously stored in the deposit file 344.1
 ;  this code can be removed later on
 ;  this is the starting document, use 31 to start with select doc first
 S FMSDOCID="CR-"_SITE_RCRJSTRT_$C(31)
 F  S FMSDOCID=$O(^RCY(344.1,"ADOC",FMSDOCID)) Q:FMSDOCID=""!(FMSDOCID]RCRJLAST)  D
 . S DEPOSDA=+$O(^RCY(344.1,"ADOC",FMSDOCID,0))
 . ;  compute deposit (all receipts) total for comparison
 . S TOTAL=0,CHAMPVA=0
 . S RECEIPDA=0 F  S RECEIPDA=$O(^RCY(344,"AD",DEPOSDA,RECEIPDA)) Q:'RECEIPDA  D
 . . S DA=0 F  S DA=$O(^RCY(344,RECEIPDA,1,DA)) Q:'DA  S TOTAL=TOTAL+$P(^(DA,0),"^",5)
 . . S CHAMPVA=CHAMPVA+$$CHAMPVA(RECEIPDA)
 . ;  tmp=deposit ^ depositda ^ depositdate ^ ^ ^ ^ deposittotal ^ champvatotal
 . S ^TMP($J,"RCRJRDEP",FMSDOCID)=$P($G(^RCY(344.1,DEPOSDA,0)),"^")_"^"_DEPOSDA_"^"_$P($G(^RCY(344.1,DEPOSDA,0)),"^",9)_"^^^^"_TOTAL_"^"_CHAMPVA
 ;
 ;  the fms document is now stored in the receipt file 344
 S FMSDOCID="CR-"_SITE_RCRJSTRT_$C(31)
 F  S FMSDOCID=$O(^RCY(344,"ADOC",FMSDOCID)) Q:FMSDOCID=""!(FMSDOCID]RCRJLAST)  D
 . S RECEIPDA=+$O(^RCY(344,"ADOC",FMSDOCID,0))
 . ;  compute deposit (all receipts) total for comparison
 . S TOTAL=0
 . ;  use the payment amount to pick up suspense deposits
 . S DA=0 F  S DA=$O(^RCY(344,RECEIPDA,1,DA)) Q:'DA  S TOTAL=TOTAL+$P(^(DA,0),"^",4)
 . S CHAMPVA=$$CHAMPVA(RECEIPDA)
 . S DEPOSDA=+$P($G(^RCY(344,RECEIPDA,0)),"^",6)
 . ;  tmp=deposit ^ depositda ^ depositdate ^ receipt ^receiptda ^ receipt date ^ receipttotal ^ champvatotal
 . S ^TMP($J,"RCRJRDEP",FMSDOCID)=$P($G(^RCY(344.1,DEPOSDA,0)),"^")_"^"_DEPOSDA_"^"_$P($G(^RCY(344.1,DEPOSDA,0)),"^",11)_"^"_$P($G(^RCY(344,RECEIPDA,0)),"^")_"^"_RECEIPDA_"^"_$P($G(^RCY(344,RECEIPDA,0)),"^",8)_"^"_TOTAL_"^"_CHAMPVA
 ;
 ;  print report
 S SCREEN=0 I '$D(ZTQUEUED),IO=IO(0),$E(IOST)="C" S SCREEN=1
 S RCRJLINE="",$P(RCRJLINE,"-",81)=""
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y,PAGE=1
 U IO I $G(RCRJSUMM)'=1 D H
 ;
 S FMSDOCID="" F  S FMSDOCID=$O(^TMP($J,"RCRJRDEP",FMSDOCID)) Q:FMSDOCID=""!($G(RCRJFLAG))  D
 . S RCDATA=^TMP($J,"RCRJRDEP",FMSDOCID)
 . K GECSDATA
 . D DATA^GECSSGET(FMSDOCID,1)
 . I $G(RCRJSUMM)'=1 D  Q:$G(RCRJFLAG)
 . . I $Y>(IOSL-7) D:SCREEN PAUSE^RCRJRTR1 Q:$G(RCRJFLAG)  D H
 . . S Y=$P($P(RCDATA,"^",3),".") I Y D DD^%DT
 . . W !,"FMS DOCUMENT: ",FMSDOCID,?34,"DEPOSIT TICKET: ",$P(RCDATA,"^"),?62,"DATE: ",Y
 . . I $P(RCDATA,"^",4)'="" W !?41,"RECEIPT: ",$P(RCDATA,"^",4) S Y=$P($P(RCDATA,"^",6),".") I Y D DD^%DT W ?62,"DATE: ",Y
 . . D H1
 . S DOCTOTAL=0
 . I $D(GECSDATA) S LINEDA=0 F  S LINEDA=$O(GECSDATA(2100.1,GECSDATA,10,LINEDA)) Q:'LINEDA!($G(RCRJFLAG))  D
 . . S LINEDATA=GECSDATA(2100.1,GECSDATA,10,LINEDA)
 . . I $E(LINEDATA,1,4)="CR2^" S DOCTOTAL=$P(LINEDATA,"^",15)
 . . I $E(LINEDATA,1,9)'="LIN^~CRA^" Q
 . . I $G(RCRJSUMM)'=1 D
 . . . I $Y>(IOSL-4) D:SCREEN PAUSE^RCRJRTR1 Q:$G(RCRJFLAG)  D H,H1
 . . . W !?1,$P(LINEDATA,"^",3),?6,$P(LINEDATA,"^",4),?11,$P(LINEDATA,"^",6),?19,$P(LINEDATA,"^",10)
 . . . W ?30,$J($P(LINEDATA,"^",18),8),?40,$E($P(LINEDATA,"^",25),4,10),?50,$J($P(LINEDATA,"^",20),10,2),?64,$J($P(LINEDATA,"^",23),9)
 . . ;  totals by fund
 . . S FUND=$P(LINEDATA,"^",6)
 . . I FUND="" S FUND="0160"
 . . S FUNDTOTL(FUND)=$G(FUNDTOTL(FUND))+$P(LINEDATA,"^",20)
 . . ;  totals by rsc for the accrued 5287 funds (01,03,04,09,11)
 . . S RSC=$P(LINEDATA,"^",10)
 . . I RSC'="",($$PTACCT^PRCAACC(FUND)!(FUND=4032)) S RSCTOTL(RSC)=$G(RSCTOTL(RSC))+$P(LINEDATA,"^",20)
 . I $G(RCRJSUMM)=1 Q
 . I $G(RCRJFLAG) Q
 . I $Y>(IOSL-6) D:SCREEN PAUSE^RCRJRTR1 Q:$G(RCRJFLAG)  D H
 . W !?23,"LINE TOTAL/DOCUMENT TOTAL: ",$J(DOCTOTAL,10,2)
 . ;  compute receipt total for comparison
 . S TOTAL=$P(RCDATA,"^",7)
 . S CHAMPVA=$P(RCDATA,"^",8)
 . I CHAMPVA W !?35,"CHAMPVA TOTAL: ",$J(CHAMPVA,10,2)
 . W !?35,"DEPOSIT TOTAL: ",$J(TOTAL,10,2)
 . I (DOCTOTAL+CHAMPVA)'=TOTAL W !," WARNING: TOTALS DO NOT MATCH, CHECK THE DEPOSIT: **********"
 . W !
 ;
 I $G(RCRJFLAG) D Q Q
 I $G(RCRJSUMM)'=1 D:SCREEN PAUSE^RCRJRTR1 I $G(RCRJFLAG) D Q Q
 D H
 ;  print totals by fund/rsc
 W !!,"TOTAL DEPOSITS BY FUND:"
 S FUND="" F  S FUND=$O(FUNDTOTL(FUND)) Q:FUND=""!($G(RCRJFLAG))  D
 .  I $Y>(IOSL-4) D:SCREEN PAUSE^RCRJRTR1 Q:$G(RCRJFLAG)  D H W !!,"TOTAL DEPOSITS BY FUND:"
 .  W !?5,"FUND: ",FUND,?20,$J(FUNDTOTL(FUND),10,2)
 I $G(RCRJFLAG) D Q Q
 I DT<$$ADDPTEDT^PRCAACC() W !!,"TOTAL DEPOSITS BY REVENUE SOURCE CODE FOR THE SERIES OF FUNDS 5287.1,5287.3,5287.4:"
 I DT'<$$ADDPTEDT^PRCAACC() W !!,"TOTAL DEPOSITS BY REVENUE SOURCE CODE FOR THE SERIES OF FUNDS 528701,528703,528704,528711:"
 S RSC="" F  S RSC=$O(RSCTOTL(RSC)) Q:RSC=""  D  Q:$G(RCRJFLAG)
 . I $Y>(IOSL-4) D:SCREEN PAUSE^RCRJRTR1 Q:$G(RCRJFLAG)  D H W !!,"TOTAL DEPOSITS BY REVENUE SOURCE CODE FOR THE SERIES OF ACCRUED 5287 FUNDS "_$S(DT<$$ADDPTEDT^PRCAACC():"(.1,.3,.4,.9):",1:"(01,03,04,09,11):")
 . W !?5,"RSC: ",RSC,?17,$$GETDESC^RCXFMSPR(RSC),?70,$J(RSCTOTL(RSC),10,2)
 I $G(RCRJFLAG) D Q Q
 I SCREEN R !,"Press RETURN to continue:",X:DTIME
 ;
Q D ^%ZISC
 K ^TMP($J,"RCRJRDEP")
 Q
 ;
 ;
H ;  report heading
 I PAGE'=1!(SCREEN) W @IOF
 S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1
 W $C(13),"DEPOSIT RECONCILIATION REPORT",?(80-$L(%)),%
 W !,"  START WITH DEPOSIT: ",$S(RCRJSTRT="":"**FIRST**",1:RCRJSTRT),"  END WITH DEPOSIT: ",$S(RCRJEND="zzzzzzz":"**LAST**",1:RCRJEND),?65,$J("TYPE: "_$S(RCRJSUMM=1:"SUMMARY",1:"DETAILED"),15)
 W !,RCRJLINE
 Q
 ;
 ;
H1 ;  print line heading
 W !,"LINE",?5,"BFY",?11,"FUND",?20,"RSC",?30,"PROVIDER",?43,"BILL",?54,"AMOUNT",?64,"TRAN TYPE"
 Q
 ;
 ;
CHAMPVA(RECEIPDA) ;  return dollars for champva
 N %,CATEGORY,RECEIPT,TOTAL,TRAN3,TRANDA
 S RECEIPT=$P($G(^RCY(344,RECEIPDA,0)),"^")
 I RECEIPT="" Q 0
 ;
 S TOTAL=0
 S TRANDA=0 F  S TRANDA=$O(^PRCA(433,"AF",RECEIPT,TRANDA)) Q:'TRANDA  D
 . S CATEGORY=$P($G(^PRCA(430,+$P($G(^PRCA(433,TRANDA,0)),"^",2),0)),"^",2)
 . I CATEGORY'=29 Q
 . S TRAN3=$G(^PRCA(433,TRANDA,3))
 . F %=1:1:5 S TOTAL=TOTAL+$P(TRAN3,"^",%)
 Q TOTAL
