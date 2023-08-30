PRCAAPR1 ;WASH-ISC@ALTOONA,PA/RGY - PATIENT ACCOUNT PROFILE ;2/12/97  11:48 AM
 ;;4.5;Accounts Receivable;**34,45,108,143,141,206,192,218,276,275,284,303,301,315,350,343,404,405,406**;Mar 20, 1995;Build 5
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;PRCA*4.5*343 Ensure displayed phone number has format 111-222-3333
 ;
HDR ;Head for Account profile
 S X="",$P(X,"=",23)="" W @IOF,!,X,"   A c c o u n t   P r o f i l e   ",X
HDR1 N DMC,IBRX,RSN,TOP4,TOP6,DPTFLG,RCACCTN,RCCV ;PRCA*4.5*405
 S IBRX=0,DPTFLG=0
 ;
 ; PRCAAPR cleans up BILL, COUNT, DEBT, DTOUT, DIC, OUT, PRCADB, SEL, X
 ;Display new 'Statement Account Number" (Patch 206)
 I PRCADB["DPT(" S DPTFLG=1,RCACCTN=$$ACCT(PRCADB) ;PRCA*4.5*405
 ;
 W !,$P(DEBT,"^",2) I DPTFLG!(PRCADB["VA(200,") S X=$S(PRCADB["DPT(":$P(^DPT(+PRCADB,0),"^",9),1:$P($G(^VA(200,+PRCADB,1)),"^",9)) W " (",$E(X,1,3),"-",$E(X,4,5),"-",$E(X,6,9),")"
 W ?53,"Statement Day: ",$S($$PST^RCAMFN01(+DEBT)>0:$$PST^RCAMFN01(+DEBT),1:"N/A")
 K Y S X("ADD")=$$DADD^RCAMADD(PRCADB)
 ;
 ;Display new 'Statement Account Number" (Patch 206)
 I DPTFLG W !,"Statement Account #: ",RCACCTN,?52,"Last Statement: " ;PRCA*4.5*405
 E  W !?52,"Last Statement: "
 ;
 S Y=+$$LST^RCFN01(PRCADB,2)
 I Y>0 S Y("CCPC")=$$FPS^RCCPCFN(+DEBT) S:Y("CCPC") Y=+$P(Y("CCPC"),"^")
 W $S(Y=-1:"N/A",1:$$SLH^RCFN01(Y))
 W !,$P(X("ADD"),"^")
 W:+$G(Y("CCPC")) ?52,"Activity as of: ",$$SLH^RCFN01($$ASOF^RCCPCFN($P(Y("CCPC"),"^",2)))
 W:$P(X("ADD"),"^",2)]"" !,$P(X("ADD"),"^",2) W:$P(X("ADD"),"^",3)]"" !,$P(X("ADD"),"^",3)
 W ! W:$P(X("ADD"),"^",4)]"" $P(X("ADD"),"^",4),", ",$P(X("ADD"),"^",5),"  ",$S($P(X("ADD"),"^",6):$P(X("ADD"),"^",6),1:$P(X("ADD"),"^",8))
 W ?55,"Amount Owed: ",?69,$J(+$G(^TMP("PRCAAPR",$J,"C")),9,2)
 I $P(X("ADD"),"^",7)?10N D    ;PRCA*4.5*343
 . N PRCHPHN
 . S PRCAPHN=$P(X("ADD"),"^",7),PRCAPHN=$E(PRCAPHN,1,3)_"-"_$E(PRCAPHN,4,6)_"-"_$E(PRCAPHN,7,10)
 . S $P(X("ADD"),"^",7)=PRCAPHN
 W !,"Phone #: ",$S($P(X("ADD"),"^",7)]"":$P(X("ADD"),"^",7),1:"N/A")
 I PRCADB["DPT(" W ?51,"RX Copay Exempt: " S IBRX=$$RXST^IBARXEU(+PRCADB,DT) W $S($P(IBRX,U)=1:"YES",$P(IBRX,U)=0:"NO",1:"N/A")
 I PRCADB["DPT(" W !?57,"CV Status: " S RCCV=$$CVEDT^DGCV(+PRCADB,DT) W $S($P(RCCV,U,3)>0:"YES",1:"NO") I $P(RCCV,U,2) W !?52,"CV Status Ends: ",$$SLH^RCFN01($P(RCCV,U,2))
 ; *108 add exemption reason/dmc info
 I IBRX>0,($P(IBRX,U)=1) S DIC="^IBE(354.2,",DIC(0)="M",X=+$P(IBRX,"^",3) D ^DIC I Y>0 W !,?54,"(",$P(Y,"^",2),")"
 I $D(^RCD(340,"DMC",1,+DEBT)) S DMC=$G(^RCD(340,+DEBT,3)) D
 .I $P(DMC,"^",2) W !,"** Account forwarded to DMC: ",$$SLH^RCFN01($P(DMC,"^",2)),?50,"Total DMC Amount: ",?69,$J($P(DMC,"^",5),9,2)
 .I $P(DMC,"^",9)'="" W !,?49,"Lesser Amt to DMC: ",?69,$J($P(DMC,"^",9),9,2)
 .Q
 I $D(^RCD(340,"TOP",+DEBT)) S TOP4=$G(^RCD(340,+DEBT,4)),TOP6=$G(^(6)) D
 .I +TOP6 W !,"** Account forwarded to TOP: ",$$SLH^RCFN01($P(TOP6,"^")),?45,"Total TOP Amount: ",?65,$J($P(TOP4,"^",3),13,2)
 .I $P(TOP6,"^",6) W !,?45,"TOP HOLD DATE: ",$$SLH^RCFN01($P(TOP6,"^",6))
 .Q
 ; "Put Re-" if rerefer
 I $D(^RCD(340,"TCSP",+DEBT)) D
 .;PRCA*4.5*350
 .W !,"x Debt "_$S($$RRD^RCTCSPU(+DEBT):"Re-",1:"")_"Referred to Cross-Servicing",?45,"Total CS Debt: ",?65,$J($$TOTALB^RCTCSPU(+DEBT),13,2)
 .Q
 I $O(^RCD(340,+DEBT,2,0)) D
 .S Y=0 F X=0:0 S X=$O(^RCD(340,+DEBT,2,X)) Q:'X  W:'Y ! W !,$G(^(X,0)) S Y=Y+1 W:Y=3&$O(^RCD(340,+DEBT,2,X)) "..." Q:Y=3
 .Q
 ; PRCA*4.5*378/PRCA*4.5*404
 S RPIEN=+$O(^RCRP(340.5,"E",+DEBT,""),-1) I RPIEN D
 .S RPIENS=RPIEN_","
 .W !,"Repayment Plan: ",$$GET1^DIQ(340.5,RPIENS,.01)
 .W ?45,"Repayment Plan Status: ",$$GET1^DIQ(340.5,RPIENS,.07)
 .Q
 ;
 Q
 ; PRCA*4.5*276 - moved headers right to add EOB indicator to bill #, adjusted at tag BLN accordingly
 ; PRCA*4.5*275 - moved headers to line up with column changes
HDR2 W !!,"#",?7,"Bill #",?20,"Est",?31,"Type",?43,"Paid",?52,"Prin",?58,"Int",?64,"Adm",?72,"Balance"
 Q
DIS ;Display bill line items
 NEW STAT1
 I '$O(^TMP("PRCAAPR",$J,"C",0)) S X="",$P(X,"*",22)="" W !!,X,"  NO ACCOUNT INFORMATION AVAILABLE  ",X G Q1
 F STAT1=0:0 S STAT1=$O(^TMP("PRCAAPR",$J,"C",STAT1)) Q:'STAT1!$D(OUT)  D BHDR S BILL=0 F  S BILL=$O(^TMP("PRCAAPR",$J,"C",STAT1,BILL)) Q:BILL=""!$D(OUT)  D BLN
 I '$D(OUT) D READ
Q1 Q
BHDR ;Display status line
 S X=$S(+$P(^TMP("PRCAAPR",$J,"C",STAT1),"^",2)=99:"PAYMENTS",1:$P($G(^PRCA(430.3,+$O(^PRCA(430.3,"AC",+$P(^TMP("PRCAAPR",$J,"C",STAT1),"^",2),0)),0)),"^"))
 S Y=" "_X_" ("_$J(+^TMP("PRCAAPR",$J,"C",STAT1),0,2)_") " W ! F X=1:1:80-$L(Y)/2 W "-"
 W Y F X=1:1:IOM-$X-1 W "-"
 Q
BLN ;
 N PRCOUT,REJFLAG,CSCSTAT,DEBTOR,CSDATE1,CSDATE2,RCIND
 I $Y+5>IOSL,COUNT D READ G:$D(OUT) Q2 D HDR,HDR2,BHDR
 ; PRCA*4.5*276, attach EOB indicator '%' to bill # when applicable
 S PRCOUT=$$COMP3^PRCAAPR(BILL)
 I STAT1'=99,PRCOUT'="%" S PRCOUT=$$IBEEOBCK(BILL)
 ; PRCA*4.5*303 - add reject indicator to kbill if applicable ; #IA 6060
 S REJFLAG=0 S:STAT1'=99 REJFLAG=$$BILLREJ^IBJTU6($P($P($G(^PRCA(430,BILL,0)),"^"),"-",2))
 S:STAT1'=99 COUNT=COUNT+1,^TMP("PRCAAPR",$J,"O",COUNT)=BILL S X=$S(STAT1=99:BILL,1:$G(PRCOUT)_$S(REJFLAG:"c",1:"")_$G(^PRCA(430,BILL,0)))
 ; PRCA*4.5*303 - End
 ;
 ; PRCA*4.5*315: AR File #430 - set historical indicator set to "y" if an entry exists in the 
 ;     ORIGINAL DATE REFERRED TO TCSP (field #156) to CS bill number.  If an entry in the 
 ;     DATE REFERRED TO TCSP (field #151), then an "x" indicator displays on the bill,          
 ;     otherwise neither indicator.
 ;
 S CSDATE1=$$GET1^DIQ(430,BILL,"DATE BILL REFERRED TO TCSP","I")
 S CSDATE2=$$GET1^DIQ(430,BILL,"ORIGINAL DATE REFERRED TO TCSP","I")
 S RCIND=$S(CSDATE1'="":"x",CSDATE2'="":"y",1:"")
 ;W !,$S(STAT1'=99:COUNT,1:"*"),?4,$P(X,"^") W:STAT1'=99 ?20,$$SLH^RCFN01($P(X,"^",10))
 I RCIND]"" W !,$S(STAT1'=99:COUNT,1:"*"),?5,$P(RCIND_X,"^") W:STAT1'=99 ?20,$$SLH^RCFN01($P(X,"^",10))
 I RCIND="" W !,$S(STAT1'=99:COUNT,1:"*"),?6,$P(X,"^") W:STAT1'=99 ?20,$$SLH^RCFN01($P(X,"^",10))
 W:STAT1'=99 ?31,$S($P(X,"^",2)=31:"TRIC PT",1:$E($P($G(^PRCA(430.2,$S($O(^PRCA(430.2,"AC",24,0))=$P(X,"^",2):+$P(X,"^",16),1:+$P(X,"^",2)),0)),"^"),1,7))  ; PRCA*4.5*192 changed CHMP PT to TRIC PT
 W:STAT1=99 ?31,"PAYMENT"
 S X=$S(STAT1=99:"^^^^^^"_^TMP("PRCAAPR",$J,"C",STAT1,BILL),1:$G(^PRCA(430,BILL,7))) W ?39 W:STAT1=99 "-" W $J($P(X,"^",7)+$P(X,"^",8)+$P(X,"^",9)+$P(X,"^",10)+$P(X,"^",11),8,2)
 W ?48 W:STAT1=99 " " W:STAT1'=99 $S($P(^PRCA(430,BILL,0),"^",2)=$O(^PRCA(430.2,"AC",33,0)):"-",1:" ")
 W $J($P(X,"^"),7,2),?57,$J($P(X,"^",2),5,2),?63,$J($P(X,"^",3),5,2),?69,$S(STAT1=99:"-",$P(^PRCA(430,BILL,0),"^",2)=$O(^PRCA(430.2,"AC",33,0)):"-",1:" ")
 W $S(STAT1=99:$J(^TMP("PRCAAPR",$J,"C",STAT1,BILL),9,2),1:$J($P(X,"^")+$P(X,"^",2)+$P(X,"^",3)+$P(X,"^",4)+$P(X,"^",5),9,2))
 K ^TMP("PRCAAPR",$J,"C",STAT1,BILL) K:$O(^TMP("PRCAAPR",$J,"C",STAT1,""))="" ^TMP("PRCAAPR",$J,"C",STAT1)
Q2 Q
READ ;Read bill number
 W !!,"Select 1-",COUNT W:$O(^TMP("PRCAAPR",$J,"C","")) " or return to continue" R ": ",X:DTIME I X["^"!'$T S:'$T DTOUT=1 S OUT=1 G Q3
 I X["?" W !!,"To see detailed information for a bill number, enter the corresponding '#'",!,"next to the bill.  (Ex: 1 or 1,3)" G READ
 I X="",'$O(^TMP("PRCAAPR",$J,"C","")) S OUT=1 G Q3
 G:X="" Q3 S SEL=X
 F X=1:1:$L(SEL,",") S Y=$P(SEL,",",X) I Y'?1N.N!'$D(^TMP("PRCAAPR",$J,"O",+Y)) W *7," ??" G READ
 S OUT=1 F X=1:1:$L(SEL,",") S Y=$P(SEL,",",X) D EN1^PRCAATR($G(^TMP("PRCAAPR",$J,"O",+Y)))
Q3 Q
 ;
ACCT(DFN) ;Get account number. Join station with DFN (Patch 206) 
 ;PRCA*4.5*406 - Added Parameter comments
 ;Input Declared:  DFN - Patient IEN
 ;Input Undeclared:  DEBT - Debtor IEN^Debtor Name
 ;end PRCA*4.5*406
 ;
 N SITE,ACCT,ACCT1,LEN
 S DFN=+DFN
 ;I 'DFN S ACCT1="" Q ACCT1 ;PRCA*4.5*405  ; Removed PRCA*4.5*406
 S LEN=$L(DFN)-1
 S SITE=$$SITE^RCMSITE                          ;station number
 S ACCT=$$RJ^XLFSTR(DFN,13,0)                   ;add leading zeroes
 S ACCT1=SITE_"-"_$E(ACCT,1,$L(ACCT)-$L(DFN))   ;add hyphen
 S ACCT1=ACCT1_"-"_$E(ACCT,$L(ACCT)-LEN,99)     ;add hyphen
 S ACCT1=ACCT1_"-"_$E($P($P(DEBT,U,2),","),1,5) ;add last name
 Q ACCT1
 ;
 ; PRCA*4.5*276 -  Use Event Date to find an associated 3rd Party bill with an associated EEOB
IBEEOBCK(PRCAAR) ; Passed AR Bill
 ; Function will quit as soon as a 3rd party bill is located that has an associated EEOB
 ;
 ; Find 3rd Party Bills with an Event Date
 N PRCAREF,PRCAEEOB,PRCADT,DFN,DBTR,X1
 ; Get DFN
 S DBTR=+$P($G(^PRCA(430,PRCAAR,0)),U,9)
 S X1=$P($G(^RCD(340,DBTR,0)),U) I X1'["DPT" Q ""
 S DFN=+X1
 S PRCAEEOB=""
 ; Loop through Xref of ARbill (#430) to Action file (#350)
 I +$G(PRCAAR) S PRCAREF=0 F  S PRCAREF=$O(^IB("ABIL",$P($G(^PRCA(430,PRCAAR,0)),"^"),PRCAREF)) Q:'PRCAREF  D  Q:PRCAEEOB="%"
 . S PRCADT=$P($G(^IB(PRCAREF,0)),"^",17) ;Get event Date
 . I PRCADT S PRCAEEOB=$$TPEVDT(DFN,PRCADT) Q:PRCAEEOB="%"
 . I PRCADT S PRCAEEOB=$$TPOPV(DFN,PRCADT)
 ;
 Q PRCAEEOB
 ;
 ; PRCA*4.5*276 - Traverse all THIRD PARTY bills for a patient with a specific Event Date (399,.03)
TPEVDT(DFN,EVDT) ;
 ; Function will quit as soon as a 3rd party bill is located that has an associated EEOB
 ; PRCA*4.5*284 - Use the 399,"APDT" (by patient) index instead of the 399,"D" index for efficiency
 I '$G(DFN)!'$G(EVDT) Q ""
 N PRCAIFN,PRCAEEOB
 S PRCAEEOB="",PRCAIFN=""
 F  S PRCAIFN=$O(^DGCR(399,"APDT",DFN,PRCAIFN),-1) Q:'PRCAIFN  D  Q:PRCAEEOB="%"
 . I $D(^DGCR(399,"APDT",DFN,PRCAIFN,9999999-EVDT)) S PRCAEEOB=$$COMP3^PRCAAPR(PRCAIFN)
 Q PRCAEEOB
 ;
 ; PRCA*4.5*276 - Traverse all THIRD PARTY bills for a patient with any Opt Visit Dates same as Event Date (399,43)
TPOPV(DFN,EVDT) ;
 ; Function will quit as soon as a 3rd party bill is located that has an associated EEOB
 N PRCAIFN,PRCAEEOB
 S PRCAEEOB=""
 I +$G(DFN),+$G(EVDT) S PRCAIFN=0 F  S PRCAIFN=$O(^DGCR(399,"AOPV",DFN,EVDT,PRCAIFN)) Q:'PRCAIFN  D  Q:PRCAEEOB="%"
 . ; attach EOB indicator '%' to bill # when applicable
 . S PRCAEEOB=$$COMP3^PRCAAPR(PRCAIFN)
 Q PRCAEEOB
