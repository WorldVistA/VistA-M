IBCREE2 ;ALB/ARH - RATES: CM ENTER/EDIT (SG,RL,PD,DV) ; 10-OCT-1998
 ;;2.0;INTEGRATED BILLING;**106,138,148**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EDITSG ; enter/edit special groups (363.32)
 N DIC,DIE,DA,DR,X,Y,DINUM,DLAYGO,IBX,IBSGFN
 W !!,"Enter/Edit a Special Group: ",!
 ;
 S DINUM=$O(^IBE(363.32,"A"),-1),DINUM=$S(DINUM<1000:1001,1:DINUM+1) I 'DINUM!($D(^IBE(363.32,DINUM,0))) Q
 S DLAYGO=363.32,DIC="^IBE(363.32,",DIC(0)="AELNQ" D ^DIC K DIC,DINUM,DLAYGO I Y<1 K X,Y Q
 ;
 S IBSGFN=+Y
 ;
 S DR=".01;.02;11",DIE("NO^")="BACK"
 ;
 S IBX=$$CHKSG^IBCREU1(+Y) I +IBX S DR="11" W ! D  W !!
 . I +$P(IBX,U,2) W !,"This was exported Nationally, only the assigned Billing Rates may be edited."
 . I +$P(IBX,U,3) W !,"This group has associated Revenue Code Links, can not edit Type."
 . I +$P(IBX,U,4) W !,"This group has associated Provider Discount Links, can not edit Type."
 . I '$P(IBX,U,2) S DR=".01;"_DR
 ;
 S DIDEL=363.32,DIE="^IBE(363.32,",DA=+IBSGFN D ^DIE K DIE,DA,DR,X,Y,DIDEL
 Q
 ;
EDITRL ; enter/edit revenue code links (363.33)
 N DIC,DIE,DA,DR,X,Y,DINUM,DLAYGO,IBX,IBRLFN
 W !!,"Enter/Edit a Revenue Code Link: " I +$G(IBSGFN) W " (for "_$P(IBSGFN,U,2)_" group)",!
 ;
 I '$G(IBSGFN) N IBSGFN S IBSGFN=$$GETSG^IBCRU1(1) Q:IBSGFN'>0  W !!
 ;
 I IBSGFN<1000 W !,"This is a Nationally exported set of revenue code links.",!,"This should be modified only if the revenue code links added or changed",!,"fit the specific group definition: ",$P(IBSGFN,U,2),".",!!
 ;
 S DIC("S")="I $P(^(0),U,2)="_+IBSGFN,DIC("DR")=".02////"_+IBSGFN,DIC("A")="Select REVENUE CODE: "
 S DLAYGO=363.33,DIC="^IBE(363.33,",DIC(0)="AELNQ" D ^DIC K DIC,DINUM,DLAYGO I Y<1 K X,Y Q
 ;
 S IBRLFN=+Y
 ;
 S DR=".01;.03;.04"
 S DIDEL=363.33,DIE="^IBE(363.33,",DA=+IBRLFN D ^DIE K DIE,DA,DR,X,Y,DIDEL
 ;
 S IBX=$G(^IBE(363.33,+IBRLFN,0)) S IBCPT=$P(IBX,U,3) ; reset cpt being displayed
 Q
 ;
EDITPD ; enter/edit provider discount (363.34)
 N DIC,DIE,DA,DR,X,Y,DINUM,DLAYGO,IBX,IBPDFN
 W !!,"Enter/Edit Provider Discount: " I +$G(IBSGFN) W " (for "_$P(IBSGFN,U,2)_" group)",!
 ;
 I '$G(IBSGFN) S IBSGFN=$$GETSG^IBCRU1(2) Q:IBSGFN'>0
 ;
 I IBSGFN<1000 W !!,"This is a Nationally exported set of Provider Discounts.",!,"This should be modified only if the provider discount added or changed",!,"fits the specific group definition: ",$P(IBSGFN,U,2),".",!!
 ;
 S DIC("S")="I $P(^(0),U,2)="_+IBSGFN,DIC("DR")=".02////"_+IBSGFN
 S DLAYGO=363.34,DIC="^IBE(363.34,",DIC(0)="AELNQ" D ^DIC K DIC,DINUM,DLAYGO I Y<1 K X,Y Q
 ;
 S IBPDFN=+Y I $D(IBPDFNX) S IBPDFNX=+Y
 ;
 S DR=".01;.03;11"
 S DIDEL=363.34,DIE="^IBE(363.34,",DA=+IBPDFN D ^DIE K DIE,DA,DR,X,Y,DIDEL
 Q
 ;
