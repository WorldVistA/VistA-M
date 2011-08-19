BPSRPT7 ;BHAM ISC/BEE - ECME REPORTS ;14-FEB-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,3,5,7,8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
 ;Routine to Display the Reports (Continued)
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
 ;Print Grand Totals - Reports 1,2,3,4,5,7
 ;
PGTOT(BPRTYPE,BPGBIL,BPGINS,BPGCOLL,BPGCNT,BPGELTM) ;
 I (BPRTYPE=1)!(BPRTYPE=4) D  Q
 .W !!,?78,"----------",?100,"----------",?122,"----------"
 .W !,"GRAND TOTALS",?78,$J(BPGBIL,10,2),?100,$J(BPGINS,10,2),?122,$J(BPGCOLL,10,2)
 .W !,"COUNT",?78,$J(BPGCNT,10),?100,$J(BPGCNT,10),?122,$J(BPGCNT,10)
 .W:BPGCNT !,"MEAN",?78,$J(BPGBIL/BPGCNT,10,2),?100,$J(BPGINS/BPGCNT,10,2),?122,$J(BPGCOLL/BPGCNT,10,2)
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
 ;
 Q
 ;
 ;Get Close Reason
 ;
 ; Input Variable -> BP59 = ptr to BPS TRANSACTIONS
 ; Returned Value -> Claim Close Reason
 ;
CLRSN(BP59) N BP02,CIEN,CL
 S CL=""
 S BP02=+$P($G(^BPST(BP59,0)),U,4)
 S CIEN=+$P($G(^BPSC(BP02,900)),U,4)
 I CIEN'=0 S CL=$$GETCLR^BPSRPT6(CIEN)
 Q CIEN_"^"_CL
 ;
 ;Get Reversal Reason
 ;
 ; Input Variable -> BP59 = ptr to BPS TRANSACTIONS
 ; Returned Value -> Claim Reversal Reason
 ;
RVSRSN(BP59) Q $P($G(^BPST(BP59,4)),U,4)
 ;
 ;Return the Billed Amount
 ;
BILLED(BP59) ;
 Q +$P($G(^BPST(BP59,5)),U,5)
 ;
 ;Return the Transaction Type - SUBMIT or REVERSAL
 ;
