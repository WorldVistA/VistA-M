FBPCR3 ;AISC/GRR,TET-PHARMACY POTENTIAL COST RECOVERY, SORT/PRINT ;30 Jun 2006  1:49 PM
 ;;3.5;FEE BASIS;**48,69,98**;JAN 30, 1995;Build 54
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EN ;entry point
 S (FBCATC,FBINS,FBPSF)=0
SORT ;sort by date certified for payment, patient, invoice number ien, rx ien
 S I=FBBDATE-.1 F  S I=$O(^FBAA(162.1,"AA",I)) Q:'I!(I>FBEDATE)  S J=0 F  S J=$O(^FBAA(162.1,"AA",I,J)) Q:'J  D
 .S DFN=J D VET^FBPCR
 .S K=0 F  S K=$O(^FBAA(162.1,"AA",I,J,K)) Q:K'>0  S L=0 F  S L=$O(^FBAA(162.1,"AA",I,J,K,L)) Q:L'>0  D  S (FBCATC,FBINS,FBPSF)=0
 ..D SET Q:'FBPSV&('$D(FBPSV(FBPSF)))  I FBCATC!FBINS D SETTMP
KILL ;kill variables set in sort
 K A1,A2,DFN,FBAAA,FBAC,FBAP,FBBATCH,FBCATC,FBDA1,FBDRUG,FBFD,FBFD1,FBIN,FBINS,FBINVN,FBLOC,FBPAT,FBPD,FBPSF,FBPV,FBQTY,FBREIM,FBRX,FBSC,FBSTR,FBSUSP,FBVEN,FBVI,I,J,K,L,N,V,Y
 K FBVNAME,FBVID,FBVCHAIN,FBPNAME,FBPID,FBDOB
 K FBADJLA,FBADJLR,TAMT,FBRRMKL
 D KILL^FBPCR2
 Q
SET ;set variables
 N FBX
 S Y(0)=$G(^FBAA(162.1,+K,"RX",+L,0)) I Y(0)']""!($P(Y(0),U,9)=1) Q
 I $G(^FBAA(162.1,+K,"RX",+L,"FBREJ"))]"" Q
 S Y(2)=$G(^FBAA(162.1,+K,0))
 S Y(1)=$G(^FBAA(162.1,+K,"RX",+L,2))
 S FBX=$$ADJLRA^FBRXFA(+L_","_+K_",")
 S FBADJLR=$P(FBX,U) ;adjustment code
 S FBADJLA=$P(FBX,U,2) ;adjustment amount
 S TAMT=$FN($P(Y(0),"^",7),"",2) ;suspend amount
 S FBRRMKL=$$RRL^FBRXFR(+L_","_+K_",") ;remitt remarks
 S FBPSF=+$P(Y(1),U,5),FBFD=$P(Y(0),U,3),FBAAA=$P(Y(0),U,5)
 Q:'FBPSV&('$D(FBPSV(FBPSF)))  S FBCATC=$$CATC^FBPCR(DFN,FBFD)
 ;,FBINS=$S($O(^FBAAA("AIC",FBAAA,+$O(^FBAAA("AIC",FBAAA,-FBFD)),0))="Y":1,1:0)
 S FBINS=$S($$INSCK(FBFD,FBAAA,FBPI)=1:$$INSURED^FBPCR4(DFN,FBFD),1:0)
 Q:'FBCATC&'FBINS
 S FBINVN=$P(Y(2),U) D VEN
 S FBRX=$P(Y(0),U,1),FBDRUG=$P(Y(0),U,2),FBAC=$P(Y(0),U,4),FBAP=$P(Y(0),U,16),FBSUSP=$P(Y(0),U,8),FBPD=$P(Y(0),U,19),FBBATCH=$P(Y(0),U,17),FBBATCH=$P($G(^FBAA(161.7,+FBBATCH,0)),U)
 I FBSUSP]"" S FBSUSP=$P($G(^FBAA(161.27,+FBSUSP,0)),U)
 S FBREIM=$S($P(Y(0),U,20)="R":"*",1:""),FBSTR=$P(Y(0),U,12),FBQTY=$P(Y(0),U,13),A1=$J(FBAC,6,2),A2=$J(FBAP,6,2),FBPV=""
 S FBPD=$$DATX^FBAAUTL(FBPD),FBFD=$$DATX^FBAAUTL(FBFD)
 S FBPV=$S($P(Y(1),U,3)="V":"#",1:""),FBFD1=$S(FBPV="":" ",1:FBPV)_$S(FBREIM="":" ",1:FBREIM)_FBFD,FBRX="Rx: "_FBRX
 S FBVEN=FBVNAME_";"_FBVID,FBPAT=FBPNAME_";"_DFN
 Q
