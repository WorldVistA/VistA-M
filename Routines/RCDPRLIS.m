RCDPRLIS ;WISC/RFJ-list of receipts report ;1 Jun 99
 ;;4.5;Accounts Receivable;**114**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 N DATEEND,DATESTRT
 W !
 D DATESEL^RCRJRTRA("RECEIPT Opened")
 I '$G(DATESTRT)!('$G(DATEEND)) Q
 ;
 ;  select device
 W ! S %ZIS="Q" D ^%ZIS I POP Q
 I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="List of Receipts",ZTRTN="DQ^RCDPRLIS"
 .   S ZTSAVE("DATE*")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
 ;
DQ ;  queued report starts here
 N %I,DATA,DATE,DATEDIS1,DATEDIS2,FMSDOCNO,NOW,PAGE,RCDPDATA,RCDPFPRE,RCRECTDA,RCRJFLAG,RCRJLINE,SCREEN,TOTALS,TYPE,X,Y
 K ^TMP("RCDPRLIS",$J)
 S RCRECTDA=0 F  S RCRECTDA=$O(^RCY(344,RCRECTDA)) Q:'RCRECTDA  D
 .   K RCDPDATA
 .   D DIQ344^RCDPRPLM(RCRECTDA,".01:200")
 .   S RCDPDATA(344,RCRECTDA,.03,"I")=$P(RCDPDATA(344,RCRECTDA,.03,"I"),".")
 .   I RCDPDATA(344,RCRECTDA,.03,"I")<DATESTRT Q
 .   I $P(RCDPDATA(344,RCRECTDA,.03,"I"),".")>DATEEND Q
 .   ;  get fms document ^ status ^ pre lockbox patch
 .   S FMSDOCNO=$$FMSSTAT^RCDPUREC(RCRECTDA)
 .   ;  compute totals by type
 .   I RCDPDATA(344,RCRECTDA,.04,"E")="" S RCDPDATA(344,RCRECTDA,.04,"E")="UNKNOWN"
 .   S $P(TOTALS(RCDPDATA(344,RCRECTDA,.04,"E")),"^",1)=$P($G(TOTALS(RCDPDATA(344,RCRECTDA,.04,"E"))),"^",1)+RCDPDATA(344,RCRECTDA,101,"E")
 .   S $P(TOTALS(RCDPDATA(344,RCRECTDA,.04,"E")),"^",2)=$P($G(TOTALS(RCDPDATA(344,RCRECTDA,.04,"E"))),"^",2)+RCDPDATA(344,RCRECTDA,.15,"E")
 .   S $P(TOTALS,"^",1)=$P($G(TOTALS),"^",1)+RCDPDATA(344,RCRECTDA,101,"E")
 .   S $P(TOTALS,"^",2)=$P($G(TOTALS),"^",2)+RCDPDATA(344,RCRECTDA,.15,"E")
 .   ;  opened by
 .   I RCDPDATA(344,RCRECTDA,.02,"E")'="" D
 .   .   S RCDPDATA(344,RCRECTDA,.02,"E")=$E($P(RCDPDATA(344,RCRECTDA,.02,"E"),",",2))_$E(RCDPDATA(344,RCRECTDA,.02,"E"))
 .   .   I RCDPDATA(344,RCRECTDA,.02,"I")=.5 S RCDPDATA(344,RCRECTDA,.02,"E")="ar"
 .   ;
 .   S DATA=RCDPDATA(344,RCRECTDA,.01,"E")
 .   S DATA=DATA_"^"_RCDPDATA(344,RCRECTDA,.04,"E")   ;payment type
 .   S DATA=DATA_"^"_RCDPDATA(344,RCRECTDA,.02,"E")   ;user initials
 .   S DATA=DATA_"^"_RCDPDATA(344,RCRECTDA,101,"E")   ;payment count
 .   S DATA=DATA_"^"_RCDPDATA(344,RCRECTDA,.15,"E")   ;payment amount
 .   S DATA=DATA_"^"_$S($P(FMSDOCNO,"^",3):"*",1:" ") ;pre lockbox
 .   S DATA=DATA_"^"_$P(FMSDOCNO,"^")                 ;fms cr document
 .   S DATA=DATA_"^"_$P(FMSDOCNO,"^",2)               ;fms cr doc status
 .   S ^TMP("RCDPRLIS",$J,RCDPDATA(344,RCRECTDA,.03,"I"),RCRECTDA)=DATA
 ;
 S Y=$P(DATESTRT,".") D DD^%DT S DATEDIS1=Y
 S Y=$P(DATEEND,".") D DD^%DT S DATEDIS2=Y
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y
 S PAGE=1,RCRJLINE="",$P(RCRJLINE,"-",81)=""
 S SCREEN=0 I '$D(ZTQUEUED),IO=IO(0),$E(IOST)="C" S SCREEN=1
 U IO D H
 S DATE=0 F  S DATE=$O(^TMP("RCDPRLIS",$J,DATE)) Q:'DATE!($G(RCRJFLAG))  D
 .   S RCRECTDA=0 F  S RCRECTDA=$O(^TMP("RCDPRLIS",$J,DATE,RCRECTDA)) Q:'RCRECTDA!($G(RCRJFLAG))  D
 .   .   S DATA=^TMP("RCDPRLIS",$J,DATE,RCRECTDA)
 .   .   W !,$E(DATE,4,5),"/",$E(DATE,6,7),"/",$E(DATE,2,3)
 .   .   W ?10,$P(DATA,"^")
 .   .   W ?21,$E($P($P(DATA,"^",2)," "),1,8)        ;payment type
 .   .   W ?31,$E($P(DATA,"^",3),1,2)                ;user initials
 .   .   W ?33,$J($P(DATA,"^",4),6)                  ;payment count
 .   .   W $J($P(DATA,"^",5),13,2)                   ;payment amount
 .   .   W ?54,$P(DATA,"^",6)                        ;pre lockbox
 .   .   W ?55,$P(DATA,"^",7)                        ;fms cr document
 .   .   W ?71,$E($P(DATA,"^",8),1,9)                ;fms cr doc status
 .   .   ;
 .   .   ;  set pre lockbox flag to 1 to show note at end of report
 .   .   I $P(DATA,"^",6)="*" S RCDPFPRE=1
 .   .   ;
 .   .   I $Y>(IOSL-6) D:SCREEN PAUSE^RCRJRTR1 Q:$G(RCRJFLAG)  D H
 ;
 I $G(RCRJFLAG) D Q Q
 I $G(RCDPFPRE) W !?54,"*CR tied to deposit"
 W !?33,"------  -----------"
 W !?33,$J($P($G(TOTALS),"^"),6),$J($P($G(TOTALS),"^",2),13,2)
 ;
 ;  show totals by type of payment
 W !!,"TOTALS BY TYPE OF PAYMENT"
 W !,"-------------------------"
 S TYPE="" F  S TYPE=$O(TOTALS(TYPE)) Q:TYPE=""!($G(RCRJFLAG))  D
 .   W !,TYPE,?33,$J($P(TOTALS(TYPE),"^"),6),$J($P(TOTALS(TYPE),"^",2),13,2)
 .   I $Y>(IOSL-6) D:SCREEN PAUSE^RCRJRTR1 Q:$G(RCRJFLAG)  D H
 ;
 I $G(RCRJFLAG) D Q Q
 I SCREEN U IO(0) R !,"Press RETURN to continue:",%:DTIME
 ;
Q D ^%ZISC
 K ^TMP("RCDPRLIS",$J)
 Q
 ;
 ;
H ;  header
 S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"LIST OF RECEIPTS REPORT",?(80-$L(%)),%
 W !,"  FOR THE DATE RANGE: ",DATEDIS1,"  TO  ",DATEDIS2
 W !,"DATE",?10,"RECEIPT",?21,"TYPE",?31,"US",?33,$J("COUNT",6),$J("AMOUNT",13),?55,"FMS CR DOC",?71,"STATUS"
 W !,RCRJLINE
 Q
