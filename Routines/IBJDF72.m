IBJDF72 ;ALB/MR - REPAYMENT PLAN REPORT (PRINT) ;16-AUG-00
 ;;2.0;INTEGRATED BILLING;**123,159**;21-MAR-94
 ;
EN ; - Print the Repayment Plan Report
 ; 
 S IBQ=0 D NOW^%DTC S IBRUN=$$DAT2^IBOUTL(%)
 ;
 I '$G(IBXTRACT),'$D(^TMP("IBJDF7",$J)) D  G ENQ
 . I '$G(IBEXCEL) D @($S(IBRPT="D":"HDRD",1:"HDRS"))
 . W !!,"There are no Repayment Plan for the parameters selected."
 ;
 ; - Summary report was selected
 I IBRPT="S" G SUM
 ;
 I '$G(IBEXCEL) S IBPAG=0 D HDRD G:IBQ ENQ
 ;
 ; - Print the header line for the Excel spreadsheet
 I $G(IBEXCEL) D PHDL
 ;
 S (IBKEY,IBDFN,IBILL)=""
 F  S IBKEY=$O(^TMP("IBJDF7",$J,IBKEY)) Q:IBKEY=""  D  Q:IBQ
 . F  S IBDFN=$O(^TMP("IBJDF7",$J,IBKEY,IBDFN)) Q:IBDFN=""  D  Q:IBQ
 . . S IBPAT=$G(^TMP("IBJDF7",$J,IBKEY,IBDFN)),IBFLG=1
 . . S IBCNT=0,IBTOT=""
 . . ; 
 . . ; - Page Break
 . . I '$G(IBEXCEL),$Y>(IOSL-7) D PAUSE Q:IBQ  D HDRD Q:IBQ
 . . ;
 . . ; - Debtor Name (* - if in default) and SSN
 . . I '$G(IBEXCEL) D WPAT
 . . ;
 . . F  S IBILL=$O(^TMP("IBJDF7",$J,IBKEY,IBDFN,IBILL)) Q:IBILL=""  D  Q:IBQ
 . . . S IBRP=$G(^TMP("IBJDF7",$J,IBKEY,IBDFN,IBILL))
 . . . ;
 . . . ; - Print the data to an Excel data format
 . . . I $G(IBEXCEL) D EXCEL Q
 . . . ;
 . . . ; - Page Break
 . . . I $Y>(IOSL-6) D PAUSE Q:IBQ  D HDRD,WPAT Q:IBQ
 . . . ;
 . . . ; - Bill, Start Date, Balance, Mo.Pymt and Due Day
 . . . W ?51,IBILL
 . . . I $P(IBRP,"^")="" D  Q
 . . . . W ?64,"->REPAYMENT PLAN INCOMPLETE. PLEASE CHECK!",!
 . . . W ?64,$$DAT1^IBOUTL($P(IBRP,"^"))
 . . . W ?74,$J($FN($P(IBRP,"^",9),",",2),10)
 . . . W ?86,$J($FN($P(IBRP,"^",3),",",2),10)
 . . . W ?98,$J($P(IBRP,"^",4),2)
 . . . ;
 . . . ; - Last Payment (Date and Amount)
 . . . I $P(IBRP,"^",5)'="" D
 . . . . W ?102,$$DAT1^IBOUTL($P(IBRP,"^",5))
 . . . . W ?112,$J($FN($P(IBRP,"^",6),",",2),10)
 . . . ;
 . . . ; - Number of Payments - Due and Defaulted
 . . . W ?124,$J($P(IBRP,"^",7),3),?128,$J($P(IBRP,"^",8),3),!
 . . . ;
 . . . ; - Date of Death (if any)
 . . . I IBFLG,$P(IBPAT,"^",3) D
 . . . . W $$DAT1^IBOUTL($P(IBPAT,"^",3)) S IBFLG=0
 . . . ;
 . . . ; - Will be used to print TOTAL line by Debtor
 . . . S IBCNT=IBCNT+1
 . . . F I=6,9 S $P(IBTOT,"^",I)=$P(IBTOT,"^",I)+$P(IBRP,"^",I)
 . . ;
 . . ; - Quits if the entry was printed to Excel file
 . . I $G(IBEXCEL) Q
 . . ;
 . . ; - Prints Total by Debtor
 . . I 'IBQ,IBTPT,IBCNT>1 D PTOT
 ;