TTYPE(BPRX,BPREF,BPSEQ) N BPSTATUS,TTYPE
 S TTYPE="SUBMIT"
 S BPSTATUS=$$STATUS^BPSRPT6(BPRX,BPREF,$G(BPSEQ))
 I BPSTATUS["REVERSAL" S TTYPE="REVERSAL"
 Q TTYPE
 ;
 ;Return the payer response
 ;
RESPONSE(BPRX,BPREF,BPSEQ) Q $P($$STATUS^BPSRPT6(BPRX,BPREF,$G(BPSEQ)),U)
 ;
 ;Print Report Subtotals
 ;
TOTALS(BPRTYPE,BPDIV,BPTBIL,BPTINS,BPTCOLL,BPCNT,BPELTM) ;
 I (BPRTYPE=1)!(BPRTYPE=4) D  Q
 .W !!,?78,"----------",?100,"----------",?122,"----------"
 .W !,"SUBTOTALS for DIV:",$E($$BPDIV(BPDIV),1,52),?78,$J(BPTBIL,10,2),?100,$J(BPTINS,10,2),?122,$J(BPTCOLL,10,2)
 .W !,"COUNT",?78,$J(BPCNT,10),?100,$J(BPCNT,10),?122,$J(BPCNT,10)
 .W:BPCNT !,"MEAN",?78,$J(BPTBIL/BPCNT,10,2),?100,$J(BPTINS/BPCNT,10,2),?122,$J(BPTCOLL/BPCNT,10,2)
 I BPRTYPE=3 D  Q
 .W !!,?100,"----------",?122,"----------"
 .W !,"SUBTOTALS for DIV:",$E($$BPDIV(BPDIV),1,52),?100,$J(BPTBIL,10,2),?122,$J(BPTINS,10,2)
 .W !,"COUNT",?100,$J(BPCNT,10),?122,$J(BPCNT,10)
 .W:BPCNT !,"MEAN",?100,$J(BPTBIL/BPCNT,10,2),?122,$J(BPTINS/BPCNT,10,2)
 I BPRTYPE=2 D  Q
 .W !!,?41,"----------"
 .W !,"SUBTOTALS for DIV:",$E($$BPDIV(BPDIV),1,22),?41,$J(BPTBIL,10,2)
 .W !,"COUNT",?41,$J(BPCNT,10)
 .W:BPCNT !,"MEAN",?41,$J(BPTBIL/BPCNT,10,2)
 I (BPRTYPE=5) D  Q
 .W !!,"SUBTOTALS for DIV: ",$E($$BPDIV(BPDIV),1,43),?65,"---------------"
 .W !,"TOTAL CLAIMS",?65,$J(BPCNT,15)
 .W !,"AVERAGE ELAPSED TIME PER CLAIM",?65,$J($S(BPCNT=0:"0",1:(BPELTM\BPCNT)),15)
 I (BPRTYPE=7) D  Q
 .W !!,"SUBTOTALS for DIV:",$E($$BPDIV(BPDIV),1,43)
 .N BPBILR
 .S BPBILR="" F  S BPBILR=$O(BPCNT(BPBILR)) Q:BPBILR=""  D  Q:BPQ
 ..S NP=$$CHKP^BPSRPT5(1) Q:BPQ
 ..W !,?3,BPBILR,?65,$J($G(BPCNT(BPBILR)),5)
 .Q:$G(BPQ)
 .W !,?65,"-----"
 .W !,"CLOSED CLAIMS SUBTOTAL",?65,$J(BPCNT,5)
 ;
 Q
 ;
 ;Print Report Header
 ; Input variables (defined in BPSRPT0) - BPPHARM,BPSUMDET,BPNOW,BPMWC,BPRTBCK,BPINSINF
 ;                                        BPREJCD,BPCCRSN,BPAUTREV,BPACREJ,BPQSTDRG
 ;                                        BPDRUG,BPDRGCL,BPRLNRL,BPSORT,BPBEGDT,BPENDDT
 ; Output variable - BPSDATA -> Reset to 0 to show no actual data has been printed
 ;                           on the screen
 ;                   BPPAGE -> First set in BPSRPT0
 ;                   BPBLINE -> Controls whether to print a blank line
 ;                   
HDR(BPRTYPE,BPRPTNAM,BPPAGE) ;
 ;Display Excel Header
 I BPEXCEL D HDR^BPSRPT8(BPRTYPE) Q
 ;
 ; Define BPPDATA - Tells whether data has been displayed for a screen
 S BPSDATA=0
 S BPBLINE=""
 S BPPAGE=$G(BPPAGE)+1
 W @IOF
 W "ECME "_BPRPTNAM_" "_$S(BPSUMDET=1:"SUMMARY",1:"DETAIL")_" REPORT"
 W ?89,"Print Date: "_$G(BPNOW)_"  Page:",$J(BPPAGE,3)
 W !,"DIVISION(S): ",$$GETDIVS^BPSRPT4(75,.BPPHARM)
 W ?93,"Fill Locations: "_$S(BPMWC="A":"C,M,W",1:BPMWC)
 W ?116,"Fill type: "_$S(BPRTBCK=2:"RT",BPRTBCK=3:"BB",1:"RT,BB")
 W !,"Insurance: "_$S(BPINSINF=0:"ALL",1:$$BPINS(BPINSINF))
 I (",7,")[BPRTYPE W ?44,"Close Reason: ",$E($$GETCLR^BPSRPT6(BPCCRSN),1,26)
 I (",4,")[BPRTYPE W ?44,$J($S(BPAUTREV=0:"ALL",1:"AUTO"),4)," Reversals"
 I (",4,")[BPRTYPE W ?60,$J($S(BPACREJ=1:"REJECTED",BPACREJ=2:"ACCEPTED",1:"ALL"),8)," Returned Status"
 W ?87,"Drugs/Classes: "_$S(BPQSTDRG=2:$$DRGNAM^BPSRPT6(BPDRUG,30),BPQSTDRG=3:$E(BPDRGCL,1,30),1:"ALL")
 I (",2,")[BPRTYPE W !,"Reject Code: ",$E($$GETREJ^BPSRPT4(BPREJCD),1,28),?89,"Elibility: ",$S(BPELIG="V":"VET",BPELIG="T":"TRI",1:"ALL"),?111,"Open/Closed: ",$S(BPOPCL=1:"CLOSED",BPOPCL=2:"OPEN",1:"ALL")
 W !,$S(BPRTYPE=5:"PRESCRIPTIONS",BPRLNRL=2:"RELEASED PRESCRIPTIONS",BPRLNRL=3:"PRESCRIPTIONS (NOT RELEASED)",1:"ALL PRESCRIPTIONS")
 W " BY "_$S(BPRTYPE=7:"CLOSE",1:"TRANSACTION")_" DATE: "
 W "From "_$$DATTIM^BPSRPT1(BPBEGDT)_" through "_$$DATTIM^BPSRPT1($P(BPENDDT,"."))
 ;
 D ULINE^BPSRPT5("=") Q:$G(BPQ)
 D HEADLN1^BPSRPT4(BPRTYPE)
 D HEADLN2^BPSRPT4(BPRTYPE)
 D HEADLN3^BPSRPT4(BPRTYPE)
 D ULINE^BPSRPT5("=")
 ;
 ;Print Division
 I $G(BPDIV)]"" D
 .W !,"DIVISION: ",$S(BPDIV=0:"BLANK",BPDIV="ALL DIVISIONS":"ALL DIVISIONS",$$DIVNAME^BPSSCRDS(BPDIV)]"":$$DIVNAME^BPSSCRDS(BPDIV),1:BPDIV)
 .I BPRTYPE=5!(BPRTYPE=6)!(BPSUMDET=1)!(BPGRPLAN="") D ULINE^BPSRPT5("-")
 ;
 ;Print Insurance If Defined
 I BPSUMDET=0,$G(BPGRPLAN)]"",$G(BPGRPLAN)'=0,$G(BPGRPLAN)'="~" D WRPLAN^BPSRPT5(BPGRPLAN)
 Q
 ;
 ;Special Division Handling
 ;
BPDIV(BPDIV) Q $S(BPDIV=0:"BLANK",$$DIVNAME^BPSSCRDS(BPDIV)]"":$$DIVNAME^BPSSCRDS(BPDIV),1:BPDIV)
 ;
 ;Get selected insurance names based on user selection
 ;If length is greater than 68 append "..."
 ;Input: BPINSINF = Semi-colon separated list of file 36 IENs
 ;Output: comma separated list of related file 36 names
BPINS(BPINSINF) ;
 N BPINS,BPINAME,RETV
 S RETV=""
 F I=2:1 S BPINS=$P($G(BPINSINF),";",I) Q:BPINS=""  D
 . S BPINAME=$$INSNM^IBNCPDPI(BPINS) Q:BPINAME=""
 . I RETV'="" S RETV=RETV_", "_BPINAME Q
 . S RETV=BPINAME
 I $L(RETV)>68 S RETV=$E(RETV,1,68)_"..."
 Q RETV
