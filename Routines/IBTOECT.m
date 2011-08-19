IBTOECT ;OAK/ELZ- ENHANCED CLAIMS TRACKING REPORTS ;7/15/2005
 ;;2.0;INTEGRATED BILLING;**317**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
UNREV ; Main entry for the Un-reviewed Claims for Coders Report
 ;
 N IBBEG,IBEND
 ;
 D DATE^IBCONS4 Q:'$D(IBBEG)!('$D(IBEND))
 Q:$$DEV("QUNREV","IB - Unreviewed Claims for Coders Report")
 ;
QUNREV ; tasman entry
 U IO
 N IBOE,IBX,IBCT0,IBCT2,IBPNAM,IBSSN,IBOE0,IBY,IBR,IBP,IBL,IBCPT,IBMOD,IBA,IBONE,IBC,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 K ^TMP("IBTOECT",$J) S IBP=0,$P(IBL,"-",IOM)=""
 ;
 ; create sort by Outpatient Encounter then by patient name (no x-ref supports this)
 S IBOE=$$FMADD^XLFDT($P(IBBEG,"."),-1)+.99 F  S IBOE=$O(^IBT(356,"D",IBOE)) Q:'IBOE!(IBOE>(IBEND_".9999"))  S IBX=0 F  S IBX=$O(^IBT(356,"D",IBOE,IBX)) Q:'IBX  D
 . S IBCT0=$G(^IBT(356,IBX,0)),IBCT2=$G(^(2))
 . I $P(IBCT0,"^",4),$P(IBCT0,"^",24),'$P(IBCT0,"^",19),'$P(IBCT2,"^",3),$P(IBCT0,"^",2) S ^TMP("IBTOECT",$J,IBOE,$P(^DPT($P(IBCT0,"^",2),0),"^"),IBX)=""
 ;
 ;
 S IBOE=0 F  S IBOE=$O(^TMP("IBTOECT",$J,IBOE)) Q:'IBOE!($D(DIRUT))  S IBPNAM="" F  S IBPNAM=$O(^TMP("IBTOECT",$J,IBOE,IBPNAM)) Q:IBPNAM=""!($D(DIRUT))  S IBX=0 F  S IBX=$O(^TMP("IBTOECT",$J,IBOE,IBPNAM,IBX)) Q:'IBX!($D(DIRUT))  D
 . S IBCT0=$G(^IBT(356,IBX,0)) Q:'IBCT0
 . S IBSSN=$P($G(^DPT(+$P(IBCT0,"^",2),0)),"^",9)
 . S IBOE0=$G(^SCE(+$P(IBCT0,"^",4),0))
 . S IBY=$$INSUR^IBBAPI($P(IBOE0,"^",2),+IBOE0,"RB",.IBR,"1,11,16")
 . S IBCPT=0,IBONE=0
 . ;
 . I 'IBP!($Y+3>IOSL) D
 . . I $E(IOST,1,2)="C-",IBP'=0 S DIR(0)="E" D ^DIR I $D(DIRUT) Q
 . . S IBP=IBP+1
 . . W @IOF,!,"Unreviewed Claims for Coders Report  from ",$$FMTE^XLFDT(IBBEG)," to ",$$FMTE^XLFDT(IBEND),?100,$$FMTE^XLFDT(DT),?115,"Page: ",IBP
 . . W !,"Patient Name",?27,"SSN",?39,"Visit Date",?58,"Location",?80,"CPTs",?87,"Mod",?91,"Insurance",?113,"Exp Date",?125,"Bill",!,IBL
 . Q:$D(DIRUT)
 . W:$X ! W $E(IBPNAM,1,25),?27,IBSSN,?39,$$FMTE^XLFDT(+IBOE0,2),?58,$E($P($G(^SC(+$P(IBOE0,"^",4),0)),"^"),1,20)
 . S:$P(IBCT0,"^",3) IBCPT=$$GETIENS^PXAAVCPT($P(IBCT0,"^",3),.IBCPT)
 . S (IBC,IBCPT)=0 F  S IBCPT=$O(IBCPT(IBCPT)) Q:'IBCPT  D
 . . S IBC=IBC+1,IBONE=1
 . . S IBA(IBC)=$$CPT^PXAAVCPT(IBCPT)
 . . D:$P(IBCT0,"^",3) CPTMODIF^PXAAVCPT($P(IBCT0,"^",3),.IBMOD)
 . . S IBMOD=0 F  S IBMOD=$O(IBMOD(1,IBMOD)) Q:'IBMOD  D
 . . . S:'IBONE IBC=IBC+1
 . . . S $P(IBA(IBC),"^",2)=$G(IBMOD(1,+IBMOD,0))
 . . . S IBONE=0
 . F IBC=1:1 Q:'$D(IBA(IBC))&('$D(IBR("IBBAPI","INSUR",IBC)))  D
 . . W:$G(IBA(IBC)) ?80,$P($$CPT^ICPTCOD(+$G(IBA(IBC)),+IBOE0),"^",2)
 . . W:$P($G(IBA(IBC)),"^",2) ?87,$P($$MOD^ICPTMOD(+$P($G(IBA(IBC)),"^",2),"I",+IBOE0),"^",2)
 . . W ?91,$E($P($G(IBR("IBBAPI","INSUR",IBC,1)),"^",2),1,20)
 . . W:$G(IBR("IBBAPI","INSUR",IBC,11)) ?113,$$FMTE^XLFDT($G(IBR("IBBAPI","INSUR",IBC,11)),2)
 . . W ?125,$P($G(IBR("IBBAPI","INSUR",IBC,16)),"^",2),!
 . K IBA
 ;
 ;
 K ^TMP("IBTOECT",$J)
 D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
