FBPAY671 ;AISC/DMK,TET-CH/CNH PAYMENT HISTORY PRINT ;21/NOV/2006
 ;;3.5;FEE BASIS;**4,32,55,69,101**;JAN 30, 1995;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
PRINT ;print data from tmp global
 S FBOUT=0 D:FBCRT&(FBPG) CR Q:FBOUT
 S FBHEAD=$S(FBSORT:"VETERAN",1:"VENDOR")
EN1 N FBI,FBINV ;entry point from fbchdi
 D HDR S FBVI="" F  S FBVI=$O(^TMP($J,"FB",FBPI,FBVI)) Q:FBVI']""!(FBOUT)  D:FBSORT SH Q:FBOUT  S FBPT="" F  S FBPT=$O(^TMP($J,"FB",FBPI,FBVI,FBPT)) Q:FBPT']""!(FBOUT)  D  Q:FBOUT  D CKANC Q:FBOUT
 .D:'FBSORT SH Q:FBOUT  S FBDT=0 F  S FBDT=$O(^TMP($J,"FB",FBPI,FBVI,FBPT,FBDT)) Q:'FBDT!(FBOUT)  S FBI=0 F  S FBI=$O(^TMP($J,"FB",FBPI,FBVI,FBPT,FBDT,FBI)) Q:'FBI!(FBOUT)  D  Q:FBOUT
 ..I ($Y+5)>IOSL D PAGE Q:FBOUT
 ..S FBDATA=^TMP($J,"FB",FBPI,FBVI,FBPT,FBDT,FBI),A2=$$EXTRL^FBMRASVR($P(FBDATA,U,3))
 ..S FBINV=^TMP($J,"FB",FBPI,FBVI,FBPT,FBDT,FBI,"FBINV")
 ..W ! W:$P(FBDATA,U,8)["R" "*" W:$P(FBDATA,U,9)]"" "#"
 ..W ?2,$P(FBDATA,U,1),?15,$P(FBDATA,U,5),?31,$P(FBDATA,U,6)
 ..W ?47,$P(FBDATA,U,7),?57,$P(FBINV,U,2)
 ..W !?2,$P(FBDATA,U,2),?15,$P(FBDATA,U,3),?25,$P(FBINV,U,1)
 .. ;Print adj reasons, if null then print suspend code
 ..W ?36,$S($P(FBINV,U,5)]"":$P(FBINV,U,5),1:$P(FBDATA,U,4))
 ..W ?46,$S($P(FBINV,U,5)]"":$J($P(FBINV,U,6),14),1:$J($P(FBDATA,U,10),14))
 ..W ?63,$P(FBINV,U,7)
 .. ;If FPPS Claim ID exists then print it.
 ..I $P(FBINV,U,3)]"" D
 ...W !?5,"FPPS Claim ID: ",$P(FBINV,U,3),"    FPPS Line Item: ",$P(FBINV,U,4)
 ..F FBY="DX","PROC" I $D(^TMP($J,"FB",FBPI,FBVI,FBPT,FBDT,FBI,FBY)) S FBDATA=^(FBY),FBSL=$L(FBDATA,"^") W !?2,FBY,": " F I=1:1:FBSL W $P(FBDATA,U,I),"    "
 ..I $D(^TMP($J,"FB",FBPI,FBVI,FBPT,FBDT,FBI,"FBCK")) D EFBCK^FBPAY21(^TMP($J,"FB",FBPI,FBVI,FBPT,FBDT,FBI,"FBCK")) D PMNT^FBAACCB2 K A2
 Q
CKANC I +$O(^TMP($J,"FB",FBPI,FBVI,FBPT,"A",0)) D PANC(FBI) Q:FBOUT  W !,FBDASH1
 Q
