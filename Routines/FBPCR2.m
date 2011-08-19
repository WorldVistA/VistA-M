FBPCR2 ;AISC/DMK,GRR,TET-OUTPATIENT POTENTIAL COST RECOVERY SORT/PRINT ;07/01/2006
 ;;3.5;FEE BASIS;**4,48,55,69,76,98**;JAN 30, 1995;Build 54
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EN ;entry point
 S (FBCATC,FBINS,FBPSF)=0
SORT ;sort by date finalized, patient, vendor, treatment ien, service ien
 S I=FBBDATE-.1 F  S I=$O(^FBAAC("AK",I)) Q:'I!(I>FBEDATE)  S J=0 F  S J=$O(^FBAAC("AK",I,J)) Q:'J  D
 .S DFN=J D VET^FBPCR
 .S K=0  F  S K=$O(^FBAAC("AK",I,J,K)) Q:'K  S L=0 F  S L=$O(^FBAAC("AK",I,J,K,L)) Q:'L  D SETTR S M=0 F  S M=$O(^FBAAC("AK",I,J,K,L,M)) Q:'M  D  S (FBCATC,FBINS,FBPSF)=0
 ..D SET Q:'FBPSV&('$D(FBPSV(FBPSF)))  I FBCATC!FBINS D SETTMP
KILL ;kill variables set in this routine
 K A1,A2,A3,D,D2,DFN,FBAACPTC,FBBN,FBCATC,FBCP,FBDOB,FBDOS,FBDT,FBDT1,FBIN,FBINS,FBOB,FBP,FBPAT,FBPCR,FBPDX,FBPDXC,FBPID,FBPNAME,FBPSF,FBSC,FBTA,FBTYPE,FBVEN,FBVID,FBVNAME,FBVP,I,J,K,L,M,T,Y,FBMODLE
 K FBCSID,FBADJLA,FBADJLR,FBRRMKL,FBUNITS,TAMT,T,FBADJ
 Q
SET ;set variables - also entry point from FBPCR67
 N FBPCR,FBX
 S Y=$G(^FBAAC(J,1,K,1,L,1,M,0)) Q:'+$P(Y,U,9)!($G(^FBAAC(J,1,K,1,L,1,M,"FBREJ"))]"")
 S FBY=$G(^FBAAC(J,1,K,1,L,1,M,2))
 S FBVNAME=$E($P($G(^FBAAV(K,0)),U),1,23),FBVID=$S(FBVNAME]"":$P(^(0),U,2)_"/"_$S($P($G(^(3)),U,2)]"":$P(^(3),U,2),1:"**********"),1:"")
 S FBP=+$P(Y,U,9),FBSC=$P(Y,U,27),FBPDX=+$P(Y,U,23),FBPSF=+$P(Y,U,12)
 S FBSC=$S(FBSC="Y":"YES",FBSC="N":"NO",1:"-")
 S T=$P(Y,U,5),D2=$P(Y,U,6),FBDOS=D2,D2=$$DATX^FBAAUTL(D2),FBCP=$P(Y,U,18),FBCP=$S(FBCP=1:"(C&P)",1:"")
 Q:FBCP]""!('FBPSV&('$D(FBPSV(FBPSF))))  S FBPCR=+$G(^FBAAC(J,1,K,1,L,0)),FBCATC=$$CATC^FBPCR(DFN,FBPCR,+$P(Y,U,18)),FBINS=$S(FBSC["N":$$INSURED^FBPCR4(DFN,FBPCR),1:0) Q:'FBCATC&'FBINS
 S FBAACPTC=$$CPT^FBAAUTL4($P(Y,U))
 S FBOB=$P(Y,U,10)
 I T]"" S T=$P($G(^FBAA(161.27,+T,0)),U)
 S FBTYPE=$P(Y,U,20),FBVP=$P(Y,U,21),FBIN=$P(Y,U,16),FBBN=$P(Y,U,8),FBBN=$S(FBBN']"":"",$D(^FBAA(161.7,FBBN,0)):$P(^(0),U),1:""),FBBN=$S(FBBN="":"",1:$E("00000",$L(FBBN)+1,5)_FBBN)
 S FBVEN=FBVNAME_";"_FBVID,FBPAT=FBPNAME_";"_DFN
 S FBMODLE=$$MODL^FBAAUTL4("^FBAAC("_J_",1,"_K_",1,"_L_",1,"_M_",""M"")","E")
 I T]"" S T=$P($G(^FBAA(161.27,+T,0)),U) ;suspend code
 S TAMT=$FN($P(Y,U,4),"",2) ;suspend amount
 S FBUNITS=$P(FBY,U,14) ;units paid
 S FBCSID=$P(FBY,U,16) ;patient account number
 S FBX=$$ADJLRA^FBAAFA(M_","_L_","_K_","_J_",")
 S FBADJLR=$P(FBX,U) ;adjustment codes
 S FBADJLA=$P(FBX,U,2) ;adjustment amounts
 S FBRRMKL=$$RRL^FBAAFR(M_","_L_","_K_","_J_",") ;remit remarks
 ;output format
 S A1=$J($P(Y,U,2),6,2),A2=$J($P(Y,U,3),6,2),A3=$J(A3,6,2),FBIN=$J(FBIN,7)
 S FBDT1=$S(FBVP="VP":"#",1:"")_$S(FBTYPE="R":"*",1:" ")_FBDT
 Q
