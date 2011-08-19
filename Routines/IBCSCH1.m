IBCSCH1 ;ALB/MRL - BILLING HELPS (CONTINUED) ; 01 JUN 88 12:00
 ;;2.0;INTEGRATED BILLING;**106,125,51,245,266,395**;21-MAR-94;Build 3
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;MAP TO DGCRSCH1
 ;
1 W !!,"DO YOU WISH TO ADD/EDIT INSURANCE COMPANY DATA FOR THIS PATIENT" S %=2 D YN^DICN S IBADI=$S(%=1!(%=-1):%,1:0)
 I '% W !!?4,"YES - And I'll prompt you so that you may add insurance data to the PATIENT",!?9,"file for this patient.",!?4,"NO  - To bypass this editing of the PATIENT file." G 1
 Q
 ;
2 W !!,"If you updated insurance information for any policy which is already specified",!,"as either a PRIMARY, SECONDARY or TERIARY for this billing episode, you will"
 W !,"need to press the <RETURN> key through the following prompts in order to insure",!,"that these new values are properly stored.  If you fail to do so, i.e.,"
 W !,"enter an up-arrow, the new values will not be stored as part of this billing",!,"record." Q
3 I '$D(IBIFN),$D(DA) S IBIFN=DA
 W !,"If a procedure is linked as a prescription to a rev code, it cannot be deleted",!
 W:$P(^DGCR(399,IBIFN,0),"^",5)<3 !!?4," - Enter the alphanumeric designation of your choice from",!?7,"the display (e.g. 'A1') to input one of the codes shown",!?7,"above into this billing record."
 I $P(^IBE(350.9,1,1),U,15)'=1 G 4
 S DGCODMET=$P(^DGCR(399,IBIFN,0),"^",9),DGCODMET=$S(DGCODMET=9:"ICD",DGCODMET="":"",1:"CPT")
 W !!?4," - Enter the name or code number of an ",$S($D(IBPY):"ICD DIAGNOSIS ",1:DGCODMET_" PROCEDURE "),"CODE",!?7,"not displayed above to input a ",$S($D(IBPY):"DIAGNOSIS",1:"PROCEDURE")," code"
 I $P(^DGCR(399,IBIFN,0),"^",5)>2 W "." G 4
 W " not found",!?7,"in the PTF record into this billing record, or '??' for ",!?7,"a list of all ",$S($D(IBPY):"ICD DIAGNOSIS ",1:DGCODMET_" PROCEDURE "),"CODES."
4 W !!?4," - Enter <RETURN> to accept the default ",$S($D(IBPY):"DIAGNOSIS ",1:"PROCEDURE "),"code, or",!?7,"'^' to abort.",!!
 K DGCODMET
 Q
 ;
DISPPRC(IBIFN) ; display procedures
 N IBHDR,IBHDR1,IBD,IBN,IBI,IBX,IBQ,IBLN,IBPR,IBPRD,IBDT,IBDV,IBCL,IBPV,IBLC,PRCARR,IBMOD,IBSUS,IBDATE
 S IBQ=0
 ;
 I '$O(^DGCR(399,+$G(IBIFN),"CP",0)) W !!?5,"No Codes Entered!",! D PAUSE^VALM1 Q
 ;
 S IBDATE=$$BDATE^IBACSV(IBIFN)
 S IBHDR="W @IOF,!,""Procedures Assigned to this Bill"",!,""Code"",?10,""Procedure"",?35,""PO"",?38,""Date"",?48,""Div"",?55,""Clinic"",?68,""Provider"" X IBHDR1"
 S IBHDR1="W !,""--------------------------------------------------------------------------------"" S IBLC=2"
 ;
 X IBHDR D PRCDT^IBCU71(+IBIFN,.PRCARR)
 S IBD="" F  S IBD=$O(PRCARR(IBD)) Q:IBD=""  D  Q:IBQ
 . S IBN="" F  S IBN=$O(PRCARR(IBD,IBN)) Q:IBN=""  D  Q:IBQ
 .. S IBI=0 F  S IBI=$O(PRCARR(IBD,IBN,IBI)) Q:'IBI  D  I IBLC>19 S IBQ=$$PAUSE(IBLC) Q:IBQ  X IBHDR
 ... S IBLN=$G(PRCARR(IBD,IBN,IBI)),(IBPR,IBPRD,IBDT,IBDV,IBCL,IBPV,IBSUS)="",IBLC=IBLC+1
 ... S IBX=$$PRCNM($P(IBLN,U,1),IBD),IBPR=$P(IBX,U,1),IBPRD=$P(IBX,U,2)
 ... S IBDT=$P(IBLN,U,2),IBDT=$E(IBDT,4,5)_"/"_$E(IBDT,6,7)_"/"_$E(IBDT,2,3)
 ... I +$P(IBLN,U,6) S IBDV=$P($G(^DG(40.8,+$P(IBLN,U,6),0)),U,2)
 ... I +$P(IBLN,U,7) S IBCL=$P($G(^SC(+$P(IBLN,U,7),0)),U,1)
 ... I +$P(IBLN,U,18) S IBPV=$P($G(^VA(200,+$P(IBLN,U,18),0)),U,1)
 ... I +$P(IBLN,U,16) S IBSUS=$P(IBLN,U,16)_"mn"
 ... I +$P(IBLN,U,21) S IBSUS=$P(IBLN,U,21)_"ml"
 ... I +$P(IBLN,U,22) S IBSUS=$P(IBLN,U,22)_"hr"
 ... ;
 ... W !,$E(IBPR,1,6),?7,$E(IBPRD,1,20),?29,IBSUS,?35,$P(IBLN,U,4),?38,IBDT,?48,IBDV,?55,$E(IBCL,1,11),?68,$E(IBPV,1,12)
 ... S IBX=$$MODLST^IBEFUNC2($$GETMOD^IBEFUNC(IBIFN,IBI),1,.IBX,IBD)
 ... I IBX'="" F IBMOD=1:1:$L(IBX,",") W !,?10,$P(IBX,",",IBMOD),?15,$P($G(IBX(1)),",",IBMOD) S IBLC=IBLC+1
 I 'IBI,'IBQ S IBQ=$$PAUSE(IBLC)
 Q
 ;
