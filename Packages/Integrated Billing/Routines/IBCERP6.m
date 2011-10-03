IBCERP6 ;ALB/JEH - MRA/EDI CLAIMS READY FOR EXTRACT ;12/10/99
 ;;2.0;INTEGRATED BILLING;**137,211,155,348,349**;21-MAR-94;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ;Entry point from option
 W !!,"This report provides a list of claims held in a"
 W !,"Ready for Extract status.  Users can select all bills"
 W !,"in a Ready for extract status or only those trapped due to"
 W !,"the EDI/MRA Parameters being turned off."
 ;
 S IBQUIT=0 D SELECT I IBQUIT G ENQ1
 S IBQUIT=0 D PARAM I IBQUIT G ENQ1
 ;
 W !!,"This report requires a 132 column printer.",!!
 ; - Ask device
 N %ZIS,ZTRTN,ZTSAVE,ZTDESC
 S %ZIS="QM" D ^%ZIS G:POP ENQ1
 I $D(IO("Q")) D  G ENQ1
 .S ZTRTN="BLD^IBCERP6",ZTDESC="IB - EDI/MRA Claims in Waiting Transmission Status"
 .S ZTSAVE("IB*")=""
 .D ^%ZTLOAD
 .W !!,$S($D(ZTSK):"Your task number"_ZTSK_" has been queued.",1:"Unable to queue this job.")
 .K ZTSK,IO("Q") D HOME^%ZIS
 U IO
 ;
BLD ; - Tasked entry point
 ;
 N IBSTAT,IBILL,IBREC,IBIFN,IBSTAT,IBVSIT,IBCAT,IBI,IBINS,IBPREC,IBEVDT,IBTYP,IBPG,IBCHK
 K ^TMP("IBCERP6",$J)
 S (IBI,IBIFN)=0 F  S IBI=$O(^IBA(364,"ASTAT","X",IBI)) Q:'IBI  S IBIFN=+$G(^IBA(364,IBI,0)) D
 .S IBQUIT=0
 .S IBSTAT=$$WNRBILL^IBEFUNC(IBIFN)
 .I IBSEL=2 D  I IBQUIT Q
 ..I 'IBSTAT,13[IBPARAM S IBQUIT=1 Q
 ..I IBSTAT,23[IBPARAM S IBQUIT=1 Q
 .S IBSTAT=$S(IBSTAT:"MRA",1:"EDI")
 .S IBREC=$G(^DGCR(399,+IBIFN,0))
 .S IBVSIT=$S($$INPAT^IBCEF(IBIFN,1)=1:"INP",1:"OPT")
 .S IBCAT=$S($$FT^IBCEF(IBIFN)=3:"UB04",1:"1500")
 .S IBILL=$$BN1^PRCAFN(IBIFN)
 .S IBINS=$P($G(^DIC(36,+$$CURR^IBCEF2(IBIFN),0)),U)
 .S IBPREC=$$PT^IBEFUNC(+$P(IBREC,U,2))
 .S IBEVDT=$P($G(^DGCR(399,IBIFN,"U")),U) ;Statement from date
 .;S IBTYP=$P(IBREC,U,24)_U_$P($G(^DGCR(399.1,+$P(IBREC,U,25),0)),U)_U_$P(IBREC,U,26)
 .S IBTYP=$$GET1^DIQ(399,IBIFN,.24)_U_$$GET1^DIQ(399,IBIFN,.25)_U_$$GET1^DIQ(399,IBIFN,.26)
 .S ^TMP("IBCERP6",$J,IBSTAT,IBILL)=IBILL_U_IBVSIT_U_IBCAT_U_$P(IBPREC,U)_U_$E($P(IBPREC,U,2),8,11)_U_IBEVDT_U_IBTYP_U_IBINS
 ;
PRINT ;Prints report
 S (IBQUIT,IBPG,IBEDI,IBMRA,IBTOT)=0 D HDR
 I '$D(^TMP("IBCERP6",$J)) W !!,"There are no "_$S(IBPARAM=1:"EDI",IBPARAM=2:"MRA",1:"EDI/MRA")_" records"_$S(IBSEL=2:" trapped",1:"")_" in a ready for extract status" G ENQ1
 S IBSTAT="" F  S IBSTAT=$O(^TMP("IBCERP6",$J,IBSTAT)) Q:IBSTAT=""!(IBQUIT=1)  D
 .S IBILL="" F  S IBILL=$O(^TMP("IBCERP6",$J,IBSTAT,IBILL)) Q:IBILL=""!(IBQUIT=1)  S IBREC=^(IBILL)  D
 ..I ($Y+5)>IOSL D  I IBQUIT Q
 ...D ASK I IBQUIT Q
 ...D HDR
 ..;
 ..W !,?2,$P(IBREC,U),?15,$P(IBREC,U,2),?22,$P(IBREC,U,3)
 ..W ?28,$E($P(IBREC,U,4),1,20),?50,$P(IBREC,U,5)
 ..W ?57,$$FMTE^XLFDT($P(IBREC,U,6)),?73,$E($P(IBREC,U,7),1,8)_", "_$E($P(IBREC,U,8),1,3)_", "_$E($P(IBREC,U,9),1,16),?110,$E($P(IBREC,U,10),1,20)
 ..I IBSTAT="EDI" S IBEDI=IBEDI+1
 ..E  S IBMRA=IBMRA+1
 ..S IBTOT=IBTOT+1
 W !!
 I IBEDI>0 W !,?3,"Total EDI Bills ",IBEDI
 I IBMRA>0 W !,?3,"Total MRA Bills ",IBMRA
 W !!,?3,"Total bills ",IBTOT
 K ^TMP("IBCERP6",$J)
 I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) D ^%ZISC
