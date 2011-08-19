IBCNRPM1 ;DAOU/CMW - Match Multiple Group Plans to a Pharmacy Plan ;10-MAR-2004
 ;;2.0;INTEGRATED BILLING;**251**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This program selects a plan and displays the 
 ;  Test Payer Sheets associated to the Plan.
 ;
EN ;  Select a plan
 NEW DA,DIC,DIE,DR,D,Y
 S DIC="^IBCNR(366.03,",DIC(0)="ABEMZ",DIC("A")="Select PHARMACY PLAN: "
 D ^DIC I X="^" G EXIT
 K DIC("A")
 I +Y<1 S D="F",DIC="^IBCNR(366.03,",DIC(0)="AEMNZ" D IX^DIC
 I +Y<1 G EXIT
 S IBCNRP=+Y
 ;
INS ;  Select an insurance company
 NEW DA,DIC,DIE,DR,D,Y,IBIND,IBMULT,IBW
 S (IBIND,IBMULT,IBW)=1
 S DIR(0)="350.9,4.06"
 S DIR("A")="Select INSURANCE COMPANY",DIR("??")="^D ADH^IBCNSM3"
 S DIR("?")="Select the Insurance Company for the plan you are entering"
 D ^DIR K DIR S IBCNRI=+Y I Y<1 G EN
 I $P($G(^DIC(36,+IBCNRI,0)),"^",2)="N" W !,"This company does not reimburse.  " G INS
 I $P($G(^DIC(36,+IBCNRI,0)),"^",5) W !,*7,"Warning: Inactive Company" G INS
 ;
 D GIPF
 I '$D(^TMP("IBCNR",$J,"GP")) D  G INS
 . W !,*7,"** No active Group Plans with Pharmacy coverage found for this Insurance Co."
 ;
 D EN^IBCNRPM2(IBCNRP,IBCNRI,.IBCNRGP)
 ;
 G INS
 ;
GIPF ;  screen for valid GIPF
 ;
 N GST1,GP0,GP6,IBCOV,LIM,IBCVRD
 N GPIEN,GPNAM,GPNUM
 S GST1=1,GPIEN=""
 K ^TMP("IBCNR",$J,"GP")
 F  S GPIEN=$O(^IBA(355.3,"B",IBCNRI,GPIEN)) Q:GPIEN=""  D
 . ;chk for active group
 . S GP0=$G(^IBA(355.3,GPIEN,0)),GP6=$G(^IBA(355.3,GPIEN,6))
 . I $P(GP0,U,11)=1 Q
 . ;chk for pharm plan coverage
 . S IBCOV=$O(^IBE(355.31,"B","PHARMACY",""))
 . S LIM="",IBCVRD=0
 . F  S LIM=$O(^IBA(355.32,"B",GPIEN,LIM)) Q:LIM=""  D
 .. I $P(^IBA(355.32,LIM,0),U,2)=IBCOV D
 ... ;chk covered status
 ... S IBCVRD=$P(^IBA(355.32,LIM,0),U,4)
 ... I IBCVRD=0 Q
 ... S GPNAM=$P($G(GP0),U,3),GPNUM=$P($G(GP0),U,4)
 ... I $G(GPNAM)="" S GPNAM="<blank>"
 ... I $G(GPNUM)="" S GPNUM="<blank>"
 ... ;set array = pharm plan and plan type
 ... S ^TMP("IBCNR",$J,"GP",GPNAM,GPNUM,GPIEN)=$P($G(GP6),U)_"^"_$P($G(GP0),U,9)
 Q
 ;
EXIT K IBCNRP,IBCNRI,IBCNRGP
 K ^TMP("IBCNR",$J)
 ;
 Q
