IBECEAU1 ;ALB/CPM - Cancel/Edit/Add... Clock Utilities ; 12-MAR-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**57**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
CLSTR(DFN,DATE) ; Find the billing clock in effect on DATE.
 ;   Input:      DFN  --  Pointer to the patient in file #2
 ;              DATE  --  The date which is covered by the clock
 ;  Output:   IBCLDA  --  Pointer to the clock in file #351
 ;                        (or null if there is none)
 ;            IBCLST  --  Zeroth node of clock pointed to by
 ;                        IBCLDA  [OPTIONAL]
 N X,Y
 K IBCLST S IBCLDA=""
 I '$G(DATE)!'$G(DFN) G CLSTRQ
 S X="" F  S X=$O(^IBE(351,"AIVDT",DFN,X)) Q:'X  S IBCLDA=0 F  S IBCLDA=$O(^IBE(351,"AIVDT",DFN,X,IBCLDA)) Q:'IBCLDA  S Y=$G(^IBE(351,IBCLDA,0)) I Y,$P(Y,"^",4)'=3,$P(Y,"^",3)'>DATE S IBCLST=Y G CLSTRQ
CLSTRQ Q
 ;
CLDSP(X,NAM) ; Display Billing Clock data for NAM.
 ;   Input:        X  --  Zeroth node of clock in file #351
 ;               NAM  --  Patient name^short id^long id
 I '$G(X)!($G(NAM)="") G CLDSPQ
 W !!,"Means Test Billing Clock information for ",$P(NAM,"^")," (",$P(NAM,"^",3),")"
 W !,$TR($J("",80)," ","-")
 W !?2,"Clock Start Date: ",$$DAT1^IBOUTL($P(X,"^",3)),?42,"Clock End Date: ",$S($P(X,"^",10):$$DAT1^IBOUTL($P(X,"^",10)),1:"N/A")
 W !?6,"Clock Status: ",$S($P(X,"^",4)=1:"CURRENT",$P(X,"^",4)=2:"CLOSED",1:"UNKNOWN"),?42,"Inpatient Days: ",+$P(X,"^",9)
 W !!?2,"Medicare Deductible Co-payments:"
 W !?15,"1st 90 days: $",+$P(X,"^",5),?45,"3rd 90 days: $",+$P(X,"^",7)
 W !?15,"2nd 90 days: $",+$P(X,"^",6),?45,"4th 90 days: $",+$P(X,"^",8)
 W !,$TR($J("",80)," ","-")
CLDSPQ Q
 ;
CLINP(BEG,DIF,IBCLDA) ; Update Billing Clock Inpatient Days
 ;   Input:      BEG  --  Existing number of inpatient days
 ;               DIF  --  Days to add to clock (could be negative)
 ;            IBCLDA  --  Pointer to clock in file #351
 N DAYS,DIR,DIRUT,DUOUT,DTOUT,DIE,DA,DR,I,IBF
 I $G(BEG)=""!'$G(DIF)!'$G(IBCLDA) G CLINPQ1
 S DAYS=BEG+DIF
 I DAYS<0!(DAYS>365) W !!,"Can't update the clock to reflect ",DAYS," inpatient days.",!,"Please review this patient's clock and use the Clock Maintenance option",!,"to make any changes, if necessary." G CLINPQ1
 W ! S DIR(0)="Y",DIR("?")="Enter 'Y' or 'YES' to update the clock, or 'N', 'NO', or '^' to stop.",DIR("A")="Update the number of inpatient days from "_BEG_" to "_DAYS D ^DIR
 I 'Y!($D(DIRUT))!($D(DUOUT)) W !,"The billing clock has not been updated." G CLINPQ
 S DIE="^IBE(351,",DA=IBCLDA,DR=".09////"_DAYS_";13////"_DUZ_";14///NOW" D ^DIE
 W !,"The clock has been updated."
CLINPQ S IBF=0 F I=90,180,270 I BEG'>I,DAYS>I S IBF=1 Q
 I IBF W !!,*7,"   ** Please review to see if this patient requires a new copay charge. **"
CLINPQ1 Q
 ;
CLAMT(STR,AMT,IBCLDA) ; Update Billing Clock Medicare Deductible co-payments
 ;   Input:      STR  --  Zeroth node of clock in file #351
 ;               AMT  --  Dollar Amt to add to clock (could be negative)
 ;            IBCLDA  --  Pointer to clock in file #351
 N DAYS,DIR,DIRUT,DUOUT,DTOUT,DIE,DA,DR,IBMED,IBCLDT,NEWAMT,PTR
 I $G(STR)=""!'$G(AMT)!'$G(IBCLDA) G CLAMTQ
 S DAYS=+$P(STR,"^",9),PTR=$S(DAYS<91:5,DAYS<181:6,DAYS<271:7,1:8)
 S IBCLDT=+$P(STR,"^",3) D DED^IBAUTL3
 S NEWAMT=+$P(STR,"^",PTR)+AMT
 I NEWAMT<0 W !!,"Can't update the clock to reflect a copayment of -$",-NEWAMT,".",!,"Please review this patient's clock and use the Clock Maintenance option",!,"to make any changes, if necessary." G CLAMTQ
 I NEWAMT>IBMED W !!,"Note that the effective Medicare Deductible for this billing clock is $",IBMED,".",!,"Please note that $",NEWAMT," is beyond this limit."
 W ! S DIR(0)="Y",DIR("?")="Enter 'Y' or 'YES' to update the clock, or 'N', 'NO', or '^' to stop.",DIR("A")="Update the "_$$INPT^IBECEAU(DAYS)_" 90 days copayment from $"_+$P(STR,"^",PTR)_" to $"_NEWAMT D ^DIR
 I 'Y!($D(DIRUT))!($D(DUOUT)) W !,"The billing clock has not been updated." G CLAMTQ
 S DIE="^IBE(351,",DA=IBCLDA,DR=".0"_PTR_"////"_NEWAMT_";13////"_DUZ_";14///NOW" D ^DIE
 W !,"The clock has been updated."
CLAMTQ Q
