PRCPDAP1 ;WISC/RFJ-drug accountability/prime vendor (process data)  ;15 Mar 94
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
PROCESS ;  process data on invoice
 N %,DATA,GSDATA,ISADATA,ITCOUNT,ITEMDA,LASTSEG,LINE,LINEITEM,NDC,NEXTSEG,NTYPE,P,STCOUNT,STCTRL,STDATA,VDC,VENDA
 K ^TMP($J,"PRCPDAPV SET"),PRCPFLAG,PRCPFERR
 S LASTSEG=""
 S LINE=0 F  S LINE=$O(^TMP($J,"PRCPDAPVS",LINE)) Q:'LINE  S DATA=^(LINE) D  Q:$G(PRCPFLAG)
 .   ;  check segment order
 .   D ORDER^PRCPDAPE I $G(PRCPFLAG) Q
 .   S LASTSEG=$P(DATA,"^")
 .   ;  control header
 .   I $P(DATA,"^")="ISA" S ISADATA=DATA D  Q
 .   .   I $L($P(DATA,"^",14))'=9 D ERROR^PRCPDAPE("'ISA' CONTROL HEADER, CONTROL NUMBER (piece 14) SHOULD BE 9 CHARACTERS IN LENGTH")
 .   ;  control trailer
 .   I $P(DATA,"^")="IEA" D  Q
 .   .   I $P(DATA,"^",3)'=$P(ISADATA,"^",14) D ERROR^PRCPDAPE("'IEA' CONTROL TRAILER, CONTROL NUMBER (piece 3) SHOULD EQUAL 'ISA' CONTROL HEADER, CONTROL NUMBER (piece 14 = "_$P(ISADATA,"^",14)_")")
 .   ;  group header
 .   I $P(DATA,"^")="GS" S GSDATA=DATA D  Q
 .   .   F %=3:1:6 S P=$S(%=3:7,1:%+5) I $P(DATA,"^",%)'=$TR($P(ISADATA,"^",P)," ") D ERROR^PRCPDAPE("'GS' GROUP HEADER, (piece "_%_") SHOULD EQUAL 'ISA' CONTROL HEADER (piece "_P_" = "_$TR($P(ISADATA,"^",P)," ")) Q
 .   ;  group trailer
 .   I $P(DATA,"^")="GE" D  Q
 .   .   I $P(DATA,"^",3)'=$P($G(GSDATA),"^",7) D ERROR^PRCPDAPE("'GE' GROUP TRAILER, CONTROL NUMBER (piece 3) SHOULD EQUAL 'GS' GROUP HEADER, CONTROL NUMBER (piece 7 = "_$P($G(GSDATA),"^",7)_")")
 .   ;  set header
 .   I $P(DATA,"^")="ST" D  Q
 .   .   S STDATA=DATA,STCTRL=$P(DATA,"^",3),STCOUNT=1,ITCOUNT=0,NTYPE=""
 .   .   I $L(STCTRL)'=9 D ERROR^PRCPDAPE("'ST' SET HEADER, CONTROL NUMBER (piece 3) SHOULD BE 9 CHARACTERS IN LENGTH") Q
 .   .   I $D(^TMP($J,"PRCPDAPV SET",STCTRL)) D ERROR^PRCPDAPE("'ST' SET HEADER, CONTROL NUMBER (piece 3) IS USED MORE THAN ONCE")
 .   ;  set trailer
 .   I $P(DATA,"^")="SE" S STCOUNT=STCOUNT+1 D  Q
 .   .   I $P(DATA,"^",3)'=STCTRL D ERROR^PRCPDAPE("'SE' SET TRAILER, CONTROL NUMBER (piece 3) SHOULD EQUAL 'ST' SET HEADER, CONTROL NUMBER (piece 3 = "_STCTRL_")") Q
 .   .   I STCOUNT'=$P(DATA,"^",2) D ERROR^PRCPDAPE("'SE' SET TRAILER, COUNT OF SEGMENTS (piece 2) SHOULD EQUAL NUMBER OF SEGMENTS ("_STCOUNT_")")
 .   ;  beginning segment for invoice
 .   I $P(DATA,"^")="BIG" S STCOUNT=STCOUNT+1 D  Q
 .   .   I $P(DATA,"^",4)="" S $P(DATA,"^",4)=$P(DATA,"^",2)
 .   .   S $P(DATA,"^",5)=$TR($P(DATA,"^",5)," ")
 .   .   S ^TMP($J,"PRCPDAPV SET",STCTRL,"IN")=$P(DATA,"^",2,5)
 .   ;  (not used)
 .   I $P(DATA,"^")="REF" S STCOUNT=STCOUNT+1 Q
 .   ;   buyer, seller, shipping info
 .   I $P(DATA,"^")="N1" S STCOUNT=STCOUNT+1,NTYPE=$P(DATA,"^",2) D  Q
 .   .   I NTYPE'="BY",NTYPE'="DS",NTYPE'="ST" D ERROR^PRCPDAPE("THE 'N1' SEGMENT, PIECE 2 SHOULD EQUAL 'BY', 'DS' OR 'ST'") Q
 .   .   S $P(^TMP($J,"PRCPDAPV SET",STCTRL,NTYPE),"^")=$P(DATA,"^",3),$P(^(NTYPE),"^",2)=$P(DATA,"^",5)
 .   I $P(DATA,"^")="N2" D NONTYPE^PRCPDAPE Q:$G(PRCPFLAG)  S %=$G(^TMP($J,"PRCPDAPV SET",STCTRL,NTYPE)),$P(^(NTYPE),"^")=$P(%,"^")_" "_$P(DATA,"^",2)_" "_$P(DATA,"^",3),STCOUNT=STCOUNT+1 Q
 .   I $P(DATA,"^")="N3" D NONTYPE^PRCPDAPE Q:$G(PRCPFLAG)  S $P(^TMP($J,"PRCPDAPV SET",STCTRL,NTYPE),"^",3)=$P(DATA,"^",2)_" "_$P(DATA,"^",3),STCOUNT=STCOUNT+1 Q
 .   I $P(DATA,"^")="N4" D NONTYPE^PRCPDAPE Q:$G(PRCPFLAG)  S $P(^TMP($J,"PRCPDAPV SET",STCTRL,NTYPE),"^",4,6)=$P(DATA,"^",2,4),STCOUNT=STCOUNT+1,NTYPE="" Q
 .   ;  term discount
 .   I $P(DATA,"^")="ITD" S $P(^TMP($J,"PRCPDAPV SET",STCTRL,"IN"),"^",6,11)=$P(DATA,"^",4,9),STCOUNT=STCOUNT+1 Q
 .   ;  date time reference
 .   I $P(DATA,"^")="DTM" S STCOUNT=STCOUNT+1 D  Q
 .   .   S %=$S($P(DATA,"^",2)="002":12,$P(DATA,"^",2)="035":13,1:0) I '% Q
 .   .   S $P(^TMP($J,"PRCPDAPV SET",STCTRL,"IN"),"^",%)=$P(DATA,"^",3)
 .   ;  invoice line item
 .   I $P(DATA,"^")="IT1" S STCOUNT=STCOUNT+1,ITCOUNT=ITCOUNT+1 D ITEM^PRCPDAPI Q
 .   ;  item count
 .   I $P(DATA,"^")="CTT" S STCOUNT=STCOUNT+1 D  Q
 .   .   I ITCOUNT'=$P(DATA,"^",2) D ERROR^PRCPDAPE("'CTT' TRANSACTION TOTALS, LINE ITEM COUNT (piece 2) SHOULD EQUAL NUMBER OF LINE ITEMS ("_ITCOUNT_")")
 .   ;  unknown segement
 .   D ERROR^PRCPDAPE("SEGMENT IS UNKNOWN")
 Q