DETQ G ENQ:IBQ!$G(IBEXCEL) D PAUSE G ENQ:IBQ
 ;
SUM ; - Print Summary Report
 ; 
 ; Sets IB with totals (Current + Defaulted)
 F I=9,11,12 S IB(I)=IB(I-8)+IB(I-4)
 ;
 ; Formats the amount fields to a $ format (9,999,999.99)
 F I=3,7,11 S IB(I)=$FN(IB(I),"",2)
 ;
 ; - Extract summary data 
 I $G(IBXTRACT) D E^IBJDE(38,0) G ENQ
 ;
 D HDRS
 I $Y>(IOSL-12) D PAUSE G ENQ:IBQ D HDRS G ENQ:IBQ
 I IBPLN'="D" D PSUM("C") W !!
 I $Y>(IOSL-11) D PAUSE G ENQ:IBQ D HDRS G ENQ:IBQ
 I IBPLN'="C" D PSUM("D") W !!
 I $Y>(IOSL-11) D PAUSE G ENQ:IBQ D HDRS G ENQ:IBQ
 D PSUM("T") D PAUSE
 ;
ENQ K IBCNT,IBFLG,IBDFN,IBILL,IBKEY,IBPAT,IBPAG,IBQ,IBRUN,IBRP,IBTOT,%
 Q
 ;
WPAT ; - Write the Debtor name & SSN
 W !,$P(IBPAT,"^"),$S($P(IBPAT,"^",4):" *",1:"")
 W ?38,$P(IBPAT,"^",2)
 Q
 ;
EXCEL ; - Prints the data to an Excel file format
 ;
 W !,$P(IBPAT,"^",1)_"^"_$TR($P(IBPAT,"^",2),"-")_"^"
 W $S($P(IBRP,"^",8):"D",1:"C")_"^"
 W $S($P(IBPAT,"^",3):$$DT($P(IBPAT,"^",3)),1:"")_"^"
 W IBILL_"^"_$$DT($P(IBRP,"^"))_"^"_$P(IBRP,"^",3)_"^"
 W $E($P(IBRP,"^",4)+100,2,3)_"^"_$$DT($P(IBRP,"^",5))_"^"
 W $P(IBRP,"^",6)_"^"_$P(IBRP,"^",2)_"^"_$P(IBRP,"^",7)_"^"
 W $P(IBRP,"^",8)
 Q
 ;
HDRD ; - Prints the Detailed Report Header
 I $E(IOST,1,2)="C-"!$G(IBPAG) W @IOF,*13
 S IBPAG=$G(IBPAG)+1 W "Repayment Plan Report"
 W ?60,"Run  Date: ",IBRUN,?123,"Page: ",$J(IBPAG,3)
 S X="" S:IBPLN'="D" X="CURRENT " S:IBPLN="B" X=X_"AND "
 S:IBPLN'="C" X=X_"DEFAULTED " S X=X_"REPAYMENT PLAN / "
 S:IBMCR="N" X=X_"NON-" S X=X_"MCCR RECEIVABLES ONLY / "
 S X=X_"BY DEBTOR "_$S(IBSN="N":"NAME",1:"LAST 4 DIGITS OF SSN")
 S X=X_" ("_$S($G(IBSNA)="ALL":"ALL",1:"From "_$S(IBSNF="":"FIRST",1:IBSNF)_" to "_$S(IBSNL="zzzzz":"LAST",1:IBSNL))_") / "
 S X=X_"'*' AFTER THE NAME = DEBTOR HAS DEFAULTED ON A REPAYMENT PLAN"
 F I=1:1 W !,$E(X,1,132) S X=$E(X,133,999) I X="" Q
 ;
 W !!,"Debtor Name",?64,"Start",?86,"Monthly",?97,"Due"
 W ?104,"Last Payment",?124,"#Paymts"
 W !,"Date of Death",?38,"SSN",?51,"Bill",?64,"Date",?74,"Balance"
 W ?86,"Payment",?97,"Day",?102,"Date",?112,"Amount",?124,"Due",?128,"Def"
 W !,$$DASH(IOM,0) S IBQ=$$STOP^IBOUTL("Repayment Plan Report")
 Q
 ;
