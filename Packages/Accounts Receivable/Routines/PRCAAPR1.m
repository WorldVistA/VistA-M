PRCAAPR1 ;WASH-ISC@ALTOONA,PA/RGY-PATIENT ACCOUNT PROFILE ;2/12/97  11:48 AM
V ;;4.5;Accounts Receivable;**34,45,108,143,141,206,192,218**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
HDR ;Head for Account profile
 S X="",$P(X,"=",23)="" W @IOF,!,X,"   A c c o u n t   P r o f i l e   ",X
HDR1 N DMC,IBRX,RSN,TOP4,TOP6,DPTFLG,ACCTNUM,RCCV
 S IBRX=0,DPTFLG=0
 ;
 ;Display new 'Statement Account Number" (Patch 206)
 I PRCADB["DPT(" S DPTFLG=1,ACCTNUM=$$ACCT(PRCADB)
 ;
 W !,$P(DEBT,"^",2) I DPTFLG!(PRCADB["VA(200,") S X=$S(PRCADB["DPT(":$P(^DPT(+PRCADB,0),"^",9),1:$P($G(^VA(200,+PRCADB,1)),"^",9)) W " (",$E(X,1,3),"-",$E(X,4,5),"-",$E(X,6,9),")"
 W ?53,"Statement Day: ",$S($$PST^RCAMFN01(+DEBT)>0:$$PST^RCAMFN01(+DEBT),1:"N/A")
 K Y S X("ADD")=$$DADD^RCAMADD(PRCADB)
 ;
 ;Display new 'Statement Account Number" (Patch 206)
 I DPTFLG W !,"Statement Account #: ",ACCTNUM,?52,"Last Statement: "
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
 I $O(^RCD(340,+DEBT,2,0)) D
 .S Y=0 F X=0:0 S X=$O(^RCD(340,+DEBT,2,X)) Q:'X  W:'Y ! W !,$G(^(X,0)) S Y=Y+1 W:Y=3&$O(^RCD(340,+DEBT,2,X)) "..." Q:Y=3
 .Q
 Q
HDR2 W !!,"#",?4,"Bill #",?16,"Est",?28,"Type",?37,"Paid",?46,"Prin",?55,"Int",?63,"Adm",?72,"Balance"
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
 I $Y+5>IOSL,COUNT D READ G:$D(OUT) Q2 D HDR,HDR2,BHDR
 S:STAT1'=99 COUNT=COUNT+1,^TMP("PRCAAPR",$J,"O",COUNT)=BILL S X=$S(STAT1=99:BILL,1:$G(^PRCA(430,BILL,0)))
 W !,$S(STAT1'=99:COUNT,1:"*"),?4,$P(X,"^") W:STAT1'=99 ?16,$$SLH^RCFN01($P(X,"^",10))
 W:STAT1'=99 ?28,$S($P(X,"^",2)=31:"TRIC PT",1:$E($P($G(^PRCA(430.2,$S($O(^PRCA(430.2,"AC",24,0))=$P(X,"^",2):+$P(X,"^",16),1:+$P(X,"^",2)),0)),"^"),1,7))  ; PRCA*4.5*192 changed CHMP PT to TRIC PT
 W:STAT1=99 ?28,"PAYMENT"
 S X=$S(STAT1=99:"^^^^^^"_^TMP("PRCAAPR",$J,"C",STAT1,BILL),1:$G(^PRCA(430,BILL,7))) W ?37 W:STAT1=99 "-" W $J($P(X,"^",7)+$P(X,"^",8)+$P(X,"^",9)+$P(X,"^",10)+$P(X,"^",11),0,2)
 W ?45 W:STAT1=99 " " W:STAT1'=99 $S($P(^PRCA(430,BILL,0),"^",2)=$O(^PRCA(430.2,"AC",33,0)):"-",1:" ")
 W $J($P(X,"^"),0,2),?55,$J($P(X,"^",2),1,2),?63,$J($P(X,"^",3),0,2),?69,$S(STAT1=99:"-",$P(^PRCA(430,BILL,0),"^",2)=$O(^PRCA(430.2,"AC",33,0)):"-",1:" ")
 W $S(STAT1=99:$J(^TMP("PRCAAPR",$J,"C",STAT1,BILL),0,2),1:$J($P(X,"^")+$P(X,"^",2)+$P(X,"^",3)+$P(X,"^",4)+$P(X,"^",5),9,2))
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
 N SITE,ACCT,ACCT1,LEN
 S DFN=+DFN
 S LEN=$L(DFN)-1
 S SITE=$$SITE^RCMSITE                          ;station number
 S ACCT=$$RJ^XLFSTR(DFN,13,0)                   ;add leading zeroes
 S ACCT1=SITE_"-"_$E(ACCT,1,$L(ACCT)-$L(DFN))   ;add hyphen
 S ACCT1=ACCT1_"-"_$E(ACCT,$L(ACCT)-LEN,99)     ;add hyphen
 S ACCT1=ACCT1_"-"_$E($P($P(DEBT,U,2),","),1,5) ;add last name
 Q ACCT1