SETTMP ;sort data by primary service facility, patient, fee program, vendor, date
 Q:$$FILTER^FBPCR4()=0
 S ^TMP($J,"FB",FBPSF,FBPAT,FBPI,FBVEN,I,K_L)=FBFD1_U_FBRX_U_FBDRUG_U_FBSTR_U_FBQTY_U_A1_U_A2_U_FBSUSP_U_FBINVN_U_FBBATCH_U_FBPD_U_FBDOB_U_FBVCHAIN_U_FBPI_U_FBCATC_U_FBINS
 S ^TMP($J,"FB",FBPSF,FBPAT,FBPI,FBVEN,I,K_L,"FBADJ")=FBADJLR_U_FBADJLA_U_FBRRMKL_U_TAMT
 S ^TMP($J,"FB",FBPSF,FBPAT,FBPI,FBVEN)=FBVCHAIN,^TMP($J,"FB",FBPSF,FBPAT)=FBDOB
 ;S FBIN(5)=$P(Y(1),U,6) I FBIN(5)]"",$D(^TMP($J,"FB",FBPSF,FBPAT,FBPI,FBVEN,I,L)) D ANC^FBPCR67
 Q
VEN ;set variables for vendor
 S V=$G(^FBAAV(+$P(Y(2),U,4),0)),FBVNAME=$E($P(V,U),1,23),FBVID=$P(V,U,2),FBVCHAIN=$P(V,U,10)
 Q
PRINT ;write output
 I FBPG>1&(($Y+10)>IOSL) D HDR Q:FBOUT
 E  D HDR1
 S FBVI="" F  S FBVI=$O(^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI)) Q:FBVI']""!(FBOUT)  D SH Q:FBOUT  D  Q:FBOUT
 .S FBDT=0 F  S FBDT=$O(^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT)) Q:'FBDT  S L=0 F  S L=$O(^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT,L)) Q:'L  D  Q:FBOUT
 ..I ($Y+6)>IOSL D PAGE Q:FBOUT
 ..S FBDATA=^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT,L),FBCATC=$P(FBDATA,U,15),FBINS=$P(FBDATA,U,16)
 ..S FBADJ=^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI,FBDT,L,"FBADJ")
 ..W !,$P(FBDATA,U),?64,$P(FBDATA,U,11),!
 ..W ?2,$P(FBDATA,U,2),?15,$P(FBDATA,U,3),?45,$P(FBDATA,U,4),?63,$P(FBDATA,U,5)
 ..W !?4,$P(FBDATA,U,6),?12,$P(FBDATA,U,7)
 ..W ?20 I $P(FBADJ,U,1)]"" W $P(FBADJ,U,1),?30,$J($P(FBADJ,U,2),14)
 ..;If no adjustment code then print suspend cpde amd amount
 ..I $P(FBADJ,U,1)="" W $P(FBDATA,U,8),?30,$J($P(FBADJ,U,4),14)
 ..W ?47,$P(FBDATA,U,9),?58,$P(FBDATA,U,10),?66,$P(FBADJ,U,3)
 ..I FBCATC!FBINS W !?5,">>> Cost recover from "_$S(FBCATC:"means testing",FBINS:"insurance",1:"") W:FBCATC&FBINS " and insurance" W "."
 ..W !
EXIT ;kill and quit
 Q
HDR ;main header
 D HDR^FBPCR Q:FBOUT
HDR1 W !!?(IOM-(13+$L(FBXPROG))/2),"FEE PROGRAM: ",FBXPROG
 W !?4,"Fill Date",?64,"Date Certified"
 W !,?15,"Drug Name",?44,"Strength",?60,"Quantity"
 W !?2,"Claimed",?12,"Paid",?20,"Adj Code",?33,"Adj Amounts",?47,"Invoice #",?58,"Batch #",?66,"Remit Remarks",!,FBDASH
 Q
SH ;subheader - vendor, prints when name changes
 I ($Y+4)>IOSL D HDR Q:FBOUT
 W !!,"Vendor: ",$P(FBVI,";"),?41,"Vendor ID: ",$P($P(FBVI,";",2),"/",1),?65,"Chain #: ",$P($G(^TMP($J,"FB",FBPSF,FBPT,FBPI,FBVI)),U)
 W !?20,"Fee Basis Billing Provider NPI: ",$P(FBVI,"/",2)
 Q
CR ;read for display
 S DIR(0)="E" W ! D ^DIR K DIR S:$D(DUOUT)!($D(DTOUT)) FBOUT=1
 Q
PAGE ;new page
 D HDR Q:FBOUT  D SH
 Q
INSCK(FBDT,FBDA1,FBPI) ;possible cost recovery fcn call
 ;Passed variables:  fbdt=fill date or treatment from date
 ;                   fbda1=ien if fee patient file, patient ien
 ;                    fbpi=fee program
 ;Output variables:   fbins=1 if possible recovery, 0 if no
 S FBINS=0,FBDT=FBDT+.1,FBDT=+$O(^FBAAA("AIC",FBDA1,-FBDT))
 I FBDT S FBINS=$O(^FBAAA("AIC",FBDA1,FBDT,0)) I FBINS="Y" D
 .N FBDA S FBDA=+$O(^FBAAA("AIC",FBDA1,FBDT,FBINS,0))
 .I $P($G(^FBAAA(FBDA1,1,FBDA,0)),U,3)'=FBPI S FBINS=0
 Q $S(FBINS="Y":1,1:0)
