FBPCR671 ;AISC/DMK,TET-CH/CNH POTENTIAL COST RECOVERY PRINT ;7/18/2006
 ;;3.5;FEE BASIS;**4,48,55,69,76,98,122,108,163**;JAN 30, 1995;Build 21
 ;Per VA Directive 6402, this routine should not be modified.
 ;
PRINT ;print data from tmp global
 N FBBILL,FBINAU  ; FB*3.5*163
 I FBPG>1&(($Y+12)>IOSL) D HDR Q:FBOUT
 E  D HDR1 Q:FBOUT
 S FBPVLIST="ATTENDING PROV NAME^NPI^TAXONOMY CODE^OPERATING PROV NAME^NPI^RENDERING PROV NAME"
 S FBPVLIST=FBPVLIST_"^NPI^TAXONOMY CODE^SERVICING PROV NAME^NPI^REFERRING PROV NAME^NPI"
 S FBVI="" F  S FBVI=$O(^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI)) Q:FBVI']""!(FBOUT)  D SH Q:FBOUT  D  Q:FBOUT
 .S FBDT=0 F  S FBDT=$O(^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT)) Q:'FBDT  S FBI=0 F  S FBI=$O(^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT,FBI)) Q:'FBI  D  Q:FBOUT
 ..I ($Y+5)>IOSL D PAGE Q:FBOUT
 ..S FBDATA=$G(^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT,FBI)),FBCATC=$P(FBDATA,U,9),FBINS=$P(FBDATA,U,10)  ;FB*3.5*163 Add $G 
 ..S FBINV=$G(^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT,FBI,"FBINV"))  ; FB*3.5*163 Add $G
 ..S FBBILL=$G(^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT,FBI,"FBBILL"))  ; FB*3.5*163 Bill No.
 ..S FBINAU=$G(^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT,FBI,"FBINAU"))  ; FB*3.5*163 Ins Auth No.
 ..W ! W:$P(FBDATA,U,8)["R" "*" W:$P(FBDATA,U,9)]"" "#"
 ..W ?2,$P(FBDATA,U,1),?15,$P(FBDATA,U,5),?31,$P(FBDATA,U,6)
 ..W ?47,$P(FBDATA,U,7),?57,$P(FBINV,U,2)
 ..W !?2,$P(FBDATA,U,2),?15,$P(FBDATA,U,3),?25,$P(FBINV,U,1)
 .. ;Print adj reasons, if null then print suspend code
 ..W ?36,$S($P(FBINV,U,3)]"":$P(FBINV,U,3),1:$P(FBDATA,U,4))
 ..W ?46,$S($P(FBINV,U,3)]"":$J($P(FBINV,U,4),14),1:$J($P(FBDATA,U,10),14))
 ..W ?63,$P(FBINV,U,5)
 ..W !,?2,$S(FBBILL:"Y",1:"N"),?9,FBBILL  ; FB*3.5*163 Bill No.
 ..W ?24,FBINAU  ; FB*3.5*163 Ins Auth No.
 ..; write admitting diagnosis if present
 .. I $P(FBINV,U,6)'="" W !?6,"Admit Dx: ",$P(FBINV,U,6)
 ..;F FBY="DX","PROC" I $D(^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT,FBI,FBY)) S FBDATA=^(FBY),FBSL=$L(FBDATA,"^") W !?2,FBY,": " F I=1:1:FBSL W $P(FBDATA,U,I),"    "
 ..I $D(^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT,FBI,"DX")) S FBDATA=$G(^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT,FBI,"DX")),FBSL=$L(FBDATA,"^") F I=1:1:FBSL D WRTDX
 ..S FBNEWLN=1
 ..I $D(^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT,FBI,"PROC")) S FBDATA=$G(^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT,FBI,"PROC")),FBSL=$L(FBDATA,"^") F I=1:1:FBSL D WRTPC
 ..K FBNEWLN
 ..;I FBDATA]"" F I=1:1:FBSL I $P(FBDATA,U,I)]"" D                                                                                      ; FB*3.5*122
 ..;.;W:FBRPROV !,?2,"PROC: " W:$G(FBRPROV)="" "    " W $P(FBDATA,U,I)                                                                         ; FB*3.5*122
 ..;.;S FBRPROV=$G(^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT,FBI,"RPROV",I)) I FBRPROV="" Q                                                 ; FB*3.5*122
 ..;.;W ?20,"RENDERING PROVIDER NAME: "_$P(FBRPROV,U,2),!,?21,"NPI: "_$P(FBRPROV,U,3),?46,"TAXONOMY CODE: "_$P(FBRPROV,U,4) S FBRPROV=1  ; FB*3.5*122
 ..K FBRPROV
 ..I FBCATC!FBINS D
 ...W !?5,">>>"
 ...I FBCATC=0 W "Cost recover from insurance."
 ...I FBCATC=1 W "Cost recover from means testing"_$S(FBINS:" and insurance.",1:".")
 ...I FBCATC=2 W "Cost recover from LTC co-pay"_$S(FBINS:" and insurance.",1:".")
 ...I FBCATC=3 W $S(FBINS:"Cost recover from insurance, ",1:"")_"1010EC Missing for LTC Patient."
 ...I FBCATC=4 W $S(FBINS:"Cost Recover from insurance and ",1:"")_"Potential Cost Recover from LTC co-pay."
 ..;
 ..I +$O(^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT,FBI,"A",0)) D  Q:FBOUT  W !,FBDASH1
 ...S (FBOV,FBCNT)=0,FBSL=7 D SHA Q:FBOUT
 ...F  S FBCNT=$O(^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT,FBI,"A",FBCNT)) Q:'FBCNT  S FBDATA=^(FBCNT),FBV=$P(FBDATA,U,11)_";"_$P(FBDATA,U,12) D  D WRT Q:FBOUT
 ....N FBXX S FBXX=$O(^FBAAV("C",$P(FBDATA,U,12),"")) S $P(FBV,";",2)=$P(FBV,";",2)_"/"_$S(FBXX="":"**********",$P($G(^FBAAV(FBXX,3)),U,2)]"":$P(^FBAAV(FBXX,3),U,2),1:"**********")
 ..D PRNT5010  ; FB*3.5*122
 ..W ! D PRTAUTH^FBPCR2(FBI)  ;FB*3.5*163
 Q