SETTMP ;sort data by primary service facility, patient, fee program, vendor, date
 Q:$$FILTER^FBPCR4()=0
 I $P(Y,U,9)'=FBPI Q
 S ^TMP($J,"FB",FBPSF,FBPAT,FBP,FBVEN,I,L_M)=FBDT1_U_FBAACPTC_FBCP_$S($G(FBMODLE)]"":"-"_FBMODLE,1:"")_U_A1_U_A2_U_T_U_FBBN_U_FBIN_U_D2_U_FBSC_U_FBPDX_U_FBOB_U_FBPI_U_FBCATC_U_FBINS
 S ^TMP($J,"FB",FBPSF,FBPAT,FBP,FBVEN,I,L_M,"FBADJ")=TAMT_U_FBUNITS_U_FBADJLR_U_FBADJLA_U_FBRRMKL_U_FBCSID
 Q
SETTR S D=$S($D(^FBAAC(J,1,K,1,L,0)):$P(^(0),"^",1),1:""),A3=".00"
 I D]"",$D(^FBAAC(J,3,"AB",D)) S FBTA=$O(^FBAAC(J,3,"AB",D,0)),A3=$S($P(^FBAAC(J,3,FBTA,0),"^",3)]"":$P(^(0),"^",3),1:.0001)
 S FBDT=$$DATX^FBAAUTL(D)
 Q
EN1 ;entry point to set variables, called by fbpcr67, anc
 N FBVEN,FBPAT,FBDT1
 D SETTR,SET
 Q
