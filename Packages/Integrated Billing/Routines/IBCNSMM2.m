IBCNSMM2 ;ALB/CMS -MEDICARE INSURANCE INTAKE (CONT) ; 18-MAY-99
 ;;2.0;INTEGRATED BILLING;**103,133**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
MII ; -- Ask Medicare Insurance Card questions
 ;  
 ;  Output Variables:
 ;  IBNAME = Name of Insured
 ;  IBHICN = Subscriber ID
 ;  IBAEFF = Effective Date for Part A
 ;  IBBEFF = Effective Date for Part B
 ;  IBCOB/IBCOBI = Coordination of Benefits
 ;  IBQUIT=1 User timed-out or entered ^
 ;
 N DIR,DTOUT,DUOUT,DIROUT,DIRUT,X,Y,IBX
 ;
MIIA ; -- Ask user for Information
 ;
 W ! S DIR("A")="NAME OF BENEFICIARY"
 S IBX=$P($G(IBARR("A",1)),"^",18) I IBX="" S IBX=$P($G(IBARR("B",1)),"^",18)
 S DIR("B")=$S($G(IBNAME)'="":IBNAME,IBX'="":IBX,1:$P(^DPT(DFN,0),U))
 S DIR(0)="F^3:30^K:X'?1E.E1"","".1E.E X"
 S DIR("?")="Enter the Name of Beneficiary (Last name, First) from the Medicare Insurance Card.  This name should be 3 to 30 characters in length."
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) K DUOUT,DTOUT,DIROUT,DIRUT S IBQUIT=1 G MIIQ
 S IBNAME=Y
 ;
 S DIR("A")="MEDICARE CLAIM NUMBER"
 S IBX=$P($G(IBARR("A",1)),"^",3) I IBX="" S IBX=$P($G(IBARR("B",1)),"^",3)
 I $G(IBHICN)'="" S DIR("B")=IBHICN
 I IBX'="",'$D(DIR("B")) S DIR("B")=IBX
 S DIR(0)="F^7:15^I '$$VALHIC^IBCNSMM($TR(X,""-"")) K X"
 S DIR("?")="^D HICH^IBCNSMM2"
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) K DUOUT,DTOUT,DIROUT,DIRUT S IBQUIT=1 G MIIQ
 S IBHICN=$TR(Y,"-") ; Strip off any '-'
 ;
 ; - don't allow editing Part A date if more than one policy
 I IBPOLA,'$D(IBARR("A",1)) G MIIPB
 S DIR("A")="HOSPITAL INSURANCE (PART A) EFFECTIVE DATE"
 S IBX=$P($G(IBARR("A",1)),"^",9)
 I $G(IBAEFF) S Y=IBAEFF D D^DIQ S DIR("B")=Y
 I IBX'="",'$D(DIR("B")) S Y=IBX D D^DIQ S DIR("B")=Y
 S DIR(0)="DO^::E"
 S DIR("?")="Enter PART A Effective Date if shown on Medicare Insurance Card."
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) K DUOUT,DTOUT,DIROUT,DIRUT S IBQUIT=1 G MIIQ
 S IBAEFF=Y
 ;
MIIPB ; - don't allow editing Part B date if more than one policy
 I IBPOLB,'$D(IBARR("B",1)) G MIIC
 S DIR("A")="MEDICAL INSURANCE (PART B) EFFECTIVE DATE"
 S IBX=$P($G(IBARR("B",1)),"^",9)
 I $G(IBBEFF) S Y=IBBEFF D D^DIQ S DIR("B")=Y
 I IBX'="",'$D(DIR("B")) S Y=IBX D D^DIQ S DIR("B")=Y
 S DIR(0)="DO^::E"
 S DIR("?")="Enter PART B Effective Date if shown on Medicare Insurance Card."
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) K DUOUT,DTOUT,DIROUT,DIRUT S IBQUIT=1 G MIIQ
 S IBBEFF=Y
 ;
MIIC ; - check effective dates before COB prompt
 I '$G(IBAEFF),'$G(IBBEFF) S IBQUIT=1 D  G MIIQ
 .W !!,*7,?5,"No data can be filed without Part A or B Effective Dates."
 ;
 ; - Coordination of Benefits prompt
 S DIR("A")="COORDINATION OF BENEFITS: "
 S IBX=$P($G(IBARR("A",1)),"^",21) I 'IBX S IBX=$P($G(IBARR("B",1)),"^",21)
 I IBX S IBX=$S(IBX=1:"PRIMARY",IBX=2:"SECONDARY",3:"TERTIARY",1:"")
 S DIR("B")=$S($G(IBCOB)'="":IBCOB,IBX'="":IBX,1:"PRIMARY")
 S DIR(0)="SA^1:PRIMARY;2:SECONDARY;3:TERTIARY"
 S DIR("?")="Enter the Coordination of Benefits as Primary, Secondary, or Tertiary."
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) K DUOUT,DTOUT,DIROUT,DIRUT S IBQUIT=1 G MIIQ
 S IBCOBI=Y,IBCOB=$S(Y=3:"TERTIARY",Y=2:"SECONDARY",1:"PRIMARY")
 ;
 ; -- Ask if Data Okay
 S IBOK=0 K DIR D OK^IBCNSMM1 I IBOK=0 K DIR,Y G MIIA
 I IBOK["^" S IBQUIT=1
MIIQ Q
 ;
 ;
HICH ; Help text for the HIC number prompt.
 W !,"Enter the Medicare Claim Number (Subscriber ID) exactly as it appears"
 W !,"on the Medicare Insurance Card, including ALL characters.  Valid HICN "
 W !,"formats are:  1-3 alpha characters followed by 6 or 9 digits, or "
 W !,"9 digits followed by 1 alpha character optionally followed by another "
 W !,"alpha character or 1 digit."
 Q