PRNT5010 ; Format and print based on data type  ; FB*3.5*122
 N FBVDAT,FBCNT
 I $G(FBPSF)]"",$G(FBPT)]"",$G(FBPI)]"",$G(FBVI)]"",$G(FBDT)]"",$G(FBI)]"",$G(^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT,FBI,"FBY4"))]""
 E  Q
 W ! S FBVDAT=^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT,FBI,"FBY4")
 F FBCNT=1,6 I $P(FBVDAT,U,FBCNT)]"" D
 . W !,$P(FBPVLIST,U,FBCNT)_": "_$P(FBVDAT,U,FBCNT),?55,$P(FBPVLIST,U,FBCNT+1)_": "_$P(FBVDAT,U,FBCNT+1)
 . W !,?6,$P(FBPVLIST,U,FBCNT+2)_": "_$P(FBVDAT,U,FBCNT+2)
 F FBCNT=4,11,9 I $P(FBVDAT,U,FBCNT)]"" D
 . W !,$P(FBPVLIST,U,FBCNT)_": "_$P(FBVDAT,U,FBCNT),?55,$P(FBPVLIST,U,FBCNT+1)_": "_$P(FBVDAT,U,FBCNT+1)
 I $P(FBVDAT,U,20)]"" D
 . W !,"  SERVICING FACILITY ADDRESS: "_$P(FBVDAT,U,20),!,"                              "_$P(FBVDAT,U,21)_", "
 . I $P(FBVDAT,U,22)]"" W $$GET1^DIQ(5,$P(FBVDAT,U,22)_",",.01)
 . W " "_$P(FBVDAT,U,23)
 W !
 Q
WRT ;write ancillary info
 N FBCATC,FBINS,FBADJ I ($Y+4)>IOSL D PAGE Q:FBOUT  D SHA,SHA2
 D:FBOV'=FBV SHA2
 S FBADJ=^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT,FBI,"A",FBCNT,"FBADJ")
 S FBCATC=$P(FBDATA,U,14),FBINS=$P(FBDATA,U,15)
 W !
 W ?1,$P(FBDATA,U,1)
 W ?11,$P($P(FBDATA,U,2),",")
 W ?31,$J($P(FBADJ,U,2),10)
 W ?43,$P(FBDATA,U,6)
 W ?54,$P(FBDATA,U,7)
 W ?64,$P(FBDATA,U,8)
 I $P($P(FBDATA,U,2),",",2)]"" D  Q:FBOUT
 . N FBI,FBMOD
 . F FBI=2:1 S FBMOD=$P($P(FBDATA,U,2),",",FBI) Q:FBMOD=""  D  Q:FBOUT
 . . I $Y+6>IOSL D PAGE Q:FBOUT  D SHA,SHA2 W !,"  (continued)"
 . . W !,?16,"-",FBMOD
 W !,$P(FBDATA,U,3)
 W ?13,$P(FBDATA,U,4)
 W ?23,$S($P(FBADJ,U,3)]"":$P(FBADJ,U,3),1:$P(FBDATA,U,5))
 W ?33,$J($S($P(FBADJ,U,4)]"":$J($P(FBADJ,U,4),14),1:$P(FBADJ,U,1)),14)
 W ?48,$P(FBADJ,U,5)
 W ?60,$P(FBADJ,U,6)
 W !?5,"Primary Dx: ",$P(FBDATA,U,9),?40,"S/C Condition? ",$P(FBDATA,U,8),?66,"Obl.#: ",$P(FBDATA,U,10)
 I FBCATC!FBINS D
 .W !?5,">>>"
 .I FBCATC=0 W "Cost recover from insurance."
 .I FBCATC=1 W "Cost recover from means testing"_$S(FBINS:" and insurance.",1:".")
 .I FBCATC=2 W "Cost recover from LTC co-pay"_$S(FBINS:" and insurance.",1:".")
 .I FBCATC=3 W $S(FBINS:"Cost recover from insurance, ",1:"")_"1010EC Missing for LTC Patient."
 .I FBCATC=4 W $S(FBINS:"Cost Recover from insurance and ",1:"")_"Potential Cost Recover from LTC co-pay."
 ;
 Q