RESETDV(NAME) ; Reset Division numbers in both Charge Sets and Billing Regions (input CS or RG name)
 ; not all division numbers were known when the Reasonable Charges files were released,
 ; if the division number was not known then nnnXn or 9nnnn was used as a place holder in CS and RG names
 ; this option allows the user to change these fake division numbers to the correct division number, when known
 ;
 N IBDIV,IBNDIV,IBFN,IBNM,IBNEW,IBI,IBX,DIC,DIE,DIR,DA,DR,DIRUT,DUOUT,DTOUT,X,Y,IBNDIVN,IBCT,IBST S IBNEW=""
 Q:$G(NAME)=""  I $E(NAME,1,3)'="RC ",$E(NAME,1,3)'="RC-" Q
 ;
 S IBDIV="" F IBI=1:1 S IBX=$P(NAME," ",IBI) Q:IBX=""  I (IBX?3N1"X"1.3N)!(IBX>899.9) S IBDIV=IBX Q
 I IBDIV=""!(IBDIV=999) Q
 ;
 W !!,">>> "_IBDIV," is an invalid site number.",!
 S DIR("?")=IBDIV_" is not a valid site number, if you know the correct number for this division you may change it now for all Billing Region and Charge Set names."
RESET1 S DIR(0)="FO^3:7^I X'?3N,X'?3N1.4UN,'$O(^DG(40.8,""C"",X,0)) K X",DIR("A")="Enter the correct Division number for this site if available" D ^DIR Q:$D(DIRUT)  I Y="" Q
 ;
 S IBNDIV=Y,IBNDIVN=$O(^DG(40.8,"C",IBNDIV,0))
 I 'IBNDIVN W !!,?5,IBNDIV," is not a valid Medical Center division on your system.",!!
 ;
 S IBI="RC "_IBNDIV,IBX=$O(^IBE(363.31,"B",IBI)) I IBI=$P(IBX," ",1,2) W !!,IBX," already exists.",! G RESET1
 S IBI="RC-PHYSICIAN "_IBNDIV,IBX=$O(^IBE(363.1,"B",IBI,0)) I +IBX W !!,IBI," already exists.",! G RESET1
 ;
 S DIR(0)="YO",DIR("A")="Replace "_IBDIV_" with "_IBNDIV D ^DIR K DIR Q:$D(DIRUT)  I Y'=1 Q
 ;
 ; change Billing Region Names
 S IBFN=0 F  S IBFN=$O(^IBE(363.31,IBFN)) Q:'IBFN  D
 . S IBNM=$P($G(^IBE(363.31,IBFN,0)),U,1) I IBNM'[IBDIV Q
 . I ($E(IBNM,1,3)'="RC ")!($P(IBNM," ",2)'=IBDIV) Q
 . ;
 . S IBNEW=$P(IBNM,IBDIV,1)_IBNDIV_$P(IBNM,IBDIV,2)
 . ;
 . S DIE="^IBE(363.31,",DA=+IBFN,DR=".01///"_$E(IBNEW,1,30) D ^DIE K DIE,DR,X,Y
 . ;
 . ; check location of Billing Region, allow it to be updated if it does not appear to be standard
 . I $P($P(IBNEW," - ",2),", ",2)'?2U D
 .. W !!,">>> New Billing Region Name: ",IBNEW
 .. W !,">>> The Billing Region location is not in the standard 'CITY, ST' format."
 .. W !,">>> If you know the correct City, State for this division you may change it now.",!
 .. S DIR(0)="PO^5:AEQMZ",DIR("A")="Enter the STATE where the Division is located"
 .. D ^DIR Q:$D(DIRUT)  S IBST=$P(Y(0),U,2)
 .. S DIR(0)="FO^1:"_(30-$L($P(IBNEW," - ",1))-7),DIR("A")="Enter the CITY where the Division is located"
 .. D ^DIR Q:$D(DIRUT)  S IBCT=$$UP^XLFSTR(Y)
 .. S IBNEW=$P(IBNEW," - ",1)_" - "_IBCT_", "_IBST W !!,IBNM," replaced with ",IBNEW
 .. S DIE="^IBE(363.31,",DA=+IBFN,DR=".01///"_$E(IBNEW,1,30) D ^DIE K DIE,DR,X,Y
 . ;
 . ; add division to Billing Region, if not already there
 . I +IBNDIVN,'$O(^IBE(363.31,+IBFN,11,"B",IBNDIVN,0)) D
 .. S DLAYGO=363.31,DA(1)=+IBFN,DIC="^IBE(363.31,"_DA(1)_",11,",DIC(0)="L",X=+IBNDIVN,DIC("P")="363.3111P" D ^DIC K DIC,DIE,DLAYGO
 ;
 ; change Charge Set Names
 S IBFN=0 F  S IBFN=$O(^IBE(363.1,IBFN)) Q:'IBFN  Q:IBFN'<1000  D
 . S IBNM=$P($G(^IBE(363.1,IBFN,0)),U,1) I IBNM'[IBDIV Q
 . I ($E(IBNM,1,3)'="RC-")!($E(IBNM,($L(IBNM)-$L(IBDIV)+1),999)'=IBDIV) Q
 . ;
 . S IBNEW=$P(IBNM,IBDIV,1)_IBNDIV_$P(IBNM,IBDIV,2)
 . ;
 . S DIE="^IBE(363.1,",DA=+IBFN,DR=".01///"_$E(IBNEW,1,30) D ^DIE K DIE,DR,X,Y
 ;
 W " ... Done.",!
 Q
