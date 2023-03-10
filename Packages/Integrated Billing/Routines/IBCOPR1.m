IBCOPR1 ;WISC/RFJ,BOISE/WRL - print dollar amts for pre-registration ;05 May 97  8:34 AM
 ;;2.0;INTEGRATED BILLING;**75,345,528,664,668**;21-MAR-94;Build 28
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
EXCEL ; Excel print
 ;
 N CTR,IBIOM,SORT
 S IBIOM=IOM I IBIOM>200 S IBIOM=200
 ;
 ;Summary Report
 I IBCNFSUM D  G EXCELX
 . N CLASS,GLO,LVL,SOI
 . D HDR
 . I '$D(^TMP($J,"IBCOPR","S")) W !,"NO DATA FOR SELECTED CRITERIA" Q
 . F LVL=1,3,"T" D
 .. S CLASS=$S(LVL=1:"Inpt",LVL=3:"Outpt ",1:"")
 .. I LVL="T" W "Grand Total",!
 .. W "Source^"_CLASS_"Bill Cnt^"_CLASS_"Bill Amt^"_CLASS_"Pay Cnt^"_CLASS_"Pay Amt",!
 .. S SOI=""
 .. F  S SOI=$O(^TMP($J,"IBCOPR","S",LVL,SOI)) Q:'SOI  D
 ... S STR=$$GET1^DIQ(355.12,SOI_",",.01)_U_+$G(^TMP($J,"IBCOPR","S",LVL,SOI,"BILLCNT"))_U_+$G(^TMP($J,"IBCOPR","S",LVL,SOI,"BILLAMT"))
 ... S STR=STR_U_+$G(^TMP($J,"IBCOPR","S",LVL,SOI,"CLMCNT"))_U_+$G(^TMP($J,"IBCOPR","S",LVL,SOI,"CLMAMT"))
 ... W STR,!
 .. S GLO=$S(LVL="T":$NA(^TMP($J,"IBCOPR","T")),1:$NA(^TMP($J,"IBCOPR","T",LVL)))
 .. S STR=$S(LVL=5:"Grand ",1:"")_"Total "_CLASS_U_+$G(@GLO@("BILLCNT"))_U_+$G(@GLO@("BILLAMT"))
 .. S STR=STR_U_+$G(@GLO@("CLMCNT"))_U_+$G(@GLO@("CLMAMT"))
 .. W STR,!!
 . Q
 ;
 ;Detail Report
 D HDR
 I '$D(^TMP($J,"IBCOPR","T")) W !,"NO DATA FOR SELECTED CRITERIA" G EXCELX
 F LVL=1,3 D
 . S SORT="" F  S SORT=$O(^TMP($J,"IBCOPR","D",LVL,SORT)) Q:SORT=""  D
 .. S CTR=0
 .. F  S CTR=$O(^TMP($J,"IBCOPR","D",LVL,SORT,CTR)) Q:'CTR  D
 ... W ^TMP($J,"IBCOPR","D",LVL,SORT,CTR),!
 . W "* Next to bill indicates bill is canceled and not used in totals"
 . W !,"F=Full Payment P=Partial Payment N=No Payment Received to date",!
 . W !,"TOTAL ",$S(LVL=3:"OUTPATIENT",1:"INPATIENT")," BILLS COUNT:",U
 . W $FN($G(^TMP($J,"IBCOPR","T",LVL,"BILLCNT")),","),U,"AMOUNT: ",$FN($G(^TMP($J,"IBCOPR","T",LVL,"BILLAMT")),",",2),!
 . W "TOTAL ",$S(LVL=3:"OUTPATIENT",1:"INPATIENT")," COLLECTED COUNT:",U
 . W $FN($G(^TMP($J,"IBCOPR","T",LVL,"CLMCNT")),","),U,"AMOUNT: ",$FN($G(^TMP($J,"IBCOPR","T",LVL,"CLMAMT")),",",2),!
 W !!,"Total Bill Ct^Total Bill Amt^Total Pymt Count^Total Pymt Amt",!
 W $FN($G(^TMP($J,"IBCOPR","T","BILLCNT")),","),U,$FN($G(^TMP($J,"IBCOPR","T","BILLAMT")),",",2),"^"
 W $FN($G(^TMP($J,"IBCOPR","T","CLMCNT")),","),U,$FN($G(^TMP($J,"IBCOPR","T",LVL,"CLMAMT")),",",2),!
 ;
EXCELX ;
 Q
 ;
