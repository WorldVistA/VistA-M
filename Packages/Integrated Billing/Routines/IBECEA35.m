IBECEA35 ;ALB/CPM - Cancel/Edit/Add... TRICARE Support ; 09-AUG-96
 ;;2.0;INTEGRATED BILLING;**52,240,361**;21-MAR-94;Build 9
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
CUS ; Process all TRICARE copayment charges.
 ;
 N X,IBCS,IBINS,IBPLAN
 ;
 ; - display TRICARE coverage
 S IBCS=$$CUS^IBACUS(DFN,DT)
 D DISP(DFN,IBCS)
 ;
 ; - collect parameters needed to create the charge
 S IBATYPN=$G(^IBE(350.1,IBATYP,0)),IBUNIT=1
 I IBATYPN["RX" D AMT^IBECEAU2 S IBDESC="TRICARE RX COPAY",IBFR=DT G GO
 I IBATYPN["OPT" D  G GO
 .S IBLIM=DT D FR^IBECEAU2(0),AMT^IBECEAU2:IBY>0
 .S IBDESC="TRICARE OPT COPAY",(IBEVDT,IBTO)=IBFR,IBEVDA="*"
 I IBATYPN["INPT" D  G GO
 .S IBDG=$$ADSEL^IBECEA31(DFN),IBDESC="TRICARE INPT COPAY"
 .I IBDG>0 D  Q
 ..D AMT^IBECEAU2 Q:IBY'>0
 ..S IBSL="405:"_+IBDG,(IBEVDT,IBFR)=$P(IBDG,"^",2),IBEVDA="*"
 ..S IBTO=$$DIS^IBECEA31(IBSL),IBTO=$S(IBTO>DT:DT,1:IBTO)
 .W !!,"An admission was not available or not selected."
 .W !,"This transaction has been cancelled." S IBY=-1 Q
 .;
 .; - if I pursue this further...
 .S DIR(0)="Y",DIR("A")="Do you still wish to create an inpatient copayment charge"
 .S DIR("?")="Enter 'Y' or 'YES' to create a charge, or 'N', 'NO', or '^' to quit."
 .D ^DIR K DIR I 'Y!($D(DIRUT))!($D(DUOUT)) W !,"This transaction has been cancelled." S IBY=-1 Q
 ;
 ;
GO ; - bill the charge
 I IBY<0 G CUSQ
 ;
 ; - okay to proceed?
 D PROC^IBECEAU4("add") I IBY<0 G CUSQ
 ;
 ; - create charge and pass to AR
 W !,"Billing the TRICARE patient copayment charge..."
 D ADD^IBECEAU3,AR^IBR:IBY>0 I IBY<0 G CUSQ
 ;
 S IBCOMMIT=1 W "completed."
 ;
CUSQ K IBCS
 Q
 ;
 ;
DISP(DFN,INS) ; Display TRICARE beneficiary insurance information.
 ;  Input:    DFN  --  Pointer to the patient in file #2
 ;            INS  --  Pointer to the patient policy in file #2.312
 ;
 I '$G(INS) W *7,!!,"Please note that this patient does not have active TRICARE coverage!",! G DISPQ
 ;
 N IBINS,IBINS3,IBPLAN,IBS S IBS=0
 S IBINS=$G(^DPT(DFN,.312,INS,0)),IBINS3=$G(^(3))
 S IBPLAN=$G(^IBA(355.3,+$P(IBINS,"^",18),0))
 W !!," TRICARE coverage for ",$P($G(^DPT(DFN,0)),"^"),":"
 W !!," Insured Person: ",$E($P(IBINS,"^",17),1,20)
 W ?42,"Company: ",$P($G(^DIC(36,+IBINS,0)),"^")
 W !," Effective Date: ",$$DAT1^IBOUTL($P(IBINS,"^",8))
 W ?40,"Plan Name: ",$P(IBPLAN,"^",3)
 W !,"Expiration Date: ",$$DAT1^IBOUTL($P(IBINS,"^",4))
 W ?38,"Plan Number: ",$P(IBPLAN,"^",4),!
 I $P(IBINS3,"^",2)]"" S IBS=1 W " Service Branch: ",$P($G(^DIC(23,+$P(IBINS3,"^",2),0)),"^")
 I $P(IBINS3,"^",3)]"" S IBS=1 W ?37,"Service Rank: ",$P(IBINS3,"^",3)
 W:IBS !
DISPQ Q
