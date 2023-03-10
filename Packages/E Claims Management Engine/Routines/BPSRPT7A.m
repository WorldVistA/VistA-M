BPSRPT7A ;AITC/CKB - ECME REPORTS ;3/9/2020
 ;;1.0;E CLAIMS MGMT ENGINE;**28**;JUN 2004;Build 22
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
 ;Routine to Display the Reports (Continued - moved from BPSRPT7)
 ;
 ; Input Variables -> BPCLM = Array of report data by date
 ;                   BPDIV,BPSUMDET,GTOT
 ; Returned Value -> Cumulative Grand Totals
 ; 
PTBDT(BPDIV,BPSUMDET,BPCLM,GTOT) N DIFF,I,NP,RDT,TOT,X
 ;
 ;Loop through compiled array and display
 S TOT=""
 S RDT="" F  S RDT=$O(BPCLM(RDT)) Q:RDT=""  D  Q:BPQ
 .S NP=$$CHKP^BPSRPT5(1) Q:BPQ
 .S X=$G(BPCLM(RDT))
 .;
 .;Print Details - Report
 .I BPSUMDET=0,'BPEXCEL D
 ..W !,$$DATTIM^BPSRPT1(RDT) ;Date
 ..W ?15,$J(+$P(X,U),17) ;#Claims
 ..W ?33,$J(+$P(X,U,2),17,2)  ;Amount Submitted
 ..W ?51,$J(+$P(X,U,3),17,2)  ;Returned Rejected
 ..W ?69,$J(+$P(X,U,4),17,2)  ;Returned Payable
 ..W ?87,$J(+$P(X,U,5),17,2)  ;Amount to Receive
 ..;
 ..;Difference
 ..S DIFF=+$P(X,U,4)-$P(X,U,5)
 ..I DIFF<0 S DIFF="<"_$TR($J(-DIFF,15,2)," ")_">" W ?117,$J(DIFF,15)
 ..E  W ?116,$J(DIFF,15,2)
 ..;
 ..;Print Details - Excel
 .I BPSUMDET=0,BPEXCEL D
 ..;
 ..;Division
 ..W !,$S(BPDIV=0:"BLANK",$$DIVNAME^BPSSCRDS(BPDIV)]"":$$DIVNAME^BPSSCRDS(BPDIV),1:BPDIV),U
 ..W $$DATTIM^BPSRPT1(RDT),U  ;Date
 ..W +$P(X,U),U ;#Claims
 ..W $TR($J(+$P(X,U,2),17,2)," "),U  ;Amount Submitted
 ..W $TR($J(+$P(X,U,3),17,2)," "),U  ;Returned Rejected
 ..W $TR($J(+$P(X,U,4),17,2)," "),U  ;Returned Payable
 ..W $TR($J(+$P(X,U,5),17,2)," "),U  ;Amount to Receive
 ..;
 ..;Difference
 ..S DIFF=+$P(X,U,4)-$P(X,U,5)
 ..W $TR($J(DIFF,15,2)," ")
 .;
 .;Save Totals
 .F I=1:1:5 S $P(TOT,U,I)=$P(TOT,U,I)+$P(X,U,I),$P(GTOT,U,I)=$P($G(GTOT),U,I)+$P(X,U,I)
 ;
 ;Print Totals
 Q:BPEXCEL
 Q:BPQ  S NP=$$CHKP^BPSRPT5(2) Q:BPQ
 D ULINE^BPSRPT5("-")
 W !,"TOTALS"
 W ?15,$J(+$P(TOT,U),17)
 W ?33,$J(+$P(TOT,U,2),17,2)
 W ?51,$J(+$P(TOT,U,3),17,2)
 W ?69,$J(+$P(TOT,U,4),17,2)
 W ?87,$J(+$P(TOT,U,5),17,2)
 S X=$S((+$P(TOT,U,4))=0:0,1:(+$P(TOT,U,5))/(+$P(TOT,U,4)))
 S DIFF=+$P(TOT,U,4)-$P(TOT,U,5)
 I DIFF<0 S DIFF="<"_$TR($J(-DIFF,15,2)," ")_">" W ?117,$J(DIFF,15)
 E  W ?116,$J(DIFF,15,2)
 Q
 ;
 ;Print Grand Totals - Report 6
 ;
