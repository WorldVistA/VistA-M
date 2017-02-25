IBECEAU2 ;ALB/CPM-Cancel/Edit/Add... User Prompts ; 19-APR-93
 ;;2.0;INTEGRATED BILLING;**7,52,153,176,545,563**;21-MAR-94;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
REAS(IBX) ; Ask for the cancellation reason.
 ; Input:   IBX  --  "C" (Cancel a charge), "E" (Edit a Charge)
 S DIC="^IBE(350.3,",DIC(0)="AEMQZ",DIC("A")="Select "_$S(IBX="E":"EDIT",1:"CANCELLATION")_" REASON: "
 S DIC("S")=$S(IBXA=7:"I 1",IBXA=6:"I $P(^(0),U,3)=3",IBXA=5:"I ($P(^(0),U,3)=1)!($P(^(0),U,3)=3)",1:"I ($P(^(0),U,3)=2)!($P(^(0),U,3)=3)")
 D ^DIC K DIC S IBCRES=+Y I Y<0 W !!,"No ",$S(IBX="E":"edit",1:"cancellation")," reason entered - the transaction cannot be completed."
 Q
 ;
UNIT(DEF) ; Ask for units for Rx copay charges
 ; Input:   DEF  --  Default value if previous charge is to be displayed
 N DA,DIR,DIRUT,DUOUT,DTOUT,X,X1,Y
 S DA=IBATYP,IBDESC="RX COPAYMENT" D COST^IBAUTL S IBCHG=X1
 S DIR(0)="N^::0^K:X<1!(X>12) X",DIR("A")="Units",DIR("?")="^D HUN^IBECEAU2"
 S:DEF DIR("B")=DEF D ^DIR I Y S IBUNIT=Y,IBCHG=IBCHG*Y
 I 'Y W !!,"Units not entered - transaction cannot be completed." S IBY=-1
 Q
 ;
FR(DEF) ; Ask Bill From Date
 ; Input:   DEF  --  Default value if previous charge is to be displayed
 N DA,DIR,DIRUT,DUOUT,DTOUT,X,X1,Y
FRA S:$G(DEF) DIR("B")=$$DAT2^IBOUTL(DEF)
 S DIR(0)="DA^2901001:"_IBLIM_":EX",DIR("A")=$S(IBXA=4!(IBXA=7):"Visit Date: ",IBXA=5:"Rx Date: ",1:"Charge for services from: "),DIR("?")="^D HFR^IBECEAU2"
 D ^DIR K DIR S IBFR=Y I 'Y W !!,$S(IBXA=4!(IBXA=7):"Visit",IBXA=5:"Rx",1:"Bill From")," Date not entered - transaction cannot be completed." S IBY=-1 G FRQ
 I IBXA=7 G FRQ
 I IBXA'=8,IBXA'=9,IBXA'=5,'$$BIL^DGMTUB(DFN,IBFR+.24) D CATC G FRA
 I IBXA>7,IBXA<10,$$LTCST^IBAECU(DFN,IBFR,1)<2 W !,"This patient is not LTC billable on this date.",! G FRA
 I IBXA=4,$$BFO^IBECEAU(DFN,IBFR) W !!,"This patient has already been billed the outpatient copay charge for ",$$DAT1^IBOUTL(IBFR),".",! G FRA
FRQ Q
 ;
TO(DEF) ; Ask Bill To Date
 ; Input:   DEF  --  Default value if previous charge is to be displayed
 N DA,DIR,DIRUT,DUOUT,DTOUT,X,X1,Y