REPORT ; Print the report to the selected device.
 ;
 N CTR,DATA,IBIOM,LINE,SORT,TAB,Y
 ;
 S IBIOM=IOM I IBIOM>132 S IBIOM=132
 ;
 ; Summary Report
 I IBCNFSUM D  G REPORTX
 . N SOI
 . S TAB(1)=(IBIOM*.2),TAB(2)=(IBIOM*.4),TAB(3)=(IBIOM*.6),TAB(4)=(IBIOM*.8),$P(LINE,"-",IBIOM)=""
 . W @IOF D HDR
 . I '$D(^TMP($J,"IBCOPR","S")) W !,"NO DATA FOR SELECTED CRITERIA" Q
 . F LVL=1,3,"T" D  I IBEX Q
 .. S CLASS=$S(LVL=3:"Outpt ",LVL=1:" Inpt ",1:"      ")
 .. I LVL="T" W "Grand Total",!
 .. W "Source",?TAB(1),CLASS,"Bill Cnt",?TAB(2),CLASS,"Bill Amt",?TAB(3),CLASS,"Pay Cnt",?TAB(4),CLASS,"Pay Amt",!
 .. S SOI=""
 .. S GLO=$NA(^TMP($J,"IBCOPR","S",LVL))
 .. F  S SOI=$O(@GLO@(SOI)) Q:'SOI  D  I IBEX Q
 ... D PAGE Q:IBEX  I $Y<6 D
 .... I LVL="T" W "Grand Total",!
 .... W "Source",?TAB(1),CLASS,"Bill Cnt",?TAB(2),CLASS,"Bill Amt",?TAB(3),CLASS,"Pay Cnt",?TAB(4),CLASS,"Pay Amt",!
 ... W $E($$GET1^DIQ(355.12,SOI_",",.01),1,TAB(1))
 ... W ?TAB(1),$J($FN(+$G(@GLO@(SOI,"BILLCNT")),","),10),?TAB(2),$J($FN(+$G(@GLO@(SOI,"BILLAMT")),",",2),14)
 ... W ?TAB(3),$J($FN(+$G(@GLO@(SOI,"CLMCNT")),","),9),?TAB(4),$J($FN(+$G(@GLO@(SOI,"CLMAMT")),",",2),13),!
 .. I IBEX Q
 .. S GLO=$S(LVL="T":$NA(^TMP($J,"IBCOPR","T")),1:$NA(^TMP($J,"IBCOPR","T",LVL)))
 .. W $S(LVL="T":"Grand ",LVL=3:"Outpt ",1:"Inpt "),"Total"
 .. W ?TAB(1),$J($FN(+$G(@GLO@("BILLCNT")),","),10),?TAB(2),$J($FN(+$G(@GLO@("BILLAMT")),",",2),14)
 .. W ?TAB(3),$J($FN(+$G(@GLO@("CLMCNT")),","),9),?TAB(4),$J($FN(+$G(@GLO@("CLMAMT")),",",2),13),!
 .. W !!
 ;
 ; Detail Report
 S TAB(1)=18,TAB(2)=24,TAB(3)=36,TAB(4)=58,TAB(5)=70,TAB(6)=84,TAB(7)=96,TAB(8)=110,TAB(9)=116,$P(LINE,"-",IBIOM)=""
 I '$D(^TMP($J,"IBCOPR","D")) D HDR W !,"NO DATA FOR SELECTED CRITERIA" G REPORTX
 F LVL=1,3 D  I IBEX Q
 . D HDR
 . S SORT="" F  S SORT=$O(^TMP($J,"IBCOPR","D",LVL,SORT)) Q:SORT=""  D  I IBEX Q
 .. S CTR=0
 .. F  S CTR=$O(^TMP($J,"IBCOPR","D",LVL,SORT,CTR)) Q:'CTR  D  I IBEX Q
 ... D PAGE Q:IBEX
 ... S DATA=^TMP($J,"IBCOPR","D",LVL,SORT,CTR)
 ... W $$FO^IBCNEUT1($P(DATA,U),16,"L")              ;Patient Name
 ... W ?TAB(1),$$FO^IBCNEUT1($P(DATA,U,2),4,"L")     ;SSN
 ... W ?TAB(2),$P(DATA,U,3)                          ;Bill Number
 ... W ?TAB(3),$$FO^IBCNEUT1($P(DATA,U,4),21,"L")    ;Insurance Co
 ... W ?TAB(4),$J($FN($P(DATA,U,5),",",2),10)        ;Billed Amount
 ... W ?TAB(5),$$FMTE^XLFDT($P(DATA,U,6))            ;Bill Date
 ... W ?TAB(6),$J($FN($P(DATA,U,7),",",2),10)        ;Collected Amount
 ... W ?TAB(7),$$FMTE^XLFDT($P(DATA,U,8))            ;Collected Date
 ... W ?TAB(8),$J($P(DATA,U,9),3)                    ;F/P/N
 ... W ?TAB(9),$E($P(DATA,U,10),1,(IBIOM-TAB(9)))      ;Source of Information
 ... W !
 . I IBEX Q
 . D PAGE Q:IBEX
 . W "* Next to bill indicates bill is canceled and not used in totals"
 . W !,"F=Full Payment P=Partial Payment" I DATETYPE="B" W " N=No Payments Received"
 . W !,LINE,!
 . S DATA=$G(^TMP($J,"IBCOPR","S",LVL))
 . W ?5,"TOTAL ",$S(LVL=3:"OUTPATIENT",1:"INPATIENT")," BILLS COUNT:",$J($FN($G(^TMP($J,"IBCOPR","T",LVL,"BILLCNT")),","),14)
 . W ?65,"AMOUNT: ",$J($FN($G(^TMP($J,"IBCOPR","T",LVL,"BILLAMT")),",",2),15),!
 . W ?5,"TOTAL ",$S(LVL=3:"OUTPATIENT",1:"INPATIENT")," COLLECTED COUNT:",$J($FN($G(^TMP($J,"IBCOPR","T",LVL,"CLMCNT")),","),10)
 . W ?65,"AMOUNT: ",$J($FN($G(^TMP($J,"IBCOPR","T",LVL,"CLMAMT")),",",2),15),!
 . I LVL=1,($E(IOST,1,2)="C-") D PAUSE^VALM1 S:'Y IBEX=1
 I IBEX G REPORTX
 K LVL D PAGE I IBEX G REPORTX
 W !,"Total Bill Ct",?30,"Total Bill Amt",?65,"Total Pymt Count",?95,"Total Pymt Amt",!
 W $J($FN(+$G(^TMP($J,"IBCOPR","T","BILLCNT")),","),10),?30,$J($FN(+$G(^TMP($J,"IBCOPR","T","BILLAMT")),",",2),14)
 W ?65,$J(+$G(^TMP($J,"IBCOPR","T","CLMCNT")),10),?95,$J($FN(+$G(^TMP($J,"IBCOPR","T","CLMAMT")),",",2),14),!
 ;
