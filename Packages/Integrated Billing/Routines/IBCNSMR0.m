IBCNSMR0 ;ALB/AAS - MEDICARE BILLS ; 02-SEPT-97
 ;;2.0; INTEGRATED BILLING ;**92**; 21-MAR-94
 ;
% G RPRT^IBCNSMRA
 Q
 ;
PRINT ;
 N IBQUIT,IBPAG,IBHDT
 S IBQUIT=0,IBPAG=0,IBHDT=$$HTE^XLFDT($H)
 I IBPRNT="D" U IO D HDR(0),TOTALS Q:IBQUIT  D HDR(1),SORT Q:IBQUIT  D HDR(2),DETAIL Q:IBQUIT
 I IBPRNT="S" U IO D HDR(0),TOTALS Q:IBQUIT  D HDR(1),SORT
 I IBSNDRPT D BULL^IBCNSMR1
 Q
 ;
TOTALS ; -- prepare report
 W !!,"  Bills Found for Selected Ins. Co.: "_$J(+$G(CNT),6)_$$FORMAT(+$G(CNT(0)),"2$",17)_$J(+$G(CNT(1)),6)_$$FORMAT(+$G(CNT(2)),"2$",14)
 W !,"        Bills for Outpatient Visits: "_$J(+$G(CNT("OP")),6)_$$FORMAT(+$G(CNT("OP",0)),"2$",17)_$J(+$G(CNT("OP",1)),6)_$$FORMAT(+$G(CNT("OP",2)),"2$",14)
 W !,"         Bills for Inpatient Visits: "_$J(+$G(CNT("IN")),6)_$$FORMAT(+$G(CNT("IN",0)),"2$",17)_$J(+$G(CNT("IN",1)),6)_$$FORMAT(+$G(CNT("IN",2)),"2$",14)
 ;
 W !!,"     Subtotals by Selected Ins. Co.: "
 S IBNM=""
 F  S IBNM=$O(CNT(3,IBNM)) Q:IBNM=""  D
 .W !,?(35-$L(IBNM)),IBNM_": "_$J(+$G(CNT(3,IBNM)),6)_$$FORMAT(+$G(CNT(3,IBNM,0)),"2$",17)_$J(+$G(CNT(3,IBNM,1)),6)_$$FORMAT(+$G(CNT(3,IBNM,2)),"2$",14)
 ;
 W !!,"Bills with Procedures and Diagnosis: "_$J(+$G(CNT("B")),6)_$$FORMAT(+$G(CNT("B",0)),"2$",17)_$J(+$G(CNT("B",1)),6)_$$FORMAT(+$G(CNT("B",2)),"2$",14)
 W !,"    Bills with Diagnosis Codes Only: "_$J(+$G(CNT("D")),6)_$$FORMAT(+$G(CNT("D",0)),"2$",17)_$J(+$G(CNT("D",1)),6)_$$FORMAT(+$G(CNT("D",2)),"2$",14)
 W !,"    Bills with Procedure Codes Only: "_$J(+$G(CNT("P")),6)_$$FORMAT(+$G(CNT("P",0)),"2$",17)_$J(+$G(CNT("P",1)),6)_$$FORMAT(+$G(CNT("P",2)),"2$",14)
 W !," Bills with No Proc. or Diag. Codes: "_$J(+$G(CNT("N")),6)_$$FORMAT(+$G(CNT("N",0)),"2$",17)_$J(+$G(CNT("N",1)),6)_$$FORMAT(+$G(CNT("N",2)),"2$",14)
 ;
 W !!,"   Bills Canceled before Completion: "_$J(+$G(CNT("C")),6)_$$FORMAT(+$G(CNT("C",0)),"2$",17)_$J(+$G(CNT("C",1)),6)_$$FORMAT(+$G(CNT("C",2)),"2$",14)
 W !,"                Bills Never Printed: "_$J(+$G(CNT("F")),6)_$$FORMAT(+$G(CNT("F",0)),"2$",17)_$J(+$G(CNT("F",1)),6)_$$FORMAT(+$G(CNT("F",2)),"2$",14)
 W !,"         Bills with wrong Rate Type: "_$J(+$G(CNT("R")),6)_$$FORMAT(+$G(CNT("R",0)),"2$",17)_$J(+$G(CNT("R",1)),6)_$$FORMAT(+$G(CNT("R",2)),"2$",14)
 W !," Bills with wrong Who's Responsible: "_$J(+$G(CNT("W")),6)_$$FORMAT(+$G(CNT("W",0)),"2$",17)_$J(+$G(CNT("W",1)),6)_$$FORMAT(+$G(CNT("W",2)),"2$",14)
 W !," Bills w/ wrong Bill Classification: "_$J(+$G(CNT("T")),6)_$$FORMAT(+$G(CNT("T",0)),"2$",17)_$J(+$G(CNT("T",1)),6)_$$FORMAT(+$G(CNT("T",2)),"2$",14)
 W !,"            Bills for Prescriptions: "_$J(+$G(CNT("X")),6)_$$FORMAT(+$G(CNT("X",0)),"2$",17)_$J(+$G(CNT("X",1)),6)_$$FORMAT(+$G(CNT("X",2)),"2$",14)
 W !,"              Bills for Prosthetics: "_$J(+$G(CNT("Z")),6)_$$FORMAT(+$G(CNT("Z",0)),"2$",17)_$J(+$G(CNT("Z",1)),6)_$$FORMAT(+$G(CNT("Z",2)),"2$",14)
 ;W !,"      Bills with Patients Not Alive: "_$J(+$G(CNT("A")),6)_$$FORMAT(+$G(CNT("A",0)),"2$",17)_$J(+$G(CNT("A",1)),6)_$$FORMAT(+$G(CNT("A",2)),"2$",14)
 ;
 W !!,"     Bills Meeting Criteria for MRA: "_$J(+$G(CNT("M")),6)_$$FORMAT(+$G(CNT("M",0)),"2$",17)_$J(+$G(CNT("M",1)),6)_$$FORMAT(+$G(CNT("M",2)),"2$",14)
 W !,"  Outpatient Bills Meeting Criteria: "_$J(+$G(CNT("M","OP")),6)_$$FORMAT(+$G(CNT("M","OP",0)),"2$",17)_$J(+$G(CNT("M","OP",1)),6)_$$FORMAT(+$G(CNT("M","OP",2)),"2$",14)
 W !,"   Inpatient Bills Meeting Criteria: "_$J(+$G(CNT("M","IN")),6)_$$FORMAT(+$G(CNT("M","IN",0)),"2$",17)_$J(+$G(CNT("M","IN",1)),6)_$$FORMAT(+$G(CNT("M","IN",2)),"2$",14)
 W !," Bill Meeting Criteria and Referred: "_$J(+$G(CNT("M",4)),6)_$$FORMAT(+$G(CNT("M",5)),"2$",17)_$J(+$G(CNT("M",6)),6)_$$FORMAT(+$G(CNT("M",7)),"2$",14)
 ;
 Q
 ;