HDRS ; - Prints the Summary Report Header
 ; 
 N X
 I $E(IOST,1,2)="C-"!$G(IBPAG) W @IOF,*13
 S IBPAG=$G(IBPAG)+1 W ?71,"Page: ",$J(IBPAG,3)
 W !?26,"SUMMARY REPAYMENT PLAN REPORT"
 S X="MCCR RECEIVABLES" S:IBMCR="N" X="NON-"_X
 S X=X_" / "_$S($G(IBSNA)="ALL":IBSNA_" ",1:"")_"DEBTORS"
 I IBSNA'="ALL" S X=X_" From "_$S(IBSNF="":"FIRST",1:IBSNF)_" to "_$S(IBSNL="zzzzz":"LAST",1:IBSNL)
 S X="("_X_")"
 W !?(80-$L(X)/2+1),X,!!?(80-$L(IBRUN)/2+1),IBRUN
 S X="",$P(X,"=",$L(IBRUN)+1)="" W !?(80-$L(IBRUN)/2+1),X
 W !
 Q
 ;
PHDL ; - Print the header line for the Excel spreadsheet
 N X
 S X="Debtor^SSN^Plan Type^Death Dt^Bill #^Start Dt^Mo.Pymt Amt^"
 S X=X_"Due Day^Lst Pymt Dt^Lst Pymt Amt^Curr.Bal.^Pymts Due^Pymts Def."
 W !,X
 Q
 ;
PTOT ; - Prints the TOTAL line for the Debtor
 ; 
 N I,X
 S $P(X,"-",11)=""
 W ?74,X,?112,X
 W !?74,$J($FN($P(IBTOT,"^",9),"",2),10)
 W ?112,$J($FN($P(IBTOT,"^",6),"",2),10),!
 Q
 ;
PSUM(X) ; Prints the Summary Information
 ; Input: X=Type of information: C-Current, D-Defaulted or T-Total
 ; 
 N IBIX
 W !?15,$S(X="C":"CURRENT",X="D":"DEFAULTED",1:"TOTAL")
 W " REPAYMENT PLANS" W:X="T" " (CURRENT + DEFAULTED)"
 ;
 S IBIX=$S(X="D":1,X="C":5,1:9)
 ;
 W !?15,"Number of Bills:",?47,$J(+IB(IBIX),10)
 W:X'="T" $$PER(IB(IBIX),+IB(9))
 W !?15,"Number of Debtors" W:X="T" " (unique)" W ":",?47,$J(IB(IBIX+1),10)
 W:X'="T" $$PER(IB(IBIX+1),IB(10))
 W !?15,"Outstanding balance of Bills:",?47,$J(IB(IBIX+2),10)
 W:X'="T" $$PER(IB(IBIX+2),IB(11))
 W !?15,"Number of payments due:",?47,$J(IB(IBIX+3),10)
 W:X'="T" $$PER(IB(IBIX+3),IB(12))
 Q
 ;
PER(X,T) ; Calculates the percentage
 ; Input: T=Total Amount, X=Amount
 ; Output: Percentage of X from T - Format: (99.99%)
 ;
 I 'T Q ""
 Q $J(" ("_($TR(X,",","")/$TR(T,",","")*10000+.5\1/100)_"%)",10)
 ;
DASH(X,Y) ; - Return a dashed line.
 ; Input: X=Number of Columns (80 or 132), Y=Char to be printed
 ; 
 Q $TR($J("",X)," ",$S(Y:"-",1:"="))
 ;
PAUSE ; - Page break.
 ; 
 I $E(IOST,1,2)'="C-" Q
 N IBX,DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 F IBX=$Y:1:(IOSL-3) W !
 S DIR(0)="E" D ^DIR S:$D(DIRUT)!($D(DUOUT)) IBQ=1
 Q
 ;
DT(X) ; - Return date.
 ;    Input: X=Date in Fileman format
 ;   Output: Z=Date in MMDDYY format
 ;
 Q $E(X,4,7)_$E(X,2,3)