ENR ; entered/not reviewed report
 ;
 N IBBEG,IBEND
 ;
 D DATE^IBCONS4 Q:'$D(IBBEG)!('$D(IBEND))
 Q:$$DEV("QENR","IB - Entered/Not Reviewed Bills Report")
 ;
QENR ; tasked entry
 ;
 N IBDT,IB0,IBR,IBPNAM,IBX,DFN,IBP,IBL,IBPNAMS,IBCP,IBC,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,IBA
 U IO
 K ^TMP("IBTOECT",$J)
 ;
 ;set up some variables
 S IBR=$S($O(^DGCR(399.3,"B","REIMBURSABLE INS.",0)):$O(^DGCR(399.3,"B","REIMBURSABLE INS.",0)),1:8)
 S IBP=0,$P(IBL,"-",IOM)="",IBPNAMS=""
 ;
 ; find the bills that match criteria and sort in ^tmp
 S IBDT=$$FMADD^XLFDT($P(IBBEG,"."),-1)+.99 F  S IBDT=$O(^DGCR(399,"D",IBDT)) Q:'IBDT!(IBDT>(IBEND_".9999"))  S IBX=0 F  S IBX=$O(^DGCR(399,"D",IBDT,IBX)) Q:'IBX  S IB0=^DGCR(399,IBX,0) D
 . I $P(IB0,"^",7)=IBR,$P(IB0,"^",5)=3,$P(IB0,"^",13)=1 S ^TMP("IBTOECT",$J,$P(^DPT($P(IB0,"^",2),0),"^"),IBDT,IBX)=""
 ;
 S IBPNAM="" F  S IBPNAM=$O(^TMP("IBTOECT",$J,IBPNAM)) Q:IBPNAM=""!($D(DIRUT))  S IBDT=0 F  S IBDT=$O(^TMP("IBTOECT",$J,IBPNAM,IBDT)) Q:'IBDT!($D(DIRUT))  S IBX=0 F  S IBX=$O(^TMP("IBTOECT",$J,IBPNAM,IBDT,IBX)) Q:'IBX!($D(DIRUT))  D
 . S IB0=$G(^DGCR(399,IBX,0)),DFN=$P(IB0,"^",2) Q:'DFN
 . D DEM^VADPT,ELIG^VADPT
 . I 'IBP!($Y+5>IOSL) D
 . . I $E(IOST,1,2)="C-",IBP'=0 S DIR(0)="E" D ^DIR I $D(DIRUT) Q
 . . S IBP=IBP+1
 . . W @IOF,!,"Entered/Not Reviewed Bills Report  from ",$$FMTE^XLFDT(IBBEG)," to ",$$FMTE^XLFDT(IBEND),?100,$$FMTE^XLFDT(DT),?115,"Page: ",IBP
 . . W !,"Bill #",?12,"Primary Insurance",?34,"Clinic",?44,"Date",?56,"Proc",?63,"Provider",?85,"RNB",?107,"Billable Findings",!,IBL
 . Q:$D(DIRUT)
 . W:IBPNAMS'=IBPNAM !,"Name: ",$E(VADM(1),1,25),?33,"Sex: ",$P(VADM(5),"^"),?42,"SSN: ",$P(VADM(2),"^",2),?61,"Age: ",VADM(4),?70,"MT Status: ",$P(VAEL(9),"^",2)
 . S IBPNAMS=IBPNAM
 . W:$X ! W $P(IB0,"^"),?12,$E($P($G(^DIC(36,+^DGCR(399,IBX,"M"),0)),"^"),1,20)
 . ; IBA format:  399 sub CP ien ^ RNB (ien) (only one) ^ billable findings description (ien)
 . S (IBCP,IBC)=0 F  S IBCP=$O(^DGCR(399,IBX,"CP",IBCP)) Q:'IBCP  S IBC=IBC+1,IBA(IBC)=IBCP
 . S IBCT=$O(^IBT(356,"E",IBX,0)),$P(IBA(1),"^",2)=$P($G(^IBT(356,+IBCT,0)),"^",19)
 . S (IBCP,IBC)=0 F  S IBCP=$O(^IBT(356,+IBCT,3,IBCP)) Q:'IBCP  S IBC=IBC+1,$P(IBA(IBC),"^",3)=$G(^IBT(356,IBCT,3,IBCP,0))
 . F IBC=1:1 Q:'$D(IBA(IBC))  D
 . . S IBCP=$G(^DGCR(399,IBX,"CP",+IBA(IBC),0))
 . . W ?34,$E($P($G(^SC(+$P(IBCP,"^",7),0)),"^"),1,7)
 . . W ?44,$$FMTE^XLFDT($P(IBCP,"^",2),2)
 . . W ?56,$$EXTERNAL^DILFD(399.0304,.01,,$P(IBCP,"^"))
 . . W ?63,$E($P($G(^VA(200,+$P(IBCP,"^",18),0)),"^"),1,20)
 . . W ?85,$E($P($G(^IBE(356.8,+$P(IBA(IBC),"^",2),0)),"^"),1,20)
 . . W ?107,$E($P($G(^IBT(356.85,+$P(IBA(IBC),"^",3),0)),"^"),1,20),!
 . K IBA
 ;
 K ^TMP("IBTOECT",$J)
 D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 ;
 Q
 ;
DEV(ZTRTN,ZTDESC) ; -- ask device
 N ZTSAVE,IBRTN,%ZIS,POP,ZTSK
 ;
 W !!,"*** Margin width of this output is 132 ***"
 W !,"*** This output should be queued ***"
 ;
 S %ZIS="QM" D ^%ZIS I POP Q 1
 I $D(IO("Q"))  D  Q 1
 .S ZTRTN=ZTRTN_"^IBTOECT",ZTSAVE("IB*")=""
 .D ^%ZTLOAD,HOME^%ZIS W "Task #",ZTSK K IO("Q")
 Q 0
