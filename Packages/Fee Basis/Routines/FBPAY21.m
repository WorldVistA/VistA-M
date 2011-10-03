FBPAY21 ;AISC/CMR-OUTPATIENT PAYMENT HISTORY SORT/PRINT ;21/NOV/2006
 ;;3.5;FEE BASIS;**4,32,69,101**;JAN 30, 1995;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
PRINT ;write output
 S FBOUT=0 D:FBCRT&(FBPG) CR Q:FBOUT
 D HDR I FBSORT S FBPAT=FBPNAME I $D(^TMP($J,"FBTR")) S FBTRCK=1 D TRAV^FBPAY671
 S FBVI="" F  S FBVI=$O(^TMP($J,"FB",FBPI,FBVI)) Q:FBVI']""!(FBOUT)  D:FBSORT SH Q:FBOUT  S FBPT="" D  Q:FBOUT
 .F  S FBPT=$O(^TMP($J,"FB",FBPI,FBVI,FBPT)) Q:FBPT']""!(FBOUT)  D:'FBSORT SH,SH1 Q:FBOUT  S FBDT=0 F  S FBDT=$O(^TMP($J,"FB",FBPI,FBVI,FBPT,FBDT)) Q:'FBDT!(FBOUT)  D
 ..S L=0 F  S L=$O(^TMP($J,"FB",FBPI,FBVI,FBPT,FBDT,L)) Q:'L!(FBOUT)  S M=0 F  S M=$O(^TMP($J,"FB",FBPI,FBVI,FBPT,FBDT,L,M)) Q:'M!(FBOUT)  D
 ...I ($Y+6)>IOSL D PAGE Q:FBOUT
 ...S FBDATA=^TMP($J,"FB",FBPI,FBVI,FBPT,FBDT,L,M)
 ...S FBCKIN=$G(^TMP($J,"FB",FBPI,FBVI,FBPT,FBDT,L,M,"FBCK")) D EFBCK(FBCKIN)
 ...S FBADJ=$G(^TMP($J,"FB",FBPI,FBVI,FBPT,FBDT,L,M,"FBADJ"))
 ...W !,$S($G(FBCAN)]"":"+",1:"")
 ...W ?1,$P(FBDATA,U,1)
 ...W ?11,$P($P(FBDATA,U,2),",")
 ...W ?22,$P(FBADJ,U,9)
 ...W ?31,$J($P(FBADJ,U,2),10)
 ...W ?43,$P(FBDATA,U,6)
 ...W ?54,$P(FBDATA,U,7)
 ...W ?64,$P(FBDATA,U,8)
 ...I $P($P(FBDATA,U,2),",",2)]"" D  Q:FBOUT
 ....N FBI,FBMOD
 ....F FBI=2:1 S FBMOD=$P($P(FBDATA,U,2),",",FBI) Q:FBMOD=""  D  Q:FBOUT
 .....I $Y+7>IOSL D PAGE Q:FBOUT  W !,"  (continued)"
 .....W !?16,"-",FBMOD
 ...W !,$P(FBDATA,U,3)
 ...W ?13,$P(FBDATA,U,4)
 ...W ?23,$S($P(FBADJ,U,3)]"":$P(FBADJ,U,3),1:$P(FBDATA,U,5))
 ...W ?33,$J($S($P(FBADJ,U,4)]"":$J($P(FBADJ,U,4),14),1:$P(FBADJ,U,1)),14)
 ...W ?48,$P(FBADJ,U,5)
 ...W ?60,$P(FBADJ,U,6)
 ...I $P(FBADJ,U,7)]"" W !?5,"FPPS Claim ID: ",$P(FBADJ,U,7),"     FPPS Line Item: ",$P(FBADJ,U,8)
 ...S A2=$$EXTRL^FBMRASVR($P(FBDATA,U,4))
 ...W !?4,"Primary Dx: ",$P(FBDATA,U,10),?40,"S/C Condition? ",$P(FBDATA,U,9) W ?63,"Obl.#: ",$P(FBDATA,U,11)
 ...D PMNT^FBAACCB2 K A2
 Q
HDR ;main header
 I FBPG>0!FBCRT W @IOF
 S FBPG=FBPG+1
 W !?25,$S($G(FBSORT):"VETERAN",1:"VENDOR")," PAYMENT HISTORY"
 I $G(FB1725R)]"",FB1725R'="A" W " ",$S(FB1725R="M":"for 38 U.S.C. 1725 Claims",1:"excluding 38 U.S.C. 1725 Claims")
 W !?24,$E(FBDASH,1,24),?71,"Page: ",FBPG,!
 W:FBSORT "Patient: ",FBPNAME,?41,"Patient ID: ",FBPID W:'FBSORT "Vendor: ",FBVNAME,?41,"Vendor ID: ",FBVID
 ;W ?71,"Page: ",FBPG
 W !?(IOM-(13+$L(FBPROG(+FBPI)))/2),"FEE PROGRAM: ",FBPROG(+FBPI)
 W !,?3,"('*' Reimb. to Patient   '+' Cancel. Activity   '#' Voided Payment)"
 W !,?3,"(paid symbol: 'R' RBRVS  'F' 75th percentile  'C' contract  'M' Mill Bill"
 W !,?3,"              'U' U&C)"
 W !,?1,"Svc Date",?11,"CPT-MOD ",?21,"Rev Code",?31,"Units Paid",?43,"Batch No.",?54,"Inv No.",?64,"Voucher Date"
 W !,"Amt Claimed",?13,"Amt Paid",?23,"Adj Code",?36,"Adj Amounts",?48,"Remit Remark",?61,"Patient Account No",!,FBDASH
 Q
SH ;subheader - vendor if fbsort; patient if 'fbsort, prints when name changed
 I ($Y+8)>IOSL D:FBCRT CR Q:FBOUT  D HDR
 I FBSORT W !!,"Vendor: ",$P(FBVI,";"),?41,"Vendor ID: ",$P(FBVI,";",2)
 I 'FBSORT W !!,"Patient: ",$P(FBPT,";"),?41,"Patient ID: ",$$SSNL4^FBAAUTL($$SSN^FBAAUTL($P(FBPT,";",2)))
 Q
SH1 S FBPAT=$P(FBPT,";") I $D(^TMP($J,"FBTR",FBPAT)) S FBTRCK=1 D TRAV^FBPAY671
 Q
CR ;read for display
 S DIR(0)="E" W ! D ^DIR K DIR S:$D(DUOUT)!($D(DTOUT)) FBOUT=1
 Q
PAGE ;new page
 I FBCRT D CR Q:FBOUT
 D HDR,SH
 Q
EFBCK(FBCKIN) ;extract check information from ^TMP
 I $G(FBCKIN)']"" S (FBCK,FBCKDT,FBCANDT,FBCANR,FBCAN,FBDIS,FBCKINT)="" Q
 S U="^",FBCK=$P(FBCKIN,U,2),FBCKDT=$P(FBCKIN,U,3),FBCANDT=$P(FBCKIN,U,4),FBCANR=$P(FBCKIN,U,5),FBCAN=$P(FBCKIN,U,6),FBDIS=$P(FBCKIN,U,7),FBCKINT=$P(FBCKIN,U,8)
 K FBCKIN
 Q
 ;
EN ;entry from fbpay67 to set '*' if ancillary payment is
 ;a reimbursement.  returns FBRP=to '*' or " "
 ;'Y' passed in equal to zero node of 162.03 look at $P(Y,U,20)
 ;
 S FBR=$P($G(Y),U,20),FBR=$S(FBR="R":"*",1:" ")
 Q