PANC(FBI) ;print anc data - FBI = unique number; called by fbpay3
 S (FBOV,FBK)=0,FBSL=8,FBLOC=1_U_12_U_23_U_33_U_43_U_56_U_62_U_71 D SHA Q:FBOUT
 F  S FBK=$O(^TMP($J,"FB",FBPI,FBVI,FBPT,"A",FBK)) Q:'FBK!(FBOUT)  S FBL=0 F  S FBL=$O(^TMP($J,"FB",FBPI,FBVI,FBPT,"A",FBK,FBL)) Q:'FBL!(FBOUT)  S FBM=0 F  S FBM=$O(^TMP($J,"FB",FBPI,FBVI,FBPT,"A",FBK,FBL,FBM)) Q:'FBM!(FBOUT)  D
 .S FBDATA=^TMP($J,"FB",FBPI,FBVI,FBPT,"A",FBK,FBL,FBM)
 .S FBV=$P(FBDATA,U,12)_";"_$P(FBDATA,U,13)
 .D WRT
 K FBK,FBL,FBM Q
WRT ;write ancillary info
 I ($Y+6)>IOSL D PAGE Q:FBOUT  D SHA Q:FBOUT  D SHA2 Q:FBOUT
 D:FBOV'=FBV SHA2
 S FBCKIN=$G(^TMP($J,"FB",FBPI,FBVI,FBPT,"A",FBK,FBL,FBM,"FBCK")) D EFBCK^FBPAY21(FBCKIN)
 S FBADJ=$G(^TMP($J,"FB",FBPI,FBVI,FBPT,"A",FBK,FBL,FBM,"FBADJ"))
 W ! W:$G(FBCAN)]"" "+"
 W ?1,$P(FBDATA,U,1)
 W ?11,$P($P(FBDATA,U,2),",")
 W ?22,$P(FBADJ,U,9)
 W ?31,$J($P(FBADJ,U,2),10)
 W ?43,$P(FBDATA,U,6)
 W ?54,$P(FBDATA,U,7)
 W ?64,$P(FBDATA,U,8)
 I $P($P(FBDATA,U,2),",",2)]"" D  Q:FBOUT
 . N FBI,FBMOD
 . F FBI=2:1 S FBMOD=$P($P(FBDATA,U,2),",",FBI) Q:FBMOD=""  D  Q:FBOUT
 . . I $Y+7>IOSL D PAGE Q:FBOUT  D SHA Q:FBOUT  D SHA2 Q:FBOUT  W !,"  (continued)"
 . . W !?16,"-",FBMOD
 W !,$P(FBDATA,U,3)
 W ?13,$P(FBDATA,U,4)
 W ?23,$S($P(FBADJ,U,3)]"":$P(FBADJ,U,3),1:$P(FBDATA,U,5))
 W ?33,$J($S($P(FBADJ,U,4)]"":$J($P(FBADJ,U,4),14),1:$P(FBADJ,U,1)),14)
 W ?48,$P(FBADJ,U,5)
 W ?60,$P(FBADJ,U,6)
 ;If FPPS Claim ID exists then print it.
 I $P(FBADJ,U,7)]"" D
 .W !?5,"FPPS Claim ID: ",$P(FBADJ,U,7),"    FPPS Line Item: ",$P(FBADJ,U,8)
 W !?4,"Primary Dx: ",$P(FBDATA,U,10),?40,"S/C Condition? ",$P(FBDATA,U,9),?66,"Obl.#: ",$P(FBDATA,U,11)
 N A2 S A2=$$EXTRL^FBMRASVR($P(FBDATA,U,4))
 D PMNT^FBAACCB2
 Q
HDR ;main header
 I FBPG>0!FBCRT W @IOF
 S FBPG=FBPG+1
 I $D(FBHEAD) D
 .W !?25,FBHEAD_" PAYMENT HISTORY"
 .I $G(FB1725R)]"",FB1725R'="A" W " ",$S(FB1725R="M":"for 38 U.S.C. 1725 Claims",1:"excluding 38 U.S.C. 1725 Claims")
 .W !,?24,$E(FBDASH,1,24),?71,"Page: ",FBPG,!?48,"Date Range: ",$$DATX^FBAAUTL(FBBDATE)," to ",$$DATX^FBAAUTL(FBEDATE)
 I '$D(FBHEAD) W !?30,"INVOICE DISPLAY",!?29,$E(FBDASH,1,17),!
 W ! W:FBSORT "Patient: ",FBPNAME,?41,"Patient ID: ",FBPID W:'FBSORT "Vendor: ",FBVNAME,?41,"Vendor ID: ",FBVID
 W !?(IOM-(13+$L(FBPROG(+FBPI)))/2),"FEE PROGRAM: ",FBPROG(+FBPI)
 W !?3,"('*' Reimb. to Patient  '+' Cancel. Activity  '#' Voided Payment)"
 W !,?3,"(paid symbol: 'R' RBRVS  'F' 75th percentile  'C' contract  'M' Mill Bill"
 W !,?3,"              'U' U&C)"
 W !?1,"Invoice Date",?15,"Invoice No.",?31,"From Date",?48,"To Date",?57,"Patient Control #"
 W !?1,"Amt Claimed",?15,"Amt Paid",?25,"Cov Days",?36,"Adj Codes",?49,"Adj Amounts",?63,"Remit Remarks",!,FBDASH
 Q
