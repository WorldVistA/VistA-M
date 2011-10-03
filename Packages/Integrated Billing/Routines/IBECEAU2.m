IBECEAU2 ;ALB/CPM-Cancel/Edit/Add... User Prompts ; 19-APR-93
 ;;2.0;INTEGRATED BILLING;**7,52,153,176**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
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
 S DIR(0)="N^::0^K:X<1!(X>3) X",DIR("A")="Units",DIR("?")="^D HUN^IBECEAU2"
 S:DEF DIR("B")=DEF D ^DIR I Y S IBUNIT=Y,IBCHG=IBCHG*Y
 I 'Y W !!,"Units not entered - transaction cannot be completed." S IBY=-1
 Q
 ;
FR(DEF) ; Ask Bill From Date
 ; Input:   DEF  --  Default value if previous charge is to be displayed
 N DA,DIR,DIRUT,DUOUT,DTOUT,X,X1,Y
FRA S:$G(DEF) DIR("B")=$$DAT2^IBOUTL(DEF)
 S DIR(0)="DA^2901001:"_IBLIM_":EX",DIR("A")=$S(IBXA=4!(IBXA=7):"Visit Date: ",1:"Charge for services from: "),DIR("?")="^D HFR^IBECEAU2"
 D ^DIR K DIR S IBFR=Y I 'Y W !!,$S(IBXA=4!(IBXA=7):"Visit",1:"Bill From")," Date not entered - transaction cannot be completed." S IBY=-1 G FRQ
 I IBXA=7 G FRQ
 I IBXA'=8,IBXA'=9,'$$BIL^DGMTUB(DFN,IBFR+.24) D CATC G FRA
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
 W !!,"Please enter 1, 2, or 3 to denote a 30, 60, or 90 days supply of"
 W !,"medication, or '^' to quit."
 Q
 ;
HFR ; Help for Bill From date
 W !!,"Please enter the ",$S(IBXA=4!(IBXA=7):"patient's outpatient visit date",1:"'Bill From' date for this charge"),", which must follow"
 W !,"10/1/90",$S(IBXA=4!(IBXA=7):"",1:" (and be prior to today)"),", or '^' to quit."
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