ENQ1 K IBPARAM,IBQUIT,IBSEL,Y,IBEDI,IBMRA,IBTOT Q
 ;
PARAM ;
 S IBPARAM=$P($G(^IBE(350.9,1,8)),U,10) ;Get MRA/EDI site parameter setting
 I IBPARAM="" D
 .W !!,"Your EDI/MRA site parameter setting is incomplete."
 .W !,"Please contact your coordinator.",!
 .S IBQUIT=1
 ;
 I IBSEL=2,IBPARAM=3 D
 .W !!,"Your site parameters are set to allow both EDI and MRA"
 .W !,"transmissions.  There is no need to run this report.",!
 .S IBQUIT=1
 Q
 ;
HDR ;Prints report heading
 ; IB*2.0*211
 ;I $E(IOST,1,2)="C-" W @IOF,*13
 I $S(IBPG:1,1:$E(IOST,1,2)="C-") W @IOF,*13
 S IBPG=IBPG+1
 W !!,?45,$S(IBSEL=2:"Trapped ",1:"")_" Claims Ready for Extract",?90,$$FMTE^XLFDT(DT),?110,"Page: ",IBPG
 W !!,?15,"Inpt/",?23,"Inst/",!,?4,"Bill #",?15,"Opt",?23,"Prof",?32,"Name"
 W ?51,"SSN",?57,"Statement Date",?89,"Type",?110,"Insurance Co."
 W !,$TR($J("",IOM)," ","=")
 Q
 ;
ASK ;
 I $E(IOST,1,2)'["C-" Q
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="E" D ^DIR
 I ($D(DIRUT))!($D(DUOUT)) S IBQUIT=1 Q
 Q
 ;
SELECT ;Report selection
 N DIR,DIROUT,DTOUT,DUOUT,DTOUT
 S IBSEL=0
 W !!  S DIR("A",1)="Do you want to print a list of:"
 S DIR("A",2)=""
 S DIR("A",3)="     1 - All bills in Ready for Extract status"
 S DIR("A",4)="     2 - Bills trapped due to EDI/MRA parameter being turned off"
 S DIR("A",5)=""
 S DIR(0)="SAXB^1:All bills;2:Trapped bills"
 W !
 S DIR("A")="Select Number: ",DIR("B")=1
 D ^DIR
 I +Y'>0 S IBQUIT=1 Q
 S IBSEL=+Y
 Q