SORT ; -- Run through list by insurance company
 N I,J,K,L,M,N,P,X,Y,Z,ZZ
 ;
 I '$D(^TMP("IB-MRA-CNT",$J)) W !!,"There are no summary records to print.",! G SORTQ
 ;
 S I=0
 F  S I=$O(^TMP("IB-MRA-CNT",$J,I)) Q:I=""!(IBQUIT)  D  ;insur. co
 .S J=0
 .F  S J=$O(^TMP("IB-MRA-CNT",$J,I,J)) Q:J=""!(IBQUIT)  D  ;year
 ..S IBQUIT=$$STOP^IBCNSMR Q:IBQUIT
 ..S K=""
 ..F  S K=$O(^TMP("IB-MRA-CNT",$J,I,J,K)) Q:K=""!(IBQUIT)  D  ;bill type
 ...D SUBHDR
 ...S L=0
 ...F  S L=$O(^TMP("IB-MRA-CNT",$J,I,J,K,L)) Q:L=""!(IBQUIT)  D  ;proc
 ....S M=0
 ....F  S M=$O(^TMP("IB-MRA-CNT",$J,I,J,K,L,M)) Q:M=""!(IBQUIT)  D  ;ar status
 .....S N=0
 .....F  S N=$O(^TMP("IB-MRA-CNT",$J,I,J,K,L,M,N)) Q:N=""!(IBQUIT)  S X=+$G(^(N)),Y=+$G(^(N,0)),Z=+$G(^(1)),ZZ=+$G(^(2)) D LINE ;ibstatus
 ;
 ;......;S P=0 ;alive
 ;......;F  S P=$O(^TMP("IB-MRA-CNT",$J,I,J,K,L,M,N,P)) Q:P=""!(IBQUIT)  S X=+$G(^(P)),Y=+$G(^(P,0)),Z=+$G(^(1)),ZZ=+$G(^(2)) D LINE
 ;
SORTQ I 'IBQUIT,$E(IOST,1,2)="C-",IBPRNT="S" W ! D PAUSE^VALM1 I $D(DIRUT) S IBQUIT=1
 Q
 ;
SUBHDR ; -- print out sub headers
 Q:$G(K)=""
 I IOSL<($Y+6) D HDR(1) Q:IBQUIT
 W !!,?10,"Insurance Company: ",$P($G(^DIC(36,+I,0)),"^")
 W !,?15,"Calendar Year of Bill: ",J
 W !,?20,"Type of Bill: ",K
 Q
 ;
LINE ; -- Write one summary line
 I IOSL<($Y+5) D HDR(1) Q:IBQUIT
 W !,$E($P(M,"^",2),1,21),?23,$E($$EXTERNAL^DILFD(399,.13,"",N),1,14),?37,$J(+X,6),$$FORMAT(Y,"2$",17),$J(+Z,6),$$FORMAT(ZZ,"2$",14)
 ;
 Q
 ;