HDR ;main header
 D HDR^FBPCR Q:FBOUT
HDR1 W !!?(IOM-(13+$L(FBXPROG))/2),"NVC PROGRAM: ",FBXPROG ;FB*3.5*163 - Changed from FEE to NVC
 W !?1,"Invoice Date",?15,"Invoice No.",?31,"From Date",?48,"To Date",?57,"Patient Control #"
 ; W !?1,"Amt Claimed",?15,"Amt Paid",?25,"Cov Days",?36,"Adj Codes",?49,"Adj Amounts",?63,"Remit Remarks",!,FBDASH
 W !?1,"Amt Claimed",?15,"Amt Paid",?25,"Cov Days",?36,"Adj Codes",?49,"Adj Amounts",?63,"Remit Remarks"  ; FB*3.5*163
 W !?1,"Billed?",?9,"Bill#",?24,"Ins Auth#",!,FBDASH ;FB*3.5*163
 Q
SH ;subheader - vendor, prints when name changed
 I ($Y+7)>IOSL D HDR Q:FBOUT
 W !!,"Vendor: ",$P(FBVI,";"),?41,"Vendor ID: ",$P($P(FBVI,";",2),"/",1)
 W !?20,"Fee Basis Billing Provider NPI: ",$P(FBVI,"/",2)
 Q
SHA ;ancillary subheader
 I ($Y+16)>IOSL D PAGE Q:FBOUT
 W !?20,">>> ANCILLARY SERVICE PAYMENTS <<<",!
SHA1 ;subheader for ancillary data
 W !!,?1,"Svc Date",?11,"CPT-MOD ",?19,"Travel Paid",?31,"Units Paid",?43,"Batch No.",?54,"Inv No.",?64,"Voucher Date"
 W !,"Amt Claimed",?13,"Amt Paid",?23,"Adj Code",?36,"Adj Amounts",?48,"Remit Remark",?61,"Patient Account No",!,FBDASH
 Q
SHA2 ;subheader for vendor name
 I ($Y+9)>IOSL D HDR Q:FBOUT  D SH,SHA
 I FBOV'=FBV S FBOV=FBV
 W !!,"Vendor: ",$P(FBV,";"),?41,"Vendor ID/NPI: ",$P(FBV,";",2)
 Q
CR ;read for display
 Q:'FBPG  S DIR(0)="E" W ! D ^DIR K DIR S:$D(DUOUT)!($D(DTOUT)) FBOUT=1
 Q
PAGE ;new page
 D HDR Q:FBOUT  D SH
 Q
WRTDX ;input
 ; FBDATA contains node from ^TMP
 ; I contains piece to be written
 I I=1!($X+$L($P(FBDATA,"^",I))+1>IOM) W !,?4,"DX/POA: "
 W $P(FBDATA,"^",I)," "
 Q
WRTPC ;input
 ;FBDATA contains node from ^TMP
 ;I contains piece to be written
 ; if FBNEWLN true then force new line and label for procedure
 N FBRPROV
 S FBRPROV=$G(^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT,FBI,"RPROV",I))
 ; start new line for procedures when appropriate
 I FBRPROV'="" S FBNEWLN=1
 I FBNEWLN!($X+$L($P(FBDATA,"^",I))+2>IOM) W !?4,"PROC: " S FBNEWLN=0
 ; write procedure code
 W $P(FBDATA,"^",I)," "
 ; write line rendering provider data if applicable
 I FBRPROV="" Q
 W ?20,"RENDERING PROVIDER NAME: "_$P(FBRPROV,U,2)
 W !?21,"NPI: "_$P(FBRPROV,U,3)
 W ?46,"TAXONOMY CODE: "_$P(FBRPROV,U,4)
 S FBNEWLN=1  ; force new line for next procedure
 Q
 ;I I=1!($X+$L($P(FBDATA,"^",I))+1>IOM) W !,?4,"PROC: "
 ;W $P(FBDATA,"^",I)," "
 ;Q
 ;S FBRPROV=$G(^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT,FBI,"RPROV",I))                                                 ; FB*3.5*122
 ;W !,?2,"PROC: ",$P(FBDATA,U,I) I FBRPROV="" Q                                                                       ; FB*3.5*122
 ;W ?20,"RENDERING PROVIDER NAME: "_$P(FBRPROV,U,2),!,?21,"NPI: "_$P(FBRPROV,U,3),?46,"TAXONOMY CODE: "_$P(FBRPROV,U,4) S FBRPROV=1  ; FB*3.5*122
 ;Q
WRTSC ;write service connected
 W !,"SERVICE CONNECTED? ",$S(+VAEL(3):"YES",1:"NO"),!
 Q
 ;