PGTOT6(GTOT) N DIFF,NP,X
 Q:BPQ  S NP=$$CHKP^BPSRPT5(2) Q:BPQ
 D ULINE^BPSRPT5("-")
 W !,"GRAND TOTALS"
 W ?15,$J(+$P(GTOT,U),17)
 W ?33,$J(+$P(GTOT,U,2),17,2)
 W ?51,$J(+$P(GTOT,U,3),17,2)
 W ?69,$J(+$P(GTOT,U,4),17,2)
 W ?87,$J(+$P(GTOT,U,5),17,2)
 S X=$S((+$P(GTOT,U,4))=0:0,1:(+$P(GTOT,U,5))/(+$P(GTOT,U,4)))
 S DIFF=+$P(GTOT,U,4)-$P(GTOT,U,5)
 I DIFF<0 S DIFF="<"_$TR($J(-DIFF,15,2)," ")_">" W ?117,$J(DIFF,15)
 E  W ?116,$J(DIFF,15,2)
 Q
 ;
 ;Print Grand Totals - Reports 1,2,3,4,5,7,8,9,10
 ;
PGTOT(BPRTYPE,BPGBIL,BPGINS,BPGCOLL,BPGDPAY,BPGCNT,BPGELTM,BPRICE) ;
 I (BPRTYPE=1)!(BPRTYPE=4) D  Q
 .W !!,?83,"----------",?105,"----------",?122,"----------"
 .W !,"GRAND TOTALS",?83,$J(BPGBIL,10,2),?105,$J(BPGINS,10,2),?122,$J(BPGCOLL,10,2)
 .W !,"COUNT",?83,$J(BPGCNT,10),?105,$J(BPGCNT,10),?122,$J(BPGCNT,10)
 .W:BPGCNT !,"MEAN",?83,$J(BPGBIL/BPGCNT,10,2),?105,$J(BPGINS/BPGCNT,10,2),?122,$J(BPGCOLL/BPGCNT,10,2)
 I BPRTYPE=3 D  Q
 .W !!,?100,"----------",?122,"----------"
 .W !,"GRAND TOTALS",?100,$J(BPGBIL,10,2),?122,$J(BPGINS,10,2)
 .W !,"COUNT",?100,$J(BPGCNT,10),?122,$J(BPGCNT,10)
 .W:BPGCNT !,"MEAN",?100,$J(BPGBIL/BPGCNT,10,2),?122,$J(BPGINS/BPGCNT,10,2)
 I BPRTYPE=2 D  Q
 .W !!,?41,"----------"
 .W !,"GRAND TOTALS",?41,$J(BPGBIL,10,2)
 .W !,"COUNT",?41,$J(BPGCNT,10)
 .W:BPGCNT !,"MEAN",?41,$J(BPGBIL/BPGCNT,10,2)
 I (BPRTYPE=5) D  Q
 .W !!,"GRAND TOTALS (ALL DIVISIONS)",?65,"---------------"
 .W !,"TOTAL CLAIMS",?65,$J(BPGCNT,15)
 .W !,"AVERAGE ELAPSED TIME PER CLAIM",?65,$J($S(BPGCNT=0:"0",1:(BPGELTM\BPGCNT)),15)
 I (BPRTYPE=7) D  Q
 .W !!,"GRAND TOTALS (ALL DIVISIONS) BY BILLER"
 .N BPBILR,BPDIV S BPDIV="ALL DIVISIONS"
 .S BPBILR="" F  S BPBILR=$O(BPGCNT(BPBILR)) Q:BPBILR=""  D  Q:BPQ
 ..S NP=$$CHKP^BPSRPT5(1) Q:BPQ
 ..W !,?3,BPBILR,?65,$J($G(BPGCNT(BPBILR)),5)
 .Q:$G(BPQ)
 .W !,?65,"-----"
 .W !,"CLOSED CLAIMS GRAND TOTAL",?65,$J(BPGCNT,5)
 I BPRTYPE=8 D  Q
 .W !!,?78,"----------",?100,"----------",?122,"----------"
 .W !,"GRAND TOTALS",?78,$J(BPGBIL,10,2),?100,$J(BPGINS,10,2),?122,$J(BPGCOLL,10,2)
 .W !,?4,$J($P(BPRICE,U,3),10,2),?23,$J($P(BPRICE,U,4),10,2),?38,$J($P(BPRICE,U,5),10,2),?56,$J($P(BPRICE,U,6),10,2),?81,$J($P(BPRICE,U,7),10,2),?96,$J($P(BPRICE,U,2),10,2),?111,$J($P(BPRICE,U),10,2)
 .W !,"COUNT",?78,$J(BPGCNT,10),?100,$J(BPGCNT,10),?122,$J(BPGCNT,10)
 .W !,?4,$J(BPGCNT,10),?23,$J(BPGCNT,10),?38,$J(BPGCNT,10),?56,$J(BPGCNT,10),?81,$J(BPGCNT,10),?96,$J(BPGCNT,10),?111,$J(BPGCNT,10)
 .W:BPGCNT !,"MEAN",?78,$J(BPGBIL/BPGCNT,10,2),?100,$J(BPGINS/BPGCNT,10,2),?122,$J(BPGCOLL/BPGCNT,10,2)
 .W !,?4,$J($P(BPRICE,U,3)/BPGCNT,10,2),?23,$J($P(BPRICE,U,4)/BPGCNT,10,2),?38,$J($P(BPRICE,U,5)/BPGCNT,10,2)
 .W ?56,$J($P(BPRICE,U,6)/BPGCNT,10,2),?81,$J($P(BPRICE,U,7)/BPGCNT,10,2),?96,$J($P(BPRICE,U,2)/BPGCNT,10,2),?111,$J($P(BPRICE,U)/BPGCNT,10,2)
 ;
 I BPRTYPE=9 D  Q
 .W !!,?84,"----------"
 .W !,"GRAND TOTALS",?84,$J(BPGBIL,10,2)
 .W !,"COUNT",?84,$J(BPGCNT,10)
 .W:BPGCNT !,"MEAN",?84,$J(BPGBIL/BPGCNT,10,2)
 ;
 I BPRTYPE=10 D  Q
 .W !!,?77,"----------",?90,$J("----------",13),?106,"----------",?118,$J("----------",12)
 .W !,"GRAND TOTALS",?77,$J(BPGBIL,10,2),?90,$J(BPGINS,13,2),?106,$J(BPGCOLL,10,2),?118,$J(BPGDPAY,12,2)
 .W !,"COUNT",?77,$J(BPGCNT,10),?90,$J(BPGCNT,13),?106,$J(BPGCNT,10),?118,$J(BPGCNT,12)
 .W:BPGCNT !,"MEAN",?77,$J(BPGBIL/BPGCNT,10,2),?90,$J(BPGINS/BPGCNT,13,2),?106,$J(BPGCOLL/BPGCNT,10,2),?118,$J(BPGDPAY/BPGCNT,12,2)
 Q
 ;
 ;Print Report Insurance Subtotals
 ;