ARSTAT(M) ; convert code to ar status
 N IEN
 S IEN=+$O(^PRCA(430.3,"AC",+M,0))
 Q $P($G(^PRCA(430.3,IEN,0)),"^")
 ;
DETAIL ; -- do detail report
 N I,J,K,L,M,N,P,IBIFN,IBXX
 ;
 I '$D(^TMP("IB-MRA",$J)) W !!,"There are no detail records to print.",! G DETQ
 ;
 S I=""
 F  S I=$O(^TMP("IB-MRA",$J,I)) Q:I=""!(IBQUIT)  D  ; ins. co.
 .S J=""
 .F  S J=$O(^TMP("IB-MRA",$J,I,J)) Q:J=""!(IBQUIT)  D  ;year
 ..S K=""
 ..F  S K=$O(^TMP("IB-MRA",$J,I,J,K)) Q:K=""!(IBQUIT)  D  ;type of bill
 ...D SUBHDR
 ...S L=""
 ...F  S L=$O(^TMP("IB-MRA",$J,I,J,K,L)) Q:L=""!(IBQUIT)  D  ;proc
 ....S M=0
 ....F  S M=$O(^TMP("IB-MRA",$J,I,J,K,L,M)) Q:M=""!(IBQUIT)  D  ;ar status
 .....S N=0
 .....F  S N=$O(^TMP("IB-MRA",$J,I,J,K,L,M,N)) Q:N=""!(IBQUIT)  D  ;ibstatus
 ......;S P=0 ;alive
 ......;F  S P=$O(^TMP("IB-MRA",$J,I,J,K,L,M,N,P)) Q:P=""!(IBQUIT)  D
 ......S IBIFN=""
 ......F  S IBIFN=$O(^TMP("IB-MRA",$J,I,J,K,L,M,N,IBIFN)) Q:IBIFN=""!(IBQUIT)  S IBXX=^(IBIFN) D DLINE
 ;
DETQ I 'IBQUIT,$E(IOST,1,2)="C-" W ! D PAUSE^VALM1 I $D(DIRUT) S IBQUIT=1
 Q
 ;
DLINE ; -- print one detail line
 N I,J,K,L,M,N,DFN,ORGAMNT,TOTPAID,FROM,TO
 I IOSL<($Y+5) D HDR(2) Q:IBQUIT
 S DFN=+$P(IBXX,"^",2)
 D DEM^VADPT
 S ORGAMNT=+$G(^DGCR(399,IBIFN,"U1"))
 S TOTPAID=$$TPR^PRCAFN(IBIFN)
 W !,$P(IBXX,"^"),?12,$E(VADM(1),1,20),?34,VA("BID"),?42,VADM(4)
 W ?48,$$FMTE^XLFDT(+$G(^DGCR(399,IBIFN,"U")),2)," - ",$$FMTE^XLFDT($P($G(^("U")),"^",2),2)
 W ?70,$$FMTE^XLFDT($P($G(^DGCR(399,IBIFN,"S")),"^",12))
 W ?82,$$FORMAT(ORGAMNT,"2$",17),$$FORMAT(TOTPAID,"2$",17)
 K VA,VADM,VAERR
 Q
 ;
HDR(L1) ; -- line item header
 N X,Y,I,J,K,L,M,N,P,DIR,DIRUT,Z,ZZ
 Q:$G(IBQUIT)
 I $E(IOST,1,2)="C-",IBPAG D PAUSE^VALM1 I $D(DIRUT) S IBQUIT=1 Q
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W !,"Possible Medicare Remittance Advice Claims",?(IOM-33),"Page ",IBPAG,"  ",IBHDT
 W !,$S(L1=2:"Detail Report",L1=1:"Summary Report",1:"Totals Report")
 W:L1=2 !,"Bill No.",?12,"Patient Name",?34,"PT ID",?42,"Age",?48,"Bill From-To",?70,"Date Printed",?85,"Amount Billed",?100,"Amount Collected"
 W:L1=1 !,?38,"Total",?53,"Amount",?62,"No.",?70,"Amount"
 W:L1=1 !,"AR Status",?25,"IB Status",?38,"Number",?53,"Billed",?62,"Coll",?70,"Collected"
 W:'L1 !,?38,"Total          Amount   No.     Amount"
 W:'L1 !,?38,"Number         Billed   Coll    Collected"
 W !,$TR($J(" ",IOM)," ","-")
 Q
 ;
FORMAT(X,X2,X3) ; -- convert number to formatted number
 ; -- input  x = number to be converted
 ;          x2 = format characters (see doc for comma^%dtc)
 ;          x3 = lenght of formated output (optional)
 ;    output   = formated character string
 ;
 D COMMA^%DTC
 Q X
