PRCPRSS1 ;WOIFO/DAP-stock status report for primaries and secondaries; 10/16/06 2:17pm
V ;;5.1;IFCAP;**98**;Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ;
PRINT ;  print report
 N DAYS,MONTH,NOW,PAGE,PRCPFLAG,SCREEN,TOTCLOS,TOTISS,TOTN,TOTOPEN,TOTVAL,ITEMCTA,X,Y
 S Y=DATESTRT D DD^%DT S MONTH=Y
 S DAYS=$P("31^28^31^30^31^30^31^31^30^31^30^31","^",+$E(DATESTRT,4,5))
 I DAYS=28 S %=(17+$E(DATESTRT))_$E(DATESTRT,2,3),DAYS=$S(%#400=0:29,(%#4=0&(%#100'=0)):29,1:28)
 ;
 ;*98 Added looping logic to go through print cycle for each type of
 ;item report (Standard/ODI/All)
 ;
 N P,PRCPTP,PRCPTP2,NODE1
 S PAGE=1
 F P=1:1:3 S NODE1=P D
 . I $G(PRCPFLAG) Q
 . I P=1 S PRCPTP="STANDARD",PRCPTP2="STD"
 . I P=2 S PRCPTP="ON-DEMAND",PRCPTP2="OD"
 . I P=3 S PRCPTP="ALL",PRCPTP2=PRCPTP
 . D REP^PRCPRSS1
 . Q
 ;
 D Q^PRCPRSS1
 Q
 ;
REP ;*98 Added header to display type of reporting, moved header logic
 ;from earlier in routine to support looping structure
 ; 
 I P>1 D LC
 I $G(PRCPFLAG) Q
 S SCREEN=$$SCRPAUSE^PRCPUREP D NOW^%DTC S Y=% D DD^%DT S NOW=Y U IO I P=1 D HEAD
 ;
 W !,"INVENTORY  ("_PRCPTP_" ITEMS)"
 I $Y>(IOSL-7) D LC G:$G(PRCPFLAG) Q
 ;
 W !,"OPEN BALANCE",?14 S TOTOPEN=0 F ACCT=1,2,3,6,8 S %=$P($G(^TMP($J,NODE1,"OPEN",ACCT)),"^",2) S OPEN(ACCT)=%,TOTOPEN=TOTOPEN+% W $$SHOWVALU(%)
 W $$SHOWVALU(TOTOPEN)
 I $Y>(IOSL-7) D LC G:$G(PRCPFLAG) Q
 W !!,"RECEIPTS",?14 S TOTAL=0 F ACCT=1,2,3,6,8 S %=$G(^TMP($J,NODE1,"REC",ACCT)),TOTAL=TOTAL+%,OPEN(ACCT)=$G(OPEN(ACCT))+% W $$SHOWVALU(%)
 W $$SHOWVALU(TOTAL)
 I $Y>(IOSL-7) D LC G:$G(PRCPFLAG) Q
 ;*98 Modified report to replace "ISSUES" with "USAGE"
 W !,"USAGE",?14 S TOTISS=0 F ACCT=1,2,3,6,8 S %=$G(^TMP($J,NODE1,"ISS",ACCT)),TOTISS=TOTISS+%,OPEN(ACCT)=$G(OPEN(ACCT))+% W $$SHOWVALU(%)
 W $$SHOWVALU(TOTISS)
 I $Y>(IOSL-7) D LC G:$G(PRCPFLAG) Q
 W !,"ADJUSTMENTS",?14 S TOTAL=0 F ACCT=1,2,3,6,8 S %=$G(^TMP($J,NODE1,"ADJ",ACCT)),TOTAL=TOTAL+%,OPEN(ACCT)=$G(OPEN(ACCT))+% W $$SHOWVALU(%)
 W $$SHOWVALU(TOTAL)
 I $Y>(IOSL-7) D LC G:$G(PRCPFLAG) Q
 S %="",$P(%,"=",80)=""
 W !,%,!,"CLOSE BALANCE",?14 S TOTCLOS=0 F ACCT=1,2,3,6,8 S %=$G(OPEN(ACCT)),TOTCLOS=TOTCLOS+% W $$SHOWVALU(%)
 W $$SHOWVALU(TOTCLOS)
 I $Y>(IOSL-7) D LC G:$G(PRCPFLAG) Q
 W !!!,"# RECEIPTS",?13 S TOTAL=0 F ACCT=1,2,3,6,8 S %=$G(^TMP($J,NODE1,"RECN",ACCT)),TOTAL=TOTAL+%,TOTN(ACCT)=% W $J(%,11,0)
 W $J(TOTAL,11,0)
 I $Y>(IOSL-7) D LC G:$G(PRCPFLAG) Q
 ;*98 Modified report to replace "ISSUES" with "USAGES"
 W !,"# USAGE",?13 S TOTAL=0 F ACCT=1,2,3,6,8 S %=$G(^TMP($J,NODE1,"ISSN",ACCT)),TOTAL=TOTAL+%,TOTN(ACCT)=$G(TOTN(ACCT))+% W $J(%,11,0)
 W $J(TOTAL,11,0)
 I $Y>(IOSL-7) D LC G:$G(PRCPFLAG) Q
 W !,"# ADJUSTMENTS",?13 S TOTAL=0 F ACCT=1,2,3,6,8 S %=$G(^TMP($J,NODE1,"ADJN",ACCT)),TOTAL=TOTAL+%,TOTN(ACCT)=$G(TOTN(ACCT))+% W $J(%,11,0)
 W $J(TOTAL,11,0)
 I $Y>(IOSL-7) D LC G:$G(PRCPFLAG) Q
 S %="",$P(%,"=",80)=""
 W !,%,!,"# TOTAL",?13 S TOTAL=0 F ACCT=1,2,3,6,8 S %=$G(TOTN(ACCT)),TOTAL=TOTAL+% W $J(%,11,0)
 W $J(TOTAL,11,0)
 I $Y>(IOSL-7) D LC G:$G(PRCPFLAG) Q
 W !!,"TURNOVER",?13 F ACCT=1,2,3,6,8 S %=($G(^TMP($J,NODE1,"ISS",ACCT))*365)/DAYS,%=$S('$G(OPEN(ACCT)):"X",1:-%/OPEN(ACCT)) W $J(%,11,2)
 S %=(TOTISS*365)/DAYS,%=$S('TOTCLOS:"X",1:-%/TOTCLOS) W $J(%,11,2)
 ;*98 Added indicator of type of report (Standard/ODI/All)
 W !,"("_PRCPTP_" ITEMS)"
 I $Y>(IOSL-7) D LC G:$G(PRCPFLAG) Q
 ;
 ;*98 Added indicator of type of report (Standard/ODI/All)
 W !!?28,"***  CURRENT  DATA ("_PRCPTP_" ITEMS) ***"
 I $Y>(IOSL-7) D LC G:$G(PRCPFLAG) Q
 ;
 ;*98 Rearranged report placement of sections and added indicator of 
 ;type of report (Standard/ODI/All)
 ;
 S Y=$E(DATEINAC,1,5)_"01" D DD^%DT
 W !!?2,"INACTIVE ITEMS ("_PRCPTP_" ITEMS) FROM  ",Y,"  TO  ",$P(NOW,"@"),!,"# INACTIVE",?13
 S TOTAL=0 F ACCT=1,2,3,6,8 S %=$G(^TMP($J,NODE1,"INACTN",ACCT)),TOTAL=TOTAL+% W $J(%,11,0)
 W $J(TOTAL,11,0)
 I $Y>(IOSL-7) D LC G:$G(PRCPFLAG) Q
 W !,"$ INACTIVE",?14 S TOTAL=0 F ACCT=1,2,3,6,8 S %=$G(^TMP($J,NODE1,"INACT",ACCT)),TOTAL=TOTAL+% W $$SHOWVALU(%)
 W $$SHOWVALU(TOTAL)
 I $Y>(IOSL-7) D LC G:$G(PRCPFLAG) Q
 W !,"% INACTIVE",?13 F ACCT=1,2,3,6,8 S %=$G(^TMP($J,NODE1,"VALUE",ACCT)),%=$S('%:0,1:$G(^TMP($J,NODE1,"INACT",ACCT))/%) W $J(%,11,2)
 ;
 ;*98 Moved TOTVAL logic to support reordered processing
 S TOTVAL=0 F ACCT=1,2,3,6,8 S %=$G(^TMP($J,NODE1,"VALUE",ACCT)),TOTVAL=TOTVAL+%
 ;
 S %=$S('TOTVAL:0,1:TOTAL/TOTVAL) W $J(%,11,2)
 I $Y>(IOSL-7) D LC G:$G(PRCPFLAG) Q
 S Y=$E(DATELONG,1,5)_"01" D DD^%DT
 W !!?2,"LONG SUPPLY ("_PRCPTP_" ITEMS) AVG. FROM  ",Y,"  TO  ",$P(NOW,"@"),!?2,"(>90 DAYS)",!,"# LONG SUPPLY",?13
 S TOTAL=0 F ACCT=1,2,3,6,8 S %=$G(^TMP($J,NODE1,"LONGN",ACCT)),TOTAL=TOTAL+% W $J(%,11,0)
 W $J(TOTAL,11,0)
 I $Y>(IOSL-7) D LC G:$G(PRCPFLAG) Q
 W !,"$ LONG SUPPLY",?14 S TOTAL=0 F ACCT=1,2,3,6,8 S %=$G(^TMP($J,NODE1,"LONG",ACCT)),TOTAL=TOTAL+% W $$SHOWVALU(%)
 W $$SHOWVALU(TOTAL)
 I $Y>(IOSL-7) D LC G:$G(PRCPFLAG) Q
 W !,"% LONG SUPPLY",?13 F ACCT=1,2,3,6,8 S %=$G(^TMP($J,NODE1,"VALUE",ACCT)),%=$S('%:0,1:$G(^TMP($J,NODE1,"LONG",ACCT))/%) W $J(%,11,2)
 S %=$S('TOTVAL:0,1:TOTAL/TOTVAL) W $J(%,11,2)
 I $Y>(IOSL-7) D LC G:$G(PRCPFLAG) Q
 ;
 ;*98 Modified section to display a new section header, item type count,
 ;and display "$ONHAND" by specific type (Standard/ODI/All)
 ;
 W !!,"# "_PRCPTP2_" ITEMS",?13 S ITEMCTA=0 F ACCT=1,2,3,6,8 S %=$G(^TMP($J,NODE1,"CNT",ACCT)),ITEMCTA=ITEMCTA+% W $J(%,11,0)
 W $J(ITEMCTA,11,0)
 I $Y>(IOSL-7) D LC G:$G(PRCPFLAG) Q
 ;
 W !!,"INVENTORY VALUE"
 W !,"$ "_PRCPTP,?14 S TOTVAL=0 F ACCT=1,2,3,6,8 S %=$G(^TMP($J,NODE1,"VALUE",ACCT)),TOTVAL=TOTVAL+% W $$SHOWVALU(%)
 W $$SHOWVALU(TOTVAL)
 I $Y>(IOSL-7) D LC G:$G(PRCPFLAG) Q
 W !,"$ DUEINS",?14 S X=0 F ACCT=1,2,3,6,8 S %=$G(^TMP($J,NODE1,"DUEIN",ACCT)),X=X+% W $$SHOWVALU(%)
 W $$SHOWVALU(X)
 I $Y>(IOSL-7) D LC G:$G(PRCPFLAG) Q
 W !,"$ DUEOUTS",?14 S X=0 F ACCT=1,2,3,6,8 S %=$G(^TMP($J,NODE1,"DUEOUT",ACCT)),X=X+% W $$SHOWVALU(%)
 W $$SHOWVALU(X)
 I $Y>(IOSL-7) D LC G:$G(PRCPFLAG) Q
 ; 
 ;*98 Modified report to not show the section addressing nonissuable 
 ;items for primary and secondary inventory points
 Q
 ;
 ;
Q ;Tag ends printing and exits routine
 D END^PRCPUREP
 D ^%ZISC Q
 ;
 ;
SHOWVALU(V1) ;show value
 N % S %="+" S:+V1=0 %=" " I V1<0 S V1=-V1,%="-"
 Q $J(V1,10,2)_%
 ;
LC ;*98 Moved line control logic into subroutines
 I SCREEN W ! D P^PRCPUREP I $D(PRCPFLAG) Q
 ;
HEAD ;heading
 N PRCPT
 S %=NOW_"  PAGE: "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W !,"STOCK STATUS REPORT FOR: ",$E(PRCP("IN"),1,20),?(80-$L(%)),%
 ;*98 Added type of reporting (Standard/ODI/All) to header
 S PRCPT=PRCPTP_" ITEMS"
 W !?5,"TRANSACTIONS FOR THE MONTH-YEAR: ",MONTH,?(80-$L(PRCPT)),PRCPT
 ;
 W !,"SUMMARY",?14,$J("ACCT 1",11),$J("ACCT 2",11),$J("ACCT 3",11),$J("ACCT 6",11),$J("ACCT 8",11),$J("TOTAL",11)
 S %="",$P(%,"-",81)="" W !,%
 Q