ITOT(BPRTYPE,BPDIV,BPGRPLAN,BPTBIL,BPTINS,BPTCOLL,BPTDPAY,BPCNT,BPRICE) ;
 N BPNP
 I (BPRTYPE=1)!(BPRTYPE=4) D  Q
 .W !!,?83,"----------",?105,"----------",?122,"----------"
 .W !,"SUBTOTALS for INS:",$E(BPGRPLAN,1,50),?83,$J(BPTBIL,10,2),?105,$J(BPTINS,10,2),?122,$J(BPTCOLL,10,2)
 .W !,"COUNT",?83,$J(BPCNT,10),?105,$J(BPCNT,10),?122,$J(BPCNT,10)
 .W:BPCNT !,"MEAN",?83,$J(BPTBIL/BPCNT,10,2),?105,$J(BPTINS/BPCNT,10,2),?122,$J(BPTCOLL/BPCNT,10,2)
 I BPRTYPE=3 D  Q
 .W !!,?100,"----------",?122,"----------"
 .W !,"SUBTOTALS for INS:",$E(BPGRPLAN,1,50),?100,$J(BPTBIL,10,2),?122,$J(BPTINS,10,2)
 .W !,"COUNT",?100,$J(BPCNT,10),?122,$J(BPCNT,10)
 .W:BPCNT !,"MEAN",?100,$J(BPTBIL/BPCNT,10,2),?122,$J(BPTINS/BPCNT,10,2)
 I BPRTYPE=2 D  Q
 .W !!,?41,"----------"
 .W !,"SUBTOTALS for INS:",$E(BPGRPLAN,1,22),?41,$J(BPTBIL,10,2)
 .W !,"COUNT",?41,$J(BPCNT,10)
 .W:BPCNT !,"MEAN",?41,$J(BPTBIL/BPCNT,10,2)
 I (BPRTYPE=7) D  Q
 .W !!,"SUBTOTALS for INS:",$E(BPGRPLAN,1,50)
 .N BPBILR
 .S BPBILR="" F  S BPBILR=$O(BPCNT(BPBILR)) Q:BPBILR=""  D  Q:BPQ
 ..S BPNP=$$CHKP^BPSRPT5(1) Q:BPQ
 ..W !,?3,BPBILR,?65,$J($G(BPCNT(BPBILR)),5)
 .Q:$G(BPQ)
 .W !,?65,"-----"
 .W !,"CLOSED CLAIMS SUBTOTAL",?65,$J(BPCNT,5)
 I BPRTYPE=8 D  Q
 .W !!,?78,"----------",?100,"----------",?122,"----------"
 .W !,"SUBTOTALS for INS:",$E(BPGRPLAN,1,50),?78,$J(BPTBIL,10,2),?100,$J(BPTINS,10,2),?122,$J(BPTCOLL,10,2)
 .W !,?4,$J($P(BPRICE,U,3),10,2),?23,$J($P(BPRICE,U,4),10,2),?38,$J($P(BPRICE,U,5),10,2),?56,$J($P(BPRICE,U,6),10,2),?81,$J($P(BPRICE,U,7),10,2),?96,$J($P(BPRICE,U,2),10,2),?111,$J($P(BPRICE,U),10,2)
 .W !,"COUNT",?78,$J(BPCNT,10),?100,$J(BPCNT,10),?122,$J(BPCNT,10)
 .W !,?4,$J(BPCNT,10),?23,$J(BPCNT,10),?38,$J(BPCNT,10),?56,$J(BPCNT,10),?81,$J(BPCNT,10),?96,$J(BPCNT,10),?111,$J(BPCNT,10)
 .W:BPCNT !,"MEAN",?78,$J(BPTBIL/BPCNT,10,2),?100,$J(BPTINS/BPCNT,10,2),?122,$J(BPTCOLL/BPCNT,10,2)
 .W !,?4,$J($P(BPRICE,U,3)/BPCNT,10,2),?23,$J($P(BPRICE,U,4)/BPCNT,10,2),?38,$J($P(BPRICE,U,5)/BPCNT,10,2),?56,$J($P(BPRICE,U,6)/BPCNT,10,2),?81,$J($P(BPRICE,U,7)/BPCNT,10,2),?96,$J($P(BPRICE,U,2)/BPCNT,10,2),?111,$J($P(BPRICE,U)/BPCNT,10,2)
 ;
 I BPRTYPE=9 D  Q
 .W !!,?84,"----------"
 .W !,"SUBTOTALS for INS:",$E(BPGRPLAN,1,50),?84,$J(BPTBIL,10,2)
 .W !,"COUNT",?84,$J(BPCNT,10)
 .W:BPCNT !,"MEAN",?84,$J(BPTBIL/BPCNT,10,2)
 ;
 I BPRTYPE=10 D  Q
 .W !!,?77,"----------",?90,$J("----------",13),?106,"----------",?118,$J("----------",12)
 .W !,"SUBTOTALS for INS:",$E(BPGRPLAN,1,50),?77,$J(BPTBIL,10,2),?90,$J(BPTINS,13,2),?106,$J(BPTCOLL,10,2),?118,$J(BPTDPAY,12,2)
 .W !,"COUNT",?77,$J(BPCNT,10),?90,$J(BPCNT,13),?106,$J(BPCNT,10),?118,$J(BPCNT,12)
 .W:BPCNT !,"MEAN",?77,$J(BPTBIL/BPCNT,10,2),?90,$J(BPTINS/BPCNT,13,2),?106,$J(BPTCOLL/BPCNT,10,2),?118,$J(BPTDPAY/BPCNT,12,2)
 Q
 ;
 ;Return the Billed Amount
 ;
BILLED(BP59) ;
 Q +$P($G(^BPST(BP59,5)),U,5)
 ;
