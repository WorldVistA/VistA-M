BPSRPT7 ;BHAM ISC/BEE - ECME REPORTS ;14-FEB-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,3,5,7,8,10,11,19,20,23,24,28**;JUN 2004;Build 22
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
 ;Routine to Display the Reports (Continued)
 ;
 ; The following sub-routines were moved to BPSRPT7A:
 ;   PTBDT,PGTOT6,PGTOT,ITOT,BILLED
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
TOTALS(BPRTYPE,BPDIV,BPTBIL,BPTINS,BPTCOLL,BPTDPAY,BPCNT,BPELTM,BPRICE) ;
 I (BPRTYPE=1)!(BPRTYPE=4) D  Q
 .W !!,?83,"----------",?105,"----------",?122,"----------"
 .W !,"SUBTOTALS for DIV:",$E($$BPDIV(BPDIV),1,52),?83,$J(BPTBIL,10,2),?105,$J(BPTINS,10,2),?122,$J(BPTCOLL,10,2)
 .W !,"COUNT",?83,$J(BPCNT,10),?105,$J(BPCNT,10),?122,$J(BPCNT,10)
 .W:BPCNT !,"MEAN",?83,$J(BPTBIL/BPCNT,10,2),?105,$J(BPTINS/BPCNT,10,2),?122,$J(BPTCOLL/BPCNT,10,2)
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
 I BPRTYPE=8 D  Q
 .W !!,?78,"----------",?100,"----------",?122,"----------"
 .W !,"SUBTOTALS for DIV:",$E($$BPDIV(BPDIV),1,52),?78,$J(BPTBIL,10,2),?100,$J(BPTINS,10,2),?122,$J(BPTCOLL,10,2)
 .W !,?4,$J($P(BPRICE,U,3),10,2),?23,$J($P(BPRICE,U,4),10,2),?38,$J($P(BPRICE,U,5),10,2),?56,$J($P(BPRICE,U,6),10,2),?81,$J($P(BPRICE,U,7),10,2),?96,$J($P(BPRICE,U,2),10,2),?111,$J($P(BPRICE,U),10,2)
 .W !,"COUNT",?78,$J(BPCNT,10),?100,$J(BPCNT,10),?122,$J(BPCNT,10)
 .W !,?4,$J(BPCNT,10),?23,$J(BPCNT,10),?38,$J(BPCNT,10),?56,$J(BPCNT,10),?81,$J(BPCNT,10),?96,$J(BPCNT,10),?111,$J(BPCNT,10)
 .W:BPCNT !,"MEAN",?78,$J(BPTBIL/BPCNT,10,2),?100,$J(BPTINS/BPCNT,10,2),?122,$J(BPTCOLL/BPCNT,10,2)
 .W !,?4,$J($P(BPRICE,U,3)/BPCNT,10,2),?23,$J($P(BPRICE,U,4)/BPCNT,10,2),?38,$J($P(BPRICE,U,5)/BPCNT,10,2),?56,$J($P(BPRICE,U,6)/BPCNT,10,2),?81,$J($P(BPRICE,U,7)/BPCNT,10,2),?96,$J($P(BPRICE,U,2)/BPCNT,10,2),?111,$J($P(BPRICE,U)/BPCNT,10,2)
 ;
 I BPRTYPE=9 D  Q
 .W !!,?84,"----------"
 .W !,"SUBTOTALS for DIV:",$E($$BPDIV(BPDIV),1,52),?84,$J(BPTBIL,10,2)
 .W !,"COUNT",?84,$J(BPCNT,10)
 .W:BPCNT !,"MEAN",?84,$J(BPTBIL/BPCNT,10,2)
 ;
 I BPRTYPE=10 D  Q
 .W !!,?77,"----------",?90,$J("----------",13),?106,"----------",?118,$J("----------",12)
 .W !,"SUBTOTALS for DIV:",$E($$BPDIV(BPDIV),1,52),?77,$J(BPTBIL,10,2),?90,$J(BPTINS,13,2),?106,$J(BPTCOLL,10,2),?118,$J(BPTDPAY,12,2)
 .W !,"COUNT",?77,$J(BPCNT,10),?90,$J(BPCNT,13),?106,$J(BPCNT,10),?118,$J(BPCNT,12)
 .W:BPCNT !,"MEAN",?77,$J(BPTBIL/BPCNT,10,2),?90,$J(BPTINS/BPCNT,13,2),?106,$J(BPTCOLL/BPCNT,10,2),?118,$J(BPTDPAY/BPCNT,12,2)
 Q
 ;
 ;Print Report Header
 ; Input variables (passed in) - BPRTYPE -> number of report
 ;                             - BPRPTNAM -> report name
 ;                             - BPPAGE -> report page number
 ; Input variables (defined in BPSRPT0) - BPPHARM,BPSUMDET,BPNOW,BPMWC,BPRTBCK,BPINSINF
 ;                                        BPREJCD,BPCCRSN,BPAUTREV,BPACREJ,BPQSTDRG
 ;                                        BPDRUG,BPDRGCL,BPRESC,BPOPCL,BPRLNRL,
 ;                                        BPSORT,BPBEGDT,BPENDDT
 ; Output variable - BPSDATA -> Reset to 0 to show no actual data has been printed
 ;                           on the screen
 ;                   BPPAGE -> First set in BPSRPT0, report page number
 ;                   BPBLINE -> Controls whether to print a blank line
 ;                   