TOA S:$G(DEF) DIR("B")=$$DAT2^IBOUTL(DEF)
 S DIR(0)="DA^"_IBFR_":"_IBLIM_":EX",DIR("A")="  Charge for services to: ",DIR("?")="^D HTO^IBECEAU2"
 D ^DIR K DIR S IBTO=Y I 'Y W !!,"Bill To date not entered - transaction cannot be completed." S IBY=-1 G TOQ
 I IBTO'=IBFR,'$$BIL^DGMTUB(DFN,$S(IBXA=3&'$G(DEF):$$FMADD^XLFDT(IBTO,-1),1:IBTO)+.24),IBXA'=8,IBXA'=9 D CATC G TOA
TOQ Q
 ;
FEE(DEF) ; Ask for Fee Amount
 ; Input:   DEF  --  Default value if previous charge is to be displayed
 N DIR,DIRUT,DUOUT,DTOUT,X,Y
 S:$G(DEF) DIR("B")=DEF
 S DIR(0)="NA^::2^K:X<0!(X>(IBMED-IBCLDOL)) X",DIR("A")="              Fee Amount: ",DIR("?")="^D HFEE^IBECEAU2"
 D ^DIR S IBCHG=Y I 'Y W !!,"Charge not entered - transaction cannot be completed." S IBY=-1
 Q
 ;
AMT ; Ask for Charge Amount
 N DIR,DIRUT,DUOUT,DTOUT,X,Y
 S DIR(0)="NA^::2^K:X<0!(X>99999) X",DIR("A")="Charge Amount: ",DIR("?")="^D HAMT^IBECEAU2"
 D ^DIR S IBCHG=Y I 'Y W !!,"Charge not entered - transaction cannot be completed." S IBY=-1
 Q
 ;
CATC ; Display that patient is not Means Test billable.
 W !!,"The patient ",$S(IBFR<DT:"was",1:"is")," not Means Test billable on this date.",!
 Q
 ;
HUN ; Help for units
 W !!,"Please enter 1, 2, 3, ...,12 to denote a 30, 60, 90, ...,360 days supply of"
 W !,"medication, or '^' to quit."
 Q
 ;
HFR ; Help for Bill From date
 W !!,"Please enter the ",$S(IBXA=4!(IBXA=7):"patient's outpatient visit date",IBXA=5:"patient's prescription date",1:"'Bill From' date for this charge"),$S(IBXA'=5:", which must follow",1:"")
 W !,$S(IBXA=5:"today or prior to today",1:"10/1/90"_$S(IBXA=4!(IBXA=7):"",1:" (and be prior to today)")),", or '^' to quit."
 Q
 ;
HTO ; Help for Bill To date
 W !!,"Please enter the 'Bill To' date for this charge, which may not precede"
 W !,$$DAT1^IBOUTL(IBFR),", or '^' to quit."
 Q
 ;
HFEE ; Help for Fee Amount
 W !!,"Please enter the charge for this Fee Service, which may not be greater than"
 W !,"the difference between the Medicare Deductible amount and the "
 W $$INPT^IBECEAU(IBCLDAY)," 90 days",!,"copay billed ($",IBMED-IBCLDOL,"), or '^' to quit."
 Q
 ;
HAMT ; Help for Charge Amount
 W !!,"Please enter the charge for this copayment."
 Q
 ;
TIER(IBATYP,IBEFDT,TIER) ; Prompt if needed for copay tier
 ; IBATYP - 350.1 IB Action Type
 ; IBEFDT - Date for possible tier choice or not if only one tier available
 ; TIER - {optional) default tier, if none specified, then 2 used
 N IB,IBN,IBD,IBEND,IBFTIER,IBLTIER,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,DIR,IBTIER
 S IBD=-($G(IBEFDT,DT)+.9),IBD=$O(^IBE(350.2,"AIVDT",IBATYP,IBD)),IBEND=$O(^IBE(350.2,"AIVDT",IBATYP,IBD))
 S IBN=0 F  S IBN=$O(^IBE(350.2,"AIVDT",IBATYP,IBD,IBN)) Q:'IBN  S IB=$G(^IBE(350.2,IBN,0)) I IB]"",'$P(IB,"^",5)!($P(IB,"^",5)>IBEFDT) S IBTIER($P(IB,"^",7))=""
 ; if only one tier don't prompt just use it
 S IBFTIER=$O(IBTIER(0)) I '$O(IBTIER(IBFTIER)) Q IBFTIER
 S IBLTIER=$O(IBTIER(1000),-1)
 S DIR(0)="N^"_IBFTIER_":"_IBLTIER_":0"
 S DIR("A")="ENTER THE COPAY TIER"
 S DIR("B")=$S($G(TIER):TIER,1:2)
 S DIR("?")="Enter the copayment tier for this charge, it will be used to determine the per unit rate."
 D ^DIR
 I $D(DIRUT) S IBY=-1 Q 0
 Q Y