REPORTX ; Report Exit
 Q
 ;
 ;
PAGE ;
 I $Y+5>IOSL D
 . I 'IBCNFSUM D
 .. W "* Next to bill indicates bill is canceled and not used in totals"
 .. W !,"F=Full Payment P=Partial Payment" I DATETYPE="B" W " N=No Payments Received"
 . I $E(IOST,1,2)="C-" D PAUSE^VALM1 S:'Y IBEX=1 I IBEX Q
 . D HDR
 Q
 ;
HDR ;Print Header
 ;
 N HSTR,LEN
 W @IOF
 N STR
 S STR=RDATE I IBCNOUT'="E" S PAGE=$G(PAGE)+1,STR=STR_"   PAGE "_PAGE
 W "SOURCE OF INFORMATION REPORT",?IBIOM-($L(STR)+1),STR,!
 S STR="TYPE: "_$S(IBCNFSUM:"SUMMARY",1:"DETAILED")
 W "FOR THE ",$S(DATETYPE="B":"BILLED ",1:"COLLECTED "),"DATE RANGE: ",$$FMTE^XLFDT(DATESTRT)," TO ",$$FMTE^XLFDT(DATEEND),?IBIOM-($L(STR)+1),STR,!
 W "SOURCE OF INFORMATION: ",$S($G(IBCNESOI)="A":"ALL",$G(IBCNESOI)>1:"SELECTED",1:$$GET1^DIQ(355.12,$O(IBCNESOI(""))_",",.01)),!
 I IBCNFSUM D  G HDRQ
 . I (IBCNOUT="E") W ! Q
 . W LINE,!!
 W "SORT: ",SORTBY,!!
 I '$D(LVL) Q
HDR2 ;SUB-HEADER
 S HSTR=$S(LVL=1:" Inpatient Bills Entered ",LVL=3:" Outpatient Bills Entered ",1:"")
 I IBCNOUT="R" S LEN=$L(HSTR),STR="" S:(LEN#2) LEN=LEN+1 S LEN=((IBIOM-$L(HSTR))/2+1),$P(STR,".",LEN)="",HSTR=STR_HSTR_STR
 W HSTR,!
 I IBCNOUT="R" D  G HDRQ
 . W "Patient Name",?TAB(1),"SSN",?TAB(2),"Bill Num",?TAB(3),"Insurance Company",?(TAB(4)+2),"Bill Amt",?TAB(5),"Bill Date",?(TAB(6)+2),"Coll Amt",?TAB(7),"Coll Date",?TAB(8),"F/P",$S(DATETYPE="B":"/N",1:""),?TAB(9),"Source",!!
 W !,"Patient Name^SSN^Bill Num^Insurance Company^Bill Amt^Bill Date^Coll Amt^Coll Date^F/P",$S(DATETYPE="B":"/N",1:""),"^Source",!
 ;
HDRQ ;
 Q
 ;