PRCNM(PRC,EFDT) ; return procedure name, input first piece of CP node -
 ;                                        (in variable pointer format)
 ; output: code ^ name
 N IBNM
 S IBNM=$$PRCD^IBCEF1($G(PRC),1,$G(EFDT))
 I $TR(IBNM,U)="" D
 . S IBNM="NO ENTRY FOUND^"
 E  D
 . S IBNM=$P(IBNM,U,2,3)
 Q IBNM
 ;
PAUSE(CNT) ;
 N IBI F IBI=CNT:1:20 W !
 N DIR,DUOUT,DTOUT,DIRUT,IBX,X,Y S IBX=0,DIR(0)="E" D ^DIR K DIR I $D(DIRUT) S IBX=1
 Q IBX
 ;
DISPRX(IBIFN) ; display prescriptions
 N IBHDR,IBHDR1,IBX,IBZ,IBRXL,IBNPI,IBRX,IBQ,IBORG
 S IBQ=0
 ;
 I '$O(^IBA(362.4,"AIFN"_IBIFN,0)) W !!?5,"No Prescriptions Entered!",! D PAUSE^VALM1 Q
 ;
 ; get NPIs
 S IBX=$$RXSITE^IBCEF73A(IBIFN,.IBRXL)
 ;
 S IBHDR="W @IOF,!,""Prescriptions Assigned to this Bill"" X IBHDR1"
 S IBHDR1="W !,""--------------------------------------------------------------------------------"" "
 ;
 X IBHDR
 S IBRX=0 F  S IBRX=$O(^IBA(362.4,"AIFN"_IBIFN,IBRX)) Q:'IBRX!(IBQ)  S IBX=0 F  S IBX=$O(^IBA(362.4,"AIFN"_IBIFN,IBRX,IBX)) Q:'IBX!(IBQ)  D
 . S IBZ=$G(^IBA(362.4,IBX,0))
 . W !?5,"RX #: ",$P(IBZ,"^")
 . W ?50,"DATE: ",$$FMTE^XLFDT($P(IBZ,"^",3))
 . W !?5,"DRUG: ",$$EXTERNAL^DILFD(362.4,.04,"",$P(IBZ,"^",4))
 . W ?50,"NDC: ",$P(IBZ,"^",8)
 . W !?5,"DAYS SUPPLY: ",$P(IBZ,"^",6)
 . W ?50,"QUANTITY: ",$P(IBZ,"^",7)
 . S IBORG=$G(IBRXL(+$P(IBZ,"^",5),+$P(IBZ,"^",3)))
 . ; ia #4532
 . S IBNPI=$S(IBORG:$P($$NPI^XUSNPI("Organization_ID",IBORG),U),1:"")
 . W !?5,"NPI INSTITUTION: ",$S(IBORG:$$EXTERNAL^DILFD(350.9,.02,"",IBORG),1:"")
 . W ?50,"RX NPI: ",$S(IBNPI>0:IBNPI,1:"")
 . W !?5,"PROVIDER: ",$S($P(IBZ,"^",5):$$RXAPI1^IBNCPUT1($P(IBZ,"^",5),4),1:""),!
 . I $Y+7>IOSL S IBQ=$$PAUSE(0)
 D PAUSE^VALM1
 ;
 Q
 ;
