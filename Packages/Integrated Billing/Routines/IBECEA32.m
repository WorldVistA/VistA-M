IBECEA32 ;ALB/CPM-Cancel/Edit/Add... Add Utilities; 02-APR-93
 ;;2.0;INTEGRATED BILLING ;**57,188**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
CLUPD ; Handle the updating of the billing clock when adding a charge.
 I IBXA=5!(IBCLDA&(IBXA=4)) G CLOCKQ
 ;
 ; - charge not covered by a clock
 I 'IBCLDA D ADD G CLOCKQ
 ;
 ; - update existing clock
 S IBCLST=^IBE(351,IBCLDA,0)
 D CLOCK^IBECEAU(IBCHG,+$P(IBCLST,"^",9),IBUNIT)
CLOCKQ K IBCLST
 Q
 ;
CHMPVA ; Process the CHAMPVA inpatient subsistence charge.
 I '$$ON^IBACVA2() W !!,"Sorry!  The CHAMPVA billing module is not yet fully installed.  You will need",!,"to generate a claim to bill this patient the inpatient subsistence charge." G CHMPVAQ
CHMPEN S IBPM=$$ADSEL^IBECEA31(DFN) I IBPM=-1 G CHMPVAQ
 I 'IBPM W !!,"This patient has no admissions on file!",!,"You cannot bill the CHAMPVA inpatient subsistence charge at this time." G CHMPVAQ
 S IBSL=+IBPM,IBCVA=$P(IBPM,"^",2),IBPMD=$P(IBPM,"^",3)
 I 'IBPMD W !!,"You can only bill admissions which have been discharged!" G CHMPEN
 I $$PREV^IBACVA1(DFN,IBCVA,IBSL) W !!,"This admission has already been billed the CHAMPVA inpatient subsistence charge."  G CHMPEN
 ;
 ; - set input parameters and automatically calculate the charge
 S IBBDT=$$FMTH^XLFDT(IBCVA,1),IBEDT=$$FMTH^XLFDT(+$G(^DGPM(IBPMD,0))\1,1)
 D BILL^IBACVA1
CHMPVAQ K IBPM,IBSL,IBCVA
 Q
 ;
ADD ; Prompt user to add a new billing clock.
 N DIE,DA,DR,DIR,DIRUT,DUOUT,DTOUT,X,Y
 W !!,"Since this patient has no active clock to cover this charge, I would like to",!,"set up an active clock as follows:"
 W !!?5,"Clock Begin Date: ",$$DAT1^IBOUTL(IBFR),! W:IBXA=1!(IBXA=2) ?4,"1st 90 days copay: $",IBCHG,! W:IBXA=3 ?5,"# Inpatient days: ",IBUNIT,!
 S DIR(0)="Y",DIR("A")="Is it okay to set up a new clock with "_$S(IBXA=4:"this",1:"these")_" value"_$E("s",IBXA'=4),DIR("?")="Enter 'Y' or 'YES' to create a new clock, or 'N', 'NO', or '^' to quit."
 D ^DIR I 'Y!($D(DIRUT))!($D(DUOUT)) W !,"A new clock will not be established.  Be sure this patient's clock is correct." Q
 W !!,"Creating a new, active billing clock...  "
 S IBCLDT=IBFR D CLADD^IBAUTL3 Q:IBY<0
 I IBXA'=4 S DIE="^IBE(351,",DA=IBCLDA,DR=$S(IBXA=3:.09,1:.05)_"////"_$S(IBXA=3:IBUNIT,1:IBCHG)_";13////"_DUZ_";14///NOW" D ^DIE
 W "done."
 Q
 ;
FEPR ; Issue prompts for Inpatient Fee Services
 N DIR,DIRUT,DUOUT,DTOUT,IBCLDT,X,Y
 S IBDESC=$S(IBXA=1:"FEE SERVICE (INPT)",1:$P($G(^IBE(350.1,+$G(IBATYP),0)),"^",8))
 D FEE^IBECEAU2(0) I IBY>0 D CTBB^IBECEAU3
 Q
 ;
HFEV ; Help for Fee Event Date
 W !!,"Please enter the Event Date for this Fee Service (which should be the"
 W !,"admission date, and not exceed the Bill From date [",$$DAT1^IBOUTL(IBFR),"]), or '^' to quit."
 Q
 ;
SPEC(X,Y) ; Display messages for special inpatient billing cases.
 ;  Input:  X -- has two values:
 ;                1 --> entering after selecting an admission
 ;                      (will need to set IBSIBC)
 ;                0 --> billing event record exists
 ;          Y -- Pointer to special inpatient billing case in
 ;               file #351.2 (quit if not positive)
 Q:'$G(Y)
 I $G(X),'$P($G(^IBE(351.2,Y,0)),"^",8) D  Q
 .S IBSIBC=+IBDG
 .W !,"This is a special inpatient billing case!  The case will be dispositioned."
 W !,*7,"Please note that you are creating a charge for a special inpatient case!!"
 S IBSIBC1=Y D DSPL^IBAMTI1(Y)
 Q