HDR(BPRTYPE,BPRPTNAM,BPPAGE) ;
 ;Display Excel Header
 I BPEXCEL D HDR^BPSRPT8A(BPRTYPE) Q
 ;
 ; Define BPPDATA - Tells whether data has been displayed for a screen
 S BPSDATA=0
 S BPBLINE=""
 S BPPAGE=$G(BPPAGE)+1
 W @IOF
 W "ECME "_BPRPTNAM_" "_$S(BPSUMDET=1:"SUMMARY",1:"DETAIL")_" REPORT"
 I (",2,10,")'[(","_BPRTYPE_",") D
 . W ?89,"Print Date: "_$G(BPNOW)_"  Page:",$J(BPPAGE,3)
 . W !,"DIVISION(S): ",$$GETDIVS^BPSRPT4(72,.BPPHARM)
 . W ?86,"Fill Locations: "_$S(BPMWC="A":"C,M,W",1:BPMWC)
 ;
 I (",2,")[BPRTYPE D
 . W ?87,"Print Date: "_$G(BPNOW)_"  Page:",$J(BPPAGE,3)
 . W !,"DIVISION(S): ",$$GETDIVS^BPSRPT4(72,.BPPHARM)
 . W ?84,"Fill Locations: "_$S(BPMWC="A":"C,M,W",1:BPMWC)
 ;
 I (",1,2,3,4,7,")[BPRTYPE D
 . W ?110,"Fill Type: "
 . I BPRTBCK=1 W "RT,BB,P2,RS" Q
 . F I=1:1:$L(BPRTBCK,",") W:I'=1 "," S RTBCKX=$P(BPRTBCK,",",I) W $S(RTBCKX=2:"RT",RTBCKX=3:"BB",RTBCKX=4:"P2",RTBCKX=5:"RS",1:"")
 ;
 I (",1,2,3,4,7,9,")[BPRTYPE W !,"Insurance: "_$S(BPINSINF=0:"ALL",1:"SELECTED")
 ;
 I (",5,6,8,")[BPRTYPE D
 . W ?110,"Fill type: "_$S(BPRTBCK=2:"RT",BPRTBCK=3:"BB",BPRTBCK=4:"P2",BPRTBCK=5:"RS",1:"RT,BB,P2,RS")
 . W !,"Insurance: "_$S(BPINSINF=0:"ALL",1:$$BPINS(BPINSINF))
 ;
 I (",7,")[BPRTYPE W ?44,"Close Reason: ",$S(BPCCRSN'=0:"SELECTED",1:"ALL")
 I (",4,")[BPRTYPE D
 . W ?44,$J($S(BPAUTREV=0:"ALL",1:"AUTO"),4)," Reversals"
 . W ?60,$J($S(BPACREJ=1:"REJECTED",BPACREJ=2:"ACCEPTED",1:"ALL"),8)," Returned Status"
 ;
 I (",5,6,8,")[BPRTYPE W ?87,"Drugs/Classes: "_$S(BPQSTDRG=2:$$DRGNAM^BPSRPT6(BPDRUG,30),BPQSTDRG=3:$E(BPDRGCL,1,30),1:"ALL")
 I (",1,2,3,4,7,9,")[BPRTYPE  W ?87,"Drugs/Classes: "_$S(BPQSTDRG'=1:"SELECTED",1:"ALL")
 ;
 I (",2,")[BPRTYPE D
 . W !,"Reject Code: ",$S(BPREJCD'=0:"SELECTED",1:"ALL")
 . W ?87,"Eligibility: " D
 . . I BPELIG1=0 W "CVA,TRI,VET" Q
 . . S (ABVELIG,LIST,N)="" F  S N=$O(BPELIG1(N)) Q:N=""  D
 . . . S ABVELIG=$S(N="C":"CVA",N="T":"TRI",N="V":"VET",1:""),LIST=LIST_$G(ABVELIG)_","
 . . W $E(LIST,1,$L(LIST)-1)
 . W ?113,"Open/Closed: ",$S(BPOPCL=1:"CLOSED",BPOPCL=2:"OPEN",1:"ALL")
 . W !,"Prescriber: ",$S(BPRESC'=0:"SELECTED",1:"ALL")
 . W ?91,"Patient: ",$S(BPQSTPAT'=0:"SELECTED",1:"ALL")
 ;
 I (",1,3,4,7,9,")[BPRTYPE D
 . W !,"Eligibility: " D
 . . I BPELIG1=0 W "CVA,TRI,VET" Q  ; ALL was selected
 . . S (ABVELIG,LIST,N)="" F  S N=$O(BPELIG1(N)) Q:N=""  D
 . . . S ABVELIG=$S(N="C":"CVA",N="T":"TRI",N="V":"VET",1:""),LIST=LIST_$G(ABVELIG)_","
 . . W $E(LIST,1,$L(LIST)-1)
 . W ?91,"Patient: ",$S(BPQSTPAT'=0:"SELECTED",1:"ALL")
 ;
 I (",9,")[BPRTYPE W !,"NON-BILLABLE STATUS: "_$S(BPNBSTS=0:"ALL",1:$$NBSTS(.BPNBSTS))
 ;
 I BPRTYPE=10 D
 . W ?87,"Print Date: "_$G(BPNOW)_" Page:",$J(BPPAGE,3)
 . W !,"DIVISION(S): ",$$GETDIVS^BPSRPT4(68,.BPPHARM)
 . ; Fill Location, Fill Type and Drugs/Classes default to 'ALL', user not prompted
 . W ?86,"Fill Locations: ALL"
 . W ?110,"Fill Type: ALL"
 . W !,"Insurance: "_$S(BPINSINF=0:"ALL",1:$$BPINS(BPINSINF))
 . W ?87,"Drugs/Classes: ALL"
 . W !,"Eligibility: " D
 . . I BPELIG1=0 W "CVA,TRI,VET" Q
 . . S (ABVELIG,LIST,N)="" F  S N=$O(BPELIG1(N)) Q:N=""  D
 . . . S ABVELIG=$S(N="C":"CVA",N="T":"TRI",N="V":"VET",1:""),LIST=LIST_$G(ABVELIG)_","
 . . W $E(LIST,1,$L(LIST)-1)
 . W ?93,"Patient: ",$S(BPQSTPAT'=0:"SELECTED",1:"ALL")
 . W !,"Status: "_$S(BPDUP=0:"ALL",1:BPDUP)
 ;
 W !,$S(BPRTYPE=5:"PRESCRIPTIONS",BPRLNRL=2:"RELEASED PRESCRIPTIONS",BPRLNRL=3:"PRESCRIPTIONS (NOT RELEASED)",1:"ALL PRESCRIPTIONS")
 W " BY "_$S(BPRTYPE=7:"CLOSE",1:"TRANSACTION")_" DATE: "
 W "From "_$$DATTIM^BPSRPT1(BPBEGDT)_" through "_$$DATTIM^BPSRPT1($P(BPENDDT,"."))
 ;
 I BPRTYPE=10 D
 . W !!,"Status Codes: S= Duplicate of Approved, D= Duplicate of Paid, Q= Duplicate of Capture"
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
 ;
ELIG(ELIG) ;
 ; Display multiple eligibilities
 ; Input:
 ;   ELIG - Array of multiple eligibilities
 ; Output
 ;   Text of eligibilities
 ;
 I $D(ELIG)=0 Q ""
 N N,LIST
 S LIST=""
 S N="" F  S N=$O(ELIG(N)) Q:N=""  D
 . S LIST=LIST_$G(ELIG(N))_","
 Q $E(LIST,1,$L(LIST)-1)
 ;
NBSTS(NBSTS) ;
 ; Display multiple non-billable statuses
 ; Input:
 ;   NBSTS - Array of multiple non-billable statuses
 ; Output
 ;   Text of non-billable statuses
 ;
 I $D(NBSTS)=0 Q ""
 N N,LIST
 S LIST=""
 S N="" F  S N=$O(NBSTS(N)) Q:N=""  D
 . S LIST=LIST_$G(NBSTS(N))_","
 Q $E(LIST,1,$L(LIST)-1)