SH ;subheader - vendor if fbsort; patient if 'fbsort, prints when name changed
 I ($Y+7)>IOSL D:FBCRT CR Q:FBOUT  D HDR
 I FBSORT W !!,"Vendor: ",$P(FBVI,";"),?41,"Vendor ID: ",$P(FBVI,";",2)
 I 'FBSORT W !!,"Patient: ",$P(FBPT,";"),?41,"Patient ID: ",$$SSNL4^FBAAUTL($$SSN^FBAAUTL($P(FBPT,";",2)))
 Q
SHA ;ancillary subheader
 I ($Y+14)>IOSL D PAGE Q:FBOUT
 W !?20,">>> ANCILLARY SERVICE PAYMENTS <<<",!
SHA1 ;subheader for ancillary data
 W !,?1,"Svc Date",?11,"CPT-MOD ",?21,"Rev Code",?31,"Units Paid",?43,"Batch No.",?54,"Inv No.",?64,"Voucher Date"
 W !,"Amt Claimed",?13,"Amt Paid",?23,"Adj Code",?36,"Adj Amounts",?48,"Remit Remark",?61,"Patient Account No",!,FBDASH
 Q
SHA2 ;subheader for vendor name
 I ($Y+5)>IOSL D:FBCRT CR Q:FBOUT  D HDR,SH,SHA
 I FBOV'=FBV S FBOV=FBV
 W !!,"Vendor: ",$P(FBV,";"),?41,"Vendor ID: ",$P(FBV,";",2)
 Q
CR ;read for display
 Q:'FBPG  S DIR(0)="E" W ! D ^DIR K DIR S:$D(DUOUT)!($D(DTOUT)) FBOUT=1
 Q
PAGE ;new page
 I FBCRT D CR Q:FBOUT
 D HDR,SH
 Q
WRTDX I $P(FBDX,"^",K)]"" W ?4,"Dx: ",$$ICD9^FBCSV1($P(FBDX,"^",K)),"  " Q
 Q
WRTPC I $P(FBPROC,"^",L)]"" W ?4,"Proc: ",$$ICD0^FBCSV1($P(FBPROC,"^",L)),"   " Q
 Q
WRTSC ;write service connected
 W !,"SERVICE CONNECTED? ",$S(+VAEL(3):"YES",1:"NO"),!
 Q
TRAV ;write out travel payments, (FBPAT,FBSORT) must be defined
 S FBTRDT=0
 F  S FBTRDT=$O(^TMP($J,"FBTR",FBPAT,FBTRDT)) Q:'FBTRDT  S FBTRX=0 F  S FBTRX=$O(^TMP($J,"FBTR",FBPAT,FBTRDT,FBTRX)) Q:'FBTRX  S FBCKIN=^(FBTRX),A2=$P(FBCKIN,"^") D TRCK Q:FBOUT  W:$G(FBTRCK) !,?5,"TRAVEL PAYMENTS: " D  K FBTRCK
 .W ?22,$$DATX^FBAAUTL(FBTRDT),?35,A2
 .S A2=$$EXTRL^FBMRASVR(A2) D EFBCK^FBPAY21(FBCKIN),PMNT^FBAACCB2
 .K A2 W ! Q
 Q
TRCK I ($Y+5)>IOSL D:FBCRT CR Q:FBOUT  D HDR^FBPAY21
 Q
