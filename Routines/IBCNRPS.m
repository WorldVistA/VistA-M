IBCNRPS ;DAOU/CMW - Match Test Payer Sheet to a Pharmacy Plan ;10-DEC-2003
 ;;2.0;INTEGRATED BILLING;**251**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This program selects a plan and displays the test payer sheets
 ;  associated with a Plan.
 ;
EN ;  Select a plan
 N DIC,D,Y,DTOUT,DUOUT,IBCNSP
 S DIC="^IBCNR(366.03,",DIC(0)="AEMZ" D ^DIC
 I $G(DTOUT)!$G(DUOUT) Q
 I +Y<1 S D="F",DIC="^IBCNR(366.03,",DIC(0)="AEZ" D IX^DIC
 I +Y<1 Q
 S IBCNSP=+Y
 ;
 D EN^IBCNRPSM(IBCNSP)
 ;
 K IBCNSP
 Q