PRINT ;write output
 D HDR1 S FBVI="" F  S FBVI=$O(^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI)) Q:FBVI']""!(FBOUT)  D SH Q:FBOUT  D  Q:FBOUT
 .S FBDT=0 F  S FBDT=$O(^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT)) Q:'FBDT  S M=0 F  S M=$O(^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT,M)) Q:'M  D  Q:FBOUT
 ..I ($Y+4)>IOSL D PAGE Q:FBOUT
 ..S FBDATA=^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT,M),FBCATC=$P(FBDATA,U,13),FBINS=$P(FBDATA,U,14)
 ..S FBADJ=$G(^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT,M,"FBADJ"))
 ..;S FBLOC=1_U_12_U_23_U_33_U_47_U_57_U_63_U_71
 ..W !
 ..;S I=1 W ?$P(FBLOC,U,I),$P(FBDATA,U,I)
 ..W ?1,$P(FBDATA,U,1)
 ..;S I=2 W ?$P(FBLOC,U,I),$P($P(FBDATA,U,I),",")
 ..W ?11,$P($P(FBDATA,U,2),",")
 ..;F I=3:1:8 W ?$P(FBLOC,U,I),$P(FBDATA,U,I)
 ..W ?31,$J($P(FBADJ,U,2),10)
 ..W ?43,$P(FBDATA,U,6)
 ..W ?54,$P(FBDATA,U,7)
 ..W ?64,$P(FBDATA,U,8)
 ..I $P($P(FBDATA,U,2),",",2)]"" D  Q:FBOUT
 ...N FBI,FBMOD
 ...F FBI=2:1 S FBMOD=$P($P(FBDATA,U,2),",",FBI) Q:FBMOD=""  D  Q:FBOUT
 ....I $Y+7>IOSL D PAGE Q:FBOUT  W !,"  (continued)"
 ....W !,?16,"-",FBMOD
 ..W !,$P(FBDATA,U,3)
 ..W ?13,$P(FBDATA,U,4)
 ..W ?23,$S($P(FBADJ,U,3)]"":$P(FBADJ,U,3),1:$P(FBDATA,U,5))
 ..W ?33,$J($S($P(FBADJ,U,4)]"":$J($P(FBADJ,U,4),14),1:$P(FBADJ,U,1)),14)
 ..W ?48,$P(FBADJ,U,5)
 ..W ?60,$P(FBADJ,U,6)
 ..S FBPDX=$P(FBDATA,U,10),FBPDXC=$$ICD9^FBCSV1(FBPDX,$$DT2FMDT^FBCSV1($P(FBDATA,U))),$P(FBDATA,U,10)=$E($$ICD9P^FBCSV1(FBPDX,3,$$DT2FMDT^FBCSV1($P(FBDATA,U))),1,19),FBPDXC=$S(FBPDXC="":"",1:" ("_FBPDXC_")")
 ..W !?3,"Primary Dx: ",$P(FBDATA,U,10),FBPDXC,?45,"S/C Condition? ",$P(FBDATA,U,9) W ?66,"Obl.#: ",$P(FBDATA,U,11)
 ..I FBCATC!FBINS D
 ...W !?5,">>>"
 ...I FBCATC=0 W "Cost recover from insurance."
 ...I FBCATC=1 W "Cost recover from means testing"_$S(FBINS:" and insurance.",1:".")
 ...I FBCATC=2 W "Cost recover from LTC co-pay"_$S(FBINS:" and insurance.",1:".")
 ...I FBCATC=3 W $S(FBINS:"Cost recover from insurance, ",1:"")_"1010EC Missing for LTC Patient."
 ...I FBCATC=4 W $S(FBINS:"Cost Recover from insurance and ",1:"")_"Potential Cost Recover from LTC co-pay."
 ..S A3=".00"
 Q
HDR ;main header
 D HDR^FBPCR Q:FBOUT
HDR1 W !!?(IOM-(13+$L(FBXPROG))/2),"FEE PROGRAM: ",FBXPROG
 ;W !!,?2,"Svc Date",?11,"CPT-MOD",?23,"Amount",?33," Amount",?42,"Susp",?49,"Travel",?57,"Batch",?63,"Invoice",?71,"Voucher"
 ;W !,?23,"Claimed",?35,"Paid",?42,"Code",?50,"Paid",?58,"Num",?64,"Num",?72,"Date",!,FBDASH
 W !!,?1,"Svc Date",?11,"CPT-MOD ",?19,"Travel Paid",?31,"Units Paid",?43,"Batch No.",?54,"Inv No.",?64,"Voucher Date"
 W !,"Amt Claimed",?13,"Amt Paid",?23,"Adj Code",?36,"Adj Amounts",?48,"Remit Remark",?61,"Patient Account No",!,FBDASH
 Q
SH ;subheader - vendor, prints when name changed
 I ($Y+6)>IOSL D HDR Q:FBOUT
 ;W !!,"Vendor: ",$P(FBVI,";"),?41,"Vendor ID/NPI: ",$P(FBVI,";",2)
 W !!,"Vendor: ",$P(FBVI,";"),?41,"Vendor ID: ",$P($P(FBVI,";",2),"/",1)
 W !?20,"Fee Basis Billing Provider NPI: ",$P(FBVI,"/",2)
 Q
CR ;read for display
 S DIR(0)="E" W ! D ^DIR K DIR S:$D(DUOUT)!($D(DTOUT)) FBOUT=1
 Q
PAGE ;new page
 D HDR Q:FBOUT  D SH
 Q
